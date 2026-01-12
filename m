Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447F0D25051
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 09:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfDrU-0005dn-Rd; Mon, 12 Jan 2026 04:05:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vfDrQ-0005aS-Hj; Mon, 12 Jan 2026 04:05:18 -0500
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vfDrP-0004wl-70; Mon, 12 Jan 2026 04:05:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvV/VgYnkrZHK9zP8be0BVzahXD46Z8GfvMiUXQxyl1F8bvD+v/7gbYDAp0eCh40gycOhoj18Tors+PE1i7u9uYpuvqSuFvDQu+oB3p/xFDDrKFZwFgU1oz6RRwZV3yYXJcFlxrzq4WqlU4A/DNViVd34ps/3jr6oM5oq9XHlZYepd/1uAopWK9WrAFtVgAinYchZAXgM/hbh0wJcvrmnwJQQrBlbGv8VhzuAVGCQMIZkqpHQcfayRc5PvUxrMAqNP/xQa19Z0JGZF2JvxRBYFT7ST+PN1edImkFB9HgKpzevZ6BKv2hqnKfugCXYk9CqPt7XHfDTNpWDRTXkg6lPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpqWViys5qdQ98AeCfFSYJDPTboPVx6aRY7qYX4eAUY=;
 b=ZGCNAXG6AYGVU08eeb/+lKNoJQM7dpBaNT7Vj6+1Hy3NbFFek6QdGtEiGNwsDV6bUOULi5y0rSF0/r0COtPgt3y47+RIpOfWUBuAqwaOv1RRdKkKBUdGus0BL7HXm4u/VFE0qJHS7Aq8oa/0d0UYmUrf6kmmc38Nw2xrC7/pHtfwLbv6q6X/bw7bSnAmaUfPxAloVr7FqVp8YpszoN3okydw1+bjz5WDx1ioNXmxWN4jc/FwL1msSWQ5NuJd5TYnTOHdz9YAyuBV1TamRGxfsccSfZBovuU43/+ljh27aQNDQgHPUdFKQtZUbUFvklaqXmHuWZuKiPOu7FG3Zcn6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpqWViys5qdQ98AeCfFSYJDPTboPVx6aRY7qYX4eAUY=;
 b=lt45CiKe11MPNZ3w4on0M0yaxMHeg/bmKJBBysNO+5hNVkcnEPbCFhBCAWm/02GVYQqxEnjSWPV+hLWUavWDBcvT5sVqMdnnS+CxRpCvvUrom43sy96fCqe442obRDfYfDWEJKZ/4hveFhBqw7GwGTMN1+5o4sl413hcKRUv53TxYdcjjZUM8SjptyMnVNypKdfdcUaNldQWPdP7jAnLW2tOCzAG17vV5anRvaO2uFaur2WbrjdUja8EDjemIv0COsZsi+AmyedNnc/SSlbfmfW3PR/BRrJgscsSnbXXhF6v18QtuFsl49ziogMktUZ2p1ncKFJV4weSNaaGfE1eng==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by MI3PR09MB8569.eurprd09.prod.outlook.com (2603:10a6:290:71::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:05:05 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%3]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 09:05:05 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v1 2/2] target/riscv: Fix null pointer dereference in
 cpu_set_exception_base
Thread-Topic: [PATCH v1 2/2] target/riscv: Fix null pointer dereference in
 cpu_set_exception_base
Thread-Index: AQHcg6KKz3Q4AXr2AUeedvhytLetew==
Date: Mon, 12 Jan 2026 09:05:04 +0000
Message-ID: <20260112090458.2345280-3-djordje.todorovic@htecgroup.com>
References: <20260112090458.2345280-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260112090458.2345280-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB2796:EE_|MI3PR09MB8569:EE_
x-ms-office365-filtering-correlation-id: 78e1f6b8-03de-4e34-078b-08de51b9ad74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?fy0DIySoyqCW2u6RzGUAA5z7huBgmofN/+5sYis8bJSdCj53iGBoyI9Y61?=
 =?iso-8859-1?Q?ZRU5YEv8QhA9iK/9oGMNOl2+2Xs/2aR/tnv66jh/H4qQ2TmhhL8+5HxzXX?=
 =?iso-8859-1?Q?4CyDR6mWE1idC0eVBIdqhqs9wXZupBspH6kkEPDR8j0YXaEdcCK+jNi7Is?=
 =?iso-8859-1?Q?G49CqiDZUlnrPEjdDFYNdVlxpUGYFB6rQ50HNRZtBstZ/MebKRb3HIN1sx?=
 =?iso-8859-1?Q?PqPT11QINM9DQ4e0RDuhXw9yCE3tFM+7i3esG5o2/Vmded2SzSi7YX78fn?=
 =?iso-8859-1?Q?7M4AULSR4cRnA1EIzQ3zm/vXtR+29J5itoqf0vslpRQZ7jNiYjeUpa8pOx?=
 =?iso-8859-1?Q?MtTZWcM3f6PSryjiJEceg+vQFcdgfSwe9y4RzCTloL8q/SgsxrcInjMc4b?=
 =?iso-8859-1?Q?6B9IspcO42dJXpX0bT9vtigSg2xvfPjXJVZJF6e9mWJbDiVl9Uwz/bxEcv?=
 =?iso-8859-1?Q?2oS5X6MDNZPkMUhZ/N5lcezbj9UHba4Y6Oy6NXFRePEwyHwBC+dJzqwWT0?=
 =?iso-8859-1?Q?Ia5o2fuCXUGFmmspNZKWPU0PcONpdtzFRV0KvgojcoONM/3iqbkuyTA5Th?=
 =?iso-8859-1?Q?Q0pNaVV3ik1jp0IjGHWHldrRe/2QQx5jae/wdbDeBKRp1vWnY0IYmEzMIf?=
 =?iso-8859-1?Q?9JVwhdlOR+QgETsySQ2x/v1I5pfV+g80IJ42/LJYWy2xMN9+5KvduVeUYv?=
 =?iso-8859-1?Q?Bxu0bqtz3rZmUem1EYiZ/aVq3mAF/0d4cCSMs98vLcGIveNdoAtbo0llZj?=
 =?iso-8859-1?Q?saVZjI+xAJxMiwZ6z+j7B7/F/Cm9Vqi1TNFj/6eVKMBszLWlU55Vy1w0AT?=
 =?iso-8859-1?Q?oPPI0kgEoSkDhI9TNBOAZMMILZHLdvwd8+HPax8Mz/OK2+ARuwlqiqgsJK?=
 =?iso-8859-1?Q?SuE44uYatpy+32Rf9kwUN9QfxqGhF2hTK2OUF80PtmMwBi8CJMNrr9gvVm?=
 =?iso-8859-1?Q?J9p29RiXVjZlOIB18BleGtp2LBiIkprcPigYO1rjTYdrkSJgONm2o1P8qd?=
 =?iso-8859-1?Q?TG5kVHMbxM7CSRCPExQMqq8O0FySSUq1vP7HepXvdWuDYYzNgWkATCjvPI?=
 =?iso-8859-1?Q?K1xEw49Ta89eQPOegPqDxk+tbt6bTC75/2blntCDP7kmjR17mfGu8a9S33?=
 =?iso-8859-1?Q?+NUDyljm9kFk27N+sIvaTfQyXkGEzGZuNoZ6890ddhZYRm0yrSr+DStCOi?=
 =?iso-8859-1?Q?1ilmAIj6tht6bmwGRMpJf83HRw0XanPGvPMvtuyQQtcYhZl03s/WYihJOT?=
 =?iso-8859-1?Q?njaf/K8A1gMgv0y9W9qNQQ5N0xIWRDH6kNCp8EgnjV5oAqz6HA9Ep0YLVS?=
 =?iso-8859-1?Q?okeHojDJM+B91Q4uXN93/sjftIMDWBGX/jphQda3UIfccohqu3JD6YrWAb?=
 =?iso-8859-1?Q?h2aGwYluMtIBghqlLDKeglJRnliUNBn0n5U7I3GXTtKmLEBJqpVoaQRO8h?=
 =?iso-8859-1?Q?G+mDG89I52xe3VWeWm7xruU99Qwc0q7wchcnyP6OystPhqh58z33HORpQr?=
 =?iso-8859-1?Q?wTjWI7xsuWhwMxdgI71CO8KYL/VFE4wrzZCRhI9yEdqt8OiW8RF65Azp0f?=
 =?iso-8859-1?Q?GQ1XtH272b1aMVksZPpsC6EJwvXA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kIKWneEisnIa2ZxRL4kpUFjkUappGWk+MZ5wEiMMHYAiedyKWW29jKKmqQ?=
 =?iso-8859-1?Q?eh+rTRgTQx3dgf3a+YIrMSUzzPYSaPCXV8++xr1NHq3OKeJWlS/P53+Ja0?=
 =?iso-8859-1?Q?tSrqZjbDk4wHTvXLqQQnjszEZGPXeCpoRNaZgnvxHwWTAQqLjosmOASx2+?=
 =?iso-8859-1?Q?3nOA/udy3lopUcY7QdolJ7a8GJNyye66tujN42qJtsbsOSerN3VIUB0z+d?=
 =?iso-8859-1?Q?SJHTmZKWgmpx7hG95rIkrwBKb+srkZKi2ni4A1aITsY4yaTqFoMLdDbz6W?=
 =?iso-8859-1?Q?FnUlxPmgRBdXtN0Ee+GgmMbdTN9fCvZRZ8zP+WnllVjVZq4PhH+LdVxcKs?=
 =?iso-8859-1?Q?UKAUAOQcyeF8Ta6Mv3MypBi01zJyBDR/wbLnWu3BcLqZ7nDOQxWSjtkS29?=
 =?iso-8859-1?Q?UhEDlCPR0z+rYjAbjcRtgIGkD0GrFCYLW7N/B6EYR6oBZXQ9q9KjXKtL14?=
 =?iso-8859-1?Q?tVDDdpO68+jhkOjHPIl5372ht+6VnITdRI8M2U/3VCPwbRAs9X1WSh2Mvv?=
 =?iso-8859-1?Q?sDOvbVzCYY2yIX9q96ZM5RJsC32u0g37cxmKzLzikmlGap8w9lGxVR3mmN?=
 =?iso-8859-1?Q?zS9LVmuAC5i0o55ffR+NdW2uTSjSJQPRXiAMaLnXJld6/fLkkuCtwjATKC?=
 =?iso-8859-1?Q?sJOpLeEAdokzAfMQ8KLfKNst91FdpwAtpgzpHF0cHFUKV9zO+LwCBrlw1A?=
 =?iso-8859-1?Q?b1SrSUSO1VXz9XZ20fiqkjc04c8eqM3E6a0Nvy9H2/H2qYR29gAKmxynaX?=
 =?iso-8859-1?Q?4UjY/GsLiNl5SyvXIhUDnkm3HnTNA7QtsHEvPTP4oM4qeP+BZH4AafMpmm?=
 =?iso-8859-1?Q?B30X7tvwWy2udixDuSX0ONcgPey07q01tJYurD6qjDvImqKKsidSo7HbUI?=
 =?iso-8859-1?Q?50XsM6PsySKQRmZ2ggM6Ma8u8kB8aTCsFfNZtC3+ArR7S4KMMghgV5ozS6?=
 =?iso-8859-1?Q?nRmPxrXBqpr7mjsnhbZ5Oi7YZzfgAAU5got/VypyGwDWG/47VTEgos33qO?=
 =?iso-8859-1?Q?qnReikd9JuxmC2XEsgXjXzgJ0jch2bVvTn6ckSCQgTaaOZ19ABsA+QlyjW?=
 =?iso-8859-1?Q?o4l2JGW8nGBhpIwi8xMrJxhcPOiaE4QjjR9nmaKmTPBBRep2ubs5V/8+XW?=
 =?iso-8859-1?Q?47abw6BJk08vIRV5pLoXG/j30FcimPuMP+GskCWwCGVTL+KeViYiUKjCAy?=
 =?iso-8859-1?Q?jQhoFX0E+l1DPAXIMOiwp7myZc7qKOix5lQKlW2SzQiB+i8aKGLsA82kWL?=
 =?iso-8859-1?Q?DThaYFPkxC9OUU/pdmjXWTiv2dMoR7h9Nm+VohzOMihI95RQtnJb1EOQwB?=
 =?iso-8859-1?Q?YLFse999VXph6rnMZrSendge70ock0TkWo4JfsH5LBXgNq716IdU4YyRzC?=
 =?iso-8859-1?Q?uSw9I1A+nmsr0YHSOdQ/2Ib30mEGn2+VqDBsbvTQEhgRhvYtY8qwEEZS73?=
 =?iso-8859-1?Q?XN/5eRjlS0fwhjvnyWQ7D2Rdy6dQEfAPcC+XxHAF+wq/HXTHUAgo2fXTgP?=
 =?iso-8859-1?Q?dNnIVH5ErAvGBrld+MnHX3CHIMD7+vxp3UfvvrbJVUPsLNmkasIvTfwT5A?=
 =?iso-8859-1?Q?LTcFi6gRMN5ILWugQjlo9IS59XKGJ2TesaRdpRWi1urk9WPX2rk/GIBrhk?=
 =?iso-8859-1?Q?lSAwaidhW8shEKeSzc3rg+CjSm1Epo+wVQ/Mt0TGy2nCAh6nhTIEABlMme?=
 =?iso-8859-1?Q?+4w0smhuHDQ8cVCsUZ/ad4jYpU8OreIiaPiK2ZoxoOeyYFSfx5xziJGtg/?=
 =?iso-8859-1?Q?qLRoci63IYt6Xg/i6/DquBM5Umcuazo7IN46DdlkWj7RvT5ZjqvzkMrgW5?=
 =?iso-8859-1?Q?T4uOLk0luWTWhR/EEJ3AD9m4p20mZ9PjjyK/3Ihb0U4zt6nnUgZX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e1f6b8-03de-4e34-078b-08de51b9ad74
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 09:05:04.1149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TV7chRdokmE8j0/KW2AVxb9A4QoT6XmRYbtpSOogezVK5noPmVvvyBVIk7gP2PxQ0OzgoXVwuNb3XVCY0pb5mQZg0xFffXF8EawCAxdHQhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR09MB8569
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

Add missing return statement after logging the error when cs is NULL.

Resolves: Coverity CID 1644077

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3b9d17d58d..10ece4bf63 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -83,6 +83,7 @@ void cpu_set_exception_base(int vp_index, target_ulong ad=
dress)
         qemu_log_mask(LOG_GUEST_ERROR,
                       "cpu_set_exception_base: invalid vp_index: %u",
                       vp_index);
+        return;
     }
     cpu =3D RISCV_CPU(cs);
     cpu->env.resetvec =3D address;
--=20
2.34.1

