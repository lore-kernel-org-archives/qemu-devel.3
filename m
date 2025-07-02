Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59B9C8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2bg-0001vf-43; Wed, 02 Jul 2025 14:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2be-0001p7-8x
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:54:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2bb-0001nF-K9
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:54:53 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a6cdc27438so4135294f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482487; x=1752087287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K7agq2/z/dMVKZ8AYrQE6GIlp8fdEIwRrjWbdb+ua6k=;
 b=pfFwlaT1zqK+wo5539RRzpwGKUHu9UzEX5WcrLPZpZ1DussBHvIwNip7+8wStAaQrt
 ZxXVMMxLHWVe7BVaGkbLdrER2q7P/7gaGGb0ejZ0IFaF47Bn9crW8114K3LQEusGvRwc
 N/FWgODTT1C1MdEv5JMN2UtmNFXXI5tBRjPVdiEqn43rVFmxI28KRayz0rV33XruMGST
 KdS6cW2R+y9wn3BHuwvOpoB7djkksW6EZ2I81OgdClnYTkpie9+EbpluA1bJJRIdz9kP
 gXT1k6VxKViC1DDFuOo9JcbynTqQ1HWRDqc7cw3sIGST3YiY8ZFHYBasuUfEBwNouVQx
 9c9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482487; x=1752087287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K7agq2/z/dMVKZ8AYrQE6GIlp8fdEIwRrjWbdb+ua6k=;
 b=GaTN0WEibafwtL/vFfmQ1qV9shHNGXixMFbxww8MvKagYRVSJdwCpb9tJ8pZjVFSIu
 /ciRORUl9A8TqPIMKUyft1wiDufjlKMtO1L76wWfx8QqPv3X88bXCR0bT0A6s5FqeAtm
 FsWj7J4QcWVnde5pJvgMjm66nNBw2KoG+DoFsRLMy+H/6VTsET9H3HzyJ5l2qWKnTXwf
 D/WuixIR1buawgWfkuIKuZb/RYEGReSViVomaJ44KpPbzkEspKlOZxcYwz6QYy20bBzp
 D0pFKSFdtGwLHKEvdBh5gdJeXd5M5rwJRac1hJMG3xv+vo4k/wvVpJAbDozFwKPZXFgE
 WK3w==
X-Gm-Message-State: AOJu0YzxfON+sqV64/2YPzt6rpgwFMeZckk4C6ojL7mbuz5XE56+CLDG
 1mb9cSlntuIG4KTuxhmVtwDpmZHkjdUFS2JhHlx3IaL/dTGRjTLeH+/+kKGpkTaw6AfM1TRZouL
 d1x2t
X-Gm-Gg: ASbGncs7tfxmFwKU/SgMRWX0ouJMsr2ZpsuIvQzs+GBgwvQl6bUh/6+UnA8/SFraYGU
 maXcSOJDNUQF1Z2j7jw133QQB0vh8Z81WCpL5EP+/1jqBq395H9X+/FoCC6RPTUoILrpnhJwfiI
 GyARz1mgWc8qaJVH/HIIjrGkfLV4YDKWM+EFGjeUho62gZR41HmzKpiW+wRMBqf0r0Weds2W0eO
 yRht/iD0unCniAKLx7P6SzRqxU64rux6xXfvmJUDTZur7wUf+auockWwWpsuIDh5xFXxKiufcZ5
 zxdZjN5QkKLxQQmXyFqXAPVwrTzCcc6eXVzWiDnqikJNQpEX+JanFHFy2UEzNHEVNigmoGDwHgm
 zKyiFlPgdrly4FfTXY1CfjXz2OK0mcBOtmwrN
X-Google-Smtp-Source: AGHT+IGUQtIt1emteiYwV891bgO7McJF2bqG2ULHbJtk+FF44HE2MvtisHO4HAlpGrc/qLCw3aFVzQ==
X-Received: by 2002:a05:6000:290d:b0:3a5:2848:2445 with SMTP id
 ffacd0b85a97d-3b1fe6b5ae9mr3546118f8f.16.1751482487269; 
 Wed, 02 Jul 2025 11:54:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9989423sm5599515e9.19.2025.07.02.11.54.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:54:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
Subject: [PATCH v4 10/65] accel/kvm: Prefer local AccelState over global
 MachineState::accel
Date: Wed,  2 Jul 2025 20:52:32 +0200
Message-ID: <20250702185332.43650-11-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/kvm/kvm-all.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 264f288dc64..72fba12d9fa 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2588,15 +2588,13 @@ static int kvm_init(AccelState *as, MachineState *ms)
         { /* end of list */ }
     }, *nc = num_cpus;
     int soft_vcpus_limit, hard_vcpus_limit;
-    KVMState *s;
+    KVMState *s = KVM_STATE(as);
     const KVMCapabilityInfo *missing_cap;
     int ret;
     int type;
 
     qemu_mutex_init(&kml_slots_lock);
 
-    s = KVM_STATE(ms->accelerator);
-
     /*
      * On systems where the kernel can support different base page
      * sizes, host page size may be different from TARGET_PAGE_SIZE,
-- 
2.49.0


