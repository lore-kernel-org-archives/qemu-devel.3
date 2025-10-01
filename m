Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5C2CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 09:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3tTi-0004tb-No; Wed, 01 Oct 2025 05:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tTX-0004im-0h; Wed, 01 Oct 2025 05:50:19 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tTP-0004vh-JW; Wed, 01 Oct 2025 05:50:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVGReDcwkFQg5D7x/xTrP7ndmphMJxqVlYq2xjNiR4Lh2Ro9P6FfUy9TI8TQQ441LxwuCfQMITdfxX5iyX7OmquwpD3FPXBhbNbq2jy7q2vE/aWDGnQNJBFdurCUbDjTlrEbJ/9VW5OL7YLAsWK78sQI6qoGWuIoZsitvze43ERZ4zArhfSK/ytRbIwoQO2szvyqMKhBzdkTQyY3F5YBXtkoL1rLJDtTXrG4rWTE3HUth6xl6Nu4+Vebusm0e1kr+R3HByaZqZbfqejkEp1jJA96iy95WXfjqfRaj5hHIMegrriM/4/9EXEDgCeH/1pqsxeHwN5dxvP0MnJ1CXNziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dneX68j8FuzKTnqV5D0s0N6GQnjVcgt7XwOeOFJaEg8=;
 b=WtqzYlpnR9C02FjRvZY0eHz3gjY81+FcwoBcUa3yiE9ypnRmY42rErohqLupSOMs461BdKQlUomtICLyXI1CAKilIskaea+zXyYDtXlSAki62OqOd2jvkomZyrydBN/8tjrbML2Fnr6cVJD2t5R4cwzZcHZGumzkULE5sRi+3wmhYtUv3uNtun/n81OOsRQ8kUz7KbigAB6KDxjpjYuNEH74exbbxO8yPD32F5/jl9tDK4eHbSOJpRFlMTJHH3tlp070m1bagoizPRWzjLEd7Mb9Y5YtJEWzJ/nPMFoK6Uh/BGs4ehRNBaxdVfzGDdItZ+DtASRcRTxKNxt3WudEEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dneX68j8FuzKTnqV5D0s0N6GQnjVcgt7XwOeOFJaEg8=;
 b=JnRRqgvZ1A/7AyKkpisrFEkhqpj7h5cvTtxVp1QW2TtPznOg4oW/hXeYMczWLelOyyS2DrALbnZ0vgWal4yISo8MYkNusLQlQ37GuQzXmIctoFUkUE2w/462GF6j8DABqtS466a5/9nEiQ8RNduCsZZXTTKm7KkARCvxLyX8bluopI6cE8ViP+w94fm4odkWDlthCrpF351SLAZneds43sjeVfM9q9TTfReyaMu2XKRvGUP1MHHD1LVXvFHZYxHmdDddFM8p8D0ivxjjse1hQBEa9HNo/71V/5cfBgiWAivKtR58jyMNJyKxRVcZHKmNQK2GePb5wlLOwezjrzRLJA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA1PR09MB7820.eurprd09.prod.outlook.com (2603:10a6:102:44a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 09:49:14 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 09:49:14 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>, Djordje
 Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v9 13/13] test/functional: Add test for boston-aia board
Thread-Topic: [PATCH v9 13/13] test/functional: Add test for boston-aia board
Thread-Index: AQHcMrilrjzfmWxvz0GdvBcziDSKbA==
Date: Wed, 1 Oct 2025 09:49:14 +0000
Message-ID: <20251001094859.2030290-14-djordje.todorovic@htecgroup.com>
References: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA1PR09MB7820:EE_
x-ms-office365-filtering-correlation-id: 34647082-fb9e-43f3-d676-08de00cfc7db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?JFQ5DZRdyJ49tqzeL1hOYzpkD+K3vsNkK07ROoPBTVc9LUNkiOeRYB7ZKS?=
 =?iso-8859-1?Q?eidtK0zGKNhUYGAcgm9v9xSxFjCVGco9k1eVDQjxZgkIPWzatQzsf3sqTS?=
 =?iso-8859-1?Q?Y/yjPS6Ly0VG9Ss9zhvvW+ZKtneX+PKYLNFdQlOrGFp6Cbo6TVtoSLx7EV?=
 =?iso-8859-1?Q?jklWKe6wLmAX6DTVxGhDaJrTqSrlA64ibrWKMi+lxXd2NmHNLpGcXWJ2KM?=
 =?iso-8859-1?Q?XT8IZmAZ7OJDTC6Hrr/wlqlBRz9coT5D3/F1WPDXwQXG0sjwfh6tVxavhp?=
 =?iso-8859-1?Q?cv8NWrdGadLmHteqJ92IZftqNALRwNv+WOWG0LmJvz2uzzsHj8hz0REH6d?=
 =?iso-8859-1?Q?UHrmadlH1fXeAynMxNepeN89PanD2y1C9vgcs78LYjZyZZeeQPRbfo1NJC?=
 =?iso-8859-1?Q?yMAZZAY9N4tML5jLF3fiE3dhuYWAv3W9LWFnqmgglX6/7yG8YJaTMJPE6X?=
 =?iso-8859-1?Q?xLRQ0Hoi/8XWO186Xb7E4BKVMKAAMhKJrEJfOV4GXSawD7mIRuzBw7p+7K?=
 =?iso-8859-1?Q?+A+6jmgJNyXgMKNKHVJgfiyyiOfRA1H9pIaFqpAuPFtTXMuXyDY+lrhz57?=
 =?iso-8859-1?Q?G3TGcuRq8bpmIpsCPIkK5SsoAXmD5s1v8yo/6oxXQWZyzAeTByyD4Fm6Tz?=
 =?iso-8859-1?Q?DEX3ZmzY8o3wFL6QPHTzc/zr+Klake4y/CyrlV2Yyb0w+JP1lrxiF5+9ax?=
 =?iso-8859-1?Q?Ul3iWvAZGjSAx1EvfJjZVQe+bum/CPf3r7cqOrScrKpmrknVUzmW5b4Us0?=
 =?iso-8859-1?Q?7O4at6qTlXBXc4u5D3wh/dQH32TCME+8Way7yyMpPib2WF3EKli4zriJ4k?=
 =?iso-8859-1?Q?E9YH2hJ/ooD7ZOdOVY7yrwZBB1eC2jgpFKhTIkx5ao1BTphUR7M1QP6hcN?=
 =?iso-8859-1?Q?qNMlEHcDn355j4UxRCFBl1JEMgbylZeUhxkzU3+Goa1kYz3OY156PkvBtH?=
 =?iso-8859-1?Q?Kuc3jB2XFu1Cv0iQ6BhjExrV6ad7CDxG36OCfmBsiA5ucHGf1Vv1R3RxKy?=
 =?iso-8859-1?Q?SZ8BDSvar2VAtFuIQBY8mPfX5hWYS74iEInQ2+ZFCu/UV72BezhKZrWhJ6?=
 =?iso-8859-1?Q?wqZfYMAtLDbpWhQzNHiRhJT8Z+VuDZosJqBqrLDTlMmJ5KhxJlfCiUsurL?=
 =?iso-8859-1?Q?qn+/XOjvPLL4EgIGd8qQ41Kk4HYv2EsuvPwrD3r++6DDf66ND5sfWC8VKm?=
 =?iso-8859-1?Q?VIxf9TuKtnm9+SJTPHPhHfayZVHqikyv1vc1m2pTSsyN5nevDfZipIq8ps?=
 =?iso-8859-1?Q?iazxb0aX/6DaA/Nd4QYdjPdY3eFbxnBbSfCBw2dCXkGpKaugL4ZHcMlJql?=
 =?iso-8859-1?Q?t1034h29qItmKTnWDnWunn0sHuowsNEgxKRma3Wt5uCa3r0xIAhoCFVXkX?=
 =?iso-8859-1?Q?40ljPAFfWpvuhSoPVyRuzMVaXhCpQQBysscSH2vX3noY7QrR0aZbZJuD1u?=
 =?iso-8859-1?Q?wDkq53XP1A0YPjC5928LX6fz1vJqmI0T7K5Yxz+Kb775VHlYwIWl6nr3kc?=
 =?iso-8859-1?Q?p2of/vuv+CDeOESGtCtPx7TvkI7I0C4TF7okSt/GDOhVKFTU51qsD+tP85?=
 =?iso-8859-1?Q?IhB7QLph+NH5gKotNcnSihIPtQ1H?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1V5jShILyfgrl8OxWkMF/5AU2GGtBuCUQqvHCf5hzZ0cVGjQrbBkV8pbY8?=
 =?iso-8859-1?Q?jLIMAJM3Q0/Bxm6SHBOqZdF2MNNDv4PSh+MfRFrmQw+rumQvxTZ1vTjCeH?=
 =?iso-8859-1?Q?OGTTrwKMTUXVJNXRRiVF9jkW6jbHQ13PzSQARqBQA3/azrabIBCNyZulG8?=
 =?iso-8859-1?Q?lkTn+Lp1BVFeAWVSTu+Eb3QPoJfgJoEUdT6UWZfgSie9VgCQ+0v7UGti7e?=
 =?iso-8859-1?Q?OKOgtBhpYiOqfHV4cMMbbddgQ+6AQjWpU2nkvzojsQe++1Ap12p4gwDryl?=
 =?iso-8859-1?Q?I+fbUR1Z7Vn3JX0ysOOSd7V4vjeYoCiR3ahqZi6RdZIbQwOaujPhoXsqUS?=
 =?iso-8859-1?Q?mQTQXrtq2YZpc9Jh1EyquA5sPzXzv1FFrgNy10UFHudaiPOa646qlOLZOa?=
 =?iso-8859-1?Q?oFyxviokYcq43xw5rvg3oLJ0ON05U1qXB8wEBPXxfkq4tbU+dNT6fYBn0V?=
 =?iso-8859-1?Q?/5tDE+3GQWbXeA+gIFEoCRk8rfoc7tqjWTsIFQHNyQ9EVtaOkjhYWJyG8Y?=
 =?iso-8859-1?Q?KrUX7ZJT+nnYYhnKy1yJQoWr6BBlZGGO+6Kyl2mIIbgrqs3YJQQC5PONIy?=
 =?iso-8859-1?Q?1+QJKFj6up6m3b+CfIHWcBNItw3GR8dpYie/o7kCbG0hTwENLpkpTOPHvt?=
 =?iso-8859-1?Q?8MqkMcryTpKJ7Sn0haLMysnLoqRr+8bTfkLO5auFc/ajwj4S8+kMWE4E1B?=
 =?iso-8859-1?Q?OpxZbQHptyFNP6xNLc3AMCb/D3BAhR/IfRi6v5uz/3s3YgYqDeAhU/zxma?=
 =?iso-8859-1?Q?71Ji0zY3fIib3Tjq5gyEOj8HCgJDtpA7kHGFq0z5WzlJcHUHVMHoQouD33?=
 =?iso-8859-1?Q?vls7xJoMAKIkf3De4yBsr3jRLpFowNWINPajiT9hrKcF2yNH159WJNz8Gz?=
 =?iso-8859-1?Q?hURfHEGh5EST4bcgiODDoj7+X3UYp5i8bv8k1fHHzABEPx3nFrEEGnM+jn?=
 =?iso-8859-1?Q?NCErvb458j8c5Ui3ndugQ4mUCgRsrCIFD3IU050GH5f2ZlDwVsVRcELP9h?=
 =?iso-8859-1?Q?0qd7LolbMV6Zpa8TMGAcsh/t77KbkTFv6D9/9QR23ZA/tZjARnFyjQ475A?=
 =?iso-8859-1?Q?rIVty72W3Jw5AJenRwlVyuqe+PkP2nksP6zmTFMP/6PAvUVAQfahzyYJ78?=
 =?iso-8859-1?Q?bj5gopJBwAAoMVoSWSlnV0osYm0ansqShBWPdlB3FErg728Xmkl1cB3I7z?=
 =?iso-8859-1?Q?IeH7diyf3hJPwLwA1WvYg7mXkcFevuZ//gUEu8FK5xyelMUQ12pnUmsX7Q?=
 =?iso-8859-1?Q?5Twd80lrdDo3sg9B6v6Z0FqeuQajM+12L05wnNbyab7kGGzKbLAfTnQ+3N?=
 =?iso-8859-1?Q?hi9mZZnkGFYdUR1gLkoZ4Crb4TXUM92hMc5hVqAaUlNdTjMk38In6yA4WX?=
 =?iso-8859-1?Q?SChHEkEeSjq1tDKrKU17Jg38KEOYMR3MRY0gFcCE9fueRtdSFOafQhcLDy?=
 =?iso-8859-1?Q?5ZgRr/sLzisuG2aKa6mzCt4cXBDsjM4ktQrvpRykzqhl7vYmAb7Os9pmNq?=
 =?iso-8859-1?Q?ODRQt7/soyB5slyjceYQsSJPwGTe6uh3E7szgmb9kEeDUz0GrVBsiiRkCH?=
 =?iso-8859-1?Q?4ZfZ6lN79Vx0ISRcCCNOW2GoGWxmlY9ESskY7u7LzkUQGBbvwPWpsUXSVp?=
 =?iso-8859-1?Q?uJUHHeOJ2K2Dv5Jbvp6o3D2Ww6FGBWpuQ3qjJ/V15PI6fcgzAlW437nnEm?=
 =?iso-8859-1?Q?EC0ODFSSUGl7PAhKxdc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34647082-fb9e-43f3-d676-08de00cfc7db
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 09:49:14.2532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fCtNhUlGoXNvbjOq/tJDU+Y4Agmaik+Tr/nC6rxHncQQDlqkQVEOj2J/93kh8RI7PJzRJNuwxD2u5rEOErDkNHRX//xI98e7wseIGWkGcRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR09MB7820
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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
 tests/functional/riscv64/meson.build          |   1 +
 .../functional/riscv64/test_riscv64_boston.py | 164 ++++++++++++++++++
 2 files changed, 165 insertions(+)
 create mode 100755 tests/functional/riscv64/test_riscv64_boston.py

diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv6=
4/meson.build
index c1704d9275..9bce341b80 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -7,6 +7,7 @@ test_riscv64_timeouts =3D {
 tests_riscv64_system_quick =3D [
   'migration',
   'opensbi',
+  'riscv64_boston',
 ]
=20
 tests_riscv64_system_thorough =3D [
diff --git a/tests/functional/riscv64/test_riscv64_boston.py b/tests/functi=
onal/riscv64/test_riscv64_boston.py
new file mode 100755
index 0000000000..0527571847
--- /dev/null
+++ b/tests/functional/riscv64/test_riscv64_boston.py
@@ -0,0 +1,164 @@
+#!/usr/bin/env python3
+#
+# Boston board test for RISC-V P8700 processor by MIPS
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+
+import os
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+
+class RiscvBostonTest(QemuSystemTest):
+    """
+    Test the boston-aia board with P8700 processor
+    """
+
+    timeout =3D 120  # Timeout for boot tests
+
+    ASSET_FW_PAYLOAD =3D Asset(
+        'https://github.com/MIPS/linux-test-downloads/raw/main/p8700/fw_pa=
yload.bin',
+        'd6f4ae14d0c178c1d0bb38ddf64557536ca8602a588b220729a8aa17caa383aa'=
)
+
+    ASSET_ROOTFS =3D Asset(
+        'https://github.com/MIPS/linux-test-downloads/raw/main/p8700/rootf=
s.ext2',
+        'f937e21b588f0d1d17d10a063053979686897bbbbc5e9617a5582f7c1f48e565'=
)
+
+    def _fetch_rootfs(self):
+        """Fetch rootfs and fix permissions"""
+        rootfs_path =3D self.ASSET_ROOTFS.fetch()
+        # Ensure the rootfs file is readable
+        try:
+            os.chmod(rootfs_path, 0o644)
+        except:
+            pass  # If we can't change permissions, try anyway
+        return rootfs_path
+
+    def test_boston_boot_linux(self):
+        """
+        Test full Linux kernel boot with rootfs on Boston board
+        """
+        self.set_machine('boston-aia')
+        fw_payload_path =3D self.ASSET_FW_PAYLOAD.fetch()
+        rootfs_path =3D self._fetch_rootfs()
+
+        self.vm.add_args('-cpu', 'mips-p8700')
+        self.vm.add_args('-m', '2G')
+        self.vm.add_args('-smp', '2')
+        self.vm.add_args('-kernel', fw_payload_path)
+        self.vm.add_args('-drive', f'file=3D{rootfs_path},format=3Draw')
+
+        self.vm.set_console()
+        self.vm.launch()
+
+        # Wait for OpenSBI
+        wait_for_console_pattern(self, 'OpenSBI')
+
+        # Wait for Linux kernel boot
+        wait_for_console_pattern(self, 'Linux version')
+        wait_for_console_pattern(self, 'Machine model: MIPS P8700')
+
+        # Test e1000e network card functionality
+        wait_for_console_pattern(self, 'e1000e')
+        wait_for_console_pattern(self, 'Network Connection')
+
+        # Wait for boot to complete - system reaches login prompt
+        wait_for_console_pattern(self, 'Run /sbin/init as init process')
+
+    def test_boston_7_vps_boot_linux(self):
+        """
+        Test full Linux kernel boot with rootfs on Boston board
+        """
+        self.set_machine('boston-aia')
+        fw_payload_path =3D self.ASSET_FW_PAYLOAD.fetch()
+        rootfs_path =3D self._fetch_rootfs()
+
+        self.vm.add_args('-cpu', 'mips-p8700')
+        self.vm.add_args('-m', '2G')
+        self.vm.add_args('-smp', '7')
+        self.vm.add_args('-kernel', fw_payload_path)
+        self.vm.add_args('-drive', f'file=3D{rootfs_path},format=3Draw')
+
+        self.vm.set_console()
+        self.vm.launch()
+
+        # Wait for OpenSBI
+        wait_for_console_pattern(self, 'OpenSBI')
+
+        # Wait for Linux kernel boot
+        wait_for_console_pattern(self, 'Linux version')
+        wait_for_console_pattern(self, 'Machine model: MIPS P8700')
+
+        # Test e1000e network card functionality
+        wait_for_console_pattern(self, 'e1000e')
+        wait_for_console_pattern(self, 'Network Connection')
+
+        # Wait for boot to complete - system reaches login prompt
+        wait_for_console_pattern(self, 'Run /sbin/init as init process')
+
+    def test_boston_35_vps_boot_linux(self):
+        """
+        Test full Linux kernel boot with rootfs on Boston board
+        """
+        self.set_machine('boston-aia')
+        fw_payload_path =3D self.ASSET_FW_PAYLOAD.fetch()
+        rootfs_path =3D self._fetch_rootfs()
+
+        self.vm.add_args('-cpu', 'mips-p8700')
+        self.vm.add_args('-m', '2G')
+        self.vm.add_args('-smp', '35')
+        self.vm.add_args('-kernel', fw_payload_path)
+        self.vm.add_args('-drive', f'file=3D{rootfs_path},format=3Draw')
+
+        self.vm.set_console()
+        self.vm.launch()
+
+        # Wait for OpenSBI
+        wait_for_console_pattern(self, 'OpenSBI')
+
+        # Wait for Linux kernel boot
+        wait_for_console_pattern(self, 'Linux version')
+        wait_for_console_pattern(self, 'Machine model: MIPS P8700')
+
+        # Test e1000e network card functionality
+        wait_for_console_pattern(self, 'e1000e')
+        wait_for_console_pattern(self, 'Network Connection')
+
+        # Wait for boot to complete - system reaches login prompt
+        wait_for_console_pattern(self, 'Run /sbin/init as init process')
+
+    def test_boston_65_vps_boot_linux(self):
+        """
+        Test that 65 CPUs is rejected as invalid (negative test case)
+        """
+        from subprocess import run, PIPE
+
+        fw_payload_path =3D self.ASSET_FW_PAYLOAD.fetch()
+        rootfs_path =3D self._fetch_rootfs()
+
+        cmd =3D [
+            self.qemu_bin,
+            '-M', 'boston-aia',
+            '-cpu', 'mips-p8700',
+            '-m', '2G',
+            '-smp', '65',
+            '-kernel', fw_payload_path,
+            '-drive', f'file=3D{rootfs_path},format=3Draw',
+            '-nographic'
+        ]
+
+        # Run QEMU and expect it to fail immediately.
+        result =3D run(cmd, capture_output=3DTrue, text=3DTrue, timeout=3D=
5)
+
+        # Check that QEMU exited with error code 1
+        self.assertEqual(result.returncode, 1,
+                         "QEMU should exit with code 1 for invalid SMP cou=
nt")
+
+        # Check error message
+        self.assertIn('Invalid SMP CPUs 65', result.stderr,
+                      "Error message should indicate invalid SMP CPU count=
")
+
+if __name__ =3D=3D '__main__':
+    QemuSystemTest.main()
--=20
2.34.1

