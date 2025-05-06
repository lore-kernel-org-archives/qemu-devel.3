Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F47CC3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJVl-0002rW-L7; Tue, 06 May 2025 10:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJSs-0007oO-88
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:40:13 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJSq-0001my-C4
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:40:09 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so4746878f8f.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542406; x=1747147206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eXL4/W2KCy0v23MfOskz73x1LQjRcBzqdAtJsMYaNnI=;
 b=Gppb0pCWn9sg7bMjFrF+BUX7UzfGkElZ3PyQ4tBAW6c5WjJLkebCeVYbVhe5B4xyXA
 RVqZy8ITBXPPTHKaNDeQJZgBUMZe3XH+W11np+wdsvKvmGSU+QhMoSNYEUTJQzUlnMga
 jLRrT4LfY5LHhg8j9MPjSRt+J4+1HFMz0RIZsTaTCgTzuAYtlP9ub+lXAu7g7T/3p9bR
 +tO7hf12gppXsp5BUsVROMdygPB/Vj4eg++sNZkmqL3UfoYUfP/7yc6LdW14GgzjxWRc
 5ap1KnxxR30tUlel8ir4OgTupwWv0JXh9a6x684u7jsDMr25RvHWPeeQCM4J6xn/BOcn
 YeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542406; x=1747147206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eXL4/W2KCy0v23MfOskz73x1LQjRcBzqdAtJsMYaNnI=;
 b=YFaIOq38RpJWEqBptt66/HV3XNi+5et8V3ksUiMmhOwgsVx4+90lwYeRFR6bY736lP
 esKpvHxSr+ejvjmpolgtw9iKdSD4Mca5lKWHLjLr37ae9tH4BRN/qpB/tO0GkzpXD2Zh
 sYjH6n82uhEUOea7PSz6LOxnvdcp/LrzPbi06K9BF9fmjOX0u9WL/Tn3TJib4h2aPO55
 7qYKGAh7wCa8wS6xemggtSM867G3dF9flEcUPDZU51+rzpBX6d/+PibhcTHjYPEajVyK
 5/KqqqfmGIgZ+YBlgVKdTG1j2ydWPRI8fj8JTAK2uKW5TzTvq9zYdauIeuTlUP247m0T
 PiFQ==
X-Gm-Message-State: AOJu0YzIODOFkIhmzTMc6lQw64+t0jgxfsnTRJSPnyoszV/fE1fLUiJb
 i7Des4k06iIMDH//dqokmrg+A4NOsw8clu27IcCOMpyDrDAspbIEUo910af6W2AWRkfgBGeYYmJ
 i
X-Gm-Gg: ASbGncuFqNMPYQnYlTa3RiPNRqaaopzTaaAJqnxtwpS0rpfnH265wH2zBpeI1LQ0gs5
 h3rLqMLeRy8SCBtnMeq29G8FqzPwoAUHyU4ba2eKYpENotypOneaGObRTo18D4DjhvPEarZF+44
 rx6W6oHxv2RBEgxcHVYhlpVXo+soUTbEI5YCi54qhx7LNBYDwARQlVEiQDOoat8Cm3+aHtcuFJ4
 T7vwOCp+2zfuL7WRtvqYlnoFpyPRP+oeYfVvg8PbO42ROCVIxxaE6Sh5RADlnI/5DLHMBk9rKm4
 QHSqs3AOjnbJLxoRA5PyjEgvEDMVGCPX0lAOYbAV7/WNC2Qs7mFgso3+HJ7PfUCud+toKddJ7Aa
 sQPXmIZksFHKmtQugp7TB
X-Google-Smtp-Source: AGHT+IFTY7bNQQNCVJlvXumq2W50yiZ5xQiCPKY0VroevxoKAH+IkM3TLDVWDAK7/Qq+WMOrQBcTdg==
X-Received: by 2002:a05:6000:2408:b0:38d:de45:bf98 with SMTP id
 ffacd0b85a97d-3a0ac0c9abcmr2529900f8f.8.1746542406262; 
 Tue, 06 May 2025 07:40:06 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0ae17d5e9sm2251022f8f.16.2025.05.06.07.40.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:40:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-block@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 12/19] hw/core/machine: Remove hw_compat_2_5[] array
Date: Tue,  6 May 2025 16:38:58 +0200
Message-ID: <20250506143905.4961-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143905.4961-1-philmd@linaro.org>
References: <20250506143905.4961-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

The hw_compat_2_5[] array was only used by the pc-q35-2.5 and
pc-i440fx-2.5 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/hw/boards.h | 3 ---
 hw/core/machine.c   | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 5dc5e3b547d..5f1a0fb7e28 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -844,7 +844,4 @@ extern const size_t hw_compat_2_7_len;
 extern GlobalProperty hw_compat_2_6[];
 extern const size_t hw_compat_2_6_len;
 
-extern GlobalProperty hw_compat_2_5[];
-extern const size_t hw_compat_2_5_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index d66b02b564c..e7001bf92cd 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -283,15 +283,6 @@ GlobalProperty hw_compat_2_6[] = {
 };
 const size_t hw_compat_2_6_len = G_N_ELEMENTS(hw_compat_2_6);
 
-GlobalProperty hw_compat_2_5[] = {
-    { "isa-fdc", "fallback", "144" },
-    { "pvscsi", "x-old-pci-configuration", "on" },
-    { "pvscsi", "x-disable-pcie", "on" },
-    { "vmxnet3", "x-old-msi-offsets", "on" },
-    { "vmxnet3", "x-disable-pcie", "on" },
-};
-const size_t hw_compat_2_5_len = G_N_ELEMENTS(hw_compat_2_5);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.47.1


