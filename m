Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80315C7115D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 12:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRrtd-0006AX-9x; Wed, 18 Jun 2025 08:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRrtb-00069M-HH; Wed, 18 Jun 2025 08:28:03 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRrtZ-0005VS-Tf; Wed, 18 Jun 2025 08:28:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1wbFuxW7PTyEjNGjlJ8+Mp4Tz9WnUBTE6pOcYZyl/Olva4+RB6V6hWI6qGJhySan313H3+o9XSV2EkxYHg9Q5EzcFh5gK0xF6UIbTn5vaOqi3y88W+dIZWcrOYAqe7tvr8P6bbvgtErsOMhmQmnQzbUd6ONrBgvX7eQW9tJQijRqWraZlsVeSQ0dey83x2MevPUtS2Ih90Ik7BSr3wtXliEFNt8GlbxdFWqTPiswMp4olUKdZ126I44ENn2qzUaAj9kwSREm3lGmqHCmmC/773qNgzxSa13vwKNkOdFbyM3Lxf31eUvQWiLx2ukiX3VkQ/Vt0qxM3pa1siv124/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkophoQVRUe/YsDowUs/IlXmuFawOCRlr871HEoTkmI=;
 b=V2z0mkwmUy7qyeNZ2WRsk2gKPkp66GCu9ajst+OKNFigBMgJoB64BiVr6CB6k1A6nqrcPmeekg1U2KfKLslWZPKh7QZBX8/90ZMqRRd2fk73QK9iMNup0WF4AI5UV/I4wtL64pOcrwDRbNvAXRC3PCc/MQ1OM9jSfXLGzOuvfF64QOLPl4pnuside2Lv2u4FefjZ7kGvVNwc4qrcSQny5Nw1aphoRqPZKpg6j0rrvC7PM6MaBqjNe1U3SQUgYiEmOM3tsOk69UJigWJvrJg7ycX23Q/TDYzUBsn3MzSjIkz0Gr3cB7tNuU367MaqW7dvb4wbmFYMh6kmvxSkICSd4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkophoQVRUe/YsDowUs/IlXmuFawOCRlr871HEoTkmI=;
 b=AKq/vBxAmgaDhFeyXX27qdoEfd0TaCUm8lBdaEdhpYZeKJ25h1KhQq2g/t5DUypRe1NGxk6ZJ6Eqrmv0pbzQope4ycY4KQyuoc4zydui7WZgoM1aCjwtdLowiGMSDMuV4Zauy/BPusainwBFm7NVai25PlhduVc4mUPXphIcR3PcjwlcN2Lcmmwhz1MbMWB+R6Tm/O/HsH7Toqx+AY6t2+5uPSLFsE7L19R/0krVRx5nEqJA6ScBAmJZwUk+ujSI1liL/p3LR8stNUCRFaBVQNfyCG0kL0PIo+ePSU9Qsh/47NAxbd5YS5Jpr/A7nJMmk2MGaIdP3oBbYm+G3R/kOA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB3834.eurprd09.prod.outlook.com (2603:10a6:10:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 12:27:50 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 12:27:50 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v3 09/10] hw/pci: Allow explicit function numbers in pci
Thread-Topic: [PATCH v3 09/10] hw/pci: Allow explicit function numbers in pci
Thread-Index: AQHb4Exn3PWobpekj0a5XB+xzUMwmw==
Date: Wed, 18 Jun 2025 12:27:49 +0000
Message-ID: <20250618122715.1929966-10-djordje.todorovic@htecgroup.com>
References: <20250618122715.1929966-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250618122715.1929966-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB8PR09MB3834:EE_
x-ms-office365-filtering-correlation-id: beb1fe30-b449-4aeb-09ab-08ddae638a8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?GAGJnTuvf+/d5fO1wq6XonbX5830/hNqCqkeQLsgUYlFOuen8Knf86Axri?=
 =?iso-8859-1?Q?IA4tVc1B+wT7Ew5uf9vXIdv6tOyC6J0htytZ0YkjFcD7SAKYLAL7KplWjF?=
 =?iso-8859-1?Q?tgsPIhSkLb1j22tt0ju+AKdXUuoDoIKH9bQtUpUYzG/snG+W7DrhhtTOfk?=
 =?iso-8859-1?Q?1/nMvnTR19ewlN2/8nbfF/SgrGkT1CX0usA7HJJMXdrsTRri7XVkvzKa7g?=
 =?iso-8859-1?Q?S4gJya7kfrxXFHBgUi22fifuSorYLqYncm816DF0S71YkF7I5GMhrLs4HO?=
 =?iso-8859-1?Q?LizXJSa0kxZcLRyC3Hi6HN5NgHqU9PX1XetNlU3SpC5ub+Y3uCzFwsRYv2?=
 =?iso-8859-1?Q?/uNUm75aCGcJrC+RToGAyqlh7H3y2kFlI/U1uJEzEOXLPDqV5feGx+bZNp?=
 =?iso-8859-1?Q?GOdVyT/7muRJMSA45GW3LICsQzx88iyUzKJKRmgW0rZaCLWy51sYmmEaN+?=
 =?iso-8859-1?Q?pvitV575Wg7tc6/5YWTjQm+EmAOFN7PtTVIs7O1E0JzZpHWJXodOdw8Aw3?=
 =?iso-8859-1?Q?PJSbA5q8sLYb/JSG3xbILh/hywcpPFaQN/FkIYX3b7RLFYDeCY3/vwMlNX?=
 =?iso-8859-1?Q?80EOTvTeEbPaBSJVMSvylGM3aG5VVDhG7AH6RfhrR9SiQFvDO2KFho9Dpq?=
 =?iso-8859-1?Q?bMmdp9Dx8RbzMF1yhwgX2pLER52FijS/5bI2xHJS3WAuKzyGq2zNOR88FF?=
 =?iso-8859-1?Q?S92tEtawdXPAV7QhC8sv0TBMN00XA5x8OqyCHXinVmqggqKOdBy3zSmBV4?=
 =?iso-8859-1?Q?XVhZT83M8jvpFOvim9/ikFaFOu7Z0bN54OH2ByzJLY7sobUQi0u3/ioggV?=
 =?iso-8859-1?Q?akLTfmpYB7F3VkF594hJrCXG9RF8b9Bwi7k5czu4BKT2tQ0+sDLMTxgnCb?=
 =?iso-8859-1?Q?xNQjlaoLhfcryS980LZTWOl032ZMzphVhwxgRs6okE9eYob3czXNnQ7Yig?=
 =?iso-8859-1?Q?yBA3KQTme/J8K7DKt/Cenb+0d3K1tIP4XDS+AbqU2mr9my3+37T86hfgfn?=
 =?iso-8859-1?Q?Q7sxB0wKFLjbU3nQdbgouYkgyxwibN/yTBCNg0UNJ/5rFMhdeuaMUmfjBq?=
 =?iso-8859-1?Q?hwDp7NWZAKKCSX0cobhgX/Iry3IYUH8n/HYVC3JaU2Tex7GwG89qdS1bj0?=
 =?iso-8859-1?Q?5uKp+27zaEVwWdJ+ucajIeT9X/7Lgp8EkHeUpzyFiI+Gw18OpW7WGRnRdl?=
 =?iso-8859-1?Q?ISHjWUEBG959//uhxNXN6OIqDLkLImyI3w9FhqKZnlPIrM8ZCZDuyAvnLM?=
 =?iso-8859-1?Q?TtqGRb61k45vIgiAZgTFC9fpoj72Zw8H/WSfNY6wFJ6vscr6jOQwqhtmss?=
 =?iso-8859-1?Q?189Mn5knDq19a8oDA5g9c6MQO1oKWRx6lyDhqmvrzw9QYbJd89O9ZG2a1l?=
 =?iso-8859-1?Q?R9CqRcEDg8Hkbi6GQgB0Y0ZO6jWKdNC6ZIrGNn71FsDEit7uy0e1dJ4rup?=
 =?iso-8859-1?Q?6W3W0B/OPXP6Na0a0IiOOAUKOhvAafPrsiLz0QKc3SgYjzTgYxCu34RYdB?=
 =?iso-8859-1?Q?PyQZwMLRLe4QCM0KK9x25cEwkVQeDk3Sv5CHFQ1oZP4A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+S7meYnxagIbZuCthQjMk4OZbxM6DPU51Pl4mUQDjp6yDkePiPMDOI3zTw?=
 =?iso-8859-1?Q?GD254WR69u/jKJRVPmCcP9WBWSa84ch0KrFeZIT0gumn+IN+Tpw1i09ecy?=
 =?iso-8859-1?Q?H3Q8G1vvT/z+kg83h94kmdkNw29L8lnUGV/dJOJ0WJW/eCXlOKa5G076yZ?=
 =?iso-8859-1?Q?M6w3zhUXII4T4HGyXFzraptv31Lm/1vXGEE5kMvfVigQFhRzHdVQzCqOpY?=
 =?iso-8859-1?Q?Bd/Rb9RMf2OAWbubCNVdtvuIV4HuVk9f3CN2ebkaaua0yZt0lgvMbaAdLT?=
 =?iso-8859-1?Q?KWl5s7+brwaocpX6L2gmhhDZSKzQaevJpW2J3gMxbJYXHVXWY3FtkLI18E?=
 =?iso-8859-1?Q?jM00YsonPlU2OpxsMeUO/BKU1qByc7jM0uAORiUM30GT1kBdcPF6AdQghp?=
 =?iso-8859-1?Q?qGQBWC6M7nYXIn3wGbKE5cGCFWrGaylhETgjqz2bxJwWRhtkAOggAL4Bh6?=
 =?iso-8859-1?Q?XolKRF4h3thA9KLPm4azSfnEZWnAaqM+UyY5tZtM38QwUXU4MwIWzPFQmD?=
 =?iso-8859-1?Q?vIQ3whJmqkYW9nc4s6vki1CPCfWB/6dhYjuiK4lkqsvmz+yFy2xmP4V6JV?=
 =?iso-8859-1?Q?n87xWE/8JpMW/HFAc5sQh5We25p4hai1eFLtbNfJNnwSbzLf04nbTOkZGc?=
 =?iso-8859-1?Q?XKkj2V2Rdzz6urHwpncFLA78WWtIVb24fXfAMKqFxo7hRzIsZNQqj5+rFO?=
 =?iso-8859-1?Q?zdvCjPwoYuDXZVwIXZcCXQjG1d9JgHKDksdQcu7mm1k9ZeTEK9+EuD8opx?=
 =?iso-8859-1?Q?HozSSfcEhJbq6YYr2v9fWvxGxwApply7v9/i9zyctW7k8xkBGAHNzuLosX?=
 =?iso-8859-1?Q?Fdo9YMWi63forkCQkUyYqP0UJAjIRBLG36M4N7kAVxpRFDOXXn/n/WxdSg?=
 =?iso-8859-1?Q?jfv5FEL+2nnJzUENsfAhnKRMu4i/FfFVjrp+VuaO4qzqi609Ug+MDjAfJi?=
 =?iso-8859-1?Q?ghowi5SQfyHM+LiUTkss2by1Gs4rq+lvXAWHSPOc/XzyxtozYFjI4J90X7?=
 =?iso-8859-1?Q?Hs1PzSlXgoaIZbqGQ1keqWTfjKMx5VK38+izBP7HWLg6eeaEp4OzFPij5E?=
 =?iso-8859-1?Q?wtM4wKsloQc8QbtLI0keaZR9s2aj6avi2lZV33fCZY0rW0pbuQE/keaMuV?=
 =?iso-8859-1?Q?ebQVpYODbK9ALc2GW2+R9zMVoQvBJR+XgAoPe/T1OgZ7Io3gbf+5sWUwTf?=
 =?iso-8859-1?Q?oeuOHcGixVFz/OXoZeBPsLTk0a1FsDac5Z28xT1uzh1qvIiA3L8pTEOgDk?=
 =?iso-8859-1?Q?4AgjyD95QjbUVhF0KEiWAU/zK9hLyst6Ut/gsZ2cT7/SfNYtwBTk4ua86G?=
 =?iso-8859-1?Q?jzCzk+XyohzpVTH/VajnTEkElpNbAeZhZmX+Wi+/gg51nwFz9SKzoLGNve?=
 =?iso-8859-1?Q?4kNyBei9EF3OIn85m9d8wmqvcEsGwvEeDR9qD/MqFmXAQE1ECR/q66g48f?=
 =?iso-8859-1?Q?nxaEcjGy12SzUFELJ7yGmI8OwR9IbesfUNnfrHkiPsM5B2FkmqUzxkX9P5?=
 =?iso-8859-1?Q?a/jXuGQSzear79+IVeJLsgYbWEIwlTO5DfSzeAI9+M1JI6UPHb5QM3JI2W?=
 =?iso-8859-1?Q?fdHn2Ig4LLFAGqwA76x7XqbBm1zmemVDP2QDIaDoNHChd2MLYEh9kHrlkw?=
 =?iso-8859-1?Q?2lK34/0gQcEGEFFev8SnEC4IBbg7TS+4wVe78MtkO0bOFFIHtDbfmVq3ci?=
 =?iso-8859-1?Q?MCd8kUTL5I8dtdY+mMc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb1fe30-b449-4aeb-09ab-08ddae638a8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 12:27:49.7753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EGzx3UC5w3WMWBQby+QjhxaUGclaYirYanT+4ki40/4JoCY4LxvGA5qkyrBF9B23GS9R/X57Z0SaqmO0neBpiXai7JpxdjCnH7KKPR46u8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB3834
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Since there is no pch_gbe emulation, we could be using func other
than 0 when adding new devices to specific boards.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/pci/pci.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index f5ab510697..23f7f02837 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -974,14 +974,15 @@ static int pci_parse_devaddr(const char *addr, int *d=
omp, int *busp,
=20
     slot =3D val;
=20
-    if (funcp !=3D NULL) {
-        if (*e !=3D '.')
+    if (funcp !=3D NULL && *e !=3D 0) {
+        if (*e !=3D '.') {
             return -1;
-
+        }
         p =3D e + 1;
         val =3D strtoul(p, &e, 16);
-        if (e =3D=3D p)
+        if (e =3D=3D p) {
             return -1;
+        }
=20
         func =3D val;
     }
@@ -2045,13 +2046,15 @@ bool pci_init_nic_in_slot(PCIBus *rootbus, const ch=
ar *model,
     int dom, busnr, devfn;
     PCIDevice *pci_dev;
     unsigned slot;
+
     PCIBus *bus;
=20
     if (!nd) {
         return false;
     }
=20
-    if (!devaddr || pci_parse_devaddr(devaddr, &dom, &busnr, &slot, NULL) =
< 0) {
+    unsigned func;
+    if (!devaddr || pci_parse_devaddr(devaddr, &dom, &busnr, &slot, &func)=
 < 0) {
         error_report("Invalid PCI device address %s for device %s",
                      devaddr, model);
         exit(1);
@@ -2062,7 +2065,7 @@ bool pci_init_nic_in_slot(PCIBus *rootbus, const char=
 *model,
         exit(1);
     }
=20
-    devfn =3D PCI_DEVFN(slot, 0);
+    devfn =3D PCI_DEVFN(slot, func);
=20
     bus =3D pci_find_bus_nr(rootbus, busnr);
     if (!bus) {
--=20
2.34.1

