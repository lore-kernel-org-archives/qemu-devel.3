Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6D7D2F7C5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 21:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Biy-0000QL-W3; Wed, 16 Oct 2024 17:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t1Bix-0000Q7-HR; Wed, 16 Oct 2024 17:38:31 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t1Biv-0002tC-Df; Wed, 16 Oct 2024 17:38:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43115887867so1779145e9.0; 
 Wed, 16 Oct 2024 14:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729114707; x=1729719507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHN8BANOw4Ho/0TQpTe4GJ81HqWZ+PUGdSkvRoVHMt4=;
 b=DRPuieKYwElkTvihDOyqx5ICxk6Z7g+KOvM4DpdEED4cFgAQW/47bHuTiprxGUyHKX
 U5Rp/vmqrnZJWg+5lBj2J7PShiGu+0KbWjl202IVHF4C2CIbtNfJEeeWx3kT51nlqRXB
 OatjniokVeHVJOdsiM+dcTsHeMM4+XqEND6bR18qJPHSOSAMRtG5Tmxf/C/1Pd4ZRjI1
 UsjPACqFbsSEDSeqp+dZLcXPjMFMZvbZZFZSYpN+NQU1dgmmWZCwoXbcvZ5QUrI/OIrs
 0FbkiJYO8pidWJXoQvYXHl1Le37flI6z/ZFgUyKw7CftXizLyNHG6YFi9zHMnmHXXJs3
 94gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729114707; x=1729719507;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MHN8BANOw4Ho/0TQpTe4GJ81HqWZ+PUGdSkvRoVHMt4=;
 b=NCBTPOgIV2z0JXjzMGi+0w8AliClLRzog5/i24bxRBUbKud38Vdxfw9frD4l6/Reo5
 by0wqEnRwz2biuN90SKLXDE4v85kWaPfpg6t080bMT0IoBQ7AF64ByI8aVqcQkZT2+eW
 qYXyt2x3lCjMYTZ1lGVijzOAnvsxYDj7jFduE22vg4NMGOfd3dZcazjF4PcxpwFW/ptR
 7IABM6yAIu8e97bpuCLXyd1A+HZh+1i85g4VDS8fDAN9f6vAXLvxB6QE4RI6au3fNXHy
 MqKhTV6wgt5adi9kldPjqj79l0j/fJEPMMFZ7wIjy9ZwmNVWOlrWx0d37l34Sfu/QTHc
 kHpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVUKaNZ3sBPS7RjaRMOgePczsAN3wz4QmToPKYXD10nvpOvqyko1UXFwz/B8ceA56h+PAMyAUVGA==@nongnu.org
X-Gm-Message-State: AOJu0YxbraAAtOvureuk354JfwXCu221nO8Nu6+FdwLb0JT95gd6tQ7g
 VcNcfKavhQL0U1vgb3IdEYtIdcdUpL8D6W5CnDyVlMbjsYL45irtAMsn3A==
X-Google-Smtp-Source: AGHT+IGoiilFjlpm5+UXjDoa7G+un6G2WdqRrp+x69u+tc3oZHvP4DQgTkPSvpJN3vdKqnqQtzYifw==
X-Received: by 2002:a05:600c:4513:b0:42c:b991:98bc with SMTP id
 5b1f17b1804b1-43158653852mr6538305e9.0.1729114706406; 
 Wed, 16 Oct 2024 14:38:26 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-191-025-143.77.191.pool.telefonica.de.
 [77.191.25.143]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43158c4da23sm5588915e9.34.2024.10.16.14.38.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2024 14:38:25 -0700 (PDT)
Date: Wed, 16 Oct 2024 21:38:24 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 qemu-arm@nongnu.org
CC: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Subject: Re: [PATCH] hw/net: Extend ethernetlite driver with PHY layer
In-Reply-To: <20241015132622.3468066-1-sai.pavan.boddu@amd.com>
References: <20241015132622.3468066-1-sai.pavan.boddu@amd.com>
Message-ID: <E3FD5F10-4C71-492E-B092-66810A921AAB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



Am 15=2E Oktober 2024 13:26:22 UTC schrieb Sai Pavan Boddu <sai=2Epavan=2E=
boddu@amd=2Ecom>:
>From: Michal Simek <michal=2Esimek@amd=2Ecom>
>
>Add missing optional MDIO lines=2E Without it U-Boot is not working=2E
>
>Signed-off-by: Edgar E=2E Iglesias <edgar=2Eiglesias@amd=2Ecom>
>Signed-off-by: Michal Simek <michal=2Esimek@amd=2Ecom>

Overall the code seems almost identical to the one in axienet=2E Doesn't i=
t make sense to share one PHY  implementation between both devices? See e=
=2Eg=2E <https://lore=2Ekernel=2Eorg/qemu-devel/20241016212407=2E139390-1-s=
hentey@gmail=2Ecom/>

Moreover, both PHY implementations use many magic numbers=2E For better co=
mprehension the mii constants could be use as well=2E See above link, too=
=2E
=20
>---
> hw/net/xilinx_ethlite=2Ec | 240 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 240 insertions(+)
>
>diff --git a/hw/net/xilinx_ethlite=2Ec b/hw/net/xilinx_ethlite=2Ec
>index bd812908085=2E=2E5b129ca7e4e 100644
>--- a/hw/net/xilinx_ethlite=2Ec
>+++ b/hw/net/xilinx_ethlite=2Ec
>@@ -56,6 +56,215 @@
> DECLARE_INSTANCE_CHECKER(struct xlx_ethlite, XILINX_ETHLITE,
>                          TYPE_XILINX_ETHLITE)
>=20
>+#define R_MDIOADDR (0x07E4 / 4)  /* MDIO Address Register */
>+#define R_MDIOWR (0x07E8 / 4)    /* MDIO Write Data Register */
>+#define R_MDIORD (0x07EC / 4)    /* MDIO Read Data Register */
>+#define R_MDIOCTRL (0x07F0 / 4)  /* MDIO Control Register */
>+
>+/* MDIO Address Register Bit Masks */
>+#define R_MDIOADDR_REGADR_MASK  0x0000001F  /* Register Address */
>+#define R_MDIOADDR_PHYADR_MASK  0x000003E0  /* PHY Address */
>+#define R_MDIOADDR_PHYADR_SHIFT 5
>+#define R_MDIOADDR_OP_MASK      0x00000400    /* RD/WR Operation */
>+
>+/* MDIO Write Data Register Bit Masks */
>+#define R_MDIOWR_WRDATA_MASK    0x0000FFFF /* Data to be Written */
>+
>+/* MDIO Read Data Register Bit Masks */
>+#define R_MDIORD_RDDATA_MASK    0x0000FFFF /* Data to be Read */
>+
>+/* MDIO Control Register Bit Masks */
>+#define R_MDIOCTRL_MDIOSTS_MASK 0x00000001   /* MDIO Status Mask */
>+#define R_MDIOCTRL_MDIOEN_MASK  0x00000008   /* MDIO Enable */
>+
>+/* Advertisement control register=2E */
>+#define ADVERTISE_10HALF        0x0020  /* Try for 10mbps half-duplex  *=
/
>+#define ADVERTISE_10FULL        0x0040  /* Try for 10mbps full-duplex  *=
/
>+#define ADVERTISE_100HALF       0x0080  /* Try for 100mbps half-duplex *=
/
>+#define ADVERTISE_100FULL       0x0100  /* Try for 100mbps full-duplex *=
/

Constants seem redundant to those in mii=2Eh=2E

>+
>+#define DPHY(x)

Better use tracing=2E

>+
>+struct PHY {
>+    uint32_t regs[32];
>+
>+    int link;
>+
>+    unsigned int (*read)(struct PHY *phy, unsigned int req);
>+    void (*write)(struct PHY *phy, unsigned int req,
>+                  unsigned int data);
>+};
>+
>+static unsigned int tdk_read(struct PHY *phy, unsigned int req)
>+{
>+    int regnum;
>+    unsigned r =3D 0;
>+
>+    regnum =3D req & 0x1f;
>+
>+    switch (regnum) {
>+    case 1:
>+        if (!phy->link) {
>+            break;
>+        }
>+        /* MR1=2E  */
>+        /* Speeds and modes=2E  */
>+        r |=3D (1 << 13) | (1 << 14);
>+        r |=3D (1 << 11) | (1 << 12);
>+        r |=3D (1 << 5); /* Autoneg complete=2E  */
>+        r |=3D (1 << 3); /* Autoneg able=2E  */
>+        r |=3D (1 << 2); /* link=2E  */
>+        r |=3D (1 << 1); /* link=2E  */
>+        break;
>+    case 5:
>+        /*
>+         * Link partner ability=2E
>+         * We are kind; always agree with whatever best mode
>+         * the guest advertises=2E
>+         */
>+        r =3D 1 << 14; /* Success=2E  */
>+        /* Copy advertised modes=2E  */
>+        r |=3D phy->regs[4] & (15 << 5);
>+        /* Autoneg support=2E  */
>+        r |=3D 1;
>+        break;
>+    case 17:
>+        /* Marvel PHY on many xilinx boards=2E  */
>+        r =3D 0x4c00; /* 100Mb  */
>+        break;
>+    case 18:
>+        {
>+            /* Diagnostics reg=2E  */
>+            int duplex =3D 0;
>+            int speed_100 =3D 0;
>+            if (!phy->link) {
>+                break;
>+            }
>+            /* Are we advertising 100 half or 100 duplex ? */
>+            speed_100 =3D !!(phy->regs[4] & ADVERTISE_100HALF);
>+            speed_100 |=3D !!(phy->regs[4] & ADVERTISE_100FULL);
>+            /* Are we advertising 10 duplex or 100 duplex ? */
>+            duplex =3D !!(phy->regs[4] & ADVERTISE_100FULL);
>+            duplex |=3D !!(phy->regs[4] & ADVERTISE_10FULL);
>+            r =3D (speed_100 << 10) | (duplex << 11);
>+        }
>+        break;
>+
>+    default:
>+        r =3D phy->regs[regnum];
>+        break;
>+    }
>+    DPHY(qemu_log("\n%s %x =3D reg[%d]\n", __func__, r, regnum));
>+    return r;
>+}
>+
>+static void
>+tdk_write(struct PHY *phy, unsigned int req, unsigned int data)
>+{
>+    int regnum;
>+
>+    regnum =3D req & 0x1f;
>+    DPHY(qemu_log("%s reg[%d] =3D %x\n", __func__, regnum, data));
>+    switch (regnum) {
>+    default:
>+        phy->regs[regnum] =3D data;
>+        break;
>+    }
>+
>+    /* Unconditionally clear regs[BMCR][BMCR_RESET] */
>+    phy->regs[0] &=3D ~0x8000;
>+}
>+
>+static void
>+tdk_init(struct PHY *phy)
>+{
>+    phy->regs[0] =3D 0x3100;
>+    /* PHY Id=2E  */
>+    phy->regs[2] =3D 0x0141;
>+    phy->regs[3] =3D 0x0cc2;
>+    /* Autonegotiation advertisement reg=2E  */
>+    phy->regs[4] =3D 0x01E1;
>+    phy->link =3D 1;
>+
>+    phy->read =3D tdk_read;
>+    phy->write =3D tdk_write;
>+}
>+
>+struct MDIOBus {

This code =2E=2E=2E

>+    /* bus=2E  */
>+    int mdc;
>+    int mdio;
>+
>+    /* decoder=2E  */
>+    enum {
>+        PREAMBLE,
>+        SOF,
>+        OPC,
>+        ADDR,
>+        REQ,
>+        TURNAROUND,
>+        DATA
>+    } state;
>+    unsigned int drive;
>+
>+    unsigned int cnt;
>+    unsigned int addr;
>+    unsigned int opc;
>+    unsigned int req;
>+    unsigned int data;
>+

=2E=2E=2E seems to be unused=2E

>+    struct PHY *devs[32];
>+};
>+
>+static void
>+mdio_attach(struct MDIOBus *bus, struct PHY *phy, unsigned int addr)
>+{
>+    bus->devs[addr & 0x1f] =3D phy;
>+}
>+
>+#ifdef USE_THIS_DEAD_CODE
>+static void
>+mdio_detach(struct MDIOBus *bus, struct PHY *phy, unsigned int addr)
>+{
>+    bus->devs[addr & 0x1f] =3D NULL;
>+}
>+#endif

Either bring this code to life or remove it=2E

>+
>+static uint16_t mdio_read_req(struct MDIOBus *bus, unsigned int addr,
>+                  unsigned int reg)
>+{
>+    struct PHY *phy;
>+    uint16_t data;
>+
>+    phy =3D bus->devs[addr];
>+    if (phy && phy->read) {
>+        data =3D phy->read(phy, reg);
>+    } else {
>+        data =3D 0xffff;
>+    }
>+    DPHY(qemu_log("%s addr=3D%d reg=3D%d data=3D%x\n", __func__, addr, r=
eg, data));
>+    return data;
>+}
>+
>+static void mdio_write_req(struct MDIOBus *bus, unsigned int addr,
>+               unsigned int reg, uint16_t data)
>+{
>+    struct PHY *phy;
>+
>+    DPHY(qemu_log("%s addr=3D%d reg=3D%d data=3D%x\n", __func__, addr, r=
eg, data));
>+    phy =3D bus->devs[addr];
>+    if (phy && phy->write) {
>+        phy->write(phy, reg, data);
>+    }
>+}
>+
>+struct TEMAC  {
>+    struct MDIOBus mdio_bus;
>+    struct PHY phy;
>+
>+    void *parent;
>+};
>+
> struct xlx_ethlite
> {
>     SysBusDevice parent_obj;
>@@ -70,6 +279,9 @@ struct xlx_ethlite
>     unsigned int txbuf;
>     unsigned int rxbuf;
>=20
>+uint32_t c_phyaddr;
>+    struct TEMAC TEMAC;
>+
>     uint32_t regs[R_MAX];
> };
>=20
>@@ -101,11 +313,15 @@ eth_read(void *opaque, hwaddr addr, unsigned int si=
ze)
>             r =3D s->regs[addr];
>             D(qemu_log("%s " HWADDR_FMT_plx "=3D%x\n", __func__, addr * =
4, r));
>             break;
>+        case R_MDIOCTRL:
>+            r =3D s->regs[addr] & (~R_MDIOCTRL_MDIOSTS_MASK); /* Always =
ready=2E  */
>+            break;
>=20
>         default:
>             r =3D tswap32(s->regs[addr]);
>             break;
>     }
>+    D(qemu_log("%s " HWADDR_FMT_plx "=3D%x\n", __func__, addr * 4, r));

Better use tracing=2E

Best regards,
Bernhard

>     return r;
> }
>=20
>@@ -159,6 +375,26 @@ eth_write(void *opaque, hwaddr addr,
>                        __func__, addr * 4, value));
>             s->regs[addr] =3D value;
>             break;
>+        case R_MDIOCTRL:
>+            if (((unsigned int)value & R_MDIOCTRL_MDIOSTS_MASK) !=3D 0) =
{
>+                struct TEMAC *t =3D &s->TEMAC;
>+                unsigned int op =3D s->regs[R_MDIOADDR] & R_MDIOADDR_OP_=
MASK;
>+                unsigned int phyaddr =3D (s->regs[R_MDIOADDR] &
>+                    R_MDIOADDR_PHYADR_MASK) >> R_MDIOADDR_PHYADR_SHIFT;
>+                unsigned int regaddr =3D s->regs[R_MDIOADDR] &
>+                    R_MDIOADDR_REGADR_MASK;
>+                if (op) {
>+                    /* read PHY registers */
>+                    s->regs[R_MDIORD] =3D mdio_read_req(
>+                        &t->mdio_bus, phyaddr, regaddr);
>+                } else {
>+                    /* write PHY registers */
>+                    mdio_write_req(&t->mdio_bus, phyaddr, regaddr,
>+                        s->regs[R_MDIOWR]);
>+                }
>+            }
>+            s->regs[addr] =3D value;
>+            break;
>=20
>         default:
>             s->regs[addr] =3D tswap32(value);
>@@ -238,6 +474,9 @@ static void xilinx_ethlite_realize(DeviceState *dev, =
Error **errp)
>                           object_get_typename(OBJECT(dev)), dev->id,
>                           &dev->mem_reentrancy_guard, s);
>     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf=2Emacaddr=
=2Ea);
>+
>+    tdk_init(&s->TEMAC=2Ephy);
>+    mdio_attach(&s->TEMAC=2Emdio_bus, &s->TEMAC=2Ephy, s->c_phyaddr);
> }
>=20
> static void xilinx_ethlite_init(Object *obj)
>@@ -252,6 +491,7 @@ static void xilinx_ethlite_init(Object *obj)
> }
>=20
> static Property xilinx_ethlite_properties[] =3D {
>+    DEFINE_PROP_UINT32("phyaddr", struct xlx_ethlite, c_phyaddr, 7),
>     DEFINE_PROP_UINT32("tx-ping-pong", struct xlx_ethlite, c_tx_pingpong=
, 1),
>     DEFINE_PROP_UINT32("rx-ping-pong", struct xlx_ethlite, c_rx_pingpong=
, 1),
>     DEFINE_NIC_PROPERTIES(struct xlx_ethlite, conf),

