Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A64CCCD182
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 10:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4dIX-0003OP-If; Fri, 03 Oct 2025 06:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dIM-0003N9-QY; Fri, 03 Oct 2025 06:45:51 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dI7-0007NV-S8; Fri, 03 Oct 2025 06:45:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XitmhTmnaYsvTId0vhcTnAd47P4mVyqtScpFxlPeSzm2kMVFpDw0+3GfEC/G2XnD7omNcDugwFe6UPtx0Pm6RfkYABWzgTSUde6ru10CTpJMq98x1zEEusR8oTIxPih3xKNpkQfV0MgGWo79MUKDDzLV4D8z71CCRpI6XzuYgF2LSFhP9tTG+E/bmH967Z4yeQ1pJOuX2K7rq3aNPs1IwvO/OK9sU45t4dyYh1RavHidXQdGW0Shs9mCyJd9CMlzOw/OGUa9YBfg+OqsuQhb+tWg4OB/XvbyU59fvSMa2YvejdDQuPvtwCXXGbEgcVSaVLa6X5o9opakmV2GL6IbVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1NB6XFTV6WRqbPQFV35ElVwn8d6xvWERzCRzOhieEI=;
 b=NkvAI4n5JnnMFZ5HO322PjN1JAsCSxOoIMq7PcNEspLxTp/XgzKlc4gh3niIarUJnSGnABRk0nPOn+Z1Q8qzcxm5GtO3Fjlu79U9noOSucGlwl3zW+0w+bn0L21g0ntp9rAAS6kKoAhH2gv7z/wwfDbYxei5whMbTTvENRlilbr8iUQKZJVqDNuNYsH0YtceVpXQhlLsuMRvzs2GwAnua+834ee78vDOq4+ttnNvvFaycTZEZ8iJ8y6NFA3G/fCTdIhhmf5Szt2U2ddlhoLFZKy4XB58gOBRsD90Jxnqt44DEA4v3hIHOyM3vZ2FJrmFhEtcoHpQnZrIQxKI2+4chA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1NB6XFTV6WRqbPQFV35ElVwn8d6xvWERzCRzOhieEI=;
 b=JIv8NPXq8Ypno2gYFQCrstakstiIXgjLhnqRyhhyFr8dG240w+yD0Ey3fG66eBA00PGc5zIWJX6EaScZe9PbOaxkmss4SaCA0KIfUrYfLRUepbAtTp2yPoy8m2q9P9CvZQfnCjJMaroUmjpwfC0YJHV7QsFiOhJ/9/aETEMiCJrZSc8sVrkbKzYpYx/rC4wbN6Vq5tg3lcuzWuLzcySlcIH7LHCBqTF3PM9UCSNCzwEbH5rzcGy0UogqAm/Db4zHmNXK7afFBjdPyMbNvqPmNNHzE4oKw/Sxk9dMyrPhcxA/FLvCueljIPVHuh2nc9qxAo9Hd5vB1kfNumgqIuLG3Q==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA2PR09MB7850.eurprd09.prod.outlook.com (2603:10a6:102:418::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 10:45:19 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 10:45:19 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v10 00/13] riscv: Add support for MIPS P8700 CPU
Thread-Topic: [PATCH v10 00/13] riscv: Add support for MIPS P8700 CPU
Thread-Index: AQHcNFLPBgrPC/ey2EWWlLi3ONa6Aw==
Date: Fri, 3 Oct 2025 10:45:19 +0000
Message-ID: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA2PR09MB7850:EE_
x-ms-office365-filtering-correlation-id: ea79509b-d15a-4c19-7a3b-08de0269f26e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?4zAazhlaIQ0S0na2/5r7l5RopAKym8lwoAyKgOxJw4arQif6NJkdEr/768?=
 =?iso-8859-1?Q?/jLsgjOC8uWngK8OLLJzWkxB1T07g4PBhWBuxJEXG6lU5HPegGeHFCVqj/?=
 =?iso-8859-1?Q?/GKQZoD34ETsgF327xn9EBBmCKRmF61zqocelia6JTrSKPy29QSpgpvb3F?=
 =?iso-8859-1?Q?0gAqZfGMC2e4wetVYjTxAKbvSVhgYqpMK+9teB0YpVhKiY0dk3OH2DmzrX?=
 =?iso-8859-1?Q?7XcSExObjyYB/mQxd6oLiq2nTfTA6sxaGM326fY1EPDHVWy9tsewcXZX+X?=
 =?iso-8859-1?Q?Pdx3QuQgvJe71UR9LvN7mj7bBtLyoC4RvYtHx7H3lPGu+4ScOCjwicb+sd?=
 =?iso-8859-1?Q?8ZFj5s0fZrCmsdk+w+IRIyZzS7YGjyk26rpeKBIZyMeCSPREuU/vsGF/vR?=
 =?iso-8859-1?Q?jmv/fnUQSIH/I9MWHJ3i71OUEzxgBAt9mc/NrjtdUDU3F9Pfk8FqBxpNhJ?=
 =?iso-8859-1?Q?hbYsqYqNVzjfy4T3lJ6BYXAJsaYneAg8rIXs6elxbKtRlr3RWlgju/ggaK?=
 =?iso-8859-1?Q?YRHjMVfW+lRD2inhBCt6IDGlosxW7ircrwxc4dqY2IJjVtPDPON4ufZgUd?=
 =?iso-8859-1?Q?t83pL1y6oOciYZrkYtRM6WZt5pe46gsbNtjdNehslEWaHtwCVWSOBMcjnr?=
 =?iso-8859-1?Q?HthIAJOkBXDwu/mzjbxJvTAihcbNuH8plvU14ui2OBHehFQnrswZAoxGEF?=
 =?iso-8859-1?Q?O8RHcgnKHfCUPZqqi9FRAFIaqWbOcFppTNH8zal9mDlH0y1zVOn11+2npS?=
 =?iso-8859-1?Q?GVU3pztLds83WNYevcv2kDguwNlK5AuBJoHf4efSMVMOfLnW2RRm9sNz0Q?=
 =?iso-8859-1?Q?2Y/7Rj6AW2Z3kXyHgBbxGOTxAUX5C2e8nbKYmkt/DZdBYMwb3I68DnvUCz?=
 =?iso-8859-1?Q?/wssKvVIK4of7vd2iwwjcPDzUTYxaX9tubbyTpkxf8WotNr/h4EAECFwSF?=
 =?iso-8859-1?Q?Vu+9BU9n7I2+kneNc+GCU6ODKZTSFZ2mG7APts2f+9JP2c6SfeCtfQ8dGf?=
 =?iso-8859-1?Q?LK0IUmcUXyuP5k4szzCHrjUzA+hRzZfCyfHEECB3z4byZflakdfzdfSiwP?=
 =?iso-8859-1?Q?DXWksAivC+E0df5i8LFZryHCNcs0qva5jK9P9nVgaDN+6Lp+s3U94HBLIv?=
 =?iso-8859-1?Q?jzDvAOUIw/+oIJ6q+VlLd+EXoFb2XDFSeLF1/i6pqsFtTTrJG1YJgAou0y?=
 =?iso-8859-1?Q?GW2JQ5KKIh+m8aG0BQHfrMCW2I7uCiRSSodeAR2GCXuaGqWql/VvgPIpJW?=
 =?iso-8859-1?Q?blP6BThdkOXEajYhikbH/K2sWlG+0xGmnJqxpG+X5cd/mVQtdTo+qpSdzJ?=
 =?iso-8859-1?Q?BDEGJHgG1lQ2IwhI/kse362mExjj+SULjf7Mwt1Kb3r220cN6dMbnIRwsV?=
 =?iso-8859-1?Q?55x5bWGg+FlY0GMIz1Bk4n2VfTawanF0JsY5JK7LBhpG7agH1D6HdWk/Ye?=
 =?iso-8859-1?Q?hRhfMnCyvvaP89Qxw1FQ+YrBCSlGtDwQ8gQ7UuIu7pX4vDNU0hR5FzBZcG?=
 =?iso-8859-1?Q?3uLPpEg6udBE0DYMI6Trwh5dBm4qzy+L4hwHGEWWyX9I7R4HjJj/JGGlwU?=
 =?iso-8859-1?Q?ehTS2lfGBsNbqpw23vohYwjt44T+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4BWGAN5T3oem/1gjKXk2x5M8xZI4gn/KQVcZOfefkONzSbvtJhBO/Efu57?=
 =?iso-8859-1?Q?7s0Lmz+ZgjvFvxXbBaf0IGRQRR0BNWdo7nBObNQvGoLKj7XV6chxjF6uNA?=
 =?iso-8859-1?Q?dY7/brcGJh1Tht9GTZWPYJBg3HacQdg6VMMhg1Cri4fMpTu3c0n6riCbUJ?=
 =?iso-8859-1?Q?0TmKLBWh7d0/ZXHCMARDq/iFBJL03HJq9mV4xvyiCwogcRx516MhBKIGCL?=
 =?iso-8859-1?Q?giGvZc4DsyTVSsQby9pFelev7Ak6bUXN8uS2LHuYk1bzPn8HmzaYRSrWMo?=
 =?iso-8859-1?Q?Y3dmrRNJL7uNEsZYwKqjIHD4Fh6hNpiZMi3oRa2cYq+9Rn1qg7vlOtzdDN?=
 =?iso-8859-1?Q?ecjQ32NiH5NHGRGOh0A+iXH3jaFi8QKHO5tTKjZnW3k49vLGPQ72QdBuVr?=
 =?iso-8859-1?Q?xq/wisrX5ZrEYxdMVEYCk0DmNFsSVzUVz4irP47nPOwMpyPDlGTLttOOTA?=
 =?iso-8859-1?Q?2URUaWOk1XpppgXJKuvBM7JzCuDiNbKnyznqqhn/4O9ZGl2JSjADwycqhk?=
 =?iso-8859-1?Q?QomMO4lvc4umd+EnWPUsEm5kaRYoBQMMvSfPOyu20PDxln3buEWjBwntI4?=
 =?iso-8859-1?Q?JINlampuwmsIrSywQznKIhuAyK8g9hq0U/sq8ep21O1w0W4qPChzIPynH2?=
 =?iso-8859-1?Q?y5HeKzr16j8F7NN77qFzF+1JnSu8cnL5b45nUbRSNZ1rSOweGK5zkFOxee?=
 =?iso-8859-1?Q?3Wz5QjxYvC/nQD0+gHqZoT5zrkaZjs3eVQove4xs9jNjwhdDOQ3OhFs9R/?=
 =?iso-8859-1?Q?NeikiMLEdLxU0kFPqqUUsayzsY288UQzro60R70yOrJYM1g5fxyq2cRsc9?=
 =?iso-8859-1?Q?xx3vHC9dWvQp/Dqnm8B1ei0k1Zc/jUM/zybQDpfGYW7Q4oM99Zspxy8M3j?=
 =?iso-8859-1?Q?D7ShLtTMJIVKekwQRpHt+JD456vwxWcfyTobvm1v1X9kv/VG1kLENMYVTq?=
 =?iso-8859-1?Q?E5qYVzTp3PTjrI4mrky6xmGK5P0uRhmMPiovJmw28SHgNSyph1HtzcbQAA?=
 =?iso-8859-1?Q?68Gmq0+OPyd6/V519RXAcVppmoL6mfxLB/tp3hwf2d9lYdUo/B9+7A5stg?=
 =?iso-8859-1?Q?YBH3+4Jg3KYT8T3Pl8MlSOnq5EB7eGikL/wxxwTIyF/OP4C9RcqFdTt2CZ?=
 =?iso-8859-1?Q?HfFUYLnwnajmNdHD3F2hM5M8unPaiz1V1md2h524Po5FKIwW9xsZmXK2KW?=
 =?iso-8859-1?Q?8h0k1oCLIjotQ5hyhE3DVCZxJKjCNd4wVEIQpWnN5SsE5XuHNhbj4s1ZQz?=
 =?iso-8859-1?Q?V3oH0SlxJg8YnxN2Vd4AxwyBcE9jpV/W0vFLF6ZP5ufG7mH+Ox7SU2DK+O?=
 =?iso-8859-1?Q?6HCJ7ewVfCYYiHD8Gds0c4nEQ+Fws/fEnDZ+Hatj3LVUZvGXWWX80nt1ON?=
 =?iso-8859-1?Q?XmHq7qflWDgelOCYYOixW0NycXQS0i2sau+o+k1oSJI074k9D+4C520zRE?=
 =?iso-8859-1?Q?OQmqRIJP39NmH7TCsr5k14cs7XO4l1xB0M4p4PZ8kcdtf/9xSLZjoj27fC?=
 =?iso-8859-1?Q?ClMHjRZixJA3d4xZxZrcjQ0LlT5k9Re3OpDIXYVsiuK123bV81LsegfaNg?=
 =?iso-8859-1?Q?5y620JxfmF4Agut7Udq2cRkmjvQYq3OkVa01WTXCsiucQuBjFgn166fKP+?=
 =?iso-8859-1?Q?tCVuWj5PwuAvWDBTOnAjcFmGNuiksWb4yhnkBhB9xqk4nY0WG4YF7Clh71?=
 =?iso-8859-1?Q?BxZMNrflW+m0HdfgeRQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea79509b-d15a-4c19-7a3b-08de0269f26e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 10:45:19.5195 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: maDYhWhB2X517U0SR3IKCbPG6//ovIPr7GWXjWtHVRsnsPB4WBz+qtf0csB86k1u04AVl8SxN3pDy5i+8t4+gVrTkxwzXyOUxzsj3oMCPj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7850
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In this version of patchset I have addressed comments
regarding the test case and added one comment for the
cpu_set_exception_base function we added.

Djordje Todorovic (13):
  hw/intc: Allow gaps in hartids for aclint and aplic
  target/riscv: Add cpu_set_exception_base
  target/riscv: Add MIPS P8700 CPU
  target/riscv: Add MIPS P8700 CSRs
  target/riscv: Add mips.ccmov instruction
  target/riscv: Add mips.pref instruction
  target/riscv: Add Xmipslsp instructions
  hw/misc: Add RISC-V CMGCR device implementation
  hw/misc: Add RISC-V CPC device implementation
  hw/riscv: Add support for RISCV CPS
  hw/riscv: Add support for MIPS Boston-aia board mode
  riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
  test/functional: Add test for boston-aia board

 configs/devices/riscv64-softmmu/default.mak   |   1 +
 docs/system/riscv/mips.rst                    |  20 +
 docs/system/target-riscv.rst                  |   1 +
 hw/intc/riscv_aclint.c                        |  18 +-
 hw/intc/riscv_aplic.c                         |  13 +-
 hw/misc/Kconfig                               |  17 +
 hw/misc/meson.build                           |   3 +
 hw/misc/riscv_cmgcr.c                         | 248 +++++++++
 hw/misc/riscv_cpc.c                           | 265 ++++++++++
 hw/riscv/Kconfig                              |   6 +
 hw/riscv/boston-aia.c                         | 477 ++++++++++++++++++
 hw/riscv/cps.c                                | 196 +++++++
 hw/riscv/meson.build                          |   3 +
 include/hw/misc/riscv_cmgcr.h                 |  50 ++
 include/hw/misc/riscv_cpc.h                   |  64 +++
 include/hw/riscv/cps.h                        |  66 +++
 target/riscv/cpu-qom.h                        |   1 +
 target/riscv/cpu.c                            |  43 ++
 target/riscv/cpu.h                            |   7 +
 target/riscv/cpu_cfg.h                        |   5 +
 target/riscv/cpu_cfg_fields.h.inc             |   3 +
 target/riscv/cpu_vendorid.h                   |   1 +
 target/riscv/insn_trans/trans_xmips.c.inc     | 136 +++++
 target/riscv/meson.build                      |   2 +
 target/riscv/mips_csr.c                       | 217 ++++++++
 target/riscv/translate.c                      |   3 +
 target/riscv/xmips.decode                     |  35 ++
 tests/functional/riscv64/meson.build          |   2 +
 .../functional/riscv64/test_riscv64_boston.py | 124 +++++
 29 files changed, 2022 insertions(+), 5 deletions(-)
 create mode 100644 docs/system/riscv/mips.rst
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 hw/misc/riscv_cpc.c
 create mode 100644 hw/riscv/boston-aia.c
 create mode 100644 hw/riscv/cps.c
 create mode 100644 include/hw/misc/riscv_cmgcr.h
 create mode 100644 include/hw/misc/riscv_cpc.h
 create mode 100644 include/hw/riscv/cps.h
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/mips_csr.c
 create mode 100644 target/riscv/xmips.decode
 create mode 100755 tests/functional/riscv64/test_riscv64_boston.py

--=20
2.34.1

