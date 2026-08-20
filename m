Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EBAC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwzhk-0006oU-2h; Thu, 20 Aug 2026 06:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhh-0006n9-B9
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:08:57 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhd-0008Io-Hg
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:08:56 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so1956785f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787220532; x=1787825332; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XyPzbjMy6v/JTvTk8bqzZDyIH2YLdq6RbLehiJKH+ZA=;
 b=qZ+wMUfsgYrHA32BzNkphZRBKchGA4lBKY99Cukq7KF8ScarcwnTKb1/ce+lCqZdv6
 p0B0Ba8Flzlgk/7hUgkZPEY9D+WBb3GbvBB2zs2UTat7rPhRAL0JkUnRTuKW5tvYchnm
 W5lQW4H9oCoeTDNkQNcycJkQcgt5NuKE+rBfYXsrgq3eX6/fsNiKXfK8PUU94Kl7uci+
 ch6NWnmuh+42fzMzxlrpY3QNdiIkJFN2D1Bviy2LE0bQfTmEmCkRZvdY57LQBJZHbHz0
 U+B8BcrT4ypwwuOpi9cJoasl2z5BB3UUzJT/pCCm6VWltZDV4flD7gQd1huApdyXXi/M
 Qevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787220532; x=1787825332;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XyPzbjMy6v/JTvTk8bqzZDyIH2YLdq6RbLehiJKH+ZA=;
 b=ZzLr/4T09HNHQXERUb03CpvB33ovp8cx8EmS27h1mlWiQsiv+jnTVwB8rq5sdgtYYP
 UTGzhpZ7mFiub54NGnXr4eZWeSn70rwYp8X0oQpPjMaOsaPulOtSxyK0c3ZcagvqmFnZ
 bnqXZ3MaurI+maj0rdAZdUVXGJ4Of+bkNfv5VWgOQHNPvSPTiBohQ+vZzKNK7b/TrH+e
 EQQMHtoQ52aCXqT0si+M23Dyj7/KOaUrXs0Xk5koB+MoloZLpidZAyIuupoJIN5XFQvj
 zkXTv0+k5yVqePOfPdONuh2JxJn7z08EIW360fyyGTQXVSIqbLVGyEocdi3JcoAO3r1M
 NOsw==
X-Gm-Message-State: AFuF++lQbtJw9/FHk9Wqh5FErE3zGOcOvfkZ94PCU5/DwJrMr4MpL+HI
 7GthJbISCBMBrAWxATrFYyZJPshU0TpJZvsWc8litMcYnyaLjWFxmvOnKVsbkqbG5mtyIp/XLou
 sGN9O
X-Gm-Gg: AR+sD123VhHkr3J/3BAtWd6Ugfezou+hfeTLG8p0AXs5Tnx3od7FM0EGpkMw1uK5t1B
 mxCGtYAhp8nj1reIoRZlT1goCg9ABLigjXLgPdVc8TkNQaBMLBT5Rphs+08DWpkPdViDpkyAr3X
 CrLV8b8vZf0d6bkNza+uRW2a88xOKLk/oMEQWzoaH8JFQ+yQnu2Nq7zdGEwU6O0d++XG2tVp4N7
 2ddu5OcmeglW6wV5cfq5dkL0AMdrlMwU3wp39S8oxTuQ3XvK4A9vBeSeelNbK68jJaaIcV5eBjj
 RsLnzsehgOHnE/juFtsmmTwtWrxsSAfdChA+paCBGAgdwVARLg1evIJVNzPoSepDWv2mPsmtp1s
 Bco2NTr41Ndn64DSVjDyGpdK21IsWtzklmE/qhiJIs4Kgq3+JHUIgR+lhBUJ+Xs0RVkzDXUi5Cr
 7Adk00fVr68h9lvcyZBoayz8nZu8sI0uMfDmFBsBPBP2dhFPw5oa7kHRh60wZob32IBz1N
X-Received: by 2002:a5d:59a7:0:b0:481:511c:8d45 with SMTP id
 ffacd0b85a97d-482b1ff5789mr22005353f8f.20.1787220532118; 
 Thu, 20 Aug 2026 03:08:52 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441b0fsm11678929f8f.4.2026.08.20.03.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:08:51 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v2 01/17] hw/ide: reject an unsupported CHS translation
Date: Thu, 20 Aug 2026 12:08:28 +0200
Message-ID: <20260820100844.411717-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820100844.411717-1-den@openvz.org>
References: <20260820100844.411717-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=den@openvz.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Denis V. Lunev <den@openvz.org>

ide_set_sector() divides by (s->heads * s->sectors) when the drive is
addressed in CHS mode. Both come from the guest via INITIALIZE DEVICE
PARAMETERS, and cmd_specify() stored them without any check, so a guest
asking for zero sectors per logical track killed QEMU with SIGFPE on the
completion of the first CHS read or write. s->heads is safe, as the
command passes a heads-1 value.

The count has an upper bound as well. The legacy sector count register is
eight bits wide, but handle_cmd() takes the count from a 16 bit field of
the register FIS, so an AHCI guest can ask for up to 65535 sectors per
track, and the CHS branch of ide_get_sector() then overflows the int it
multiplies cylinder, heads and sectors in.

ATA-5 6.2 numbers CHS sectors from one and ATA-2 D.2.8 limits IDENTIFY
DEVICE word 56 to 1 through 255, so neither end is a translation a device
may accept. ATA-5 8.16.6 requires an unsupported one to be reported as an
aborted command: do that, leave the translation in effect alone, and
refuse the value rather than checking it at every use.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: qemu-stable@nongnu.org
Fixes: 176e4961bb33 ("hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS command")
Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2399
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/ide/core.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index fb9bf11b45..747fa71677 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1655,14 +1655,21 @@ static bool cmd_check_power_mode(IDEState *s, uint8_t cmd)
 /* INITIALIZE DEVICE PARAMETERS */
 static bool cmd_specify(IDEState *s, uint8_t cmd)
 {
-    if (s->blk && s->drive_kind != IDE_CD) {
-        s->heads = (s->select & (ATA_DEV_HS)) + 1;
-        s->sectors = s->nsector;
-        ide_bus_set_irq(s->bus);
-    } else {
+    if (!s->blk || s->drive_kind == IDE_CD) {
+        ide_abort_command(s);
+        return true;
+    }
+
+    /* ATA-2 D.2.8 limits IDENTIFY DEVICE word 56, and the count, to 1..255 */
+    if (s->nsector == 0 || s->nsector > 255) {
         ide_abort_command(s);
+        return true;
     }
 
+    s->heads = (s->select & (ATA_DEV_HS)) + 1;
+    s->sectors = s->nsector;
+    ide_bus_set_irq(s->bus);
+
     return true;
 }
 
-- 
2.53.0


