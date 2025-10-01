Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDF2CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 09:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3tTX-0004iw-F3; Wed, 01 Oct 2025 05:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tTR-0004eF-7A; Wed, 01 Oct 2025 05:50:14 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tTE-0004v0-6i; Wed, 01 Oct 2025 05:50:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0/jKH57cBHmw2o9s8b7EysGSRu/nAIbcXOHS60gcUH6Ds8iKkFtrZcftizi1kvBTsgmWzjcdObHlx+w6PzFumJ3tejrEptn5nupbbqbDu1wtNLWjmZ5LsktBL/pU1Tv1IBhbYHXJf0wO/SGt6eAc3mxUWMODSJ1E0ixQq25YUDdDSRRxx9s8VmQfu+zlJpQvSzbrDmzy7xrWm4NM0ReqACLQv2GPo3GDsjxxyQRqVUqQbCTFo45YjrpHVD4iBVhk8y3vBA9JPxQGlUU3aAcRLfY50Z5S+qu541d35+O31TzSacWV6Y5imVB0xJjiN0XlByEpd0wr4WQVcsi8m8cLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CY75rhKf9DKchvqAFPD/+HyBzpmDRtoJTe+EJkQ1z7Y=;
 b=ReIyCpmN04wweSBt2rmsv2jwUsBXrEohgbJP7Z0O44fM9mFfTDdyAgqeRInSggGrJZiFg5hz7Bin0QMRMVVc0niye4p6S/DwV1c4GPh6oa70WtjA+H4wmuuVKUdQuJS0jOJTnIJlucH7BREA+LW18UMv30QS0BokKd/p+Q3TvzV9kE6fUU2sNr/Rsxal0PUbm/BUSPb/cN4HQdovAeIOiB56j2obu4DeAu6P5JmDNpbMq96Xlott2prStI7gxGZJKwlElP0ZFNFMypuDSUzQp7chjIWH2l+jIxNXtwmP66KUTm2HmXWr4fPZY8spZuSt/lRNWciJvmxxk4Pw74TbHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY75rhKf9DKchvqAFPD/+HyBzpmDRtoJTe+EJkQ1z7Y=;
 b=FA78GL1DAAXA7Amt0EGRBs0OtGv01UOqu2+PxGYB4DZNS1pmmoQUxy4SFDfJGm/3ymgCF6/DbTfkEiR/54Izjml4UEexZfa6Ll0XvwmCEO8jmBxE7G49a0B1TMQa0geOf884qxy/J6i/UhrDO0Bg87cNAms2+sEaJC/Mr7c3W6RNKXoIxn+7oqgBgLXy3tYtL2Kq6pA/H0p8w+XiYYj1WibCSk8/ZGICSq/+1L8/r13R7qjXpxe2AXStILfHLUBUvd/NjuJ8k9k3kPXhlS6jEnUQGOFICnLHV3uqjh3jhHqbZC0o2Ha2rKWWLYEdRw2BNkKNFBGSMfAgVXNamgIUAg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA3PR09MB8279.eurprd09.prod.outlook.com (2603:10a6:102:4b9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 09:49:11 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 09:49:11 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>, Djordje
 Todorovic <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v9 05/13] target/riscv: Add mips.ccmov instruction
Thread-Topic: [PATCH v9 05/13] target/riscv: Add mips.ccmov instruction
Thread-Index: AQHcMrij/WwjhFelM0ujNcqS0qi68w==
Date: Wed, 1 Oct 2025 09:49:11 +0000
Message-ID: <20251001094859.2030290-6-djordje.todorovic@htecgroup.com>
References: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA3PR09MB8279:EE_
x-ms-office365-filtering-correlation-id: c3cc9f4b-bb64-4000-501b-08de00cfc5fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|13003099007|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?phqyMvY09Uro8YyBeai5ZNzB00rwgy9nfrAXEL+ZF72fO9bxEx5YF/qkLo?=
 =?iso-8859-1?Q?LdpUEaSaL/Fsq06kMlfPqIaGWK2qvH30tfd/4FJuNTh0DxLHGGgUkhBwBt?=
 =?iso-8859-1?Q?QrVeSKsuvT5aWiySHR+fs21PK1hPdsPb8bTEI+eWA0uK3vxH47W5t2gCjO?=
 =?iso-8859-1?Q?me4nQ5iR6f0VQAdhjIxjCaXui5n8okJCCC/nc2Gvzx2pQ4bok8OFVm0rCt?=
 =?iso-8859-1?Q?WexFpPNJkLi5lXr1qEnv74hnWGKDx1SWqYdxujSjarPYNWRjQ7vj/n2wNl?=
 =?iso-8859-1?Q?X9I2UogoHS+weEhXzJesE6SZxv0acNmQxXld+PLmTaUlyZxLHMSMrgU1oi?=
 =?iso-8859-1?Q?IFBVXuDIhGes7Hs1Cl2OWI6YQkkFiD3lVPMe8HaDjekUSaHxC7OlmNvbTr?=
 =?iso-8859-1?Q?uT5HkPCErUucpY58KSPZtJKj8a2mxv2z2h9TxPq6PrKOhwqEhDtWSVmdfY?=
 =?iso-8859-1?Q?BRBnIVnEjZJUUDdvvj47PkEc3xCphljYEMfjC+rxwxdA6OSc0q8w2kcRiT?=
 =?iso-8859-1?Q?EQPjoEGFufQ5ZxAo0SgVphZ94XJk4LkVTuYmp5XOs9VYjmos2SnjKcZfKm?=
 =?iso-8859-1?Q?CsEk+GZHNW+jR7sz+w362xsycKMwTZeDn084zZDzFYyHONIUR79odaMUvi?=
 =?iso-8859-1?Q?/bmt31QgBql+gkJsQX6x/Y9jTFJR5Emx/ynDl4Z/2J12ywxnMDBOdIzHtm?=
 =?iso-8859-1?Q?K3edLyfHFg8zciok2VVBOjVzKnV4VCKnlR04bAciDKXnKb3NwU4qSqwUCm?=
 =?iso-8859-1?Q?8D/XDveqJIstGLWLctFZnHena67TB1cmkFWqrsPmM4evXVO1O0egCTzJ4I?=
 =?iso-8859-1?Q?7WJrX/6F6SXjire23LfNWJu2JFd9ZU5xidobiE6MH0NF1TLeIB8JYYuBrP?=
 =?iso-8859-1?Q?9wso31vsgbzv2qgWjtsOW/l6kssz8aDYJiGA/42me4J7hezWNFCGXUm+cn?=
 =?iso-8859-1?Q?PDnDvbCAvpR++WI2JJ5sqgLiZDBZToHTcGS4gQ3p7BrwfHS2IAc5OzuFs3?=
 =?iso-8859-1?Q?g1q5H03AIC/OkugoT3x/8KV0af4EHu9VI9xBw0AUuZjO+zVygzHLUzYozw?=
 =?iso-8859-1?Q?7hpMOoStMutqI1S6DwyyRGS0wCvaOe9sDFh/781eHfo0kWxwDpptmJCiVc?=
 =?iso-8859-1?Q?vbnpIEUHrMBCHAVNpf2xaZyyXWIUxbJn2SgxpQvVlCUTM+Q444O+wxbdHd?=
 =?iso-8859-1?Q?M/TWBvELYgCWFKEbT3FK4wlAcsQWm3aWjwqBWeiOwXd95KWekBVr/LOOXY?=
 =?iso-8859-1?Q?17MSoTpJsIgE/nJ+IPQMuC+bdoSPjyz5HGmJ6cfvsgMbnkCuYNJYxKmeId?=
 =?iso-8859-1?Q?LM+1xHEIkA/b12uW8JYn6nxk3J+cRi4hNr7JUszy4QBaYha49cq9LZYDF0?=
 =?iso-8859-1?Q?r4nYkpeIrTYHrLNPMpswm/h1fyucFCPYRSQa0M5ZLWfS0vkRs/h/QjR+cJ?=
 =?iso-8859-1?Q?fRhK1nEv+V/8GweVZRi12w+HNCb2/3UpaGpqNzXC2yYZFeyJJ+S3mO+V0e?=
 =?iso-8859-1?Q?MEtxxVXl7svDw9e1x5YX2YelYn4Zyv3l8BoC7q2FuFdg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ITNtg14BnlrBnwgywgic3wWc3U++QdpI4UQK+UtTWzSx259ZujbUB1qNzZ?=
 =?iso-8859-1?Q?riCrIcodjZDpbXbTJc6tsVUGtziY/sXvQKDBsIqXCVjxlaOb43WpAYdz0e?=
 =?iso-8859-1?Q?nGv6FdVpWjw+iYhJZqNIh711RyAak75rVGHDpC/QaQdGxEHMPeinpXej0T?=
 =?iso-8859-1?Q?O02Egfe7JBsd7TNXE+85BOWs2FqONCxlWJT840x7ZC8xqKa9iy44WoVeu4?=
 =?iso-8859-1?Q?DHOM7FbpHvlDuW6jYJiMBJ19jT15jiVtHwrseeW/npHWQBEI9am2c04sfL?=
 =?iso-8859-1?Q?+ODmYnIr1c4ya8Y0TYvSk7c93J53xMHXGss8Rn+s+PHDaIEWLehlaGNzZt?=
 =?iso-8859-1?Q?T/Uilg2ROgJN8XWKTAGgDQP5vKXVNT8aO47LAmB9h0fR6Wi0rdZFBBkezF?=
 =?iso-8859-1?Q?k0NBnM+9yYcG0KVE75eT4dkSDwDOpVU5qYJd6r0JsUM1tqXC9GXaxHOIci?=
 =?iso-8859-1?Q?nrLRadCUTWpZSfZH0GHlX4bal7INivyzDVmP0SjuD4GER6oUVBmsFc4F79?=
 =?iso-8859-1?Q?0VW1NQrJsdp0iuYVuSc/CC1S4MPu0vV8Oawox9oGtgpG8QSv+X0Bn/7Xmo?=
 =?iso-8859-1?Q?7xeW8w6qfgFB+8DtnCB1GTM1mH/mwRMqWgFtzICgLbVkZPZ+zUHATqmMaC?=
 =?iso-8859-1?Q?8y40ezymcBH22PZSAjDqs5yXRxM9+gnmmkgtcN2us3EfTtsicnBfrflhw7?=
 =?iso-8859-1?Q?gKC8m8QU9vNAnhzhyoSWJKK3FSGXb0FNq99dW7bswQtGkUbE8AUkaGQ5y9?=
 =?iso-8859-1?Q?kwd38gMX1J2+RMgQuYQAt1XKspQ3f+fMwJT88L9j73OoM1kCJBwzDvifkZ?=
 =?iso-8859-1?Q?zoaeVs+O3D/I53A5pMgDCXldD8ImjOq2iAt1VqqDwjLYdN39isDUkqlywx?=
 =?iso-8859-1?Q?0iZn9ynhl7cioAgOX3o8/dTZxofNZZ/qPOObf4weS7Y1iF7IRN1TPQ2oG+?=
 =?iso-8859-1?Q?gUUHb65boIkTDV0l5KVFAXHZRNEGCFYV1wPoUkJHDuOKIJKF+T2+e1jxb8?=
 =?iso-8859-1?Q?K9J1HgBnPNgnwWxvrJZ+L5TD27dfxHfalbwZK/1/tedPApsfuK6rodU+bu?=
 =?iso-8859-1?Q?18Oe4idUL9E0Z7g2o6SlPxrl3lyJ1ZitG185ysKW5NDmc6MOa9GJJ2nB2f?=
 =?iso-8859-1?Q?wHCluoSIhucuEKjyfv73+lH/+ETD6I9PHT2Y0C6ZhihmfwK0NoA9hQwJDM?=
 =?iso-8859-1?Q?8G0bV/RDj3cF9QdMQeU6xlnLZ9rct7QiTwmuNo5OhATo9HhsPCdlHMFZdx?=
 =?iso-8859-1?Q?u269aLVzUTSKLNJCT2Ax6+kQ0Cgjzl/GcoZBpCfU6VqJt7TRzxglvzEoYM?=
 =?iso-8859-1?Q?caD89b7fi0bgmk5YfYgbsJyKRoVVr7BgKG2ea/c6XH+JVrNLB2k5x1gMzZ?=
 =?iso-8859-1?Q?X9Ero0b8Lg522aiYRp94OPx71XUZaszKoP9J9iSXkubtPf21OmSRYqDEgv?=
 =?iso-8859-1?Q?ckIEfhqKw7McKwy4velQjMef02CECDFa14qJvdHLA7nd04ZPpp5Lkld2qn?=
 =?iso-8859-1?Q?QyfiPauTbOQp8SMfK5TJkFx5z3qCOuVVr4x85W76+UR7Rucy4PgO64IpLG?=
 =?iso-8859-1?Q?P/k2K76mJMmm67r/wFiZy4qjiDiZPhpW7+DeOv3vG2OVO3e33oayep4JJ0?=
 =?iso-8859-1?Q?YmF3WWzwDFAcnSoeaaU2y+gt5B44SkUZ7BrtxJXszif8WyFC5X12khiJTp?=
 =?iso-8859-1?Q?pnITYmh96YWibREfFKI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3cc9f4b-bb64-4000-501b-08de00cfc5fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 09:49:11.2043 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V6bvwLWSVJ0f3UWJG/tn4IxCDhk1aV1i++svtlxEGI7N6LnwF67ZkdYVPA7NCcnXNMgF6ks6t1X1tF9P901wizGdXkK9tDO+QyutK7EsbDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR09MB8279
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

Add mips.ccmov defined by Xmipscmov.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                        |  3 +++
 target/riscv/cpu_cfg.h                    |  5 ++++
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 33 +++++++++++++++++++++++
 target/riscv/meson.build                  |  1 +
 target/riscv/translate.c                  |  3 +++
 target/riscv/xmips.decode                 | 11 ++++++++
 7 files changed, 57 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/xmips.decode

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1a1ea7fe9a..77fbf67776 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -247,6 +247,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1379,6 +1380,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
 };
@@ -3293,6 +3295,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index aa28dc8d7e..2db471ad17 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -36,6 +36,11 @@ static inline bool always_true_p(const RISCVCPUConfig *c=
fg __attribute__((__unus
     return true;
 }
=20
+static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
+{
+    return cfg->ext_xmipscmov;
+}
+
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
 {
     return cfg->ext_xtheadba || cfg->ext_xtheadbb ||
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index e2d116f0df..a290303ee7 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscmov)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
new file mode 100644
index 0000000000..3202fd9cc0
--- /dev/null
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -0,0 +1,33 @@
+/*
+ * RISC-V translation routines for the MIPS extensions (xmips*).
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Reference: MIPS P8700 instructions
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#define REQUIRE_XMIPSCMOV(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscmov) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
+/* Conditional move by MIPS. */
+static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
+{
+    REQUIRE_XMIPSCMOV(ctx);
+
+    TCGv zero, source1, source2, source3;
+    zero =3D tcg_constant_tl(0);
+    source1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    source2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    source3 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+
+    tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[a->rd],
+                       source2, zero, source1, source3);
+
+    return true;
+}
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 25d59ef9f9..3842c7c1a8 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -4,6 +4,7 @@ gen =3D [
   decodetree.process('insn32.decode', extra_args: '--static-decode=3Ddecod=
e_insn32'),
   decodetree.process('xthead.decode', extra_args: '--static-decode=3Ddecod=
e_xthead'),
   decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decod=
e=3Ddecode_XVentanaCodeOps'),
+  decodetree.process('xmips.decode', extra_args: '--static-decode=3Ddecode=
_xmips'),
 ]
=20
 riscv_ss =3D ss.source_set()
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9ddef2d6e2..66d31b67d3 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1194,8 +1194,10 @@ static uint32_t opcode_at(DisasContextBase *dcbase, =
target_ulong pc)
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
 #include "decode-xthead.c.inc"
+#include "decode-xmips.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
 #include "insn_trans/trans_xventanacondops.c.inc"
+#include "insn_trans/trans_xmips.c.inc"
=20
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
@@ -1211,6 +1213,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, t=
arget_ulong pc)
=20
 const RISCVDecoder decoder_table[] =3D {
     { always_true_p, decode_insn32 },
+    { has_xmips_p, decode_xmips},
     { has_xthead_p, decode_xthead},
     { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
 };
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
new file mode 100644
index 0000000000..fadcb78470
--- /dev/null
+++ b/target/riscv/xmips.decode
@@ -0,0 +1,11 @@
+#
+# RISC-V translation routines for the MIPS extension
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Reference: MIPS P8700 instructions
+#            (https://mips.com/products/hardware/p8700/)
+
+ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
--=20
2.34.1

