Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3E1C35FE7
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 14:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spqCK-0003bA-G2; Sun, 15 Sep 2024 10:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1spoov-0006NL-VI; Sun, 15 Sep 2024 08:57:42 -0400
Received: from zproxy4.enst.fr ([137.194.2.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1spoot-0003c6-9d; Sun, 15 Sep 2024 08:57:41 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id AB901207A0;
 Sun, 15 Sep 2024 14:57:33 +0200 (CEST)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id wXTK8bTEcPei; Sun, 15 Sep 2024 14:57:33 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 16B372074D;
 Sun, 15 Sep 2024 14:57:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr 16B372074D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1726405053;
 bh=61IWChj066lC9mznhlQQqTTzjbiEacGVJFsxPyAEhhg=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=I5Ao+IIOdcUvb9i44/9u34fcDHRZ7eLuNYu7oSEpRK2lQQHhxYKWkCy42jwsFFewJ
 3o2JnNOvVzC0TI14qncbYqTVkujOjtOAOwcIW+h9bV9SpAz1in4rPxpbbdbt47QFWl
 J1s3LRm/23uRIRiKfX4OX2FL/4NuYlBApkmzbols=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id rOHjoqyqAgXH; Sun, 15 Sep 2024 14:57:32 +0200 (CEST)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:124::190c])
 by zproxy4.enst.fr (Postfix) with ESMTPSA id 0059F2070E;
 Sun, 15 Sep 2024 14:57:31 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
Subject: [PATCH] hw/display: Fix mirrored output in dm163
Date: Sun, 15 Sep 2024 14:57:00 +0200
Message-ID: <20240915125725.33099-1-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.223;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy4.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 15 Sep 2024 10:25:54 -0400
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

DM163 is an emulated 8x8 LED matrix. This commit flips the image
horizontally so it's rendered the same way as on the hardware.

Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 hw/display/dm163.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/dm163.c b/hw/display/dm163.c
index f92aee371d..75a91f62bd 100644
--- a/hw/display/dm163.c
+++ b/hw/display/dm163.c
@@ -271,7 +271,7 @@ static uint32_t *update_display_of_row(DM163State *s,=
 uint32_t *dest,
                                        unsigned row)
 {
     for (unsigned _ =3D 0; _ < LED_SQUARE_SIZE; _++) {
-        for (int x =3D 0; x < RGB_MATRIX_NUM_COLS * LED_SQUARE_SIZE; x++=
) {
+        for (int x =3D RGB_MATRIX_NUM_COLS * LED_SQUARE_SIZE - 1; x >=3D=
 0; x--) {
             /* UI layer guarantees that there's 32 bits per pixel (Mar 2=
024) */
             *dest++ =3D s->buffer[s->buffer_idx_of_row[row]][x / LED_SQU=
ARE_SIZE];
         }
--=20
2.45.2


