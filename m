Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4586C3DA61
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 00:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUbpy-0007DD-5z; Thu, 18 Jul 2024 20:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sUbpx-00077p-EI
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 20:51:05 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sUbpu-00041E-H0
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 20:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1721350261; x=1752886261;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tG1ckkkyckMqVaajYFj/8Q9u48cebryKalzWsOGJDmc=;
 b=nYN0Y23uBc39/crw3PR+CEpcQ93smpDd1kipjxY8jdQIv2lvpYsHHCW1
 vUL1Nx4tlT2vYz81/pyGCdcNPJiZkOuxFo2tpg0CTfpfy/pZ3ePfDLlyR
 ShgclJ41lrF9qvA7BOhhUtV1QfHYZCG7V6/NM+fNMQZ0j+CFRS5cR+hzQ
 TOUZL8/bYFD5ij5vthaWukz9Zk1FaiR2bvEuHdvmoLMVMMG6nLc7SjzZU
 NdrCAhZ/U7SkktcEPQDogCswJWLOBWahpyPk/2mz3IKEQO2FJPKQaI4/p
 J4fh35rF8/4gdf9hjxFnG5PLKhXt39VwYqbJnDCy3BOEYKOGG90vNA+x0 A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="125551292"
X-IronPort-AV: E=Sophos;i="6.09,219,1716217200"; d="scan'208";a="125551292"
Received: from mail-japanwestazlp17010001.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.1])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2024 09:50:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7woTIbPIV6EdwN00BxBgcS7KhaaMQcTGadhBEhRuzZGYNX7EufRs76Ju7kJPhpEvj/u86wf1xTuVEgJMaocrmUhJcZGplcxe8fc+9c6jJ3c15G7d1OnUg7GfX9L0T06RystfsstdXEDiudSnWDnA/RFy+23UMtC47ORSQ9VeBY6UH/c+YkacZqSU0fA4K7hapTAkQ8N2sfha+VnLePBWIhpF0+ndOAP/ayd7LFuK/X7Y2bj/7hEr59dFohTy7hZ7I2VXN2aOlkSn42djc9HhlpSHJJ6VqmYfWPHb0nuQiTDz+14vPEoYRyQ+l3wfBOEMgFCEBSlaxhlXqLQLOmGEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tG1ckkkyckMqVaajYFj/8Q9u48cebryKalzWsOGJDmc=;
 b=UXxzxbjHAiEKhtIjXaAl7recRi/MUCRhSa/aB6XzbOWyOTh8HOkl5bP2jhwtqGDM+ptE4OjI5ZlZugDcBSYOKSK0f6tDWqujrLk8IXe/Ma9ZyMWcss7g86CnEi8nMbM70ghoTxVEX/53CcgmU9QUPkOc/Unsfg9N+8A9knJJBMsSc5yY23+UE1GksehCU9ziiJ/fYFlLoo+AAI1r9+VW+bGv0Wimah4kd8lkLHkKp9yOPRNNboiwS1a84FR10/cDoJlCtZId3APERMQ5n0ibhzhn8d2NmPQHn1eosdE2x3x8A/lXA5ePpKtaQ9Tcl5wuUKdkd+i8/P9la0gvEqAW6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYCPR01MB9829.jpnprd01.prod.outlook.com (2603:1096:400:20b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 00:50:49 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%4]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 00:50:48 +0000
To: Peter Maydell <peter.maydell@linaro.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
CC: "fan.ni@samsung.com" <fan.ni@samsung.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH] mem/cxl_type3: Fix overlapping region validation error
Thread-Topic: [PATCH] mem/cxl_type3: Fix overlapping region validation error
Thread-Index: AQHa2PH/d/XLGCPGR0Wjd/3IZU/pELH8r1EAgAAJ2wCAAH2sYA==
Date: Fri, 19 Jul 2024 00:50:47 +0000
Message-ID: <OSZPR01MB6453D638037F5D3FAEB480C28DAD2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240718090753.59163-1-yaoxt.fnst@fujitsu.com>
 <20240718173614.00006d13@Huawei.com>
 <CAFEAcA8UOwr6tuvPLZSPn8vzwpEnUrOW-2x184K2O281H7J07Q@mail.gmail.com>
In-Reply-To: <CAFEAcA8UOwr6tuvPLZSPn8vzwpEnUrOW-2x184K2O281H7J07Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9MWI5ODA0NzYtNDVmMS00ZjAyLWFkMzUtNDZmNmQzZmMz?=
 =?utf-8?B?MTkwO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA3LTE5VDAwOjQxOjI0WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYCPR01MB9829:EE_
x-ms-office365-filtering-correlation-id: c6b02704-2399-4721-769d-08dca78cd42b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?ZldHQld1OVNJazZ0c2EveE5xUGlvd21oWFFYOGl4UUd0OVUzSVppZTd5OVFF?=
 =?utf-8?B?VWJRSlIraWxTNTE4ajRoK3A2S1ZiU3lKK2RvdkFJa1htajBWa3dvaHJqVU1U?=
 =?utf-8?B?Yi9hTENtTTVmNFlxdjE4R0N4Ylc5QW5ZbVVYNS9OdFUrRS8rNERMVDZKRVhr?=
 =?utf-8?B?UE1TZUxhYVFidGJPeTJVck9PNDVPTnRQSzl3dmlWTU1BTEdkUWxtTHE4M3JB?=
 =?utf-8?B?c1lwa3pyckF2dkJadjZMYTE2RVl2V3k5TnNFQ1ZwUHNSRzUwd09LVkZkME4y?=
 =?utf-8?B?KzJQZlh1TTF5eDZKclZRR3BPYTMraGJiQ0x1MkVaWjRjWExreXpoNmtvOThL?=
 =?utf-8?B?NnRORzZGbk5CUU5KMk5ickZRN2RZK2lsdnJSbjQ2czRNbDNVYXVMcHVKckFk?=
 =?utf-8?B?VmY4U2lGOWZtcjZZUG90SWFTejZQS2VCSWpkeEw5TlgrMkhubDczTWNCeEkx?=
 =?utf-8?B?M3J5SXY1aHVDVEFneEc0cEhNZnRXZ29hb3g4VEVjQ1ZLYkZtL1pBcC9VVVJm?=
 =?utf-8?B?eGVoNzFGYUxjcWhVc0pISHV1SUoxMWlFN0VLUDZtV2JTQ2p3NXRTMm5ZSkJO?=
 =?utf-8?B?MkQ2UkxEdXhLc3c3bzFRVkNsbHlFN0k2N3RMUjNRaVZ1ZlcvcTVvd3RBYlZ3?=
 =?utf-8?B?TDF5c1Zsc1U1S2doSFp4ZW1KVFVmOU9haE9VRVEzT1hHSE91cTJjLzhZRkpk?=
 =?utf-8?B?NERGVDBocnZOU3ZsdXIxbmZvOVltRU5XMHdpVjFOVk5TT0owK3pSb0g3V2Jj?=
 =?utf-8?B?bjdzQk13RzdGVWVJR1RScWthdWNJa0dXMHN6ckpzVVZYQWJRcE90WklmdVkv?=
 =?utf-8?B?LzdLOWxQeE9WT213QmdUN0hIMXJzTUhrOTFpcEZIQkMrL3dxSWxwd09IRFY1?=
 =?utf-8?B?SXpZNkxqdXBXQ3hJVzVsQm5sNVJQRDREY28zTW1hYlZiVlRTdGR4MXdWMWNM?=
 =?utf-8?B?VExad3ZsSnlZTkZkMWQ2TFl0U1lEcm42cEJiQ29ZQXptd2ZONHB1OVdqc0Jv?=
 =?utf-8?B?M04yV1g1cFdFVG1XU0hZWTU2V21YOWxibThVUVVZYlByUmFoY3FQWUFNdCtl?=
 =?utf-8?B?OXdvZG9LSml5TzBYanloUWRiYXpXMlJ5bk5aWmE3bklLVGdjZXRha3c4VW5Q?=
 =?utf-8?B?TkpncUphY2trVThrU0dPaWsrTlp5cFZUdHRRTWhtRUk3SnczWW5mSEduNFdB?=
 =?utf-8?B?aEdnYVROeFlocE9xWVdwOXRXNUIyemcrS3laV1VjTk9Hak1Ia2xEN2U4c1Rx?=
 =?utf-8?B?bTIvSmpSUTFVRHpIODdWN1FSR0Q2aG01U25WVmhQdm1maUpTLzIvMEROMGw0?=
 =?utf-8?B?WkREeWFJck9FVUhQNlhEalZRdWZZVDF1Y29La2RnVmVLSEVzakN5R0QwcmlE?=
 =?utf-8?B?RjUwek9TZTJhVHlMWnNYYkhKbGpYcDhsU3NicEI4R1A2cFFwZysyVHUxeVNx?=
 =?utf-8?B?WmE0WkhpUWN0Z2dJR3NLZU1NNDM4dUpKT3YvYmZZWFVuOFdqQk1MZG4wVWxE?=
 =?utf-8?B?dXdyN1ZJdi81Rk82eDVUSTdJN0ZQNWVrdWoxZGJ6NWF5UjltVDVHYWNLQlNK?=
 =?utf-8?B?OXF0NVk3NmJGN1dHWlNMTytEWVl2dGJrYVdSdTdCTTIzMUg4TmdwWkNBRjFW?=
 =?utf-8?B?WklLdlRkNmlDRUo2alQvbGFKb1RhbzBxcUhPMEdKaTlHTjFnWjVqL3FYZmkx?=
 =?utf-8?B?WUZEM3Y2cFcyVTdPQlA0WFREQUZTYjJCU2R4MnFxUDJEa1N3R0RmOUNpUWo4?=
 =?utf-8?B?SW45eDN0VlB1VzZIckNEMkc4SzNoZG1SaWNpa3U5V3cxTHZqcFAySVJhNitX?=
 =?utf-8?B?bHJlSjc3MlpOV1VFdDdiaWlSUm8zcU9kU2w5Mk5kZVBHZ256MXFKc0Rxc01r?=
 =?utf-8?B?UGtRVUxxYXhCMjlRUThueVB2WWZtNUpYN0ZJUmlpV2puV2RVTGNmN0tIbFpj?=
 =?utf-8?Q?lEheSfXyPfY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE5SNG5lcCsrcEpZUEhScVJYaU5HTTkxY3JZTXV0Q2xDZGNJdVRJWHk5c2o0?=
 =?utf-8?B?SFRmdTFDdVIwQXJRNWZraDByVnRCTVRlT2psMmgyaTVzbENIOWRwOUNMMGFD?=
 =?utf-8?B?K1IyN0JkTlQvM1JRWk81NGFOc1k3UHhtKzBnNHpKN3ZhYU9wWXZwYURtS0hR?=
 =?utf-8?B?bkNJcDhLTVliaWRUdVozVzVjMGVUSlFUMHFVYnRXdGtzZUJGSU9GbTdFTE1u?=
 =?utf-8?B?cGNXNDVTZFlPdXVJeXlIYXdnbitGRHBLTVQxcnJyenpaeVp0RUVXMDZnTXJw?=
 =?utf-8?B?UDFlOXZmcU5OZXozYjUxU3RNNnp5dHZzUFhtQWtNdnJXWGcrbnNFVU9YT211?=
 =?utf-8?B?ZmE2MklKWHlrRUhMYkVZenkwWmJ5Z1ZGQUhBT0hJL0lDVkJINWNZcjUrM3k3?=
 =?utf-8?B?YmlVVkVSdHFud1UzMmdqZlNTTGo2cm5QMHpwU3IwdXFOSnB0VGxsTG40d0xs?=
 =?utf-8?B?L0hYOGo0ODEwekdCOGY5UUhHd1g4Vm1UeTlWejhTbDFqak1KK2lUVXBycmdz?=
 =?utf-8?B?RDJRZVFxZFg3ZWZjWFNxcVF1VFRBNk1qek1WcTVqYmlNeTMrN244Z1JrNmZn?=
 =?utf-8?B?SjFRUHBKeVloaW9LS3h3K21QSmZYcnFFZkhidDQrbFBWN0UyVFZMeldxVlc5?=
 =?utf-8?B?aDVjeEdqNGoxc0JnNEx4L2FWTS8wZ1ZNazFJQUpvQUU5VFlWZnJSWXlVL1o1?=
 =?utf-8?B?VFprdW1QcHhVMDdMdU50d0dJQ1pZUHVLSVdDTUh1YnhmcEFsM1FIaWU3cysx?=
 =?utf-8?B?UTN6ZTkxOWRFbi9neGp0aFNZUTFUallHaUhZQy80MGN4VGwrVERiTEx4emJR?=
 =?utf-8?B?NGhzQlgrRHBBTFBtOHhXWk9EUXNCemllUjkzQnhaQytRMHM4a0krdFZlSmx0?=
 =?utf-8?B?dUVuKzlCRDZlRFloMVRacEdraUZQZm9ENTRITkNEUEdIOFQ2VGFGUXZTbUxE?=
 =?utf-8?B?TjNzNFJTRWRFZEloQmUwcW90QldoYTVneVNmalBIZldKZ214cnROQlhlSW5G?=
 =?utf-8?B?eW51T0txTDR2RHI1L0lVVTJBMnlFUStUakNYdG5BbWhHQU5SWWxMNlYwTTBM?=
 =?utf-8?B?TG5jNkFtbmZ3YWxCNWdlaWxmVG1adzI2bXBUUHRQNXZ0OTIzY2NYcnFLSkt4?=
 =?utf-8?B?Z3gzY3R0eE9YYWtIL1Fpd1VYK0l0cHI4azU3RHZUZUlsbWFXVFJoM2w2THZz?=
 =?utf-8?B?ZDkxQjlZQnpWRnRKcU1zWjg1aVF4TEV0V3R4cTlFQUc1UWE3QVhaMXVkUnVM?=
 =?utf-8?B?d2NLTXVrbjZyaitmY3l2K0Fvd2QvMXN0SWNVN3VRRGtDUkxtTkY2WXVDMFNP?=
 =?utf-8?B?SXBTOHQ1UEhzK0lsT0pKQnlJL2V5SS9sZWxjNzUzKzE3b3o5a1V5VmhhbElz?=
 =?utf-8?B?U2gySlpmRWR5dTdBYlBtRGlxMURpQkQybzlTaktVUHIyNnA0SVgxTkt6K3BZ?=
 =?utf-8?B?UFdNV05YSXVqelJUNVVrbkNQUC84cnpxeXpQZytXVzdJV1Fmb0tSVi80ckYz?=
 =?utf-8?B?U015bU5KUGZLdU5XcGI1TnZhcmdwM08waEUvSzc4TWEvS01YcklYeFphckpF?=
 =?utf-8?B?eXlMYm1JMkRSeGZjSjF0eDc0WDd0dUsxbDZBSVdWcndZUjZhbWJqNnZHNnRZ?=
 =?utf-8?B?Z1FpVkpWWFVGRTRuNU9US1ZjYXlNaDB1KzZ3d0R0K0l4S1FWMkNvcG5Ldlcx?=
 =?utf-8?B?RjgwQnlsdU1yYmgvRkoxTzhFbTRsSDM3aWFZVFNHUFd0UEwySkJkQUNKV1Nn?=
 =?utf-8?B?K3pwWDJXZDNaUWsrMnVDWFQ5NkV4em5MbTF1aDM5NU5DZi8zS3dhYWhiK0h6?=
 =?utf-8?B?Nkx2MlR2cDhSaTBOOEJ4OG5SMU1YcGgxSzBNb0IrVk9JbklLTHZZWmpCS3I0?=
 =?utf-8?B?ZWE3U2orKy9IblNGS3BEajAydFBSejVjMWxKOWdXemQ2NXFoTGVIWWtJVEVr?=
 =?utf-8?B?OUQyUlpoaEptSHFIUCtGc1QyTndwUCtNSXV6eEd4OUUyM3lIK3VDbENYTms3?=
 =?utf-8?B?RUpXUHNOUERJWkRKYzNoVmVKVTE2OWlReWEvMS9zNExicWxrOVJ3VEUrNWtz?=
 =?utf-8?B?RWxEMFpBcTFEdS9WQkFqamhGSm1XL1Vmc0NIUjJxa09ZZW91KzBoWW1oT3BP?=
 =?utf-8?Q?/0uQVuhbEYBoM8bAPeL3CjVH1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: M241fUnTZGZDIKNyZ39KUoPNLYPDOBPVfrvw3NFc7KxrEr5F0FQoSIJliVqsvypsBrsFJxsnr8u6YmKhtEjboL0mIsjlafKjyk7VskY9AhenHDtyPH/7/2pTYKxYsMHMQxwxoRO1XMSdKdYBSpvEYIkckRaw8NaBRBm8BqrzCIl5yKZ1mms6jphLGCfKQnTXdUJLlG52QJtqYm+UuwrKFwVEyO2kLThkSJJQmFDDGu1N/9wTBvTIQuh/Ouz0E/PlHw+TkdkVKwkdWCNPeqsr/cJI9YGIK4Ak2YSkyAGBfbFxfeDoTxg2zlD+XsuB2ZfPaQIw9PgsIXJI0iMbB272kwAYhBLXIhPzmL/T9BlUrxS/2ixhrfxrv9NbcKSL6WxkQOxz1k3tk+PgR6NiZOEfcivi8wuwaDbGIX+j9+GzTVY63AY7VlBl8mt/pcOoMsl/kG6tZFIP5AiCcz+RGLAeOLnXWbkjU6h4fmfYLsFp82LsKIVhE1gMshZwxTIYR/Euo8RXwsjLsz4XksaxarNw6EQQCurxyQ+PidseeNjc8exHiFvUtlySSnNpG3wwFJ7UUTehPdWK8IcpG2GFApqEHu0olSOxzijW6lEBTh4jQ21NjJxOElYaOzle8vuSXtTL
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b02704-2399-4721-769d-08dca78cd42b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 00:50:47.6222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 64R3HhXpWufYeglDHenmLVjfxLL5DnKmLbrwJHVsLVmS0bgWPJg3DOJ50adHpAXYye5xctThfTkwDSsmh6woPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9829
Received-SPF: pass client-ip=68.232.159.87;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa7.fujitsucc.c3s2.iphmx.com
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIEp1bHkgMTksIDIwMjQg
MToxMiBBTQ0KPiBUbzogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWku
Y29tPg0KPiBDYzogWWFvLCBYaW5ndGFvL+WnmiDlubjmtpsgPHlhb3h0LmZuc3RAZnVqaXRzdS5j
b20+OyBmYW4ubmlAc2Ftc3VuZy5jb207DQo+IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIXSBtZW0vY3hsX3R5cGUzOiBGaXggb3ZlcmxhcHBpbmcgcmVnaW9uIHZh
bGlkYXRpb24gZXJyb3INCj4gDQo+IE9uIFRodSwgMTggSnVsIDIwMjQgYXQgMTc6MzcsIEpvbmF0
aGFuIENhbWVyb24gdmlhDQo+IDxxZW11LWRldmVsQG5vbmdudS5vcmc+IHdyb3RlOg0KPiA+DQo+
ID4gT24gVGh1LCAxOCBKdWwgMjAyNCAwNTowNzo1MyAtMDQwMA0KPiA+IFlhbyBYaW5ndGFvIDx5
YW94dC5mbnN0QGZ1aml0c3UuY29tPiB3cm90ZToNCj4gPg0KPiA+ID4gV2hlbiBpbmplY3Rpbmcg
YSBuZXcgcG9pc29uZWQgcmVnaW9uIHRocm91Z2ggcW1wX2N4bF9pbmplY3RfcG9pc29uKCksDQo+
ID4gPiB0aGUgbmV3bHkgaW5qZWN0ZWQgcmVnaW9uIHNob3VsZCBub3Qgb3ZlcmxhcCB3aXRoIGV4
aXN0aW5nIHBvaXNvbmVkDQo+ID4gPiByZWdpb25zLg0KPiA+ID4NCj4gPiA+IFRoZSBjdXJyZW50
IHZhbGlkYXRpb24gbWV0aG9kIGRvZXMgbm90IGNvbnNpZGVyIHRoZSBmb2xsb3dpbmcNCj4gPiA+
IG92ZXJsYXBwaW5nIHJlZ2lvbjoNCj4gPiA+IOKUjOKUgOKUgOKUgOKUrOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUrOKUgOKUgOKUgOKUkA0KPiA+ID4g4pSCYSAg4pSCICBiKGEpIOKUgmEgIOKUgg0K
PiA+ID4g4pSU4pSA4pSA4pSA4pS04pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS04pSA4pSA4pSA4pSY
DQo+ID4gPiAoYSBpcyBhIG5ld2x5IGFkZGVkIHJlZ2lvbiwgYiBpcyBhbiBleGlzdGluZyByZWdp
b24sIGFuZCBiIGlzIGENCj4gPiA+ICBzdWJyZWdpb24gb2YgYSkNCj4gPiA+DQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBZYW8gWGluZ3RhbyA8eWFveHQuZm5zdEBmdWppdHN1LmNvbT4NCj4gPiBMb29r
cyBjb3JyZWN0IHRvIG1lLg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IEpvbmF0aGFuIENhbWVyb24g
PEpvbmF0aGFuLkNhbWVyb25AaHV3ZWkuY29tPg0KPiA+IEkndmUgcXVldWVkIGl0IG9uIG15IGxv
Y2FsIGJyYW5jaC4NCj4gPiBJIG5lZWQgdG8gcHV0IHRvZ2V0aGVyIGFuIHVwZGF0ZWQgcHVibGlj
IG9uZS4NCj4gPg0KPiA+IE5vIGh1Z2UgcnVzaCB0byBxdWV1ZSB0aGlzIHVwIHRob3VnaCBJIHRo
aW5rIGFzIHRoZSBlZmZlY3RzDQo+ID4gYXJlIG1pbm9yLg0KPiANCj4gSSB0aGluayB5b3UgY2Fu
IHByb2JhYmx5IHdyaXRlIHRoaXMgYXMNCj4gICAgcmFuZ2VzX292ZXJsYXAoc3RhcnQsIGxlbiwg
cC0+c3RhcnQsIHAtPmxlbmd0aCkNCj4gdXNpbmcgdGhlIHV0aWxpdHkgZnVuY3Rpb24gaW4gaW5j
bHVkZS9xZW11L3Jhbmdlcy5oLCB3aGljaCBpcw0KPiBhIGJpdCBtb3JlIHJlYWRhYmxlIHRoYW4g
b3Blbi1jb2RpbmcgdGhlIG92ZXJsYXAgdGVzdC4NCkdyZWF0ISBJIHdpbGwgZml4IGl0IGluIHRo
ZSBuZXh0IHJldmlzaW9uLg0KDQo+IA0KPiAoVGhlcmUncyBhbm90aGVyIGNvdXBsZSBvZiBvcGVu
LWNvZGVkIG92ZXJsYXAgdGVzdHMgaW4NCj4gY3hsLW1haWxib3gtdXRpbHMuYy4pDQpJIHdpbGwg
Y29sbGVjdCB0aGVzZSBpc3N1ZXMgYW5kIGZpeCB0aGVtIGluIHNlcGFyYXRlIHBhdGNoZXMuDQoN
Cj4gDQo+IHRoYW5rcw0KPiAtLSBQTU0NCg==

