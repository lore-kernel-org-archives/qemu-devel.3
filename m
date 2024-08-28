Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7370BC54FAA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 12:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjHy9-0006r1-3H; Wed, 28 Aug 2024 08:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1sjHy7-0006mU-W4
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:40:12 -0400
Received: from netsrv01.beckhoff.com ([62.159.14.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1sjHy5-0003sz-MP
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:40:11 -0400
Received: from 172.17.5.170 by netsrv01.beckhoff.com (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Wed, 28 Aug 2024 12:40:07 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1724848807; bh=5ikrUX7SUcWU2EBEEPgC8GO62thTByiqo2+Nul+mmag=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 WP2VIb0LmQHxpAFg0CvlyCxLG5MzL6Cq3ZxZY+DXtjRPHIzi7utT5sLS0spfHoAsx/iUwhgJRfogtVzYBRcSCA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1724848807; bh=5ikrUX7SUcWU2EBEEPgC8GO62thTByiqo2+Nul+mmag=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 gBzdk11jhJDqmhTAT7Upkuha0fo/fAi5RG4R2byfaPrcl2Ho2OAVyFXuWSSwOL7x2dbot9wbnVT8kaWw4VwD7yfaMfcvmsaahaNPYESRm0qn4ICP138+RPdZMzlbG9F0wK7h62+LJFULPeAkGEhTzq1R8HiRCUh8RrhgcJd7Ut8jMxgYrjSNlbT+feggAQ5zNLp3hz1RTR+Q3NmhXCLIZ6LbSuYY9nyK79H4rtoapr1Kxwpi7lpO9qqiTOh+ali7pjo7BxXXSPlCl5cn98ApOUl/SDdnKfxbIJISl/1+MtzN7yuQK/rZs/WT3hBCLa+oVnZ+nlx8vAX0+ARPQXxWOg==
Received: from corvink-nb.beckhoff.com (172.17.128.201) by ex04.beckhoff.com
 (172.17.5.170) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 14:40:05 +0200
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
To: <qemu-devel@nongnu.org>, <c.koehne@beckhoff.com>
CC: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: [PATCH v2 7/7] vfio/igd: correctly calculate stolen memory size for
 gen 9 and later
Date: Wed, 28 Aug 2024 14:39:59 +0200
Message-ID: <20240828123959.84400-3-c.koehne@beckhoff.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828123959.84400-1-c.koehne@beckhoff.com>
References: <20240828123549.83293-1-c.koehne@beckhoff.com>
 <20240828123959.84400-1-c.koehne@beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.17.128.201]
X-ClientProxiedBy: ex07.beckhoff.com (172.17.5.172) To ex04.beckhoff.com
 (172.17.5.170)
X-OLX-Disclaimer: EX04.BECKHOFF.COM
Received-SPF: pass client-ip=62.159.14.10; envelope-from=C.Koehne@beckhoff.com;
 helo=netsrv01.beckhoff.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

=EF=BB=BFWe have to update the calculation of the stolen memory size becaus=
e
we've seen devices using values of 0xf0 and above for the graphics mode
select field. The new calculation was taken from the linux kernel [1].

[1] https://github.com/torvalds/linux/blob/7c626ce4bae1ac14f60076d00eafe71a=
f30450ba/arch/x86/kernel/early-quirks.c#L455-L460

Signed-off-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
---
 hw/vfio/igd.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 0751c43eae..a95d441f68 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -488,11 +488,18 @@ static int igd_get_stolen_mb(int gen, uint32_t gmch)
         gms =3D (gmch >> 8) & 0xff;
     }
=20
-    if (gms > 0x10) {
-        error_report("Unsupported IGD GMS value 0x%x", gms);
-        return 0;
+    if (gen < 9) {
+        if (gms > 0x10) {
+            error_report("Unsupported IGD GMS value 0x%x", gms);
+            return 0;
+        }
+        return gms * 32;
+    } else {
+        if (gms < 0xf0)
+            return gms * 32;
+        else
+            return gms * 4 + 4;
     }
-    return gms * 32;
 }
=20
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
--=20
2.46.0

This email contains confidential information. If you have received it in er=
ror, you must not read, use, copy or pass on this e-mail or its attachments=
. If you have received the e-mail in error, please inform me immediately by=
 reply e-mail and then delete this e-mail from your system. Thank you
=20
Diese E-Mail enth=C3=A4lt vertrauliche Informationen. Sollten Sie sie irrt=
=C3=BCmlich erhalten haben, d=C3=BCrfen Sie diese E-Mail oder ihre Anh=C3=
=A4nge nicht lesen, verwenden, kopieren oder weitergeben. Sollten Sie die M=
ail versehentlich erhalten haben, teilen Sie mir dies bitte umgehend per An=
twort-E-Mail mit und l=C3=B6schen Sie diese E-Mail dann aus Ihrem System. V=
ielen Dank

Beckhoff Automation GmbH & Co. KG | Managing Director: Dipl. Phys. Hans Bec=
khoff
Registered office: Verl, Germany | Register court: Guetersloh HRA 7075




