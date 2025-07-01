Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB711C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcHI-0001cw-2k; Tue, 01 Jul 2025 10:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcGY-00080y-74
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:47:22 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcGQ-0007ZD-Ir
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:47:21 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4538a2fc7ffso38459825e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381232; x=1751986032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwhPsNiTZCmsjwBt8ypm79VEINoM/2m2M7Tv3kawXOs=;
 b=ZjuGiiOAidjH9MPF6cwYF3fWAHfs+ifB7uMhC7AAOlDLzNTwoYzjDUFieWurGmFsV6
 upaTU7O+egnJNAoU/51jT//APRv9iSoSWOwxWnFOywwdAWgPyncqTp9pfRE4KTZiH2FJ
 Nu/e4SErW8W2ZGWLKE8RxHmRWo0qJJ2sn4+AtRBFPRLrxOnTGIyHNYlbn8XmukGmQvHq
 DZ0AOKTjYicDkKSSZNTVREtL7S0R8tWhr3ZzJODeZ8KE8RFegbrcVvIo1XPbzGHXDJVC
 85z4rADHPzqG2A5tkWKBwPnmS8wJfT0Ls2Na+kvxKB3sOiY2xBO2K2iUcLQqk1HADgbN
 Wh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381232; x=1751986032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uwhPsNiTZCmsjwBt8ypm79VEINoM/2m2M7Tv3kawXOs=;
 b=VuOUz0cWehmz3obu/3NaeDo9KGMYLlW6XF8VCynrL8Wd7pjutKJ0hN9PR70qGZSQYm
 lMB2nyt+bUUlHrJsw+Vm1Yj0N6jCSSAFJq+5RB15wj4LG4AGsyHEnKct/GT9ypcddYiC
 jmC0Di3JeF1NCNcMRT2uyCBB4sj/AUABqPgMNQtrIqQyulZfj3jaRqi+6FueeH3LJKaN
 u9uF623I6YibWglqAqIELowxZuZKQBaq7WnusHfJLyDQg1w+lBINTRvlOYo0x9yjTPg2
 TwHv9mSZugP9KqEDdyhz16PqVzFLUMXUmxOh65FjV+YAV/WmPoLkS5QhsqMLRnlBVcFM
 ShiA==
X-Gm-Message-State: AOJu0Ywlb5ioGGo5HH18SfDv5bQ88DXKaz7K3vc+MKgLqsvrYHLrmxrj
 rCIv6T3qqp4m6Pf8UrFFYriRnLCKQ2rhIXXAYBvPqKblJMkYXg0BLkDqF1OjKF549BV7JLGpkAD
 nes92
X-Gm-Gg: ASbGnct/0AETtdaZFeLihHIkIlWhpa5vhmE5XjuXvomieIrfBes7HfFMemkrFiUmzfK
 CzZNClXdekd9WNnEcPMpSKl8jP+DyVci7dxZiRE1keK5/5WUgU4P5Hr2YotAQiuny/NpqOxNoKe
 U/+tgOpJtkoYVN89RBmJ8fMXfilE8V89kMkT22peNr4BnvzcR5W6CFJ5AGnsppcWfwmDywptbGk
 ViqTR9BtHAl1lNEGhOduMHeeamGykfXo/UkC5CZ+Ee5ohpGUIr5s/IF4KF4/NrAH8NbKGerBhX4
 r8AU0Itvf9fqoQzjSmVcDolrsg+AYl8ralFn2/D9l+GxAXSrMeo0EQWOCh1XE8diTPdUAma9PSY
 1bLgl6xrhcrGP0qYZ7yXpkNqVQIZe/zFo0iWS
X-Google-Smtp-Source: AGHT+IFTkYY3ZKStZyWav1nbgfyuyxa7yYeOJCfnYrnvB0B6ewJ3t5zK6NuKvI2l4x0s7dL6LRjlUQ==
X-Received: by 2002:a05:600c:6099:b0:450:d79d:3b16 with SMTP id
 5b1f17b1804b1-4542d448185mr29303465e9.14.1751381232548; 
 Tue, 01 Jul 2025 07:47:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a3fe587sm171581605e9.19.2025.07.01.07.47.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:47:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 63/68] accel/system: Declare init/exec/destroy vcpu hooks
Date: Tue,  1 Jul 2025 16:40:11 +0200
Message-ID: <20250701144017.43487-64-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/accel-ops.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 28e29cfa06d..f98a1c9b662 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -43,8 +43,11 @@ struct AccelOpsClass {
     void *(*cpu_thread_routine)(void *);
     void (*thread_precreate)(CPUState *cpu);
     void (*create_vcpu_thread)(CPUState *cpu);
+    int (*init_vcpu_thread)(CPUState *cpu);
     void (*kick_vcpu_thread)(CPUState *cpu);
     bool (*cpu_thread_is_idle)(CPUState *cpu);
+    int (*exec_vcpu_thread)(CPUState *cpu);
+    void (*destroy_vcpu_thread)(CPUState *cpu);
 
     /**
      * synchronize_post_reset:
-- 
2.49.0


