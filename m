Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD04CEF8FEA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 14:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmuu-0002DE-LC; Wed, 04 Mar 2026 09:09:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Bertrand.Marquis@arm.com>)
 id 1vxhfF-0005Ot-Az
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:33:05 -0500
Received: from mail-westeuropeazon11013041.outbound.protection.outlook.com
 ([52.101.72.41] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Bertrand.Marquis@arm.com>)
 id 1vxhfC-0004PL-CZ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:33:05 -0500
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Opq3Q6rxBzx836EuwoMLndzdeMiQZWRpkU+jDgwQKW05lCHD9G8921KKDu+dtNDu18gQFQJ5ihD75JNnHiN7zcF5X402fGeGHUvvkCreOfbb+2YAxhaBVDnpP9e0wtsVwNV3ByI/hKP1GkWVW/XzxQ47jaJ1hykVfnxGLBCrrmSHu4HFoeQ+Azc1NxbatpwpVjXWSlUKHuG1uzE6REUPGQJymEMuisclhQ6iO4s9ICOYGAo8HvLsmMonem+QK+g5UeP+nIelMAjFzE5KP1HQnQiqIF/OOT1+3XD5wkHdJbubL6BgbzZUoq0wxw3MfdS8Ufuo7IYcfuDhohgZrwoAPw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rn9GaHmcQe5kglpJXqmMQZANOB93M/YwhgAmfRBSoA=;
 b=CKikDYYpgQwpkcQuNqGNUDyrdz9IqKrmtyYgfcvArT0nw7yqR4Z+WtTg3G7W7yTm6PWgDH+KyhG/o4mzluaR5nBKs+dV86s5w5dq4xC6NzJuSJ3j0cGU7/g/uc0LlTVtXGUDRMgc0DUpHxdgGq1KNExW+eC8ns8c0dfceaO+qHyMvalk5fwrlOx73AYYXFO64fF1upoRTvZAd5NQbjA9zu48/lYrAMKONVBNzcV5q+lDDHVhTu5z/P4vv20S1prGVEAib0yi3vyYbJkPz5Q8zwH7C4y0Gb5EfPEcZJXr9lS4gVvVLGUIvYIELf4/muCTAmcOkg+qUoCggrW04n3w0Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rn9GaHmcQe5kglpJXqmMQZANOB93M/YwhgAmfRBSoA=;
 b=fGFAQngZHZCZjgpmOwBLj6PGvAoFQwHxuWAcGBlKOfIV4pi12sR4vflyggFX/caK8wuZHLq01Pf+3FlUexPgk5cBty0GjMrwJ1yDAgGZ+o2fYrRcd3jZ2GFUgfx7/uR5oVwoprLkweWxs1cE4nQZjQGT5rDW6PcpHMvO5onBNPk=
Received: from AM0PR10CA0025.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::35)
 by AS4PR08MB7529.eurprd08.prod.outlook.com (2603:10a6:20b:4f8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 08:27:53 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:208:17c:cafe::43) by AM0PR10CA0025.outlook.office365.com
 (2603:10a6:208:17c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Wed,
 4 Mar 2026 08:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.16
 via Frontend Transport; Wed, 4 Mar 2026 08:27:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMWkBqBSQyfP18zHuZjgx0EgM2As1iOoCs2EmX515wht4f5INZslIsVCF8AtcHyJpGBvPw6pWSbBQNWMppB6fNxmjD6RAMHGQgb3Oc0lUK9wH3lEJDywdStsxQ70auSeruByRP907gnSLR3gMmThhjFpX1XGNkL6N63FiZywGXU3nmkxFSvYj5xHh6hXKfn0NKC/BO1fntt38oC++5HS+/16joNavbn/9Z4CjQd+N3WmdK0mly8km8Ya4FP23f/YPDXPCWYQ/RZDc6f4dtjc3WDLHAtqbzeMamt7EKAE+9eIR5Kny4lsobDc05VVbW+/30shVb8Aci7u9xTYbjBl+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rn9GaHmcQe5kglpJXqmMQZANOB93M/YwhgAmfRBSoA=;
 b=q/T1wG9GeqGPjs6ZdAH+3wSgSIVz9IUI/fAPWiCEH28/j98wRcd1AGy5/bpeIV77zhKxvJDzHMmgmjLHAY3C/UjsmxahsqmT6p0Cgchq/EbR2gxnK+qT6XFEL35jBqQY0MoFA0r2ZYZTNJ6NXTX1YitviP3q/aIoU1D1rEUpNh/mek5qjbBzzIQjjPWHu/93cKb1qjLEyTRT9QZ/hx13osywfHF6x2AWPvaxufqLMXZLGIaa15SgmKDhN7UtYw2VMfynNonkW5fZpvLZeosaJzwWXxiLQgxL2Q9YAriZ5emi/Kps9L57kXcJcwF0/6cHMLS3fDKrOHXXzpUDzlejlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rn9GaHmcQe5kglpJXqmMQZANOB93M/YwhgAmfRBSoA=;
 b=fGFAQngZHZCZjgpmOwBLj6PGvAoFQwHxuWAcGBlKOfIV4pi12sR4vflyggFX/caK8wuZHLq01Pf+3FlUexPgk5cBty0GjMrwJ1yDAgGZ+o2fYrRcd3jZ2GFUgfx7/uR5oVwoprLkweWxs1cE4nQZjQGT5rDW6PcpHMvO5onBNPk=
Received: from PR3PR08MB5593.eurprd08.prod.outlook.com (2603:10a6:102:84::13)
 by DB9PR08MB8625.eurprd08.prod.outlook.com (2603:10a6:10:3d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 08:26:49 +0000
Received: from PR3PR08MB5593.eurprd08.prod.outlook.com
 ([fe80::aae1:6871:afc4:620e]) by PR3PR08MB5593.eurprd08.prod.outlook.com
 ([fe80::aae1:6871:afc4:620e%4]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 08:26:49 +0000
From: Bertrand Marquis <Bertrand.Marquis@arm.com>
To: Demi Marie Obenour <demiobenour@gmail.com>
CC: Alyssa Ross <hi@alyssa.is>, Bo Chen <bchen@crusoe.ai>, Rob Bradford
 <rbradford@meta.com>, Wei Liu <liuwe@microsoft.com>, Sebastien Boeuf
 <seb@rivosinc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dev@lists.cloudhypervisor.org" <dev@lists.cloudhypervisor.org>, Spectrum OS
 Development <devel@spectrum-os.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?=
 <marcandre.lureau@redhat.com>, "virtio-comment@lists.linux.dev"
 <virtio-comment@lists.linux.dev>
Subject: Re: virtio-msg inter-VM transport vs virtio-vhost-user
Thread-Topic: virtio-msg inter-VM transport vs virtio-vhost-user
Thread-Index: AQHcqzep5HvZkOgsvEi4uRh6zzeLULWeCs4A
Date: Wed, 4 Mar 2026 08:26:48 +0000
Message-ID: <08706B81-11D1-47DA-BC0B-756CF3705C69@arm.com>
References: <b291c8af-58ee-46e4-9033-e681ff9677db@gmail.com>
In-Reply-To: <b291c8af-58ee-46e4-9033-e681ff9677db@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.400.21)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PR3PR08MB5593:EE_|DB9PR08MB8625:EE_|AM3PEPF00009BA2:EE_|AS4PR08MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc29d7a-aa06-47e1-a61e-08de79c7ee2f
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
X-Microsoft-Antispam-Message-Info-Original: Fz2cw1YjBTCgn5sL9XuEOsL1mm0Idang6Vi6Uyywz12ulb4soXEw/ZmNsbrwXQ3oBfdZKKyH4A0IkDRcOKG+z3355Ya3/jv1rU/DxkO2eYPcSmYktchIApywUwxpJ3iGqmPB/KGpxs/92/uE2exRMBLLvbhqWvwGbsjuvLNP4jzswq0BH5RGXLt0NrlbENezmvpvPrsx3T2svvQcfyQ8wZNmqYdh+7mzW8fWSvxXojWaFs8610aZKSn+xsL4ZBY8TU606FkKDm15pG6Zwj2fdEmwZiUooPLJe5Ivlb+8IhCqApmXFhov2LNST4qZ1tuko509OUJ5sZLIo9EO3wBSilGZ4notL4O7JWOv8yNk56hEm4i9tB4RHMCeqWmkkE/JZbVM54O0daQd1qIlbaZ0ExEB/lwGR17SkcuRVI59sQTOFhuDYlGWebG97nrcv2143w/hB1uCabRqthLbTnG+eDvrf089ES2g6FWg0Cw67X2I1unddNLN97xX44fpz+y68bmM2B8FZEQqZHhWSRmAexCOd9Wos1eL6sj3pYYH1EVnWkdhJvyR0fxkiLTE57w6Uh9rRpljsZC4pPvFUU3ueFvLdjPwG0VhMT2bfWj2z0Ly5Ef2Z4o1trtnznHDguFqyOmLidDRvf5jVXinBF9xIlBUCXW0VHEoI4kcppicLkFmAH/PdP9ysd2GQc9Pd/0MNlOzZD943vjtuk7em7QsqXUhF+NFPDnXmvxOBUmshuw=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PR3PR08MB5593.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C302A4A3D88CE458D751666AFD127EC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8625
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 730bf17b-3e1e-4678-8cb7-08de79c7c7bd
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|14060799003|1800799024|82310400026|35042699022|376014|7416014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: DK4YxdDTCotUlWPdqq+HcHGwI2ePwG/C8YGCwzjPjfkaInS/irDqCHpxKkbQLMIQr1iR9tjbO+4W+yIn6YNVvNZqwHJlJyaIh/9t8I8hj/Eukjc1EIAtXogFRoLhNIe2L1KT33aiX8nCYX5660dkK0wyb+zqhviDcQimOoGCZSQtCjZsZ1/uXw20r1nCK5OWYih717zJGrQ1Lt1BgTwkXtWrP2+nUfFy4rPeILS7VbUfYb/Ur/pZM+MEhb4YaJ0+QbPO5C/+3ESVw7Gr0Xq8K1UhEL9hL6NVAvFiBMeGfL/zA2E/mq+GMmBkHohIftEimLgZ+l/qrakP0VTN8o94obxlyKlx4qrOe534eg0cz/DMnSwHEVuaTDjbexcSKkZXD1mlmQlbgp0IVjAyNgTP5Yy+zLn/fmaNk7AOMh+lWJ0bwMBLQF8QTzf5YoaXfPWXM9LYf+cIUf0onG5oDAdDY2Hio/RBZkvMypDqx08lxI7sNLoSU4ryxT+VktQN4oR8LVlr2DSJRWBeOyEC/GaxWhAMUqgje2AnNfHl5bH/7u8whSYiydkdx5BVnT9jH116NCJ9f1jeysK1cmnz9JQDjnT0NZPt4FTti/kiJaiI+lEw3lSKEqjsEd9PsfVoM0uBo1sOydDc3NaHCDXpBFacpvRosH29pLxLDkaVJraKQoI7AnxcJd0+mVoF98PcUcF7FMjajAOOZkhmN4EZBGtL3g==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(14060799003)(1800799024)(82310400026)(35042699022)(376014)(7416014)(13003099007)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9Ng8TdPapf0fHJZaM6I/9W7Jk53W6NqMUb1Zo5/v0l5nHcOrEx9no0yrLdLdcaKTR1ykpKWR4T+20TudjTbdhYcHLkILzjPTdRuUZgpMTeV/ZI5rsrLtRb+yRAy3dmSNZVyj1YCqsAHRDf6ENV9KY/HXy+kvNTEjH8AW0PA90LtE0ouBTlwuuVDLGWjG1BXeWmnFCbsaAE3J4YAw1whKNO1PKnU9MP443YMZiadTMd+ALpR4gMJ5qWSR73g0hsMhcus0LHyoGAb6/xWyxkURH6jZndNf5LBTl88JHmG1+3s9Kn7zfiFjHIyJoW/A1UIDjl5n3pQPi8Wd4gGtctsXwKYL8U9E0rzeyNT7xAcaH73XKQ0A4uXvdDB1xKVTt3QWkAwAj8qlFqYRedVjShiIW+AnN845D8u6FHs30MvswRIz0PKuaoyPPAQ3ik6atp47
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 08:27:53.3665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc29d7a-aa06-47e1-a61e-08de79c7ee2f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7529
Received-SPF: pass client-ip=52.101.72.41;
 envelope-from=Bertrand.Marquis@arm.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Mar 2026 09:09:20 -0500
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

SGkgRGVtaSwNCg0KPiBPbiAzIE1hciAyMDI2LCBhdCAxODo1NiwgRGVtaSBNYXJpZSBPYmVub3Vy
IDxkZW1pb2Jlbm91ckBnbWFpbC5jb20+IHdyb3RlOg0KPg0KPiBTcGVjdHJ1bSAoaHR0cHM6Ly9z
cGVjdHJ1bS1vcy5vcmcpIGlzIGdvaW5nIHRvIGJlIGltcGxlbWVudGluZw0KPiB2aXJ0aW8gZGV2
aWNlcyBvdXRzaWRlIG9mIHRoZSBob3N0LiAgT25lIHByb3Bvc2VkIG1ldGhvZCBvZiBkb2luZw0K
PiB0aGlzIGlzIHZpcnRpby12aG9zdC11c2VyLCB3aGljaCBpcyBhIHZpcnRpbyBkZXZpY2UgdGhh
dCBhbGxvd3MgYQ0KPiBWTSB0byBleHBvc2UgYSB2aG9zdC11c2VyIGRldmljZSB0byBhbm90aGVy
IFZNLiAgRm9yIGluc3RhbmNlLCBvbmUNCj4gY291bGQgYXNzaWduIGEgTklDIHRvIG9uZSBWTSBh
bmQgaGF2ZSBpdCBwcm92aWRlIGEgdmhvc3QtdXNlci1uZXQNCj4gZGV2aWNlIGZvciB1c2UgYnkg
YSBkaWZmZXJlbnQgVk0uDQo+DQo+IEkgYnJvdWdodCB0aGlzIHVwIG9uIHRoZSBLVk0vUUVNVSBj
b21tdW5pdHkgY2FsbCB0b2RheS4gIEFsZXggQmVubsOpZQ0KPiByZWNvbW1lbmRlZCB1c2luZyB2
aXJ0aW8tbXNnIGluc3RlYWQuICBIb3dldmVyLCBJIGhhdmUgYSBmZXcgY29uY2VybnMNCj4gd2l0
aCB0aGlzOg0KPg0KPiAxLiBWaXJ0aW8tbXNnIGJ1c2VzIGFyZSBzcGVjaWZpYyB0byBhIGdpdmVu
IGh5cGVydmlzb3Igb3IgKGluIHRoZQ0KPiAgIGNhc2Ugb2YgRkYtQSkgdG8gYSBnaXZlbiBDUFUg
YXJjaGl0ZWN0dXJlLiAgTm9uZSBvZiB0aGUgY3VycmVudA0KPiAgIGJ1c2VzIHN1cHBvcnQgS1ZN
IG9uIHBsYXRmb3JtcyBvdGhlciB0aGFuIEFybTY0LiAgVGhlcmVmb3JlLA0KPiAgIGEgYnJhbmQt
bmV3IGJ1cyB3b3VsZCBiZSBuZWVkZWQuDQoNCkV2ZW4gRkYtQSBpcyBub3QgdXNlYWJsZSBhdCB0
aGUgbW9tZW50IHdpdGggS1ZNIGFzIHRoZXJlIGlzIG5vIEZGLUENCnN1cHBvcnQgZm9yIFZNIHRv
IFZNIGluIEtWTSAob25seSBob3N0IGNhbiBjb21tdW5pY2F0ZSB3aXRoIHRoZSBzZWN1cmUNCndv
cmxkKS4NCg0KTU1JTyBvciBQQ0kgYmFzZWQgdmlydGlvIGluIEtWTSBjYXNlIGlzIHdvcmtpbmcg
YW5kIHdhcyBub3QgcmVhbGx5DQp0aGUgdGFyZ2V0IG9mIG91ciB3b3JrLg0KDQpwS1ZNIGlzIGEg
dGFyZ2V0IGFuZCBpcyBiZWluZyB3b3JrZWQgb24gdXNpbmcgRkYtQSBidXQgcFZNIHRvIEhvc3QN
CnZpcnRpbyBpcyBzdGlsbCB1c2luZyBQQ0kgYXQgdGhlIG1vbWVudA0KDQpOb3cgY3JlYXRpbmcg
YSBLVk0gc3BlY2lmaWMgYnVzIHJldXNpbmcgdGhlIGNvbmNlcHQgb2YgYSBGSUZPDQp0byB0cmFu
c2ZlciB0aGUgbWVzc2FnZXMgYmV0d2VlbiBhIFZNIGFuZCBIb3N0IGlzIGRlZmluaXRlbHkgcG9z
c2libGUNCnRvIGRvIGFuZCBzaG91bGQgbm90IGJlIHRoYXQgY29tcGxleC4NCg0KUmlnaHQgbm93
IGkgYW0gd29ya2luZyBvbiBiYWNrZW5kIGltcGxlbWVudGF0aW9uIHdoZXJlOg0KLSB0aGUgYnVz
IGltcGxlbWVudGF0aW9uIHdvdWxkIGJlIGluIGxpbnV4IGtlcm5lbCBhbGxvd2luZyBzZXZlcmFs
DQppbXBsZW1lbnRhdGlvbnMgbGlrZSBGRi1BLCB4ZW4gb3Igb3RoZXJzIHRvIGJlIGRvbmUgYXMg
bGludXggZHJpdmVycy4NCi0gaGF2ZSBhIGJ1cyBpbnRlcmZhY2UgcHJvdmlkZWQgdG8gdXNlciBs
YW5kIHNvIHRoYXQgUWVtdSBjb3VsZCBjb250YWluDQp0aGUgdHJhbnNwb3J0IGltcGxlbWVudGF0
aW9uIGJ1dCB3b3VsZCBub3QgbmVlZCB0byBiZSBtb2RpZmllZCBmb3IgbmV3DQpidXMgaW1wbGVt
ZW50YXRpb25zLg0KDQpSZXVzaW5nIHRoaXMsIGl0IHNob3VsZCBiZSBmYWlybHkgc2ltcGxlIHRv
IGRlZmluZSBhIEtWTSBidXMgYW5kIHJldXNlDQp0aGUgb3RoZXIgcGFydHMgb2YgdGhlIGltcGxl
bWVudGF0aW9ucy4NCg0KPg0KPiAyLiBWaXJ0aW8tbXNnIHJlcXVpcmVzIG5vdC15ZXQtdXBzdHJl
YW0gZHJpdmVycyBpbiBib3RoIHRoZSBmcm9udGVuZA0KPiAgICh0aGUgVk0gdXNpbmcgdGhlIGRl
dmljZSkgYW5kIHRoZSBiYWNrZW5kICh0aGUgVk0gcHJvdmlkaW5nIHRoZQ0KPiAgIGRldmljZSku
ICBWaG9zdC11c2VyIHVzZXMgYW55IG9mIHRoZSBleGlzdGluZyB0cmFuc3BvcnRzLCBzdWNoIGFz
DQo+ICAgUENJIG9yIE1NSU8uICBUaGlzIG1lYW5zIHRoYXQgdXBzdHJlYW0gZHJpdmVycyBjYW4g
YmUgdXNlZCBpbiB0aGUNCj4gICBmcm9udGVuZCwgYW5kIGFsc28gZW5hYmxlcyBzdXBwb3J0cyBm
b3IgV2luZG93cyBhbmQgb3RoZXIgZ3Vlc3RzDQo+ICAgdGhhdCBsYWNrIHN1cHBvcnQgZm9yIHZp
cnRpby1tc2cuDQoNClRoaXMgaXMgZGVmaW5pdGVseSB0cnVlIGFuZCB3aWxsIGFsd2F5cyBzdGF5
IHRydWUuIFRvIHVzZSB2aXJ0aW8tbXNnIHlvdQ0Kd2lsbCBuZWVkIGEgbmV3IHRyYW5zcG9ydCBp
bXBsZW1lbnRhdGlvbiBmb3IgaXQgd2hlbiB5b3Ugd2FudCB0byB1c2UNCml0IGFuZCB0aGUgYnVz
IGltcGxlbWVudGF0aW9uKHMpIHlvdSByZXF1aXJlLiBUbyBiZSB1c2VkIGluIHdpbmRvd3MNCnRo
b3NlIHBhcnQgd2lsbCBhbHNvIGJlIG5lZWRlZC4NCg0KSW4geW91ciBleGFtcGxlIGhlcmUgeW91
IHJlbHkgb24gZXhpc3RpbmcgTU1JTyBvciBQQ0kgdHJhbnNwb3J0IGFuZA0KZXhpc3Rpbmcgdmhv
c3QgaW1wbGVtZW50YXRpb25zLiBUaGlzIGlzIGRlZmluaXRlbHkgcXVpY2tlciB0byBkbyBhbmQg
dXNlLg0KVGhlIGdvYWwgaXMgbm90IHJlcGxhY2Ugd2hhdCB3b3JrcyBidXQgdG8gcHJvdmlkZSBz
b2x1dGlvbnMgZm9yIHVzZSBjYXNlcw0Kd2hlcmUgTU1JTyBvciBQQ0kgY3VycmVudGx5IGRvIG5v
dCB3b3JrIG9yIG5lZWQgdG8gYmUgb3B0aW1pemVkLg0KDQo+DQo+IDMuIFZob3N0LXVzZXIgaXMg
YWxyZWFkeSB3aWRlbHkgZGVwbG95ZWQsIHNvIGZyb250ZW5kIGltcGxlbWVudGF0aW9ucw0KPiAg
IGFyZSBxdWl0ZSB3ZWxsIHRlc3RlZC4gIEEgS1ZNLXNwZWNpZmljIHZpcnRpby1tc2cgdHJhbnNw
b3J0IHdvdWxkDQo+ICAgc2VydmUgb25seSBvbmUgcHVycG9zZTogZHJpdmVyIFZNcyAod2l0aCBh
c3NpZ25lZCBkZXZpY2VzKSBvbg0KPiAgIG5vbi1Bcm02NCBwbGF0Zm9ybXMuICBUaGlzIGlzIGEg
cXVpdGUgbmljaGUgdXNlLWNhc2UuICBUaGVyZWZvcmUsDQo+ICAgSSdtIGNvbmNlcm5lZCB0aGF0
IHRoZSBuZWVkZWQgZnJvbnRlbmQgY29kZSB3aWxsIGJlIHBvb3JseSB0ZXN0ZWQNCj4gICBhbmQg
Yml0cm90Lg0KDQpXZSBhcmUgaW4gdGhlIHByb2Nlc3Mgb2YgZGVmaW5pbmcgdGhlIHNwZWNpZmlj
YXRpb24gZm9yIHZpcnRpby1tc2cgYW5kIHdlDQphcmUgd29ya2luZyBvbiBpbXBsZW1lbnRhdGlv
bnMgaW4gcGFyYWxsZWwgc28gb3VyIGltcGxlbWVudGF0aW9ucyBhcmUNCmZvciBub3cgbm90IHdp
ZGVseSB0ZXN0ZWQgdGhhdCBpcyBjbGVhci4NCk5vdyBhIHNwZWNpZmljIEtWTSB2aXJ0aW8gbWVz
c2FnZSBidXMgaW1wbGVtZW50YXRpb24gd291bGQgcmV1c2UNCnRoZSB0cmFuc3BvcnQgYW5kIGRy
aXZlciBpbXBsZW1lbnRhdGlvbnMgd2hpY2ggd291bGQgYmUgdXNlZCBvbiBhbnkNCnBsYXRmb3Jt
cyBpbiB0aGUgZnV0dXJlLiBJIGFtIG5vdCBmb2xsb3dpbmcgeW91ciBuaWNoZSB1c2UtY2FzZSBo
ZXJlDQphbmQgdGhlIHBvb3JseSB0ZXN0ZWQgYXJndW1lbnQuIE1heWJlIGkgYW0gbWlzc2luZyBz
b21ldGhpbmcuDQoNCj4NCj4gTWFub3MgUGl0c2lkaWFuYWtpcyBzdGF0ZWQgdGhhdCB2aG9zdC11
c2VyIGRvZXMgbm90IG1ha2Ugc2Vuc2UgaW4NCj4gdGhpcyBjYXNlLiAgV2h5IGlzIHRoYXQ/ICBX
b3VsZCBpdCBtYWtlIHNlbnNlIHRvIHVzZSB2aXJ0aW8tbXNnDQo+IGJldHdlZW4gVk1NIGFuZCBp
dHMgVk0sIGFuZCBleHBvc2UgYSB2aG9zdC11c2VyIGRldmljZSB0byB0aGUNCj4gb3V0c2lkZSB3
b3JsZD8gIFdoYXQgYWJvdXQgaGF2aW5nIHRoZSB2aXJ0aW8tdmhvc3QtdXNlciBndWVzdCBkcml2
ZXINCj4gZW11bGF0ZSBhIHZpcnRpby1tc2cgdHJhbnNwb3J0LCBzbyB0aGF0IGl0IGNhbiBiZSB1
c2VkIHdpdGggYW55IGRldmljZQ0KPiBpbXBsZW1lbnRhdGlvbiBzdXBwb3J0aW5nIHZpcnRpby1t
c2c/DQoNCkkgYW0gbm90IGZvbGxvd2luZyB5b3VyIHBvaW50IGhlcmUuIFlvdSB3YW50IHRvIGRv
IHZpcnRpbyBvbiB0b3Agb2YgdmlydGlvID8NCg0KUmVnYXJkcw0KQmVydHJhbmQNCg0KPg0KPiBJ
IHdvdWxkIGdyZWF0bHkgYXBwcmVjaWF0ZSBhbnkgYW5kIGFsbCBzdWdnZXN0aW9ucyBoZXJlLiAg
VGhpcyBpcyBhDQo+IHNlcmlvdXMgcHJvamVjdCB0aGF0IGlzIGdvaW5nIHRvIGJlIHVzZWQgaW4g
cHJvZHVjdGlvbiwgYnV0IEkgd2FudA0KPiB0byBlbnN1cmUgdGhhdCB0aGUgZGVzaWduIGlzIHRo
ZSBiZXN0IHBvc3NpYmxlLg0KPiAtLQ0KPiBTaW5jZXJlbHksDQo+IERlbWkgTWFyaWUgT2Jlbm91
ciAoc2hlL2hlci9oZXJzKQ0KPiA8T3BlblBHUF8weEIyODhCNTVGRkY5QzIyQzEuYXNjPg0KDQpJ
TVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFj
aG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlv
dSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRl
ciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3Ro
ZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBp
bmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=

