Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D644E776C4
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRiH-0007s8-Ua; Wed, 24 Dec 2025 11:27:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRi0-0007h3-MQ
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:27:34 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRhz-0003pq-8F
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:27:32 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so37538335e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593649; x=1767198449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iPj2s3kMb90wVd2exYaw2+LTGdQknCaaYvO5hBNEwcM=;
 b=rScK4t9piNwC5RrIiqISh/CuZZmTFFMF57spMxobMdaBn/rorDjXb57tdA0llMIlp1
 g1B+ZWNOv10kUt53BXKmUMEkotNcmDTp0ZSzxljDr5CXcrzo4yPdimyNqW9zA/1Psvmu
 uLsOVkpi58736HTp/6NbB3ynX8PcBI8B1E+kwba+2j9t+JmgqH89TVl9tbj2T95MnmSH
 zXAxNiNX8zR5rnLgYdz/0+yc+QchK4F75wrTDifCR/nn5YvWALfEExt4GnTPzAt1klo+
 9oEv6bWg6j9RLK+BCh8gKCRQiKogje5uXjqByhANXVMeEAPnglBKhOG8TIlx093No8So
 16Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593649; x=1767198449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iPj2s3kMb90wVd2exYaw2+LTGdQknCaaYvO5hBNEwcM=;
 b=vVeIcdHVWNA7LOf81Zx4UI6WdCJ0pYlBVRM8h2z8DgjlrrZFKn55v2h+uJ9DAlpvLa
 kRQkWcALa2mkKfMG7uTVwLy9o4gpPUADr3Gs9R7yjyHeW+wp5DAXa76X4JzJXBeO9F/C
 suxD2kfFuvVTvOh8UkuwNXCxX5PyRURjs5azp+ytcpU7i60bU8eKvQs+kAf1xaMu2rAw
 Cm+jTr6zs5N3ggB1xw251G8aNcjfK3+Qhu7N5KZ4kOXou3i9KQ1ybHRJWRc9krjnSgzG
 LMtTGHDXA/TmCcTngQknDeZY1LVto+PdeMgXYjco6jfyIc9a/KfH00lzIaMqiGLoEy1W
 jLfw==
X-Gm-Message-State: AOJu0Yycx2PO/jfkSiXWlL3AK90uBGvO3Q6xcCkbUE4FVkqhfUZgvQkT
 Z6SrVtrhRo7lz/GUJj9v6l3oT1vfy7iikd+usNUZhcNC41eslickt9QOGeTkxxE3eSyLN0Qs+H1
 n4TXixts=
X-Gm-Gg: AY/fxX7S2WIRdSGlyhWWJSwu/BK1XEakNI6NkOkuJh6zIxINw0CHXYprZXskremlefx
 dC/X+tCHR/Back83zdrWjLjtNq8XwrIQHz572TqyhDWm+BBxNno7BRBk2h1S+EqjveStS6KccNr
 VqItqUUkq3TuJ0kLFhBnWgz6qobPEMdR34VAe5FeaZ5rbem7bBLco1KJAPwXrkf30rNiEgKbfu/
 FtP9hTpMB1SyEM54EDS+fRUnng3W0vXJXJ7czgQ/sau2nfjE0RPsUdXM7rpiDayh+JlGGxjtkaC
 YX+J2baWzhTcUZx80iuo2XQRNgsbU7H6WUpsBLV1yqh6YmJ6ny++H7hNQ3Y3bWXvS1ihpcz4sJJ
 nr0WodLSVSGLWoUYIdElEpxmEm2PWqEO+ly6NqBVUyHkvb5xz94uSZgDapZaiAGa6JKi4Z/fXFL
 6gsdj9JFls+WD74sD9fwty7RVaIDeAkUb8zmkJfCYyaoGZttsLNF6lXM2GLcx4kENnZw==
X-Google-Smtp-Source: AGHT+IGmfQiUYjiJ9L9J9YIezDnViBMZfijEHzi7rzLcO1TzWJnVwZAlfcUdVvVcJF7vAI5Cyi5viA==
X-Received: by 2002:a05:600c:8183:b0:477:aed0:f401 with SMTP id
 5b1f17b1804b1-47d1957afbamr177015475e9.23.1766593649463; 
 Wed, 24 Dec 2025 08:27:29 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab257asm35673370f8f.38.2025.12.24.08.27.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:27:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 5/9] target/sparc: Use big-endian variant of
 cpu_ld/st_data*()
Date: Wed, 24 Dec 2025 17:26:37 +0100
Message-ID: <20251224162642.90857-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224162642.90857-1-philmd@linaro.org>
References: <20251224162642.90857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

We only build the SPARC targets using big endianness order,
therefore the cpu_ld/st_data*() definitions expand to the big
endian declarations. Use the explicit big-endian variants.

Mechanical change running:

  $ tgt=sparc; \
    end=be; \
    for op in data mmuidx_ra; do \
      for ac in uw sw l q; do \
        sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
      for ac in w l q; do \
        sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/ldst_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 9892c8f61c6..d39f7d72a7e 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1228,13 +1228,13 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
             ret = cpu_ldub_data(env, addr);
             break;
         case 2:
-            ret = cpu_lduw_data(env, addr);
+            ret = cpu_lduw_be_data(env, addr);
             break;
         case 4:
-            ret = cpu_ldl_data(env, addr);
+            ret = cpu_ldl_be_data(env, addr);
             break;
         case 8:
-            ret = cpu_ldq_data(env, addr);
+            ret = cpu_ldq_be_data(env, addr);
             break;
         default:
             g_assert_not_reached();
-- 
2.52.0


