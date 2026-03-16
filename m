Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCB5F013CA
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 08:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w237W-0001cI-Ag; Mon, 16 Mar 2026 04:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w237L-0001Yf-Bv; Mon, 16 Mar 2026 04:16:03 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w237H-00052Z-ST; Mon, 16 Mar 2026 04:16:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wx206hfLLmOj01QadraLxqULFxK65T/s3p4Sv3Izg5S6mFdXEnz8MznhIZZgy3Dk9g+xO0gxOzLjHC4Cmpjk0/rFI9USsvN+l97OtdEE2NDTtjGbk554Ahl8GhNjyldJzo9M/NL1N9lVnnY3jxFuZKJulX0HXUbd7G9UhQJvkCUClUxN23aqKDwzGtp8O8TgBMSD9Bo15vxaLrdse9mh4M3VSKhNnpxNwqJ40bm2pE7C2XgWAb8P39w8mxNRswzbtg+cyoAgd3t982w5Gvje0cTHhsmIPNNvegDIfDWtafrMXST6Vok2wtAgzT7QzInk5Hj5KsFtht1sT1FOwUJqwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDwZe/fWYoa63Rioq7P1krcDhKcmyY/Niphiz8yV3ms=;
 b=JPB60WDbVmGlZ8Fi729EuF5SN221TpyUjhIPccA/CuoOaP4R16kofBj61dR63+oE1z9CFFw9utTF8EWAhavAXGoDiLIMNOVmxoJBYJHpAwyJd1wV6IUhtt24of0Sjz+LnxPzZ1ZoPeMR8qoH+nfdMa1zTR2NWwzTQbgngzI7wlcvBnMocAjOHlIZycfrdHygqPrQsDKxCDr6EVYQF6PvwKRMmdqgHX0RUbqCrUGYBkg9hl6oK+LvUMHbVRSTACTHivF75tua1wczJvAtdctMrS+QValxgHc3dHvvi2QqkXNC1yw5kWfskeWm3g6uNRlJ7+gA2jc+AdIDYkhzAUoIRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDwZe/fWYoa63Rioq7P1krcDhKcmyY/Niphiz8yV3ms=;
 b=iBYnq0av0JXJL0+HM/HUINYWNgVAT9bHxNdDL+Bc5bGrhgSFPl+lNsxR7EMzQYUKYID0hNpU1Gzm9vlmoCurk5kLgxSeR7uYSC2MndGTnU2E+I3Y9tAJRTidNtoHM9c10K98EGDdUNsflzGGP4P5+KmclUBxG54OZ5ItKQcJWeZ43dtSXO8a0esE/1N//z1DmdW6srZmOYp0BjXUPbEET+EohqhhrA1SOB3VpVhZLZM5vwO8Oes/cemSjAbHObpTA+ehPbxdppsfURRBJ5c5W5twqpQmsYoBATval4XkdkOnFt6hzgU+DTtkQFO2oNtdBe4i26MjCwkQR7LAqvCSVA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY0PR06MB5306.apcprd06.prod.outlook.com (2603:1096:400:211::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.21; Mon, 16 Mar
 2026 08:15:51 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 08:15:50 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1] tests/functional/aarch64/test_aspeed: Disable kernel
 crypto self-tests in AST2700 boot tests
Thread-Topic: [PATCH v1] tests/functional/aarch64/test_aspeed: Disable kernel
 crypto self-tests in AST2700 boot tests
Thread-Index: AQHctR0Zd+cC98arEUOD0Fkwm7Ox5w==
Date: Mon, 16 Mar 2026 08:15:50 +0000
Message-ID: <20260316081549.1279841-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY0PR06MB5306:EE_
x-ms-office365-filtering-correlation-id: 8482eb55-40e4-4a54-fefe-08de83343c66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|18002099003|56012099003; 
x-microsoft-antispam-message-info: uMUxcDlBfbS0792DClwW9UNzPcLCDg6W5KHY9mFN6LupsDWM+187ZPvnmCPdpX72XL/H8CPc/2EDMQZEG1fLMtmdlqiJsMziu8X4mRqme8GYZSR+JCuK3puLa8tfglbpDItbKxH6zz2XTo0YHNEX//7L5BB5lFW7rsPKIyoctZY+kok60yFGCDANgqkqwzlediRSDSA8b6JtzFB1HgqKwqmX4YD9LM17QnFNcZfmkycuZfQcdV4+K9f7CUk2Qgbtq1+B257yRTr3fYJ4jNjC4rDWfj8obHjj0jqQcdI9UkP/tC2B9dyyD8TJR9mEB2An+HRr+vhAtZ0T0HOP/HjSjahvPYCm0fRABNYnqJZx2GEqgUerdA5baQWjGvNo8E3JBkCBD3WoFCJGG5Vb7K3x6L6/+Lj3eTKiqNBOpdE5BRvvIAFD/E28Ci9WiQ5+Yqm7nxtWF7VA+d8fmBAcCdAgxzGUIYyoXZ/ZWcIV+/uwHC/QOetr/pQQMTMiT/fIex352uXAAtP8M15gm4u7CBGxtPd6LFWWc3fWcqYW8NKEZXH0/7oSR+QEiyxJomqECsYWMhrVb+ylD7yv9klBaZsE9XsdzY3PLB/3L/1G4qpfq4CWXAm8A68Zw6pmuajyHS/1bn/ua2ZmFME/B9tqh2Gg1hPaZc2eV9Mauj6ApeH24QtHSIQtKaCButcJc2yvRezJBtOAjmCK6gTExIwJ4HZyW1wauWdcgE/VtTw1hkQD9QpFugRg8jIXfOzsoFOeDGDMJZq/KEXZCjrx1EE1VybWk2UU902UxXzFxDBx5PtK1cs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YeeBJnqFQtlfrK9p2HUiE8vHFirNYI6FXO+MG2wdLkbU/B0KMwkRDXbtM+?=
 =?iso-8859-1?Q?mnsyZljNvAHSJZULMyKu7RQ/igV+Uf8cm52IM38nqBvF7QG+vYI/r0+m9R?=
 =?iso-8859-1?Q?BM+YFQXjzpWCQreSsIrS/mEUjSRMSxmQSM2Aw2lRspShnIEApBMrGxSc1Z?=
 =?iso-8859-1?Q?mvm8mvDzLL/pG8SpTknm/LC+D7Ur2b4j26L3iMgI+x5OjQ2ModiDlY5W5x?=
 =?iso-8859-1?Q?+kxlYtFUNZl+an+fp6HriBVsAZto5OB4YnT46SmmUlXsvDn5WlwKdk3y7V?=
 =?iso-8859-1?Q?eg7EUSB7mCbukcfuNzvHhhmqA8yx9jC1G9xnpq3gJSmLiBN+rFdopJKK7K?=
 =?iso-8859-1?Q?Srgc13x5qfK96P/xM7ElUl56xjIr90LvHvgDpBerKG7tXRwPg/0hs97UXO?=
 =?iso-8859-1?Q?KlVNdBabwa0YM3nrWg8hkoFBJx7OcYOQxbKkWWKInbbdUWhvfzaLV1tsBa?=
 =?iso-8859-1?Q?nzqKL5+byUWso7LEXBhnViIycWmDe9t783EzzDcO9Bq2rfaS8oqkQlMWG2?=
 =?iso-8859-1?Q?RtWtMgKwwfhl1LeMbVDSbE+i3WsEjHve/4GvawVhzP7yHjXee+RpqDsFR7?=
 =?iso-8859-1?Q?BEPa9KRK4HlJhQG6ykj/R5NLdNn88xOSNyg2AxxjoAYu3wF2H63qELbCWL?=
 =?iso-8859-1?Q?EFTsjmM47it/R/x+pFQBtAdWmIXpwuMznmvTO/DrTzLVvBBCwrh7RDCALC?=
 =?iso-8859-1?Q?HPHzR625zieumdCrGSkLXUw3PY3Hk4lQ5qhqoWFp6sFXX5uSoNu7Y4AnnO?=
 =?iso-8859-1?Q?1FXJMV/8OGo/VXSwF6PJeKibjPCoPMO7j6yg/oI49P6w+BD3sRfF6anFqe?=
 =?iso-8859-1?Q?4UMio8ohzERpEGvQmjMI//c9ZYZHd/+OkiDOfJ7jHFDUhIzigdRcI6dLuE?=
 =?iso-8859-1?Q?K37qWDRGfcjrqGEm0IBop8WEHbYYb7c6EoK5wY19BsAFWh980xxkK4pqaL?=
 =?iso-8859-1?Q?SeATEO49ipsNUDAY3sk8RaGgZkz1wmKX9nZTxhXvYV3DUNGbNNpOUzmHsi?=
 =?iso-8859-1?Q?RjXu6UeA03rnvRUHTEof0QWJk1STN20F5jILMYPYA4Q9XgC9YLYPulIxSd?=
 =?iso-8859-1?Q?DBDgWHpmznxUi0wywxBRQWLw4v8SfzUFTYYC4LrhWSQm2im6Pyluxsy8lC?=
 =?iso-8859-1?Q?FHN5MCY3ByngOwreaHzN1xBUaen24+xB6Uw0BGD0eiJrHsLtFH8ZLHd4uf?=
 =?iso-8859-1?Q?IyuOxmnsrhWHePwswsoPkR1phmEAkrxmN2azV6TrXd8E4nIF3oFiAbUpCs?=
 =?iso-8859-1?Q?XuJ1xKAvvcNtOp8NMDuDEj6+jfI0HMshmFVlvx7dBKPV94Tx9B7tY4kozt?=
 =?iso-8859-1?Q?WCkiS9ex3kUo/5YYgb19AvfKIpW1QR5vK6LkEh1BQ64jvbZu4YVsp4ApgA?=
 =?iso-8859-1?Q?8PdJ3BdQebscT+iK09/D2mzXeYavIEUSYtyCViArapMFEcPSJAOcF5XRND?=
 =?iso-8859-1?Q?FYGc1Zq6C99wI8cSW1OijHXEVWq/WYNKE1m+fJWKya1JeLPrkGdOMXCaZv?=
 =?iso-8859-1?Q?VAPbgxc2r8kAzdTiZUbnvM2awFfBgM5FOac8xVkVSDTqOuMmDgQ1J/PkYp?=
 =?iso-8859-1?Q?BBao4rF2EpdpYwwWUWnfG58mqP26TrARWobBFtRVBkdJu20vyvFaZx/CnD?=
 =?iso-8859-1?Q?ewPIjnUQ4SzoCu3vKn7VKpVeEgT9jQzTNW+HnV8Sj9M7DrgHwLwK9z0IVD?=
 =?iso-8859-1?Q?dso50wV27nQrUJkiEm8GvNh7Tee7xxSSbdtGXFrNLD0m2L1BMs76ZiSUzw?=
 =?iso-8859-1?Q?sbEqPSbE873vd+r/eHCVWPZBcV8Kmb8RieB0aedX3UEuFKw9SgwzNxhWik?=
 =?iso-8859-1?Q?fvpHmSNgDQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ndo+9gjcjpezM3o+coOHm/7C3nlh0jqZQrKlXdVDmxYKCwt350hyqYWoKHd8AVEC7PXAb7Lm3ziVP/YaoHMsexE96uuHdxtZE2YG0Q87Bc6VwcQ4+zpOR/UllZLDlgEEYB9ygJg09IZ1ZkjHGB2B1Adx5Nexta5DdxEK91Z6Pfr+qDePmHiTy7L3v3pJOmhU4wg2UUcob6RLaND7N96SDwO/xcvcsM/1wu25RsGhAtcMfRzyz9kXhGi1Yr+LNSNEbZrFPeIZqXDGbYMv7AjhEfQWgr1vjaDoyFFIIKQLcu8hiM0MCI7czNDwR7qYFtwfWqguTFk/kApiTFmXMU+gzA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8482eb55-40e4-4a54-fefe-08de83343c66
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 08:15:50.8084 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GnBOz0C2AUvR8Aa3fooy4Dca9fESev8jAZyYWKuGWZ0bP+BsvGx53BLqHfJRY3AABagGWB/oWBqGpMSjhQU2yoIWPf5Xz4hv7USBeCSgvV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5306
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

Disable the kernel crypto self-tests in the AST2700 functional tests by=0A=
appending "cryptomgr.notests=3D1" to the U-Boot bootargs before booting=0A=
the kernel.=0A=
=0A=
The ASPEED SDK enables crypto self-tests during kernel startup to=0A=
validate the hardware crypto engine. However, the current QEMU=0A=
implementation of the AST2700 HACE/crypto engine is still incomplete.=0A=
As a result, the kernel crypto self-tests trigger multiple warnings=0A=
during boot when running under QEMU.=0A=
=0A=
Typical examples observed in the kernel log include failures for=0A=
several cipher modes such as DES/TDES/AES in ECB/CBC/CTR modes:=0A=
=0A=
alg: self-tests for ctr(des) using aspeed-ctr-des failed (rc=3D-22)=0A=
alg: self-tests for ecb(des3_ede) using aspeed-ecb-tdes failed (rc=3D-22)=
=0A=
alg: self-tests for cbc(aes) using aspeed-cbc-aes failed (rc=3D-22)=0A=
...=0A=
=0A=
To reduce noise in the functional test logs, the tests now append=0A=
the following parameter to the kernel bootargs:=0A=
=0A=
  cryptomgr.notests=3D1=0A=
=0A=
This disables the kernel crypto self-tests when running the functional=0A=
tests under QEMU.=0A=
=0A=
For validating the HACE implementation, we should instead rely on the=0A=
dedicated QEMU unit tests located in:=0A=
=0A=
  tests/qtest/ast2700-hace-test.c=0A=
=0A=
Once the QEMU implementation of the ASPEED HACE/crypto model has=0A=
progressed further and supports the missing crypto modes, we can=0A=
reassess whether enabling the kernel crypto self-tests again in the=0A=
functional tests is appropriate.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/aarch64/test_aspeed_ast2700a1.py | 11 +++++++++--=0A=
 tests/functional/aarch64/test_aspeed_ast2700a2.py | 11 +++++++++--=0A=
 tests/functional/aarch64/test_aspeed_ast2700fc.py |  9 +++++++--=0A=
 3 files changed, 25 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a1.py b/tests/func=
tional/aarch64/test_aspeed_ast2700a1.py=0A=
index 5c0c4b0ed5..b0c08854da 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700a1.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700a1.py=0A=
@@ -51,9 +51,11 @@ def verify_vbootrom_firmware_flow(self):=0A=
         wait_for_console_pattern(self, 'pass')=0A=
         wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-=
A)')=0A=
 =0A=
+    def disable_kernel_crypto_selftest(self):=0A=
+         exec_command_and_wait_for_pattern(self,=0A=
+            'setenv bootargs "${bootargs} cryptomgr.notests=3D1"', '=3D>')=
=0A=
+=0A=
     def enable_ast2700_pcie2(self):=0A=
-        wait_for_console_pattern(self, 'Hit any key to stop autoboot')=0A=
-        exec_command_and_wait_for_pattern(self, '\012', '=3D>')=0A=
         exec_command_and_wait_for_pattern(self,=0A=
             'cp 100420000 403000000 900000', '=3D>')=0A=
         exec_command_and_wait_for_pattern(self,=0A=
@@ -67,8 +69,13 @@ def enable_ast2700_pcie2(self):=0A=
 =0A=
     def verify_openbmc_boot_start(self, enable_pcie=3DTrue):=0A=
         wait_for_console_pattern(self, 'U-Boot 2023.10')=0A=
+        wait_for_console_pattern(self, 'Hit any key to stop autoboot')=0A=
+        exec_command_and_wait_for_pattern(self, '\012', '=3D>')=0A=
+        self.disable_kernel_crypto_selftest()=0A=
         if enable_pcie:=0A=
             self.enable_ast2700_pcie2()=0A=
+        else:=0A=
+            exec_command(self, 'boot')=0A=
         wait_for_console_pattern(self, 'Linux version ')=0A=
 =0A=
     def verify_openbmc_boot_and_login(self, name, enable_pcie=3DTrue):=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a2.py b/tests/func=
tional/aarch64/test_aspeed_ast2700a2.py=0A=
index cc62a915b5..ed414999f4 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700a2.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700a2.py=0A=
@@ -51,9 +51,11 @@ def verify_vbootrom_firmware_flow(self):=0A=
         wait_for_console_pattern(self, 'pass')=0A=
         wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-=
A)')=0A=
 =0A=
+    def disable_kernel_crypto_selftest(self):=0A=
+         exec_command_and_wait_for_pattern(self,=0A=
+            'setenv bootargs "${bootargs} cryptomgr.notests=3D1"', '=3D>')=
=0A=
+=0A=
     def enable_ast2700_pcie2(self):=0A=
-        wait_for_console_pattern(self, 'Hit any key to stop autoboot')=0A=
-        exec_command_and_wait_for_pattern(self, '\012', '=3D>')=0A=
         exec_command_and_wait_for_pattern(self,=0A=
             'cp 100420000 403000000 900000', '=3D>')=0A=
         exec_command_and_wait_for_pattern(self,=0A=
@@ -67,8 +69,13 @@ def enable_ast2700_pcie2(self):=0A=
 =0A=
     def verify_openbmc_boot_start(self, enable_pcie=3DTrue):=0A=
         wait_for_console_pattern(self, 'U-Boot 2023.10')=0A=
+        wait_for_console_pattern(self, 'Hit any key to stop autoboot')=0A=
+        exec_command_and_wait_for_pattern(self, '\012', '=3D>')=0A=
+        self.disable_kernel_crypto_selftest()=0A=
         if enable_pcie:=0A=
             self.enable_ast2700_pcie2()=0A=
+        else:=0A=
+            exec_command(self, 'boot')=0A=
         wait_for_console_pattern(self, 'Linux version ')=0A=
 =0A=
     def verify_openbmc_boot_and_login(self, name, enable_pcie=3DTrue):=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/func=
tional/aarch64/test_aspeed_ast2700fc.py=0A=
index f68f40a1bf..df889134ed 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
@@ -27,9 +27,11 @@ def do_test_aarch64_aspeed_sdk_start(self, image):=0A=
 =0A=
         self.vm.launch()=0A=
 =0A=
+    def disable_kernel_crypto_selftest(self):=0A=
+         exec_command_and_wait_for_pattern(self,=0A=
+            'setenv bootargs "${bootargs} cryptomgr.notests=3D1"', '=3D>')=
=0A=
+=0A=
     def enable_ast2700_pcie2(self):=0A=
-        wait_for_console_pattern(self, 'Hit any key to stop autoboot')=0A=
-        exec_command_and_wait_for_pattern(self, '\012', '=3D>')=0A=
         exec_command_and_wait_for_pattern(self,=0A=
             'cp 100420000 403000000 900000', '=3D>')=0A=
         exec_command_and_wait_for_pattern(self,=0A=
@@ -43,6 +45,9 @@ def enable_ast2700_pcie2(self):=0A=
 =0A=
     def verify_openbmc_boot_and_login(self, name):=0A=
         wait_for_console_pattern(self, 'U-Boot 2023.10')=0A=
+        wait_for_console_pattern(self, 'Hit any key to stop autoboot')=0A=
+        exec_command_and_wait_for_pattern(self, '\012', '=3D>')=0A=
+        self.disable_kernel_crypto_selftest()=0A=
         self.enable_ast2700_pcie2()=0A=
         wait_for_console_pattern(self, 'Starting kernel ...')=0A=
 =0A=
-- =0A=
2.43.0=0A=

