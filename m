Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB24A109190D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 18:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ITr-0003NB-7a; Thu, 19 Mar 2026 14:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3ITp-0003MI-DA
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:52:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3ITo-00011F-0o
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:52:25 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-485445e80bdso11289615e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 11:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773946342; x=1774551142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=06PbSn9Pduw968j+IvDOdjXCS1Zr8HZL4HWuUI+RKJQ=;
 b=RNRR5ip9VuvsFjuaCFZivUfNJPrr2zh1UbCeMd/r9RMtq4BbRkl5XbDv5aMcwDAF32
 vpSmRufxXkX53MVz94V/mTFCEtg2lpNtRgwye6ro+Zdz1IE6IDxxaOvZ+ucpdKddQGD+
 Phofs//I9Ly1qhNTXEOvUwRiY7QYhMT2kTbwVmrPof+3w70ya6R+6YibRpaHLM/0x49D
 +3LJjLrukBOGVrSlcYlZEcptko11+11OABLzryElc45esaGUIBKJIWyLW1INR4HKsJg3
 eOaqNtsJxb43Q0mjlChpRHH/Wl94cDOoDrxWjaELf0Z0/P4PObLZHAyXAt9wyyL7K9RF
 olIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773946342; x=1774551142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=06PbSn9Pduw968j+IvDOdjXCS1Zr8HZL4HWuUI+RKJQ=;
 b=G49RQATqsTXVhTBZHCB/kvmvUEIpMKLFacdfJevW+OzubfvKjJ1tBdEQ8cll1fKBRO
 QtT/NA3ciVeOYmEdax+nQi5QS18DwScnsyC5fmz3pTP1Q0ZYneA76ml8eM+cmSWQxJ5w
 9YmsbF4f1mKJCwwBGHzIhGkSGom8H0tcL8rn+635HC9/4RAjDpL3EiBh4vjOuZaFtyVg
 lUZ6Cr/xk6Asl712a565jRS4YvP3cJWmSJoRYt8sqZMW82VYvoyxOI2FEIZWUSySJZnD
 2fnW1MACt1/4SaNkiuoEzTNO53cUpuiHKWjTshX0OyhV/mZmb8htt8MWtZ8qoYPZ+MHU
 ICRg==
X-Gm-Message-State: AOJu0YwCoE1zOH3gJV8JDtzwKXP+YpfqdReMAN6Sm0HInRUHroe+CJEN
 kiBV5FGqQ/tO0YEkD4PzlO7jXaDFRExTEHwdGtDDXbdjaTQAULZNmqclWjW0xagFcNq6oj53aCR
 2mpQcyGE=
X-Gm-Gg: ATEYQzxEEP6owVKTNgJ1dXR2kl0Hq2m95BTLvhg3AeQTXrAEiA/DiOzifXsHTPNRY78
 ZyCTsP4k5nfgQjAX+d7tRhU6gqRg30I6AdLFfAfEz8VK4gxT1ruXjp6d0aJx5/X9wYsccpgvI0K
 OGIywVpl6ivU0AP/hRbnIQVPaP+JSKrqWxMjiUvXE3MW8pbb0UecSUj7AMaqldiBQg3qqQT0S0S
 jj96ZhlFm8HwY31cqvCEQOtbH5HGXt1ELZDseaaIIPVRc0/h95+n0OmLcL5y/YlftNXyoSDZ37w
 qcbV4uk41kRK+O554Fgw16TNWqKNn/KJir1uUsVIPYKQ4dWK2MaaEbsJ1rIEwdU5LYGaNhAYhzy
 JrgSeMXf1UMlK548QfMSJxt8B3JqnAM/2OTqwCxit7XTF/agq3IsKNlxKZ+LOJTxyMcktYs5/Zo
 UUOT+9+rzagBNUc6LLuYviqb6zI1qQo5EYATP09YA19sM+XNnjsMrzKcAtRnc2TS+OG1c88R6z
X-Received: by 2002:a05:600c:450b:b0:47a:7fd0:9eea with SMTP id
 5b1f17b1804b1-486fede7341mr3242055e9.3.1773946342300; 
 Thu, 19 Mar 2026 11:52:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8aacc73sm74068155e9.0.2026.03.19.11.52.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 11:52:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/5] target/s390x: Replace legacy ld/st_phys ->
 address_space_ld/st (mmu)
Date: Thu, 19 Mar 2026 19:52:00 +0100
Message-ID: <20260319185203.11799-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319185203.11799-1-philmd@linaro.org>
References: <20260319185203.11799-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Prefer the address_space_ld/st API over the legacy ld_phys()
because it allow checking for bus access fault.
This code however doesn't check for fault, so we simply inline
the calls (not specifying any memory transaction attribute nor
expecting transation result). No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/mmu_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 246573ff642..255271b9d34 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -44,8 +44,9 @@ static void trigger_access_exception(CPUS390XState *env, uint32_t type,
     } else {
         CPUState *cs = env_cpu(env);
         if (type != PGM_ADDRESSING) {
-            stq_be_phys(cs->as, env->psa + offsetof(LowCore, trans_exc_code),
-                        tec);
+            address_space_stq_be(cs->as,
+                                 env->psa + offsetof(LowCore, trans_exc_code),
+                                 tec, MEMTXATTRS_UNSPECIFIED, NULL);
         }
         trigger_pgm_exception(env, type);
     }
-- 
2.53.0


