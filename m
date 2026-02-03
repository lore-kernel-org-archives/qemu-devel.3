Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2712E7C712
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 19:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnM5X-0005pc-FD; Tue, 03 Feb 2026 14:29:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vnM5V-0005pK-7R
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 14:29:25 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vnM5T-0000xb-7J
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 14:29:24 -0500
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
 by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6133FXOg1963199; Tue, 3 Feb 2026 19:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :message-id:mime-version:subject:to; s=jan2016.eng; bh=JLZit1xKU
 a8E4UpIpyheBof6bJ26MzL41gah36VvR0w=; b=mmq768jxUj2x/N84oR0u86rR+
 qrz9m3ZNf1e4fthnKnlGdqbwwLhpo6n9UMu58aD2BQ8E6NkbKTeSoP3sjdnvdUqj
 mxaenEunzms/WfKc6IP1mFaRt3bnMQU1/f0LQGb7stnhVftFyCw1VzqEcxsX9qlZ
 tBFOP3Z6rLJofVK/F74zJtybR5rS2w4AATlYnUBPKcl69cXK0vKMkdW3PizNCxLt
 CNXQU7ElpsuIcT4XfUzxjfbz5mstUJfbJChdUUZoOag4uogt6alX2s9KAqgRES5+
 AHKqVcz10ApB1ErH56x17jI+JqkFNrdsd9PbYaw/wItMD0JKqYfPqRmnlf7Iw==
Received: from prod-mail-ppoint7
 (a72-247-45-33.deploy.static.akamaitechnologies.com [72.247.45.33] (may be
 forged))
 by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4c1avqavr7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 19:29:20 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
 by prod-mail-ppoint7.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 613Ikdbd031675; Tue, 3 Feb 2026 14:29:19 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.220])
 by prod-mail-ppoint7.akamai.com (PPS) with ESMTPS id 4c1dy3fgvb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 14:29:19 -0500
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 3 Feb 2026 11:29:19 -0800
Received: from CO1PR08CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft
 SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 3 Feb 2026 11:29:19 -0800
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by PH0PR17MB4717.namprd17.prod.outlook.com (2603:10b6:510:85::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 19:29:16 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 19:29:16 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: "vsementsov@yandex-team.ru" <vsementsov@yandex-team.ru>,
 "jasowang@redhat.com" <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "yc-core@yandex-team.ru"
 <yc-core@yandex-team.ru>, "d-tatianin@yandex-team.ru"
 <d-tatianin@yandex-team.ru>, "davydov-max@yandex-team.ru"
 <davydov-max@yandex-team.ru>, "i.maximets@ovn.org" <i.maximets@ovn.org>
Subject: Re:[PATCH v2 08/12] net: introduce net_parse_fds()
Thread-Topic: [PATCH v2 08/12] net: introduce net_parse_fds()
Thread-Index: AQHclUNiloznUvzfDkSS1exkRSpcaw==
Date: Tue, 3 Feb 2026 19:29:16 +0000
Message-ID: <777C1460-24C2-48CC-9B38-34A5FE022007@akamai.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|PH0PR17MB4717:EE_
x-ms-office365-filtering-correlation-id: 096cac1e-ac29-4cbc-743d-08de635a8550
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?UEpDcEdQNmxFclVoRWRNb3FjcjhsWHNuZXBIRzRtU2dMWlY1TVgyUnJIRHhZ?=
 =?utf-8?B?cmZDL2ZBTVFLNkVyTDlHY01hZjFMUmtHNFhHTTZ2dXNFbTVyNXVQdjlNa0Qw?=
 =?utf-8?B?MmpBc3JYeVhScGRMNjNpZDJ4M0djcVh3VE9WNkdySFZ5b3JjQU9BZnUrd3ds?=
 =?utf-8?B?bWNYbkZxY3NoWENVMGNFa2tZaXNBU1pkdDQrcllIckFQMFBEc2lnNjM1L09o?=
 =?utf-8?B?dS83VlJESVQzSDJaRFBuZ2lrbzgzNnlMd3FXanRxejdFeVlEWUl3NzJ3ZzZ2?=
 =?utf-8?B?UTF6RnBkaHg5ZmZDRTNuREhkMjJ0VDQ5R3A5VitLRUNrNmJySlZnc0JzMEFL?=
 =?utf-8?B?aEgvWTFra0Nmc0dsTEhUaWlweXI2RkFCa3R0dk0xZWs1Ui9SVHA1bXNyUlp0?=
 =?utf-8?B?a2hzTHVSTVdSVW9CbjEyVTRRK2RCSjNVY2pmQ0d1NHJVY0VoV3FFMkI0bDQv?=
 =?utf-8?B?aG5YWmFzMEVPSi9XcWxNU0l4cnBRR3dXeVl1K2JncUpJWGVVbzNtRlA3MUxo?=
 =?utf-8?B?YVE4YVpBaklhTFhOb2NuQ1dvZEdWZCt4QmxXT3JRUklsUnBFUzU0ZWltU0xT?=
 =?utf-8?B?RzhnMUt4UDd2bVZjUnEvZWNWTUNpNFlMU3o4dDdyd1dxK3Y5OU4rbVlFRG80?=
 =?utf-8?B?TE40aXVLdFVQdkdES1QvY1M1a1ZlNHMwNUh2NkdkQ3N2aW5jOGZzbFJnbTFC?=
 =?utf-8?B?MTVtYkJQWGkxZHltdkRhZmtqZkh0RmNmTHQ1VXpYUkt4dDNkZlhDK2c5OEpm?=
 =?utf-8?B?QzUvYnErQm4vUytya2poSDZDRTJiTkREM0hHTERjdzA4NEpPMkVnRjdvTlRT?=
 =?utf-8?B?NTFsNUJ4cEovZVNRZTNYSU5hcjBuYXQzbFliVEcrc3pPd0Ryc3FhREN6RC9J?=
 =?utf-8?B?dlJUTmYva1NldjRSditBRXIxS2cxd2ZaY1Zpd29sYjZveWRzcEpaWVFRU3hs?=
 =?utf-8?B?UmlMN2RESUVUMWdjMGFVOVllYzl1Si9sYXZheUdPUG5nS1FtekZjbDV0aGUx?=
 =?utf-8?B?V3JvbHBrMjFjUVZBUGdjMFdGNDRVL2ZtNnAxQnNPT3ZySGl0U2JCYTdpQ0V2?=
 =?utf-8?B?SlFzVStrMXJXcngyTmgwTC9CT0hHNEhLNFk2TWMvZVZ4eFZtOEFmVEoweG5X?=
 =?utf-8?B?NTZ5NFJ4ZEQ3Q0ZWSk1IdmxzdmxVODgxRkRMaVZTcnc5TWtLYTMwQVFJYThB?=
 =?utf-8?B?dVVxQlRTT1Vtb2dWWjdzUnFIdDZtd20zMFdLVnZMaFJwN01US1h0bVV0c0xN?=
 =?utf-8?B?eG5acWJUZXUzTHk3Q3Y1dy84bmlEU2lqM3A3V3J3NzF1VUF2bXNrMUd2dDFn?=
 =?utf-8?B?ZUFmR01kTHQrUERodFBHT1BNdURLS0hqOGxLNTgrVHEzSnBVUUhYTHhlRy9j?=
 =?utf-8?B?UldzQVp6N1FhNXZNT3MrdmdrWEoyV0ZXbklYQVNwODBKUmdMWENNMzhJRlpz?=
 =?utf-8?B?dUxHaVlJc0hqQnBQeUNlVEx5RkJ3UGdBdDdLTlhtUzVlZ3FTN096TTZtSWw2?=
 =?utf-8?B?RWJsVTAwcUpSYXl0dGk4b282L2tjaWpuejBWbmRha1FhWGwwUjRXU0JVQzNU?=
 =?utf-8?B?QTFaTkhZMXhVdzVRejhJOXJGRG4yREx1cERBTzgrSFQ3Q2V5QUZqbi9zaTNH?=
 =?utf-8?B?VWt2cWVuTUhIOXZWdXdVbVFxNklPQW10Y25Jakw0dUJ5ZFVmUGMzTG9JclFj?=
 =?utf-8?B?K1ZXRkd5WVMydHZTQklDUUl3K1lsL2NGOVRXckFCQXF1VlkzVzFwY2ZRK2di?=
 =?utf-8?B?M0FVSnoyZktWejRLZnpyYkhaSTQwZ1JHMVdBMm5zSW5VMVJSN2gxY1NRSXRz?=
 =?utf-8?B?NWdNakh6UTlVc2ZLcVpMTEl3aUtUcjl3a3dVcHE0dWJ0SEMyS0d2YnNRMGJF?=
 =?utf-8?B?enRUb2N3aG05b2xQNEZwRkZhaEs1WDU2a2RqTmxLdTZoVjRpekQ0U3NVRWNo?=
 =?utf-8?B?ZlB1RVpxdGFJUXA5SG05NVNVMFdncHpPUUR5UEdRUm9lNEF5NHhpUElOQlFh?=
 =?utf-8?B?RHd2bjBtZElGQlE0Sms5WGZsY3JXa2w5UFZlMHM2cHo4cWhvNDlHd2RsaHkv?=
 =?utf-8?B?ZFlNZndkbllEOHBaMHNDcEk2RjYrMXlJRDlHOHB5eXlDc0xXTjV1a1FBamJM?=
 =?utf-8?B?SVZkTFhWcVFHWXhPN21kaGpXYUt3SFZYK21YSjZ4S000UUl1SFRGVkNpTXp1?=
 =?utf-8?Q?mlH1A/dJF4g42StXyUE2fbQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFdxK2x2T0c3RFlMRWU1K2MvVDhtTmZkbVMrNFhrK1RXOEtJRkhqb1JET0hp?=
 =?utf-8?B?VUtRV2RvajdxNjllTEFGWmxsanJYdExNKzlWQ2ozWW85R0huT2tvQ0hMZk0z?=
 =?utf-8?B?S1c3NFpMbjN0dEtZWElWOHYzYnJWVkh6NEVrek0xbmFTN3pYU3Y2VUpJSjBI?=
 =?utf-8?B?NXVCSUVLVG0wMkhzWnlUWUR5OGFtVXBHbUJsM3RabW9KaTVsdy9HMDBNVDRZ?=
 =?utf-8?B?SUtZa0NmT3BDV1dHQjAxVW5xUnZiK3NGam94MmdmRXcyU01UcWhmZnJxVTJ0?=
 =?utf-8?B?WDhVL1RaQnJMZWQ3T3gyUTFqM1BjRlBFSlhBUS9TQ0wveHNzbWNBVjNqV0ov?=
 =?utf-8?B?T1BmWXRVWkVNWVljOXBpOFBVd0NVblc1UDFQNkw5WVhTc25oU3hRS1ExRURE?=
 =?utf-8?B?WUJKbmFIZEcxVFFuc3I5L0pRSFZaVkRLQUZRVHpPdDFtSWFJMGVKUkdONUpK?=
 =?utf-8?B?anBDeERwV2hnaGlHZnVOZm4yeEtBeGZONWlibXVLcGRsamdDS2NZdE1IMlBN?=
 =?utf-8?B?aEl0UDBuUXVuN3oxUHdGc0l1VDJRdkFJRXJXY3NGZnhRU0czOURBNVVDQVdB?=
 =?utf-8?B?T0pXeXVYRXNUa3hNVEFoOVdpNUNXWWJnNFVjS201MTBic2tXNEpaWkhNZFYy?=
 =?utf-8?B?WEdRZzlTUnFLenZ4UDcyUVRlSGxMcVBWUUgwVEZ1cWRhSHlOU0NscEY3ZUVa?=
 =?utf-8?B?cWUxRmJJaDIyRlBmVEdyc2dSZEM5VmlBK0ZURmpzd2dqREllaFA4WmZBSkFG?=
 =?utf-8?B?dHNRWVR4eVB2bGUvTEI4UEVmV3IzRHJXS3VJb0l1MnN1Mk1lcytWcUF0a2dE?=
 =?utf-8?B?MXBwNzBYZ3p0MkgrZHZtVUhESUNpN0VBQmRCdURJaC9jeWJkNG9EcjZmZkcz?=
 =?utf-8?B?NFlEZjZGY3NORXBXNlN4YTAxbUNPdERRVjRpZlVIWmVVc3FvV0I1dUNaSFZU?=
 =?utf-8?B?KzBwRjRIRHNjbXQxMmo4Z3hOVnJJZUFJQkpNaVppVEEyUmZFbDd3b090L0wr?=
 =?utf-8?B?empUb0d3aHRRbS9zUUk3bFZJa3VVWE5ucnZ2OXdNeU5zeldNdXFwcUVBMnZZ?=
 =?utf-8?B?V1FncUpHeW9XVU52ZkMvY2szWWJBT2dvOUVucUVvbnN1YSsvTThYb01jcFdt?=
 =?utf-8?B?WktJSnFVSmlhamt0eDZXNjBjWjlCN0YyNWZvZUUvZFo4dE5RZEY4YzRVcXB5?=
 =?utf-8?B?Y0xyMy9adjRST2JlZ3phazdoVmY3QlY4RlRyQXVpTXk0L0Y2Um5jZ2lzVWND?=
 =?utf-8?B?ZCtMclowT0JNQmVvRTVZOUI3WEhjVE1uOEVKYWdnUlg1SXpRUVV2TzZSK28v?=
 =?utf-8?B?Yzlha2tYMERDakxYOFpPNHN6RlE1cTcxRDh0cytqempMeEhEOU9PVm5sUDBv?=
 =?utf-8?B?ZjRZNWNJUkZwUnBOYlZld2l1UHl3L3VhUlVaM09tSlcwQ3A3UkJCeTR5SEVr?=
 =?utf-8?B?aU9EK1BKcXE5Q2tPemFwdDR5OTUxaXVWTnltT28zTkgyMUNUUWFQeURKa0Y4?=
 =?utf-8?B?Z0ZXa1I3L2JWeTROK2hoUkdJRisybzBVWGRvM3Q0N3luS2lQUWY4amZiazdO?=
 =?utf-8?B?Wk5CWFlDVlFlNlNCV1F6ZTliNG4xeGhGMGk2RUNraCtXNFY2ZnlGQVEybkVE?=
 =?utf-8?B?M3FDN01tSFZYWUVucU82anMwTWdHWG1hVFFwa2NVRkdiZnFMLzAvN2l5VStx?=
 =?utf-8?B?Lzk5YW04YXdkUEVUMEx2N3BSaXcvSVYzQzBQeDJjRVRYb2dsbEdPMjNoaHRQ?=
 =?utf-8?B?bHBndGZUOFFWdVdTR0swNlRJN2M2NlA3WFJ6N1kvMFRya1cwOFNOVWVCSUpR?=
 =?utf-8?B?a20wRUVRcC9NNjFOSlZYR3psaUJ5OTZCNEFLb2lwL0QvWlhQSUMrcWFCNWlS?=
 =?utf-8?B?WGZUQmZmbzFCWWY5Q2paaWFZa0tkMDlVS2xXSmpNZUZLUlZ4NGlyWW9KTFdU?=
 =?utf-8?B?STB2L3VlSXk0YUxNSitHU0djOWRORFVhTjhqNWdEUGpLTFdWOUhtbjlueCsr?=
 =?utf-8?B?NVIzTy8yOTNTbWJRMWszRXBMZGMwSVNJck8wN25WUUZDOUFXQjltcGpnUWpN?=
 =?utf-8?B?MTRKUy9wUUxYVEU3ajB6OThpbm9ubm1SRjJZdDJSWXA5ZlhWV2dscXBXUXdH?=
 =?utf-8?B?d3A2aVdzcG5yMXk5NUN6OTZIY204Q2dEazR3aEd0V1hMUk02eEs2MWE4Qktn?=
 =?utf-8?B?MllQVHQ4eXU0MzRNZkJNalZqeHZyWis0MGExZkMvaXhWNVpNU3M4Y2dMSExW?=
 =?utf-8?B?N0VYZUZqczBDbUVsT1h6V24rb1VINlNtVTY4NUhjN3Z6eXAzeHVtc2FxWCtP?=
 =?utf-8?B?bFlacHJlZDhNdC9IRWlZaDNqTzhseUx0N2hmZG9RdnBVQTE0V01WVnFiazRO?=
 =?utf-8?Q?riwoJTPPWg9F0FwN0vPqV0IuczHC18NCiAauFrpG5qlSG?=
x-ms-exchange-antispam-messagedata-1: 8FR//E1srGrRGQ==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EInIFXf2sN6m06feVQN/EOJOW4yiYkXcsLhGJZ5BCqfMoFYsDd0RFRiVGMJj2GoGSSBoqjMLaVk1mKU5ssXxN8k+EiP8fnc4EUsmMr0VG+FBIxX4LWDWjuPCFVEiBqmNUZ/yI7AieaQTECxdvyPnO9Pk1TSNdkZX6P4EggRYDj0G9IbzbuGhxmG0m8BchM1Y9yE2CmUP7r6++3PwJs1WqlTScD/hQ2qgxSHKOdyn2UdFL/GfHjLqLDI1x4Cnxs01AI9jhLZB619IatGovCJo8VeG8SOHhoGB4F8ET3dG6rSdPoVP3YoXSt6imaxfa6AnCwCkkUfJlznU//2GHu1WMg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZrrs0OqHmgtLFDRhWlbXQfwIZGn4huwXocl5/DJTM0=;
 b=BI77NoJdepVI0EFx1lg7lejeTVL8s5pF8MrX3+deTLQ3W/3aBagF9u93o65pqBep4h3z+lsgKYZyhnpzcLcMX0MoxNIMPcMzi96xC9hoNGkRG+7oEnArxzbsHY/DBckqQgyhvEolpeKSvV0kFn3vY9b5LMGhAkOVUANq+FD/Fmi6rtYQYA6vxm3BaegXO4HoV/Rvd3INwIHWlqwNHCuKY6+9H6lNpH51QqZHHmOLbGfKkwL3nfUuXLTgNYA1x+Z2YFevm7KnynpfSbfJkVbnbrjuLZ+REHM74WSqklzbThjlZEJmGtghwXY7+WsB6H1q+E//3K0FDDZxjLatJxMZuA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZrrs0OqHmgtLFDRhWlbXQfwIZGn4huwXocl5/DJTM0=;
 b=BgNzTTQC5CgiY7CO0bnbsLCIUwZXyxdOXGV7k89qHIFVPnUMXz2UJZlsaoULDbw6jk+PvI9Fry+YvD2zBA4SPXsINEm4+ol9wRzeWzs2AHB4TzNjTXke2mGLIFdMZHil82U3zk7ZIuzkEywybzSX0qGKFgtOXl2Hqjg1IuHs3fg=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 096cac1e-ac29-4cbc-743d-08de635a8550
x-ms-exchange-crosstenant-originalarrivaltime: 03 Feb 2026 19:29:16.7981 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: k20tRcIp2GmJsmpidhmoe5uED2Qx6EQTUm4r3v9z9XPqLYpuZFEdckUOOSZwjqkzDIogq0pH3ed691bGRYT0VQ==
x-ms-exchange-transport-crosstenantheadersstamped: PH0PR17MB4717
x-originatororg: akamai.com
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA1D9F6C1594EC4086A7A4BB181BC1FC@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 phishscore=0 mlxlogscore=910 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602030153
X-Proofpoint-ORIG-GUID: DhifgJQzI8CKQJq6Fmhv4xqqHI04E3vY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDE1NCBTYWx0ZWRfX9BnFjlOIe6N4
 v8sZfvxE1eM7ke47qkIdZ6QrJGijYab7qvO3ZOynaEbXvAsqBTLGKtbsi5IrDzbGPdHBt2RjjoJ
 Q4QeWJVp3JtG5fUZ0BYwTZKAx3W3R1R/Q47EOc2KOjL3zO31+kZonFOJ+/howTDbwJ5khup7RHZ
 e5KGA7eXkFep6KJBpaCLEp1HKjzH9SFPS+TOEM0PN0Bg5qlWZVnf7nCcUsmrPzGsdWRgYi4jwHn
 vj2hMCEDCDTapsucVOTk9Kp32PYe9q0LObF+1WMNJH/zsdMjryOHDHBe3pTjseVQLny6zvwa66j
 2oM0SSdn4wBWjbIrgj9q/AtGVwwZRrxADsY9TMLXXafXENgKt8WgalPeVXLoDKXFWAjcjRHA3ah
 5ki37hvLMODiF522XeAwEeOjU3LNaZK1eUo7hHOV2c6ggPDAO5kBvgQvQONtph2jZ15rcmuxpps
 zyOCORifGwlqvVUoWwg==
X-Proofpoint-GUID: DhifgJQzI8CKQJq6Fmhv4xqqHI04E3vY
X-Authority-Analysis: v=2.4 cv=Io4Tsb/g c=1 sm=1 tr=0 ts=69824c90 cx=c_pps
 a=3lD5tZmBJQAvN++OlPJl4w==:117 a=3lD5tZmBJQAvN++OlPJl4w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=g1y_e2JewP0A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=qm8-YGAmNVbVkbdaMT0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015 phishscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602030154
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=bchaney@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLSBpZiAob3B0cy0+aGFzX3F1ZXVlcyAmJiAob3B0cy0+cXVldWVzIDwgMCB8fCBvcHRz
LT5xdWV1ZXMgPiBVSU5UX01BWCkpIHsNCj4gKyBpZiAob3B0cy0+aGFzX3F1ZXVlcyAmJiAob3B0
cy0+cXVldWVzIDwgMCB8fCBvcHRzLT5xdWV1ZXMgPiBJTlRfTUFYKSkgew0KDQpUaGlzIGNoYW5n
ZSBzaG91bGQgYmUgcGFydCBvZiB0aGUgZmlyc3QgcGF0Y2ggKGFsdGhvdWdoIHByb2JhYmx5IHdl
IHNob3VsZCB1c2UNCk1BWF9UQVBfUVVFVUVTIGluc3RlYWQgYW55d2F5KS4NCg0KDQoraW50IG5l
dF9wYXJzZV9mZHMoY29uc3QgY2hhciAqZmRzX3BhcmFtLCBpbnQgKipmZHMsIGludCBleHBlY3Rl
ZF9uZmRzLA0KKyBFcnJvciAqKmVycnApDQorew0KKyBnX2F1dG8oR1N0cnYpIGZkbmFtZXMgPSBn
X3N0cnNwbGl0KGZkc19wYXJhbSwgIjoiLCAtMSk7DQorIHVuc2lnbmVkIG5mZHMgPSBnX3N0cnZf
bGVuZ3RoKGZkbmFtZXMpOw0KKyBpbnQgaTsNCisNCj4gKyBpZiAobmZkcyA+IElOVF9NQVgpIHsN
Cj4gKyBlcnJvcl9zZXRnKGVycnAsICJmZHMgcGFyYW1ldGVyIGV4Y2VlZHMgbWF4aW11bSBvZiAl
ZCIsIElOVF9NQVgpOw0KPiArIHJldHVybiAtMTsNCg0KVGhpcyBzaG91bGQgcHJvYmFibHkgYmUg
IE1BWF9UQVBfUVVFVUVTIGFsc28NCg0KDQo+ICsgfQ0KPiArDQo+ICsgaWYgKGV4cGVjdGVkX25m
ZHMgJiYgbmZkcyAhPSBleHBlY3RlZF9uZmRzKSB7DQo+ICsgZXJyb3Jfc2V0ZyhlcnJwLCAiZXhw
ZWN0ZWQgJXUgc29ja2V0IGZkcywgZ290ICV1IiwgZXhwZWN0ZWRfbmZkcywgbmZkcyk7DQo+ICsg
cmV0dXJuIC0xOw0KPiArIH0NCj4gKw0KPiArICpmZHMgPSBnX25ldyhpbnQsIG5mZHMpOw0KPiAr
DQo+ICsgZm9yIChpID0gMDsgaSA8IG5mZHM7IGkrKykgew0KPiArICgqZmRzKVtpXSA9IG1vbml0
b3JfZmRfcGFyYW0obW9uaXRvcl9jdXIoKSwgZmRuYW1lc1tpXSwgZXJycCk7DQo+ICsgaWYgKCgq
ZmRzKVtpXSA9PSAtMSkgew0KPiArIG5ldF9mcmVlX2ZkcygqZmRzLCBpKTsNCj4gKyAqZmRzID0g
TlVMTDsNCj4gKyByZXR1cm4gLTE7DQo+ICsgfQ0KPiArIH0NCj4gKw0KPiArIHJldHVybiBuZmRz
Ow0KPiArfQ0KDQpJIGRvbid0IGxpa2UgdGhlIGltcGxpY2l0IGNhc3QgdG8gc2lnbmVkIGhlcmUu
DQpJcyBpdCBwb3NzaWJsZSB0byBiZSBtb3JlIGNvbnNpc3RlbnQgd2l0aCB0eXBpbmc/DQoNClRo
YW5rcywNCkJlbg0KDQoNCg0KDQo=

