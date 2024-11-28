Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE9AD690FA
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGc1F-0004Gs-QJ; Thu, 28 Nov 2024 05:45:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzy-0002Dh-0f
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:53 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzt-0000kp-TF
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:49 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37ed3bd6114so459307f8f.2
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790616; x=1733395416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eT1LXyat6VBXQfbf2ZEeygMBWdK2hSiibfIDvIYaJow=;
 b=RFOheQh3IPIf1l6+sAnVIhgWWt5ytJNUcTsEATaRCV2gcMr/Xf7bDCujQ3kUOEfgp+
 gnCf5lVjy0JNsaXlau0vtW1lXQ6FqtYhs4e0XDg8HJGet6BUu+VJfXAx7MI9s2NIZOpb
 ewy3bAR6VtZ5DLoxHprhxz+9mliIcQEbXO/LS8FA9dFCJWTQZjs01PbIT7dJx/ALi1oh
 G8UWo5bAf+ZF3pKLrAyiZGESnxrV5sxU8NRZnRM11BAptIWjKRtgtbgoRsOD98C3HpNz
 L08h/Bitzh8r97w/7ETEa38D/vN3KyiWoOMUPmZjvX4SoM5tkF2I065rQkoxg5S6ErsA
 I2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790616; x=1733395416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eT1LXyat6VBXQfbf2ZEeygMBWdK2hSiibfIDvIYaJow=;
 b=Qzs0cNDqTme89muuBIFPwtrTZshVkLe0WXd4Kz659GeTWnmqA1lPOPOuuxgHTp/uzl
 joIAoxptWgwtZ22XKzJ9fcULLLpNaOZAUiSFVrgP8vMp7UaOksebuINv2COOAIWl8don
 G9szCeoIDBrdA95PotS+w9qOl5up4rugwxeJf0Z4n1AXTBX3qlSMlqyn/DeDHoojnM1a
 V+KiWS9XdiANhX74ksMykszLr2fls6plvBWTPTpDlusTlbM22KKKMW80Y4EFTHVTeOZ3
 5geySrbs24t3eerfjVsVmbmDfyiPBHY23AYRjKWtG5oQduDZ/QLIQArE3L/fXwj3ZoaW
 osZg==
X-Gm-Message-State: AOJu0Yz5jGQOze1BCrKy5jjRrroI+m4PoNrb7C4pw11zL2sb6hERCBlT
 Eso+vUWxvxAbWgUOpXD2zqKnRUR4SKJTjLb2KPCd+s2Ts3nhsVBn5MP+HHR1HflCKkQvel75yf2
 m
X-Gm-Gg: ASbGncv6sbHSgkCH2EY19puLk2VFn10qLpkMZdoVUQDwhXcu/mVu1pArYzWEP2QuzlZ
 vh4DBQJKGikRbtRWjyHl052KjcpPEmeTMcpgV5FWCsNbjewPphyrC7kVnF5GwZaFMXgvtVDBBPm
 pTpVQoqUYy/xuYP+OHYiKoYPLkTxUt/Qn2P+mKvy6+HxkYqFy6WIf/oeVkBCJSqsxWhs9bKORVU
 +dIlJv8ihYwhIQthuvUs36xjyA4ADAdjda7o7XIeel5F6H9q3RZ7Xw=
X-Google-Smtp-Source: AGHT+IFoK756JycdHDegIr7eJmXs59U3bbQb3x/KF12D+QOk4s7BgtVPWqKjS3obexchOJx8/9gF/A==
X-Received: by 2002:a05:6000:18a7:b0:382:4dad:3887 with SMTP id
 ffacd0b85a97d-385c6cca8eamr6108106f8f.3.1732790616027; 
 Thu, 28 Nov 2024 02:43:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH for-10.0 23/25] target/i386: Set Float3NaNPropRule explicitly
Date: Thu, 28 Nov 2024 10:43:08 +0000
Message-Id: <20241128104310.3452934-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128104310.3452934-1-peter.maydell@linaro.org>
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

Set the Float3NaNPropRule explicitly for i386.  We had no
i386-specific behaviour in the old ifdef ladder, so we were using the
default "prefer a then b then c" fallback.  This is very likely wrong
for i386, but in this refactoring we don't want to make a behaviour
change, so we leave a TODO note.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index e9de084a96d..b62719dead1 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -180,6 +180,8 @@ void cpu_init_fp_statuses(CPUX86State *env)
      * against the manual.
      */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->sse_status);
+    /* Similarly the NaN propagation rule is likely wrong. */
+    set_float_3nan_prop_rule(float_3nan_prop_abc, &env->sse_status);
 }
 
 static inline uint8_t save_exception_flags(CPUX86State *env)
-- 
2.34.1


