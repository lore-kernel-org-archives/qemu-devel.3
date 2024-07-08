Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4ADEC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 11:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQmjO-0004O1-AP; Mon, 08 Jul 2024 07:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sQmj6-0003x4-UD
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:40:13 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sQmiv-0007ru-2R
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720438801; x=1751974801;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=hVh5soF1sbHB0PJ604yENPnseV6Ov4o/X3k1Zl3qdXU=;
 b=TWZkvPXcuqc5p/iVCmIpIpBx+PsSzyctJZAIbTKyZllW0sqXIWwHbdnq
 TeBq3+n5eDgHB55LI2+w6ozGP3WOAeFS6m8zzWis7aHhlfche13D/6LkG
 B3C9tRGl+pA8kUW1540NCGcerTE6qraimzAVtSa1CbOnudbFjeOGW6YpE
 SVVGMA5p1GngaeFJPu4kuYvjlrzRwvSmtWB9h/2mKn7MHyGtK+WJjq+2c
 nD4UByXeJcm2kwIJ3F3lpo2e6xkuEf/5AQGPbfCDLlX23Kc3rc/IF6NDA
 Q7FEvkpvSIKEz/o/IBHI4ZGeDTPUDS3+waJ7bG2i2kSWRDYExlaqTKaBT g==;
X-IronPort-AV: E=Sophos;i="6.09,191,1716242400"; d="scan'208";a="16088415"
X-MGA-submission: =?us-ascii?q?MDFAqD+/7YTWuWa8Ao4O1OoCaN49GNglfsbPir?=
 =?us-ascii?q?Os6tkaG/U9KBFGAuRK0XcXjLR6Kh7UL2EP3Tp261Dm05SwwxM/zUfwWC?=
 =?us-ascii?q?sqYXbILs7FW9IhPvVGRSYbTS6OqDK9PtwrxNVOKZH1Ve4burjLtzEa6M?=
 =?us-ascii?q?nMrRq9vFtjJHBWLthZbrFnKg=3D=3D?=
Received: from mail-vi1eur03lp2105.outbound.protection.outlook.com (HELO
 EUR03-VI1-obe.outbound.protection.outlook.com) ([104.47.30.105])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2024 13:39:56 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFUmfmElNTxIm9dEnaCgZ9LixdOLaGvdmpRuAXaedfTfCBbwHlRKfdhQOwyCt5gPaxDpO9ou1wDsCHqzNaJR7LviAS5LgGbds1ybTP5Z0CVBEg4Yan9RnCDH2LAFBz9Vx1PwssXbfb+Sl718uCuqaZIhRQKKhXmCo6vU8iXr2fp0hgVMbEluJ/EwKJkJPI4h2TmPpLmGAEX0Vt/TV4XRWRbeIB6xiQ7sa2N6xm4QeA6K+XwrSIgvq1rEZRgHR/xm1PL+K0nqTE8QGmLwpCQ2hilseIr618OqPoOAey7W2G8y4mkup0vv2bwdamr7oRGqbdTdG2DV4ESyJCurWMfyDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVh5soF1sbHB0PJ604yENPnseV6Ov4o/X3k1Zl3qdXU=;
 b=k3bfaldWrJUtMHlr/EAGbZe8s207dIOC0nM0Wh5jaAx0Ma2HtleEoxCWIco93OLJsSV06GSa7LUp9hSA5RalSf7KEI/Fu8vCKbM2nW/+PkEhjjxwiHqOz6Cs2pqMYdzKLs+5EXtu3DY6gh1O9tjeWSBRQJ9asI6UV6sff0QErF3M3nhhhLkPp08/MmgYumOVmsmNr1KrYMDEWo9oyT+mc7FqU5ZJOzvMO8++In1Wdk8ayJJqHxoT3TPXo0D1EKc6jbmhWj0IkmsEMq7Wgr5BfyjCMYUbX8WSYPX46YSIq+6pJKr+uv1Ek+jq5ckeoYo/x4coyO2f7S/POYKHiIlZsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVh5soF1sbHB0PJ604yENPnseV6Ov4o/X3k1Zl3qdXU=;
 b=AqR0fxLuLUbZoeSvqyd/ObYWNuIftjX0sHOUgYEPiqfBXL+5MrpTqpt5h4DQz7WM6Dy5180SjQkFn8E4U61P2i76whnSJloOmkkr8kDk4A987c34oqXFQsPlJMs8bo1SiizGv+paGzbFtBAkuo4y5ApZrxkufs/M0P2JXbwcScNBj4QMOtXMuT51+KjCWH5vsiOdqzHpfGDS/7fXpyvuzCYCpDqf+pdvrDhnN6xLagLD6qJhgN2cBAC2WHLuOO7DHBgVPGWSrZ0wLRNmVdZLJqLEfutKVInYDTBHX7PupBOcxgGaGKjsDlS5DfJgorHCDXA7iH0pbLtUWJLpPYhp4g==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7400.eurprd07.prod.outlook.com (2603:10a6:20b:2a4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.18; Mon, 8 Jul
 2024 11:39:55 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7762.016; Mon, 8 Jul 2024
 11:39:55 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH  v5 3/4] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Thread-Topic: [PATCH  v5 3/4] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Thread-Index: AQHa0SuNYymPsQHFfky5WnjMRsYUBA==
Date: Mon, 8 Jul 2024 11:39:54 +0000
Message-ID: <20240708113908.19535-4-clement.mathieu--drif@eviden.com>
References: <20240708113908.19535-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240708113908.19535-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7400:EE_
x-ms-office365-filtering-correlation-id: a59437e5-7193-42b2-b31b-08dc9f42b00c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cHFXUkhod2VPbWZWcWphQ1lDSFJ3YXJ5WjRGQWJNRVFqS1J2cDNPV2ptaG93?=
 =?utf-8?B?ZjAwczNjdGRWYTFhNVZ4SG1vb1M1RTdCdGJEUFArVDFtMDdEOVVETEZ4Ryt6?=
 =?utf-8?B?WUpzRVhxdmxLZVBVelpjQmJpQ2pFSGwvVktKVDBPSU9TL0phS0syRW5zazNE?=
 =?utf-8?B?TkdFeVJHR2lSRjE1eU1zV3VBSnAyQU5wdGlwcnRLK0dGMDA0T0I4aklrMWxS?=
 =?utf-8?B?NHpUUEZMaVhnVk1Ud1N6L0oyMWtKOHdKbVNGaUZ4LzZheWhxQnFhZEJpSzho?=
 =?utf-8?B?VVBRZDlhQ1ExeTUrd0xETHd0NmRXTDZwczN6NlFrWkVkcDMrLzlLUHJiM09F?=
 =?utf-8?B?NHZrMXZwd0xwZU1JSkh0ZzZtaHM3UWxhNEN5clpqeThZcVFCOFBjU1QxWVhW?=
 =?utf-8?B?T05ISlJOVFZjN0tFNDZuQmFVNGdpZVhLWCsvQm1rTFFCRGhqYVpkL3pxWUxk?=
 =?utf-8?B?OHpHN2dwVE1GMFdRc1pVN2VBQklvRWh2R1pCdzAyV0RTK29rTmd4Y3QvL3Yr?=
 =?utf-8?B?QVQ2dVlsVytBVFhZTG9WMWRDbElJVFlnK3BiSFdxcm00eWhITWVmUVdXbVQ2?=
 =?utf-8?B?SlRWcmlPVWhMQjZFN25MaEhBYk9VdkZJN1ZHZjlUVlkySVVaWlJ4dXBSOHc1?=
 =?utf-8?B?QUFFL1FMa1NkZGF0WjhDV2t3N1JIa1FwdW1XNGNYN2NLaWphK3dmRkYrWFV4?=
 =?utf-8?B?bGRPVUdGZmJIODV2UFNOanF2LzhITWUvdThmUjRXUzhaeGZkZy94ek1tZDEw?=
 =?utf-8?B?TUFCdlhDTHM0Q05tdjlXZm0zSFJnTlp6K3NzZmFUM0lIQnpSTU1jeHhMSlkw?=
 =?utf-8?B?NlFEemxJd0kwdXg1eFhmbTE5MmpRbHlEd2ZKdDlXYUgzcGxOTmtoYWYvUUhU?=
 =?utf-8?B?cTRsNnZBWGIrb2V4WTQ4M01MUkxXZ3cwR3lGc1Vwdlo2bEREK0NYNjg0a2dO?=
 =?utf-8?B?dUE5c2FCMFVzcktUS1BQclcvVjUyUmR5dzY2eEFWaDVMQjRDb3h2U0hQdzVK?=
 =?utf-8?B?THZOWFZLNDVuWWs0cGdaMGNKSExXMWxyYU42Z1Fhd2hVYUhFQXB6ZXUwYzM3?=
 =?utf-8?B?VDJJT1hRNHJxa28wZHJLUEtMTzE4eDgzd1Y3eXVNMGp4Z3hkL2V4M1UwOFIy?=
 =?utf-8?B?QXp6NTJ4OXVWTE1PdVZ1MjRxSXRhNllpS29wWllDQlQxeEJ5Y1J5d25YTTdW?=
 =?utf-8?B?b1Jhbm4vZUttK2RNbmg5M1FiT2twZU53cWQrUHBNQWpWRWxMalc2TjBUbERz?=
 =?utf-8?B?bGF4Y2c0eGJJSE1ZVTB0SGxtbWQ0dFN3ejFJQW8xL1FQRFhTR1VvY2d6Nkk4?=
 =?utf-8?B?UEpFdHNWRlpFRkFSWTIwT2wzNHRiT3hWVFZvdDJ0RlF5QnNNRGZLWkp2VUtV?=
 =?utf-8?B?QTVsNWdoSy9lekgya1ZrYi9PTXVSMlhsN2FPSDdZREE2SXNxOXMxSllabVhG?=
 =?utf-8?B?Zm0xMDM3YTdIM21KQlRpcWVLWEJBTURicmlpSjBoREowOXEySEhMekw1SHQ4?=
 =?utf-8?B?Qm9KM01TNTdhMVVLWWoxZDl2N004Q09wN0J1b1pXZS9WLzNKN2F2YXlWUyty?=
 =?utf-8?B?ZEh3YlM3b3cvMXVacllqaE44MEFXb2VaTmNyQ0ZlSWRBc0dzRktkN2JxTmdI?=
 =?utf-8?B?MTVyeHg4U09wMi96enJzWTNaSk14TjhBd25HVU9oZ1dyR081eEFkR0ZiMXJZ?=
 =?utf-8?B?ZDBnSnJ0VEJqa25mVC92MW5JSU0wc1JsYmUyTXlWUVFCSG1vT0xOUE94Wm5O?=
 =?utf-8?B?Q2NMU2tuZWtzTFdIdmlpUVJEcXRDVE5SYVBZZm5ockhrSW1EN3F5dEQrdWtO?=
 =?utf-8?B?MWxmVVRML3B3VXBQKzlzSUE0WnExUkhyU1JCMU9rN3VieVNZWlhGTDVkVHpL?=
 =?utf-8?B?dFRpOTNvbVZzdEFvRnp4R3prRFF4T0F2dDRlTWJTdFV5cWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHpaR2REZktET05oR2ZDQUR0N0lWSHhnV05sZEs2cVcrMEtzR2lCZnZVV0xD?=
 =?utf-8?B?c1ZZUEhmTjlxYTlnWG5ZeWhJdFl6WGNTZDZSd2ZnMHl4TDVPMkRhaXVvSVFW?=
 =?utf-8?B?Ujl6U21vd0t4VGp4dEt0RGd1aVJ0SVY4SldybEtpTkRUTXR2dkR5TlhXMmxh?=
 =?utf-8?B?d3M3aW5oTlNqdEM4RlpLVEh2ZEUxbldjRVVUWlBjVTQ1NUtDR0VKL2pSTHJo?=
 =?utf-8?B?MXB3UjcwMGZWRmE2bnBVZFZtblJMTXBPMk5SczhyaFB4MWNDY1M5M0NQUlRU?=
 =?utf-8?B?S29YZnp3Y3o4UkxRQmQ2WkFSMExpLzgraWkyRklhMXRLQU5DMjZvUElrWVlB?=
 =?utf-8?B?WXU5TDJFYUt5cVNKems2QW5keWJyM2M3SEd1RnJMRlhrczhDMTJDZDduYThw?=
 =?utf-8?B?VDhYL3lydHBKQWh6TzBqZldjcHBYMVJ0QkF0V1VlcDRsUGJnYVg2Y1c3OTM3?=
 =?utf-8?B?aHgyUWNNYWlrMFM1YUdLU0g5VWgwVXhXQkpVTmhYbll6TmpRNEQ3NStueVdw?=
 =?utf-8?B?VEJ4bnFEQnF3SjF1c09xMk9GT01uUG5xN0w2QVFoODhZMHFVZUdVN0dFZzRE?=
 =?utf-8?B?VStnYXcvUnZ4QlFWbG00TE1kaCtxYmRjbjEram8xRS9MZ3NJNDNoY0o0TXY2?=
 =?utf-8?B?ZUh0M0dPOU9adjExV2JOalA1cEkycWtoUEd2RjJCV2QvNXhNbS9UOFg5dm13?=
 =?utf-8?B?MUZ2dWZQN3hCN2I1N0V1Ykx0eFB2eldYWGJ4cGovMDNGMFZZaFJuaDZEMHhB?=
 =?utf-8?B?NGxhR3pkZ2l3Qkcya0t2RE1pK1J5VXN0ZnEzZEdpVjk4MElibkhZMThzY25r?=
 =?utf-8?B?dURNczVHYkJNajNvZTRkQVBzbGhKL1JzUnk2Vkl1Wis1UUxwNm5ROGtCK01m?=
 =?utf-8?B?cTBSS1ozcmJmUDI3TWtlRVB2OCttVDhYcEhETGt2WENsR0tUVXFORVQweVpI?=
 =?utf-8?B?K3lOeFAwT1k1MWxuSHdzaHBUbkRUTlUzaE5CMDZHbGlSUVlPTWZFNGxPdXJw?=
 =?utf-8?B?S21OWHdOMVoyTUtuM1BFSzdlUW8yTXpCdFdCMStvcCtJQ3FjeHloSTR2YjAy?=
 =?utf-8?B?cGtPQTFpbUtzS0cwNHVQVnoza3hXUU93T1hxbEVZUkxnQUlFMUI3VzYvTlQw?=
 =?utf-8?B?OWZjMTVUYzlkOUNGcU8wNVNKa2lkZTkvbGlDSExHNXdmTWhKNkNYLy9ac0dT?=
 =?utf-8?B?bXN4QUx1eXBDcVhNNFlOQ1pKcHFwNksrZi9GM1ZJZnVOM2dhYzZrcktBTld3?=
 =?utf-8?B?R2U1cGF0MDFPZjVLVFpFZlFWUXo2RnNFSlBYei9FbUcxUnYvS3VpSS8vendn?=
 =?utf-8?B?eWdwN3hKZFVCcHZlSFV5SlFPeDAvcTlOUFZFQlU2M3FjSkxHTHhxMGFwb2cy?=
 =?utf-8?B?R0V0V1gzV3ZkeEEvL25GNy9LNVBOamVUeUpHMEdrUnNLcW5ONEZzU1h6blV0?=
 =?utf-8?B?dDd5Q0ZlNzZTQWlzcGNRL0Y3SlF4bTlTMml4SkcyTVBLT3M3TmVnVWMwMmhP?=
 =?utf-8?B?ZnBxdUdPT3BHTzhSbFhIaWZBdnZDeE53aTA3T2R3bEIrUjQ5a0wyVkJRVzVu?=
 =?utf-8?B?L3lCSUl4dE81eE9KRVM0ZmYwRDdzdk1zTTdZbk9GRGROZXVDSGE5QVJVbm8v?=
 =?utf-8?B?b0JmajRGUUdZNk03Y05VTXVweEFQUGpjQzJDdGpkSktCNGhBS1E3Qmc0S3oy?=
 =?utf-8?B?Y0JLMUc4OFBKVmRHSlp5MXI5d2swMDJocFhnb2ZTUWdGZ1ZHV0NwVWJnODlp?=
 =?utf-8?B?YWRJVEFmVXU4WUh1cDI2QU9hZXlJeWFsWG9tK0NzMkIwUkZtbHBFRXVZNmtX?=
 =?utf-8?B?NVp3bzRweUpNYjRFWGlpNkI4d0dtbk1GRGNhekRyVjJzV1dvbGErblFUSVQ2?=
 =?utf-8?B?dUViUVBBemdNVGpYTFltK0YwK00xaW9qSDJicVVPWXdYQ2d0YVJVSDlpbVlP?=
 =?utf-8?B?NmQwWUxkU0g2WFhaTnJwQTl3Z1ptMTJTZFgyclJzajZqRVhMWGNUcTBQMlhq?=
 =?utf-8?B?cXVjUDdzZmZtUUN6RFpuT3pZa21lQ2hOOHVQT3JDUE9ETXlOb0RZZjh5ZVE5?=
 =?utf-8?B?ajBVKzNQSyt2WXA4Z1I3VVROZW5abTljYm1yb0M5OW14U1RpZWM4cnFnL0kw?=
 =?utf-8?B?d2tsSWF6K01FR1ZlUE5TTEVXeTNaRkhETzNzZlU5TTl0akg5RHFuTVQ4eTlu?=
 =?utf-8?Q?5BWdhZg9r0QsyIi4ncNvSYE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <335F543A0BD124458A581B97CC6CBA0B@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59437e5-7193-42b2-b31b-08dc9f42b00c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 11:39:54.9477 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3lxipbX/oFtypJYJU3vQGThxZYW/naPd/r5tN+PkJqzZ9u4cQAWISZw14G4Q7agHIPuduSWCQJytOKOQH/6hxqsxiuacwj5WRGmy+fVRJbXVxX+HK5HaLUon2ZchEkRW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7400
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClRoZSBtYXNrIHdlIGFyZSB0cnlpbmcgdG8gc3RvcmUgaW50byBWVERJT1RMQlBh
Z2VJbnZJbmZvLm1hc2sgbWlnaHQgbm90DQpmaXQgaW4gYW4gdWludDhfdC4gVXNlIHVpbnQ2NF90
IHRvIGF2b2lkIG92ZXJmbG93cy4NCg0KUGVyIHRoZSBiZWxvdyBjb2RlLCBpdCBjYW4gb3ZlcmZs
b3cgYXMgYW0gY2FuIGJlIGxhcmdlciB0aGFuIDggYWNjb3JkaW5nDQp0byB0aGUgQ0ggNi41LjIu
MyBJT1RMQiBJbnZhbGlkYXRlLiBBbmQgeW91IG1heSB3YW50IGEgZml4IHRhZyBhcyB3ZWxsLg0K
DQppbmZvLm1hc2sgPSB+KCgxIDw8IGFtKSAtIDEpOw0KDQpDSCA2LjUuMi4zIElPVExCIEludmFs
aWRhdGUNCg0KQWRkcmVzcyBNYXNrIChBTSk6IEZvciBwYWdlLXNlbGVjdGl2ZS13aXRoaW4tZG9t
YWluIGludmFsaWRhdGlvbnMsDQp0aGUgQWRkcmVzcyBNYXNrIHNwZWNpZmllcyB0aGUgbnVtYmVy
IG9mIGxvdyBvcmRlciBiaXRzIG9mIHRoZSBBRERSDQpmaWVsZCB0aGF0IG11c3QgYmUgbWFza2Vk
IGZvciB0aGUgaW52YWxpZGF0aW9uIG9wZXJhdGlvbi4gVGhpcyBmaWVsZA0KZW5hYmxlcyBzb2Z0
d2FyZSB0byByZXF1ZXN0IGludmFsaWRhdGlvbiBvZiBjb250aWd1b3VzIG1hcHBpbmdzIGZvcg0K
c2l6ZS1hbGlnbmVkIHJlZ2lvbnMuIFJlZmVyIHRvIFRhYmxlIDE5IGZvciBlbmNvZGluZ3Mgb2Yg
dGhpcyBmaWVsZC4NCldoZW4gaW52YWxpZGF0aW5nIGEgbGFyZ2UtcGFnZSB0cmFuc2xhdGlvbiwg
c29mdHdhcmUgbXVzdCB1c2UgdGhlDQphcHByb3ByaWF0ZSBBZGRyZXNzIE1hc2sgdmFsdWUgKDAg
Zm9yIDRLQnl0ZSBwYWdlLCA5IGZvciAyLU1CeXRlIHBhZ2UsDQphbmQgMTggZm9yIDEtR0J5dGUg
cGFnZSkuIEhhcmR3YXJlIGltcGxlbWVudGF0aW9ucyByZXBvcnQgdGhlIG1heGltdW0NCnN1cHBv
cnRlZCBhZGRyZXNzIG1hc2sgdmFsdWUgdGhyb3VnaCB0aGUgQ2FwYWJpbGl0eSByZWdpc3Rlci4N
Cg0KU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1
LS1kcmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgg
fCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoN
CmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmgNCmluZGV4IGZhZWEyM2U4ZDYuLjVmMzJjMzY5NDMgMTAwNjQ0
DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCisrKyBiL2h3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaA0KQEAgLTQzNiw3ICs0MzYsNyBAQCBzdHJ1Y3QgVlRESU9UTEJQ
YWdlSW52SW5mbyB7DQogICAgIHVpbnQxNl90IGRvbWFpbl9pZDsNCiAgICAgdWludDMyX3QgcGFz
aWQ7DQogICAgIHVpbnQ2NF90IGFkZHI7DQotICAgIHVpbnQ4X3QgbWFzazsNCisgICAgdWludDY0
X3QgbWFzazsNCiB9Ow0KIHR5cGVkZWYgc3RydWN0IFZURElPVExCUGFnZUludkluZm8gVlRESU9U
TEJQYWdlSW52SW5mbzsNCiANCi0tIA0KMi40NS4yDQo=

