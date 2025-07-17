Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B668AC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 09:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLKs-0001EC-Tc; Thu, 17 Jul 2025 05:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL53-0006dk-W3; Thu, 17 Jul 2025 05:39:10 -0400
Received: from mail-westeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c201::5] helo=AS8PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL52-0002Os-6I; Thu, 17 Jul 2025 05:39:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOdzLNTghznYcbDTYLhQOsl1NCZr0FI7M7Qoh+ZmvJj21iM4cBvdRV4ubdZ9gZW/XOicLs96t9t2+ZOsYQ+PESJbKnZrAU1Psc4+syBm2k4rnRCRnSdqB91DRELZ9ktRDtZ4M21FUzts/XCWDjl8e5X9S9wTKbe2sjk6M7JESxtdxbJmFLasog6WvWaD7lS3PTOqvQT9pvbnUX0GlM+8zT0TpT0BS5juMVQAkKwm9vf/d6NITM2S2ZxtgqlLaQDpB7cfi7aB9bXpWoqPJgzZcAWqgzX/ZAn3En5DXJn21yEdV8wGAznxzHYEwSem8R3PVKF8If2IdU0IBRsFiECSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJgu133TZscQUlhZO24MhRgXqd0U+EFvxkwHD+Is+vU=;
 b=szBmhU6kUN0FMYYv1+07RS8HXyt+FTDEeVgODaz5Ji/FzbA75Cyd4rnfeVpdnQTaDwoTbm4F3sDD9PfSscTnCp1Y18i73H/SA5R79VZSkStMGhLOQDhJlEyxrA/KeuNK3eFV8Cp4T2j9BSQ/uE3kg8oPIvLa5BzGNg/pE1VAKfEKVm3sQjmQoNF4J6M5XSl2HiNovRI+1NlTyAoQRP7hg0YOKUf+qmtW27SXdfjbygvtALhjA4aPURjs2XmCQk5nMRvHBh8wAen4znP//ZZ182Q3pGK9NYDFPZSADX38S0DNcMu7qETgzun47U1MegERgz51rUpWDpXhKtKZtt6ruQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJgu133TZscQUlhZO24MhRgXqd0U+EFvxkwHD+Is+vU=;
 b=pj8Yv4leDMn0d58TEdIUWhr0yyYRAniMll5caihgkfQUP6DaRLXuiRZ2jEwJyfyToj9bDHsvAbhbiixCPBcFeEjDaaXrqdQo4THaEAEhWawB6vVSORd5ImgC5yKruOefpQMNpI6sSA+V72nb33KsZvvAMIVBPShzCEan9ZA0fHWMTraKJ9PRoLR4i9pQbz6VUklpkMQG60rk7NmUIg+D7A1SED7Fs4btQOHLBm3eVLiG+Xp3k4//ZWCbXtI+0mRVRBbO00lO/qgiV4gErdMpfObLsRm4XP+uEO+Ob111RqOHGsoDYHP3LroZWq9WX50nRhNiXMn2ybmvQeGPr9oMGg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI1PR09MB4318.eurprd09.prod.outlook.com (2603:10a6:800:155::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 09:38:50 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 17 Jul 2025
 09:38:50 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v6 14/14] test/functional: Add test for boston-aia board
Thread-Topic: [PATCH v6 14/14] test/functional: Add test for boston-aia board
Thread-Index: AQHb9v6YDN4iWZ98eU2tCiBT1sz21Q==
Date: Thu, 17 Jul 2025 09:38:47 +0000
Message-ID: <20250717093833.402237-15-djordje.todorovic@htecgroup.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI1PR09MB4318:EE_
x-ms-office365-filtering-correlation-id: a874440c-e7bc-4525-8a45-08ddc515bca7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?f+/0VzJHGVpSlub/rNkLtGT5px48AtlfSoFjvDM8v2gdiM6kGQr1blLOTW?=
 =?iso-8859-1?Q?zuZ6CQ0pAPiCtq7NWzOy5We7leKpudpe9lcsYikQNe/ulIh+c0MY4XD/8c?=
 =?iso-8859-1?Q?AuvQaykRD67IJE71yH3Ao0qcgV/LYQIgX0oAnqo9rbHSrolx0xtwlmbSxz?=
 =?iso-8859-1?Q?FI+TVe2/L84U9iUTibGSBUYJZvzMWh8aFYKwpO7v1D2++QxKZkulmwXE5G?=
 =?iso-8859-1?Q?xU9yhE7omYWDlX2NpS4tEXVuurPqvn71G+h3dsHkVv1M0FLQEyK3jGIHJU?=
 =?iso-8859-1?Q?QcZBsZO2iSEPWb0bOKI4oBdsAe5hTdWmUvxvsT22pycZGyioacWgex66i/?=
 =?iso-8859-1?Q?I9H0PqjqgkARgUYcF3GWy8SUCxQ0s1kF/9VgOTAuKx3rszf/HTm284hQ1G?=
 =?iso-8859-1?Q?Y/a4ORQA7/2KxIzfsyHbAegVfGTr6ON9FJi52K0ECqfUVjrI87gUheow7Q?=
 =?iso-8859-1?Q?VMT+fpCAc4+ySY3wt37P9UduRIXfxZTNmi2IEc2bAA+Fuy+DBoMcNuKPl9?=
 =?iso-8859-1?Q?Cay5SRmPESCjjMG0Z7JBU0tBstF63wyLGeT7CxTmVY0jnnX8FXEn8msTKN?=
 =?iso-8859-1?Q?bMtariNCWse+HRalGQl20X8HJJ8BrFWel8HBnv0JI4/3wyljph+cjqJevN?=
 =?iso-8859-1?Q?P9fk7DchLP2u1BA9rZrBFBB4H8k6jdoDm5dR/agR2b6hQO1oTCIkWibIP6?=
 =?iso-8859-1?Q?12gCAbAu8GthPSt4d+7zm8y8qBMOsqKoDue/YPAT4kREnhnPJ/L6F2k9Mg?=
 =?iso-8859-1?Q?YFjfPn2yYXqhrPz90jD+fT6vIFDIgEX1Q/czrdTXfx0genCfvjtL0yZK/o?=
 =?iso-8859-1?Q?4ebKXgwnk7VaY22NaWCvVIvxw1789YJdQiSNYN/R1Pk5oF+fvbvRTRyR1a?=
 =?iso-8859-1?Q?o+vyLVxIe6r3q5DW09b5PbjZRITQRtklIgnAEMydZ+ytJo7G0CqRiKvMUe?=
 =?iso-8859-1?Q?yFkqCIghBVgZ6ogpZFiYqrx1bhIzIw6Hc5z4zhGm/FpTG4YzhNI7AbEI+9?=
 =?iso-8859-1?Q?bkTzxW7XLAilf4iq+3c3qdbN37Ln8rIrkBmT8A9ItEVYXCFs09/RFv6zJU?=
 =?iso-8859-1?Q?L89Vt9Td5zBMu/ENIl+EWXFgmWt53b77Ai6nNdkCNObJRzHsmiv0NcnPT8?=
 =?iso-8859-1?Q?W66+R132TRrmMMY3lH5QUiWYOsfBzjAJkKEpiGBv45B2ABZl7JAQ5auwf9?=
 =?iso-8859-1?Q?CAijCuKqU7JadWY8g5MEtZcK6HDprtBVJ/F5qWhZKcmcmnyHqTINJESOi8?=
 =?iso-8859-1?Q?Uee2i8ScS2RdnPX476TVAJwltFMIGhjHVuJvN0No+2/QtNPjaKCVR9gQx5?=
 =?iso-8859-1?Q?ivHNBInY3rDsH9Sen50cuGynz6zf1fk2EqtSo5uyJkPFH+kMsFm6dbMuqf?=
 =?iso-8859-1?Q?Xq8+cvvQACK067fsWhXwXZQB8rmv6FOoCTtCpSqYke+t7wWV2lxoJGYe7V?=
 =?iso-8859-1?Q?++dzHWg4Ykqv7ffY3K9dg0le4iH3zHlt5EXm+6CCo+sW02KvjaalKkvHZT?=
 =?iso-8859-1?Q?J4FIrmGrx76fovFTjbADhbuAbhEkYLAVzL7iHnHEa5eQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XKjfW5KUU/nbjoye12nNXDzh+MnXMc+6FHXXhIO63FJ6QJxNLuM82isWRG?=
 =?iso-8859-1?Q?/xvbMF0gCUqaUQKEBi35Q6qj8k8hR5273s7Ect7JZvGNoV5eU9KqapWTuA?=
 =?iso-8859-1?Q?yv5B+3Lng2tNPFnNoKp1V0g65mrUCTp0wfVTkNTeh6/EGKr477BDHV6Gjm?=
 =?iso-8859-1?Q?XF56R3ReUp5No/B0OzlnYxUUAl+OZfXbwMJ1z6sfyzvECCQX5yQmUjv/lG?=
 =?iso-8859-1?Q?+Xb5mKUDXH6vLCYm1uQeSDEVd40LEQlwXtN7Iw75NkTeEZprlgzXll6Lyg?=
 =?iso-8859-1?Q?50k9675gxN/cpNLrC+v5C7culUDhRN91t+lFDJ2NcOZldlcWdcQMIlSlxm?=
 =?iso-8859-1?Q?ljzMhnusDjTuBH5VPeXkyHgidScPiNMI+EFWtVz1W5cGOO+a72Nvg4cCRy?=
 =?iso-8859-1?Q?Pk7qdiDiL6nUb+ajqUgGTkrKVhHTW8Pc5LPyxUIERXG5j22ZfEIu2RjXTE?=
 =?iso-8859-1?Q?XvrzbQsNaYQpePV6Pd/GJJBr9ztle1YPDxOhRynWcMRkOjEM0NIm7YUEfM?=
 =?iso-8859-1?Q?JWZ0Vl18ei8RMh+JkrzdCCRg+7B8IZ2vhHkzQiO5ZCVnvnp6P5fsx6QeVB?=
 =?iso-8859-1?Q?kDCatBhLyeYtPWJbfB70a+NYkRZwqYgbcFTX5t07eaN21JMx2kN/TAJAhY?=
 =?iso-8859-1?Q?aqZGTdLrEjSGEVx1SapDBgl61ADBwuE2BNhol/gAPcsyFiManLM9mEoxlC?=
 =?iso-8859-1?Q?4fu/0IGTS6uac3IQYqj+lebwJ41oggTbhd08XA58N3UhdJhZc6Ly0PakTQ?=
 =?iso-8859-1?Q?VHnQqefRyoEfWEXZJw+pOfEYABmdSMPMPGsCyesqIxKX9dpKIbPPfwmyd7?=
 =?iso-8859-1?Q?mgD0F7C76g1KcZKmvUC4eBvqU4wbnbA9ieioX5ww5DTRnXbuG2IGCE8Yrt?=
 =?iso-8859-1?Q?dZcImAq5jmPmjnVgifFstKcw6L6ZO7BSH8sRql4140CEZkYUDFGvWr46zp?=
 =?iso-8859-1?Q?Fu+ywRbVk0szeIFOxkEuY8E04XPOhVdOakuh/uppACeR+u0DMEziSPIInz?=
 =?iso-8859-1?Q?Mo42o7qGN/gEHyXxAYQe92+FqWKkGpM4Ya6qRLkJZqJIkujCujwRz20TUg?=
 =?iso-8859-1?Q?mlEKs2XEsLbqjJkRtppdiR89h1DOTBh03DlwL7o039+9HU3aEHLNHm/N3b?=
 =?iso-8859-1?Q?zJoKHazfACHPbuj6NkfEiSDE2pGd0dRxVlaBe5g/dpodpIUjaEu1xMSKBy?=
 =?iso-8859-1?Q?Vs5xlvJysVmEdtLEd4dTH5fXIerV7MeXmfG9OTF2tif0lufpnNTeIO88Zn?=
 =?iso-8859-1?Q?OT7zboNXg7c2dcXl36Mf20zdJZV0/OV4v22un0fTAvTuIVVG4m0ZXjTaFc?=
 =?iso-8859-1?Q?NR9MjtOeGITeKysNx35cxuthqkHVEN1tiXM9dq2tz1r+o1U/djHTXR/FSE?=
 =?iso-8859-1?Q?Lmk8voTtWeRIi2AjkO5hFWTNxbPev5WQ28olq0OaVuZ7AzHE8kRTbkQ5Cb?=
 =?iso-8859-1?Q?SeIUxw7nk2rqNgzvdKNSxDlzK47oe3NInhtuOEs2/wVGDefaB/1aQDG8nh?=
 =?iso-8859-1?Q?n3oPzEG+58AIpc4wdPqi0pDPLC5MlKF0kjgAXdo9qLfOF4Cd8doEL7u9Rw?=
 =?iso-8859-1?Q?79xT5hmAsFvMGMI0ThM6QyBMEIab0mPiSOfCEf4J3seQ1rBroWX1F5ClRg?=
 =?iso-8859-1?Q?nqMcrkrC9NQP9lD+KDc/ohDAmKx4BxYydwpmmdK/EJhg0tcAm4cMrl/Xe0?=
 =?iso-8859-1?Q?TyF5PU0SLKF7Ntd3g1M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a874440c-e7bc-4525-8a45-08ddc515bca7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 09:38:47.0929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iE6fJ5GPG0IoRmhvg/QVLcKl4c0u0BIHFiKz7/y82BJtNJorNXdmEC4DbZyBGqvJS9rySZHvzofm68Tn+Nt++RLO+luilW/y5efOYHSV/7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB4318
Received-SPF: pass client-ip=2a01:111:f403:c201::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR03CU001.outbound.protection.outlook.com
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

Add functional test for Boston AIA board. The P8700 RISC-V based
CPU by MIPS supports it at the moment.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 tests/functional/meson.build            |  1 +
 tests/functional/test_riscv64_boston.py | 78 +++++++++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100755 tests/functional/test_riscv64_boston.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 52b4706cfe..317e085bfb 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -259,6 +259,7 @@ tests_riscv32_system_thorough =3D [
 tests_riscv64_system_quick =3D [
   'migration',
   'riscv_opensbi',
+  'riscv64_boston',
 ]
=20
 tests_riscv64_system_thorough =3D [
diff --git a/tests/functional/test_riscv64_boston.py b/tests/functional/tes=
t_riscv64_boston.py
new file mode 100755
index 0000000000..eb5dd07b79
--- /dev/null
+++ b/tests/functional/test_riscv64_boston.py
@@ -0,0 +1,78 @@
+#!/usr/bin/env python3
+#
+# Boston board test for RISC-V P8700 processor by MIPS
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
+#
+
+from qemu_test import QemuSystemTest
+
+class RiscvBostonTest(QemuSystemTest):
+    """
+    Test the boston-aia board with P8700 processor
+    """
+
+    timeout =3D 10
+
+    def test_boston_memory_constraints(self):
+        """
+        Test that boston-aia board enforces memory size constraints
+        """
+        # Test invalid memory size
+        self.set_machine('boston-aia')
+        self.vm.add_args('-cpu', 'mips-p8700')
+        self.vm.add_args('-m', '512M')  # Invalid size
+        self.vm.add_args('-nographic')
+        self.vm.set_qmp_monitor(enabled=3DFalse)
+        self.vm.launch()
+        self.vm.wait()
+
+        # Should fail due to invalid memory size
+        self.assertEqual(self.vm.exitcode(), 1)
+        log =3D self.vm.get_log()
+        self.assertIn("Memory size must be 1GB, 2GB, 3GB, or 4GB", log)
+
+    def test_boston_requires_kernel(self):
+        """
+        Test that boston-aia board requires a kernel or bios
+        """
+        self.set_machine('boston-aia')
+        self.vm.add_args('-cpu', 'mips-p8700')
+        self.vm.add_args('-m', '1G')  # Valid size
+        self.vm.add_args('-nographic')
+        # No kernel or bios specified
+        self.vm.set_qmp_monitor(enabled=3DFalse)
+        self.vm.launch()
+        self.vm.wait()
+
+        # Should fail due to missing kernel/bios
+        self.assertEqual(self.vm.exitcode(), 1)
+        log =3D self.vm.get_log()
+        self.assertIn("Please provide either a -kernel or -bios argument",=
 log)
+
+    def test_boston_cpu_count(self):
+        """
+        Test various CPU counts for boston-aia board
+        """
+        cpu_counts =3D [1, 2, 4, 8]
+
+        for cpus in cpu_counts:
+            with self.subTest(cpus=3Dcpus):
+                self.set_machine('boston-aia')
+                self.vm.add_args('-cpu', 'mips-p8700')
+                self.vm.add_args('-smp', str(cpus))
+                self.vm.add_args('-m', '1G')
+                self.vm.add_args('-nographic')
+                self.vm.set_qmp_monitor(enabled=3DFalse)
+                self.vm.launch()
+                self.vm.wait()
+
+                # Board should fail due to missing kernel, not CPU count
+                self.assertEqual(self.vm.exitcode(), 1)
+                log =3D self.vm.get_log()
+                self.assertIn("Please provide either a -kernel or -bios ar=
gument", log)
+
+if __name__ =3D=3D '__main__':
+    QemuSystemTest.main()
--=20
2.34.1

