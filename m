Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A646D0E6C3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 10:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNqhj-0004GR-3S; Tue, 25 Nov 2025 05:55:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqhg-0004EE-Iw
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:55:24 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqhe-0001fa-OX
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:55:24 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso40263015e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 02:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764068120; x=1764672920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJnvThjS80O1Eon7AqXWBK1cOL1m23OMM4urIwDftzk=;
 b=dSDcv4fY4jLmCrbYeNtvQ0dYyApViaKAs/GV1CV50xxofebri4Ke+gZoNPhANMrfHm
 WMcLzGwDp/+TZl9Zh2R4TAz+wimCjsXXrleFitFX44woseRj2dMKlRYSPKfDtfjPgSRw
 ZQKV0nPfC60OYcVtE8ZTTB2QdHwdY3b0NNDdmxanloM+LKKeQGt+tTspJ6tLmlqSk4I9
 9NrYLLcjOiRUirvB5J1EU9wQqMEmj+YwQfbiBn69AF/usgtj34n8YqUZCUIhOPbtdpGd
 VHdQqkxtxd6/qra20DCaDajVFUjkMK33Kd+PYYFQS2y9A1eZRk1NJO2P1EoGwW6Z1TZB
 zYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764068120; x=1764672920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lJnvThjS80O1Eon7AqXWBK1cOL1m23OMM4urIwDftzk=;
 b=COsa3lBtuxqhfPQ5zLQxnTw18H7lYW2hoqq+fZwYlTOicYMmZhVxlRCHnXRhnW21pY
 r1+q39lqpVOyBBP0FXHMEtaYJ45J8cdcqefWqxkffGWzB6iWJViFYwW9znwAjj2Rz7GM
 RzgtAH2thvp/Xo1JO+cklL1yMvRx+mVfdO4s2DIPqPBVE8Ztv8P9Y8xG9W1buwYIzRuN
 dkL82C/G2N8vvm18EBufRBZfCQk3qr32dDa4hrxPmmLtjYqwj/ypYqRXlUsJiROYQnrB
 iOb9pHb0HZtYywQeT9LdJjW/0VycQYhSR3DYcYXmgjYORRA8+dv1QN0BVJLKYMeMOuLS
 IbAg==
X-Gm-Message-State: AOJu0Yx6yZQtS6E0Sjz3inNJ8XPLl1dBNqRiDih7iLiYeNzTOTtmVeeb
 Lq5Qno/2gFuXM7NZSepPyTyUBQ3nP+/5DtZiOqzOgckJerQ1lfzfM8xSSkDLSuHXTAc6CyvMOup
 LmvsJpfOxlg==
X-Gm-Gg: ASbGncvuLNfU2Hn8iW3WKRewvolzVt0aoBvitaAJ9Z/kfIUoT9F2f0Pl5cVIsZbn1Pv
 0t0Sd6rdM6ywhmgVl3jifpusTNOojX4397rPKO109I3wezKGfbCI3aOiDrGquFLR6kGB8z2xKV+
 smlwyvE46GITCW9u4M27kOxv2IYWqFcdG4LGBDcP2cF/RMQ4TGULR42Qosgj6TNwmxKoZXXTcAa
 DpMt/ru3WTkcuX/hd81REKBX3zX5krIIrvnu0SGPy4gzhUjSI7haUX1tUnGvE1BG4mzb/YKGOrN
 QikC+YdzowQq/rAHSwRhKNmiDBZHFi9N2Q5bSk8DIU1NQ79R6N8s9V2zt2O2ZwNj5uH1GhQ1BzQ
 h8WmTJhI8r7vC+nVCqJaTKotUMPzpiRYcYt1HqZ2oWlQwm/UdDCjmx50asXVOyWgazHgsxr9XmV
 dyY1NHm/SK7ARN8DIMXylZLroL1mdpM3xtErfiRdaXxy32kLGnygsT1ISOXfrO
X-Google-Smtp-Source: AGHT+IGsqiVHH5SjJWCQB8QRWjbF3lU+3KogymlcesoKSiwG5fKIhJYXXZqXGAfxfKyTCo39hLqidw==
X-Received: by 2002:a05:6000:4010:b0:42b:3dbe:3a37 with SMTP id
 ffacd0b85a97d-42cc1302285mr17879937f8f.10.1764068120487; 
 Tue, 25 Nov 2025 02:55:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cc231dc6esm24752764f8f.7.2025.11.25.02.55.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Nov 2025 02:55:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH-for-11.0 06/12] target/sparc: Use little-endian variant of
 cpu_ld/st_data*()
Date: Tue, 25 Nov 2025 11:54:27 +0100
Message-ID: <20251125105434.92355-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125105434.92355-1-philmd@linaro.org>
References: <20251125105434.92355-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

We only build the SPARC targets using little endianness order,
therefore the cpu_ld/st_data*() definitions expand to the little
endian declarations. Use the explicit little-endian variants.

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
---
 target/sparc/ldst_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 2c63eb9e036..bd0257d313a 100644
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
2.51.0


