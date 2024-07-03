Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5CBC30658
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 01:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOpEb-0004bB-0M; Tue, 02 Jul 2024 21:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sOpEU-0004RI-29
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 21:56:30 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sOpER-0000vB-PY
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 21:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1719971787; x=1751507787;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nHKxdfcJndi7lyJ8xodcfjRvhOSHuSrjrU6zBGzVSp4=;
 b=CLoNVYpBxOeGk4gLtDFFINM+ujFUykDiFsl9XtT0dZ1AmjB2xi1OarT+
 cxzX74T2a7F9i3cIVyw/tZm7N2KTCDS6pyd68t5iqzlEsBK5SP7631lnE
 cgu0xUjVLfZg+aucjHPedHnA3uDv52fiJQgGRQpfgs3sAJkrdw657gT6+
 rA46TOnDmoxTxnk4me4A28J2WnZGbUoYZ7FrDkKH5kgJ573ywdMn0JraD
 bqmuU3WQtgPiU3lay/Nr+1yXj5p3kRmi06Ciy1/p+6KojY6z+iNJzjAXm
 uKT8xBtzUumPqsgntTKs8vhIgrYUo9XBegDOo7H1OLRkrLDffIu/CEZFT Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="37059807"
X-IronPort-AV: E=Sophos;i="6.09,180,1716217200"; d="scan'208";a="37059807"
Received: from mail-japanwestazlp17010007.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.7])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2024 10:56:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgO6TdAowM1NUWmAINGsMOkD+qDsifLVQVl4PoS3YvMsfUWO5noJfgfVPlKYpKwQVae6/Joso9ZcZncU4bFxTcg5fvTbe3DzEFTZw6dBLmxPcrGacNCaiuxMu/JkZvfKF7CZMrD0AjIw2e8l88Ph4u36XSdG77D7PNxbPE9XTw79U3aPzp/RG9V88+99Smj8H4zugcV21k1dO9oo1mZpbZy2CfqB/WO9h1ob5oeRTY5UjinaMJeg4ZUY7rAvCbx7Q0pkT6hh8y0cZxGNPMf5L28jw9nF4kYoNVvTjToNp2Zy7QLvbK7MrK7gBK9nD7rgt6G7ZzNmRz+JZJvNZX/Wkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHKxdfcJndi7lyJ8xodcfjRvhOSHuSrjrU6zBGzVSp4=;
 b=ILWDaiJ3xSXiAJ53XpauVzQEA9PspF/YzMzQ4pySTKgFW0xK0xLmtgVVsUrxcYaze4f15ll+1AVL+U5s37tVqfbxhmiaamdGoUg6YW91l3lJci3XO23Wpn0akj17eXS16zTlon3NPDTXANn3cag2iJa0HJNBMtAEVXBdnbkGR6tJpRg9Aze5LO0FaWMFmacV+LQdZ0DxkHBkcfcK1LQu4/KycwIRF0Y8D3KLdMu761+F4OVE0HDrh0lBKIE8f33igCuv9wly0IDgfqYMBNhxZBvtSMBW3dl4mb7K6scnCmsTAdhMc4WuHURE7JT/EqnWGjOk40ZliHj04xyzUP0VuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYWPR01MB10726.jpnprd01.prod.outlook.com (2603:1096:400:2a6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Wed, 3 Jul
 2024 01:56:18 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%6]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 01:56:18 +0000
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH v4 6/7] tests/plugin/mem: add option to print memory
 accesses
Thread-Topic: [PATCH v4 6/7] tests/plugin/mem: add option to print memory
 accesses
Thread-Index: AQHazLA8x0hoAFMFikGL4SM7P+FAwbHkO1CQ
Date: Wed, 3 Jul 2024 01:56:17 +0000
Message-ID: <OSZPR01MB6453256AC74D96DB511BA3358DDD2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
 <20240702184448.551705-7-pierrick.bouvier@linaro.org>
In-Reply-To: <20240702184448.551705-7-pierrick.bouvier@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9YjEyNGVmMDctZjBlZi00MDFhLWI3Y2MtZWE4YzU0ZDVi?=
 =?utf-8?B?ZTdmO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA3LTAzVDAxOjU1OjU5WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYWPR01MB10726:EE_
x-ms-office365-filtering-correlation-id: 639383e6-df95-4c10-13ff-08dc9b03543a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?OE9tdkpBUE1UOHROWDlzVUkzeG9BMmVuZE1yTS9UQ1ZkMmhnWjhkRGIxelh1?=
 =?utf-8?B?STIvYjNPMnhDVTllam5VUUJ4MkZaanhlUDlpWUowemFFK2RwY3lIUVd4ZWFY?=
 =?utf-8?B?eXJ0aXBxM0hxNXF1Qll1Wko5dzhYeDR1RWlkb3p6U0FZdmtUUkFrNFcyY21z?=
 =?utf-8?B?QkVFZnZzakk2WWdzRmxKMXlPcVdJWXdUT1ZPc3duaTdXZ29HUkNvejNFMlhm?=
 =?utf-8?B?SVZOVnc2dmM1eTZmeXYweW10dkdNMnlOaGoxTGU4MFBhdGJFT2xMditHQThF?=
 =?utf-8?B?dzNFa0ovT0E2Z1lDak8xNEV3S2ZkcVFUaEhoNHdSdWh2QUJuc202RlNnb2ZS?=
 =?utf-8?B?NW1VakVha2YyK1ZNMEFpOVozdWlOcGh0WmpYSFRRQ1VpTjFiRHZUSmNGcGNs?=
 =?utf-8?B?cStWUWdZQkJ5N0hxMXR1L2x3WktrMEp1bnl0b05FL0xpWG14Vms3MHRIZXgw?=
 =?utf-8?B?NTc3TmVkUm1iS2txNDl6SGIwREgzUENlUEJyYlpKVzNTMmdnN3NNUmJNN0lP?=
 =?utf-8?B?dTZDVTJTc0hWL3NXY2owQk52MDhqY2pUSElHR3J3dnViSXNyTXZuNzYyb2NG?=
 =?utf-8?B?TGdSV0wwdzBMUkVRQzZ0bWVLRkFvUExkV29HbjhwYTdVM3F4SndPRkZhWEJm?=
 =?utf-8?B?L0lXQzZGSDAxMmlPelkrQURCQXc4NG16TTJuMTd0TGE0VUgzbDJaaEtPZnRD?=
 =?utf-8?B?VjlONVUzV1lPaHJBeUU2K3Y0KzZsNHo1YUY1TitBbUtIQzRmL2hWV0FSb3Jr?=
 =?utf-8?B?NEM2UG1nd3JDWnArM3d0bGx6M2ZuUDRxa0x1c3hLbldpZDNrT00yT01abDRw?=
 =?utf-8?B?ZUpkSzJSTEhLWExuaExHUllSRjJPaHMxTG9TcmU0UWpDRWUxaDFJSzg2SWxI?=
 =?utf-8?B?eVhPOXhiTDc0RlpsdFhqbVJTcXMwbDRjbzYrZ2VBUWU2VnAzZk1kRFdHZUlU?=
 =?utf-8?B?aUJLNmN0Tk0rMmd4VGlGMWMyWllFeTRqTTFvTkY1Y0ViMGU3d0xwQnZwYzUw?=
 =?utf-8?B?aWpXU3BrYW9Fc3RuWURrY2RZbHRkNXdXUnlhb0VnQmVuMlR0NTBBanF5eHFW?=
 =?utf-8?B?UExmVFhhbDNSWDdYc1grcFhPT0VsaUdVZUVJLzJIMVlBU0dIb1ZZQnVDSU1x?=
 =?utf-8?B?VVF6dldETXFCYVNxSnljMUp2Q0JreTlsVUZmbDlxajY3bkRpRWNnMVV3Zlg5?=
 =?utf-8?B?dVE0SUtlRUJwbGplNmNXYlVjNVBDMmVaKzE4eFl4TTBZc05lcmxWaFQ1RDRH?=
 =?utf-8?B?YkJ0UzRxeWlFQ1BYMjRwV2JndnJEckJ6d2xmVll4Uml5clRQUi9nN0QvNG4y?=
 =?utf-8?B?dk9qWGxhemg0K1JZSElWK2lETi9GNkhhd3dCV0dVcXV5dTlxUCtvVHZ0blFP?=
 =?utf-8?B?cnJOLzkvNXFjbElGdDZoTitGLzNQUkxRZ21IOGZDV2c4NnM3N3RnNmNjb3Nj?=
 =?utf-8?B?eGlpL2ExaEpEMENQUmN6aWJFSVkvTEtHK0FPTHEwb0lyRS83ZTUwMFBwaEV5?=
 =?utf-8?B?eGVLeDNNM01YNzd2eGFYbkpNbFVZcURrSnlEN3I4UzZ4emJNU1EvZXptUVhI?=
 =?utf-8?B?b3BTMWR6ZnQyckFXaWxxZHlNVjNXSWxyUDRad0YvbXRFZ3U1Z0VSSHRmaTJo?=
 =?utf-8?B?NlZmUTdWdG0wZWgwZGtVSzRSYm40U3pzYmJIKzI0SDd3Y2VEWkMvL0JYUG9V?=
 =?utf-8?B?UGd5UjlGd3FGNFVGd21haEdkSThWTDhsaXRUQlQ3aUpZTm9BZ1RaUVNnU01t?=
 =?utf-8?B?dWdtVVZZVUdHTEs2QW40bzhOdjVzaGxrR09LcHBhTzBIeUpZaTRKK29jdDNl?=
 =?utf-8?B?R3F3WUdTZ0N5T2QrR1pPTzdTM2FPN3o5V0YzN2hZL0lkODRydHcwRGVWRHVy?=
 =?utf-8?B?Y0lGQnRxeldoQ2V2MFUwbERXVlBzSkxJQno0bytkMXZjeGNjVkpiMVNrMUpr?=
 =?utf-8?Q?kU/4upaCXJ4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2RuNXhTcm9VWTh5MHNyNGwzM3dlT1A2UjljZ3crOG9wR1lUOWFiY1BiOGla?=
 =?utf-8?B?Z3daVWtKN1E2YVdPeE9qSWtHTm5kY3o2QzdpR0hzTWhnaTEwaEtML2o0eVpq?=
 =?utf-8?B?Tlo1VHZGY2lGdngrVEpYWVdjTllRLy9UNkU4ZjdvMHd6M0dhRmtNMG5SUEd2?=
 =?utf-8?B?emJ4aS9ZT1lJYVQ1OVl3RCtKK3FCMkVzMWRBQXpsRjJqVERIZWpOdlJoQmhX?=
 =?utf-8?B?aFM2YjdkeGI3a0RDS0tWWXlqQ1hkcUtvZytRc2lkREkxcmdBTXEzUGJhZ0Zj?=
 =?utf-8?B?VEJGZDRPZjI4NmZVV0tQcEwxc29RVXpZYlpnYU13MVMxWDlpbjMwNmJ6dUdw?=
 =?utf-8?B?TVE4WUF5QjVUNDh0dldxc0owcElhWVp4UTRXN25MTmk5b0U3Y3BjOHBXN2hM?=
 =?utf-8?B?Mys1WGEzN2pURXdFdDNUclR3QUxGRy85QXEzemVwa2hzaFNpMitTb2dsejlp?=
 =?utf-8?B?a0JhUG5nem1nL05kMHo5cVVBZkRkK2ZMOFZ1WTZiOS9rU2RKcUc5WUoxNlFl?=
 =?utf-8?B?WTFqWWFwMGhvNzFVSmk4SEQ3b3RoQWNGemsrWVBhczM4WUNvN1hPcCtRNWtG?=
 =?utf-8?B?MnVDSXlWdUc5Nkt2VjdLNmNCb1ErT3NrWHNadHV1NEFQSlRhS21DUStrUjhZ?=
 =?utf-8?B?ZjdaL015YlovUStIbFFFZ0YxSVlxV0oyc0JGa1Q2Uk1NV0ZFUHJXaFVxaURt?=
 =?utf-8?B?WGoxczFYelVDSlFnUHNJMEgvYUJLcjZ1bWMvY1NDOW1SS2RVaXlMVDN0TlR5?=
 =?utf-8?B?c2ZnUVFINjlVUm55NUV5YmRjWlF5YmxmbG5uUVZzVVNXaVNlOU00Nncxbllt?=
 =?utf-8?B?UXNtVTJldFNWeHh0ZEgzZSsrRTkyNGROTmdkYXhSb00yeFlJdHpXczZNWXdZ?=
 =?utf-8?B?alNJd3JDYjZWUEs1MnJFYUpxNFlHeW4yOUxBZk1oeEVaMW56RStMYnFCTkFp?=
 =?utf-8?B?VVZ6ZmkzWERxT3JtU2E5NmZVYmsvSC9wV0tPVXhYc3VqcjRlaGVydlpiNmJn?=
 =?utf-8?B?d1BEU0s2d1REQ216aXgvdmY4dXZ0N3h2dkowVmpqVVNVdnRUOFVsNUM2eXkw?=
 =?utf-8?B?RzlwaUJuVWg5WE9tZkFSUFllSjd1L3FaU3NFSVByYWdIdFRldWY3M3RacGl3?=
 =?utf-8?B?SGlqY2I0QjVIcllVMnFvQ084OTExbENvZUkySjVtMmRUMDFBT0gwZ3NtU2VW?=
 =?utf-8?B?ZGE1eldaV2FOMDhRV0pqcmt5ODBDT3JvRm91UUdvU0Y4ZHNZR0pNNEdzd2ZX?=
 =?utf-8?B?aWtSbmJUMWFkbG5HblVYOWlWRnUzM1ZQK0V2MTVsTUNUWFFiQlJySXRRZk82?=
 =?utf-8?B?b2Z3d1hyeTBXUFl2dFJmNU0vQTBRcm1tdXh1c2hTYVQwdzhjeEhKZmRNMmNX?=
 =?utf-8?B?YXdaZ1hoaUFRWmRNWVdKSGFEdEcyTUU3L2FDc0hKajdIZUN0Wkp1bXZmVWJY?=
 =?utf-8?B?Y2k2K1BZZTVyZjNpWlprSEVGVWViSVFuWE5jVEdmNXNyNTdZS2lsTUozYXJT?=
 =?utf-8?B?UHIwcXc0d1VCejkxNmY0a21zZGYrS0dBRVJSZ015VnRWUWdORjlGT2RkRS9h?=
 =?utf-8?B?Y0JRY242U2FKQVdxWVhPbUtQbGJqUmRlMTBybHFyWjFFVDg3bnNHWkFuakNX?=
 =?utf-8?B?TkhvU3VKSUpCN1VFU3REUWhYL1pBSDhnS1lKeEo3OWtSWnBNS0NBK3dOYU8x?=
 =?utf-8?B?REhCb0VHZ0dma0ZWQlJXV3JFOERXaDR2ZkkrTUN4Z1RCeGVYOVVhd05NYTlV?=
 =?utf-8?B?c2RiZHArdmdkTGwyR2puQ1UxRkpILzZjSGJoK3BYOHBESEFOWHBYWXd2dGNI?=
 =?utf-8?B?K0tRMnp3NGxCTjBGNVBsWFJlSEVSaGVwRDhBS2lVb0dzMWR2SG9NdW1qWnZM?=
 =?utf-8?B?SVZvSUtSdGRSS0FhNG1iUUwvTy9QSTB0bnBwOVVXRWNjN3BQWUZ2WmRnc3Uz?=
 =?utf-8?B?dVI1SC8wUjBHOGYwWWI0YzY1RUR6b25qczh2MkhuN3VRUWcya3JqTVVhWmtw?=
 =?utf-8?B?NkZDdlN4clZtQUZ2K0YzVGFSdTB6KzZyWmNDcHJoRlNTN1QvMGV6YkF5Y3VG?=
 =?utf-8?B?aFNpWmc3RExTTjRwdlk2SEhuVWdmbVNlalFvQnlYWjRhQlVFaFN4OGtPNmZD?=
 =?utf-8?Q?+hHhAzGz/PWPot1n15Hp4M14N?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oBj1bJXT3W84Y1URwBOuEsAHS9DUsBw7njY1sEy0znqi1q3kN68NShk5kyBLReLD5D5RBnUDcWEooJeMZ9RtsVh1vyV8xdLdNzNvpvjQvjrP1SJXNRkkaLl6LkcCGnX9Ckmu8anR/kJTzo9RCSt6jCsiN6UDJtbRwVOS+i/jStFX90LL+J2cFhxBD4n20DstwLztllXZ5yMqoP+8UvzVTjxp2lRhe/CDn+N3zmAIaucUtSQrbgAObVxDKWG6GgjudsKMFpkC6d0PxwJk7d30NphB3U8wa1gum9Vbslr37OeKPGBD6LTo507lVMraHLmASKQsG50HdcRXlrV3hzuW84Fq2cHh/6xESFAoIARmKY/3uBLwXn9T5k+PtnUrmj1nImAHO6qbmSG0Z5+gJOw0eQkHdE52G3wE9LqHUptmIlsslZkXFf3n/lGclJIEHqVGIvIgAdvZszpW91Fkccg2KESZtH0Rnua6fKeU1HpfAVL4+YL5YJrPPVr6+HSwS7OL73u2Uq7y+vZm0wvmnmBQ0B+SjDRJ1JyBu3e6ZUBlM3Yp7bc7LCCZovyU7/TUm5F4SMtMWr6JzlRvwjQsOOMnj8ZvpYRfjRQNXhelhxdGcFLEFN3CJnfzNsKfCqYuwLsO
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639383e6-df95-4c10-13ff-08dc9b03543a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 01:56:17.9981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HI1VY9ArTYYj/ZxVERpjY2/oZEAtuLL4X1PsPsu1DnBjV0UU9Zf1+/w4PODZXD8CF2QCw1wzGqsz/YqEl5wYbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10726
Received-SPF: pass client-ip=68.232.151.214;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa4.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

VGVzdGVkLWJ5OiBYaW5ndGFvIFlhbyA8eWFveHQuZm5zdEBmdWppdHN1LmNvbT4NCg0Kb25lIHNt
YWxsIHN1Z2dlc3Rpb246DQpLZWVwaW5nIHRoZSBhZGRyZXNzZXMgb3IgdmFsdWVzIG9mIGZpeGVk
IHNpemUgaW4gb3V0cHV0IG1lc3NhZ2UgY2FuIGltcHJvdmUgdGhlIHJlYWRhYmlsaXR5IG9mIGxv
Z3MuDQpsaWtlOg0KPiArICAgIGNhc2UgUUVNVV9QTFVHSU5fTUVNX1ZBTFVFX1U4Og0KPiArICAg
ICAgICBnX3N0cmluZ19hcHBlbmRfcHJpbnRmKG91dCwgIjB4JSJQUkl4OCwgdmFsdWUuZGF0YS51
OCk7DQo+ICsgICAgICAgIGJyZWFrOw0KY2FzZSBRRU1VX1BMVUdJTl9NRU1fVkFMVUVfVTg6DQog
ICAgZ19zdHJpbmdfYXBwZW5kX3ByaW50ZihvdXQsICIweDAyJSJQUkl4OCwgdmFsdWUuZGF0YS51
OCk7DQogICAgYnJlYWs7DQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBxZW11LWRldmVsLWJvdW5jZXMreWFveHQuZm5zdD1mdWppdHN1LmNvbUBub25nbnUub3JnDQo+
IDxxZW11LWRldmVsLWJvdW5jZXMreWFveHQuZm5zdD1mdWppdHN1LmNvbUBub25nbnUub3JnPiBP
biBCZWhhbGYgT2YNCj4gUGllcnJpY2sgQm91dmllcg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkg
MywgMjAyNCAyOjQ1IEFNDQo+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IEFsZXgg
QmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz47IE1haG1vdWQgTWFuZG91cg0KPiA8bWEu
bWFuZG91cnJAZ21haWwuY29tPjsgUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBs
aW5hcm8ub3JnPjsNCj4gQWxleGFuZHJlIElvb3NzIDxlcmRuYXhlQGNyYW5zLm9yZz47IFBoaWxp
cHBlIE1hdGhpZXUtRGF1ZMOpDQo+IDxwaGlsbWRAbGluYXJvLm9yZz47IFBhb2xvIEJvbnppbmkg
PHBib256aW5pQHJlZGhhdC5jb20+OyBSaWNoYXJkIEhlbmRlcnNvbg0KPiA8cmljaGFyZC5oZW5k
ZXJzb25AbGluYXJvLm9yZz47IEVkdWFyZG8gSGFia29zdCA8ZWR1YXJkb0BoYWJrb3N0Lm5ldD4N
Cj4gU3ViamVjdDogW1BBVENIIHY0IDYvN10gdGVzdHMvcGx1Z2luL21lbTogYWRkIG9wdGlvbiB0
byBwcmludCBtZW1vcnkgYWNjZXNzZXMNCj4gDQo+IEJ5IHVzaW5nICJwcmludC1hY2Nlc3Nlcz10
cnVlIiBvcHRpb24sIG1lbSBwbHVnaW4gd2lsbCBub3cgcHJpbnQgZXZlcnkNCj4gdmFsdWUgYWNj
ZXNzZWQsIHdpdGggYXNzb2NpYXRlZCBzaXplLCB0eXBlIChzdG9yZSB2cyBsb2FkKSwgc3ltYm9s
LA0KPiBpbnN0cnVjdGlvbiBhZGRyZXNzIGFuZCBwaHlzL3ZpcnQgYWRkcmVzcyBhY2Nlc3NlZC4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJA
bGluYXJvLm9yZz4NCj4gLS0tDQo+ICB0ZXN0cy9wbHVnaW4vbWVtLmMgfCA2OQ0KPiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNjggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rl
c3RzL3BsdWdpbi9tZW0uYyBiL3Rlc3RzL3BsdWdpbi9tZW0uYw0KPiBpbmRleCBiNjUwZGRkY2Nl
MS4uYWVjYmFkOGU2OGQgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3BsdWdpbi9tZW0uYw0KPiArKysg
Yi90ZXN0cy9wbHVnaW4vbWVtLmMNCj4gQEAgLTIxLDEwICsyMSwxNSBAQCB0eXBlZGVmIHN0cnVj
dCB7DQo+ICAgICAgdWludDY0X3QgaW9fY291bnQ7DQo+ICB9IENQVUNvdW50Ow0KPiANCj4gK3R5
cGVkZWYgc3RydWN0IHsNCj4gKyAgICB1aW50NjRfdCB2YWRkcjsNCj4gKyAgICBjb25zdCBjaGFy
ICpzeW07DQo+ICt9IEluc25JbmZvOw0KPiArDQo+ICBzdGF0aWMgc3RydWN0IHFlbXVfcGx1Z2lu
X3Njb3JlYm9hcmQgKmNvdW50czsNCj4gIHN0YXRpYyBxZW11X3BsdWdpbl91NjQgbWVtX2NvdW50
Ow0KPiAgc3RhdGljIHFlbXVfcGx1Z2luX3U2NCBpb19jb3VudDsNCj4gLXN0YXRpYyBib29sIGRv
X2lubGluZSwgZG9fY2FsbGJhY2s7DQo+ICtzdGF0aWMgYm9vbCBkb19pbmxpbmUsIGRvX2NhbGxi
YWNrLCBkb19wcmludF9hY2Nlc3NlczsNCj4gIHN0YXRpYyBib29sIGRvX2hhZGRyOw0KPiAgc3Rh
dGljIGVudW0gcWVtdV9wbHVnaW5fbWVtX3J3IHJ3ID0gUUVNVV9QTFVHSU5fTUVNX1JXOw0KPiAN
Cj4gQEAgLTYwLDYgKzY1LDQ0IEBAIHN0YXRpYyB2b2lkIHZjcHVfbWVtKHVuc2lnbmVkIGludCBj
cHVfaW5kZXgsDQo+IHFlbXVfcGx1Z2luX21lbWluZm9fdCBtZW1pbmZvLA0KPiAgICAgIH0NCj4g
IH0NCj4gDQo+ICtzdGF0aWMgdm9pZCBwcmludF9hY2Nlc3ModW5zaWduZWQgaW50IGNwdV9pbmRl
eCwgcWVtdV9wbHVnaW5fbWVtaW5mb190DQo+IG1lbWluZm8sDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgdWludDY0X3QgdmFkZHIsIHZvaWQgKnVkYXRhKQ0KPiArew0KPiArICAgIEluc25J
bmZvICppbnNuX2luZm8gPSB1ZGF0YTsNCj4gKyAgICB1bnNpZ25lZCBzaXplID0gOCA8PCBxZW11
X3BsdWdpbl9tZW1fc2l6ZV9zaGlmdChtZW1pbmZvKTsNCj4gKyAgICBjb25zdCBjaGFyICp0eXBl
ID0gcWVtdV9wbHVnaW5fbWVtX2lzX3N0b3JlKG1lbWluZm8pID8gInN0b3JlIiA6ICJsb2FkIjsN
Cj4gKyAgICBxZW11X3BsdWdpbl9tZW1fdmFsdWUgdmFsdWUgPSBxZW11X3BsdWdpbl9tZW1fZ2V0
X3ZhbHVlKG1lbWluZm8pOw0KPiArICAgIHVpbnQ2NF90IGh3YWRkciA9DQo+ICsgICAgICAgIHFl
bXVfcGx1Z2luX2h3YWRkcl9waHlzX2FkZHIocWVtdV9wbHVnaW5fZ2V0X2h3YWRkcihtZW1pbmZv
LA0KPiB2YWRkcikpOw0KPiArICAgIGdfYXV0b3B0cihHU3RyaW5nKSBvdXQgPSBnX3N0cmluZ19u
ZXcoIiIpOw0KPiArICAgIGdfc3RyaW5nX3ByaW50ZihvdXQsDQo+ICsgICAgICAgICAgICAgICAg
ICAgICIweCUiUFJJeDY0IiwlcywweCUiUFJJeDY0IiwweCUiUFJJeDY0IiwlZCwlcywiLA0KPiAr
ICAgICAgICAgICAgICAgICAgICBpbnNuX2luZm8tPnZhZGRyLCBpbnNuX2luZm8tPnN5bSwNCj4g
KyAgICAgICAgICAgICAgICAgICAgdmFkZHIsIGh3YWRkciwgc2l6ZSwgdHlwZSk7DQo+ICsgICAg
c3dpdGNoICh2YWx1ZS50eXBlKSB7DQo+ICsgICAgY2FzZSBRRU1VX1BMVUdJTl9NRU1fVkFMVUVf
VTg6DQo+ICsgICAgICAgIGdfc3RyaW5nX2FwcGVuZF9wcmludGYob3V0LCAiMHglIlBSSXg4LCB2
YWx1ZS5kYXRhLnU4KTsNCj4gKyAgICAgICAgYnJlYWs7DQo+ICsgICAgY2FzZSBRRU1VX1BMVUdJ
Tl9NRU1fVkFMVUVfVTE2Og0KPiArICAgICAgICBnX3N0cmluZ19hcHBlbmRfcHJpbnRmKG91dCwg
IjB4JSJQUkl4MTYsIHZhbHVlLmRhdGEudTE2KTsNCj4gKyAgICAgICAgYnJlYWs7DQo+ICsgICAg
Y2FzZSBRRU1VX1BMVUdJTl9NRU1fVkFMVUVfVTMyOg0KPiArICAgICAgICBnX3N0cmluZ19hcHBl
bmRfcHJpbnRmKG91dCwgIjB4JSJQUkl4MzIsIHZhbHVlLmRhdGEudTMyKTsNCj4gKyAgICAgICAg
YnJlYWs7DQo+ICsgICAgY2FzZSBRRU1VX1BMVUdJTl9NRU1fVkFMVUVfVTY0Og0KPiArICAgICAg
ICBnX3N0cmluZ19hcHBlbmRfcHJpbnRmKG91dCwgIjB4JSJQUkl4NjQsIHZhbHVlLmRhdGEudTY0
KTsNCj4gKyAgICAgICAgYnJlYWs7DQo+ICsgICAgY2FzZSBRRU1VX1BMVUdJTl9NRU1fVkFMVUVf
VTEyODoNCj4gKyAgICAgICAgZ19zdHJpbmdfYXBwZW5kX3ByaW50ZihvdXQsICIweCUuMCJQUkl4
NjQiJSJQUkl4NjQsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmFsdWUuZGF0
YS51MTI4LmhpZ2gsIHZhbHVlLmRhdGEudTEyOC5sb3cpOw0KPiArICAgICAgICBicmVhazsNCj4g
KyAgICBkZWZhdWx0Og0KPiArICAgICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOw0KPiArICAg
IH0NCj4gKyAgICBnX3N0cmluZ19hcHBlbmRfcHJpbnRmKG91dCwgIlxuIik7DQo+ICsgICAgcWVt
dV9wbHVnaW5fb3V0cyhvdXQtPnN0cik7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyB2b2lkIHZjcHVf
dGJfdHJhbnMocWVtdV9wbHVnaW5faWRfdCBpZCwgc3RydWN0IHFlbXVfcGx1Z2luX3RiICp0YikN
Cj4gIHsNCj4gICAgICBzaXplX3QgbiA9IHFlbXVfcGx1Z2luX3RiX25faW5zbnModGIpOw0KPiBA
QCAtNzksNiArMTIyLDE2IEBAIHN0YXRpYyB2b2lkIHZjcHVfdGJfdHJhbnMocWVtdV9wbHVnaW5f
aWRfdCBpZCwgc3RydWN0DQo+IHFlbXVfcGx1Z2luX3RiICp0YikNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFFFTVVfUExVR0lOX0NCX05PX1JFR1MsDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBydywgTlVMTCk7
DQo+ICAgICAgICAgIH0NCj4gKyAgICAgICAgaWYgKGRvX3ByaW50X2FjY2Vzc2VzKSB7DQo+ICsg
ICAgICAgICAgICAvKiB3ZSBsZWFrIHRoaXMgcG9pbnRlciwgdG8gYXZvaWQgbG9ja2luZyB0byBr
ZWVwIHRyYWNrIG9mIGl0ICovDQo+ICsgICAgICAgICAgICBJbnNuSW5mbyAqaW5zbl9pbmZvID0g
Z19tYWxsb2Moc2l6ZW9mKEluc25JbmZvKSk7DQo+ICsgICAgICAgICAgICBjb25zdCBjaGFyICpz
eW0gPSBxZW11X3BsdWdpbl9pbnNuX3N5bWJvbChpbnNuKTsNCj4gKyAgICAgICAgICAgIGluc25f
aW5mby0+c3ltID0gc3ltID8gc3ltIDogIiI7DQo+ICsgICAgICAgICAgICBpbnNuX2luZm8tPnZh
ZGRyID0gcWVtdV9wbHVnaW5faW5zbl92YWRkcihpbnNuKTsNCj4gKyAgICAgICAgICAgIHFlbXVf
cGx1Z2luX3JlZ2lzdGVyX3ZjcHVfbWVtX2NiKGluc24sIHByaW50X2FjY2VzcywNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFFFTVVfUExVR0lOX0NCX05P
X1JFR1MsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBy
dywgKHZvaWQgKikgaW5zbl9pbmZvKTsNCj4gKyAgICAgICAgfQ0KPiAgICAgIH0NCj4gIH0NCj4g
DQo+IEBAIC0xMTcsNiArMTcwLDEyIEBAIFFFTVVfUExVR0lOX0VYUE9SVCBpbnQNCj4gcWVtdV9w
bHVnaW5faW5zdGFsbChxZW11X3BsdWdpbl9pZF90IGlkLA0KPiAgICAgICAgICAgICAgICAgIGZw
cmludGYoc3RkZXJyLCAiYm9vbGVhbiBhcmd1bWVudCBwYXJzaW5nIGZhaWxlZDogJXNcbiIsIG9w
dCk7DQo+ICAgICAgICAgICAgICAgICAgcmV0dXJuIC0xOw0KPiAgICAgICAgICAgICAgfQ0KPiAr
ICAgICAgICB9IGVsc2UgaWYgKGdfc3RyY21wMCh0b2tlbnNbMF0sICJwcmludC1hY2Nlc3NlcyIp
ID09IDApIHsNCj4gKyAgICAgICAgICAgIGlmICghcWVtdV9wbHVnaW5fYm9vbF9wYXJzZSh0b2tl
bnNbMF0sIHRva2Vuc1sxXSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAmZG9fcHJpbnRfYWNjZXNzZXMpKSB7DQo+ICsgICAgICAgICAgICAgICAgZnByaW50Zihz
dGRlcnIsICJib29sZWFuIGFyZ3VtZW50IHBhcnNpbmcgZmFpbGVkOiAlc1xuIiwgb3B0KTsNCj4g
KyAgICAgICAgICAgICAgICByZXR1cm4gLTE7DQo+ICsgICAgICAgICAgICB9DQo+ICAgICAgICAg
IH0gZWxzZSB7DQo+ICAgICAgICAgICAgICBmcHJpbnRmKHN0ZGVyciwgIm9wdGlvbiBwYXJzaW5n
IGZhaWxlZDogJXNcbiIsIG9wdCk7DQo+ICAgICAgICAgICAgICByZXR1cm4gLTE7DQo+IEBAIC0x
MjksNiArMTg4LDE0IEBAIFFFTVVfUExVR0lOX0VYUE9SVCBpbnQNCj4gcWVtdV9wbHVnaW5faW5z
dGFsbChxZW11X3BsdWdpbl9pZF90IGlkLA0KPiAgICAgICAgICByZXR1cm4gLTE7DQo+ICAgICAg
fQ0KPiANCj4gKyAgICBpZiAoZG9fcHJpbnRfYWNjZXNzZXMpIHsNCj4gKyAgICAgICAgZ19hdXRv
cHRyKEdTdHJpbmcpIG91dCA9IGdfc3RyaW5nX25ldygiIik7DQo+ICsgICAgICAgIGdfc3RyaW5n
X3ByaW50ZihvdXQsDQo+ICsgICAgICAgICAgICAgICAgImluc25fdmFkZHIsaW5zbl9zeW1ib2ws
bWVtX3ZhZGRyLG1lbV9od2FkZHIsIg0KPiArICAgICAgICAgICAgICAgICJhY2Nlc3Nfc2l6ZSxh
Y2Nlc3NfdHlwZSxtZW1fdmFsdWVcbiIpOw0KPiArICAgICAgICBxZW11X3BsdWdpbl9vdXRzKG91
dC0+c3RyKTsNCj4gKyAgICB9DQo+ICsNCj4gICAgICBjb3VudHMgPSBxZW11X3BsdWdpbl9zY29y
ZWJvYXJkX25ldyhzaXplb2YoQ1BVQ291bnQpKTsNCj4gICAgICBtZW1fY291bnQgPSBxZW11X3Bs
dWdpbl9zY29yZWJvYXJkX3U2NF9pbl9zdHJ1Y3QoDQo+ICAgICAgICAgIGNvdW50cywgQ1BVQ291
bnQsIG1lbV9jb3VudCk7DQo+IC0tDQo+IDIuMzkuMg0KPiANCg0K

