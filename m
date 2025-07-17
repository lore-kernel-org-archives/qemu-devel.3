Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4761BC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 09:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLKU-00086S-Og; Thu, 17 Jul 2025 05:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL4t-0006PI-1T; Thu, 17 Jul 2025 05:38:59 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL4o-0002PD-Qj; Thu, 17 Jul 2025 05:38:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WoE09x6rpFxeG/GRg9N0O2LFhoJgDM68UMsTg+ZTr3joFipXEhNYqC5WxtBLxWU241Y857mYdwwkr7HmYD5bv/CInudaPpeO4+Bxj2hYyTyclwTaQRYywjE0tWHjdGEnQkJvIxtw2QnuBOt3oWWpBzmnSoTwy8aq7+cmAgAbyY/VsJ+72M+sWHh6eVH5rwqgOJ+12K23xo03L+v6jlzDCWU1Vm5yJC05zLjAVMeX+u5VZqS327AV7jFhgauCE8Gk0Gu0GHcV+icehXqbpL9GY0QN0prrXaL1g8zJG3BIDaLbVJHwV1fkm1BY5KwcZdfOcHH/SSHEs6A56zr/SWBcWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlrC+ZJFyEIGLXfWcfdPeWMYsHalovjkJbPXEEN0pCo=;
 b=CFxxis7sVbXNbO4bHwJWJ+G65WhHBtfB8n0KRyD5LhaXss91EPT8h886LFhyNatxkGhHz/l6FgEmsqjeTMrXGdaF0DffPIQZEiRt/n5swrZG9lppwa2MFE5JsskmgokTpV1x+fE3OjNqOX8h/LTWDZOjBIPj/44Njdwn3oSQJY9njKAF9tN1C3w0kyeTWPvlZ4ZWEDJr5NZ4PKaQ8+A1nvmgIVVn5gSuXYKQUbnIM94L/katOur8P5rsqE8+hRYMqej4/k888Fa6MWFE/u26IE1O/rOHWDrv8+5WK2piE8AG925DZRdmEgvzf9o6RKBbThvCQcgX20BXO+pHYhs0ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlrC+ZJFyEIGLXfWcfdPeWMYsHalovjkJbPXEEN0pCo=;
 b=ArSUd0WpMyU4IF7oRm5rHkQhIFawUKz2uAP7CGnT0Uaqdde4I44y2CqRwht9k4vRLBtBXxq7vS1D6lrjaVHDhH5g55TuObtFvTEbVKLo2Dcbx2qBjFBE/xc0hxiKTTzSmNql2jubcPtBTjQLTyp7QrKb8mDiN0WtyvI3DhGtiOCA/irWdP2DI26W7UMh7U2j3C37wQH6/ZleiAeiKfFZX8U1Tz+5POGssK7eqQv1bcVyelcVvm88Nlupzt2MtXHFSgsehjCUwnPG8mIxWev1U2vBxlrm6aHs1OERWtqWvUupDGZwCly6DfJQd1Hua0evsDb1Iu6enSwWVz9XcvKrog==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI1PR09MB4318.eurprd09.prod.outlook.com (2603:10a6:800:155::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 09:38:45 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 17 Jul 2025
 09:38:45 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v6 04/14] target/riscv: Add MIPS P8700 CSRs
Thread-Topic: [PATCH v6 04/14] target/riscv: Add MIPS P8700 CSRs
Thread-Index: AQHb9v6VHAce5oZ/v0+Yu6iPCXNWCg==
Date: Thu, 17 Jul 2025 09:38:42 +0000
Message-ID: <20250717093833.402237-5-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 521cc710-5d60-453c-1613-08ddc515b952
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?c8eG8yVoSc2yEAc1WoNOBbMsBT3sNBVHeqh276vxIsIElw+zxIU+qWT1rl?=
 =?iso-8859-1?Q?raYGBZGAdgFtKcN7KPJvbF+8sAMsXaRbk6JkLv+lP29nLctfrVY3lJbnFA?=
 =?iso-8859-1?Q?Uk5KXHxe7Rpi62i0NY7iHweXMoDDieeyoBtdULmlvwXF0J+kr1uLBt4qzV?=
 =?iso-8859-1?Q?+77M3hkklMVXE/sYedW5YWhcqd5BGe16wRYSnW2A6dbL6bLLM9qunqcG4A?=
 =?iso-8859-1?Q?3UeV/tTN7htX+wLusxQwQC5CrLPFMpO0+BtMYchCEX7FaWCSYITf7IufCL?=
 =?iso-8859-1?Q?7buLOzqKnWGtKEjeI0534qjcpgGyhqRz9ywWkpxYhKV5t753jtGR0nbJxl?=
 =?iso-8859-1?Q?OJDcaTfAYmDqopty01p1lBuW3N0ILKSV0ZTJMVaMeinKdl+q9eBC7pSFjC?=
 =?iso-8859-1?Q?Fw+zRxde9qF457eWC9etolXuTgijFeCLkXHfhMZQ1cessQNO2DgPinO8RS?=
 =?iso-8859-1?Q?cUwUzY4SvEYPZEXs+E6zzEYMTRA8si0GI1WdJkr7DnyzCIJnUk64V5Padn?=
 =?iso-8859-1?Q?GassGvvFrlhDdnzIgUkl1Gp5b1kJidOZ+JZ5tZXyjDCwXRrrBGGSl6GW/d?=
 =?iso-8859-1?Q?d99JZbPb/iqqtjjuOY4DavDnQkMfxH2lkf2wOx0oTqXbXMMTefo27t7ciD?=
 =?iso-8859-1?Q?Li7Yvah8vanW7T0ykQmwB6RWnUghhkLJmO13eywe48oEnGx+yV49Fb7wUa?=
 =?iso-8859-1?Q?vXUkhfRgV3Px3HWM7fjIkLItv80hqVE/PZ0p1rbOTomvb9OJ7mx9XHsPiu?=
 =?iso-8859-1?Q?lGyWLHSfWmuwfk5bVK/WcmSu7vpMGImRtIQ42S+e3Jof6pfUhybbWQHCx0?=
 =?iso-8859-1?Q?hcDgQemgKYBh9ICjJYjJdsrRC9pa2rchfN6piND7Ybo2zbfIhU4O8Zlfgb?=
 =?iso-8859-1?Q?T0M3kJwY/Bh4RD5S6hVDHZmbmBsCFB5h9hDEahplrioHzEyUYAKCWlVmrM?=
 =?iso-8859-1?Q?142F+D0eUjRPrvJUqK1Sh+LvH5jBAkYAIsUhUBiafq+eMmToF+QEPsa+fU?=
 =?iso-8859-1?Q?rvn5wc0oW6pUVUAzID59+spNn5gJwUQ/iMFvdtRmMpQIdlU5zNk6Jbzm8D?=
 =?iso-8859-1?Q?wkxZ65X5wY86RQc0H7cUaa++IxpOdlomrGZ4w3zA6s2xgAH3/srr+9AGvh?=
 =?iso-8859-1?Q?GnWArOgIRYNLs/SAI2IL2q++zSn+UOM7JFQEE2Tvt8Dvx02zSkfO/B5Nhj?=
 =?iso-8859-1?Q?t6D56mjPmgM+MrW6PXCmQeI99iPRwMbyLZJohk6OcOODDyTQgwsWnk8ADY?=
 =?iso-8859-1?Q?P1xHNjvzpWAKHVetekRLsM06BykOQi/by5/rwW6DzemYyNNcEOVr7S0SA0?=
 =?iso-8859-1?Q?ozCTIugwTJDNkUYc65pMsQSxuhEk6Wb8lYm4lJHIcwB7bqhT8iWYZs09x8?=
 =?iso-8859-1?Q?3QYE1YrVkmKXbV4gSV8LEHJX+IhsQgWorourebrjQ0+907SiUB2UbmQiZn?=
 =?iso-8859-1?Q?Uql7Wk0wYJoLpaZPR93xa7OzW4ZCZIdEgGeXSLcuhFGYgT4pbguOJv7+3x?=
 =?iso-8859-1?Q?83+bnDY8kh7ddLAH4yhF6maMtf6OLPnU8seHLh2W5ibdJsOizRQTL0YXqC?=
 =?iso-8859-1?Q?KQSaogw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/Y3OsVDZcYFdIEtGTYhRWKwYD+SIic6TU6IKN2MPR0TT4qDjeSVksFLOal?=
 =?iso-8859-1?Q?H9IlvL1ZqZUKYcwrv2J+aWyMmICANi2Z2+XI5W0HKL6k29YPNNFlItEM33?=
 =?iso-8859-1?Q?xk+Ls2iVmmELN04O0w2nlDwCsE23dFSPdv9dsiWHJ2Wkjvv6T+zXzfeDVo?=
 =?iso-8859-1?Q?c6UE3wz5ouvj5ZI1jovuNjhg3q1sfAx8OnXbqRrD6HR8wyA6WJf6qb76hv?=
 =?iso-8859-1?Q?pCyLzTxTKhuPYOSdSzBQZIF3gGS1hVv9IM5NWEe1e0eoIt27PR2HFl5aGF?=
 =?iso-8859-1?Q?s2WY6xDRxg6RCqzCOUSktXfdl0rAy5EoqTP46MR+rh6cQoFHe6TjAcqb/b?=
 =?iso-8859-1?Q?Y27ZSFHbh8FL610aNv9k0lmipFNRD3D0hnR5ISI/tBHiYsV8yUKzOr1jOt?=
 =?iso-8859-1?Q?4Ya8DXE67NTroJ84eLBFH3+uDj781XQqE96zgqaVCh1e2SxvxwrT+NXhDs?=
 =?iso-8859-1?Q?ShejNO6kCylppSeD1JZ4eiFIo+n2294hwFy5hzDyCBAoJwuIViga6+r6gR?=
 =?iso-8859-1?Q?rFa5hM2vI+ILkRnm321dAtwGl9tQTiA6M5wx6OtyWhbuC5op/xs89MdyQ2?=
 =?iso-8859-1?Q?N5FNO3g8wYgjyoXMN1bzZMj1oMUyoNttCZFpKiffEDSvaPqyw+lMWq0olE?=
 =?iso-8859-1?Q?v7kFqcarxRJfmkHxiWcfWzYTsGXI8caUkWzrrMm/bA4O3voMNVxo3wq34w?=
 =?iso-8859-1?Q?0sszHfmsDI3f5DvkfuEwRDZtVhVcMNDV7fjW7zuGHpEdnUua79JA0gUNYR?=
 =?iso-8859-1?Q?/AqywU1Ylk0MLKVHkeCFv9qzgS4xLziwufC6PNkSqkXb2z8LR+GpMjQ2X5?=
 =?iso-8859-1?Q?kCPRuEjMJeOmR9udGUJZ9C8w+VqBlGw1DjF7ZN3+teBgCZQCorFGFk5xEo?=
 =?iso-8859-1?Q?iI6I9ZTULhgI0nALXs7M7+/lYvGmoMkVKp9x9uelifdi/hetYGxEhZYyHq?=
 =?iso-8859-1?Q?FsFnRpgWZpisTfd3nJ5oERJ73cmo1T//ue5DoKYluSjkcUcdT4fi7GneqT?=
 =?iso-8859-1?Q?ddCQq6Ox21MqI7BD58zLoBOXM2+ksG7VOmj/7JhFyn9ei6y4bKxwJWN8HB?=
 =?iso-8859-1?Q?BK/h99H6j3zRRMBQgsJsEENS7/5dAFEBePmX5e4H4hfqijTscQCUBFPVIo?=
 =?iso-8859-1?Q?iMNj9ZUBrqMpXMobZSmZ6xvKZdQK4naB1BGinqyP4ceJ5sAYA4z031HOIE?=
 =?iso-8859-1?Q?5LCuUL5UZCHUc3sqAq9idqgprhWoNwZAn5X09X8Sr+pAWDuD8gz0rrNTYQ?=
 =?iso-8859-1?Q?Akn/1OIJ218VGci9Dgt7rhhc+E+hY8VTJSrHm+rlamYGNlrLFJiamMHelM?=
 =?iso-8859-1?Q?KCGkpZahINYn6dxc+D3AeAfQyRI2+67L/UnH7HvUT5LUAXaTi/yGanJlsa?=
 =?iso-8859-1?Q?hMwiMij8K+v6T4rro1hieNWrR3//XqkirJeM9enLPAdzaSq/Q6YhimdczI?=
 =?iso-8859-1?Q?gHdTWZy67rro+O8xFjZy5lnXtRWycDYw+FoMtYyV7RWgPF0lJxvwqDvnim?=
 =?iso-8859-1?Q?+hwx2OVX7bn/wH905NPh/24fLdMF7NlXt9GSs4Ym2ZLbN1y7+SXJCUBsZr?=
 =?iso-8859-1?Q?OyyexQprBkot7wnSVMfrHQMudltFXO0hQmCftknvMiO3it4FfZ+8kryH2R?=
 =?iso-8859-1?Q?9ZyiqxFa4rFdvRt/kQQKIe9Nca6e/PUC/rGu321pfDDS3l2UUX+CfZWEJA?=
 =?iso-8859-1?Q?eCCfBIWZfdnkV5QcM3c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521cc710-5d60-453c-1613-08ddc515b952
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 09:38:43.0458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JAKh7tUP24pRZw9LFd3JYf++DDFctEisAsdmS2aIX9Jpyt+6Cpt1t+ZwqfA0R7CtLwInqzLTwkAPqCloVGN+JmCga2sAw0pIc6E5nwwgp7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB4318
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

Define MIPS CSRs used for P8700 CPU.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c       |   3 +
 target/riscv/cpu.h       |   3 +
 target/riscv/meson.build |   1 +
 target/riscv/mips_csr.c  | 228 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 235 insertions(+)
 create mode 100644 target/riscv/mips_csr.c

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 401c0f6c7d..7f453acbf8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3193,6 +3193,9 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.ext_zbb =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
+#ifndef CONFIG_USER_ONLY
+        .custom_csrs =3D mips_csr_list,
+#endif
     ),
=20
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index fba0b0506b..ed10709a65 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -972,5 +972,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32=
_bit);
 /* In th_csr.c */
 extern const RISCVCSR th_csr_list[];
=20
+/* Implemented in mips_csr.c */
+extern const RISCVCSR mips_csr_list[];
+
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index a4bd61e52a..fbb6c8fb45 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -32,6 +32,7 @@ riscv_system_ss.add(files(
   'debug.c',
   'monitor.c',
   'machine.c',
+  'mips_csr.c',
   'pmu.c',
   'th_csr.c',
   'time_helper.c',
diff --git a/target/riscv/mips_csr.c b/target/riscv/mips_csr.c
new file mode 100644
index 0000000000..2fc10b8618
--- /dev/null
+++ b/target/riscv/mips_csr.c
@@ -0,0 +1,228 @@
+/*
+ * MIPS-specific CSRs.
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along=
 with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu_vendorid.h"
+
+/* Static MIPS CSR state storage */
+static struct {
+    uint64_t tvec;
+    uint64_t config[12];
+    uint64_t pmacfg[16];  /* Fixed: was 15, should be 16 */
+} mips_csr_state;
+
+/* MIPS CSR */
+#define CSR_MIPSTVEC        0x7c0
+#define CSR_MIPSCONFIG0     0x7d0
+#define CSR_MIPSCONFIG1     0x7d1
+#define CSR_MIPSCONFIG2     0x7d2
+#define CSR_MIPSCONFIG3     0x7d3
+#define CSR_MIPSCONFIG4     0x7d4
+#define CSR_MIPSCONFIG5     0x7d5
+#define CSR_MIPSCONFIG6     0x7d6
+#define CSR_MIPSCONFIG7     0x7d7
+#define CSR_MIPSCONFIG8     0x7d8
+#define CSR_MIPSCONFIG9     0x7d9
+#define CSR_MIPSCONFIG10    0x7da
+#define CSR_MIPSCONFIG11    0x7db
+#define CSR_MIPSPMACFG0     0x7e0
+#define CSR_MIPSPMACFG1     0x7e1
+#define CSR_MIPSPMACFG2     0x7e2
+#define CSR_MIPSPMACFG3     0x7e3
+#define CSR_MIPSPMACFG4     0x7e4
+#define CSR_MIPSPMACFG5     0x7e5
+#define CSR_MIPSPMACFG6     0x7e6
+#define CSR_MIPSPMACFG7     0x7e7
+#define CSR_MIPSPMACFG8     0x7e8
+#define CSR_MIPSPMACFG9     0x7e9
+#define CSR_MIPSPMACFG10    0x7ea
+#define CSR_MIPSPMACFG11    0x7eb
+#define CSR_MIPSPMACFG12    0x7ec
+#define CSR_MIPSPMACFG13    0x7ed
+#define CSR_MIPSPMACFG14    0x7ee
+#define CSR_MIPSPMACFG15    0x7ef
+
+static RISCVException any(CPURISCVState *env, int csrno)
+{
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipstvec(CPURISCVState *env, int csrno,
+                                    target_ulong *val)
+{
+    *val =3D mips_csr_state.tvec;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipstvec(CPURISCVState *env, int csrno,
+                                     target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.tvec =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipsconfig(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val =3D mips_csr_state.config[csrno - CSR_MIPSCONFIG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipsconfig(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.config[csrno - CSR_MIPSCONFIG0] =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipspmacfg(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val =3D mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipspmacfg(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0] =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+const RISCVCSR mips_csr_list[] =3D {
+    {
+        .csrno =3D CSR_MIPSTVEC,
+        .csr_ops =3D { "mipstvec", any, read_mipstvec, write_mipstvec }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG0,
+        .csr_ops =3D { "mipsconfig0", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG1,
+        .csr_ops =3D { "mipsconfig1", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG2,
+        .csr_ops =3D { "mipsconfig2", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG3,
+        .csr_ops =3D { "mipsconfig3", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG4,
+        .csr_ops =3D { "mipsconfig4", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG5,
+        .csr_ops =3D { "mipsconfig5", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG6,
+        .csr_ops =3D { "mipsconfig6", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG7,
+        .csr_ops =3D { "mipsconfig7", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG8,
+        .csr_ops =3D { "mipsconfig8", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG9,
+        .csr_ops =3D { "mipsconfig9", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG10,
+        .csr_ops =3D { "mipsconfig10", any, read_mipsconfig, write_mipscon=
fig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG11,
+        .csr_ops =3D { "mipsconfig11", any, read_mipsconfig, write_mipscon=
fig }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG0,
+        .csr_ops =3D { "mipspmacfg0", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG1,
+        .csr_ops =3D { "mipspmacfg1", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG2,
+        .csr_ops =3D { "mipspmacfg2", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG3,
+        .csr_ops =3D { "mipspmacfg3", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG4,
+        .csr_ops =3D { "mipspmacfg4", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG5,
+        .csr_ops =3D { "mipspmacfg5", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG6,
+        .csr_ops =3D { "mipspmacfg6", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG7,
+        .csr_ops =3D { "mipspmacfg7", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG8,
+        .csr_ops =3D { "mipspmacfg8", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG9,
+        .csr_ops =3D { "mipspmacfg9", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG10,
+        .csr_ops =3D { "mipspmacfg10", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG11,
+        .csr_ops =3D { "mipspmacfg11", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG12,
+        .csr_ops =3D { "mipspmacfg12", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG13,
+        .csr_ops =3D { "mipspmacfg13", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG14,
+        .csr_ops =3D { "mipspmacfg14", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG15,
+        .csr_ops =3D { "mipspmacfg15", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    { },
+};
--=20
2.34.1

