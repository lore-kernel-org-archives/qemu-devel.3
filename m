Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33546CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBw4f-0005hx-Ad; Thu, 23 Oct 2025 10:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBw4e-0005hD-11
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:13:52 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBw4a-0007MZ-Gi
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:13:50 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4298b49f103so214635f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761228826; x=1761833626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bn2C92Ox23h5s0IuScw63a4Ihrbd//B4afSM1bgktqo=;
 b=zCut6CCnlIr/hJcruYMVtZg71sK+5Uh5Kt2OVLSn3yHPnIu5e/kkSb8HMwVNKOZQof
 en/ue5ACG0sv4DDSe/DrysYnT1enfSszzE8QpfxR006zCtcRpVMg5gdkZfK6jmbEFY0I
 sERYil58MJSPZyuSf3ltpFFNHAaxX88TK0BmumuWx370on3GBMGK9MKceIpwdMuC6qov
 MoR9c9/NUAz50Zc7h+WMapQ1UdGdaXWdpMMAPD24vdcfP8GkBzfUnQkNbF3X3ZlZ5Syl
 hVLJRhpjI8HMaAebltvRT5kqZjhvjOFkJoNT941My6bqfzB+yyD2/1/6ebk2fdh6CpKW
 5JZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761228826; x=1761833626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bn2C92Ox23h5s0IuScw63a4Ihrbd//B4afSM1bgktqo=;
 b=VMrzcpYZzgwN3tYM9+VkZtgitFCfMcaPOzkmt+LysCE6DfkxtnBG5+/t1AWBWKzCjU
 sYQnHNZA26SC4slHnMdqMJnEOkS2JqdPW+vXnBArrb+XWDrsaNbWkkvSXwp8TOQ9Nm10
 h96Co3AEUgy9s5p+DO+IfGvozbl/NiSnHrajTdk7THTW+tiz2ljrdWL350b+LVxAVkpQ
 rql+kyrDBdBaS302wvpFZq3Coy9QpJT2qt5wOstfHhgzBz7GZqz2JG3md1Z7LnT7iG3Q
 W1OfiKjGm8RJXGawGeIf+7KMs/qb05gS96dCGwXj1LU1JOapw+v90ozSwsNCkMNiecOZ
 bm+Q==
X-Gm-Message-State: AOJu0YwgvK3YABlaWFKQ3Y+Wft6XReMuPLS34rP7C57pldE4Z9VlM+d8
 E+bmd7wkZEbuI0zYaaY/Qxa6XfIY4ozbQIWPBUBfeLGQZ1lBT709MTsxdIDR390brmcmPnNWq7V
 AUPPwxJg=
X-Gm-Gg: ASbGncs5nA/KtI4sQ+x10nMUD8aKqGZRS5tP60EiCb8/33LQStSqEia9UcAOx78tUAN
 C5HzSMlzoftCGeoBWSp9V2XKkt1mCQ35d5KZS3timvkrw7xBhV0/pMdDI1QJT0aVChoPbddR8J6
 +wqr1ZivpMWMKqpnyFtg61SfngFLc4262n7B7x4DmaOW59vqtrL3EqbUkUthxFJ5f3asFAgivXT
 lB1inPXehpeGSz4PS6JYj8OdS/6M4SgmoDmc9yoIrpnhZJYT9Rh58ifSwFrokxnn/t+f8UnrEdt
 c9Pd07VNilAoy+WBR3tlapeulqZOFA16U9HbJMxW7y/UuOfJX0gH0jjgChyo2L4ZBFHaGQSEEpx
 lqXAEOEojkkaOPbwHlBt/H4xuQ+3FY2hn2Fez+XV2mrG269CfWLkj2HW8I4EaG/DWLBRVPzqHDF
 9qYQ7cjAdOi644tF4ylYumizYVDhC7SdwxWTWwDaL5G6kpaYGDCCnWPokPjtRx
X-Google-Smtp-Source: AGHT+IFOObY4FZQI60HAKVyYFMcVdLy2QIR00SAsee7dM4Kc4Y6LZN9jVb7S4ynbEXe1Qt2RZDCCiw==
X-Received: by 2002:a05:6000:2884:b0:429:8d0f:eb4 with SMTP id
 ffacd0b85a97d-4298d0f1116mr410025f8f.28.1761228826243; 
 Thu, 23 Oct 2025 07:13:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897ff3f5sm4349458f8f.22.2025.10.23.07.13.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 07:13:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Collingbourne <pcc@google.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v2 11/58] accel/hvf: Mention hvf_arch_update_guest_debug()
 must run on vCPU
Date: Thu, 23 Oct 2025 16:13:30 +0200
Message-ID: <20251023141339.10143-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Since hvf_arch_update_guest_debug() calls hvf_arch_set_traps()
and hvf_arch_update_guest_debug(), which must run on a vCPU, it
also must. Mention it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
---
 include/system/hvf_int.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 0c335facc3b..241c668795e 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -83,6 +83,8 @@ int hvf_arch_vcpu_exec(CPUState *);
 int hvf_arch_put_registers(CPUState *);
 /* Must be called by the owning thread */
 int hvf_arch_get_registers(CPUState *);
+/* Must be called by the owning thread */
+void hvf_arch_update_guest_debug(CPUState *cpu);
 
 struct hvf_sw_breakpoint {
     vaddr pc;
@@ -109,7 +111,6 @@ void hvf_arch_remove_all_hw_breakpoints(void);
  * handled by calling down to hvf_arch_update_guest_debug.
  */
 int hvf_update_guest_debug(CPUState *cpu);
-void hvf_arch_update_guest_debug(CPUState *cpu);
 
 /*
  * Return whether the guest supports debugging.
-- 
2.51.0


