Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4340ECC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHETX-0002sL-F4; Thu, 15 Oct 2026 01:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESm-0001ub-6O; Thu, 15 Oct 2026 01:57:13 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESk-0003GK-6u; Thu, 15 Oct 2026 01:57:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoDcikVAOg3smCsjP9RFesZvyFFclIQwg2Dy3X6f+yAc5wNzcP/LKRhKk68vlZKDCZV7CEL057a/7L4AJdOYye78WE4RFNARVUSi/6MYFhz3DMatFi45eUjQ65NM9gc/5DtJAVgrilGqHlyRcl/FZ6StTzBBQFWu/aqkljySYwhYzuU11lYqNFo/vfeZlMEzCDQ+HxX8lwhr/SR1nRkOFUwG1SAL6n7CZWEANePY33nQltFrXpzptpvnWqompQdjV6jlatIFZWN8TyASxfm9ICwNU2sX3iGyp5Q3tluL/hMQzks3JrmSKgQ+00nac49PKwcjQnDQszQA0jFkcC4jqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khxCHza3Vqz8GVZhEDXjGhZ4XYIsWCh8/CEYpG0kakg=;
 b=v2IG/f5zxpc1jZK4agSfuHy242RMwyyJaRX3wSEHR4BC52pQDk/HjrlYjqgGkdhdhs/HHSS4VtVnVVOXg17+AJy4yFv77VH1hplsEnDEKjny8I3E9f8drcfHe2c70JoHE3A5nYVz25o1gbsZvZ6LTXIvzzSB/m+S7I7bAePh08WkpVyB33V/drjiP0K+y6+M+UI+TOY1HHFpIGeBkbqTg59JytXA764ro5iAM2QkBtZ3CH27Bjn/V2piC+CKwQImFgDCc8NW9Ca10BJrkcJTYR9rUz2nIcXGXhgAtW2luIE4/Krnk6MhouWJH4ljb6bYbc3zpY3qpOpwIRyzIlwwjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khxCHza3Vqz8GVZhEDXjGhZ4XYIsWCh8/CEYpG0kakg=;
 b=D1/48Bhsl4H9y7IuN/cQXXgYal7npe2OOE4MKyfc5o+czJ75LQwvOndT3sotLe/sDxhvO1NPe2m3ngKp/cvh92IV9Um2w6JkmcciAgtIxrBI3Sm28DMS71gOeyatP8u8JgKeBBOVxdMx1hlxs6rCZHzNYctG6ywYp/2yX8hC88h3PdC1Y4KL9+Cm1grDcc7YWFBdsbulPZQ5Dr2o9o6kpak8ccMEAA4dB/w5/GOxxDG4QIx12P75gOUcaNWj6GHKXY6VL3boStB45eJj3eghFk4JXCIlojzLnGRmHdIT0bPGgi63HszDig1jRoGQzqhrTNpISVBEId64mkj7hcFoRA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYSPR06MB6716.apcprd06.prod.outlook.com (2603:1096:400:470::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 05:57:05 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 05:57:04 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 14/14] tests/functional/arm/test_aspeed_ast1040: Update
 AST1040 image to aspeed-mcu-fw-hub v01.00
Thread-Topic: [PATCH v1 14/14] tests/functional/arm/test_aspeed_ast1040:
 Update AST1040 image to aspeed-mcu-fw-hub v01.00
Thread-Index: AQHdXGn98ZowHnW/c0uhRcEUfz/0/g==
Date: Thu, 15 Oct 2026 05:56:59 +0000
Message-ID: <20261015055642.106204-15-jamin_lin@aspeedtech.com>
References: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYSPR06MB6716:EE_
x-ms-office365-filtering-correlation-id: 344b4dbe-9540-4656-9aa8-08df2a812386
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|1800799024|376014|18002099003|22082099003|10067099003|261009223027099003|921020|38070700021|56012099006;
x-microsoft-antispam-message-info: 1pnrV83GYtP9g5ykw7fg7qZlBxrSfCKmDm3wSUV+oRH619LBLIo48LOt53yFoDMMjma13SsbEwtDWEMYULqlluxrsnTe0FERW4f/VoIWnsQg6Ee/GHZGuruc0+r0e/mh97OmhqePWNcO5gkuHaueZJs9l9kPQnf8R7fXivDSR7QWeeP3dwQal+z0CAkex4ZUeH1uzRmy72COVnRDxK7xZ/SuDrWU3gOU/BW7c1LY3oZUdFp6PV8bsVRoeRhShKI1/MBKrF1LbrHmT+ZEVeHh/FHc47FdyiI/QBt1GXXN9Tl5w7AzDIm47GEWLdf8hNLTEN9rxP2E1IvY7vLPeZ1eEtKoUnn8oN7Ghm9qiIG6o0VGmSnlDRyUsF24DnL9WO3Dm/6cm0zU4qQcaQX3BGy7slbjyqoZQUfmkgJvT9g/gDsiFE+vs0I0EiUrBeAClZgO1UlUVFw7ZtQWREbJWyKZF0UZcaqi69QyXxspLuJfWGy2i2gzJK1XshecCLszyUgh9nV1PbhWpP8GqPd+QkHwGQXm5+HXwkEfrc2SJ1UCshfcTVMdubB13ccMWRNUMI32QpHT7DYymWU4PKdquHUlEeJbOtpgcDP4DQVIIG/KwhpfA7PKn3TT6GIo/FLXQ3Rf4dw3CTMHWwF7YeK5Pn5pbumy5IUe0MJD5XM56ryP+qJaemoBTH+WqrIguubEgR2s9QJDSbX/riKZ9beCOPQIko9WMCtNmYxWPusddYplJXXyerMHWqllFDFhcHToynC8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(261009223027099003)(921020)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xON21xNT6mmEqlp6z7ZsorxalFZ+yzUwgM4Ovcff6RxNueDxGhTKdSw5ub?=
 =?iso-8859-1?Q?liYmX6C4/l6PvUbr7oblhXZ53/sUpitwaSctxPlzsxyhgrgPTKPeo6YoLn?=
 =?iso-8859-1?Q?sg4IIg4gPqL3QT9PFbZbsRn37mUprHmuZJPoSWu73bpuuitWQKMUnUs2Ab?=
 =?iso-8859-1?Q?CwDjbDzFha//AyNjZtaM6WUGPZqWXQeo5AJaFQoUGgVQV/c+RMi4HPfLqM?=
 =?iso-8859-1?Q?QwGZsOi2fPA07MvEn55WggbKtXuAjE/iYZs6SzWxPcCD9+yCoDymTCCD5m?=
 =?iso-8859-1?Q?3NhFJtVmFkhGK01cnIQTpThKcZZxRZQkNaev71+zkVmJ1S5W8hGU060r18?=
 =?iso-8859-1?Q?UFz/DU44gcsn+x1bhwZF11Gxi0J53VYRC38iYtLz02xAW7xyw2lamyHB9W?=
 =?iso-8859-1?Q?4DNsZuBGGNPuMyhvdfFgj2f8/bXnxA8Py/X3Noa9z4uWUoWYX2cov7Dupp?=
 =?iso-8859-1?Q?jQnOFo/XyL1JokGOvWu3aG+U+gk/j0lBAUJiZ0VX4t0XiqUoop57NJhnre?=
 =?iso-8859-1?Q?xC5fbNRs8xprcXmH592+Q29zEVVNY1IRvtMlQqoEX89pCP2WAcXkPeJ1bj?=
 =?iso-8859-1?Q?sVXB/YTmchdHYIrV+p0dj6V0OuGBZX0iLgw6ru2IXNf0JS0yqbmSMW/3V4?=
 =?iso-8859-1?Q?V6fjNAf+ch6EEEojKfU2r55iRnKrdFnp6+hGh64IHIPR3IkV2BBOfd5MJ5?=
 =?iso-8859-1?Q?bZA9V4ins0GJFz1zfjRBsE6gQr1nAE1d6KToqRxIA+vH7nfiVmuDH5bzlr?=
 =?iso-8859-1?Q?vDvQRoT+7pH6fBe7Nu1W8puaDiqHJ1Hd4iVmUhUzoRUHWVwXn1/hf9LWjN?=
 =?iso-8859-1?Q?SCu62IY8S7Q7qljV/N+XGUE+D+4mKOBo++/wxvKGtQDgGDfTCcpQAtjtzy?=
 =?iso-8859-1?Q?4+K4afedYCMuMLUXSNXQaeshW/3+ha1S0GL7cZXVFf4/WYqqMDlt+OWZCv?=
 =?iso-8859-1?Q?i8akLk1Put/fanfa4t2tpTMVRrCvsWPotCEUHDGromNoht6NIah9wKPMy6?=
 =?iso-8859-1?Q?gqwhG7qtXEJ1vapd34yezJEZSCHNDGJK2ELDmxrhq64ccHfuaW5UDNwSuc?=
 =?iso-8859-1?Q?0da+08vqOzm1m2mAgQHgFnGqEy2qUS+j6MX4ZtkE3LrK1f/IHpprGHHOVZ?=
 =?iso-8859-1?Q?c0oFVCjIDzvnKjqJLdsijmSi+OaaFPJlVTpXe9MvWMli729vYGVGX0Ci8U?=
 =?iso-8859-1?Q?cldBlFBInkUmWa6kc6DFQtRBLBiTJfW4bUFTg41CIcVbD2EH5BmynL5EEn?=
 =?iso-8859-1?Q?pfteu6l+cR0kgZgZm/t5c+1k/qhtCsJ3f5t1SA54JTAYOnJ8b8HHqvMKtO?=
 =?iso-8859-1?Q?3f5ZRQPF/M91oj+u7adF8QoxSSGAgbvpY1f4o+TMLRCR7efV+W46nLk7ds?=
 =?iso-8859-1?Q?YwRo+1WFvoimjHFajIdwfbNDLfnpnJtTtAHAaStGcx6+N/PyZ4hYocRx38?=
 =?iso-8859-1?Q?fHTb1quLjpOqYENA1yEsKzOo6XpJj4oQ9kR4FXEBgFRq/uSOuEKDW64+I9?=
 =?iso-8859-1?Q?T1mn1ofpupggAsGgrnKvK9Rjn+dbK/wu//MR4zFr/hEvEr6n0kHDIRlyMG?=
 =?iso-8859-1?Q?ZbuDjGeT83TKwWLXHj0k1GBMLK66y5a2IOwLZ9uPeh+L/wZ5TpA8ENNxuJ?=
 =?iso-8859-1?Q?9Urzz7Xxw37yCrolp42p2bzEdggjIZdRQF4/zUJ5rXhs7uomOssS04B5qk?=
 =?iso-8859-1?Q?YW2xWQYyQ+sKGtP7ASW+ZG5K1+W1r2fdH92ybzOC+fvTALxpx8Bdnwy+B5?=
 =?iso-8859-1?Q?YHYeAU/NQCbwCN2n5Ykc1yjRG/en8hjeSn1YdNQ0Xxck9Ue24p3HEJ9lXp?=
 =?iso-8859-1?Q?C26XcKQ7dw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AoNaj39cqiPbj6jdqZOvXupcs4Vc+VCSHO5r/PiL4PZ7P6z++ijaUZGApMoHyv3x5YgYq5pWUxuEQF+qhSE/qoL9vNes6cdpZ48Lwg5gyvLufWTqnHER1Bn4F/Kyl1vv8PQuhiExR9rScXrmQPub44bxYRvIY5JhVTilYCAqybV7GrBKHBhFPJEKwa19ddFkw1llKCtbXpxDqF1+d7TL9QvUtUKV9QIa5w73h7pGc4XOc90ooqrEUxyhDSWqroF48zhCnKFdC3hcsPBQBzJ4OaLQAGaztKu7vT81vhgUy3+y5CMuiOKv3sC4fbQdlqKLhfen3cEadGHl9J6emUlbkw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344b4dbe-9540-4656-9aa8-08df2a812386
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 05:56:59.1698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YurDGGGOq/5txPAk0ixqvX17EDDg7YHB6BYw6EaFNKw9qf36gfxZKe03ll3E6QiD5kxnegOHESvc+3dnyOSUpq5rSph6DQLsGyPCZJFbUrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6716
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Previously, ASPEED hosted the AST1040 pre-built image in the Zephyr GitHub =
repository=0A=
as a temporary solution for QEMU functional tests.=0A=
=0A=
ASPEED now provides official AST1040/AST1080 pre-built images in the aspeed=
-mcu-fw-hub=0A=
repository, starting with release v01.00.=0A=
=0A=
Update the AST1040 functional test to use the official pre-built image from=
=0A=
aspeed-mcu-fw-hub instead of the Zephyr repository.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/arm/test_aspeed_ast1040.py | 12 +++++++-----=0A=
 1 file changed, 7 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast1040.py b/tests/functional=
/arm/test_aspeed_ast1040.py=0A=
index e4d8ecb37a..bdfd815673 100644=0A=
--- a/tests/functional/arm/test_aspeed_ast1040.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast1040.py=0A=
@@ -12,17 +12,19 @@=0A=
 =0A=
 class AST1040Machine(AspeedTest):=0A=
 =0A=
-    ASSET_ZEPHYR_3_07 =3D Asset(=0A=
+    ASSET_ASPEED_AST1040_EVB_01_00 =3D Asset(=0A=
         ('https://github.com/AspeedTech-BMC'=0A=
-         '/zephyr/releases/download/v00.03.07/ast1040-evb-demo.zip'),=0A=
-         'b5189797c22c2d732ddc27670c1efdeba821a2747c9c7434f190791125baa121=
')=0A=
+         '/aspeed-mcu-fw-hub/releases/download/v01.00'=0A=
+         '/ast1040a0-evb-v01.00.tar.gz'),=0A=
+         '62dff10cef99a72a9ec679b7ed2c80ba1b76dcdab6bb66251e99a83a31612a02=
')=0A=
 =0A=
     def test_arm_ast1040_zephyros(self):=0A=
         self.set_machine('ast1040-evb')=0A=
 =0A=
-        kernel_name =3D "zephyr.bin"=0A=
+        kernel_name =3D ('ast1040a0-evb-v01.00/ast1040/ast1040a0/evb/'=0A=
+                       'zephyr-shell-module.bin')=0A=
         kernel_file =3D self.archive_extract(=0A=
-            self.ASSET_ZEPHYR_3_07, member=3Dkernel_name)=0A=
+            self.ASSET_ASPEED_AST1040_EVB_01_00, member=3Dkernel_name)=0A=
 =0A=
         self.vm.set_console()=0A=
         self.vm.add_args('-kernel', kernel_file, '-nographic')=0A=
-- =0A=
2.53.0=0A=

