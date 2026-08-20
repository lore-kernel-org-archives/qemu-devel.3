Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D09C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 00:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwqmw-0004nW-T5; Wed, 19 Aug 2026 20:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1wwqmv-0004n5-AP
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 20:37:45 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1wwqmu-0002Je-0e
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 20:37:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEYGHursbgflcUfLPK9u8/pFguTaXlbfRIDfBrhzYwLxuBiw6fDH2eSFkfWZjYt3xRdaboWDBxCwb8A0w3iT37K3dL63H83fgLFg1FKy0H2I3itZxdQWlIX+SLgPhbauyeTfG44t2nDbPGxa7JDjzj6vYssxXpdT/Y4r8b7zvmBjcdvzflZv4O39Yt1rKPirEl0blSOY63kIYwWRY1bxCv1X1oRonL4EHBWsY2F1kFOmoXOBw4N/kSTFYtXYpJaVnZ40GjCo3+dJXIsivGJNpLhbdnwBo0j+RadI2JbgQMPx64Dk+17wdPujrkXr6Ht6HjoUpgsSCR/NZgthxU8pog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UV2NBQmbQ5s6QU4NcHkrXFwDc5Q4BcUZkIduMJYSZ9Q=;
 b=KjLP0k7ElEGzjpFMPZx3unBT+6Ygw+cgdSxQJR0MeRsAvFvvzijUaZGJY5+2qmFkrxdq0JdX/NkxRUtYpZ72KgWH1aRcjXtcEbCptyvRxw4K0QCBNvuLzr2+Zcui3EhhL6sxCYmbp0LmQx5o2GMa/dpsHGS0HpdvJgb8deL8RGPS0gfc5gckAszR1LssYsmKRnWqDYHRe51BXEUxYRrXiME/609ABsHakGnSWxMqn6SUpQGsplwc1c8BeiuRDQh9/dUc5C5frCPUHGk6/SX41j82TrFmnsJUtXVZ6DHXVkDPCiy2ptwk/I2VRm64GvE35PaJx/mULT5Cdi+B54HXsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UV2NBQmbQ5s6QU4NcHkrXFwDc5Q4BcUZkIduMJYSZ9Q=;
 b=YDA6zKNP11+BtMDVz6lCmNo2khDyeIX0Cf2FfC+LCtiishPFl6EkfVoI1T1ui708qOPpq954wunqXkXB/BvNp7QKwikkSd+bKGgSz/2ea7zhhyqxN3XDiCDyf7c1RHeKgHZm2155jj4UpBkH3WZ/MpQMHZtlQzBYF4FeHTrLBtg=
Received: from LVXPR21MB7009.namprd21.prod.outlook.com (2603:10b6:408:37f::24)
 by LV5PR21MB4995.namprd21.prod.outlook.com (2603:10b6:408:2fb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.0; Thu, 20 Aug
 2026 00:37:39 +0000
Received: from LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc]) by LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc%4]) with mapi id 15.21.0315.008; Thu, 20 Aug 2026
 00:37:34 +0000
From: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pedro d'Aquino Filocre F
 S Barbuda <pbarbuda@microsoft.com>
Subject: Re: [PATCH v2 1/3] target/arm/whpx: Don't try to sync ARM_CP_CONST
 registers
Thread-Topic: [PATCH v2 1/3] target/arm/whpx: Don't try to sync ARM_CP_CONST
 registers
Thread-Index: AQHdMDwXU+j7n7YPcUKgvvdkr+afmA==
Date: Thu, 20 Aug 2026 00:37:34 +0000
Message-ID: <LVXPR21MB70094332960604D62C736552ADA42@LVXPR21MB7009.namprd21.prod.outlook.com>
References: <LVXPR21MB7009C0007D22503C38FE053EADA42@LVXPR21MB7009.namprd21.prod.outlook.com>
 <EB90ECF3-E5ED-4F1F-B071-BE58248D305C@unpredictable.fr>
In-Reply-To: <EB90ECF3-E5ED-4F1F-B071-BE58248D305C@unpredictable.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f65c3948-c369-4092-a062-9ab9627f5d75;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-20T00:36:25Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVXPR21MB7009:EE_|LV5PR21MB4995:EE_
x-ms-office365-filtering-correlation-id: 011ba6ac-037f-4f3f-a602-08defe533a66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|38070700021|10067099003|7146999003|56012099006|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: +U1nv8IVvFooFYmzu012W6mKgV8l8bLhXAcN5KjuUn0K3GCWwhKX44hZIZ9gJqs0QQ99b/Jtt24RpYED3iKAq7D8XadcHh2AZp+SPJOEyusSswnXPzj85pFIL0/TSQ1hDNXT/08vYMKK9AB4hHl9Cv8l6I/Mxl4mrsD4JbRZBmOnYRSIKvJVBLjrxqYSGH1p4g9GEUsnFw0khH1GrvErCMo44t96uPmAUq1jWmGWEwFedctDi5j/V2l9wXbChdXhDtP35st5e2+sL1TjHeeBlLYE0+MksFg63S1fIy8SXHQ0sdZNaRvy0X1QJgu/Zk0XxOehkkfo4aWljudnLftelp+HQSZLRWUHeVlI9JaOppjDhx57pSrLeCEGHqwwV69b8t0mjLhJWJ7Cv3QpfXENlrAJOxMteNyq4CIf9ARbXqgMxp4M5sNRrrzRDhJHy3wLiofahIxrl51rGF5c3KM/lWyCxNcmLM4tckodcGq4u+yV6sBjXTq4Cmlgfktxc7EyQ4jbgJtzn+HzY9QmkV4gV5aHXkSBBtjCBlJJhksbdNPSSz+KC/7JJyucnhhclKzX88op8/etx5wG/VjoftAdfyR9LXrQ66Nhdc7Zxn3DYV3gC1GrnqUOY4wNt1rtwCC7fFz9VbwRCwYxvv7vIIFWqew77yrO/8WWAWvRYE9G3u5Ev+WDXkPqkZP6oykN5T+hpMSMh7hYrMqcx8w/Wx5VzIbCNA1Zz8NwTMgdu8xMQxI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVXPR21MB7009.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(10067099003)(7146999003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PLKusjR1C5t2s3t0g9EMHkYXfqXwccaEXXUHltw0gCK/hsjTZiR+RSd2IFKE?=
 =?us-ascii?Q?Pvf+iXQFblhjuydYtAM0Tg3JWUYQJGPchaOhjy5D0XZXqdFgIN2b2TJ71CIO?=
 =?us-ascii?Q?BiFL4T7RMvGUqUohxs8CPKIbKC8rxhr4MiVyuAiN4kmziutCLMs9VcceEJFu?=
 =?us-ascii?Q?7QJz2YpPvq98kog/qBq0RdXeLwKdTcA+LdmUNKexWC8GPj3H33m0UCsSjY2k?=
 =?us-ascii?Q?i4xZiKkZ8NT9/D5F+FNYAwMDl46MVJrXmc/dRUDrOWd0XihHCWJoGEC4CTp0?=
 =?us-ascii?Q?KPdLebEspSsOB4p/x1YccYlgMkTwD4yM5kP8m5oj3xuo315Y1V6lPW+OiKLj?=
 =?us-ascii?Q?4ftR1xj290oFZOYnO5q8b71xJGNF+cK6Ez3rsRjLX2W2fLoUHRIB27MuBCZk?=
 =?us-ascii?Q?GMdBS5nV75pRU51HcGdmhsMLYBVhjOfb4FP1KJDURk9qAtIgA7IklKEXV3tN?=
 =?us-ascii?Q?5znGPE0bf6SJcK/DObbp47hitcZ5uUhjNvqHUh+k/vGQ4SL92FQ5oTQ9cHt/?=
 =?us-ascii?Q?NMpTfZ6Ko9kWpJFmGUmSIhAmSF3WKA69dDMfnUik/T3CdFR9lvfcgMX5R+Zb?=
 =?us-ascii?Q?bnBiaMkumXfxkt8moDkN3BGAY+aPsMMrYGMsin+mJa70DD7iJfJv8NsGvchw?=
 =?us-ascii?Q?3f3jcW2nplaaVsMA0AE1Rwxzu+bvN5p7DEc2F9GoQQ1xEcUV6WqEgNRz2Auk?=
 =?us-ascii?Q?AgTjSt0KPYyuE6AoDhLmV7evD8cLbgnoYxEuVzYjNGWcsiBW4aAmvwzEx+nt?=
 =?us-ascii?Q?D7yqefSD+rT0J3/MXBuaoeKwb9fValmNBDFL4uYfKh5lr54ilyUuSb+3LR4M?=
 =?us-ascii?Q?hvGGleULIYa5uYlNz2qf+9VpMObtWO4Q6kkqp9ajEJHPDTsS00RqCjbKpsV3?=
 =?us-ascii?Q?lsxfUc+aT9aPrnhcQ25rmEbVR1vOM/oga9vkMTBZM/gdtlVxrFhIKwCTnxPE?=
 =?us-ascii?Q?x6JGNEXhbySr2ATn4i5Xp873Iw8GIVnJDlEYNdoLQtglrGOZpmHzU+0Pzos0?=
 =?us-ascii?Q?/8awiJpBK8ApaCayLLla5sME6SteY1eleK8dtIYNM5J917dA/pCgYvU4ejKU?=
 =?us-ascii?Q?z5ezCLWhE1oWQSGx0XRGq/EschUtIvQP4SR1Lq6tjmjNuTfZexyBdoU0CKoM?=
 =?us-ascii?Q?WVbRuSEzWuhT/wPftb8V6RA3bqtkPu0xZ5TO5dpmg12SLNoMQUOiBKngpfMQ?=
 =?us-ascii?Q?rpWDwJXjL/RPnorNfkwi0YP92uxWkjP3PJ5R0Th5XXir0TvN9Kk5ilSazfoB?=
 =?us-ascii?Q?zgGpnxdGNsfkaQeq7wmUv+6mlu17BCT4ejH38mgezjfnTaqdVLA7lsmiX4Tg?=
 =?us-ascii?Q?wxS+34RHpCDaYOf5NazQLyXrr6FwTV84C2pRIym/DSt2GWUdV3X6yBSozWv0?=
 =?us-ascii?Q?spTobKXz4Tjjx/zVCXAX/mG5TWxmp3wUw+FYzQ5LOBlMRuHXOPKIeP7pkkO1?=
 =?us-ascii?Q?LQSVd3u5vbmT4MSDmd8EyXcydJi0vhWHF7t1Q7QpSHyD3aqGMFKHQTgP0VqQ?=
 =?us-ascii?Q?wsQydzgJh/UfsMDiNZnlvrgGCsGjC+K87lqNFahs2SyHDILDl/HaxaiYHMgH?=
 =?us-ascii?Q?Oph83eTRfepHzPT7hWSiV3fPeggTlHuPeZUjZCb1R7O6HN11hywhKAeuba6K?=
 =?us-ascii?Q?328gzrGXw3p1KZ1M+rCuMJUbzQyjkWRBsKsF8dtk+TQ8DceYoO+XjPptzwum?=
 =?us-ascii?Q?bq0MuEWCrQLvCP6PBxNHkJ3x2/ilGsmxHdLjnkWBGLOKm8PB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVXPR21MB7009.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011ba6ac-037f-4f3f-a602-08defe533a66
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 00:37:34.8338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lRT7izuoHP69e/QA6dCEQNM73xJJ6N8n04mhXzrUfV6Y+gfrljFUWU/+JRERQ8tqBVKvbmdt8N5ShF3cSLXB7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR21MB4995
Received-SPF: pass client-ip=2a01:111:f403:c107::3;
 envelope-from=dcook@microsoft.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

> >         ri =3D get_arm_cp_reginfo(arm_cpu->cp_regs, key);
> >         if (ri) {
> > -            assert(!(ri->type & ARM_CP_NO_RAW));
> > +            assert(!(ri->type & (ARM_CP_NO_RAW | ARM_CP_CONST)));
>=20
> This chunk is no longer needed after adding the `#ifdef SYNC_CONST_ID_REG=
S`
> bit above
>=20
> >             whpx_sreg_match[i].cp_idx =3D sregs_cnt;
> >             arm_cpu->cpreg_indexes[sregs_cnt++] =3D cpreg_to_kvm_id(key=
);
> >         } else {

Seemed like it would be useful to make sure we didn't accidentally add any
new CONST registers in the future.

