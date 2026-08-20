Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1307C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 00:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwqgf-0001O7-9K; Wed, 19 Aug 2026 20:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1wwqgc-0001Nd-5k
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 20:31:14 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1wwqgY-0000HM-Bq
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 20:31:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHzvAK9ti1jS9H0OZ3OZNIwOvEEGCaMQZD4blxr14BwOgswKXKRVxOj/BgDZAk269lwWtBHAtkdZG4TTvszXBnwNivDCGeH9ssFuhuoKyDws9t39vhoqMcFlBiEUCz6bDttCSsBa/tB6rLXfQ+5JcNNyo6FVAIjckc2poSkYPh2c9HQL0bNGkwOBmoh0OALENcXLH7o8YJmPm0JZOH7ssUn95uoVQkBkdx4PMaLwVTIsMZ1HI6w6q3Oo6DWPapBgqQwIKpGvMt1aOJbljbLpyQt01o0lXvaTFyZV6HZydlT5FoWBne0n+mIFM4ZPwwlvW+NonIXrWfIJNZXkBPJzAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGjuAPf/ZgzdFhlcLEUUAceoZVVf64Qjo0qpNPVB2KM=;
 b=k5dcnvUrdT8sgIoM1cp3eACEzPKidcM5A22wHIciWKjeEEPvfwG46u/FmS5lVZPfoA5Z83Dz4O/591ypTU4vQ4L9IkEmpmTC9MpC//XGKA4Zxx6mS1ET8Y3YM69agnEF7VIknDe/4706tJ7xIxN/af0v3fUSosa3tKfm2nTs3wvDxC0gWoDK5EUB7a4ZRK9uukIxg7cccPXdqDTqMk3B1MGDJLT1FNNxP0jBrVTuAxBdGeuk7CMmFit9fDhZJRVPsNXVx8CeZbCq+KG0VX0u5gl0MBpsoX2fEsoAzV2AiIOcGxZv30hV0OfvRqD0pxbv7rG2J560plq7crDnqJRlwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGjuAPf/ZgzdFhlcLEUUAceoZVVf64Qjo0qpNPVB2KM=;
 b=WSOrUavVULQ2UzRA7XcBe52iKDa6q3rVBX+eNQL7i2W1r8BEOZRjH5prgyH70xTzS9FAY+LsG3a5haKeCZ2miIOxGnw5ppD+9MmqNrGm1zBK5eh+iYSmSrBSUX1aP8x903SIk2FRMJQnH2GqWFWm4C1WVO1OLA9hB3BfZqR7HvY=
Received: from LVXPR21MB7009.namprd21.prod.outlook.com (2603:10b6:408:37f::24)
 by LV5PR21MB4995.namprd21.prod.outlook.com (2603:10b6:408:2fb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.0; Thu, 20 Aug
 2026 00:30:31 +0000
Received: from LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc]) by LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc%4]) with mapi id 15.21.0315.008; Thu, 20 Aug 2026
 00:30:31 +0000
From: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Pedro d'Aquino Filocre F S Barbuda <pbarbuda@microsoft.com>,
 "mohamed@unpredictable.fr" <mohamed@unpredictable.fr>
Subject: [PATCH v2 2/3] target/arm/whpx: incorrect ENCODE_AA64_CP_REG
 parameter order
Thread-Topic: [PATCH v2 2/3] target/arm/whpx: incorrect ENCODE_AA64_CP_REG
 parameter order
Thread-Index: Ad0wOvX5dTb61SNeQYOjqV4Ezn3dUw==
Date: Thu, 20 Aug 2026 00:30:31 +0000
Message-ID: <LVXPR21MB7009F5C9E8D9C44602816944ADA42@LVXPR21MB7009.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=249a2130-12f0-4338-b9e8-2eb77295063b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-20T00:29:28Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVXPR21MB7009:EE_|LV5PR21MB4995:EE_
x-ms-office365-filtering-correlation-id: 0e8e7a4c-c33e-4a36-4b1e-08defe523de4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|38070700021|10067099003|7146999003|56012099006|11063799006|3023799007|18002099003;
x-microsoft-antispam-message-info: 66TCyUYAOgKlDvzrmM0H9WZqUB18ha3VffIFDQbEJlilM27P2lFdWVPQlf3AF4jDKjQTD5rPh6ZcQe1M3tqVUiujxETYxBVok5l94JwuhKZp5Cm6m7y11aJ1VeogdpETsRLOqcH0BAzy0ptsbJFxbR/gnFZvdye+mV7rUI9B106rrVrCHVrEBLeySx+t/LqDKHBIPl3il97HZgx7Qi48fpAs09AZbmKHzEmlmKOIclGij2pmE9JCNzTBYs8+6J6D5n2N1z82/kgjRfknteFFMPK2NBCZjFZS1nFlP+P8bWl5SFTmp5mW5Q1LeiWAuG+WVnpbEhoYnMMwdx+V1dwk2Og/g3lXlrkqRrbKiBUGkTgNU6Z/UMQP01n+0A2n2FkoXv6d4tp2dp5P4dNrjYWcJpHnCheal3jFK0x1GgJMi9fUyezKy7ynubbw914vApUVTw1+cjlhZ6yUA+WGm/LLzLMoPLAAyuhEP+Z6X6nac5w2QKa0Et2E7zSZH9efV0MuBlYApbgQtY10G8N2jwWaTyWjTrvIhdUvJv1sdPknx3qR1UQzxdxOlidBPPp3MU3T010TojN2lA5MLg1SvGMUycRPeioIg8VkngdLLka29D77kmcAx1S1i6UU9QGcfO7YSIkooLP7TM5WSEcmRO++Z3EIlEpaSolAt0k7+Hgbxs19Xvh4hzSnDNCQsOIpDKUiXsqIdn+8eeOoO51KuICT71SESaCoZRm7NqLyUemUdxk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVXPR21MB7009.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(10067099003)(7146999003)(56012099006)(11063799006)(3023799007)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GYY9+znvPppQiPJENpC3LLBpqbjsEWuRvgDLF0GLrufxgdvNWSGLDHUUMzxd?=
 =?us-ascii?Q?WZlBn9nQoBCMF4SxC+2Lq8QDj5Ec2RAa9L/2NjuttLHTqY9KMres8UClkHSY?=
 =?us-ascii?Q?WQk5mXqnmhMlMPlV8BIxG7nvO/RYvLW8dsooJleNs5QD5lI2PifoXsmZahBn?=
 =?us-ascii?Q?WtwlvPNYvuhvaocVCcw2xtAfh42BlBOcQoS+8Sjt+Ae0PeJ0MLXZ+63+mdfI?=
 =?us-ascii?Q?nB6aWXmpTlwZVZZS9ysVinQHPzkIXWrYTIk8heo/FEU8OFhxkvjjO4coOc2C?=
 =?us-ascii?Q?bczsahI03zdZNrSju8Bw7T01d+FZJCTmMmmHv+9YPYUgioCcjW0dyoqhOYJk?=
 =?us-ascii?Q?IAjSXIs+ULxDts2PtBw9WM9Id8nfnwA+K3a2/uttlw21BYuIxRmfZKWmguko?=
 =?us-ascii?Q?ou9Tw4Zx81BCfqgqAD1knmlqguiIThm2Pm0A+oY0SIs4noS0x3BVB16CzIM8?=
 =?us-ascii?Q?CGlg+aQbQv1qhjPMAOSLkKzw++clX7QQyn5UQCRnFK1gqSwH97kckvZrq/dK?=
 =?us-ascii?Q?zUDDR52YoujcjYxxpBQbKRWUai5ui6nxgHxNc59PDUuzFETJ/APNKazwViqi?=
 =?us-ascii?Q?yRriQ+vh1WuxJVmqbhnozOliazPJJDNHlnkpMmPpIuE5SZvTND55gRPUSWKW?=
 =?us-ascii?Q?oLZlirAQYKW29WBS81GTBhNPNw9kJaatyFE0fj5yaezgdxSEZWunmlG+ZT1r?=
 =?us-ascii?Q?XcHg/ip0W2k0ynZALwERUwkOUbYqXXJEYt70/ZL4NYp7cgVe82hkqqBta8DJ?=
 =?us-ascii?Q?6tSPjXoByjVOWEQIBxw5YKt2an2rGi2l8M6Syb11sE5FZKP3DqvyDX0JlSa5?=
 =?us-ascii?Q?Hck+1kv+t3lmSvOqQYYxFzg1PtaebLW6TgtJNQssWNpKdMh/lkSbIuZgxwCm?=
 =?us-ascii?Q?1xLQGFG9KVtpOorMtgyjtFdpTSMCztfTG+qpXCsBp4a09GRERbKLG/E/8K2z?=
 =?us-ascii?Q?SEFjDV/ysk59/s/x515wNJX41UCDV5AdEj0klXiFAk40O9ja/oegXHHSmBms?=
 =?us-ascii?Q?q6OO/vgq77Jj7dTK8/A0zJcqDOXeJ8fl5I5xwMPHCm5LIGMh65CmE3KibXPU?=
 =?us-ascii?Q?Nqwm0uAG9M9NXKseAXSy6ITGgyE8J3HSHNMXLDI+MD6duQ6TgHxsUkbExJNf?=
 =?us-ascii?Q?xVXjunGF+CtjQEMdbubW0DOvJGWPUeqT/z5+xfzMbF9I06AyUTcq+9cWzCRQ?=
 =?us-ascii?Q?XAysuvydaZzQPhiSjm6gU9pYuq7sLx/m/NyRUxZfW/z19m2RnwbJFV1wXw35?=
 =?us-ascii?Q?sUlvJ55A5v0FKV44T0kHvvbg55dcpwLH917s7u9eHa7LKbOjlgD7XqyBPawa?=
 =?us-ascii?Q?DLXEPpLVQ8f+/3ptsnNaCuFdGJlQ/mbTgqq5liYotsNhmOXO3H8ZNnntiQgQ?=
 =?us-ascii?Q?OHqiM+Q7zyGcZ0uO1a+rt5ylRHdyZUpBeA4hnsU7X062977auQJmsCZBB0Rx?=
 =?us-ascii?Q?IjYAaJMomum72nha5k7RWcVZcrCzLoWIQwUKjLDJOTEaFIwcFp2/GJuHudO/?=
 =?us-ascii?Q?fEJcmzM0bvQyqS1CioYJN5hTRTWXVJDEjwFWLNlCshJJP73eEWMLt3kHzXhX?=
 =?us-ascii?Q?v+hROUNTCUkdV0ErVVmAwck2Vnx/KY+qZG8OyLxT8A4Zx06tnQvg7eQbMgjm?=
 =?us-ascii?Q?uy/w5qfx/35PaN9SCNMlKhmJqM4xCxd1BjLLgS/viq1X250rGJRsQ4yl/JiY?=
 =?us-ascii?Q?dqyR2j10GyU/SssAYQ9PiOYqOgSu28oOYP1shGbjO9oDxCTW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVXPR21MB7009.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8e7a4c-c33e-4a36-4b1e-08defe523de4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 00:30:31.1910 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7XW2wsvdXOr54Mv5/S+k707AwCpi+uf/5v+UkvLSy7i6gTVZ+Zdkckqsb1PQiWQ6xxJA1urcRtx4HFgDntO4iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR21MB4995
Received-SPF: pass client-ip=2a01:111:f403:c10c::1;
 envelope-from=dcook@microsoft.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

ENCODE_AA64_CP_REG expects parameters (op0, op1, crn, crm, op2) but whpx
was using parameter order (crn, crm, op0, op1, op2). As a result, every
call to get_arm_cp_reginfo() returned NULL, cp_idx was -1, and both
whpx_get_registers() and whpx_set_registers() were no-ops.

In addition, several encodings were paired with the wrong WHV register
tag. These are inert while the encodings do not resolve, but would sync
the wrong register once they do:

- the series 1 debug register encodings used series 0 tags,
- the SP_EL0 encoding was tagged WHvArm64RegisterSpEl1, which would
  clobber SP_EL0 with SP_EL1 on get and never write SP_EL0 on set,
- the ID_AA64PFR0_EL1 encoding was tagged WHvArm64RegisterIdPfr0El1.

Fix parameter order (using a regular expression). Fix tags.

Signed-off-by: Doug Cook <dcook@microsoft.com>
---
 target/arm/whpx/whpx-all.c | 252 ++++++++++++++++++-------------------
 1 file changed, 126 insertions(+), 126 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 9a5a575b5e..a05df7d2cb 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -135,145 +135,145 @@ struct whpx_sreg_match {
 };
=20
 static struct whpx_sreg_match whpx_sreg_match[] =3D {
-    { WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 7) },
+    { WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(2, 0, 0, 0, 4) },
+    { WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(2, 0, 0, 0, 5) },
+    { WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(2, 0, 0, 0, 6) },
+    { WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(2, 0, 0, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr1El1, ENCODE_AA64_CP_REG(2, 0, 0, 1, 4) },
+    { WHvArm64RegisterDbgbcr1El1, ENCODE_AA64_CP_REG(2, 0, 0, 1, 5) },
+    { WHvArm64RegisterDbgwvr1El1, ENCODE_AA64_CP_REG(2, 0, 0, 1, 6) },
+    { WHvArm64RegisterDbgwcr1El1, ENCODE_AA64_CP_REG(2, 0, 0, 1, 7) },
+
+    { WHvArm64RegisterDbgbvr2El1, ENCODE_AA64_CP_REG(2, 0, 0, 2, 4) },
+    { WHvArm64RegisterDbgbcr2El1, ENCODE_AA64_CP_REG(2, 0, 0, 2, 5) },
+    { WHvArm64RegisterDbgwvr2El1, ENCODE_AA64_CP_REG(2, 0, 0, 2, 6) },
+    { WHvArm64RegisterDbgwcr2El1, ENCODE_AA64_CP_REG(2, 0, 0, 2, 7) },
+
+    { WHvArm64RegisterDbgbvr3El1, ENCODE_AA64_CP_REG(2, 0, 0, 3, 4) },
+    { WHvArm64RegisterDbgbcr3El1, ENCODE_AA64_CP_REG(2, 0, 0, 3, 5) },
+    { WHvArm64RegisterDbgwvr3El1, ENCODE_AA64_CP_REG(2, 0, 0, 3, 6) },
+    { WHvArm64RegisterDbgwcr3El1, ENCODE_AA64_CP_REG(2, 0, 0, 3, 7) },
+
+    { WHvArm64RegisterDbgbvr4El1, ENCODE_AA64_CP_REG(2, 0, 0, 4, 4) },
+    { WHvArm64RegisterDbgbcr4El1, ENCODE_AA64_CP_REG(2, 0, 0, 4, 5) },
+    { WHvArm64RegisterDbgwvr4El1, ENCODE_AA64_CP_REG(2, 0, 0, 4, 6) },
+    { WHvArm64RegisterDbgwcr4El1, ENCODE_AA64_CP_REG(2, 0, 0, 4, 7) },
+
+    { WHvArm64RegisterDbgbvr5El1, ENCODE_AA64_CP_REG(2, 0, 0, 5, 4) },
+    { WHvArm64RegisterDbgbcr5El1, ENCODE_AA64_CP_REG(2, 0, 0, 5, 5) },
+    { WHvArm64RegisterDbgwvr5El1, ENCODE_AA64_CP_REG(2, 0, 0, 5, 6) },
+    { WHvArm64RegisterDbgwcr5El1, ENCODE_AA64_CP_REG(2, 0, 0, 5, 7) },
+
+    { WHvArm64RegisterDbgbvr6El1, ENCODE_AA64_CP_REG(2, 0, 0, 6, 4) },
+    { WHvArm64RegisterDbgbcr6El1, ENCODE_AA64_CP_REG(2, 0, 0, 6, 5) },
+    { WHvArm64RegisterDbgwvr6El1, ENCODE_AA64_CP_REG(2, 0, 0, 6, 6) },
+    { WHvArm64RegisterDbgwcr6El1, ENCODE_AA64_CP_REG(2, 0, 0, 6, 7) },
+
+    { WHvArm64RegisterDbgbvr7El1, ENCODE_AA64_CP_REG(2, 0, 0, 7, 4) },
+    { WHvArm64RegisterDbgbcr7El1, ENCODE_AA64_CP_REG(2, 0, 0, 7, 5) },
+    { WHvArm64RegisterDbgwvr7El1, ENCODE_AA64_CP_REG(2, 0, 0, 7, 6) },
+    { WHvArm64RegisterDbgwcr7El1, ENCODE_AA64_CP_REG(2, 0, 0, 7, 7) },
+
+    { WHvArm64RegisterDbgbvr8El1, ENCODE_AA64_CP_REG(2, 0, 0, 8, 4) },
+    { WHvArm64RegisterDbgbcr8El1, ENCODE_AA64_CP_REG(2, 0, 0, 8, 5) },
+    { WHvArm64RegisterDbgwvr8El1, ENCODE_AA64_CP_REG(2, 0, 0, 8, 6) },
+    { WHvArm64RegisterDbgwcr8El1, ENCODE_AA64_CP_REG(2, 0, 0, 8, 7) },
+
+    { WHvArm64RegisterDbgbvr9El1, ENCODE_AA64_CP_REG(2, 0, 0, 9, 4) },
+    { WHvArm64RegisterDbgbcr9El1, ENCODE_AA64_CP_REG(2, 0, 0, 9, 5) },
+    { WHvArm64RegisterDbgwvr9El1, ENCODE_AA64_CP_REG(2, 0, 0, 9, 6) },
+    { WHvArm64RegisterDbgwcr9El1, ENCODE_AA64_CP_REG(2, 0, 0, 9, 7) },
+
+    { WHvArm64RegisterDbgbvr10El1, ENCODE_AA64_CP_REG(2, 0, 0, 10, 4) },
+    { WHvArm64RegisterDbgbcr10El1, ENCODE_AA64_CP_REG(2, 0, 0, 10, 5) },
+    { WHvArm64RegisterDbgwvr10El1, ENCODE_AA64_CP_REG(2, 0, 0, 10, 6) },
+    { WHvArm64RegisterDbgwcr10El1, ENCODE_AA64_CP_REG(2, 0, 0, 10, 7) },
+
+    { WHvArm64RegisterDbgbvr11El1, ENCODE_AA64_CP_REG(2, 0, 0, 11, 4) },
+    { WHvArm64RegisterDbgbcr11El1, ENCODE_AA64_CP_REG(2, 0, 0, 11, 5) },
+    { WHvArm64RegisterDbgwvr11El1, ENCODE_AA64_CP_REG(2, 0, 0, 11, 6) },
+    { WHvArm64RegisterDbgwcr11El1, ENCODE_AA64_CP_REG(2, 0, 0, 11, 7) },
+
+    { WHvArm64RegisterDbgbvr12El1, ENCODE_AA64_CP_REG(2, 0, 0, 12, 4) },
+    { WHvArm64RegisterDbgbcr12El1, ENCODE_AA64_CP_REG(2, 0, 0, 12, 5) },
+    { WHvArm64RegisterDbgwvr12El1, ENCODE_AA64_CP_REG(2, 0, 0, 12, 6) },
+    { WHvArm64RegisterDbgwcr12El1, ENCODE_AA64_CP_REG(2, 0, 0, 12, 7) },
+
+    { WHvArm64RegisterDbgbvr13El1, ENCODE_AA64_CP_REG(2, 0, 0, 13, 4) },
+    { WHvArm64RegisterDbgbcr13El1, ENCODE_AA64_CP_REG(2, 0, 0, 13, 5) },
+    { WHvArm64RegisterDbgwvr13El1, ENCODE_AA64_CP_REG(2, 0, 0, 13, 6) },
+    { WHvArm64RegisterDbgwcr13El1, ENCODE_AA64_CP_REG(2, 0, 0, 13, 7) },
+
+    { WHvArm64RegisterDbgbvr14El1, ENCODE_AA64_CP_REG(2, 0, 0, 14, 4) },
+    { WHvArm64RegisterDbgbcr14El1, ENCODE_AA64_CP_REG(2, 0, 0, 14, 5) },
+    { WHvArm64RegisterDbgwvr14El1, ENCODE_AA64_CP_REG(2, 0, 0, 14, 6) },
+    { WHvArm64RegisterDbgwcr14El1, ENCODE_AA64_CP_REG(2, 0, 0, 14, 7) },
+
+    { WHvArm64RegisterDbgbvr15El1, ENCODE_AA64_CP_REG(2, 0, 0, 15, 4) },
+    { WHvArm64RegisterDbgbcr15El1, ENCODE_AA64_CP_REG(2, 0, 0, 15, 5) },
+    { WHvArm64RegisterDbgwvr15El1, ENCODE_AA64_CP_REG(2, 0, 0, 15, 6) },
+    { WHvArm64RegisterDbgwcr15El1, ENCODE_AA64_CP_REG(2, 0, 0, 15, 7) },
 #ifdef SYNC_NO_RAW_REGS
     /*
      * The registers below are manually synced on init because they are
      * marked as NO_RAW. We still list them to make number space sync easi=
er.
      */
-    { WHvArm64RegisterMidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 0) },
-    { WHvArm64RegisterMpidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 5) },
-    { WHvArm64RegisterIdPfr0El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 0) },
+    { WHvArm64RegisterMidrEl1, ENCODE_AA64_CP_REG(3, 0, 0, 0, 0) },
+    { WHvArm64RegisterMpidrEl1, ENCODE_AA64_CP_REG(3, 0, 0, 0, 5) },
+    { WHvArm64RegisterIdAa64Pfr0El1, ENCODE_AA64_CP_REG(3, 0, 0, 4, 0) },
 #endif
 #ifdef SYNC_CONST_ID_REGS
     /* ID registers are ARM_CP_CONST (writes ignored).  */
-    { WHvArm64RegisterIdAa64Pfr1El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 1), tr=
ue },
-    { WHvArm64RegisterIdAa64Dfr0El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, 0), tr=
ue },
-    { WHvArm64RegisterIdAa64Dfr1El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, 1), tr=
ue },
-    { WHvArm64RegisterIdAa64Isar0El1, ENCODE_AA64_CP_REG(0, 6, 3, 0, 0), t=
rue },
-    { WHvArm64RegisterIdAa64Isar1El1, ENCODE_AA64_CP_REG(0, 6, 3, 0, 1), t=
rue },
+    { WHvArm64RegisterIdAa64Pfr1El1, ENCODE_AA64_CP_REG(3, 0, 0, 4, 1), tr=
ue },
+    { WHvArm64RegisterIdAa64Dfr0El1, ENCODE_AA64_CP_REG(3, 0, 0, 5, 0), tr=
ue },
+    { WHvArm64RegisterIdAa64Dfr1El1, ENCODE_AA64_CP_REG(3, 0, 0, 5, 1), tr=
ue },
+    { WHvArm64RegisterIdAa64Isar0El1, ENCODE_AA64_CP_REG(3, 0, 0, 6, 0), t=
rue },
+    { WHvArm64RegisterIdAa64Isar1El1, ENCODE_AA64_CP_REG(3, 0, 0, 6, 1), t=
rue },
 #ifdef SYNC_NO_MMFR0
     /* We keep the hardware MMFR0 around. HW limits are there anyway */
-    { WHvArm64RegisterIdAa64Mmfr0El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 0) },
+    { WHvArm64RegisterIdAa64Mmfr0El1, ENCODE_AA64_CP_REG(3, 0, 0, 7, 0) },
 #endif
-    { WHvArm64RegisterIdAa64Mmfr1El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 1), t=
rue },
-    { WHvArm64RegisterIdAa64Mmfr2El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 2), t=
rue },
-    { WHvArm64RegisterIdAa64Mmfr3El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 3), t=
rue },
+    { WHvArm64RegisterIdAa64Mmfr1El1, ENCODE_AA64_CP_REG(3, 0, 0, 7, 1), t=
rue },
+    { WHvArm64RegisterIdAa64Mmfr2El1, ENCODE_AA64_CP_REG(3, 0, 0, 7, 2), t=
rue },
+    { WHvArm64RegisterIdAa64Mmfr3El1, ENCODE_AA64_CP_REG(3, 0, 0, 7, 3), t=
rue },
 #endif
=20
-    { WHvArm64RegisterMdscrEl1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 2) },
-    { WHvArm64RegisterSctlrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 0) },
-    { WHvArm64RegisterCpacrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 2) },
-    { WHvArm64RegisterTtbr0El1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 0) },
-    { WHvArm64RegisterTtbr1El1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 1) },
-    { WHvArm64RegisterTcrEl1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 2) },
-
-    { WHvArm64RegisterApiAKeyLoEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 0) },
-    { WHvArm64RegisterApiAKeyHiEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 1) },
-    { WHvArm64RegisterApiBKeyLoEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 2) },
-    { WHvArm64RegisterApiBKeyHiEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 3) },
-    { WHvArm64RegisterApdAKeyLoEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 0) },
-    { WHvArm64RegisterApdAKeyHiEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 1) },
-    { WHvArm64RegisterApdBKeyLoEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 2) },
-    { WHvArm64RegisterApdBKeyHiEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 3) },
-    { WHvArm64RegisterApgAKeyLoEl1, ENCODE_AA64_CP_REG(2, 3, 3, 0, 0) },
-    { WHvArm64RegisterApgAKeyHiEl1, ENCODE_AA64_CP_REG(2, 3, 3, 0, 1) },
-
-    { WHvArm64RegisterSpsrEl1, ENCODE_AA64_CP_REG(4, 0, 3, 0, 0) },
-    { WHvArm64RegisterElrEl1, ENCODE_AA64_CP_REG(4, 0, 3, 0, 1) },
-    { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(4, 1, 3, 0, 0) },
-    { WHvArm64RegisterEsrEl1, ENCODE_AA64_CP_REG(5, 2, 3, 0, 0) },
-    { WHvArm64RegisterFarEl1, ENCODE_AA64_CP_REG(6, 0, 3, 0, 0) },
-    { WHvArm64RegisterParEl1, ENCODE_AA64_CP_REG(7, 4, 3, 0, 0) },
-    { WHvArm64RegisterMairEl1, ENCODE_AA64_CP_REG(10, 2, 3, 0, 0) },
-    { WHvArm64RegisterVbarEl1, ENCODE_AA64_CP_REG(12, 0, 3, 0, 0) },
-    { WHvArm64RegisterContextidrEl1, ENCODE_AA64_CP_REG(13, 0, 3, 0, 1) },
-    { WHvArm64RegisterTpidrEl1, ENCODE_AA64_CP_REG(13, 0, 3, 0, 4) },
-    { WHvArm64RegisterCntkctlEl1, ENCODE_AA64_CP_REG(14, 1, 3, 0, 0) },
-    { WHvArm64RegisterCsselrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 2, 0) },
-    { WHvArm64RegisterTpidrEl0, ENCODE_AA64_CP_REG(13, 0, 3, 3, 2) },
-    { WHvArm64RegisterTpidrroEl0, ENCODE_AA64_CP_REG(13, 0, 3, 3, 3) },
-    { WHvArm64RegisterCntvCtlEl0, ENCODE_AA64_CP_REG(14, 3, 3, 3, 1) },
-    { WHvArm64RegisterCntvCvalEl0, ENCODE_AA64_CP_REG(14, 3, 3, 3, 2) },
-    { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(4, 1, 3, 4, 0) },
+    { WHvArm64RegisterMdscrEl1, ENCODE_AA64_CP_REG(2, 0, 0, 2, 2) },
+    { WHvArm64RegisterSctlrEl1, ENCODE_AA64_CP_REG(3, 0, 1, 0, 0) },
+    { WHvArm64RegisterCpacrEl1, ENCODE_AA64_CP_REG(3, 0, 1, 0, 2) },
+    { WHvArm64RegisterTtbr0El1, ENCODE_AA64_CP_REG(3, 0, 2, 0, 0) },
+    { WHvArm64RegisterTtbr1El1, ENCODE_AA64_CP_REG(3, 0, 2, 0, 1) },
+    { WHvArm64RegisterTcrEl1, ENCODE_AA64_CP_REG(3, 0, 2, 0, 2) },
+
+    { WHvArm64RegisterApiAKeyLoEl1, ENCODE_AA64_CP_REG(3, 0, 2, 1, 0) },
+    { WHvArm64RegisterApiAKeyHiEl1, ENCODE_AA64_CP_REG(3, 0, 2, 1, 1) },
+    { WHvArm64RegisterApiBKeyLoEl1, ENCODE_AA64_CP_REG(3, 0, 2, 1, 2) },
+    { WHvArm64RegisterApiBKeyHiEl1, ENCODE_AA64_CP_REG(3, 0, 2, 1, 3) },
+    { WHvArm64RegisterApdAKeyLoEl1, ENCODE_AA64_CP_REG(3, 0, 2, 2, 0) },
+    { WHvArm64RegisterApdAKeyHiEl1, ENCODE_AA64_CP_REG(3, 0, 2, 2, 1) },
+    { WHvArm64RegisterApdBKeyLoEl1, ENCODE_AA64_CP_REG(3, 0, 2, 2, 2) },
+    { WHvArm64RegisterApdBKeyHiEl1, ENCODE_AA64_CP_REG(3, 0, 2, 2, 3) },
+    { WHvArm64RegisterApgAKeyLoEl1, ENCODE_AA64_CP_REG(3, 0, 2, 3, 0) },
+    { WHvArm64RegisterApgAKeyHiEl1, ENCODE_AA64_CP_REG(3, 0, 2, 3, 1) },
+
+    { WHvArm64RegisterSpsrEl1, ENCODE_AA64_CP_REG(3, 0, 4, 0, 0) },
+    { WHvArm64RegisterElrEl1, ENCODE_AA64_CP_REG(3, 0, 4, 0, 1) },
+    { WHvArm64RegisterSpEl0, ENCODE_AA64_CP_REG(3, 0, 4, 1, 0) },
+    { WHvArm64RegisterEsrEl1, ENCODE_AA64_CP_REG(3, 0, 5, 2, 0) },
+    { WHvArm64RegisterFarEl1, ENCODE_AA64_CP_REG(3, 0, 6, 0, 0) },
+    { WHvArm64RegisterParEl1, ENCODE_AA64_CP_REG(3, 0, 7, 4, 0) },
+    { WHvArm64RegisterMairEl1, ENCODE_AA64_CP_REG(3, 0, 10, 2, 0) },
+    { WHvArm64RegisterVbarEl1, ENCODE_AA64_CP_REG(3, 0, 12, 0, 0) },
+    { WHvArm64RegisterContextidrEl1, ENCODE_AA64_CP_REG(3, 0, 13, 0, 1) },
+    { WHvArm64RegisterTpidrEl1, ENCODE_AA64_CP_REG(3, 0, 13, 0, 4) },
+    { WHvArm64RegisterCntkctlEl1, ENCODE_AA64_CP_REG(3, 0, 14, 1, 0) },
+    { WHvArm64RegisterCsselrEl1, ENCODE_AA64_CP_REG(3, 2, 0, 0, 0) },
+    { WHvArm64RegisterTpidrEl0, ENCODE_AA64_CP_REG(3, 3, 13, 0, 2) },
+    { WHvArm64RegisterTpidrroEl0, ENCODE_AA64_CP_REG(3, 3, 13, 0, 3) },
+    { WHvArm64RegisterCntvCtlEl0, ENCODE_AA64_CP_REG(3, 3, 14, 3, 1) },
+    { WHvArm64RegisterCntvCvalEl0, ENCODE_AA64_CP_REG(3, 3, 14, 3, 2) },
+    { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(3, 4, 4, 1, 0) },
 };
=20
 HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
--=20
2.55.0.vfs.0.3

