Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC64CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91E7-000387-FT; Wed, 15 Oct 2025 09:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91E0-000345-4P; Wed, 15 Oct 2025 09:07:30 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91Dr-0000nK-7o; Wed, 15 Oct 2025 09:07:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eno/p67GNLImj5JAbzlIShZmAMDg1kM+tzU1vFg/desCEbjrmwHklDdozDFeb/e2YDKen2n/18ADAwrT3kESrzl/KBi+uj4l7nn8TbFNx+J9IuXTQFObvrZl4eMkmVzgMg9/iKLT5MAWZN1IeT0XSQoKQYgrUGkRTppDj9/uhsuMmX//kVz2Oc5mMHrWSeazgO/yn6KZ47blib67D8nzELcDLM2P8nx//PbICKS1rCNFxx0VG3T/NWA9Z/6W5J5gH3z7zM6wg3hwA8ujarMgd1jYkUC6AsDqfjJKNBg66D25hgRJNOwL2jFqlyE+w/NGqGK/Ht4jMD0tiiUuLUK6nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4KBazVfEid2gaSPREfx/zq16YcEM1woDFNWp9mRo40=;
 b=BmVyr1qV1Se3BChneCBJIXOYoEDl7ovlpvmC7+WoYHP8kx+KBjepRTDGFKu1MutSOJqaX2Ygot4MYU/WtpYg0WITL73JNW2eziCRh0oj8OxIKa9yKJkgpMjN0Aspq2D4OjhlVfm//jHCtIqNqohs+30nAaYP52/7OXPlAQUSM4vlHNCSlKtDOc/lb7IjKtGliAcRe/xWaD7W/DUwbTBAHqH3/aCjjVlrwPLx2zgUxu9MHuAvD4k1W3LwrDZOgsUxquGuVzvdIHSMAMtAii2RDe96yZdocM8BU9LEM5QNOo+7M9kwuu1cB7yQR45vi29ZSLUz6Tn/72SfkD2DyHLFWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4KBazVfEid2gaSPREfx/zq16YcEM1woDFNWp9mRo40=;
 b=p9El+x3sDf7FAPu0wrZl1xeB7VfMKwk02O9R+noZ9OX8FGXVABM+znc28SGUrGLFp/EaYwLbe1iJ5jn4i4HrI1n2cxrHG30bMiMGmZCXOpqFgBwQ511iG1EgGy9KBuGWWpYDpgR16G3F+mvpT+vPfgX1zjUzZqTLvVloxH+Vcssl9NT1anB/a3+d19Z7rHVtcl90kvNxNsa3Z2jvNXGRX1jRq+l2ERcvYFgeTlZbxWeRGigfNmopW2tfh6jk1WPlkmOXpXPxvhNuXpHO3jseHoC/HHRnkKiMRjXWL7g9FdsYmgaVXQr5d0tRkotFjePTC9m+urMCupX/ug2RKZljhw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB9PR09MB6057.eurprd09.prod.outlook.com (2603:10a6:10:3da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 13:07:04 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 13:07:04 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v12 03/13] target/riscv: Add MIPS P8700 CPU
Thread-Topic: [PATCH v12 03/13] target/riscv: Add MIPS P8700 CPU
Thread-Index: AQHcPdSaEqxrLtSU2UeV3jE6zTM7Gw==
Date: Wed, 15 Oct 2025 13:07:04 +0000
Message-ID: <20251015130657.571756-4-djordje.todorovic@htecgroup.com>
References: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB9PR09MB6057:EE_
x-ms-office365-filtering-correlation-id: 53a3a26b-5b1f-4efe-7a6f-08de0bebbcaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?K2cmRLwIrJdS90RIeuezw+p4yG/0n7hIoZ/+w2gvLZ31JyymkGQ3SJDonm?=
 =?iso-8859-1?Q?igRTSQ4RzB4s86+47DMo5qW4WbTb2K1yV+zpB8aPdW0W4WadFL2MDwqU6D?=
 =?iso-8859-1?Q?IIl6vxdJ5b9HlQC66nWuHnCOaIAWPoy3DOh0LbT8sKGdq3E7srP756OEcK?=
 =?iso-8859-1?Q?R4ff8szK4OFGKEFCDjjLjp/TKHP1quirH9KfajB73hWbboN2Ji9hMWqSln?=
 =?iso-8859-1?Q?pCmuJoq5yLeZTZ6+pWNS0vu79bcx6smgS8nFOXT5/6IZitEJJbE+iETnR/?=
 =?iso-8859-1?Q?2UIILT2SZA4lBXRTXOyp8gqnvzz4WEL5HVjl/XhzNWJuO7keRtZtwoEB19?=
 =?iso-8859-1?Q?8YKVJ9xyE+o3ykqnXeImDVRT/ICr9oAcS5wmhEtpAd3748btgOzLong2s/?=
 =?iso-8859-1?Q?I4+fmmIc2Vo6tVA+u2ZI2EO1BxHM4zOphbMa9ZCawz0mP3wqKJG9r6pCg0?=
 =?iso-8859-1?Q?rPlkfapwxojjghUWLjysxlllryRrycs2xz8ZmHP90sHJ2tRZkBF6+FjFnL?=
 =?iso-8859-1?Q?qbLamFQlnEBQB3JATAImq5Hb9aMbnOv1FAv9EZ9xkD+JM1a6jgeg/iqEAY?=
 =?iso-8859-1?Q?H6rpM4abvlMFX3HbgGFyKciLOJPccvhl40f45fYfZx7XDmY070vEOm1ien?=
 =?iso-8859-1?Q?L58fbhs8ZjB3Xi8xTZbPWPnKmAXidfXRPysd9GWts1rmiuK5RQkeiz5MS0?=
 =?iso-8859-1?Q?GCZVvSra6dHIiYe0KSuKytZmoU4BjNizhUxxx3b328KQ2vsCainKdLWHL3?=
 =?iso-8859-1?Q?6dpwykwWHw1hztS1GBOEnMAQxDNp/+puCSqxtjpClrEan/NukXmXSmEpc+?=
 =?iso-8859-1?Q?YbMdcUoDcuI78Y4RgToUVB1gzeGIHUrPMpH4KIehqRy+yit6yFfuhyAYGr?=
 =?iso-8859-1?Q?WajtPg2C7heu2I4iQ7r0uqbKlt+wp3wJcqJc90wrNJb5uSJy3Elcm8WaDc?=
 =?iso-8859-1?Q?5o5VmvOgcatNvgRR3LMivZm1o5EpaCoP+55v13jLCSNL04Kdvx9VLtwARF?=
 =?iso-8859-1?Q?tv+47vmLQVy+8Fve7TvuR3f0E80qAM8y70ArwxWZvYjgts2pyNmMOTm5v6?=
 =?iso-8859-1?Q?ofhNm/NJ5zDYVT3LtFMiZgQTgAchtsyaJnCRf+yBLwhFqeZKl4XLyw7Oi2?=
 =?iso-8859-1?Q?Ps3QCCxYBPv4HjvPKl3NtIKIDdYCItNmoguVH+r01l1hpS9/ERCBcfCJ+T?=
 =?iso-8859-1?Q?dBrfr6NlcgC+sN2phtiAQ7n/LYjd4B9NJ9YEm00Qc6vSk8SpavbuG/RmlW?=
 =?iso-8859-1?Q?NLccvTYYJDYkXEgv2GtvJ1FJocOr5hEDS336XlOgK9S1VZfureH/AekIRz?=
 =?iso-8859-1?Q?ymtU5Xml+mMGDxP3hHW/hkVqFxoz3sKyu9gC18stBkzAsy4ZhHCaKRoULE?=
 =?iso-8859-1?Q?8cNND70kHqyEmmiaIgjH56L7d48NRUZ7OlysJhV9ce8QoHV2EOhru0mKoA?=
 =?iso-8859-1?Q?j4w5+h7B1zeED5TN8DBxak41otDExImoBchpTkc5V/nImWtx1OQAo4ivy0?=
 =?iso-8859-1?Q?UAN+aShowI3KBMMp3HafPJsPs7IoSWdfULkIislWb/1c/SeQN9pId0lHu8?=
 =?iso-8859-1?Q?b/w7DKt5dei+kS4VHtZ+TXhgdrtc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?W+Z/jepnSvjKKcKnJgCSa4ygcdLuc+Q11C/sHWFtciGuqOwlNYXQB5dXei?=
 =?iso-8859-1?Q?W8qhBsHYSPFZlpKba19bvKlTNYVADC5SlKOBb55RoYb4Scr0JC6Qn9NzP8?=
 =?iso-8859-1?Q?2wXTF3Tl+MS0ELhcZa+7kI2si9uSVclGbowfU5b6NR77Lx3QJMagDE1tnl?=
 =?iso-8859-1?Q?CRfKvQ2aGEAugo/3TyqD71iqXjn8mpugnQv05WIed1i0lLNshYcnXBjpvJ?=
 =?iso-8859-1?Q?K7PCjcl7OFNoFywOWk9mPRxdL87EKNZHPTc41WLOY+PEG6BI6VQnCTPOnz?=
 =?iso-8859-1?Q?FMMjv2SusqpxSDO6fTwrfdrSYNnqahb0LoPVvY1fQhzUdUXKybUJkNCN7/?=
 =?iso-8859-1?Q?TgyGWRXwIJ6GrTYfDNLE+C6wcnL0WAn4anpFGOVKltUL2Ax+D0ae7ELKty?=
 =?iso-8859-1?Q?VJHrLWYurlFbUGObbxBNl11XPmKwAQK/dCIOrn4GLya+m3pXvKtND8nohD?=
 =?iso-8859-1?Q?Iu3w2TO0EjMWH5MVLs+T8fiRT1f6+A0CzOyovgdTxNGtWp6clN9sc/TK8o?=
 =?iso-8859-1?Q?nema3N3D4ZsCj5L+ZBhlZ2KaQwEsp1NEsyHikkV5c9d4+Gs8gw+l5N4YDN?=
 =?iso-8859-1?Q?5KzQ6EZQPAPYF0yyyfNjkBlXuIlPyJOj0+TaDmK+Ao5Ycn9ugwvZrARPif?=
 =?iso-8859-1?Q?F8bCxn/gfpyNy5jxw3xqQJNLDZpkTA8M+EjOWIFv28GOxZhQepVvwAbVRy?=
 =?iso-8859-1?Q?rd8QeQ4g4tSN9eCaBIZ7tj8ikh3HIIjQQODPHOksL0H+jvMF5ii2Eaxkuk?=
 =?iso-8859-1?Q?pUqM7/shjIJVk9bfeitrnWwYr9H+3FfDpHFyztaunY7fmH3NjhMWORz6zr?=
 =?iso-8859-1?Q?ANnQ+AQqWJezcTvD5ycEe7+CNU6pGkROBX5MCk9sxXvOBeCnedDq+7CWyF?=
 =?iso-8859-1?Q?9W+9cRX+sJCPtSEqngRXOeZyl+3Ae7zRqIGPSfKdDcu4CW413rQtMlXCvy?=
 =?iso-8859-1?Q?Mdbxjby8Y8AqUzas0cuKBvWDHfzBHk1gpAexp1d2cyxrHKwb+aZy1Pzx0N?=
 =?iso-8859-1?Q?24Y5kTe2nBpfqVjaSNJdqyzYMvFwZuvokgF7AUwDd+9LgjtwpE8Nkz0tZb?=
 =?iso-8859-1?Q?tk4K87vHRm0RgLMIz4muisc30gLWDk2QxQ9lCR23cSDAe/EhNR2rW3nlch?=
 =?iso-8859-1?Q?is/nRG4X9DTk3Mf5+D7OPoGYOpZglOz/F03o5So8UfXdAEp1PvsvVsxHyw?=
 =?iso-8859-1?Q?Y1wCcLtp30N9mLtIIXkKpnJCZSw+Pb1ojmbKTdnCqxy7UZ9Wr9w2kDZHbz?=
 =?iso-8859-1?Q?pN4uS491IvNPEocOFIvkHe00dDJH6/T+UL+DzxUlTglPmqBrgx1PdtJCDI?=
 =?iso-8859-1?Q?qQ9BzL9rT0860l/epTpdGkKPbn/XgJDUiTH4CHWSq766bZwa7llbvD4B+0?=
 =?iso-8859-1?Q?0RmU2HUF7WoSfiYXlbK8zBZ3LieGVXwBSpZ5UKfYXojj7tNOTa1VuAaZjG?=
 =?iso-8859-1?Q?xqe1dPEDsnuRjY2aLG6yhnfN2AD6vEMT1jvqGOI108UoZpFazQneFBDIcI?=
 =?iso-8859-1?Q?Wz6NT+i4q0nIfE3rtdLIDYvc2Bv8yGOpJQmYe/SgLxlj1NZvbN6MFoQj3F?=
 =?iso-8859-1?Q?s7kOLmcaxSlcoGCVpTt2z4as2IBrNJdkiUNrG4CQcHdLI8QXBQvcX4mR+g?=
 =?iso-8859-1?Q?qeUdbJW5A7ybolQiz/B3uyM6Wf3PoD1ghK1nfN2CUIxddOreM3EdLYwyxD?=
 =?iso-8859-1?Q?Dz3wilVnkMK1a525To0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a3a26b-5b1f-4efe-7a6f-08de0bebbcaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 13:07:04.2745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +fS6OunhBmkHcqWdzZgkIIqBwNLzMbW8P13W62bzzXCMnfRe3BNRAaxf56iXbgIYv8yHwGAxwWYQuMOguPnrvhOaZRMwB1crv4yHrLl9CXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6057
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

Introduce P8700 CPU by MIPS.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu-qom.h      |  1 +
 target/riscv/cpu.c          | 16 ++++++++++++++++
 target/riscv/cpu_vendorid.h |  1 +
 3 files changed, 18 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 75f4e43408..30dcdcfaae 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -56,6 +56,7 @@
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nan=
hu")
 #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kun=
minghu")
+#define TYPE_RISCV_CPU_MIPS_P8700       RISCV_CPU_TYPE_NAME("mips-p8700")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
=20
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7932ba6873..cd4e442bdb 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3283,6 +3283,22 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.max_satp_mode =3D VM_1_10_SV48,
     ),
=20
+    /* https://mips.com/products/hardware/p8700/ */
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max =3D MXL_RV64,
+        .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
+        .priv_spec =3D PRIV_VERSION_1_12_0,
+        .cfg.max_satp_mode =3D VM_1_10_SV48,
+        .cfg.ext_zifencei =3D true,
+        .cfg.ext_zicsr =3D true,
+        .cfg.mmu =3D true,
+        .cfg.pmp =3D true,
+        .cfg.ext_zba =3D true,
+        .cfg.ext_zbb =3D true,
+        .cfg.marchid =3D 0x8000000000000201,
+        .cfg.mvendorid =3D MIPS_VENDOR_ID,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode =3D VM_1_10_SV57,
diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
index 96b6b9c2cb..28f0ce9370 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -2,6 +2,7 @@
 #define TARGET_RISCV_CPU_VENDORID_H
=20
 #define THEAD_VENDOR_ID         0x5b7
+#define MIPS_VENDOR_ID          0x722
=20
 #define VEYRON_V1_MARCHID       0x8000000000010000
 #define VEYRON_V1_MIMPID        0x111
--=20
2.34.1

