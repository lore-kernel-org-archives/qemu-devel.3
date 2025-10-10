Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA057CCD18E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7DOw-0002F9-6U; Fri, 10 Oct 2025 09:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7DOt-0002Da-Dt
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:43:15 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7DOW-0007sQ-83
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:43:15 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46faa5b0372so13328305e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760103766; x=1760708566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=61NQQUfc5AHH6sOajFhd3xe+bOM3Liy2MIqh9GGhkaQ=;
 b=blXreB/V8dK5HYLUa7/X02sv/fssOGeMRXB+QnSf28A2WZxhISeZ9HlSDuq/34HgsO
 yF6dgPCxCcbXGRiJ2hx6RgwDIJq6STqNICbNnnRtPNZJoVodbjBpLXabAWjKHDUqxPFK
 JkH8Rkl4Rep/GCGrdU/2v2Z8v7A73VJ+NfXbhsJvad+TovJWU4e2doZa1GFwn5QF4Rf7
 FPzCJWJpjWXc1K1EUArhttc8N5T5AIM/QhX3IeWbuw3+o4k2wu2r1oqTJvHRXYW4Csgy
 t9VQxNAsPRvzl1zEPIABrllqN3SMwnbfgAMpH9mQXyP4RV+j2K/T2jhovh+HLzFFbGX7
 n7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760103766; x=1760708566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=61NQQUfc5AHH6sOajFhd3xe+bOM3Liy2MIqh9GGhkaQ=;
 b=knenutEZgnhsTwJbeiR+1zvGn5ZLmIGqOVRV1RMZHFHpicm+bH4ceAK4a/2ndPDVVR
 S19DOI7ZalvkOzLR7VTnaKYEv/tVBuFM4x/zB7za3fn9aTEbosHWpmqmJKwu6mKvNJsV
 2i0qXZHSFmOgcfB2+trCcq9IElBejeSJ0cJPJyNcBRRWBNBzMa3BrmEaDnb8epoEpWGh
 DSuxiuRFE3gLNVOqzPJZQLaucmmKTDtHNzJozrCEX3h3JguB2O49MYsTbhLBmsUXeXHF
 E4yJ93IQvaNwIRBIuE1k15loI9AEIvpRtnDjDX1qCwPKDWJtV3pczG+pMNLT6EHTd8tB
 fWHw==
X-Gm-Message-State: AOJu0YzXzZnRTA669K00rA0TqZ0Vzs+PO9V9/yBiqdTBRkPkTv8n4e/i
 +04/wSbllXDsKndbM0oC8ECeJLCAhOvylOHHFBJOy0jgB/OyIlp6NqebBwYWhvBPDn6bLqs4sJp
 48hvtwlzvyg==
X-Gm-Gg: ASbGncsFV7dL3FzPQWoS+cDju5G3wg0BLZEJ5Zg7iUDr5uXBSH96OJGqyiGknXG5JK1
 qe7GaNGVJfOd/xqNjlTt/SY31KC33mm6DtDvhR0jZ9MpWltWxa2nb03Agm4ydQI2VWqcb6gV6Io
 LGqqoYOvaXs7hle1oGJjLC65Vk6KweOoibfqPqBYmBQhwi9MalD4YWxMmDfL3kpA9VteMIUh4iW
 +uPoZWhRBgv6K4WMQYGdxRI52/bSSG4zrpiD2KsLDeGaLvbUYrlX5J/Qc6pZoT4qMT8UcZ+wSSi
 OKZX/+mbxNYHoIH+VVwiR0H6Pa5H2t7WxRb7zK7CRet1LUr+mJ8Bl6es4GgXrEhSbteUi6wVIQz
 n8ICJxi3Gb91SjBspeUx+fM0sOu+LdokXyhuTACfhlLbOUXOLE3VpH98TfVsNNxWEA/ul8tpTi/
 70bp+hvfWm40OpYjzPTtgMD/olHqR87Q==
X-Google-Smtp-Source: AGHT+IEL530wYI6ec2dvGV8IhPhoS7pJXv2tYfyowgqvyrI+XiBgK9StQAaWW4IwhCKK6t2MFVEECw==
X-Received: by 2002:a05:600d:4203:b0:46e:6af4:ed83 with SMTP id
 5b1f17b1804b1-46fa9af9099mr85429505e9.23.1760103765671; 
 Fri, 10 Oct 2025 06:42:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb48a60b8sm47789695e9.19.2025.10.10.06.42.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 06:42:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 03/16] ui: Replace HOST_BIG_ENDIAN #ifdef with runtime if()
 check
Date: Fri, 10 Oct 2025 15:42:12 +0200
Message-ID: <20251010134226.72221-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010134226.72221-1-philmd@linaro.org>
References: <20251010134226.72221-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Replace compile-time #ifdef with a runtime check to ensure all code
paths are built and tested. This reduces build-time configuration
complexity and improves maintainability.

No functional change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/vdagent.c | 16 ++++++++--------
 ui/vnc.c     |  6 +-----
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/ui/vdagent.c b/ui/vdagent.c
index ddb91e75c64..66dc33567df 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -660,14 +660,14 @@ static void vdagent_chr_open(Chardev *chr,
     VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(chr);
     ChardevQemuVDAgent *cfg = backend->u.qemu_vdagent.data;
 
-#if HOST_BIG_ENDIAN
-    /*
-     * TODO: vdagent protocol is defined to be LE,
-     * so we have to byteswap everything on BE hosts.
-     */
-    error_setg(errp, "vdagent is not supported on bigendian hosts");
-    return;
-#endif
+    if (HOST_BIG_ENDIAN) {
+        /*
+         * TODO: vdagent protocol is defined to be LE,
+         * so we have to byteswap everything on BE hosts.
+         */
+        error_setg(errp, "vdagent is not supported on bigendian hosts");
+        return;
+    }
 
     vd->mouse = VDAGENT_MOUSE_DEFAULT;
     if (cfg->has_mouse) {
diff --git a/ui/vnc.c b/ui/vnc.c
index 77c823bf2e8..e93b5335690 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2348,11 +2348,7 @@ static void pixel_format_message (VncState *vs) {
     vnc_write_u8(vs, vs->client_pf.bits_per_pixel); /* bits-per-pixel */
     vnc_write_u8(vs, vs->client_pf.depth); /* depth */
 
-#if HOST_BIG_ENDIAN
-    vnc_write_u8(vs, 1);             /* big-endian-flag */
-#else
-    vnc_write_u8(vs, 0);             /* big-endian-flag */
-#endif
+    vnc_write_u8(vs, HOST_BIG_ENDIAN);         /* big-endian-flag */
     vnc_write_u8(vs, 1);             /* true-color-flag */
     vnc_write_u16(vs, vs->client_pf.rmax);     /* red-max */
     vnc_write_u16(vs, vs->client_pf.gmax);     /* green-max */
-- 
2.51.0


