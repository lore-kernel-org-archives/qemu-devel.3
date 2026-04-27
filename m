Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E329FF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH1G-0000oe-RZ; Mon, 27 Apr 2026 04:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH10-0000iR-4s
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:08:27 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH0y-0001b6-Hb
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:08:25 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4890098abbaso77827915e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277303; x=1777882103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qNtUCJEojkga+haWLj/ILWXdDy+o/7LVCJo0CbKm7kQ=;
 b=ggZb/aWJYZTF7XOIzFGBKOKWLn43BG0G86jPt71pU2fn9HZ2QfcHTpvB9tCfgjomm+
 RoOyvAHLZWl34xNZR9fhRZSZYBgbnoF9WhI4KRZJ3W4/BR1X8z24R8cMKSMtmJHd1LKc
 nofGRWQqZXKZStUDBTh62bOVBFQjlsNc7m3dUPcYHajOBMWZy17kvs2Xk175vJBgIY2L
 a2vIjRcwHy8ZBn07sDx0To58P9mPKmytY6rxA9+ytXaUrjoSjQb1k7PI8bdXD3qm4AQe
 uTg93f5jhCRTpAnIglVzMPgbOnew2xZnwvoj8iH2Lnez/h/SPRDPDD75MUrxSerwmjCI
 9DmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277303; x=1777882103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qNtUCJEojkga+haWLj/ILWXdDy+o/7LVCJo0CbKm7kQ=;
 b=PynT5+wLcGmPfLVJhMgvOQOAa2FD0tQmfCt9yd+c25kI+jNClA0oPdDluFnuJ+aEmu
 vB4uAt/u5ITDQcV0qnGE4DtFJghNVcntxV+qLRQTzdjmzf45H/orhP5rMVm+FKi1jssr
 r5HOCG2SWi3nI3mx+GsV9X780y0elb2yqv8aMDuFkef8yCZwfZC+42A54KdYHFa09/3R
 sUGDDHoGiB6oFnQNlMJ55o5aSKAAjHpkfHRyXBTkGKU8/TBgya0r7z3GJfgLJIq/9hgm
 aIFySEIjM4nfx+XLv5icbh1PLVblmYm8EbzDv2/KmQmo9PaHh0afHe4qGWOF/SCO0EPt
 m3qg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Bsbvce+GTXDXiltTcRBbzbn679Jp79EUNUlUY24WjV3v6fmrqbNJXAG846TymACVumulWD4lfC16I@nongnu.org
X-Gm-Message-State: AOJu0YyR1QC3w55/xHj0crKrx/ysLxSBfETCqcSkgBjoWM1hM8M76dSa
 HTnrn69s61q0q9Re4CPZUVAAzHTpMd0nvSRAuun4D36Xcir8fzMXSdkCcshg2ZU8FmDXcL2o0dK
 gPFHbQ08=
X-Gm-Gg: AeBDiet9s1xQrJj7/pstY6El2aAP3DuTiLJCSXdShwiYXXVFQh7tM0z6hFlzXwGS8f9
 Nv5LUjV/SUmL8J4vA0H7wnfDv3RM6Jsd83gTTKXGgwLhkuUcRaKxVuKp36r3zTDpHSgki17Q4Aq
 s5/X09BOcltPQ7kKAnAJDooVop31a3FZu6lyfhIJXE1epVhAG7f1ygE+lFFxNJJRBeCMubPe2OE
 u+UiMLn/pGSTWiQUCvF0cEd1qEHZilbkyXsRMxsPNiQ5gmqz1k+lAlneSfjWiJP2a/DNrhVwImG
 XsHu7gOydt230FI5VOgBFc9rGcSRqMxDrfTQ3xEzAHWaHFEmdf32hMzi/Tnijg5d5lKSNVtvx/h
 hj1eUYoa/gnVinjsFMJi001jR70XjhbOv88Sy2ng7fBic9gzIaKhb/svzbxrc+QzPanGgpqoqWf
 v37LV1hlvCwxp+rqigGi78nnHKcy+tA0DzUCds7x5AXHa7diqoYBgtoFDPmho2spB0FpJq5Bjxc
 tqwNeITJyA=
X-Received: by 2002:a05:600c:621a:b0:48a:592c:e642 with SMTP id
 5b1f17b1804b1-48a592ce867mr333974625e9.18.1777277302759; 
 Mon, 27 Apr 2026 01:08:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb77b001sm369730625e9.3.2026.04.27.01.08.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:08:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 06/32] monitor/meson: Use SPICE with migration HMP commands
Date: Mon, 27 Apr 2026 10:07:12 +0200
Message-ID: <20260427080738.77138-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

When moving code around in commit 27be86351ec ("migration: Move
the QMP command from monitor/ to migration/") we forgot to update
the meson rule about SPICE pkg-config flags.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 migration/meson.build | 2 +-
 monitor/meson.build   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/meson.build b/migration/meson.build
index c9f0f5f9f21..e583822dec6 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -23,7 +23,6 @@ system_ss.add(files(
   'fd.c',
   'file.c',
   'global_state.c',
-  'migration-hmp-cmds.c',
   'migration.c',
   'multifd.c',
   'multifd-device-state.c',
@@ -37,6 +36,7 @@ system_ss.add(files(
   'socket.c',
   'tls.c',
 ), gnutls, zlib)
+system_ss.add([spice_headers, files('migration-hmp-cmds.c'), spice])
 
 if get_option('replication').allowed()
   system_ss.add(files('colo-failover.c', 'colo.c', 'multifd-colo.c'))
diff --git a/monitor/meson.build b/monitor/meson.build
index 2647100e04c..585251804e4 100644
--- a/monitor/meson.build
+++ b/monitor/meson.build
@@ -5,8 +5,8 @@ system_ss.add(files(
   'hmp-cmds.c',
   'hmp.c',
   'qemu-config-qmp.c',
+  'qmp-cmds.c',
 ))
-system_ss.add([spice_headers, files('qmp-cmds.c')])
 
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
-                if_true: [files('hmp-target.c'), spice])
+                if_true: [files('hmp-target.c')])
-- 
2.53.0


