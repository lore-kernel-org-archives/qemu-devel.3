Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E59CCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 12:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v90AH-0008ED-MI; Wed, 15 Oct 2025 07:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v90AE-0008Ca-SW; Wed, 15 Oct 2025 07:59:30 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v90A6-0007nK-Nj; Wed, 15 Oct 2025 07:59:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t87yTDcN/Pp7wtX36EZAPmf2ciiCWVLJ68/Z93EsGG8qBlZvUDjPwIf5YJ8A4luT/9WC1Fsn0KY4wypRZaTe11M58zjH/iP2BTKiO5xdzfJZDNa1+v8kw5GuizpvyknVPI2RKi66irnl4ffbeuPzYSKEqrUcTKWiuIPxdQH6AR84iotUXnxQICMtFuVpa4Z3Ic32Ssu5YKvwslHh79RkPOIHuQ5fjVj5q2ZRBEdmltch91/2I1DSpqtpSNR9BM+9hihfeCryAoZcWJYOZGaVC4zvTw0BaYrqEK+s4F0l/UrkLp1c3O2q1p5ZGZeRMRE91rgQ4dT7EAroDsNlpzXm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1uJ1nZcMszuOEYS2dgtFT0UIQ3DHUQLHvvIi5VaMoM=;
 b=F1+NL3eFS9eMg5xFwoqNFsbh3uTi9mSy5c+Pb8c+b3horpZcOuLsDoZj80l+CSgXhfLgUlK9hM+LlmeiUJLkVbklN99A4mnotZgxpviD2JjHThZ2IzTxgq3w7DJcWGtPiVu6TkNmp04VkQV1LcaqVw9KQmh+LhxQ/hvaWtc9fpMFslBf68c4dCCdbagp/82Xb5mUwWnjAnaUAfSuAhEjIDX73G/OEts+E21uon1rZfffjWv0a3XOSXGSWb+ZFoRge+O6DQ9LoeUctJoymxPq5g/UZMND7FCL9W/k2nNm7tFaX5Z1Fkk/4MTjybT7Fx9//ziaOruYhyVhEE6lZ4XSzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1uJ1nZcMszuOEYS2dgtFT0UIQ3DHUQLHvvIi5VaMoM=;
 b=Dlh+YhjbZH2bzfdqLSnmAaGjbhHHH+abmocfPlmqccalrve/Bpy7N431C0d3bjYtog2QaLP7QlG0pHHtrO/rPrQA9ZPKdq4e3Bgc+xkOie0y8X885l2htfJdch6aoqAgnWJ3PTT+oX3jJYQunZteJ8K0cb+WYFSrEUzn1pSx+KbRu205MVf53R61ZeHC+m5HlDsDz4Y4HOoixNTbS/7u3cZtxjMwgR0pTKer+m1Wx7wzfswJGW7R8v+yAcmWaZwxaVLgG3ai1disCCpQMCiZJoEqC9duezBdkTTwtHJTvhdtvLA5qNVPUnSYvyZ4XiDemgjYUM0v/2lMcvMpOxycRA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AS1PR09MB5739.eurprd09.prod.outlook.com (2603:10a6:20b:477::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 11:58:20 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 11:58:20 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v11 10/13] hw/riscv: Add support for RISCV CPS
Thread-Topic: [PATCH v11 10/13] hw/riscv: Add support for RISCV CPS
Thread-Index: AQHcPcr+rS1k2hCxDEW8OIdugWM8pQ==
Date: Wed, 15 Oct 2025 11:58:18 +0000
Message-ID: <20251015115743.487361-11-djordje.todorovic@htecgroup.com>
References: <20251015115743.487361-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015115743.487361-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AS1PR09MB5739:EE_
x-ms-office365-filtering-correlation-id: 7a13ae3c-1780-4442-5dc8-08de0be222a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?lFI2pSlyTkT5sOnEcEpHzgOBJ5BWM1LJw0kIooFNaJrDsh/qJL1mZh20x2?=
 =?iso-8859-1?Q?w2qVuKX8qwBAA8ft5C/v47f/nhWjyuNLNnJmCH4UimkWPdrZEhO7gm/j0f?=
 =?iso-8859-1?Q?mljU6s8kJKPPyngf8dyDcB1iBRQv/drQNDsCXu6/+y/oyJTLpdbZudxBZR?=
 =?iso-8859-1?Q?m/z4OgB7h0r7aYpUd9MEs1LCerRiiJQzlcbPPVsGBJKl2kS4lOh8z/rCAl?=
 =?iso-8859-1?Q?2Ja+BT4qKtMNSOQF2gbFVlCPfgITcEaSCRgNG4JwHHRC4cxPpxzCcaeSj4?=
 =?iso-8859-1?Q?qSd3CcmjypVvdwdT3E/tzDvzEIp4WcWfjCoCZAXB8BEOGSvXgSHu09EHCg?=
 =?iso-8859-1?Q?AIrdqihGyRQ7dt/k4TCfQCwXvKnS+AW1r8nAw6Fci04aXYYlOi75/ggWg2?=
 =?iso-8859-1?Q?at223Ac2KksIUgIsH1aPPiKLzXYop27Ml4wxJ8zwWl5WdfWx6ueiOu+dbL?=
 =?iso-8859-1?Q?Xr6xIt/y3MQG85fpNyqn9G9Gv/FZ9e2GwoN0sjHfGR4DPfy75l+EgQ98Q9?=
 =?iso-8859-1?Q?mVC8lcsgALq8ajuwFaIBGt52ghfzjakLlCeq+pATQ7GiAW+uqls+DlbBGU?=
 =?iso-8859-1?Q?DnqflnkP90klrS+v7/a4BlJcZ6UlDIgqk/kU0rCFcT7NB789PEwIPlwB2r?=
 =?iso-8859-1?Q?5kcEFtTDHxaEydwQDzA6nQGguzkFJlXHe7hKhwgE5mVfT5ZVlfuWkHnpKH?=
 =?iso-8859-1?Q?v+8n9QP5Ye3Da6AUhEM0P4fo1RHq7+KplJgv14ZJTdsherNMP61Gfu9an5?=
 =?iso-8859-1?Q?3esg5FRVUeWi7CS3yrdimQhb0D3zXjfdDdG3K5gr82uwISomecQPEeBXlZ?=
 =?iso-8859-1?Q?1QtpUb299OVI3vBgC/oAxRQ1rXISx+/HE3HFmoJKEjAC4ZyefFcZJO5Pt6?=
 =?iso-8859-1?Q?PBAizfmmfnMFhswjvd2YMWZkDw6m/Ewz2hn6/rd4HLK+escR/B8ZD8t4zZ?=
 =?iso-8859-1?Q?jT/pUJZFOYTA1OBo+JhWitsKWbkWVGzLs3eYRQ1jJJPyEykyltObmfJNEN?=
 =?iso-8859-1?Q?JPXi1qbRm7AP6FdF1x45vF3N4z8j2/M1qGPDjZD49mbsUuWSASb4RUWs/f?=
 =?iso-8859-1?Q?2WMzcJ3bEcBgcwaZocHHACT9IpTC5SyvN+iHiqvfTjhi+MOzmqCVg7gf9T?=
 =?iso-8859-1?Q?jJhXtJWeI+1sGhYfcrqKxHis/90/vLzY3jjMQXWh2dRtLkmOH/lymIz7Wt?=
 =?iso-8859-1?Q?zBT/YmsyEo3VXa58c0OpFNNlnclQYN7OAZZhncNfOVaAns2hDgVifkyCvH?=
 =?iso-8859-1?Q?wwGGykJ+6h2KqtvN+pY76xRb8iCm/3kC9vcwCIKH8M+2o++ar7WYcAS7Yz?=
 =?iso-8859-1?Q?Lym9KZXwLqXBKdyo5yjsj6PVLbf6+VomrMn1ZQ0m5BPRB5bCXdE/d23+oW?=
 =?iso-8859-1?Q?8BeG/TQW9uH/A49rNkOeH5e0rVxAbuQtdSj0nXZnpoSuPvINBIagd0KoVy?=
 =?iso-8859-1?Q?tmWnPcld1zchtgl/bPU0Si3aRp13I6KPoBCSFSmPpXb2agCahw0PL7i3bL?=
 =?iso-8859-1?Q?LoQG2NMXmsmUXG38tl1XkE7JwjQTAeqXhew1IGOE+a7TvklAIOVafi89XR?=
 =?iso-8859-1?Q?K5bDmOHkBJiv2FI7NSHP2V6mzFMd?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cX+yDXNxmYRe0MVU1a55Bq/GOIbCDbN0IcHUmUuPrqFt9ZeFuGWihff8OJ?=
 =?iso-8859-1?Q?srWQSOL7CUG1pcADqX/k8tLrvYzivAveIeS+5t6LOB9hpH+HaPW3H9gWCR?=
 =?iso-8859-1?Q?3jPGqrB71NLdLsgBhfM/qiK52XCR/sC8TQUdKwpgWApopISZdCSAY7e5fk?=
 =?iso-8859-1?Q?WbCgE1P/4r60uVxc64ZHBZ43bYUvanqWjK4wZniiP66OIXxCYn3hJ6Wv6J?=
 =?iso-8859-1?Q?AMWloBDoE6DvoINhW8wTS/SZz/1hpCVkjq6r1WnTTgpHAtqCzvA7otvGj6?=
 =?iso-8859-1?Q?yg4JP4RRObvV/+6y+PUGWeYZaDJ7fQPY0Gh6DzyT4bWcCoJeabpOb7hTKM?=
 =?iso-8859-1?Q?4NtGK1nKC/d1NrXdkVjYLM0KhSDaP7ztW18vb1Csi6xt1JnjCdtT4CiPCC?=
 =?iso-8859-1?Q?+7GT+S/l2Migav3nVKvg6BKmYnp9mU7Knj5C1Sf+plwm74akSmyBuWZE+Y?=
 =?iso-8859-1?Q?NLTeMJnSuDfASuJeAehokylU7l91mIr+UetnCFCvfhLnv+0g0Gfuu2/p/F?=
 =?iso-8859-1?Q?aznn6Sp9CuJEDtB5Vi2ufg+L48jMKOAyS3Yd5qzgsmM3YRwD5XtEwA9sx/?=
 =?iso-8859-1?Q?LToLynWqUlZsiUyOidhYFeD7GP6WqBRhiqI8e8v1Zhv1YFEI3TkKs65Uod?=
 =?iso-8859-1?Q?TkM3n6HVJal6vX0ct8MZ1+bqDR833wf4lAzb5fPZ+r016AqM3CfZvQNDWG?=
 =?iso-8859-1?Q?8OQPpjDgq6oJ0qZpYbc0HMi6A5LQaPz87S0ZlbJYR6/LgjIiA8oIPaDs4b?=
 =?iso-8859-1?Q?QJQpdcPfebo3617Quz9+wgRGX09K8BO+T5vEyC+oe5mfgWarG+6tpiqC0S?=
 =?iso-8859-1?Q?vSBHNxME4v7wuxuPQmUJ2ZPX3qsGB+tRBS4PPGoo/gGBghlxyOg4VuH7Le?=
 =?iso-8859-1?Q?adTMHZI3ivrPius7kyrrEV/7hbjQSrsw6+1XYChUnT0d5QiYMRJBJo+MUy?=
 =?iso-8859-1?Q?Xmwq+KGXWFkut6Fq7NNGWH0WOOeqRw9e/19fID33FgZDo3k2T3iA7TlYQH?=
 =?iso-8859-1?Q?3bxlli2/RXqVDPasboIU0mJxd2DCvCRRcitN1inSxp0vDBeqXmlx4JajO7?=
 =?iso-8859-1?Q?sGHWwfLzpqHlxDubg7uhQHdn5rt8O0ud4ZvT47Nj+wuzq0DMUQFJTOp3r/?=
 =?iso-8859-1?Q?+miXshEHYCtHuWyF7RELM0CvukIcrlbRmDiHSeYrGlLzWMe+PaqwJA4EeS?=
 =?iso-8859-1?Q?dIMwAp/U1/K1rEXxEcW94GrGUQL5RdZAMlESAtbQGmSxnc/aqMUrHuxyp5?=
 =?iso-8859-1?Q?qalXZVkxgW5YjdbdcXv9gEGRTjq8DaHdCczRSDH9GQ0wkJFM1XPM+6zWZN?=
 =?iso-8859-1?Q?T2mbJpQ3pL4FObCqEt0Ryb583ZqnVV/bCPxNUHtLlMF6e1xIdg9ARgoG24?=
 =?iso-8859-1?Q?1SPBVjZPyZ3DlJ+urmPyKnxZXiOHxWPg8QuKsu9L2R2h+nzZO+xC791tD0?=
 =?iso-8859-1?Q?QQuT6/1wTWp+nRe0bXrCWjTldKEAsrYde4W1knOkaZQyo9WljUR2ioEssK?=
 =?iso-8859-1?Q?blbrGsqeW9DSahMxd1dZIuSFVkotDBbm93BQGjnbaIWeGcMy8eegoEDvpp?=
 =?iso-8859-1?Q?QwfuOwSIudgr9oAKomIoS/E/ig9sVoIPGyKay3ssl0QoM0bj+nuCneUZDA?=
 =?iso-8859-1?Q?jishQVPnXqfdx6yjMFvnGajjiCBVl1GfyM/GBcPJi/KkF1/nzLEAfJKN8I?=
 =?iso-8859-1?Q?cseFMtDVTQfw1FIU/uc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a13ae3c-1780-4442-5dc8-08de0be222a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 11:58:18.5523 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2gPytqf9YNi3wd6e1BA7e+Ud5j3PQOEtph52o5O93syQ8EGR1RvpxUUmjZrtxLoY2AyOeAYefG/QAgRv3LzdIQpVmZzOU2dbR1MFJ6PvqMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR09MB5739
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

Add support for the Coherent Processing System for RISC-V.
This enables SMP support for RISC-V boards that require
cache-coherent multiprocessor systems.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/misc/Kconfig        |   4 +
 hw/riscv/cps.c         | 196 +++++++++++++++++++++++++++++++++++++++++
 hw/riscv/meson.build   |   2 +
 include/hw/riscv/cps.h |  66 ++++++++++++++
 4 files changed, 268 insertions(+)
 create mode 100644 hw/riscv/cps.c
 create mode 100644 include/hw/riscv/cps.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 2b308ec9b0..a2726abccc 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -127,12 +127,16 @@ config RISCV_MIPS_CMGCR
 config RISCV_MIPS_CPC
     bool
=20
+config RISCV_MIPS_CPS
+    bool
+
 config MIPS_BOSTON_AIA
     bool
     default y
     depends on RISCV64
     select RISCV_MIPS_CMGCR
     select RISCV_MIPS_CPC
+    select RISCV_MIPS_CPS
=20
 config MPS2_FPGAIO
     bool
diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
new file mode 100644
index 0000000000..8642d87fbc
--- /dev/null
+++ b/hw/riscv/cps.c
@@ -0,0 +1,196 @@
+/*
+ * Coherent Processing System emulation.
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "hw/riscv/cps.h"
+#include "hw/qdev-properties.h"
+#include "system/reset.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/intc/riscv_aplic.h"
+#include "hw/intc/riscv_imsic.h"
+#include "hw/pci/msi.h"
+
+static void riscv_cps_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVCPSState *s =3D RISCV_CPS(obj);
+
+    /*
+     * Cover entire address space as there do not seem to be any
+     * constraints for the base address of CPC .
+     */
+    memory_region_init(&s->container, obj, "mips-cps-container", UINT64_MA=
X);
+    sysbus_init_mmio(sbd, &s->container);
+}
+
+static void main_cpu_reset(void *opaque)
+{
+    CPUState *cs =3D opaque;
+
+    cpu_reset(cs);
+}
+
+static void riscv_cps_realize(DeviceState *dev, Error **errp)
+{
+    RISCVCPSState *s =3D RISCV_CPS(dev);
+    RISCVCPU *cpu;
+    int i;
+
+    /* Validate num_vp */
+    if (s->num_vp =3D=3D 0) {
+        error_setg(errp, "num-vp must be at least 1");
+        return;
+    }
+    if (s->num_vp > MAX_HARTS) {
+        error_setg(errp, "num-vp cannot exceed %d", MAX_HARTS);
+        return;
+    }
+
+    /* Allocate CPU array */
+    s->cpus =3D g_new0(CPUState *, s->num_vp);
+
+    /* Set up cpu_index and mhartid for avaiable CPUs. */
+    int harts_in_cluster =3D s->num_hart * s->num_core;
+    int num_of_clusters =3D s->num_vp / harts_in_cluster;
+    for (i =3D 0; i < s->num_vp; i++) {
+        cpu =3D RISCV_CPU(object_new(s->cpu_type));
+
+        /* All VPs are halted on reset. Leave powering up to CPC. */
+        object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
+                                 &error_abort);
+
+        if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
+            return;
+        }
+
+        /* Store CPU in array */
+        s->cpus[i] =3D CPU(cpu);
+
+        /* Set up mhartid */
+        int cluster_id =3D i / harts_in_cluster;
+        int hart_id =3D (i % harts_in_cluster) % s->num_hart;
+        int core_id =3D (i % harts_in_cluster) / s->num_hart;
+        int mhartid =3D (cluster_id << MHARTID_CLUSTER_SHIFT) +
+                      (core_id << MHARTID_CORE_SHIFT) +
+                      (hart_id << MHARTID_HART_SHIFT);
+        cpu->env.mhartid =3D mhartid;
+        qemu_register_reset(main_cpu_reset, s->cpus[i]);
+    }
+
+    /* Cluster Power Controller */
+    object_initialize_child(OBJECT(dev), "cpc", &s->cpc, TYPE_RISCV_CPC);
+    object_property_set_uint(OBJECT(&s->cpc), "cluster-id", 0,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->cpc), "num-vp", s->num_vp,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->cpc), "num-hart", s->num_hart,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->cpc), "num-core", s->num_core,
+                            &error_abort);
+
+    /* Pass CPUs to CPC using link properties */
+    for (i =3D 0; i < s->num_vp; i++) {
+        char *propname =3D g_strdup_printf("cpu[%d]", i);
+        object_property_set_link(OBJECT(&s->cpc), propname,
+                                OBJECT(s->cpus[i]), &error_abort);
+        g_free(propname);
+    }
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpc), errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(&s->container, 0,
+                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cpc)=
, 0));
+
+    /* Global Configuration Registers */
+    object_initialize_child(OBJECT(dev), "gcr", &s->gcr, TYPE_RISCV_GCR);
+    object_property_set_uint(OBJECT(&s->gcr), "cluster-id", 0,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->gcr), "num-vp", s->num_vp,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->gcr), "gcr-rev", 0xa00,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->gcr), "gcr-base", s->gcr_base,
+                            &error_abort);
+    object_property_set_link(OBJECT(&s->gcr), "cpc", OBJECT(&s->cpc.mr),
+                             &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gcr), errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(&s->container, s->gcr_base,
+                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gcr)=
, 0));
+
+    for (i =3D 0; i < num_of_clusters; i++) {
+        uint64_t cm_base =3D GLOBAL_CM_BASE + (CM_SIZE * i);
+        uint32_t hartid_base =3D i << MHARTID_CLUSTER_SHIFT;
+        s->aplic =3D riscv_aplic_create(cm_base + AIA_PLIC_M_OFFSET,
+                                      AIA_PLIC_M_SIZE,
+                                      hartid_base, /* hartid_base */
+                                      MAX_HARTS, /* num_harts */
+                                      APLIC_NUM_SOURCES,
+                                      APLIC_NUM_PRIO_BITS,
+                                      false, true, NULL);
+        riscv_aplic_create(cm_base + AIA_PLIC_S_OFFSET,
+                           AIA_PLIC_S_SIZE,
+                           hartid_base, /* hartid_base */
+                           MAX_HARTS, /* num_harts */
+                           APLIC_NUM_SOURCES,
+                           APLIC_NUM_PRIO_BITS,
+                           false, false, s->aplic);
+        /* PLIC changes msi_nonbroken to ture. We revert the change. */
+        msi_nonbroken =3D false;
+        riscv_aclint_swi_create(cm_base + AIA_CLINT_OFFSET,
+                                hartid_base, MAX_HARTS, false);
+        riscv_aclint_mtimer_create(cm_base + AIA_CLINT_OFFSET +
+                                   RISCV_ACLINT_SWI_SIZE,
+                                   RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
+                                   hartid_base,
+                                   MAX_HARTS,
+                                   RISCV_ACLINT_DEFAULT_MTIMECMP,
+                                   RISCV_ACLINT_DEFAULT_MTIME,
+                                   RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, fal=
se);
+    }
+}
+
+static const Property riscv_cps_properties[] =3D {
+    DEFINE_PROP_UINT32("num-vp", RISCVCPSState, num_vp, 1),
+    DEFINE_PROP_UINT32("num-hart", RISCVCPSState, num_hart, 1),
+    DEFINE_PROP_UINT32("num-core", RISCVCPSState, num_core, 1),
+    DEFINE_PROP_UINT64("gcr-base", RISCVCPSState, gcr_base, GCR_BASE_ADDR)=
,
+    DEFINE_PROP_STRING("cpu-type", RISCVCPSState, cpu_type),
+};
+
+static void riscv_cps_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D riscv_cps_realize;
+    device_class_set_props(dc, riscv_cps_properties);
+}
+
+static const TypeInfo riscv_cps_info =3D {
+    .name =3D TYPE_RISCV_CPS,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVCPSState),
+    .instance_init =3D riscv_cps_init,
+    .class_init =3D riscv_cps_class_init,
+};
+
+static void riscv_cps_register_types(void)
+{
+    type_register_static(&riscv_cps_info);
+}
+
+type_init(riscv_cps_register_types)
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 2a8d5b136c..9023b80087 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -15,4 +15,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-gen=
eric.c'))
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan=
_kmh.c'))
=20
+riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
+
 hw_arch +=3D {'riscv': riscv_ss}
diff --git a/include/hw/riscv/cps.h b/include/hw/riscv/cps.h
new file mode 100644
index 0000000000..00f17112c1
--- /dev/null
+++ b/include/hw/riscv/cps.h
@@ -0,0 +1,66 @@
+/*
+ * Coherent Processing System emulation.
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef RISCV_CPS_H
+#define RISCV_CPS_H
+
+#include "hw/sysbus.h"
+#include "hw/misc/riscv_cmgcr.h"
+#include "hw/misc/riscv_cpc.h"
+#include "target/riscv/cpu.h"
+#include "qom/object.h"
+
+#define TYPE_RISCV_CPS "riscv-cps"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPSState, RISCV_CPS)
+
+/* The model supports up to 64 harts. */
+#define MAX_HARTS 64
+
+/* The global CM base for the boston-aia model. */
+#define GLOBAL_CM_BASE 0x16100000
+/* The CM block is 512 KiB. */
+#define CM_SIZE (1 << 19)
+
+/*
+ * The mhartid bits has cluster at bit 16, core at bit 4, and hart at
+ * bit 0.
+ */
+
+#define MHARTID_CLUSTER_SHIFT 16
+#define MHARTID_CORE_SHIFT 4
+#define MHARTID_HART_SHIFT 0
+
+#define APLIC_NUM_SOURCES 0x35 /* Arbitray maximum number of interrupts. *=
/
+#define APLIC_NUM_PRIO_BITS 3
+#define AIA_PLIC_M_OFFSET 0x40000
+#define AIA_PLIC_M_SIZE 0x8000
+#define AIA_PLIC_S_OFFSET 0x60000
+#define AIA_PLIC_S_SIZE 0x8000
+#define AIA_CLINT_OFFSET 0x50000
+
+typedef struct RISCVCPSState {
+    SysBusDevice parent_obj;
+
+    uint32_t num_vp;
+    uint32_t num_hart;
+    uint32_t num_core;
+    uint64_t gcr_base;
+    char *cpu_type;
+
+    MemoryRegion container;
+    RISCVGCRState gcr;
+    RISCVCPCState cpc;
+
+    DeviceState *aplic;
+    CPUState **cpus;
+} RISCVCPSState;
+
+#endif
--=20
2.34.1

