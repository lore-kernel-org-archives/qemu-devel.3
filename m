Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4702ECCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBttH-0006ZL-9P; Thu, 23 Oct 2025 07:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBttE-0006U3-5L
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:53:56 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBttC-0002fF-9u
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:53:55 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-475c1f433d8so5978895e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 04:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761220432; x=1761825232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJbOfgCSRJVEsgKWpcu4Ftzf4/H1829jkVWLENUxHOU=;
 b=GNSfhNlWI0lCWdm0Kvn36isA5hTPyNrQvdY2JHa6/mRuNja+VJsll4TL68zD6vRp0Z
 +76KApIFYl0ScvCkFdumLsJD7GQL1Kytk4Hdkzzxf6o8BoVw9VRkUoxKN7To4F2n2BDc
 x4YDSQjLTsrDb8vxAHo9/BCLP82JjCNHh6bWiGZyeiXYosmOrq5Mch5/dCTcqD34Xato
 eqHsqGbQGci1xWhvG5nmKWOMZ32Hkur0ee7eJgCswNgq40GG3kxWvx47QWFvn/a96650
 yfv0hHPQA68ESSOpV/Q/Wdy8Y8q30U0naKFgScUtFSpGV7dvmo2IQFJJLuN81DM9unQt
 SWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761220432; x=1761825232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zJbOfgCSRJVEsgKWpcu4Ftzf4/H1829jkVWLENUxHOU=;
 b=TLys/vDEkKovG37YHOBAN1xNjzCfng5kifebzUP99WgQ+JWj4+HnMVHqd+rCR3o9qc
 2n3lhVX96e8eEflT+LtC9XqWsHC7wCpbRkupbsg9o1lwmHC9YIlaA4qtPQJa+/cnMAHi
 gIkEgmNvWEw2JL03JZcOrQQFwS9+Ptil61vGaq52izTY/SttdgxRsjaJTdqKAE9tzE4O
 yyhpk69DpbRNAqZZqJXd95Ur2Q47mjpehmBrujYyzYJ+E8ZTA4e7RpKTVPnRzxYKRxBW
 SHrT7R0vrEUgM1J8AWgHMZuCrfm9HiH2nKfT7Adoyx36f9+Fh7kbxn6mbz4FrOEw5WNZ
 TmmQ==
X-Gm-Message-State: AOJu0Yy+CgR+YENe6woXDPVXpQ1gh+mlLT0QOuHQdW03edgCFSxK3XM+
 T0tyJfPBQfDWSBd+s1UOF4x3A95YR5R0abp3S1Ye+F4ok/QVwWB3i46Zp6fvKtskQvkkYumMFEp
 QShTfngw=
X-Gm-Gg: ASbGnctK2YjpbSoBJ+BxTENHCllOm44oZbZpP3z98Kt+tMeTPeAPj3n/aDqqPW7Ip8u
 Rm7PLNFy2HM2fMabhg85b6NSqezy6Pz3FIMV65S5ceX2HD23KZ+vB3qbM+jxB/ehuNgfKn67ojt
 9yv1pj6yitYQAoU9S/7Ps31xPy9lO6veUi/1O/N7qOAqyil1ModfPC4Qz0MG4Z83Ici2wN+cQmD
 u2F6pZ2IejI0Iy7bsgUsunYlQedaq8t62I9Eo16E/yXAKOvyRHRXVqlvrd3XQQsJJQLN5NWzS6O
 FQuz4kbh4a+5aM3ffR0jmk5fQcdiGorQgH4lnDn3yv+iVI+arPMhdgf/5EZiv82qkJuY9/M589t
 geiTprPgBtJ5jErSr6LB7l6plMPMRiP+sSuptrpgIlgFZpdyWpEuz7ONn4qY9/Quf9vn42K7Ojd
 3oQj6TdxmAz7tiOk8AhnJFsOb6gcBToMGJ8xVzjHmgItn6CkHyMRpesb7A1/wBASPBQG/y9v0=
X-Google-Smtp-Source: AGHT+IEnkL0yRDryjcuiYy7eTbFDJ4a2Y9x9j9B9l8A0D8M9wF229UnFNNLEbNkSJ68l94/JSNIiTA==
X-Received: by 2002:a05:600c:3b8d:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-471179176b9mr206095785e9.28.1761220432357; 
 Thu, 23 Oct 2025 04:53:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475caf4642fsm31945115e9.17.2025.10.23.04.53.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 04:53:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 38/58] accel/hvf: Move hvf_log_sync to hvf_log_clear
Date: Thu, 23 Oct 2025 13:52:49 +0200
Message-ID: <20251023115311.6944-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Right idea, wrong hook.  log_sync is called before using
dirty bit data (which for hvf is already up-to-date),
whereas log_clear is called before cleaning the range.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-all.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 1be419652e0..844cc179de2 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -220,12 +220,13 @@ static void hvf_log_stop(MemoryListener *listener,
     }
 }
 
-static void hvf_log_sync(MemoryListener *listener,
-                         MemoryRegionSection *section)
+static void hvf_log_clear(MemoryListener *listener,
+                          MemoryRegionSection *section)
 {
     /*
-     * sync of dirty pages is handled elsewhere; just make sure we keep
-     * tracking the region.
+     * The dirty page bits within section are being cleared.
+     * Some number of those pages may have been dirtied and
+     * the write permission enabled.  Reset the range read-only.
      */
     hvf_protect_clean_range(section->offset_within_address_space,
                             int128_get64(section->size));
@@ -250,7 +251,7 @@ static MemoryListener hvf_memory_listener = {
     .region_del = hvf_region_del,
     .log_start = hvf_log_start,
     .log_stop = hvf_log_stop,
-    .log_sync = hvf_log_sync,
+    .log_clear = hvf_log_clear,
 };
 
 static int hvf_accel_init(AccelState *as, MachineState *ms)
-- 
2.51.0


