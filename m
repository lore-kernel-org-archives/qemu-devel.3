Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA94C61DE1
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 18:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0kNc-00039Y-92; Sun, 30 Aug 2026 14:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x0kNa-00039F-PT
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 14:35:43 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x0kNY-0003vg-KN
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 14:35:42 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49b392ccaacso36983295e9.2
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 11:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788114938; x=1788719738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KZKl9g/UZeRYJu6FsqErpKA6vDCHKGHPgIylahbayf0=;
 b=suwSnzsA1rIDZVFJFNrOfoJZhgEqsIc362bnO/itPSxXzV8UOmelvB+wv/uA2cpZcB
 4146JzhAn92nUxY/K8SAF8PITL+Miz9MS30kIVd2dXFNEEdVcABZQFuClCE76LMUZ1hH
 G5z+Bb4QTyl7lSUSXbUJU4MuD+Ayizz5srb3WaCPeBXffn4F794EM0YMj5Z1qVmJ1xGo
 luqjmq1r4HpHYaNdk350gPVCp1BmRYFBxao2Bbu1W/wSMOr7katxHemOINTnhqMR0QyF
 PAeh13zQREWt+hQj0c1t2Bw44+3WzrLZr3+1FRTU58uIyJiSJkkHH2r/RkI4T4b4LchX
 Wrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788114938; x=1788719738;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KZKl9g/UZeRYJu6FsqErpKA6vDCHKGHPgIylahbayf0=;
 b=O9XgHOhFYgI1Pn7fFQyooDLwCKaX5KAkBOgXXiD3XM5KEHRFznJZf8zU3k0o6Ehngi
 9gscEjHNUJWIHxlcEoJ7fjwdqDY6zXUhXhb2t74DJxfr+GVSnpcShH/1w3MbQlLj8w3O
 o41PLxfIitXHdOoMfcCMn+rMn0Sx7SOCM5meovhdGLRa1fHoqtvpPfVpg8Q940cBe/xy
 mg/XKW8o16C5lHvpkQv+LHggdLwVWGY+7i0DEEYK0e8U7xiLIz+hIcsxFRpZ0CuywLib
 n2ruHjMygWLgXeJ4hI4udu+2B2jAn7W6Zlfkp7pp6Kfkh3vOH0trHhD8rmEXaIJm+O2g
 xU6A==
X-Gm-Message-State: AFuF++mPF5nt9DeDuZwzHHy1BGJ2FU5mU2sG5ovnkoXk361yQ7OPOnKk
 fV68h6+C4Cn5BWCWkGnCUeCsd5KqyxMZ3SIuO1EYBSkJuiFzN0P8jH0AJRgwgm8t43C4XrxMQzr
 H+ZL+
X-Gm-Gg: AR+sD10vgWrg67ZXuUoHUTQNIXegfIyhOjMUmd9siAz/AVYc6t0Fwlpe/jdlfD+a/gx
 4dn00+r0rygyMiiUFZUWKQZkCl30lGW/OvsPP+nGFiEtXcWjGfi8ohkNgTTKPNa3hKd6bGNexiV
 SGh0C3qF/pUIZ8Ei59LkAjphAFVLsKTwBWVilZks/qezhK5OtkgOanov9if9fqFBK43UyaO02ga
 nS3ehr8YW1Srx1h5oO7nojpFdxdFN0PQxNBwg4eAP5moNWSh3TJq2GCqntXcxbfsBMtagIzGFMt
 A3FaoQbYJMUC4i5CSvwt7AErxUGExRrA/O7A5kfTxonvxrKRE2EgqqW+pGpQLD2+GuWnwoF1NwO
 YR5oRC9tVWGR4mfBhPW4ZNzNEETHN1n2dtVOrBYQfYgn1cF+7xpTu+ZjvshDo7cBQOyjMPDX6lP
 Z6N5N7okYeQZCI27mUpGT4hhk8HpfjyvkISwZgNFVaLbEhNdtYmg==
X-Received: by 2002:a05:600c:1d11:b0:496:c1f3:e8f8 with SMTP id
 5b1f17b1804b1-49b91c25414mr279695125e9.7.1788114938102; 
 Sun, 30 Aug 2026 11:35:38 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:62df:a7bb:fcfe:51e0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ccea6b814sm117015775e9.0.2026.08.30.11.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 11:35:37 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	"Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 1/1] tests/qtest/ahci: fix a racy deadlock in the engine stop
 test
Date: Sun, 30 Aug 2026 20:35:34 +0200
Message-ID: <20260830183534.104435-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=den@openvz.org; helo=mail-wm1-x32e.google.com
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

test_write_engine_stop_in_flight() resumes the suspended backend write
and goes straight on to restart the command engine and read the second
sector back. Whether the write has retired by then is a race. While it
is still outstanding the drive is busy, and handle_cmd() drops a
command that arrives in that state instead of queueing it. Nothing
retries the drop, so the PxCI slot stays set and no D2H FIS is posted.
ahci_command_wait() polls both with no timeout, so the test deadlocks
until the harness kills it.

Drain the port before issuing the read, so the abandoned write has
retired and the engine is idle. Host load stretches the gap between the
resume and the write completing, which is why the deadlock only shows
up on a loaded machine.

Fixes: d05ae87e7a6a ("tests/qtest/ahci: regression test for a PIO write vs. engine stop")
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/ahci-test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index b143862ce7..2552fa39f1 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1914,6 +1914,12 @@ static void test_write_engine_stop_in_flight(void)
 
     g_free(qtest_hmp(ahci->parent->qts, "qemu-io drive0 \"resume wr\""));
 
+    /*
+     * Retire the abandoned write. handle_cmd() drops a command that arrives
+     * while the drive is still busy and nothing retries it.
+     */
+    g_free(qtest_hmp(ahci->parent->qts, "qemu-io drive0 \"aio_flush\""));
+
     /* Round-trip through the device to confirm qemu is still alive. */
     ahci_px_rreg(ahci, port, AHCI_PX_TFD);
 
-- 
2.53.0


