Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA25C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YNX-0003nY-Jg; Thu, 02 May 2024 11:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNW-0003mn-Gf
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:46 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNU-0005yW-Nb
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663784; x=1746199784;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=jM1EHjhFLT2EkJoFivJljUJFgLUgd0qqSvusSb1EhyE=;
 b=WV5EC9r7I99sytiMrtXA/K4FOFpKHy/lcwJ70+AUKADv75bywd6ZTOEI
 1dShO2YYDRMOkJjV/g01cMLZqvNX9pJ9aotCaguLlP3O25o/YQB5SVrRC
 ZDznfwOeKLNST2KanVC5W/yGLbeTGXfPm25he+qVjWQfQOaaDyHU6Rv7W
 KEh22N1VpucqblOSmfhe7yZ4hHDPPxU8IR461/Z64N1DgGwT/EY0tuNQY
 jGsp5byzMYl9L9HR/SRLUgdC+3K36uGGt4UZhYIEg8OL3RXzc9EGormfu
 TJX4n2qlY5tF7TehAX8UWhhY7oFG+JeFfPo6C12gRUVWv7UUTPtEuAoJr A==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11785880"
X-MGA-submission: =?us-ascii?q?MDHedQyCWxBvme6j69c45I3Xc4XetY9H5xBY8k?=
 =?us-ascii?q?Sfr1uMvRIsLYHTBfXl44jQ0CXGLABIPY9QWOW7oSIWck0iRExaqonP2T?=
 =?us-ascii?q?YYs1u0AI1l2P2XLrg8hBSLFsvM7Gph6ncSoQvtNjqnAFjPFKsZX472PW?=
 =?us-ascii?q?Mei5I+z30HWnAH+dnOS6VWbg=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:20 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpC/1Bd3Dsf1yT1rX2EnGOzyVWP6R10KOVvhOegzmDIZ08cVyUjRl7WQFT09f8sZELEBAGz0YsTBrXqmZGO+97JTAXJ4w8stApivkKy83oGl/kzyUThhuqId0VonLYmE8ps2+pb3EvDN2H9Ba7v97faJwvMYQoplfWRPmCfUrFRTBn/JUzG0nVvg5YPAHJmK9VbBtGK9+nz64/0T2MdJVinZSdMc1Dz6peNaOPkU4V8NUr/gNSc5+pJXMbG8KL8Op99VQU+QvO5xMWRC4XeqKAw9PAOUsFo37Tefj0Joh0HXKP5SJUEoR8QxMM6EAMGxshl47t0DncLfaoN08NcItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jM1EHjhFLT2EkJoFivJljUJFgLUgd0qqSvusSb1EhyE=;
 b=iWu+Xqx2xAwRWOttzuLuY5ueIdBbcSC73BiTa1iXlVWbPSX+L7ygVM/2wGuYXk4wlqxXCtSsADGRVI33nIdglVxx8zjt9vJ36mU6reVkUAl/bFuH7iX/1vaTPOaw3hYFeErWAjfBBBlO8wFhO3MrZqezroKxsUHQmHpntytYSeBOPQwSBxp1xmRVD/VqYiH83Ep6VlIbCrUW5yLEcX63JQnRLACKn6zr3c+Raqjm7vFmFfucVS8rKJ47GZ+zbe+oZGyCdRTq3lSfcYDGrhowZtOlMdj9spx5E6wisnZ/d/DAoaVw7BTUYFbxcYO1rqjLdOa1tF59aycGOMxWkC6Hqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB9661.eurprd07.prod.outlook.com (2603:10a6:102:389::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:18 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:18 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v1 07/24] memory: add permissions in IOMMUAccessFlags
Thread-Topic: [PATCH ats_vtd v1 07/24] memory: add permissions in
 IOMMUAccessFlags
Thread-Index: AQHanKV/BkiYnlnArkGPo2DOdz2MPA==
Date: Thu, 2 May 2024 15:29:18 +0000
Message-ID: <20240502152810.187492-8-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 0dda3ad2-c5b3-4776-caaf-08dc6abca1f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VFFtWnltZ01vZEpDeTgxT3RRekFnRnBIaHVVRTVuMnBTWExqSSsyUDVhOS9M?=
 =?utf-8?B?QkNwd294UHlkbkwrWjlhUTV1OVArZ09WSFF1ODR4WUdnOUUvUzhXdFo1WERi?=
 =?utf-8?B?dmVZZGJDRC9rTW1TOFdUYThyNFJHZE5uaEhlelpaWnJERUZGNDNDQ3VKdDZp?=
 =?utf-8?B?Rkx4b20vUlRHOG50WGk1YllVOEZwSHpsOHhxcis5N3QzT01WOWxJWlhsalVx?=
 =?utf-8?B?ZTJoaTFhRHdCMzNBb3BrREc0QllDcG5jWlkzRjVsRHRGY3EwZWRVVlhIamhH?=
 =?utf-8?B?RDYzaFdpK3NMaiszSko3YkhVRGpNRE15VVJPR3FocnZtZFVGVld3Qld2OGl4?=
 =?utf-8?B?amJuRU5ZejdkUld2RTZ2VjVMVTZOMlMrRVE1NUdHVUpmZEU4VGY3NWhKVGNE?=
 =?utf-8?B?eGVORFpvQUpxSE9JOGxiV1N5dm1DRDFmbHRPNHlVb0MwNkN4bk03L0V5R1ZZ?=
 =?utf-8?B?ekhhZURhSmJ5SU8zN2E4K3NTbjRDUVd2Q0ZzREJHcVNJMWtLTnNKZkNqTTRY?=
 =?utf-8?B?bkdEb1h5R0I3aHJObmRrUm5oK2hGY21yODFaTm1EV3ZQUWk0U1ZLZzVycFQ0?=
 =?utf-8?B?YXVIaGVLS0FFRFpNR2wxT1Z2c2hWVUpXeERVSGhqZEJTeHU1TWhHVFRZbVdM?=
 =?utf-8?B?VjQvTjRmZTBWWEF0VlZWVEIrd085MHZiS3NESTgvVnZSbTFRUlRya0gvZ3Y5?=
 =?utf-8?B?VFB2eFVRbGVhZ0RDQkZBNHdGN2c3cVpmbVRKNTk5UXMweUZJUXJXVk5TOHIz?=
 =?utf-8?B?SHZ5TWJiWnJIV050cTFnQ3h0NjAvM01kelJ6SFltaTlGTEdtYXZGN2ZKS0Va?=
 =?utf-8?B?WGpiRjRDRTYyRXZKMzNGdjBqczJPd29Jd0tqQkRYZzNqZlNGa0V6clRXNTZX?=
 =?utf-8?B?STBLREVjT2haS1g2djF3Zm4vNEpBeURQSThIRnhHNHVUNW1ZN0V4Q3lOU1lv?=
 =?utf-8?B?dHNiYnMvRnhOMTd5SXBVSTl3a1BWYi9jU0c5bmFLNk5XY3kyd1JqcmFZelpu?=
 =?utf-8?B?M2JEY3pnZHRuL21JQzQ0RGJDNTVwcWdwLzNkSU9XRG5mSk9MR3dtL2F6VmM3?=
 =?utf-8?B?NlQyNS9aTW9jM2lZb05nb2VoQjVBV3BCWUFoT0dzT0p4NHBrUU9RaEJWaTNq?=
 =?utf-8?B?VmJ1cU1aa1lIWHowTWdiWjZJSzB5MmRyQ1RneUh3Z08rREZLRm9EOUhUN3JV?=
 =?utf-8?B?c3JuUUN4TUVvTVQxTnh2Wmh6bHZ3ZDZXa2xkMmtiU3BubWxJRllWZzJFYUQ4?=
 =?utf-8?B?c2ltNWg2MG1BNkdGN1FVcXh2b1VIT1NyZ2w0bHkyRjZVSVljQWRRV1UwQ0V2?=
 =?utf-8?B?bVVib2JBTE15aDRCV2d0VkV5TGR2VjZnN0w1ZE53aFZENFhDRU8xd1IxeDBn?=
 =?utf-8?B?b3hScDkzL3ZWSVhnVGZDcFJkYlFTbTE5UEpHaHl5bGFHZFhuaW53UCs2S1c5?=
 =?utf-8?B?bStEaDFYQ1VXQW1ISkZJclZnQi80M3l6TTlmN0JKbGR5cVcwRW9VaERRRkx0?=
 =?utf-8?B?UEloTVUxbjUvRUxqRW5wd1JmeGFxL0YvOFBsMzFTQ0N2RnpHOGlQSHpoaGRE?=
 =?utf-8?B?QmlMVHBuQyt5SFBhalg4R3cxNVJPUnE5UGxqQVR1c1JnYkVodVQ4Z0ppTUlM?=
 =?utf-8?B?QTMxS2JmUVpWUFR2aWU0Nk9WT0hwNVZuZkZzQWYxcWhLVVNZNDNQZW94czVS?=
 =?utf-8?B?R3ArZGgreUNGbTgxejlZcEl0b1oyVnVpK2tZNUtLZ1hoSEJmU2FqMEVpb0tT?=
 =?utf-8?B?WWNNZzFPMmFHQnBybzRGNi9YRmlhRi9lVUxNTzNKS1cxYmc2Qm82V1hoMms5?=
 =?utf-8?B?RDlua0l2K3JrbTM1Vldjdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3pTWkhpR3h1Misyck1oMEF1bGM5Qk9kSU5qQlJzZ05sYW41VzdXQ0RlRjlM?=
 =?utf-8?B?UktGNFVjZVhSdUIzQXd5K1FiMFNZcGQ5WkJqbUtlU0V2R1FMUlhrZHBGdHg3?=
 =?utf-8?B?bmJFR1Y5bWo2QzhZeHozckdBMW9XZ3RGb3QxNXJ0R0hkaXVzbUw4U1FWZzBN?=
 =?utf-8?B?RXpUakhIWWlYcG9aVTFVWDRVN2RGQmNDS1luMmRpaWd1RWtwTldaaUE5UVhM?=
 =?utf-8?B?cEtYb3BYZjhKZWF1MDdDUDZlcGU4L2VDSm85UVBIaTdMWFdxNkdIeGg1RFZZ?=
 =?utf-8?B?QklGV2J6REpWa09OelVJU1o3bm4xQ01ndU5TVTg0OC9UMEVwbDBHVFlnZUhv?=
 =?utf-8?B?OE9hbGZJQ3MrLzdnMEVnSE5QZ1FJby9wSll6OXRsSWI3UFdRay9hdEJxSEdZ?=
 =?utf-8?B?dHJ2a0NXYWpwYlk1a0ZaWjBKZGpyOXZWSmY3UGxXVkx4bklzTmNkbmFjY3lE?=
 =?utf-8?B?QStxK3hlTHR6dUNINm9KWVVyNHBqL0VLbVdOeXliSk5wdzFXM1lDUFNRRi95?=
 =?utf-8?B?TFozZDkzRDdWMDgvQml6Skx3U3JnQkhwc0hqWFVlYXVjWnA1RjBscU9RZ2Uv?=
 =?utf-8?B?Z09VSFJBREE0b2I5ditqZzM1N29WY2RiODhyaVFKTUxsdFpRSHVvZU1IbzhV?=
 =?utf-8?B?azZpYXF2bklYby9ZYVJxNG1aZ203bjNUaFExWERCQUhOMXQ5cEY1ZTRaMVNt?=
 =?utf-8?B?UWZjdGRPSUV6Y0M1Q3JzbXJTVnE0RzgyQW1BZFZxbUxRV1gzQTFSNXQ1TXRY?=
 =?utf-8?B?U2NVNlYzV3BoZDZZNjU5aDlXQWJrdURwYXJVTUZ4cmwwaW01c3VUampZaXVU?=
 =?utf-8?B?QjA1SDRHQUpQR3VlYmVzNmdwME90aDVJY04zWTVUTmIzSTUxNHphNVE4ODVE?=
 =?utf-8?B?K3U3NVlZV3VpZmdueEErREErdWZGZHF3cS9xa2ZLTjNpOFpYSHBRbW4zdHA0?=
 =?utf-8?B?Uk1IQXlBeEpWTm8rZHgzZDdFMkZzRG80TmxIL3B5cmdjanVZc3RFdHc2Tk9j?=
 =?utf-8?B?eGZWcjRRUStIVzhIRGRtOWdwa1hCT3Y4OExXeWkyMm9xSmtCMTcyWk9IVXUx?=
 =?utf-8?B?WHdXS1k3WmNPd2hUa2VpYmY5N2J5NWsyUGRLNEZ1aTFzRHVvWEg2Ny9qUG45?=
 =?utf-8?B?Q1NNeENhL3hPbit6d3VjS1c0Z0dsTUF6MkhUOW05aERvMENhWUM4TW1MV09Y?=
 =?utf-8?B?M05YYzF5ZE9zN1V6OU8zbzE0N2FqQUtMYzBDR2N3c1NwaXpPZTNnUkh5bHBq?=
 =?utf-8?B?Q2l4cHV4aGY3VnR1bXhUcDVTSlFaKzZ3S0ltY0ltZDRNR0pEa0V3emxGRzZR?=
 =?utf-8?B?SUs3VmVLNVZId1U5eWRQS1lsWXBZZ0hkZGdsRFl0WjBKYUhtaUVuYlRVVGUy?=
 =?utf-8?B?Mmp1a1RVVHJFZ2xvcFhuZ202VG1WZ01paXNiVnV5YktIN0c0VDRmSnpubEY2?=
 =?utf-8?B?T3RUbnFNUWVMVkEvckVINm01dTJSV1dMZXNpaURTanFIZjZRUm1NMDRRTDdp?=
 =?utf-8?B?OFZCTzFkL2NyNlhKU3BCc3lWNkovc0d6NitZUXRJTE01ZU1pUHo3TlFQd1gv?=
 =?utf-8?B?WW5NOWN1dytnU1k3Ymp4RTBRbzB1NDVMRGxqdHlrbmJVUDRqM25SM2lBV1VH?=
 =?utf-8?B?T3JVZk1iWmM5dGpZbzVSbzFZeUxPajV3ZXVNdTg3SFZPRFJ0U05NcTA0UlJr?=
 =?utf-8?B?RjVBMnJ2TlRSc2pMM1JDeXpjbVBzMU5tOWo3bFRuNXVWSjg3b3JXZy9oQ29B?=
 =?utf-8?B?bG5FWWVnN3lBU2grTFUzWmxXQUN0eE1hVndDeVdlNEdFQ091V3ZpSFlPQStH?=
 =?utf-8?B?QUxEYm1UOUVrb3RmaTEzNXQ4T2g5a1RXQ25CUDJVVllLQWl2eWk5cC9LVlRC?=
 =?utf-8?B?SUNkN1hWQ1BnUnVKaU9lV0dlYjBRT1RuQVhXR0hDL2dKUTdxTVRPT3RLVUds?=
 =?utf-8?B?ZXRvbFRhMnFoeWo4R3J1YkcydmlkRUp6SDFRNGxOWVB2ekkxN1FCSEh5UU1p?=
 =?utf-8?B?ZXpPUm92MjkyMzBRMzc5NWJQcVVYYmV0QS9OUVQyYmhVNlorb2hXbEVqNGd5?=
 =?utf-8?B?cVd5OE4xd3RtK1Nja0RzSjBmNE53WTllSU9VRWpSQVpuSmc4Y0k3eVgvcENv?=
 =?utf-8?B?WEZ6aTcwYlplKzY3eS9RUTRWY1N3YS90RFh6dVZ1WndwZStBM2krS3VpS2tT?=
 =?utf-8?Q?okubMOLaKasBOjv7e3GGq9k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5DF50602171C440B77636D4363CC263@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dda3ad2-c5b3-4776-caaf-08dc6abca1f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:18.2838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nM2XyIYeT6yRO6/8eV3+SxoRXwiBLj0rtfNfqkgX4P7KqPX7IzL94on+2FYCI1XAaQBRFbqXJ8pSCAmTjrpvqdUhLu7FXHdt2dr3Q3+cCokF8j+zpdgE5ElV3CGNFApG
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

VGhpcyB3aWxsIGJlIG5lY2Vzc2FyeSBmb3IgZGV2aWNlcyBpbXBsZW1lbnRpbmcgQVRTLg0KV2Ug
YWxzbyBkZWZpbmUgYSBuZXcgbWFjcm8gSU9NTVVfQUNDRVNTX0ZMQUdfRlVMTCBpbiBhZGRpdGlv
biB0bw0KSU9NTVVfQUNDRVNTX0ZMQUcgdG8gc3VwcG9ydCBtb3JlIGFjY2VzcyBmbGFncy4NCklP
TU1VX0FDQ0VTU19GTEFHIGlzIGtlcHQgZm9yIGNvbnZlbmllbmNlIGFuZCBiYWNrd2FyZCBjb21w
YXRpYmlsaXR5Lg0KDQpIZXJlIGFyZSB0aGUgZmxhZ3MgYWRkZWQgKGRlZmluZWQgYnkgdGhlIFBD
SWUgNSBzcGVjaWZpY2F0aW9uKSA6DQogICAgLSBFeGVjdXRlIFJlcXVlc3RlZA0KICAgIC0gUHJp
dmlsZWdlZCBNb2RlIFJlcXVlc3RlZA0KICAgIC0gR2xvYmFsDQogICAgLSBVbnRyYW5zbGF0ZWQg
T25seQ0KDQpJT01NVV9BQ0NFU1NfRkxBRyBzZXRzIHRoZSBhZGRpdGlvbmFsIGZsYWdzIHRvIDAN
Cg0KU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1
LS1kcmlmQGV2aWRlbi5jb20+DQotLS0NCiBpbmNsdWRlL2V4ZWMvbWVtb3J5LmggfCAzMyArKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0
aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9tZW1v
cnkuaCBiL2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KaW5kZXggODYyNmEzNTViMy4uMzA0NTA0ZGUw
MiAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KKysrIGIvaW5jbHVkZS9leGVj
L21lbW9yeS5oDQpAQCAtMTEwLDIyICsxMTAsNDEgQEAgc3RydWN0IE1lbW9yeVJlZ2lvblNlY3Rp
b24gew0KIA0KIHR5cGVkZWYgc3RydWN0IElPTU1VVExCRW50cnkgSU9NTVVUTEJFbnRyeTsNCiAN
Ci0vKiBTZWUgYWRkcmVzc19zcGFjZV90cmFuc2xhdGU6IGJpdCAwIGlzIHJlYWQsIGJpdCAxIGlz
IHdyaXRlLiAgKi8NCisvKg0KKyAqIFNlZSBhZGRyZXNzX3NwYWNlX3RyYW5zbGF0ZToNCisgKiAg
ICAgIC0gYml0IDAgOiByZWFkDQorICogICAgICAtIGJpdCAxIDogd3JpdGUNCisgKiAgICAgIC0g
Yml0IDIgOiBleGVjDQorICogICAgICAtIGJpdCAzIDogcHJpdg0KKyAqICAgICAgLSBiaXQgNCA6
IGdsb2JhbA0KKyAqICAgICAgLSBiaXQgNSA6IHVudHJhbnNsYXRlZCBvbmx5DQorICovDQogdHlw
ZWRlZiBlbnVtIHsNCiAgICAgSU9NTVVfTk9ORSA9IDAsDQogICAgIElPTU1VX1JPICAgPSAxLA0K
ICAgICBJT01NVV9XTyAgID0gMiwNCiAgICAgSU9NTVVfUlcgICA9IDMsDQorICAgIElPTU1VX0VY
RUMgPSA0LA0KKyAgICBJT01NVV9QUklWID0gOCwNCisgICAgSU9NTVVfR0xPQkFMID0gMTYsDQor
ICAgIElPTU1VX1VOVFJBTlNMQVRFRF9PTkxZID0gMzIsDQogfSBJT01NVUFjY2Vzc0ZsYWdzOw0K
IA0KLSNkZWZpbmUgSU9NTVVfQUNDRVNTX0ZMQUcociwgdykgKCgocikgPyBJT01NVV9STyA6IDAp
IHwgKCh3KSA/IElPTU1VX1dPIDogMCkpDQorI2RlZmluZSBJT01NVV9BQ0NFU1NfRkxBRyhyLCB3
KSAgICAgKCgocikgPyBJT01NVV9STyA6IDApIHwgXA0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICgodykgPyBJT01NVV9XTyA6IDApKQ0KKyNkZWZpbmUgSU9NTVVfQUNDRVNT
X0ZMQUdfRlVMTChyLCB3LCB4LCBwLCBnLCB1bykgXA0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIChJT01NVV9BQ0NFU1NfRkxBRyhyLCB3KSB8IFwNCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAoKHgpID8gSU9NTVVfRVhFQyA6IDApIHwgXA0KKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgocCkgPyBJT01NVV9QUklWIDogMCkgfCBc
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKChnKSA/IElPTU1VX0dMT0JB
TCA6IDApIHwgXA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgodW8pID8g
SU9NTVVfVU5UUkFOU0xBVEVEX09OTFkgOiAwKSkNCiANCiBzdHJ1Y3QgSU9NTVVUTEJFbnRyeSB7
DQotICAgIEFkZHJlc3NTcGFjZSAgICAqdGFyZ2V0X2FzOw0KLSAgICBod2FkZHIgICAgICAgICAg
IGlvdmE7DQotICAgIGh3YWRkciAgICAgICAgICAgdHJhbnNsYXRlZF9hZGRyOw0KLSAgICBod2Fk
ZHIgICAgICAgICAgIGFkZHJfbWFzazsgIC8qIDB4ZmZmID0gNGsgdHJhbnNsYXRpb24gKi8NCi0g
ICAgSU9NTVVBY2Nlc3NGbGFncyBwZXJtOw0KKyAgICBBZGRyZXNzU3BhY2UgICAgICAgICAgICAq
dGFyZ2V0X2FzOw0KKyAgICBod2FkZHIgICAgICAgICAgICAgICAgICBpb3ZhOw0KKyAgICBod2Fk
ZHIgICAgICAgICAgICAgICAgICB0cmFuc2xhdGVkX2FkZHI7DQorICAgIGh3YWRkciAgICAgICAg
ICAgICAgICAgIGFkZHJfbWFzazsgIC8qIDB4ZmZmID0gNGsgdHJhbnNsYXRpb24gKi8NCisgICAg
SU9NTVVBY2Nlc3NGbGFncyAgICAgICAgcGVybTsNCiB9Ow0KIA0KIC8qDQotLSANCjIuNDQuMA0K

