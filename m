Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2E3606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRX4z-0007Jj-Rl; Thu, 12 Nov 2026 10:51:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1xRWKf-0005h7-KP; Thu, 12 Nov 2026 10:03:30 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1xRWKb-0004Ns-6A; Thu, 12 Nov 2026 10:03:20 -0500
DKIM-Signature: a=rsa-sha256; bh=dWwzDrrQ61aRsyqeFt+FVeE/c10tiMFAC/Q5TJEg0so=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1794495789; v=1;
 b=UJtABtRpe2tvy/PC4atFKzT4jNdceK5YKM1e+heRrzL4A6DcbmSfXiEsGHNOP/qg8U+ASsk1
 UFi58FJYDX7qiFzJ8sGT1ilrEMDphyW6IXp1RSny0ARyCTrgV+yG3l5RPiR+1ytIkn82E5yt3/0
 IvqIe9FmibT12O1J3Moq+4F/Ou2iE6EK9KgjFwssvAZh+BwYrchVeOsZ1pn1ClIjemVeC2eH7nY
 QsMDFNW4lKBym1DQibTZTyMUHuKmDZGAFJYAR29AgVr24mVoNskAdNBqlPs2WVBTrS0VJkMG4c4
 Od2zQtxcw2xuP6IbBR4r2/hTQkXhZtr2Yq+WTm4dsE/pA==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id BF7A622F0C;
 Thu, 12 Nov 2026 15:03:09 +0000 (UTC)
From: ~mohammadodeh <mohammadodeh@git.sr.ht>
Date: Sun, 27 Sep 2026 10:08:13 +0300
Subject: [PATCH qemu 1/3] hw/block: Add Macronix MX25R6435F flash
Message-ID: <179449578952.8382.2790865629085512841-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <179449578952.8382.2790865629085512841-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Samuel Tardieu <sam@rfc1149.net>, Alistair Francis <alistair@alistair23.me>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Bin Meng <bin.meng@processmission.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Nov 2026 10:51:10 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: ~mohammadodeh <Mohammad.Odeh@exalt.ps>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mohammad Odeh <mohammad.odeh@exalt.ps>

Add the 64-Mbit Macronix MX25R6435F serial NOR flash model, its
SFDP data, and the 1-4-4 quad page-program command used by the
device.

Signed-off-by: Mohammad Odeh <zephyr@exalt.ps>
---
 hw/block/m25p80.c      |  5 +++++
 hw/block/m25p80_sfdp.c | 20 ++++++++++++++++++++
 hw/block/m25p80_sfdp.h |  1 +
 3 files changed, 26 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index baf798c6b5..9b931f5861 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -243,6 +243,8 @@ static const FlashPartInfo known_devices[] =3D {
     { INFO6("mx25l25635f", 0xc22019,     0xc22019,  64 << 10, 512,
             ER_4K | ER_32K), .sfdp_read =3D m25p80_sfdp_mx25l25635f },
     { INFO("mx25l25655e", 0xc22619,      0,  64 << 10, 512, 0) },
+    { INFO("mx25r6435",   0xc22817,      0,  64 << 10, 128, ER_4K | ER_32K),
+      .sfdp_read =3D m25p80_sfdp_mx25r6435 },
     { INFO("mx66l51235f", 0xc2201a,      0,  64 << 10, 1024, ER_4K | ER_32K)=
 },
     { INFO("mx66u51235f", 0xc2253a,      0,  64 << 10, 1024, ER_4K | ER_32K)=
 },
     { INFO("mx66u1g45g",  0xc2253b,      0,  64 << 10, 2048, ER_4K | ER_32K)=
 },
@@ -405,6 +407,7 @@ typedef enum {
     PP =3D 0x02,
     PP4 =3D 0x12,
     PP4_4 =3D 0x3e,
+    QPP_1_4_4 =3D 0x38,
     DPP =3D 0xa2,
     QPP =3D 0x32,
     QPP_4 =3D 0x34,
@@ -759,6 +762,7 @@ static void complete_collecting_data(Flash *s)
=20
     switch (s->cmd_in_progress) {
     case DPP:
+    case QPP_1_4_4:
     case QPP:
     case QPP_4:
     case PP:
@@ -1255,6 +1259,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
                           "QIO mode\n", s->cmd_in_progress);
         }
         break;
+    case QPP_1_4_4:
     case QPP:
     case QPP_4:
     case PP4_4:
diff --git a/hw/block/m25p80_sfdp.c b/hw/block/m25p80_sfdp.c
index 8ac603e212..29fc6aa5af 100644
--- a/hw/block/m25p80_sfdp.c
+++ b/hw/block/m25p80_sfdp.c
@@ -135,6 +135,26 @@ define_sfdp_read(mt35xu02g);
  * Matronix
  */
=20
+static const uint8_t sfdp_mx25r6435[] =3D {
+    0x53, 0x46, 0x44, 0x50, 0x06, 0x01, 0x00, 0xff,
+    0x00, 0x06, 0x01, 0x10, 0x10, 0x00, 0x00, 0xff,
+    0xe5, 0x20, 0xf1, 0xff, 0xff, 0xff, 0xff, 0x03,
+    0x44, 0xeb, 0x08, 0x6b, 0x08, 0x3b, 0x04, 0xbb,
+    0xee, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0xff,
+    0xff, 0xff, 0x00, 0xff, 0x0c, 0x20, 0x0f, 0x52,
+    0x10, 0xd8, 0x00, 0xff, 0x23, 0x72, 0xf5, 0x00,
+    0x82, 0xed, 0x04, 0xcc, 0x44, 0x83, 0x68, 0x44,
+    0x30, 0xb0, 0x30, 0xb0, 0xf7, 0xc4, 0xd5, 0x5c,
+    0x00, 0xbe, 0x29, 0xff, 0xf0, 0xd0, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+};
+define_sfdp_read(mx25r6435)
+
 /* mx25l25635e. No 4B opcodes */
 static const uint8_t sfdp_mx25l25635e[] =3D {
     0x53, 0x46, 0x44, 0x50, 0x00, 0x01, 0x01, 0xff,
diff --git a/hw/block/m25p80_sfdp.h b/hw/block/m25p80_sfdp.h
index 61544fb7cc..da3e7d74bc 100644
--- a/hw/block/m25p80_sfdp.h
+++ b/hw/block/m25p80_sfdp.h
@@ -19,6 +19,7 @@ uint8_t m25p80_sfdp_n25q256a(uint32_t addr);
 uint8_t m25p80_sfdp_mt35xu01g(uint32_t addr);
 uint8_t m25p80_sfdp_mt35xu02g(uint32_t addr);
=20
+uint8_t m25p80_sfdp_mx25r6435(uint32_t addr);
 uint8_t m25p80_sfdp_mx25l25635e(uint32_t addr);
 uint8_t m25p80_sfdp_mx25l25635f(uint32_t addr);
 uint8_t m25p80_sfdp_mx66l1g45g(uint32_t addr);
--=20
2.49.1


