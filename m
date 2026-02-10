Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3EEEA811D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoA3-0001wd-Kn; Tue, 10 Feb 2026 08:52:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoA1-0001vq-GB
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:13 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpo9z-0006JF-DM
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:13 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4834826e5a0so9780885e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770731530; x=1771336330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8ZYllfqCxHjZfO9L3URwSmEVOZS07oqfLdpX+lY9NZ8=;
 b=lCNu7NFdU35WyW2/sL/no8BKVjsEA3t+vr+VuGx7FZhyWHZNU4XxPjpZMMmC0Yqky9
 TMvsJ5MXhslAP0+nzwUSRYlbyLahCyYNJgfrLIXpMuC1xbIuXQMXRblFMuNPvTk5rToQ
 f26VQKKjC6DtNh6G7WQ2LY7IcpRnTCs2SLkpoRCn6lfwC1KM9CKNuj30/PVRne/mkL3Z
 ktZYl1XFvS8tyV/WxxI23jX7q0BuwY5nAHSc3/zj/CrAOOfxIbeVmdImLxIRhvW6WrVK
 jfrNX8TT3IQcZXdkbihT4piah0LvyM3HUg0iFjsKdH11MBhvQs3r4R4tOUViXh3Xxn+H
 kmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770731530; x=1771336330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8ZYllfqCxHjZfO9L3URwSmEVOZS07oqfLdpX+lY9NZ8=;
 b=vNqlstdgiJ2hNhE15MNnHbavksg0pT+GTnDyLv9Fm9aUB5Xq5L6lG6p6iEYsOE63A5
 YnutgVL6XXOnyyZa+zNI2YSMYz/NDlpInXATtZhQRWCRTKZNhQufYgofxUlElAtiAfCn
 23E6Ei9ToO4N6OF4xkKf14ITfWnzn1iKMovTUa+izHmKAQegolv45S+SeFB76zp8rcuq
 K0hGodZrBkWOE4Ce0nwlnaUuXVRHq8a66+okR3qVmFpqmuXN9UhgFc91RzrvCwgcA/sb
 yUzk5WQWIgKWl6FuxEVY5k17vo+Yk3+H2Wwyn3UPOzaQ52OLRPL6LuzOMw9WcvWqmnhN
 +uMw==
X-Gm-Message-State: AOJu0Yzowy1KWp2ThlN/E1qdrY9DyvZ4w7y+uuE/Rm9FMymiTfcYTObq
 jQCE/UuF/3bry6sCx3k+gA8Tai3XfXDbp66IxLLicm9lwCnk2LHxX/VKG3E+UsfnByvqA7/4+zX
 xSeZt
X-Gm-Gg: AZuq6aIdwOVdTUxtCqaNZqoxKAAvIq4Us5CI89FEb6Hg2SAdRD0y0KlpfPY0nXPlZmU
 IidCIAy1nHURXmJsqVuPRjb5RLdxYBbb36SXr0oZntOMbKYRnSSqNkSGFRcylNliBWcB9TVwIuj
 sCXnxzHMcgdm+Dn2DfOHp542MVqeHJzYmIUoZJTuzgiruiQGnvnVD2s6nnx3q9YvVN33oMKBnBU
 unFvd/WboNSw37r8B+ilC5mrB/7XSbdyzZgPImcO4kubPkv6JRqbKgs6tgSEQa2YSDSzvwCw2/8
 9ScUanZe7YvVAaoixQ9mzIaldMpkLv5rw/3TNxAO/C1HQSOiLxGiIfxXnWh89AxufMXm6lqpTdm
 7/Jr0vYEYZX38cmGlEaRwf3/kn2Ah5coSbJu4rXUJ9KoEpEoGruwfkCJ7cJASFqrRUhFCYmwHS9
 TqxjI1HyUcx+i1gZViZqX/4x0OEjmilqxgrZsNWfNna9SldCjbCEL1Isz5qFd1BN4qZS2q10gc8
 pji9PLvgROPCsE/W8WX0E8/houX3TU=
X-Received: by 2002:a05:600c:4f8a:b0:480:3230:6c9b with SMTP id
 5b1f17b1804b1-483201dd004mr213407675e9.7.1770731529465; 
 Tue, 10 Feb 2026 05:52:09 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm64344875e9.3.2026.02.10.05.52.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:52:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/26] accel/system: Introduce hwaccel_enabled() helper
Date: Tue, 10 Feb 2026 13:51:42 +0000
Message-ID: <20260210135206.229528-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135206.229528-1-peter.maydell@linaro.org>
References: <20260210135206.229528-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

hwaccel_enabled() return whether any hardware accelerator
is enabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/system/hw_accel.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index 55497edc29..628a50e066 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -40,4 +40,17 @@ void cpu_synchronize_pre_loadvm(CPUState *cpu);
 void cpu_synchronize_post_reset(CPUState *cpu);
 void cpu_synchronize_post_init(CPUState *cpu);
 
+/**
+ * hwaccel_enabled:
+ *
+ * Returns: %true if a hardware accelerator is enabled, %false otherwise.
+ */
+static inline bool hwaccel_enabled(void)
+{
+    return hvf_enabled()
+        || kvm_enabled()
+        || nvmm_enabled()
+        || whpx_enabled();
+}
+
 #endif /* QEMU_HW_ACCEL_H */
-- 
2.43.0


