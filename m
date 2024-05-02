Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A406C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YNI-0003fG-Cy; Thu, 02 May 2024 11:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNG-0003db-0G
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:30 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNB-0005z0-Uk
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663766; x=1746199766;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=PMN2/YZ4hr8ioAnlB9SWX5lZ5wPmzGuhK2ljrPklk+8=;
 b=LfYj3qWUWMQfn8hDwFLQp5aoQFHb8qE3vpOoe1AFMwPIVcCrA37lW4NV
 +vvHXxZo6ZCY41hk1sKRTYX2jJ5OFhFyDEZCoSM9P36rRu90EqTLVwPW0
 2+Hlqz6Mq9YYppWsKTFMI52mG8HouvrVmqzBqKLqJmnRIQ5tUyadBrKcM
 4IWvN2dAIsu7ZXNgbcWHX91pOnBVeIywJcmSnB9GvNRzvIErfgXsVOaQX
 u8bOPFFYLRmu3Za3YX54xvhlYMpr5P59V0aim3KkiKnHFc5QYydBnpDfR
 AQBEBqzmQuCmA4O9mnt00Wul9jr5FInh2b3JgjJtQUDfsFehJuchHtS1O Q==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11785874"
X-MGA-submission: =?us-ascii?q?MDEQ6+YV/wSmIPgAVcEG9NT8iFl5dXWIwJMnMk?=
 =?us-ascii?q?JaFz4GI8QYyM9c9bObEQSf9FRTGeGXQDn/IIPbzwCdfVmnqN20uyfcFx?=
 =?us-ascii?q?S1gJvR5ZMFJ4gfuPdip0Mub6zRJwPFx9MV03GTETU7e738+JSpGlgx9c?=
 =?us-ascii?q?dEt/0TjHWUFoPU3UabGmPF/Q=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:18 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0c5BYN+8d9hJ6wDwoLkxFFRZf+TcXqGypw4BxrGRDQrcEkyz5bn7H2xLysjghagX8U8I3Imm0XmnjxsOypprd5IA9aLAFhjsrtcxDhneytudKDPPj4CtfBYlDXUYIyyeCKP3mFR/KoJyNWcy6KLSJs2lwuSySrwp+qcB3IqPYKgjlUexd6BddYxbLhqOfQKBBU7ZGQ/x56iIC1Jmv1LwzmDJhncM4LxoXkZESFQOEwM1XSk62SQfY2SWfPPt29FI8H5pHOByabIiX+G0l8W+N6X+BQv4oAC+1LyqTscDecVV4gcoN8lNeHMnaQQqPMimYTTlRBE1ExAxi4KF/UBTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMN2/YZ4hr8ioAnlB9SWX5lZ5wPmzGuhK2ljrPklk+8=;
 b=DKmf2fCSQtrm+A2eIxj0SNL/9oo4rszlMvSorqfgx/peaK28ZG98YK5gsFu9kjsfIqAZPXhHCrdxThNCOBfGoYwmkiG9M81gTqWBGOZ3B88OQ5+Z3BqzdatbN6Y+MVtFOd4HAC0tJ6rmiKgIvUMPjSEN4xXY7ngA3Xo6UcIZ488V3SCUJhuSyG8yHj2+Cri91z9L0m8j/ec2zhxVoSdTK2eqBm49kBsindgHbec2mjYJestvMUZvPK/Hr3WbwcX/kayPyIZDbBIOEsvrunfvp50u+mrVbhfTbMD6DxyTE/5bgnBMxpykDR7ONa3ooYG2OsNEeXdfeXkihAYkreNyIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB9661.eurprd07.prod.outlook.com (2603:10a6:102:389::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:17 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:17 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v1 02/24] intel_iommu: make types match
Thread-Topic: [PATCH ats_vtd v1 02/24] intel_iommu: make types match
Thread-Index: AQHanKV+D17/DXjLQk22A8eEISz9PA==
Date: Thu, 2 May 2024 15:29:17 +0000
Message-ID: <20240502152810.187492-3-clement.mathieu--drif@eviden.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAWPR07MB9661:EE_
x-ms-office365-filtering-correlation-id: f2adef8a-e8a1-4d6b-8da2-08dc6abca13d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RzMxSFA2ZERHbWdzcDR2ajdQa1FBTjNMODkwRGlGYWVFc3dvY0VJcW54b2lP?=
 =?utf-8?B?L3JkM1NRZXVZQWg2YlNZOEV3cWxHMEtTeFBzeFJ3M1VoZ0dNOTRheXk4TDJ1?=
 =?utf-8?B?TkZhWjVqaXpnVkI0eWpqa3NWSWNHSGd1a1g0azk4aWk1Q0Uvc3BMSDh5dzdG?=
 =?utf-8?B?aDVvWTA5clV6b1lGR2lNWVZJMThtTHQ3UnNQUU5leFRWODNjY3R5WVRLc1BF?=
 =?utf-8?B?aUVrSHZBODl5QXZCakFobWcrNWRHNkdIcVQ2YkJTS2M5c1owR2tqQ2VxQU5j?=
 =?utf-8?B?NVN3YnJzY2xEb1ZBSy9yV3RDclJ6ZnQxeDM2OVVGL2hHeFZKVGM3bnBwbWdG?=
 =?utf-8?B?R0xubnRTSzc0U01pOW1ibTJBWFdvQUlVUUYva2FmYTNYSWIza29vQUhHdzVq?=
 =?utf-8?B?azdyOWFuMVhWWi9xb1BreGkxNTNqY3Y3TlVDV0czYWR3SzNTSmd5cnZVK2Nz?=
 =?utf-8?B?SUpGalJaMWJOYW1heG1PMXBUaittN21sZmQ5ZEZkOFdVZmxDVU9yNVIzZTNS?=
 =?utf-8?B?cExQbjZYS0YxZXhPTk9penFkMGQ4TTU3TWVPNGNWNHRjRlJ1dythNHFhc0JR?=
 =?utf-8?B?OXlZdW5Kd3M3Z21PZW1ZTkZ6TEY2WTZaaGZBZHNucUpIa3ZSNWR2VWpha013?=
 =?utf-8?B?NXNQYkFQOEZlb3UrdnNLZ0NJMm5nakoyWlQ0cWgvTmp2VWcxY2hVTjB0SEJy?=
 =?utf-8?B?YmRPR2Vsd0VjNWJnR1ZqRG9uWVUyRkJ2WTVlYjEzNmh5QWQ4NjF5eVNsZ214?=
 =?utf-8?B?L21MRVhUbkF0Q3kvZVBWcjQreTUzY3NNUlNVUm03UDN0RS9kMC9vT0N6Zk5L?=
 =?utf-8?B?ZlZhb0hKSEpPVFU4YloyMzVxaDYvZWRXeGZRb1RwREVjSUdWd2NmVGMwdHkx?=
 =?utf-8?B?SG1OMmtudjl0ZFYrYWF3RjNZNVdZc1ZOVmhNeVA5RHpteU54a0piU3QxeU9j?=
 =?utf-8?B?ZHVRK1luQ25hSHpGSjVzaWhHVVRpUGdtUkdXMkJucWhiNTZxNm9HTDR1cW5l?=
 =?utf-8?B?SDBJZVE3SWJuTXZIQzljRTVJU3REYjd2RjBxRW1HeXlkdFI0RUhHV2o5STJT?=
 =?utf-8?B?eFc0UzJJQ3JRVm5xaDcxb251RUhPT0h3dmRieGQ4V2pTNU5PSXUvU05pSzBQ?=
 =?utf-8?B?Q2dNNTVGN24rMjFvTnoyc05meSt1ME1vdnpNYzBRNEdSNE1rQnRCK0dxMHFI?=
 =?utf-8?B?YkdheDBSbVJTQmxTQnJva3lUWUhuZGk3dEQxcllXOW1ObzhDWTVpRzRLVDh5?=
 =?utf-8?B?OW9JYkRJVkN1M3JaOHNobmZ0T0RUUzArMnhnM1c1UHlGVVl1djNsTFpmY0do?=
 =?utf-8?B?NHR4cWQxaFNFTHdudElITFhoazJ0SzRuN2xSMlQ0Wmd5czlNM2padEplc0FZ?=
 =?utf-8?B?ZGFPTzMxOWZvZ3ZtN1FOa0xNd2VyQ0RSNm5GdVFsVmNaNUJuY0VISUM4RHQv?=
 =?utf-8?B?a0hHVnVSNjJKUVR3M0NBMit0MU5IUlhrU09veGZ4dXh6dTJiVjZXMXBTU20y?=
 =?utf-8?B?WDFDMjBhRU9GdDd6TnFtY1E0ZEpWR1ZyeDltc3RnRk1tWFY4TitXaEdXa2dq?=
 =?utf-8?B?U3Y0Y21NNDZGVVdVa05qUFlsQTl0ZUgzdmw4YmdabmRDdUJQSmFTR3VnRE5z?=
 =?utf-8?B?QXFwZ0t4SGZDNFVnem9jK1c2a1ZNdTQwSkI5MUhjYnk0ME83L1R4Q1g1cmVU?=
 =?utf-8?B?YktTWkFkbFFVbEpCcW82RDlhTE11SjJHNTNMRko4b01CR0JjVDJRZFpjRkZE?=
 =?utf-8?B?TCtKQ0REMnB3bGVlYmtUMmxPeEFTa0NtVklkZTZPTkNhWVh6L2FoT1RrSXZq?=
 =?utf-8?B?QUl4dnFnZWpqNVhzWG5oZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEtlcWk3M3JjYnozMW5ZV0dhekpKb25HQ2piQWdiZW1oM3p4cW84aFhocHA3?=
 =?utf-8?B?UjB6TytVQVdpWkpGYTlSeGRWSG9DUUtndzMzblNSVjF2V3JIZmRjUnJ1YVg2?=
 =?utf-8?B?NjJSN0xTNVFTK0VId2wyTUxLWVdZMUg2ZWtOUlkyV3dSK2owakJTV2w5NEE4?=
 =?utf-8?B?QmlyWEV3VVRwZkJsUVgyT1ZTU0ptY2EvbENHbWpDT05qL2pWSEdMLys3WGxl?=
 =?utf-8?B?Q1JlZjloR3VYbG1mR0p2b2RIVzMvU2FFeFg3Z0pRWTEraDVsLzZ2eWgwZmtx?=
 =?utf-8?B?ckROWVlYNCtnU3B5cm1Qc2tiK2tkTzhTVm16c0tUcmw5MWMyRWJxQTEwV0lY?=
 =?utf-8?B?TmRBOGswQ01yQ3JDUnRWMXhTWVF3KzRpVVMyR2l2TGIzL3FJUktTNkIvZk5V?=
 =?utf-8?B?UUg5ZG52bTgvTGU1ck1IcmdCLzllUlRMd3VmdmNKQ2R6aEVoMmRvYklDczdG?=
 =?utf-8?B?OU5HRzZzMVpuRmk3V1R6ak1WODl3RGJTWjh2bDFRU1orTFNYdTNYRzIzZGY3?=
 =?utf-8?B?aVVVL1l1QStwTUZDOGV2a3cyZC9NWTFqWC82UGh4dS9lM1VkaHNKQ1grRzZm?=
 =?utf-8?B?ZFNneW5FN2lVaEN2ck1BR2NldGlpK0cyZlR3bjBxR0VlZGtTRStTdk5oY1dJ?=
 =?utf-8?B?bDE5ZTVlZGxEbk04SVh5OXBWenZpNVNNU3Fhb2tHUGVRUk1Fdy9mM0l0K3Nw?=
 =?utf-8?B?QVA0TE9xcUdOUzFTaVZQckVLQUc0M28raGl2R0xKbGhPM3B4RktmOG10SFJD?=
 =?utf-8?B?VzVRZnYwQlM4ZUVZWW40RnYyb3lZeTBXSnM4QWJPdm5KNTR3Mkg2c0pZQzdU?=
 =?utf-8?B?bnF3R29CMGMybUhQb2VHbURtUE1pOXVuOUNHVFAzdlp5ZUVrQXk5cE5Xcll1?=
 =?utf-8?B?OVYyUWh3UlIyYWlkQUxJLzBnbDVLSVRKVC82bjR4L2R3OTF4NE1LL2IvYk05?=
 =?utf-8?B?OHl6RFQ4M3cwMnFoZXFCSjVpbkc5alRrQ2ZTS0l3UGhQSTJTakw5bnVZbXNC?=
 =?utf-8?B?Sm1WUnR6b0RBU1c4ZWF6am4xVVdmb2JmbWxhWjFaKyt0aVpNRllKSW15VEhj?=
 =?utf-8?B?NlpXaUhFY2NYa0l5NXhYamF1ZU40TXA1eEJ4RWFoWjBjek04MzFDL2d4anpQ?=
 =?utf-8?B?Mzh4NVFDYXF3dDZtaVFwSzRHNWE2T3d6UDFhMnZyalUrdVhpNmY0eTluZ1lo?=
 =?utf-8?B?TlNoVUdpck5uNFpZYTlsTW9UY1VoZ1V4aEpmVitqMWVUY08zNmk0NEFqSUtj?=
 =?utf-8?B?MG1wV1REc2FEMUZQdnVPNjhkWlp1Umh5K205SXNKYlMwWnBlc2lrcHIvdmdM?=
 =?utf-8?B?SGNDSC9JTjJtNGs5VkNrSWhGdndJSDJveTg4L1U1ejd5LzlTdThkRUNaSDIx?=
 =?utf-8?B?Y254SXF4QUJSM3poT2JGY1F6N01SelVBbmhueE1aaTJyaTNJb3hyaWxGbjM3?=
 =?utf-8?B?Vmo3ck43b2NlOHduQkRsR2ZkN3ZnQlp1Z2FQYVk1Tm1ZMHNwUVZwRTNWSTRK?=
 =?utf-8?B?YXh4RERxZFM4S1ljQit2aFppNldyL3hydENvdWhSQk91VjdwTDhHSUlSSDQ0?=
 =?utf-8?B?bzFmV1dFUXZtQnBWWnhhTHBjUU9YTlI0dW5oMUtBNXZ4Q3FPZW45cGNYT1Bw?=
 =?utf-8?B?SXRGclcvaE8yN09EM2k4YmEzSlRqaVlGOXYvd3p4Z3ZHNmdQdU9CTWZ2SW5k?=
 =?utf-8?B?dG04eEtDRTJ3MWhRR0lXWWpJZEVLOGZPOVd5K2pJekV2TDJzTXF5dHpiODVx?=
 =?utf-8?B?ZktPQ2wvbWJGcWk2cXJYMkFQSTA3QTk0eXVFbGp2TXl5c3FWYXgxcm1YK2lv?=
 =?utf-8?B?UDVJNm9iZlZtM0V6Ny83YUVLei9BTDByN0dQUUpzWFFnWjNmS1ZiM2JEWDlB?=
 =?utf-8?B?dVFXdFJzaGgvNG5qQnUvelNxczg2T0tjcDVvR1JqdmhlWk9SQXYrRFdESGhO?=
 =?utf-8?B?WjlUYXZKeEhlRUUxVTZpQ2EwemRkcFVEcFFqR09MUEs3L2NCNWYxTG04UlFM?=
 =?utf-8?B?ck9lbEF1bFJyejFvbHFYc0l0S1FoVXNlc29QZWRrSWtRS0hqR2xOOVRZMVZm?=
 =?utf-8?B?MjA4cmtNc1p2OEdtSld3dTZibGhvZ0VCbjVSZHE2NGt0TzZjZ0VuRHp6a1FH?=
 =?utf-8?B?Q1NiUk5udytzcUVSSm9wSytlcnR4UWZRKzFsM3piWDR5amRRRlNJTjNyeXFv?=
 =?utf-8?Q?NWNYJ3eAeKwcDaM/W/90gD0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A141E47F9577B64CAF965018B9011A5B@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2adef8a-e8a1-4d6b-8da2-08dc6abca13d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:17.1269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jSadikAUYTBJLIvSy1THOxBI9pOmUHSQaVRcEjR9oFWNsvg6+Kv//QrvJ7c0qMFuLPQtABNMcXYOqki/+sdBbs2W6Jo2+f588TDVV27VOZeMRp3xBYugxL5aXFZGy+Zm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9661
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

VGhlICdsZXZlbCcgZmllbGQgaW4gdnRkX2lvdGxiX2tleSBpcyBhbiB1aW50OF90Lg0KV2UgZG9u
J3QgbmVlZCB0byBzdG9yZSBsZXZlbCBhcyBhbiBpbnQgaW4gdnRkX2xvb2t1cF9pb3RsYiAoYXZv
aWRzIGENCidsb29zaW5nIHByZWNpc2lvbicgd2FybmluZykuDQoNClZURElPVExCUGFnZUludklu
Zm8ubWFzayBpcyB1c2VkIGluIGJpbmFyeSBvcGVyYXRpb25zIHdpdGggYWRkcmVzc2VzLg0KDQpT
aWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRy
aWZAZXZpZGVuLmNvbT4NCi0tLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDIg
Ky0NCiBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAyICstDQogMiBmaWxlcyBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ody9p
Mzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCmluZGV4IDcwNzM1ZTIz
NzkuLjgwY2RmMzc4NzAgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCisrKyBi
L2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KQEAgLTM4Niw3ICszODYsNyBAQCBzdGF0aWMgVlRESU9U
TEJFbnRyeSAqdnRkX2xvb2t1cF9pb3RsYihJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90IHNv
dXJjZV9pZCwNCiB7DQogICAgIHN0cnVjdCB2dGRfaW90bGJfa2V5IGtleTsNCiAgICAgVlRESU9U
TEJFbnRyeSAqZW50cnk7DQotICAgIGludCBsZXZlbDsNCisgICAgdWludDhfdCBsZXZlbDsNCiAN
CiAgICAgZm9yIChsZXZlbCA9IFZURF9TTF9QVF9MRVZFTDsgbGV2ZWwgPCBWVERfU0xfUE1MNF9M
RVZFTDsgbGV2ZWwrKykgew0KICAgICAgICAga2V5LmdmbiA9IHZ0ZF9nZXRfaW90bGJfZ2ZuKGFk
ZHIsIGxldmVsKTsNCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgg
Yi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCmluZGV4IDRmNmIwMTU0YjUuLjkwMTY5
MWFmYjkgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCisrKyBi
L2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KQEAgLTQ3Myw3ICs0NzMsNyBAQCBzdHJ1
Y3QgVlRESU9UTEJQYWdlSW52SW5mbyB7DQogICAgIHVpbnQxNl90IGRvbWFpbl9pZDsNCiAgICAg
dWludDMyX3QgcGFzaWQ7DQogICAgIHVpbnQ2NF90IGFkZHI7DQotICAgIHVpbnQ4X3QgbWFzazsN
CisgICAgdWludDY0X3QgbWFzazsNCiB9Ow0KIHR5cGVkZWYgc3RydWN0IFZURElPVExCUGFnZUlu
dkluZm8gVlRESU9UTEJQYWdlSW52SW5mbzsNCiANCi0tIA0KMi40NC4wDQo=

