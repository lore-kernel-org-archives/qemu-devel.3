Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8DCE73170
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmu47-0006ns-88; Mon, 02 Feb 2026 08:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu45-0006mt-Uv
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:05 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu44-0002e1-Bn
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:05 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so33486425e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770039243; x=1770644043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aIgmMwISMpLwftLkUcpbNnEzoo+JvfxNkgOo0yRxeX4=;
 b=lXpg8KM8Bx7RtfenJXyoi9yChhYy2Z5dwLg8sW/zPbUTzqEzLZCjQ3YodYEshRocbS
 1bAJxvnfs8Mjp8DQjuVmf+iCmh1CsMYDlb8/xHadxOB72H8xtbWoE3TRS8kau2tC7B/9
 piNXGH+8Dy20pa7lb5aqd4rJ/G9bJii1JkCB7PzmTxOhPygRSPMYGf86gB1hEcQAUu/6
 d+Qc6ii5uEjL+tMKbcfn2NmnF9EMQjnz0VL/Z+eWswSSOho3qvWVBb5gOO8e/y4TOuNw
 Vr566jtzCKfEI85CB2yTBDR06FahtDdAcdwZYM6fFgSZ9/Sasm9WlrOXV283VITvD2kp
 0mWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770039243; x=1770644043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aIgmMwISMpLwftLkUcpbNnEzoo+JvfxNkgOo0yRxeX4=;
 b=E9IdocuQ7JeX/5uSpHReeTl0C2rRUJsaYcG54JIEhScvKlOm4SdLeUhJHRIPDULN88
 PNWgDY6/gpi31aC/7JPY5ymFdzJf+8jkH7MmXiKuRLjb0+wkUbJY8kLSVGVzbRr7mVQu
 VKf0z23Ert1a4ItJtQOAURaZqk57HomeKSG/udInJrBDsbz0g/u3sRjiLw7BJc5jR/jz
 /0Fo6V81BCHnFgywDRo3ZQO2mEqlA/ZDWN9PkBszjrHbYYO9OB0+rWdmFupLoROk2AkT
 mm0JssNuzemAt0bhDEGQrQpF/Qe3bqAolRm7iT5mBWMllzZA8oTl4LYx71f/u2RmA7La
 HaqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqmQ8mhOuyL9YOdG9tN3mQNYeo4bhPm5iLIFW2Is4XQpiwGZ1fNypkc6I1kJkCgg42dvWDo6gDbRu9@nongnu.org
X-Gm-Message-State: AOJu0YygqA4Wm5sw2kQFGyfRDzNSxfH51RPbmMJxCLCnqipzCwgMORGk
 CWeOtDmsvW2Pgz5ecM6uNgpW/bz2Aw3j51aqb8oYTeeVXn7seX3fBBmpoz0gRK2oEEw=
X-Gm-Gg: AZuq6aKlPd5mxPYCdk9B+dOgLyByXTmbyvaKwN8U7XMGcPYrzn64RYS4TGTMYaYnQYq
 iDHswRs1UqJ5i+LHRVbjqGaaaV2cxstonTw1nfcYCtefZMUzn0Xua7Y8pp3wHJHYRNJOEHdw2Mu
 /1VqeZvyINkGTprNMCkHAmkt8Bt2BPuEVNRe8ouW4nnenYT8u33+qKXxYcxFLmLhib9mxgoTxMd
 8ChjIO1xg5Szr3W/WwJ7JUSorcjQFgIU8qGZHT4pTQ8VxhV8mQL6lNH2+liO2YTs3XvYWiJRk4P
 GZT3FkTywvkAbHJVHaYMjn8bxASPuoiM7czAedpckRIAcAOlfvRsUWfZ1b0atFzHjCpJbdFpeN3
 4zdDTzeYwV4KFbaw5Eof5hX/6p4KmaAIQu6J4MlbUO7w00bWXMR552D1558llsuMSay0txrTEfk
 MZzyxfv67dGUZIzJd8+D45mlYaFiBWsw==
X-Received: by 2002:a05:600c:4e87:b0:459:db7b:988e with SMTP id
 5b1f17b1804b1-482db4655c1mr146429415e9.13.1770039242878; 
 Mon, 02 Feb 2026 05:34:02 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c42895sm478054495e9.14.2026.02.02.05.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 05:34:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 06/15] target/arm: Handle SME-only CPUs in
 sve_vqm1_for_el_sm()
Date: Mon,  2 Feb 2026 13:33:44 +0000
Message-ID: <20260202133353.2231685-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202133353.2231685-1-peter.maydell@linaro.org>
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

In sve_vqm1_for_el_sm(), we implicitly assume that the CPU has SVE:
if called with sm == false for non-streaming mode, we try to return a
vector length from svq_vq.  This hits the "assert(sm)" at the bettom
of the function in an SME-only CPU where sve_vq.map is zero.

Add code to handle the "SME-only CPU not in streaming mode" case: we
report an effective VL of 128 bits, which is what the architecture
rule R_KXKNK says should be used when SVE instructions are disabled
or trapped but floating point instructions are enabled.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e7aa5ec2f2..e4a6ff17b1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4766,7 +4766,7 @@ int sme_exception_el(CPUARMState *env, int el)
 }
 
 /*
- * Given that SVE is enabled, return the vector length for EL.
+ * Given that SVE or SME is enabled, return the vector length for EL.
  */
 uint32_t sve_vqm1_for_el_sm(CPUARMState *env, int el, bool sm)
 {
@@ -4778,6 +4778,12 @@ uint32_t sve_vqm1_for_el_sm(CPUARMState *env, int el, bool sm)
     if (sm) {
         cr = env->vfp.smcr_el;
         map = cpu->sme_vq.map;
+    } else if (map == 0) {
+        /*
+         * SME-only CPU not in streaming mode: effective VL
+         * is 128 bits, per R_KXKNK.
+         */
+        return 0;
     }
 
     if (el <= 1 && !el_is_in_host(env, el)) {
-- 
2.43.0


