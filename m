Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABFCC7115A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 12:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRrtg-0006Cq-Bz; Wed, 18 Jun 2025 08:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRrtd-0006BW-Qz; Wed, 18 Jun 2025 08:28:05 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRrtc-0005VS-84; Wed, 18 Jun 2025 08:28:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vp7JTvHj6fI3lTWccyDqnWaBYDPb9WrEhaXQK68IrYVLG2WxM5Gm/SbKneL6so68S0Ko6Y20qrA+cLApCrHRSS6Q6lThsEYCHsW4i4I67ITrOHU4pqXVyvVDNmA2efGCgmggwMLIf8SuMmMORToj367mRQLefW+AzgQxlDZuCUfmMhKXgUtJQF8MOKEAdbFVCrazPAIGb11ztmo6eVIHAM/eGjU9GWMK4UwpZ2Gay8O45whwnwVNZdFKofFvx53HmMm5se4mPecADo1OWd3sYNsfBSalDIAGCw6JAbqP4VIRj284xdR/obOfHbf4cMUapLRG6yQ7kbnYDql1Ld0YfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrmPUNiYpxLANPjmk3lme2Cm3Q0rIJtRBV5hlRQ8/ic=;
 b=Uu4wf6GgsJ9kLIBK40DoZuhC/Bmrbj8yLPIcEe5K8BSh57UV6emZ/swoXKq5NPWsXdDI0gHT0LhTW3T/rERyxQ4GtEhcmu/xPnhJYOm/PW7XB+Kgx9rVNCRvy+YcKgBjclAJ0mU7SyNK108vECbV0+0ZcrzXIYSRLfqgO0GWmrjfh1NQ65Lod4mNif/eQu0cWbg87N/FIQEy8QzWwvo9Yq0Z/d7O1cFM9rNMRg1zHX2zwHMLXG9LCShCT3meMWdfkX/dC5C0JXU7aOlJoOqsQoPoTKrXWhjo3GuQeucGZrHTAATFhVtihfJBIXYSds3GJvLMfjbSNomruUMVkzkCzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrmPUNiYpxLANPjmk3lme2Cm3Q0rIJtRBV5hlRQ8/ic=;
 b=aLchKwPu4aXGUBHST0+bqQjsnNExufGIbT2dMICBFCQI3WhaZZJXe/Yi8Ed1sm5lHn6YmcOKG14cDC7gAkHz+QoIx2p60rfmKr2sm0kfNRS5CGk5NlJpHAgCxB5F+LEM1CwEDClhWjuVogFISu6ddDUm3Ib+aPHA0Ur9BRMIM4j57YzCSlyIDuZACfTuB4v74wpnRITi3+33vDEgxYBWpe7RPvhn8Kik1NVXalT8j/f64g2nMDeuBH25+qIIm9Ar97j7gBfuFtZPsVNtCZ6xJC5hX/hI42gVyTEaBtU2fymuraL4WpSBRN3BizcNTAOl74PJfep0RJcm8uCg3s681g==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB3834.eurprd09.prod.outlook.com (2603:10a6:10:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 12:27:51 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 12:27:50 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v3 10/10] riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
Thread-Topic: [PATCH v3 10/10] riscv/boston-aia: Add an e1000e NIC in slot 0
 func 1
Thread-Index: AQHb4ExnzhtIKbJ7nUuRXuUxmijF2A==
Date: Wed, 18 Jun 2025 12:27:50 +0000
Message-ID: <20250618122715.1929966-11-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 6969b048-74dd-4137-2034-08ddae638abf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Lxk/FK5PaJrTF9Odngymj+ve2/2RguOarQTZ57PnAdyb2emflglEqlP16z?=
 =?iso-8859-1?Q?1wFDY1YnYBMNyFObTlLtQNe8FxlHrSiyF1hsAsYNfggJCxpc6T+28o1H0n?=
 =?iso-8859-1?Q?BFSJA7+dYPO7nM+y7YElyNLKJfIe1BhM+8fvtvTpfnHuEMhUrTcHGczsAY?=
 =?iso-8859-1?Q?+pFp3G0fWlpIlaj2ahjQKs1WVIDCBhrG42Ao8OVPZeY8Wsu/DpdDZ+asSz?=
 =?iso-8859-1?Q?h3PRSFIRdCkywRkWp5gUNbGlbOFCnZ6oNtDIY2byW5sI9HmkYQBt94CL77?=
 =?iso-8859-1?Q?wVYvqz01GOxkCpWjRrdkmczv7OMgfZEH6FANmfJ+T31pU+Z/5kQutIWlXk?=
 =?iso-8859-1?Q?PyycxLWCJrZTYDGNEuUO8qaKUrredx5LFXe7LQ6VXCah5xw8c7sLN2E8IH?=
 =?iso-8859-1?Q?dDsyt1u5rA4hBrsam8aY2A1YpJ2+8qyUTPMsfVf3iqC0XKaqBsEzHPbdNQ?=
 =?iso-8859-1?Q?j1oU4AFzJt3tHPsEKNfudFSDvBtypwQrNIJOJU6DKlXCvVt01rgEzsKzkx?=
 =?iso-8859-1?Q?uOA6sJjWCxipkfMCJiypxCzAKPCtww/owvitmzcET/dC34ca2tcMr/1T28?=
 =?iso-8859-1?Q?15rIgKhXaXRhxP2MkX4ZTyNP3xhnAWHjveaIps/W3J58mla8sgz9m8mAvX?=
 =?iso-8859-1?Q?F3/YZTYgsWL/SE5a6n4nt5hz/BfE/laxnPS8DBMhup5/lZsEKwc/opTAdF?=
 =?iso-8859-1?Q?MemnWfm4/v8UwaZE/nkANoFr9OhaPeZpaCu8Zr7u1dXk+87yDPRCHw2njP?=
 =?iso-8859-1?Q?etLUnGy6lVLaUpPhGA4ek/V7Wd9BCLsxrMPzCXzt9b5iSBvESxqnjfRjRJ?=
 =?iso-8859-1?Q?Yh5Fry0mfXCxNAZCuUtd9F1uIx5bydnb41RNF2iJPkvTV7gLTFZoWeF+26?=
 =?iso-8859-1?Q?jizX7pI6dPRb01j/j2hCRRowDqEI1nFfJEBcoCwd9EklUXV8BFhgIMtEvV?=
 =?iso-8859-1?Q?+cJJoa2gQGiVRGwVaLBw/pBafdMxFoaYkZSUVYFgPIEvysP19Zi2AlR5jr?=
 =?iso-8859-1?Q?J5FjGirFa+aAROWDhiAokVCae0MjW+Qp4PZ/GrmMqke8t+j/WJUTG8Wfx7?=
 =?iso-8859-1?Q?736cQBtA4gzPJKVW5/6/Yi24gU03JVcuNJN41/xpvizGWUxLxZCNCciCEu?=
 =?iso-8859-1?Q?ybhJnmE0PLH7ap88VnyL8IONmDr9kuAX9jAQ6TbA+/7dCNOAKkidckEPdW?=
 =?iso-8859-1?Q?KiOqT2z7C2I8jLuoJ3+U+iv4YOkMaCvb/p4TRZRyHkdIfYCgDm7k/ob5AJ?=
 =?iso-8859-1?Q?oYK0ppbDLecdMD36kiGr4B3nhh64bZ6QcCMSWT2D3wTUjEGTb4SETGt6yR?=
 =?iso-8859-1?Q?8d/ab9M/WpFhz7YrKnQPFBJauXG9AW2wG5gOLsC7Z0wXAo7ecF2pg9NeKT?=
 =?iso-8859-1?Q?/3avKoRilmB8PxUZtdePyYXkcSretb3T5jJcr79WM4VYvFcsvT27DhYPsZ?=
 =?iso-8859-1?Q?eau0vTemTlVjPXuK4cHSVsbdkLsOzoQ22F4PDRwyO3IBRAjuJYMEUTxalO?=
 =?iso-8859-1?Q?aR4nCg3gQV/vtMIqST7NonjgyhTHvuotoKe2wCRYQW6w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iYQafHEgf/DOnxvi3oQXIO4OyJPlmK8ZoHyqBLxI3TW6z1vHF/8rbFnTwR?=
 =?iso-8859-1?Q?wBiUqhJyrjBUCzdZyVwkRiicZ7UStFwc+EAGTMIFE9gpY08mWOTLsqp/B+?=
 =?iso-8859-1?Q?1KgAfAUJ9Bdo+j8IvU59TWvXSkqwqqsE8XpgdaA5VX4e0sKOOR9OdZmwT7?=
 =?iso-8859-1?Q?uZWEIBN43m793Ttw424Kk90MD3ZM4fRsL0ps3ePvF+a0VlRiJEC2jGuW0A?=
 =?iso-8859-1?Q?7L/ztlMxfuoUuIZo7CwJu0yMJ5GATN3F+4TUsWCYycOTVBjwYSLdpPdaSb?=
 =?iso-8859-1?Q?79aNv2CAwlgg3X0sb9h0cWv65OZ7yY6tuwNIv9ooKq2KPvaDqmH7pj7EdH?=
 =?iso-8859-1?Q?UvibhG4+OIqnLoDijbqdtMFTY/2sAaJ8bJJ30xwPYTcfz20oHQyIHLj8y/?=
 =?iso-8859-1?Q?ExgzLGLfO6sofYzi+ieBTnO9gjlUJjmp6EWvCPI+EBW/zFSAMKG5fYNr7e?=
 =?iso-8859-1?Q?qNnv1cxvV8SXXAVicfodcmLZBfx43QptdQrFa5eH466ft7tuDDcvPEZXR4?=
 =?iso-8859-1?Q?QRhg8LQR/979hS8WxrxiixkrUN8LrmpuX8s8dMXl7p0WTMG4QZbdmhJIDy?=
 =?iso-8859-1?Q?d4l0lS67PbJkfMKTt5OuQGwmPog3WNQ+p6w2rs/oFqeFVNv/Tm5RPFSfQ/?=
 =?iso-8859-1?Q?WJhD53BqrGLopkibcZjqQjwTivBOMR91fyZCVdSl9lHv79l+vCIJdiMKZl?=
 =?iso-8859-1?Q?GqPdMXNyoQuxULBPb7gnDRd7FcEdrgCW07gCYmmN9XzZCsn0WacKaskLz6?=
 =?iso-8859-1?Q?sPQAKcQgpTyNNhGvtEfVoWVOJleDQvpLNN0dasux/TYN+Hy864L5wlz7KO?=
 =?iso-8859-1?Q?iQgX7+PcLYMRnPMymZ2HQdG7seKlyX0CRjeTGvtGJDnhkx7KcHoK1xc0MC?=
 =?iso-8859-1?Q?zod3aY1fRNj4Ad0oYPviRjGoNDobiI7sk9TshR0U/bou+xRfHj9cX54feg?=
 =?iso-8859-1?Q?aNoFkIBM0U3qkVOBuKaghW4HE6v7QVTqEjHR3gqf5BbZHh6Zfu73zh2z9K?=
 =?iso-8859-1?Q?f8Xx3uqfG3Y47T4JNwm3YNTW+6jwkK9u5lx8vAo96YxKaKpQ26XKaoacYn?=
 =?iso-8859-1?Q?WgbMLvV9ypS5z24DsfyHS75+7GejaRIPOUJIlkY/05+FbkhEKfX2/KAmAU?=
 =?iso-8859-1?Q?v47WoEEOehZq6f4HrlwZ5RM9a4lhS0JQ2cIXgK7enifvqONpjkUOMwQGIu?=
 =?iso-8859-1?Q?OHwzdqyXTtEtYk3Pi5/tjaAFskJAgG4i98eAWvKzhY1G2eOW362qJ5lJos?=
 =?iso-8859-1?Q?UohnSPdutJaq8FJpcEbs6ja8q/CbwwT53jll6NXE40qPFZML6RzXw4u94N?=
 =?iso-8859-1?Q?aBm+OUew9/r5j0GywqaWDKeB5amYZAte/lVS3kxzyN0bdHuOelBVb8HEgv?=
 =?iso-8859-1?Q?mQWBkFSCCZ60vwBjLHY5DKxiWWUoC6ku/KrN/635Z/IGIJEuSv+I/4+2MU?=
 =?iso-8859-1?Q?1/eQuhmLsYiZIJFYWLaGAEGRheME0I6s9dWFwgvNuFQilLUTcvR/ufRhGA?=
 =?iso-8859-1?Q?nLrzpgRrZ99l7qDDMhi1vFaIvUsCAO3qCycmDr88jTlcBS4Kw5SSvYdhkK?=
 =?iso-8859-1?Q?gUdLMrI4CtEY0lBxuUM5pjQZpopdPXbDmZoknM6J2gEtowArTYLvr2Z5hd?=
 =?iso-8859-1?Q?GYkgdIIShg2p7z3lT0Pywj4CLysLwoP+/Wjhj4kN5YHRfW66/gKu7JeNWF?=
 =?iso-8859-1?Q?CcQqMtVBIfAi+XrFIbc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6969b048-74dd-4137-2034-08ddae638abf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 12:27:50.0961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: beN7Uzae6J88/kZv1jjLM+NPT2UfFk4orLg1+qWMs7y/EsIiXas+JZfkW866h3zEqAgm8149ZuQKGF59fFKPBtAdULfKD9lGBPDWguusL1c=
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

The Boston AIA board needs a basic GbE NIC.  There is no PCH GbE
device emulation, so use an `e1000e` instead.  We place it in
**slot 0, function 1** in order not to conflict with the existing
AHCI device in slot 0 func 0.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/riscv/boston-aia.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 6ed5c636cc..34cc0abe79 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -437,6 +437,11 @@ static void boston_mach_init(MachineState *machine)
     ide_drive_get(hd, ich9->ahci.ports);
     ahci_ide_create_devs(&ich9->ahci, hd);
=20
+    /* Create e1000e using slot 0 func 1 */
+    pci_init_nic_in_slot(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e", NUL=
L,
+                         "00.1");
+    pci_init_nic_devices(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e");
+
     if (machine->firmware) {
         fw_size =3D load_image_targphys(machine->firmware,
                                       0x1fc00000, 4 * MiB);
--=20
2.34.1

