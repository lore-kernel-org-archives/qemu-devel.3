Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D63CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 15:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo1QC-0003Gr-7Z; Mon, 18 Aug 2025 11:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1uo1Q5-0003Eg-D7
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 11:05:09 -0400
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1uo1Q2-0000Md-Tn
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 11:05:09 -0400
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
 by m0050095.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id
 57IF2wnx019457; Mon, 18 Aug 2025 16:05:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :message-id:mime-version:subject:to; s=jan2016.eng; bh=+fus9OJVA
 n+E+fifI+iRTJOX7UQtURQ/0u1O1dzO5JM=; b=mYBMqDN8GjdxL+yseQ1hiL4Gg
 14w6h7fgjC3WyU7qUyel2JqhXR7lN7FkHIrBjsjuu4EcBadu0sIxczvQWPZaMrlD
 ejeqK8L18RlXEMJPSbzoHvrcxvRBj58mmo7Qd5jo+rL7ZJU3k4yIaZ7g5Ltim5vR
 G9phlE4TDhJFGUeabFGopZ97pqLmTZonEIz5DK1Zq7b7xLj+0hxFHYcuSZDZ724u
 e16djDObuk1Sn1RU6WkG5ykEh99LLbnyQ9vpOhQEXsdko0NWJFnaILCHLLPlgmWm
 iWOdaTWOZIf6+D8jE4bHwQAqM+asQiRldpHz6L8zQUJwWL3JQ2oKUrDkVIAMA==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
 by m0050095.ppops.net-00190b01. (PPS) with ESMTPS id 48m6fg00fv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 16:05:01 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
 by prod-mail-ppoint2.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 57ICFwUk014532; Mon, 18 Aug 2025 11:05:00 -0400
Received: from email.msg.corp.akamai.com ([172.27.91.21])
 by prod-mail-ppoint2.akamai.com (PPS) with ESMTPS id 48jnaxg0uy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 11:05:00 -0400
Received: from usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) by
 usma1ex-dag4mb2.msg.corp.akamai.com (172.27.91.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 18 Aug 2025 11:05:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (184.51.33.212)
 by usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 18 Aug 2025 11:04:59 -0400
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by SJ0PR17MB4480.namprd17.prod.outlook.com (2603:10b6:a03:29a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Mon, 18 Aug
 2025 15:04:58 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95%7]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 15:04:57 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Steven Sistare <steven.sistare@oracle.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "farosas@suse.de" <farosas@suse.de>,
 "hamza.khan@nutanix.com" <hamza.khan@nutanix.com>, "Hunt, Joshua"
 <johunt@akamai.com>, "Tottenham, Max" <mtottenh@akamai.com>,
 "Glasgall, Anna" <aglasgal@akamai.com>,
 "Harnett, Dan" <dharnett@akamai.com>
Subject: Re: [RFC V2 0/8] Live update: tap and vhost
Thread-Topic: [RFC V2 0/8] Live update: tap and vhost
Thread-Index: AQHcEFF2OW1cv5PMKkaucPF70+xKUQ==
Date: Mon, 18 Aug 2025 15:04:57 +0000
Message-ID: <4370E749-04FF-4B85-BF6C-B24A3A3575DE@akamai.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|SJ0PR17MB4480:EE_
x-ms-office365-filtering-correlation-id: 85b7460d-a4ea-4d96-8c79-08ddde6898e1
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?V2pvNlJaRUkreWxnNXlCSTR4Tk1qenE2SDhsSzRNWkN4WExQR2tlTXc3cktV?=
 =?utf-8?B?OEUzTnJMZFYzaFRkL3B0eU5ucW9LTWV0OW5uSzJzemVwVDRLamlRUXduNnhp?=
 =?utf-8?B?ZFEraG45T1NiZUs1ZXBDY3YxcUphQmF6a3dFSU5JVlM3Z2VwWDdpcG8zSitM?=
 =?utf-8?B?RDUzc05iOUhEWEhGak5wcVFmVllNT3h3anE5MjNzQThZOHk1VXcrUG5XQ0x4?=
 =?utf-8?B?ZUtaK284NkViMytadjVYSCtoZmF0Z2xzR21FWm5ONVkwMTlLZk9NY2lpeVdN?=
 =?utf-8?B?MGhhNVhMYk9qdk5xQXR6WHliSXdaNERFcWNDbTNqaTJxVURXUlR5VjNaYXA5?=
 =?utf-8?B?czJJMmhKdEl5UFJha1Mxd01HUjlkSUlLb21LM3ZhaS9NODh0WDFoYWtFQklN?=
 =?utf-8?B?YThSU0dsSVhOOGNPNUtOemptQ0JUVFpWY0JBTkJ1OVREY3B0V29TWUJuUmor?=
 =?utf-8?B?anNueGFhcDRaQ3hXcEJqSmJ4dnlkRXVCM2xyY3JwQ0J3dm9ZZW5yMzlVd3lO?=
 =?utf-8?B?aGZhOG9EV0FxNlFBbGl2aDlXSWJlVGtUNmZ5a3lXWElQNHdMSTBIVmtkc3c4?=
 =?utf-8?B?elBRY3NMeEYvZHp5UW9vNEt0UDQ2dk5PNzVlb1haaGJZRllNWTREL0YyYWJl?=
 =?utf-8?B?dWtpS3M0VTRpZXNhRGlBcUN4VE8yODNiZXlzWDNRR1JXZVI1V0hHbVpGemtw?=
 =?utf-8?B?Wkc0NVExclhDaGR1ckUrWXcxakpLaE12VVBkVnBUajJyUlM4N1VDcGluS2s2?=
 =?utf-8?B?QjBWRTcyNms4dnAvZTE4ZDd2a0x4ekdDVlVsZDJCbGo4T3YxOFhMb0FkZ3h5?=
 =?utf-8?B?bndTVXMrR3ZoMVZSN3JxNUhkQ3VGamUySytXOVY4SXJnRUQrVHdWNVNjM1J4?=
 =?utf-8?B?TG1pRURzTkNMUmxkVmtFMUdKbHBoZnpSNGw4cmZRTEh4R2lBNDhDWk9oNSth?=
 =?utf-8?B?ZEJNNFJWVEdyVEhWU09acTkwaGVXWmszOEhHN2JFYWM0UUdFbVJSR1lSSFlW?=
 =?utf-8?B?NXpIc0w5TFVyMklNaW4zcTZ6NWhSeXBIa0hrQmRSY3VQM0sxUURvYUp6WXcv?=
 =?utf-8?B?R05FZDhxV2pBQm1VdmdpVUFLMVZHbEdxSCtlUi8zZW5iUkxUQXRjem5nUzJ1?=
 =?utf-8?B?TVJITVljSkl1ZDRQeXVUZDQrb1FjZFZhWURVRERFUW1nVUZ3OHg1dW85Q2ht?=
 =?utf-8?B?OS9OUllNU01pZ281aTJCdnFxZHNIdkcrR0QybXY0aUxHNTFlQ09SRTdEUWcy?=
 =?utf-8?B?WkZyTXV1ZmticzZXNW1mRzZsdDJyV1IrZzRRaXFLdFVCRUVDTWhPcDVDMVdO?=
 =?utf-8?B?WTJ2VStxMWVPR0ZKSGc5My9uRzhjZWdvbDV3UlljRldWd1l5cDArZ003Um9l?=
 =?utf-8?B?VTIzN2NWcFRxZkUrdWFOelREYnNNTnEybU14bmxPbWtnaG0xUVJ1WnpPdDY1?=
 =?utf-8?B?cFZ0a0dodU03SU5QdXlHNTNmREpFUnVVMGZyMmI0K3QzM2pRUXEvY2E4SFkr?=
 =?utf-8?B?NXNPMXNHSE01K1gwOE13UGN4Szkybnp0ZUMzaGtoNGt3TXdXbkFEK0l4RE5w?=
 =?utf-8?B?K2x6MmR0ZjIrMlNDNDhjOXZOc2l2QThkVFNHRmlIM2VmYUI0Q2ZYVkpqc0N5?=
 =?utf-8?B?T3hqT2NobmE0UmhRTW8yaElXdXE0TzdDVkhCYjltWFBUMGpyRmc3QmdIMGRo?=
 =?utf-8?B?eDVpNDVLak8xWWkrWEtWWnpDcm9zTml2VVRvOXg1bkV0ZDJyNkhUalFiY01E?=
 =?utf-8?B?a0RrenFuT1NDVWgvZ2graWUvK3poNHlyWVcxVWhYZi8vRGhvRHJoZG04YVFr?=
 =?utf-8?B?UitqS3I3em1LaTZpQWVZaU83b3RDSWVweHkrRGVFTVk1c3lTNUdQbkF1c0E1?=
 =?utf-8?B?dDhoOE5vMStZd0tnazVuaXFkblNnSWZXOUZTOTVmUFBOcGFPNkJ2aGFSNzFV?=
 =?utf-8?B?V2pGV1NOOEEzeXhCQUd3aEFPdnJCdlB0TlB1ZGQ5YWp2aXN6SFdTWEpCbmFO?=
 =?utf-8?B?Q1BtTkpQTzN3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018)(7053199007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NitqNUxTMzVUTWFVTnhhS0E0bGNUcStHTUdXZkxMdnhjQjZjNlNwajJoam5D?=
 =?utf-8?B?QTM5TlpLN1JnY21WZ29NWjk2ditOa3p5cDJ2dG1iKzR4UzVnS1RuRE1VZkp2?=
 =?utf-8?B?cTVRNkcxcDlodW15U1VMZ00xd0RFUHlqcmRld2hSb2VLbXBBMDdzR3d6SDR2?=
 =?utf-8?B?SmVMS29IUXJXeFM2MVFVNndveFFrODRTbDdQNTNZYnZ6MVhZdTJkTitxMGRz?=
 =?utf-8?B?cjhhRWpJT2VHU1YxdVN6aGtIb0t1c1dEU2FQRG45SkRBcU91SHNQL3RFeWh6?=
 =?utf-8?B?YWExdHFLSmhveWFTeURRSUFZbTRFR2lvS1Z4dHljN0tKNStTWDZCZUxwZXBX?=
 =?utf-8?B?UE5sTzlOWGNETGNieFBWZTk5c0cwN0d5OGY5RjZpVHhPcERVTVkvSS9KZXZM?=
 =?utf-8?B?bGNKbFNsdTFWQittWUFMdHFNYWlzN1dVc1N3VE9wY2RiRWZzbkVCcGdvRk5h?=
 =?utf-8?B?bVFIV04rVkJjZS9ueG1ubjZhelVLUURvM09OZmRlSVJWMnZRNmdsWEUySGhV?=
 =?utf-8?B?RzcvU24xczFTUW0xNzhUVlI5VmtRQVhKNTFMQWx1R3dIcTdTRnM2emkwYlpU?=
 =?utf-8?B?RU1NTGxpcUhDTFV0c2hBSi9oekRzTUJVcUxNY1NEM2ZpSDdvRXZtRjRLZjZm?=
 =?utf-8?B?RDVNdk0wWHMzYTJWOXZqczFZaEEzMG1BQ3R6SythUGw2eFg1M0tZek05SzRH?=
 =?utf-8?B?ZU0xZERoNEN0bm9LenJ2d3BrWVVxVTlyVlBwOGJqZWluNVJsMTN3R21JdXZ5?=
 =?utf-8?B?NlRLL0s0U3U4TUdrWDIvV0lTdmlhdTVhckxxVEc1TTFLclFTS1J4aEhSWVdH?=
 =?utf-8?B?QzJlN0dwZGtxb2pERGh1WjMrWkdxaEtMS01BNCszV25TY0Z1Slp2ZHlwWFlL?=
 =?utf-8?B?Q2FCbllWUUhUdFozOXJ3WjZnNFVhZ2piTWFlcFdqVnE4clVEZFZlbFF5Q0Rh?=
 =?utf-8?B?Q1lLdlNLenNydEhvL1lmUDgvdjI4S1FMajJKbDV5NlRSQXFnNGMxdjJJZXQ0?=
 =?utf-8?B?RVJqUFdYSW93Vncya2FiclJuK2VZa2FnYlNSNVEvVDBLUDBFa3Y2OFpNNXQ2?=
 =?utf-8?B?YW9IcDdkRkJ6djl1cE53VVV0UnVYWi9EekxoNUZJM0R4U1phRHlBa0MwbXVX?=
 =?utf-8?B?amUvd1Nkd0k1UENxeGIxU1hBSXZONG1jeE5RZ1pYQkUvZkRLZ2xweC9YUXZq?=
 =?utf-8?B?NEhacHYxeWpDK2F6WTRNTHc4WDQyci9IYXZTMm1lUjNJUzl1Zk5HdHNSMzJ6?=
 =?utf-8?B?Wnh3c1NCRmVmK2VveWRoVjZyRkR6TGQ0VTNLVVhFQldtZFVxQWUvc0lja1U2?=
 =?utf-8?B?enRobWs1Nml2OVBja1BoeHA5enFkY2lYSHlUTkhNZzNDZzExV2lOSlg3YzN6?=
 =?utf-8?B?OEdkMjQ2NnBsbTVQVXg1SWxvNG9jM1UxMzJHS2RqdHVqZ0ZTaExxaEU3NjJ1?=
 =?utf-8?B?YTZGcVRlelRQcUZSbjFpV0lINUs3UjJlRnBZeDhrb01XL0dXUG41a3JBVWRT?=
 =?utf-8?B?U2gybmxaazZiaXNncmNYbStaTStxMlgyMFEwVUVlQkpETkZuTGUwUS9vaUFW?=
 =?utf-8?B?MExFekpRZDBiUWUwZlNJZXc4WXlYa3YwRDR6djgraUNzZmVqYWw5NDMyYVFT?=
 =?utf-8?B?dGp1OGFDWW1qQ1JUL25hNC9QWndZc01haDRxbnZjdlo5NDU5WTBuUHhuelFn?=
 =?utf-8?B?WFNtRjVZbWxjRVNmeTRZNGRYdDRid2NGelZNZndpK0h6MkxrT0V2MTZOclMy?=
 =?utf-8?B?YXRXOThWNnNwTTB5Q2pOdlgyQ0xyUFUxMHdiL1ZzV2FIQU9oQkNwYThTUlI5?=
 =?utf-8?B?TnJGd0hpa2x1OHIvM3Z2U21iclhwNEtYanZIbnN1OHl2eTM5TCtBQStBSnhT?=
 =?utf-8?B?bjRiVmh2T2VpaW9wMTQyNm41M3ZEUFlQWlJ5Y1FuZFQ2SkhuTzFOeXlqSHFk?=
 =?utf-8?B?TWR3NFMzd1FqenliRzI3dHJ2bGhxYncveE83V3FOOTZmZFJwUTdGZEczREY0?=
 =?utf-8?B?OG9nYlRmSkFMMUNIZHFtWTRhSnRtbFpueld2UzlCY0tkcWFCYUN2d0d0cVNI?=
 =?utf-8?B?MStIaG0ydEgvZlVBdDNmdVlDRDYzaVUrem5qNlR1a04wZzZEVVlvUnVpYVo2?=
 =?utf-8?B?WmxGQ0xHeCtkanlxcXRRK1Nnbkp5amhtM25wTE5ZUVNua1JOMjRFL3R0aStO?=
 =?utf-8?B?OHRqVytLNVlTR3psTVUrZFppSTR1d1VlR01TZ3dCUGZ6d3ZYUjBJb3dBbFBs?=
 =?utf-8?B?QWVhbXhrVThzNlNMeGdMZ0VwTEdRPT0=?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xjsr6Wl2dQzISoltMdgqts+m7T62ccCR0ukCPbwOPpCHUrj6X5yplfvl+yD0m/X1+sHU7e+lbnxjapgaa6w2Vxzg02p/OfUdU4hTa9PZY2IfZMV/hzJLm7kGJC31l6BJ16jDICBKZLwmYhRu8287WGwE5C/QFRsOaPhm+quZkawZbwtojUSFYZ3N/gkDJ/GeHYNvbG3/yTQvfuP1Gy/Q00zqkHjTkuFQUF4ZfD2us+k0pBTqI1NTAU3yRq28H7qsnCbxXalI4GGGOpijZ/MQGbd/YB6qrq5ZFz7kp3aKWtLxY69K7RTV3aSTCYcYcJPKjtjI5YVywqxIgNOiZbMNLA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CowVkrq8/Tqa+9IwVbPEi5esj+0BUAfnqYx46G+nMAg=;
 b=fVFdjj955H6q458R8NKhOoeYX8cH1fOSr9rEIcG+u96A9B8x6Ek4tdG+nVypke4dOp7P6y4L/OjUXoGRfOXXxEVuseJ22TPnpXmZEms85LJPVjzHVdInZPxLAGRg4IqsIqd0k3AJz71wSxEJa5ytnOHXaZnwI0G06ERB95dGpmtzcANZOY19M3uogfI5GdXLl9i2ptF86dK7Iqf11gHBjoeljQmijCxqg21ipt6Bfmhloj91URqdOV51crWt5Xwk+dVuybRYvCDwrs/9qa4JUi+yvwIC0z/P72d+yVydD7/d4AP/iHRuU9AmZiLYLyXn80xXIVD4KYUMatCAClVy3g==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CowVkrq8/Tqa+9IwVbPEi5esj+0BUAfnqYx46G+nMAg=;
 b=fPjuAVkwgc7wPovu2MNJA8e20ZA8gxqGzrKZDVLTlFBuUmofPBM5eyizQAVVvbhrxOklYAcYkQGYrFCOcvLu0Jbvi0nsn6IAifFYSgKlC1Q3YQLKt9QXkvQlu4O56GQ+x5V9OzNMqUORGJJp/0+QCQZxe9MfHL31P+8eKmcac/M=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 85b7460d-a4ea-4d96-8c79-08ddde6898e1
x-ms-exchange-crosstenant-originalarrivaltime: 18 Aug 2025 15:04:57.8809 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: CXxgdtFAE12JDl9V49D7ORp5Xa3rvDhM57MWIEWu3rodQ/MecRT2I1AcFaxk63HZgl2IyHBdUI40pb/f9kvmzw==
x-ms-exchange-transport-crosstenantheadersstamped: SJ0PR17MB4480
x-originatororg: akamai.com
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAF40DD93138A5469FF716ADA016E741@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508180141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE0MSBTYWx0ZWRfX1AQUYSNTyuZ+
 TvmYQTptT/0BM4wR429V5+l+aEh0hy41vTyih/adx1T8lknfcpfnChb6lFxEopy7pqPaChuAe2F
 26htrl3iswVuQwxMQw3vLxWDMkkqc0qjQLuojS2xje4/MdbW8L9M5hnVEM3alB0cqD7DBVgVAU5
 JeYTdpp7wBRA2LQ7bx0eQe+oUqPJwiIhhR5xNyVlKS/pw1CpEhxtwVkoGS5tIzBHvrsHKMT+Db5
 c/alTmyCO1Z+1fwPa4pPmrXqWNl9eicxFv8k0WxapHSrJUosBYn7HZKNz0DZ48vm7kTIC5B2Y16
 20hxE9pmny3ZOuTehPqoXGe6Z4FdRR5Or5+igbhzAPtExEehiOOyE0I81scpbd+aknfGZ1s6LCA
 G8AXdSjK
X-Proofpoint-ORIG-GUID: ArJIXRY-EJc6dOQAdKJkS-kN_1TdH4IT
X-Authority-Analysis: v=2.4 cv=Rr3FLDmK c=1 sm=1 tr=0 ts=68a3411d cx=c_pps
 a=BpD+HMUBsFIkYY1OQe22Yw==:117 a=BpD+HMUBsFIkYY1OQe22Yw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=g1y_e2JewP0A:10 a=yPCof4ZbAAAA:8 a=bIdf9muXvC-gcXBdo9IA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ArJIXRY-EJc6dOQAdKJkS-kN_1TdH4IT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 phishscore=0
 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508180141
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=bchaney@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

IHN0ZXZlbi5zaXN0YXJlQG9yYWNsZS5jb21Gcm9tOiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lz
dGFyZUBvcmFjbGUuY29tIDxtYWlsdG86c3RldmVuLnNpc3RhcmVAb3JhY2xlLmNvbT4NCg0KPlRh
cCBhbmQgdmhvc3QgZGV2aWNlcyBjYW4gYmUgcHJlc2VydmVkIGR1cmluZyBjcHItdHJhbnNmZXIg
dXNpbmcNCj4gdHJhZGl0aW9uYWwgbGl2ZSBtaWdyYXRpb24gbWV0aG9kcywgd2hlcmVpbiB0aGUg
bWFuYWdlbWVudCBsYXllcg0KPiBjcmVhdGVzIG5ldyBpbnRlcmZhY2VzIGZvciB0aGUgdGFyZ2V0
IGFuZCBmaWRkbGVzIHdpdGggJ2lwIGxpbmsnDQo+IHRvIGRlYWN0aXZhdGUgdGhlIG9sZCBpbnRl
cmZhY2UgYW5kIGFjdGl2YXRlIHRoZSBuZXcuDQoNCj4gSG93ZXZlciwgQ1BSIGNhbiBzaW1wbHkg
c2VuZCB0aGUgZmlsZSBkZXNjcmlwdG9ycyB0byBuZXcgUUVNVSwNCj4gd2l0aCBubyBzcGVjaWFs
IG1hbmFnZW1lbnQgYWN0aW9ucyByZXF1aXJlZC4gVGhlIHVzZXIgZW5hYmxlcw0KPiB0aGlzIGJl
aGF2aW9yIGJ5IHNwZWNpZmluZyAnLW5ldGRldiB0YXAsY3ByPW9uJy4gVGhlIGRlZmF1bHQNCj4g
aXMgY3ByPW9mZi4NCg0KDQpIaSBTdGV2ZSwNCg0KVGhhbmsgeW91IGZvciBzZW5kaW5nIHRoaXMg
cGF0Y2ggc2V0IEkgdHJpZWQgdGVzdGluZyBpdCwgYW5kDQp0aGUgbWlncmF0aW9uIGZhaWxzIHdp
dGggdGhlIGZvbGxvd2luZyBlcnJvciBvbiB0aGUgZGVzdGluYXRpb246DQoNCg0KMjAyNS0wOC0w
N1QxODoxNDozMC41NjQzMjNaIHFlbXUtc3lzdGVtLXg4Nl82NDogY291bGQgbm90IGRpc2FibGUg
cXVldWUNCnFlbXUtc3lzdGVtLXg4Nl82NDogLi4vaHcvbmV0L3ZpcnRpby1uZXQuYzo3Njc6IHZp
cnRpb19uZXRfc2V0X3F1ZXVlX3BhaXJzOiBBc3NlcnRpb24gYCFyJyBmYWlsZWQuDQoNCg0KQW5k
IHRoZSBmb2xsb3dpbmcgZXJyb3Igb24gdGhlIHNvdXJjZToNCg0Kdmhvc3RfcmVzZXRfZGV2aWNl
IGZhaWxlZDogT3BlcmF0aW9uIG5vdCBwZXJtaXR0ZWQgKDEpDQp2aG9zdF9yZXNldF9kZXZpY2Ug
ZmFpbGVkOiBPcGVyYXRpb24gbm90IHBlcm1pdHRlZCAoMSkNCjIwMjUtMDgtMTVUMTQ6NTA6MTYu
MDI4NDk0WiBxZW11LXN5c3RlbS14ODZfNjQ6IEZhaWxlZCB0byBjb25uZWN0IHRvICdtYWluLnNv
Y2snOiBDb25uZWN0aW9uIHJlZnVzZWQNCjIwMjUtMDgtMTVUMTQ6NTA6MTYuMDI4NTUyWiBxZW11
LXN5c3RlbS14ODZfNjQ6IHZob3N0X3NldF9vd25lciBmYWlsZWQ6IERldmljZSBvciByZXNvdXJj
ZSBidXN5ICgxNikNCjIwMjUtMDgtMTVUMTQ6NTA6MTYuMDI4NTY1WiBxZW11LXN5c3RlbS14ODZf
NjQ6IHZob3N0X3NldF9vd25lciBmYWlsZWQ6IERldmljZSBvciByZXNvdXJjZSBidXN5ICgxNikN
CjIwMjUtMDgtMTVUMTQ6NTA6MTYuMDI4NTc4WiBxZW11LXN5c3RlbS14ODZfNjQ6IHZob3N0X3Nl
dF9vd25lciBmYWlsZWQ6IERldmljZSBvciByZXNvdXJjZSBidXN5ICgxNikNCjIwMjUtMDgtMTVU
MTQ6NTA6MTYuMDI4NTkwWiBxZW11LXN5c3RlbS14ODZfNjQ6IHZob3N0X3NldF9vd25lciBmYWls
ZWQ6IERldmljZSBvciByZXNvdXJjZSBidXN5ICgxNikNCjIwMjUtMDgtMTVUMTQ6NTA6MTYuMDI4
NjA0WiBxZW11LXN5c3RlbS14ODZfNjQ6IHZob3N0X3NldF9vd25lciBmYWlsZWQ6IERldmljZSBv
ciByZXNvdXJjZSBidXN5ICgxNikNCjIwMjUtMDgtMTVUMTQ6NTA6MTYuMDI4NjI5WiBxZW11LXN5
c3RlbS14ODZfNjQ6IHZob3N0X3NldF9vd25lciBmYWlsZWQ6IERldmljZSBvciByZXNvdXJjZSBi
dXN5ICgxNikNCjIwMjUtMDgtMTVUMTQ6NTA6MTYuMDI4NjQxWiBxZW11LXN5c3RlbS14ODZfNjQ6
IHZob3N0X3NldF9vd25lciBmYWlsZWQ6IERldmljZSBvciByZXNvdXJjZSBidXN5ICgxNikNCjIw
MjUtMDgtMTVUMTQ6NTA6MTYuMDI4ODQ0WiBxZW11LXN5c3RlbS14ODZfNjQ6IHZob3N0X3NldF9v
d25lciBmYWlsZWQ6IERldmljZSBvciByZXNvdXJjZSBidXN5ICgxNikNCjIwMjUtMDgtMTVUMTQ6
NTA6MTYuMDI4ODU2WiBxZW11LXN5c3RlbS14ODZfNjQ6IHZob3N0X3NldF9vd25lciBmYWlsZWQ6
IERldmljZSBvciByZXNvdXJjZSBidXN5ICgxNikNCjIwMjUtMDgtMTVUMTQ6NTA6MTYuMDI4ODY4
WiBxZW11LXN5c3RlbS14ODZfNjQ6IHZob3N0X3NldF9vd25lciBmYWlsZWQ6IERldmljZSBvciBy
ZXNvdXJjZSBidXN5ICgxNikNCjIwMjUtMDgtMTVUMTQ6NTA6MTYuMDI4ODgwWiBxZW11LXN5c3Rl
bS14ODZfNjQ6IHZob3N0X3NldF9vd25lciBmYWlsZWQ6IERldmljZSBvciByZXNvdXJjZSBidXN5
ICgxNikNCjIwMjUtMDgtMTVUMTQ6NTA6MTYuMDI4ODkzWiBxZW11LXN5c3RlbS14ODZfNjQ6IHZo
b3N0X3NldF9vd25lciBmYWlsZWQ6IERldmljZSBvciByZXNvdXJjZSBidXN5ICgxNikNCjIwMjUt
MDgtMTVUMTQ6NTA6MTYuMDI4OTA0WiBxZW11LXN5c3RlbS14ODZfNjQ6IHZob3N0X3NldF9vd25l
ciBmYWlsZWQ6IERldmljZSBvciByZXNvdXJjZSBidXN5ICgxNikNCjIwMjUtMDgtMTVUMTQ6NTA6
MTYuMDI4OTE2WiBxZW11LXN5c3RlbS14ODZfNjQ6IHZob3N0X3NldF9vd25lciBmYWlsZWQ6IERl
dmljZSBvciByZXNvdXJjZSBidXN5ICgxNikNCjIwMjUtMDgtMTVUMTQ6NTA6MTYuMDI4OTI4WiBx
ZW11LXN5c3RlbS14ODZfNjQ6IHZob3N0X3NldF9vd25lciBmYWlsZWQ6IERldmljZSBvciByZXNv
dXJjZSBidXN5ICgxNikNCg0KSSBzdXNwZWN0IHRoZSBpc3N1ZSBtYXkgYmUgcmVsYXRlZCB0byB0
aGUgZmFjdCB0aGF0IHdlIGFyZSBkcm9wcGluZw0KcHJpdmlsZWdlcyAoLXJ1bi13aXRoIHVzZXI9
JFVTRVJOQU1FKSBhcyBjcHIgdHJhbnNmZXIgaGFzIHJ1bg0KaW50byBvdGhlciBpc3N1ZXMgd2l0
aCB0aGF0IGluIHRoZSBwYXN0LCBidXQgSSBoYXZlbid0IGZvdW5kIGFueXRoaW5nDQpjb25jcmV0
ZSB0aGVyZSB5ZXQuDQoNClNvbWUgb3RoZXIgaW5mb3JtYXRpb246DQoNClRoZSBmdWxsIHFlbXUg
YXJndW1lbnRzIHVzZWQgZm9yIG5ldHdvcmtpbmcgYXJlOg0KDQotbmV0ZGV2IHRhcCxpZD1uZXQw
LGlmbmFtZT10YXAuNzk4NzQ0MTFfMCxzY3JpcHQ9bm8sZG93bnNjcmlwdD1ubyx2aG9zdD1vbixx
dWV1ZXM9OCxjcHI9b24NCi1kZXZpY2UgdmlydGlvLW5ldC1wY2ksbmV0ZGV2PW5ldDAsaWQ9bmV0
cGNpMCxtYWM9JG1hYzEsdmVjdG9ycz0xOCxtcT1vbg0KLW5ldGRldiB0YXAsaWQ9bmV0MSxpZm5h
bWU9dGFwLjc5ODc0NDExXzEsc2NyaXB0PW5vLGRvd25zY3JpcHQ9bm8sdmhvc3Q9b24scXVldWVz
PTgsY3ByPW9uDQotZGV2aWNlIHZpcnRpby1uZXQtcGNpLG5ldGRldj1uZXQxLGlkPW5ldHBjaTEs
bWFjPSRtYWMyLHZlY3RvcnM9MTgsbXE9b24NCg0KSSBhcHBsaWVkIHlvdXIgcGF0Y2ggb24gdG9w
IG9mIDcxMzYzNTJiNDA2MzFiMDU4ZGQwZmU3MzFhMGQ0MDRlNzYxZTc5OWYNCkkgYWxzbyBhcHBs
aWVkIHRoZSBwZW5kaW5nIGFybSBpbnRlcnJ1cHQgZml4DQoNClRoYW5rcywNCiAgICAgICAgQmVu
DQoNCg0K

