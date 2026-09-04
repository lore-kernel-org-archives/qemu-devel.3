Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F520C79F87
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Tah-00074Q-0k; Fri, 04 Sep 2026 09:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZq-0006Nb-5u
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:32 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZn-00034K-SN
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:29 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-484392e3d33so589199f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788527006; x=1789131806; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=07E0fW2eDFKopiWn1vNWEYlUUP8ZSGC64Z2M/Dtuonc=;
 b=gXVeMIdPD9EZuWv96o76lHhtITSy2qGgZdL5MrH/EGkOhUXLLLi0AK3VHxt1+XzBll
 VSwxktH1XpU6tSTXNADKOi1aHBHLTIuZmshrDPx8/ExA+630dx9L7UOMzWlJF2G074Vt
 8vmRO4/VRnJrqAIxib5db0FYV0aXv/TUbKfcZ5b9ZXmnQHgxGPby0fdfHz0oH++e9hOC
 yvU5kr80wyYwD9XGjaxCtTtt2k1Vms/GQGv15SZzcIxbXwK0asOddv03GbpK9SqHlvz1
 JCNPR/mo1wOcQQ32e9+pbT49c4ZpCzqdNKlY1LXySSJuAM43Cysues6v3cNJUWhB5bdh
 u+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527006; x=1789131806;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=07E0fW2eDFKopiWn1vNWEYlUUP8ZSGC64Z2M/Dtuonc=;
 b=OLHl0kcuwZcJkV4/NIbmB1j4/YZEiEGlozwCOUJ9XH/9m21hUXZZNzYpo0swgjHW6Z
 Jrc1w//5APA8WZR/3gXNI3TIl0JE2u64BX3XVQSWUDuXVDkyGhJheZ0qvroTNjK94r0b
 NA66OH06PzUF7Pz7hsU/AEzBlfJsuLL15Svyt8yo88360rEYDCG7Qsmck5V4j/F63NMb
 TUdM3jXte0RSoBjYokG5xgu353tIw+zOVFLZPtroJQmR62HeyR4g7cmbRQ2o0p3tEWRt
 zckMbLNdeXL6PVrycWx5LhXWweV2c01Ym8dWNUwJQga0agA9S6Ry4NdnjpPpMY7Ahiav
 bbeg==
X-Gm-Message-State: AFuF++m3Yo+jHs3enCMQJ+dbU8c8qj/jKSu+JT6nWxGAO0MS0D20M9Rx
 lAjUwq84gT+tZAa9VE3uIOYgucdNPgdkdUtQZYz7XcG+77eCkKTipOok4Eo44GB5Xn1o9TvYc31
 spZZWxdA=
X-Gm-Gg: AYBFou2kATcbbARpmHpYzwFgVBMXvQfQYyeyEOsBTLVVtoqFD4JLiQE9BXtO3UN208A
 aiqn5aSpVZTpwYuW/mskM21WZd9LzxrwtEA1/giHs1bRrJrMIMKYq8ALqDc8rdJhm5jOVpiDI9p
 S9AMlF7YzBl0NSOBhbo89Tok3ZaAj7BQsFnyRX3XYgnUJDeOsLjFhu3hV1s7pddOQIwSHUfCOL+
 wyyjAoLQxoWgTFHdV4owV/vBX23Sh5ToCTB/BpOLgwtE7QbEfkavXKVma3RYxf7ikKHoROC2zUE
 Mcqts/Jv5GFn6fpQro4PFT/XJwlQSlY6yJTNqsygPHzLwxz4DibdFrRgyDLqu19scDX205ov5MN
 NOTne29KcnoWFvaJP2+LiBg5BcM7bYgog8d9ys2ZYmbP+McFqc4HaajSJ8zfwgoAR5p8UENVnOw
 Ol8Xc6u9lxc7vRJpTwhtnKv5ehqZsUNIleilH1OXOYdGu/v7LBNfSIqE/eSFdWbBzJDpaWsOk=
X-Received: by 2002:a05:6000:601:b0:484:4874:db4e with SMTP id
 ffacd0b85a97d-485872a004fmr7952448f8f.17.1788527006216; 
 Fri, 04 Sep 2026 06:03:26 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858e239862sm1087957f8f.9.2026.09.04.06.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:03:23 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 857155F954;
 Fri, 04 Sep 2026 13:46:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 033/105] tests/tcg/Makefile: skip user/system tests if target
 Makefile is not present
Date: Fri,  4 Sep 2026 13:44:47 +0100
Message-ID: <20260904124604.2207440-34-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

In the next commits, we'll port each architecture from Makefile to
meson, and it's easier to review those changes if we remove Makefiles
step by step.

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-34-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 1b83824ff4e..836fccaca23 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -105,7 +105,9 @@ ifeq ($(filter %-softmmu, $(TARGET)),)
 # $(TARGET_NAME)/Makefile.target to include the common parent
 # architecture in its VPATH. However some targets are so minimal we
 # can't even build the multiarch tests.
-ifneq ($(filter $(TARGET_NAME),aarch64_be),)
+ifeq ($(wildcard $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target),)
+# skip user tests if Makefile.target is not present
+else ifneq ($(filter $(TARGET_NAME),aarch64_be),)
 -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
 else
 -include $(SRC_PATH)/tests/tcg/multiarch/Makefile.target
@@ -135,7 +137,11 @@ ifneq ($(filter $(TARGET_NAME),$(MULTIARCH_SOFTMMU_TARGETS)),)
 -include $(SRC_PATH)/tests/tcg/minilib/Makefile.target
 -include $(SRC_PATH)/tests/tcg/multiarch/system/Makefile.softmmu-target
 endif
+ifeq ($(wildcard $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.softmmu-target),)
+# skip system tests if Makefile.target is not present
+else
 -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.softmmu-target
+endif
 
 endif
 
-- 
2.47.3


