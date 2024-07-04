Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341F8C3DA40
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 14:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPNkk-0003QZ-NH; Thu, 04 Jul 2024 10:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPNki-0003Pe-LS
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 10:48:04 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPNkg-0003Lq-Uk
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 10:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720104483; x=1751640483;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=2svyLmHlQ6d1l2Iag7bhkpug/Bb2fDl8x+3PvU0cF0w=;
 b=nwpRLJWuDl9F0k0yKs3ZL8KwfaOPK1gxqitfYOMfqcU7rLB87ZGpT4yX
 hsvxbne1c5miALI0hQ1yUER2Pj6vF2YKFrS0gakvotwTYAqKFzi+EA5BU
 7qCAnR/tR0QHMVYRU+yYVODSFPmcGxPySURh5GUIj9XwyineEUTDaO2Vb
 /symxrfiB45bg9sFBFbg3xqQY0zpPabKh0GHaHaOBsJjkA9cU+DlieFzv
 +CG9Vly6wCEYci+jXl/BnYOQRUL4msQZwzLRNQANIj3XAbTJY9EV6SPT1
 0d+AM8YONLqT2D4KuIzpLCEE43rXiufjIi8PkYp66xtoylhe6hSURe3ak A==;
X-IronPort-AV: E=Sophos;i="6.09,183,1716242400"; d="scan'208";a="16005887"
X-MGA-submission: =?us-ascii?q?MDHvxumJxW+xlRTDGNcApb8433uaACFQtIPj12?=
 =?us-ascii?q?8wY/h2RP1GrNjNeB+1EWlf0UhEYlhtQID2TJA0/dcJkDaSEKxkAMBKAZ?=
 =?us-ascii?q?D0YqMW9hPs5NzxmnXNxwLEQMglMxdFg6BtvzHS3fgfsTSPazjDOXmwQH?=
 =?us-ascii?q?I4UuvfX9jQRehaZ7dc34Lm8g=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 16:48:01 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVf5W14V3tB0wlRChXB2HhZPZlpCAxiXNGdDPkYEQc7idmKe4gNz2JnSBPwq5uVtFiG/4fQg8R92W3bPon20dueKurwgcxaWn/FNprAJMuPfR4NGRqClXMOAtk2kt8Pkn6oborvugivo1KJjgshTzgl1Vx7Pw/qOsr4J9CC172fhsKJQiVXZ+FwQmBB29uyZOa1MsJlQlEk643QT69DW8Ia8FPgS0ildQzFoL+EHIaQRZYPI/UNXP1f2o2xRoKyJ/7Tozht8k8t1Ik4Pmtp3bbT06vrAwsxUCjld4L3UG1lr103G+6ihhLGXKDbpaTgm2U1FAvQPpaSGz8LiEgTQRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2svyLmHlQ6d1l2Iag7bhkpug/Bb2fDl8x+3PvU0cF0w=;
 b=K3JnJcmwIIU0/bxs3QVoW1e9A+Sy+gYpUF5UThoLqKtaeh+X/SHxUSTLz77f+fTZjhbvSvLKxuxzNydu9IWyF05HhDIqMNNb1ZZXnCUkh5YzqAWH9L4ZNcmCdmXVwVIc3ZWrH5pAB2lzsRULten0id7AOMjYHIrmRUv6BtonSw6YsWinIVOTVPCa4S/do0gxPRYBijjeb6pm3le4NLsUyg+rfTS9pjgojWixKvjzZznxcK59Qi70fNC043bBFJdcG+1W30iAbHAXLrIL/EMkZi/wV9eY14vlTfM9lc88JcZ7iMQW5OCwSdS6hbvTchzrtQ8iopuvtkOmzDuZibEw/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2svyLmHlQ6d1l2Iag7bhkpug/Bb2fDl8x+3PvU0cF0w=;
 b=X6ilOpyH3OlPuUKf2S6f8GjjpdlEcPQ3peKaVLOGQyEZDvRSGVnwDHeI3HXG1ILXj82SH0NXIAqVICT814fbFfkSR4pCxu+sJrnGX7dxiRrpKNAIaR4Qb74jefzwjqqpahcfV+zKSs461KRJyg2glIsEV95f5IAhEWWqmlQuLpNuSkJVxlOxz5h4GqfcNHkPjZjfqC5xRhto0OUG/VuvgFJN4jGJMogUsXo+ptyS1EL+j3sNDszQBm8cwgJe6DsCRwvnRxiVZA++IAPF2ubou7FzG81z5tKLWaPdXyW2YmJfsuB4EHTaC98+zqv49q5OOFtQaniSAs7cPhxOnEsnzw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB9499.eurprd07.prod.outlook.com (2603:10a6:800:1c8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Thu, 4 Jul
 2024 14:47:59 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 14:47:59 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, Clement Mathieu--Drif <cmdetu@gmail.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH  v1 2/3] intel_iommu: make types match
Thread-Topic: [PATCH  v1 2/3] intel_iommu: make types match
Thread-Index: AQHaziEpnBS59oBIpUuVMnrpPnUfBA==
Date: Thu, 4 Jul 2024 14:47:59 +0000
Message-ID: <20240704144737.996889-3-clement.mathieu--drif@eviden.com>
References: <20240704144737.996889-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240704144737.996889-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB9499:EE_
x-ms-office365-filtering-correlation-id: 078e6f02-8941-4a44-235c-08dc9c384c78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VS9OVEdsNDFVdnNCQWx2RlpoemU3VVNhQUY0YXZQWlROTEs5ZmhBUXNLdHYx?=
 =?utf-8?B?azFJSjVYbWxlbHJYWThiK1h5VzNrUlhoQkM5aEthUDdXZStyWlVYeTJpOVBX?=
 =?utf-8?B?aW9zQXlqOElNbFBPNHVhY2dIOERkVVhIN1lQQ3hUNG92STFFcGVGTnRYV3ZQ?=
 =?utf-8?B?MHVIS2xUcDFnZHZLa3BHZnNRVVBxbnU0RjJEQzZneHQxNDlrbWtpS2N4KzR4?=
 =?utf-8?B?Z1NQQTZvV1hZY2dJUU9RZlRvelhadG5janc1YnpCM29CVStGVU9Yd3F2TEln?=
 =?utf-8?B?NC9rclFVdGxvWmFNN1JYTXhQMUFqZjZJbWhJeW1LRGthRWRnbXBmL29mdjd3?=
 =?utf-8?B?Y1NDVVIxWElQVCt2U1ZaT1hZbEdHT3NQKzJKWDAwYXU4czNJK0ZhUlFlT3dK?=
 =?utf-8?B?T211cHoxdlhRYTRpSnk5TVJscUhRdmdKaHpJa0J2cWZEdUNvcy9iZTZBNDl3?=
 =?utf-8?B?WjNxQ2JYd21xVHZXSzlNMnpWeXk4czhzdzRyRE1DWEtFOUZQSXBFU1kxNmhn?=
 =?utf-8?B?R3lEbS8zSG1Ma0czYVJjQWZWcTBkTXFWN2hBUGNMS1pIcmQxMlRETUhUMTlO?=
 =?utf-8?B?Z1ZrYmk5c0VTV2c2TzF6QmhXZWdDMlNEVkZWcWFjMGFkTDhUWisxcDRGNmpT?=
 =?utf-8?B?Y2JHS2dSMUdwV05rREFxSjg2UVJ4SFlhcksvZDFFTWRYSWg4aEJkbVlqM3NL?=
 =?utf-8?B?L0R4UDAxcnZtaWNhWE91cnpjSHhjbmhiVFhRRWo0YTRUeFFiUFVoeVdHQU9k?=
 =?utf-8?B?MWZLUnM4b0cyMW5UUmt0MnVzdGRaaUoyTXNkR3dMOUJTbkN6UkRIK2MrUDFF?=
 =?utf-8?B?dFl6RnVKTUhNcWZETUpka2QvSE0yNXJteGlJVDZ4RncwOTB5Y2kwMGtnYnBS?=
 =?utf-8?B?MmF3VjdNeVh5LytKT2xkVDZyeFMxQm0rcEdXSUNXaUhwdFkwblQ5elh1MUdt?=
 =?utf-8?B?QVNwMWY2ODE3QzBkSzEyRUVqMEx1QVZmdkF6VW93aVlRVzdkRUExMC9iaThH?=
 =?utf-8?B?b09DcVpkRzJvWXlRUDhWVWxFN0JJeHhFc1VCWkRpYXlFWXhaUmp0ZlhrZzBN?=
 =?utf-8?B?REhJQ3BvQzR3Yks3bUhOQTNKdGQzeGwxdllKVWFTcVQ4UitNMWU0cTA2RTdL?=
 =?utf-8?B?QXFUblNDKzhwQzFXR0pyTG56c3lCY2I1LzR6OXF4NTZKeHV5SmU4Y1dueW56?=
 =?utf-8?B?VUVpTzlBV1lHYWhMNXBwSDdNNi8zZUhpRHdUakcybFMzWHA5ejgxUWRvMHl2?=
 =?utf-8?B?dER6M0d5NWpaa1g0Zk52ZklhUlRaVE9iclIyaURGZGRkdk43ME5weWxnbTAr?=
 =?utf-8?B?Z1NBVmlVS01LeElQTFdLVStUclMzNUJGUWFmOHBwcGRXN01hYTN4cW05cTJp?=
 =?utf-8?B?L2FNZjVIRnNJVk1Na2IzVkJEYUJtSmk4YXlvenRiYkgrT0NNL25rVUVVTlRE?=
 =?utf-8?B?Q0tJc1B3MnVQT3FYWFByMHREck85aDhpa3AxSlZaQW9lYTBYQldRY2t6VlVI?=
 =?utf-8?B?a1lleVNqelB0Z1RYa091RUpSL1FoUWZvS3pjNVVJUkUvTkNtTjFWU3JKcHpF?=
 =?utf-8?B?UmwzZ1poTkMrU09oOWRTL2YrU2w1K2Y0OUxEY01STVBBYmJna2NuV095S2sr?=
 =?utf-8?B?bmlqWGNWNGpvMnFkMGFRcWV1MWtuUWU2R3c1bWdYeUVrSUNNbGVzY1BDcy9R?=
 =?utf-8?B?U1EzVmlxcGQzeHpqMFJKeXYwbXVzckwyVzFOK3RWWUwwU09zTTUySjlFNW5G?=
 =?utf-8?B?akhYYU9BS2JoVGVHMzJFbGZuY2lpOXZ6VWxzbTA5NjNWT2tTWE5Hb0VsZmts?=
 =?utf-8?B?ckhrVkF2UzRpeVRQdkN4UE53dVNJRU9pNTA0clkxOUJONlQvaEpzMjFFaWNz?=
 =?utf-8?B?RU5INVhMUjlTYnJmK281cTRaaVp6akpkYzZmZE56ZVNkUWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU1MOHJRblJGcTRmTjJYTFduZHVwZzErdVNvUlBlQVhtbk5scS9KaUFZV1Ry?=
 =?utf-8?B?amhhc1pLeE5HdlYyTlN3NmZ0YnBtSC9YTEszMnlkcEZYSW1adzlVU3AvdTZE?=
 =?utf-8?B?aEpzbUlRRlE4NzFESzVMdmRpTHJ4M2tBR25ycm5kakM0akFjdUxydUVEYVZv?=
 =?utf-8?B?WUkxOCttQ09IYnhTMGNvMHdvRFp5L1N2bWw5dmtsai9KeXU0Y0o4a3Y2YStU?=
 =?utf-8?B?SklTZWxvamFqYmthb2hyaDRqcTdjSnhSSStjbk8zSjFLNm5nMWR3QVBkOEps?=
 =?utf-8?B?d096Q1Nqc2JwKytLdG9VTTQxdk91dUI5U2RlZHlLQUZjTWRKdTNtWGpnMWlZ?=
 =?utf-8?B?VGQrN1hxeUU3Nk9neGQrV3JTRXZ4Q0JMeWRmVmZLVytHTEh5L1ZpcDBWNkNu?=
 =?utf-8?B?ZXZ4amtldSthRlg0WDVGZE9Ba2M2S1JHYWJxdXNsNkxoOFZSZU51UmNqQThr?=
 =?utf-8?B?SjY2YUhLWTlUWnNFZVVEb0RKemJBd09rdldPYnJWdXBPODhaUWVRS0VsbWY2?=
 =?utf-8?B?MDJZTXc5OVNjVkpORXl6OHpjOFplVzMwUWdkU2lHam9vQ1hSNWlub0tYcU9G?=
 =?utf-8?B?aWFIelNCYi83TFhLOFdlN1NZLzlrTEp3M3UyeGYwOC9xMUJ0ekdYTmszVFVI?=
 =?utf-8?B?R242VzF3L29UYy91eVExL1BCQVh2RVZHWEVVRDNzR3dWcUxEOXJGOGlKZGNO?=
 =?utf-8?B?VDBsSGV0RXNDRUl3ZUNtbk9TTmpTd3UzdnozS0UycThVQmNXRlZXcjRvVmg5?=
 =?utf-8?B?aFpqMkI2bkpjVFlOeXBiaWp2NXQvdTM4L2o0LzRUeVAxSlJDZUZZVWNKRXN4?=
 =?utf-8?B?MnpIODhFekVIKzRlaDlaNWxMZWlXTDlBOHVoVFQzZkVqcWM0RXlDeUhCUFJx?=
 =?utf-8?B?bE94NmN3LzdnZFBNc2hYZTFzVmVHMVAzamZrc1duVWRGM0wrSWhMSjlJbHV3?=
 =?utf-8?B?aXYxdUpTeWZLL1VzK1ppMjdDSFJuNjRscDNOSGx1MlN0VHgwTzJ5Tnp4TzRU?=
 =?utf-8?B?bklUVmY0NTBoekRSQmZ5YXMxYlFKSkdKbzlSNG9jYUs4SklXZVcxdWowYnV3?=
 =?utf-8?B?RW55MnlSby8vakdSbFFZeFJYVXRraFZaZHhLUER5cGFzNHFRVllwajhZbGx1?=
 =?utf-8?B?Z1M5SXBZYlUyVllxY2VNOXNyTmJYMjRTbVQzeCtScFdlbXdxNTVUWkppTjFq?=
 =?utf-8?B?V2E2YmNNU0liMjdUVXVQQlNjVGZJZ0F6cWtBNVY5ZjVxc0VYaGV3UFlKVDZL?=
 =?utf-8?B?dlVMVUtjU04vWW1aWXVKNXRYaUhvOGdhNjgxajNqVkZXbGdtSDhuOEVwT3Vp?=
 =?utf-8?B?S1owbUpaWWFhUzRqZUtvSHFUdWdnUVBaUE9la3BIbjgzdWU2d1QvZ1cwTERT?=
 =?utf-8?B?NnBVQ2FpY0FDbGlPSTFkaW50ZVAvUnBxV3pMVCtUMmt0TWdLNmpudk1LSGpu?=
 =?utf-8?B?M21SeUhHVEdjS0l1V3pRRUdzazRjcC9Tb2lXQytVcU9nSEhFYXRBeUlQSE1F?=
 =?utf-8?B?ZUdaKy90YkhHbHRnRWRoejFCMTN6SW9hUHVsdnp4RVdWSHgwSFovZkJiN242?=
 =?utf-8?B?YXAvZ0VNRmhDcVBGQTdmRWYyUXBLejBtUUlPbDlwcnB0dG5ORVdyVm4wQkpG?=
 =?utf-8?B?WlIzQ1JGWTRsckZSTTlmV3g1WnhrYVltUC9WYWc0a1FkSDdmU2k3cldOVGFp?=
 =?utf-8?B?Sm1LZTFodGhZN2FZN3E2T0hUTFFNdGlWa3FsT1AxZlJaUEh4S3p2NmVHTkpJ?=
 =?utf-8?B?b3lraWkvdkdKRjh0VmprY21kSzEzak1uWW8zU25ncHZPZS82bWJyT0lNSkx5?=
 =?utf-8?B?MGo0dXlQY3NyL0VEV2l4VkZIUWowWUdnOWdoK1M4VTdiSGxheUdHaXBDdWM4?=
 =?utf-8?B?bDdPLzFyOHM5SFRBMWQ5NXY5QU1iQmJuMDM5b3JyazZYazgxbXBkSVA5c2ZP?=
 =?utf-8?B?R2lzWitvYVZZMWlISk14a1FLSWJTdktkMm5pbGRxWnRIUVpkVldGOWVLRFdW?=
 =?utf-8?B?YS9tSUo1R2tGa2RTVWo2Z202QUViZjVIVHNmR2pTekJFNTMrL2NocmVNK0Zu?=
 =?utf-8?B?MjRNc2M3cHNNUHczSEVGRW9YY2FCS1JSaHVqSzFUQlVIRTZWTUc3dHhCY29S?=
 =?utf-8?B?Vy9qZTZ0N1c4SW9NcTJDeHZheU1BRzZZRUwwTlVveGs2WjdwMm9ueHFlanlo?=
 =?utf-8?Q?9PvNBEAKh4NoIYz7+F0Qwgs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C95DCCEFFB92EA42B95B98CB5A49BA64@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078e6f02-8941-4a44-235c-08dc9c384c78
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 14:47:59.4631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FWo9zLY5LXmPcvzneebd2UALRQFOHmy513cPPXABLK90QV1lzvoAXZ9/Sfx0ziH0AjYS/12nsXHFQreA2Nsu0ssmF+xQLCozBUkg6c5yOsa6dKU4SL3OnnQEsaLsxYSj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9499
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

RnJvbTogQ2xlbWVudCBNYXRoaWV1LS1EcmlmIDxjbWRldHVAZ21haWwuY29tPg0KDQpUaGUgJ2xl
dmVsJyBmaWVsZCBpbiB2dGRfaW90bGJfa2V5IGlzIGFuIHVuc2lnbmVkIGludGVnZXIuDQpXZSBk
b24ndCBuZWVkIHRvIHN0b3JlIGxldmVsIGFzIGFuIGludCBpbiB2dGRfbG9va3VwX2lvdGxiLg0K
DQpWVERJT1RMQlBhZ2VJbnZJbmZvLm1hc2sgaXMgdXNlZCBpbiBiaW5hcnkgb3BlcmF0aW9ucyB3
aXRoIGFkZHJlc3Nlcy4NCg0KU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8
Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lv
bW11LmMgICAgICAgICAgfCAyICstDQogaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwg
MiArLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dS5jDQppbmRleCAzN2MyMWEwYWVjLi5iZTBjYjM5YjVjIDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9p
bnRlbF9pb21tdS5jDQorKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCkBAIC0zNTgsNyArMzU4
LDcgQEAgc3RhdGljIFZURElPVExCRW50cnkgKnZ0ZF9sb29rdXBfaW90bGIoSW50ZWxJT01NVVN0
YXRlICpzLCB1aW50MTZfdCBzb3VyY2VfaWQsDQogew0KICAgICBzdHJ1Y3QgdnRkX2lvdGxiX2tl
eSBrZXk7DQogICAgIFZURElPVExCRW50cnkgKmVudHJ5Ow0KLSAgICBpbnQgbGV2ZWw7DQorICAg
IHVuc2lnbmVkIGxldmVsOw0KIA0KICAgICBmb3IgKGxldmVsID0gVlREX1NMX1BUX0xFVkVMOyBs
ZXZlbCA8IFZURF9TTF9QTUw0X0xFVkVMOyBsZXZlbCsrKSB7DQogICAgICAgICBrZXkuZ2ZuID0g
dnRkX2dldF9pb3RsYl9nZm4oYWRkciwgbGV2ZWwpOw0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KaW5k
ZXggY2JjNDAzMDAzMS4uNWZjYmUyNzQ0ZiAxMDA2NDQNCi0tLSBhL2h3L2kzODYvaW50ZWxfaW9t
bXVfaW50ZXJuYWwuaA0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQpAQCAt
NDM2LDcgKzQzNiw3IEBAIHN0cnVjdCBWVERJT1RMQlBhZ2VJbnZJbmZvIHsNCiAgICAgdWludDE2
X3QgZG9tYWluX2lkOw0KICAgICB1aW50MzJfdCBwYXNpZDsNCiAgICAgdWludDY0X3QgYWRkcjsN
Ci0gICAgdWludDhfdCBtYXNrOw0KKyAgICB1aW50NjRfdCBtYXNrOw0KIH07DQogdHlwZWRlZiBz
dHJ1Y3QgVlRESU9UTEJQYWdlSW52SW5mbyBWVERJT1RMQlBhZ2VJbnZJbmZvOw0KIA0KLS0gDQoy
LjQ1LjINCg==

