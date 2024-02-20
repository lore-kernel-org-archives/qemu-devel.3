Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA00C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 18:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcUdu-0008SF-Ba; Tue, 20 Feb 2024 13:14:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rcUdt-0008S6-89
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:14:57 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rcUdp-0002RP-4B
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:14:57 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41KALLG1016729; Tue, 20 Feb 2024 10:14:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:mime-version; s=proofpoint20171006; bh=fCYooww8ipZ
 Ny64Yjz3/Xx6EZ8fVxmBedPxRWVGgA9E=; b=M/oU+qgjSLjs3G56g1bFeJXA+wc
 W+JiCSFEZvKB4RIABGsEQ5clXdkz+8LfqhdnRDQZgt87EG3cdp3ynC5sevu3njIv
 OB1j4RKjWzVmA3wo7WvRy5+YsZ3xwHx3/Ml16RRddTtV7AFlF3NaQ26GnoOuR6Le
 8DDL29YDJ0zbMJjzV/qdmeIk/89MaE9hH77XdnKqCD8PYgevak2b1Ju5uESRebf2
 MITX3luXFCoW12M5OKpw8ieB9UNnQHlRkhwyrhC+M+CXw29sobBf1ViTuxw/hg75
 DwlmwmNjthJw3P14h3wWO1/IFvDi9RHl1i7lBGaLTE6LpkgmWZW0hL/i/Og==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3waw0gxpca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 10:14:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1KUTP5l0xBiZ4a4hZ9rtaiqD0M07ZODUv8nghyn4wqkQlwLZReHWqZm1Pq6MwRHIqp60LUQQSHHL5X8RFHPzqZAbMJ+H2iF5ha2j9MVvf/qyQ1WuNYaR6mBHKR6GVhyJii9iZ1/o/5voMoGWwggG+x9O1EbonwoKgWw8Y7d89zPNFRiTbUCWBPzrb7Bw1C9APOm8J8oLmV+HfBuQ7ryGeA9+08S+wHAGZqcE8iVf+G919xIH/Bpg6EzpUwdzIsz+58Q75Lh9xVn5r82Nt5EGgYTell8gRtppIO9Zgn/nPX0ZrJDAlb1NAaPNtnXnV8r9R0PF1pzhFELJW3t1etXFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCYooww8ipZNy64Yjz3/Xx6EZ8fVxmBedPxRWVGgA9E=;
 b=DX/P/AvsRkCcM4+54IHHrARxTf4Kiu0KxDaOStj4G0JyWYaJki3ZvNvJJanzYP9LzDoxwIjiS1F3K9cKMwKtlayWKK7FLRfTmi66Jf4isP8FFUoh1sSk8csTqsFIHKfrGDErXXC2mb2ZNA9gCfqs8/vjIlpcTSM1Nr8IG/UyYh1+NCSWmAosMhzdlLjalbF3Mu9UFLGYs356wsaggqaFnKzrZ5Imm879UMmb8cuR858xad3wOZ5YVh6IfKZfJf69FiuDwfw5K2Htu/iuwjZh9ruvdjWeOPBMBvY7zGy9LBs7HV2dX2hoNF45wi/HuDSiL8oi4DYO6RPqg6IPB6kyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCYooww8ipZNy64Yjz3/Xx6EZ8fVxmBedPxRWVGgA9E=;
 b=of/tWtvKiiTj22fkutjmcNU8mqSlutc5yB94c+eTyctVodxWCOmXkMh7zIkm0evaN0/DrUnnNZrcCXi/X3FAbZZTwWIjyOK6+VPfPfYXpktVXYkPMAL805Zlgr1p1u0NHc4l8KS1/xWteiQp3kZFsCzAsKkVUUHviMg6QC4Lxb5c/7vs/f3tqpzZqK9LbPS/bMJzxIH7MT1w4utAEcuGc8GvE3u+J1d84fropo9EARWwipKDCKyFBS+UhvGaI0yNjMBkXYYEG+BfNSPWWJ5FZL5FASDPKsjuUG+Mjr8y1SDnDA0GJWHBNHJEStZJma/QiQWWnDSdG4yDpAhPjA8MlQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DS7PR02MB9473.namprd02.prod.outlook.com (2603:10b6:8:e5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.31; Tue, 20 Feb 2024 18:14:46 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 18:14:46 +0000
From: Het Gala <het.gala@nutanix.com>
To: Peter Xu <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "armbru@redhat.com"
 <armbru@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>
Subject: Re: [PATCH 1/3] qtest: migration: Enhance qtest migration functions
 to support 'channels' argument
Thread-Topic: [PATCH 1/3] qtest: migration: Enhance qtest migration functions
 to support 'channels' argument
Thread-Index: AQHaYLdw22HuV77oEEatSv767gPgurESw42AgACvqpc=
Date: Tue, 20 Feb 2024 18:14:46 +0000
Message-ID: <SJ2PR02MB9955B1E7FDF128EE745F121E98502@SJ2PR02MB9955.namprd02.prod.outlook.com>
References: <20240216090624.75445-1-het.gala@nutanix.com>
 <20240216090624.75445-2-het.gala@nutanix.com> <ZdRAo3XJ9xvs6Z4Q@x1n>
In-Reply-To: <ZdRAo3XJ9xvs6Z4Q@x1n>
Accept-Language: en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR02MB9955:EE_|DS7PR02MB9473:EE_
x-ms-office365-filtering-correlation-id: f31cb0d5-0d3f-4788-6cd1-08dc323fd1ba
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AKphJ70nJ7ZqlH9FOP+Jp3SQxzVB5akhW3YvfWOVz+IVJODhlQEsVaKMtEL82zx3a00QPUavj+y5wu8itwItMTtDf58A7M6ZLev2gch+Hnd9QybclFjOGR5RiYCEgE2lpeVIvmrf0Y9N8tLAiLjRuNKAUFCwj5O6vX/v+UrFjdt+FJEdyAgkRNG3sz8+d2oCXAyg75JSEwUN3PiZEFSPwrPq8tU+a16Vft2YGOMvusumQnbyOS+V7N2PzHU8zw0eN0DiiR8tnY/Ij7+56RG0Yc2b9W6xP+vhH64NO6VG/CyU9jKczWoAbgV2WwO8zHkF5wg5p6/ehMle+OmbY4Jl7c8pxdaglXPn6o6VYBNK4ilcbNKwZcvx3cYqj6BMy7/cbypn7dMfTFmimJZMZ9xjp5xB0iQBGeUTgIhNJjrQf8OIdx1MeL0FTTEPqjc23ROs79RdonpbfHgfu8P6uEOThv4IfnQr252iSp1tedYC1zWIxGEa4Mh5WsBDhcEUPP9Amxqu3veH0TccWAxQAoUXWEz4MnAz895zXsn0nZtci2g33tWCGhYjFTRtcvGVNQLcDcp2leX98E1E7LRRWxTYOAmSBFtlmz6+essNI6deoQyiwkpcpybulV5WiJijB+dA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?pNikEmjWWGPbcgt4y4edvk/MgpjopoomP52fK4MjQuhcNtr/cZ7F4uSz?=
 =?Windows-1252?Q?IH6yp1c5kBt3rbwiUvq2S+eD9XCkfOrsL6JIAKgbKe51OAS0E3yJxrv2?=
 =?Windows-1252?Q?w2iah5lZ+DvogNDdcl4k06jFqtiKkqju3lAztQwvj7AcEb3MQJn3QDan?=
 =?Windows-1252?Q?s9qcxwAL8bPhFPT5QZGpvEETkPXQ53l6GkIdVGqj6mLr+/J3bFMcAC90?=
 =?Windows-1252?Q?Sa/fNy53XZPk9bPpB+aYZfp3h8UVSQ4r9t5CPavdZkvzgRfdI8hk7jNJ?=
 =?Windows-1252?Q?fAibY3dr4/2DSI2A5WqcHYtHfko3htKHBG1PySl2NadXwRi0W8Qu+GVy?=
 =?Windows-1252?Q?M9ODO2MDCyD/ZXWBW5+XudfG9o59QM70SClFYf3KOqYdN1GluBp/vPib?=
 =?Windows-1252?Q?r6PEAbQ6byp1L0QoyenCSWOeNb8sD0a6q6JcCyXtC+0R5thbxCeMo/ez?=
 =?Windows-1252?Q?2FR5srZg4oO4n4Cs8Kor1bYdzX2Kpy30VbPxxzIumurdXRDO38y5UJXt?=
 =?Windows-1252?Q?rUitRTD0OOb6Eyl451djyBgGyv16sTsCry++8BvDACJ1YPdo4ZxGjCd4?=
 =?Windows-1252?Q?cll5ScyNLdeHnr7c4DRSiFnw0TEcUQmvs8QsuMIOitzM8UdNXZEsOv5+?=
 =?Windows-1252?Q?/zdKdJ7bEG79z/It9OqAh3hnf+n2Z1UhQQYxBxc3dLpvkvH2PcCPqm9/?=
 =?Windows-1252?Q?WVwCSzJrezI/B0zAUHlMPpxexYR8RoahyREmp28vA9ftz78diCsdxoQA?=
 =?Windows-1252?Q?Ck438a6BVBxwjCJ56xCaFctENWv3C3AcX3wAVFD45wBcqwyF5qU/MQAW?=
 =?Windows-1252?Q?PKjP5BeHC2/p5LAOkbHOck5vvMHUQFLeLqWSLfKBj6doGW7VzT52IuOp?=
 =?Windows-1252?Q?X/FrmdUXS94EQLXK2jetQbDKeW8RmFbjIWaAFoOiJ+DxIzLIYN+wwpFe?=
 =?Windows-1252?Q?len8csV20rYAyMnXcLqHmyIgFfVKVdRiSx3KC2mqNw8Xbr+Ofhj22KZo?=
 =?Windows-1252?Q?lYXzDD9O3Sz0s68i2JBpVHFx5NNOtKPyKSHhv8Y/xX/vIZRuXNZ6i6Lw?=
 =?Windows-1252?Q?mppjYgK4OAo2dCNKtW1Ugd0neWAim7V5+OccTu0AJ1V+JVVGJqCNKHv3?=
 =?Windows-1252?Q?xFZJX1r0bzgZiZzjiv6NjguSC8xm1WQPlZ3V9v9AKjSpKo6d+YX8ITlA?=
 =?Windows-1252?Q?LlesAxwk0IX0RP9GCkfwstwti+wXUZXb2HA+XOAB3P3i2T+Y2Xegsqfg?=
 =?Windows-1252?Q?VUu46+6lWX5Cg0f+KvDvdNXrRNeFiV6a999NqWDbcl/8wl9/XlXJh6Us?=
 =?Windows-1252?Q?fkrvv9JZznqXJ19W/x51FRnWFM/28BZSyam6MShQTyrZhwwo/UHCyLaU?=
 =?Windows-1252?Q?oe/xqCr6Zi+Y5NsYphi5XJuyyt3a7sctN2xuERmyuut37dZO6fkDBxie?=
 =?Windows-1252?Q?KbIim/MHGejWEgKg43WGSLWtuLoe9MAoHT9ZJInxAQ6gBWwy79KhnBSN?=
 =?Windows-1252?Q?hm/3PaSkZ24SjGuXZcNpAfHySwQUS4aS70yPGU9L8eW7lViY0uniSNm3?=
 =?Windows-1252?Q?3Siy7mf3uvRWxUmCGNf+0Mzr2kOchjSd/NptFhmeGVLktfW13+QjSomA?=
 =?Windows-1252?Q?gxN9Yu9vYWBBQNd9ZgCsE3L2At48R7vbVg2AfOxW1qyeHA46jpiSoz4T?=
 =?Windows-1252?Q?NnRL+4+We0d1KFp+l7nFKYpEAPTrMC8Aa3hHYw51Ja9B7wCp7fBdRg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR02MB9955B1E7FDF128EE745F121E98502SJ2PR02MB9955namp_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f31cb0d5-0d3f-4788-6cd1-08dc323fd1ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 18:14:46.2383 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IvPnG3JX5sMpQAt4vq/3DTUybcMJQ8oaLjWy9Gb9uTr7tqD4Nj7cVt06mN73DbFXCe/Tebz2YeA5wO/tGdBuCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB9473
X-Proofpoint-ORIG-GUID: slqyyPGgAt4k2RtA7eUn3q6CeIbpHEpu
X-Proofpoint-GUID: slqyyPGgAt4k2RtA7eUn3q6CeIbpHEpu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--_000_SJ2PR02MB9955B1E7FDF128EE745F121E98502SJ2PR02MB9955namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable



From: Peter Xu <peterx@redhat.com>
Date: Tuesday, 20 February 2024 at 11:33 AM
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>, armbru@redhat.com <armbr=
u@redhat.com>, berrange@redhat.com <berrange@redhat.com>, farosas@suse.de <=
farosas@suse.de>
Subject: Re: [PATCH 1/3] qtest: migration: Enhance qtest migration function=
s to support 'channels' argument
On Fri, Feb 16, 2024 at 09:06:22AM +0000, Het Gala wrote:
> Introduce support for adding a 'channels' argument to migrate_qmp_fail
> and migrate_qmp functions within the migration qtest framework, enabling
> enhanced control over migration scenarios.
>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>  tests/qtest/dbus-vmstate-test.c |  2 +-
>  tests/qtest/migration-helpers.c | 93 ++++++++++++++++++++++++++++++---
>  tests/qtest/migration-helpers.h | 11 ++--
>  tests/qtest/migration-test.c    | 33 ++++++------
>  4 files changed, 112 insertions(+), 27 deletions(-)
>
> diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-t=
est.c
> index 6c990864e3..0ca572e29b 100644
> --- a/tests/qtest/dbus-vmstate-test.c
> +++ b/tests/qtest/dbus-vmstate-test.c
> @@ -229,7 +229,7 @@ test_dbus_vmstate(Test *test)
>
>      thread =3D g_thread_new("dbus-vmstate-thread", dbus_vmstate_thread, =
loop);
>
> -    migrate_qmp(src_qemu, uri, "{}");
> +    migrate_qmp(src_qemu, uri, NULL, "{}");
>      test->src_qemu =3D src_qemu;
>      if (test->migrate_fail) {
>          wait_for_migration_fail(src_qemu, true);
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-help=
ers.c
> index e451dbdbed..d153677887 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -13,6 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/ctype.h"
>  #include "qapi/qmp/qjson.h"
> +#include "qapi/qmp/qlist.h"
>
>  #include "migration-helpers.h"
>
> @@ -43,7 +44,70 @@ bool migrate_watch_for_events(QTestState *who, const c=
har *name,
>      return false;
>  }
>
> -void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt,=
 ...)
> +static char *socketAddressType_to_str(SocketAddressType type)
> +{
> +    switch (type) {
> +    case SOCKET_ADDRESS_TYPE_INET:
> +        return g_strdup("inet");
> +    case SOCKET_ADDRESS_TYPE_UNIX:
> +        return g_strdup("unix");
> +    case SOCKET_ADDRESS_TYPE_FD:
> +        return g_strdup("fd");
> +    case SOCKET_ADDRESS_TYPE_VSOCK:
> +        return g_strdup("vsock");
> +    default:
> +        return g_strdup("unknown address type");
> +    }
> +}

Use SocketAddressType_lookup?
Ack, I guess combination of using qapi_enum_parse() and qapi_enum_lookup() =
would help me eliminate the need for creating this function itself. Let me =
do the changes in the next patch.  Thanks!

> +
> +static QList *MigrationChannelList_to_QList(MigrationChannelList *channe=
ls)
> +{
> +    MigrationChannel *channel =3D NULL;
> +    MigrationAddress *addr =3D NULL;
> +    SocketAddress *saddr =3D NULL;
> +    g_autofree const char *addr_type =3D NULL;
> +    QList *channelList =3D qlist_new();
> +    QDict *channelDict =3D qdict_new();
> +    QDict *addrDict =3D qdict_new();
> +
> +    channel =3D channels->value;
> +    if (!channel || channel->channel_type =3D=3D MIGRATION_CHANNEL_TYPE_=
_MAX) {
> +        fprintf(stderr, "%s: Channel or its type is NULL\n",
> +                __func__);
> +    }
> +    g_assert(channel);
> +    if (channel->channel_type =3D=3D MIGRATION_CHANNEL_TYPE_MAIN) {
> +        qdict_put_str(channelDict, "channel-type", g_strdup("main"));
> +    }
> +
> +    addr =3D channel->addr;
> +    if (!addr || addr->transport =3D=3D MIGRATION_ADDRESS_TYPE__MAX) {
> +        fprintf(stderr, "%s: addr or its transport is NULL\n",
> +                __func__);
> +    }
> +    g_assert(addr);
> +    if (addr->transport =3D=3D MIGRATION_ADDRESS_TYPE_SOCKET) {
> +        qdict_put_str(addrDict, "transport", g_strdup("socket"));
> +    }
> +
> +    saddr =3D &addr->u.socket;
> +    if (!saddr) {
> +        fprintf(stderr, "%s: saddr is NULL\n", __func__);
> +    }
> +    g_assert(saddr);
> +    addr_type =3D socketAddressType_to_str(saddr->type);
> +    qdict_put_str(addrDict, "type", addr_type);
> +    qdict_put_str(addrDict, "port", saddr->u.inet.port);
> +    qdict_put_str(addrDict, "host", saddr->u.inet.host);
> +
> +    qdict_put_obj(channelDict, "addr", QOBJECT(addrDict));
> +    qlist_append_obj(channelList, QOBJECT(channelDict));
> +
> +    return channelList;
> +}
> +
> +void migrate_qmp_fail(QTestState *who, const char *uri,
> +                      MigrationChannelList *channels, const char *fmt, .=
..)
>  {
>      va_list ap;
>      QDict *args, *err;
> @@ -52,8 +116,16 @@ void migrate_qmp_fail(QTestState *who, const char *ur=
i, const char *fmt, ...)
>      args =3D qdict_from_vjsonf_nofail(fmt, ap);
>      va_end(ap);
>
> -    g_assert(!qdict_haskey(args, "uri"));
> -    qdict_put_str(args, "uri", uri);
> +    if (uri) {
> +        g_assert(!qdict_haskey(args, "uri"));

IMHO we don't need to assert here?

Rather than doing this, we can also have tests covering when both are set,
or when none are set, to make sure we fail properly in those wrong cases.
(Neglecting your comments here based on Patch 3/3 comment).

> +        qdict_put_str(args, "uri", uri);
> +    }
> +
> +    if (channels) {
> +        g_assert(!qdict_haskey(args, "channels"));
> +        QList *channelList =3D MigrationChannelList_to_QList(channels);
> +        qdict_put_obj(args, "channels", QOBJECT(channelList));
> +    }
>
>      err =3D qtest_qmp_assert_failure_ref(
>          who, "{ 'execute': 'migrate', 'arguments': %p}", args);
> @@ -68,7 +140,8 @@ void migrate_qmp_fail(QTestState *who, const char *uri=
, const char *fmt, ...)
>   * Arguments are built from @fmt... (formatted like
>   * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
>   */
> -void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
> +void migrate_qmp(QTestState *who, const char *uri,
> +                 MigrationChannelList *channels, const char *fmt, ...)
>  {
>      va_list ap;
>      QDict *args;
> @@ -77,8 +150,16 @@ void migrate_qmp(QTestState *who, const char *uri, co=
nst char *fmt, ...)
>      args =3D qdict_from_vjsonf_nofail(fmt, ap);
>      va_end(ap);
>
> -    g_assert(!qdict_haskey(args, "uri"));
> -    qdict_put_str(args, "uri", uri);
> +    if (uri) {
> +        g_assert(!qdict_haskey(args, "uri"));
> +        qdict_put_str(args, "uri", uri);
> +    }
> +
> +    if (channels) {
> +        g_assert(!qdict_haskey(args, "channels"));
> +        QList *channelList =3D MigrationChannelList_to_QList(channels);
> +        qdict_put_obj(args, "channels", QOBJECT(channelList));
> +    }

Duplicated chunks; sign of adding some helper?
I didn=92t think of adding a helper function here as it was just 2 lines of=
 code, already calling MigrationChannelList_to_QList() to avoid duplication=
. Even then if you have something in your mind to create some helper functi=
on, please suggest :)

>
>      qtest_qmp_assert_success(who,
>                               "{ 'execute': 'migrate', 'arguments': %p}",=
 args);
> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-help=
ers.h
> index 3bf7ded1b9..52243bd2df 100644
> --- a/tests/qtest/migration-helpers.h
> +++ b/tests/qtest/migration-helpers.h
> @@ -14,6 +14,7 @@
>  #define MIGRATION_HELPERS_H
>
>  #include "libqtest.h"
> +#include "migration/migration.h"
>
>  typedef struct QTestMigrationState {
>      bool stop_seen;
> @@ -25,15 +26,17 @@ typedef struct QTestMigrationState {
>  bool migrate_watch_for_events(QTestState *who, const char *name,
>                                QDict *event, void *opaque);
>
> -G_GNUC_PRINTF(3, 4)
> -void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)=
;
> +G_GNUC_PRINTF(4, 5)
> +void migrate_qmp(QTestState *who, const char *uri,
> +                 MigrationChannelList *channels, const char *fmt, ...);
>
>  G_GNUC_PRINTF(3, 4)
>  void migrate_incoming_qmp(QTestState *who, const char *uri,
>                            const char *fmt, ...);
Just thinking, should also add =91channels=92 argument here I guess, would =
be helpful in future to add some tests where only =91channels=92 parameter =
wants to be added to the function ?

>
> -G_GNUC_PRINTF(3, 4)
> -void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt,=
 ...);
> +G_GNUC_PRINTF(4, 5)
> +void migrate_qmp_fail(QTestState *who, const char *uri,
> +                      MigrationChannelList *channels, const char *fmt, .=
..);
>
>  void migrate_set_capability(QTestState *who, const char *capability,
>                              bool value);
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 8a5bb1752e..e7f2719dcf 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -18,6 +18,7 @@
>  #include "qemu/module.h"
>  #include "qemu/option.h"
>  #include "qemu/range.h"
> +#include "migration/migration.h"
>  #include "qemu/sockets.h"
>  #include "chardev/char.h"
>  #include "qapi/qapi-visit-sockets.h"
> @@ -1350,7 +1351,7 @@ static int migrate_postcopy_prepare(QTestState **fr=
om_ptr,
>      wait_for_suspend(from, &src_state);
>
>      g_autofree char *uri =3D migrate_get_socket_address(to, "socket-addr=
ess");
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>
>      migrate_wait_for_dirty_mem(from, to);
>
> @@ -1500,7 +1501,7 @@ static void postcopy_recover_fail(QTestState *from,=
 QTestState *to)
>      g_assert_cmpint(ret, =3D=3D, 1);
>
>      migrate_recover(to, "fd:fd-mig");
> -    migrate_qmp(from, "fd:fd-mig", "{'resume': true}");
> +    migrate_qmp(from, "fd:fd-mig", NULL, "{'resume': true}");
>
>      /*
>       * Make sure both QEMU instances will go into RECOVER stage, then te=
st
> @@ -1588,7 +1589,7 @@ static void test_postcopy_recovery_common(MigrateCo=
mmon *args)
>       * Try to rebuild the migration channel using the resume flag and
>       * the newly created channel
>       */
> -    migrate_qmp(from, uri, "{'resume': true}");
> +    migrate_qmp(from, uri, NULL, "{'resume': true}");
>
>      /* Restore the postcopy bandwidth to unlimited */
>      migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
> @@ -1669,7 +1670,7 @@ static void test_baddest(void)
>      if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
>          return;
>      }
> -    migrate_qmp(from, "tcp:127.0.0.1:0", "{}");
> +    migrate_qmp(from, "tcp:127.0.0.1:0", NULL, "{}");
>      wait_for_migration_fail(from, false);
>      test_migrate_end(from, to, false);
>  }
> @@ -1708,7 +1709,7 @@ static void test_analyze_script(void)
>      uri =3D g_strdup_printf("exec:cat > %s", file);
>
>      migrate_ensure_converge(from);
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>      wait_for_migration_complete(from);
>
>      pid =3D fork();
> @@ -1773,11 +1774,11 @@ static void test_precopy_common(MigrateCommon *ar=
gs)
>      }
>
>      if (args->result =3D=3D MIG_TEST_QMP_ERROR) {
> -        migrate_qmp_fail(from, connect_uri, "{}");
> +        migrate_qmp_fail(from, connect_uri, NULL, "{}");
>          goto finish;
>      }
>
> -    migrate_qmp(from, connect_uri, "{}");
> +    migrate_qmp(from, connect_uri, NULL, "{}");
>
>      if (args->result !=3D MIG_TEST_SUCCEED) {
>          bool allow_active =3D args->result =3D=3D MIG_TEST_FAIL;
> @@ -1869,11 +1870,11 @@ static void test_file_common(MigrateCommon *args,=
 bool stop_src)
>      }
>
>      if (args->result =3D=3D MIG_TEST_QMP_ERROR) {
> -        migrate_qmp_fail(from, connect_uri, "{}");
> +        migrate_qmp_fail(from, connect_uri, NULL, "{}");
>          goto finish;
>      }
>
> -    migrate_qmp(from, connect_uri, "{}");
> +    migrate_qmp(from, connect_uri, NULL, "{}");
>      wait_for_migration_complete(from);
>
>      /*
> @@ -2029,7 +2030,7 @@ static void test_ignore_shared(void)
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
>
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>
>      migrate_wait_for_dirty_mem(from, to);
>
> @@ -2455,7 +2456,7 @@ static void do_test_validate_uuid(MigrateStart *arg=
s, bool should_fail)
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
>
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>
>      if (should_fail) {
>          qtest_set_expected_status(to, EXIT_FAILURE);
> @@ -2558,7 +2559,7 @@ static void test_migrate_auto_converge(void)
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
>
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>
>      /* Wait for throttling begins */
>      percentage =3D 0;
> @@ -2869,7 +2870,7 @@ static void test_multifd_tcp_cancel(void)
>
>      uri =3D migrate_get_socket_address(to, "socket-address");
>
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>
>      migrate_wait_for_dirty_mem(from, to);
>
> @@ -2901,7 +2902,7 @@ static void test_multifd_tcp_cancel(void)
>
>      migrate_ensure_non_converge(from);
>
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>
>      migrate_wait_for_dirty_mem(from, to2);
>
> @@ -3234,7 +3235,7 @@ static void test_migrate_dirty_limit(void)
>      migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_=
value);
>
>      /* Start migrate */
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>
>      /* Wait for dirty limit throttle begin */
>      throttle_us_per_full =3D 0;
> @@ -3275,7 +3276,7 @@ static void test_migrate_dirty_limit(void)
>      }
>
>      /* Start migrate */
> -    migrate_qmp(from, uri, "{}");
> +    migrate_qmp(from, uri, NULL, "{}");
>
>      /* Wait for dirty limit throttle begin */
>      throttle_us_per_full =3D 0;
> --
> 2.22.3
>

--
Peter Xu
Regards,
Het Gala

--_000_SJ2PR02MB9955B1E7FDF128EE745F121E98502SJ2PR02MB9955namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-IN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US"><o:p>&nbsp;</o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"col=
or:black">From:
</span></b><span style=3D"color:black">Peter Xu &lt;peterx@redhat.com&gt;<b=
r>
<b>Date: </b>Tuesday, 20 February 2024 at 11:33 AM<br>
<b>To: </b>Het Gala &lt;het.gala@nutanix.com&gt;<br>
<b>Cc: </b>qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;, armbru@redh=
at.com &lt;armbru@redhat.com&gt;, berrange@redhat.com &lt;berrange@redhat.c=
om&gt;, farosas@suse.de &lt;farosas@suse.de&gt;<br>
<b>Subject: </b>Re: [PATCH 1/3] qtest: migration: Enhance qtest migration f=
unctions to support 'channels' argument<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">On Fri, Feb 16, 2024 at 09:06:22AM +0000, Het Gala wrote:<br>
&gt; Introduce support for adding a 'channels' argument to migrate_qmp_fail=
<br>
&gt; and migrate_qmp functions within the migration qtest framework, enabli=
ng<br>
&gt; enhanced control over migration scenarios.<br>
&gt; <br>
&gt; Signed-off-by: Het Gala &lt;het.gala@nutanix.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; tests/qtest/dbus-vmstate-test.c |&nbsp; 2 +-<br>
&gt;&nbsp; tests/qtest/migration-helpers.c | 93 +++++++++++++++++++++++++++=
+++---<br>
&gt;&nbsp; tests/qtest/migration-helpers.h | 11 ++--<br>
&gt;&nbsp; tests/qtest/migration-test.c&nbsp;&nbsp;&nbsp; | 33 ++++++------=
<br>
&gt;&nbsp; 4 files changed, 112 insertions(+), 27 deletions(-)<br>
&gt; <br>
&gt; diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstat=
e-test.c<br>
&gt; index 6c990864e3..0ca572e29b 100644<br>
&gt; --- a/tests/qtest/dbus-vmstate-test.c<br>
&gt; +++ b/tests/qtest/dbus-vmstate-test.c<br>
&gt; @@ -229,7 +229,7 @@ test_dbus_vmstate(Test *test)<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; thread =3D g_thread_new(&quot;dbus-vmsta=
te-thread&quot;, dbus_vmstate_thread, loop);<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp; migrate_qmp(src_qemu, uri, &quot;{}&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp; migrate_qmp(src_qemu, uri, NULL, &quot;{}&quot;);<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test-&gt;src_qemu =3D src_qemu;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (test-&gt;migrate_fail) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wait_for_migrati=
on_fail(src_qemu, true);<br>
&gt; diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-h=
elpers.c<br>
&gt; index e451dbdbed..d153677887 100644<br>
&gt; --- a/tests/qtest/migration-helpers.c<br>
&gt; +++ b/tests/qtest/migration-helpers.c<br>
&gt; @@ -13,6 +13,7 @@<br>
&gt;&nbsp; #include &quot;qemu/osdep.h&quot;<br>
&gt;&nbsp; #include &quot;qemu/ctype.h&quot;<br>
&gt;&nbsp; #include &quot;qapi/qmp/qjson.h&quot;<br>
&gt; +#include &quot;qapi/qmp/qlist.h&quot;<br>
&gt;&nbsp; <br>
&gt;&nbsp; #include &quot;migration-helpers.h&quot;<br>
&gt;&nbsp; <br>
&gt; @@ -43,7 +44,70 @@ bool migrate_watch_for_events(QTestState *who, cons=
t char *name,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -void migrate_qmp_fail(QTestState *who, const char *uri, const char *f=
mt, ...)<br>
&gt; +static char *socketAddressType_to_str(SocketAddressType type)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp; switch (type) {<br>
&gt; +&nbsp;&nbsp;&nbsp; case SOCKET_ADDRESS_TYPE_INET:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return g_strdup(&quot;inet=
&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp; case SOCKET_ADDRESS_TYPE_UNIX:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return g_strdup(&quot;unix=
&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp; case SOCKET_ADDRESS_TYPE_FD:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return g_strdup(&quot;fd&q=
uot;);<br>
&gt; +&nbsp;&nbsp;&nbsp; case SOCKET_ADDRESS_TYPE_VSOCK:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return g_strdup(&quot;vsoc=
k&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return g_strdup(&quot;unkn=
own address type&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
<br>
Use SocketAddressType_lookup?<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Ack, I guess combination of using qapi_enum_parse() and qapi_en=
um_lookup() would help me eliminate the need for creating this function its=
elf. Let me do the changes in the next
 patch. &nbsp;Thanks!<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt"><br>
&gt; +<br>
&gt; +static QList *MigrationChannelList_to_QList(MigrationChannelList *cha=
nnels)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp; MigrationChannel *channel =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp; MigrationAddress *addr =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp; SocketAddress *saddr =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp; g_autofree const char *addr_type =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp; QList *channelList =3D qlist_new();<br>
&gt; +&nbsp;&nbsp;&nbsp; QDict *channelDict =3D qdict_new();<br>
&gt; +&nbsp;&nbsp;&nbsp; QDict *addrDict =3D qdict_new();<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; channel =3D channels-&gt;value;<br>
&gt; +&nbsp;&nbsp;&nbsp; if (!channel || channel-&gt;channel_type =3D=3D MI=
GRATION_CHANNEL_TYPE__MAX) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;%s: =
Channel or its type is NULL\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; __func__);<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp; g_assert(channel);<br>
&gt; +&nbsp;&nbsp;&nbsp; if (channel-&gt;channel_type =3D=3D MIGRATION_CHAN=
NEL_TYPE_MAIN) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdict_put_str(channelDict,=
 &quot;channel-type&quot;, g_strdup(&quot;main&quot;));<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; addr =3D channel-&gt;addr;<br>
&gt; +&nbsp;&nbsp;&nbsp; if (!addr || addr-&gt;transport =3D=3D MIGRATION_A=
DDRESS_TYPE__MAX) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;%s: =
addr or its transport is NULL\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; __func__);<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp; g_assert(addr);<br>
&gt; +&nbsp;&nbsp;&nbsp; if (addr-&gt;transport =3D=3D MIGRATION_ADDRESS_TY=
PE_SOCKET) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdict_put_str(addrDict, &q=
uot;transport&quot;, g_strdup(&quot;socket&quot;));<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; saddr =3D &amp;addr-&gt;u.socket;<br>
&gt; +&nbsp;&nbsp;&nbsp; if (!saddr) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;%s: =
saddr is NULL\n&quot;, __func__);<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp; g_assert(saddr);<br>
&gt; +&nbsp;&nbsp;&nbsp; addr_type =3D socketAddressType_to_str(saddr-&gt;t=
ype);<br>
&gt; +&nbsp;&nbsp;&nbsp; qdict_put_str(addrDict, &quot;type&quot;, addr_typ=
e);<br>
&gt; +&nbsp;&nbsp;&nbsp; qdict_put_str(addrDict, &quot;port&quot;, saddr-&g=
t;u.inet.port);<br>
&gt; +&nbsp;&nbsp;&nbsp; qdict_put_str(addrDict, &quot;host&quot;, saddr-&g=
t;u.inet.host);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; qdict_put_obj(channelDict, &quot;addr&quot;, QOBJE=
CT(addrDict));<br>
&gt; +&nbsp;&nbsp;&nbsp; qlist_append_obj(channelList, QOBJECT(channelDict)=
);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; return channelList;<br>
&gt; +}<br>
&gt; +<br>
&gt; +void migrate_qmp_fail(QTestState *who, const char *uri,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MigrationChannelL=
ist *channels, const char *fmt, ...)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va_list ap;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QDict *args, *err;<br>
&gt; @@ -52,8 +116,16 @@ void migrate_qmp_fail(QTestState *who, const char =
*uri, const char *fmt, ...)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args =3D qdict_from_vjsonf_nofail(fmt, a=
p);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va_end(ap);<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp; g_assert(!qdict_haskey(args, &quot;uri&quot;));<br=
>
&gt; -&nbsp;&nbsp;&nbsp; qdict_put_str(args, &quot;uri&quot;, uri);<br>
&gt; +&nbsp;&nbsp;&nbsp; if (uri) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_assert(!qdict_haskey(arg=
s, &quot;uri&quot;));<br>
<br>
IMHO we don't need to assert here?<br>
<br>
Rather than doing this, we can also have tests covering when both are set,<=
br>
or when none are set, to make sure we fail properly in those wrong cases.<o=
:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">(Neglecting your comments here based on Patch 3/3 comment).<o:p=
></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt"><br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdict_put_str(args, &quot;=
uri&quot;, uri);<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; if (channels) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_assert(!qdict_haskey(arg=
s, &quot;channels&quot;));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QList *channelList =3D Mig=
rationChannelList_to_QList(channels);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdict_put_obj(args, &quot;=
channels&quot;, QOBJECT(channelList));<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D qtest_qmp_assert_failure_ref(<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; who, &quot;{ 'ex=
ecute': 'migrate', 'arguments': %p}&quot;, args);<br>
&gt; @@ -68,7 +140,8 @@ void migrate_qmp_fail(QTestState *who, const char *=
uri, const char *fmt, ...)<br>
&gt;&nbsp;&nbsp; * Arguments are built from @fmt... (formatted like<br>
&gt;&nbsp;&nbsp; * qobject_from_jsonf_nofail()) with &quot;uri&quot;: @uri =
spliced in.<br>
&gt;&nbsp;&nbsp; */<br>
&gt; -void migrate_qmp(QTestState *who, const char *uri, const char *fmt, .=
..)<br>
&gt; +void migrate_qmp(QTestState *who, const char *uri,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; MigrationChannelList *channels, const char *fmt=
, ...)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va_list ap;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QDict *args;<br>
&gt; @@ -77,8 +150,16 @@ void migrate_qmp(QTestState *who, const char *uri,=
 const char *fmt, ...)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args =3D qdict_from_vjsonf_nofail(fmt, a=
p);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va_end(ap);<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp; g_assert(!qdict_haskey(args, &quot;uri&quot;));<br=
>
&gt; -&nbsp;&nbsp;&nbsp; qdict_put_str(args, &quot;uri&quot;, uri);<br>
&gt; +&nbsp;&nbsp;&nbsp; if (uri) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_assert(!qdict_haskey(arg=
s, &quot;uri&quot;));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdict_put_str(args, &quot;=
uri&quot;, uri);<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; if (channels) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_assert(!qdict_haskey(arg=
s, &quot;channels&quot;));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QList *channelList =3D Mig=
rationChannelList_to_QList(channels);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdict_put_obj(args, &quot;=
channels&quot;, QOBJECT(channelList));<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
<br>
Duplicated chunks; sign of adding some helper?<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">I didn=92t think of adding a helper function here as it was jus=
t 2 lines of code, already calling
</span><span style=3D"font-size:11.0pt">MigrationChannelList_to_QList() to =
avoid duplication. Even then if you have something in your mind to create s=
ome helper function, please suggest :)<br>
<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qtest_qmp_assert_success(who,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;{ 'execute': 'migrate', 'arguments=
': %p}&quot;, args);<br>
&gt; diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-h=
elpers.h<br>
&gt; index 3bf7ded1b9..52243bd2df 100644<br>
&gt; --- a/tests/qtest/migration-helpers.h<br>
&gt; +++ b/tests/qtest/migration-helpers.h<br>
&gt; @@ -14,6 +14,7 @@<br>
&gt;&nbsp; #define MIGRATION_HELPERS_H<br>
&gt;&nbsp; <br>
&gt;&nbsp; #include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;migration/migration.h&quot;<br>
&gt;&nbsp; <br>
&gt;&nbsp; typedef struct QTestMigrationState {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool stop_seen;<br>
&gt; @@ -25,15 +26,17 @@ typedef struct QTestMigrationState {<br>
&gt;&nbsp; bool migrate_watch_for_events(QTestState *who, const char *name,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QDict *event, void *opaque);<br>
&gt;&nbsp; <br>
&gt; -G_GNUC_PRINTF(3, 4)<br>
&gt; -void migrate_qmp(QTestState *who, const char *uri, const char *fmt, .=
..);<br>
&gt; +G_GNUC_PRINTF(4, 5)<br>
&gt; +void migrate_qmp(QTestState *who, const char *uri,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; MigrationChannelList *channels, const char *fmt=
, ...);<br>
&gt;&nbsp; <br>
&gt;&nbsp; G_GNUC_PRINTF(3, 4)<br>
&gt;&nbsp; void migrate_incoming_qmp(QTestState *who, const char *uri,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; const char *fmt, ...);<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Just thinking, should also add =91channels=92 argument here I g=
uess, would be helpful in future to add some tests where only =91channels=
=92 parameter wants to be added to the function
 ?<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt"><br>
&gt;&nbsp; <br>
&gt; -G_GNUC_PRINTF(3, 4)<br>
&gt; -void migrate_qmp_fail(QTestState *who, const char *uri, const char *f=
mt, ...);<br>
&gt; +G_GNUC_PRINTF(4, 5)<br>
&gt; +void migrate_qmp_fail(QTestState *who, const char *uri,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MigrationChannelL=
ist *channels, const char *fmt, ...);<br>
&gt;&nbsp; <br>
&gt;&nbsp; void migrate_set_capability(QTestState *who, const char *capabil=
ity,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; bool value);<br>
&gt; diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test=
.c<br>
&gt; index 8a5bb1752e..e7f2719dcf 100644<br>
&gt; --- a/tests/qtest/migration-test.c<br>
&gt; +++ b/tests/qtest/migration-test.c<br>
&gt; @@ -18,6 +18,7 @@<br>
&gt;&nbsp; #include &quot;qemu/module.h&quot;<br>
&gt;&nbsp; #include &quot;qemu/option.h&quot;<br>
&gt;&nbsp; #include &quot;qemu/range.h&quot;<br>
&gt; +#include &quot;migration/migration.h&quot;<br>
&gt;&nbsp; #include &quot;qemu/sockets.h&quot;<br>
&gt;&nbsp; #include &quot;chardev/char.h&quot;<br>
&gt;&nbsp; #include &quot;qapi/qapi-visit-sockets.h&quot;<br>
&gt; @@ -1350,7 +1351,7 @@ static int migrate_postcopy_prepare(QTestState *=
*from_ptr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wait_for_suspend(from, &amp;src_state);<=
br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_autofree char *uri =3D migrate_get_soc=
ket_address(to, &quot;socket-address&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp; migrate_qmp(from, uri, &quot;{}&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp; migrate_qmp(from, uri, NULL, &quot;{}&quot;);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate_wait_for_dirty_mem(from, to);<br=
>
&gt;&nbsp; <br>
&gt; @@ -1500,7 +1501,7 @@ static void postcopy_recover_fail(QTestState *fr=
om, QTestState *to)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_assert_cmpint(ret, =3D=3D, 1);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate_recover(to, &quot;fd:fd-mig&quot=
;);<br>
&gt; -&nbsp;&nbsp;&nbsp; migrate_qmp(from, &quot;fd:fd-mig&quot;, &quot;{'r=
esume': true}&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp; migrate_qmp(from, &quot;fd:fd-mig&quot;, NULL, &qu=
ot;{'resume': true}&quot;);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Make sure both QEMU instances wi=
ll go into RECOVER stage, then test<br>
&gt; @@ -1588,7 +1589,7 @@ static void test_postcopy_recovery_common(Migrat=
eCommon *args)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Try to rebuild the migration cha=
nnel using the resume flag and<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the newly created channel<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp; migrate_qmp(from, uri, &quot;{'resume': true}&quot=
;);<br>
&gt; +&nbsp;&nbsp;&nbsp; migrate_qmp(from, uri, NULL, &quot;{'resume': true=
}&quot;);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Restore the postcopy bandwidth to unl=
imited */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate_set_parameter_int(from, &quot;ma=
x-postcopy-bandwidth&quot;, 0);<br>
&gt; @@ -1669,7 +1670,7 @@ static void test_baddest(void)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (test_migrate_start(&amp;from, &amp;t=
o, &quot;tcp:127.0.0.1:0&quot;, &amp;args)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp; migrate_qmp(from, &quot;tcp:127.0.0.1:0&quot;, &qu=
ot;{}&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp; migrate_qmp(from, &quot;tcp:127.0.0.1:0&quot;, NUL=
L, &quot;{}&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wait_for_migration_fail(from, false);<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_migrate_end(from, to, false);<br>
&gt;&nbsp; }<br>
&gt; @@ -1708,7 +1709,7 @@ static void test_analyze_script(void)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uri =3D g_strdup_printf(&quot;exec:cat &=
gt; %s&quot;, file);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate_ensure_converge(from);<br>
&gt; -&nbsp;&nbsp;&nbsp; migrate_qmp(from, uri, &quot;{}&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp; migrate_qmp(from, uri, NULL, &quot;{}&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wait_for_migration_complete(from);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pid =3D fork();<br>
&gt; @@ -1773,11 +1774,11 @@ static void test_precopy_common(MigrateCommon =
*args)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (args-&gt;result =3D=3D MIG_TEST_QMP_=
ERROR) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate_qmp_fail(from, con=
nect_uri, &quot;{}&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate_qmp_fail(from, con=
nect_uri, NULL, &quot;{}&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto finish;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp; migrate_qmp(from, connect_uri, &quot;{}&quot;);<br=
>
&gt; +&nbsp;&nbsp;&nbsp; migrate_qmp(from, connect_uri, NULL, &quot;{}&quot=
;);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (args-&gt;result !=3D MIG_TEST_SUCCEE=
D) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool allow_activ=
e =3D args-&gt;result =3D=3D MIG_TEST_FAIL;<br>
&gt; @@ -1869,11 +1870,11 @@ static void test_file_common(MigrateCommon *ar=
gs, bool stop_src)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (args-&gt;result =3D=3D MIG_TEST_QMP_=
ERROR) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate_qmp_fail(from, con=
nect_uri, &quot;{}&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate_qmp_fail(from, con=
nect_uri, NULL, &quot;{}&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto finish;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp; migrate_qmp(from, connect_uri, &quot;{}&quot;);<br=
>
&gt; +&nbsp;&nbsp;&nbsp; migrate_qmp(from, connect_uri, NULL, &quot;{}&quot=
;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wait_for_migration_complete(from);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; @@ -2029,7 +2030,7 @@ static void test_ignore_shared(void)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wait for the first serial output from=
 the source */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wait_for_serial(&quot;src_serial&quot;);=
<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp; migrate_qmp(from, uri, &quot;{}&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp; migrate_qmp(from, uri, NULL, &quot;{}&quot;);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate_wait_for_dirty_mem(from, to);<br=
>
&gt;&nbsp; <br>
&gt; @@ -2455,7 +2456,7 @@ static void do_test_validate_uuid(MigrateStart *=
args, bool should_fail)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wait for the first serial output from=
 the source */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wait_for_serial(&quot;src_serial&quot;);=
<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp; migrate_qmp(from, uri, &quot;{}&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp; migrate_qmp(from, uri, NULL, &quot;{}&quot;);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (should_fail) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qtest_set_expect=
ed_status(to, EXIT_FAILURE);<br>
&gt; @@ -2558,7 +2559,7 @@ static void test_migrate_auto_converge(void)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wait for the first serial output from=
 the source */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wait_for_serial(&quot;src_serial&quot;);=
<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp; migrate_qmp(from, uri, &quot;{}&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp; migrate_qmp(from, uri, NULL, &quot;{}&quot;);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wait for throttling begins */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; percentage =3D 0;<br>
&gt; @@ -2869,7 +2870,7 @@ static void test_multifd_tcp_cancel(void)<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uri =3D migrate_get_socket_address(to, &=
quot;socket-address&quot;);<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp; migrate_qmp(from, uri, &quot;{}&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp; migrate_qmp(from, uri, NULL, &quot;{}&quot;);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate_wait_for_dirty_mem(from, to);<br=
>
&gt;&nbsp; <br>
&gt; @@ -2901,7 +2902,7 @@ static void test_multifd_tcp_cancel(void)<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate_ensure_non_converge(from);<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp; migrate_qmp(from, uri, &quot;{}&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp; migrate_qmp(from, uri, NULL, &quot;{}&quot;);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate_wait_for_dirty_mem(from, to2);<b=
r>
&gt;&nbsp; <br>
&gt; @@ -3234,7 +3235,7 @@ static void test_migrate_dirty_limit(void)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate_dirty_limit_wait_showup(from, di=
rtylimit_period, dirtylimit_value);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Start migrate */<br>
&gt; -&nbsp;&nbsp;&nbsp; migrate_qmp(from, uri, &quot;{}&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp; migrate_qmp(from, uri, NULL, &quot;{}&quot;);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wait for dirty limit throttle begin *=
/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; throttle_us_per_full =3D 0;<br>
&gt; @@ -3275,7 +3276,7 @@ static void test_migrate_dirty_limit(void)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Start migrate */<br>
&gt; -&nbsp;&nbsp;&nbsp; migrate_qmp(from, uri, &quot;{}&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp; migrate_qmp(from, uri, NULL, &quot;{}&quot;);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wait for dirty limit throttle begin *=
/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; throttle_us_per_full =3D 0;<br>
&gt; -- <br>
&gt; 2.22.3<br>
&gt; <br>
<br>
-- <br>
Peter Xu<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Het Gala<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_SJ2PR02MB9955B1E7FDF128EE745F121E98502SJ2PR02MB9955namp_--

