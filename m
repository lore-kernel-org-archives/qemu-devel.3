Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D39CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ySA-0003xp-4N; Wed, 01 Oct 2025 11:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yS3-0003mR-7U
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:09:07 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yQA-0000o2-L4
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:09:06 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso982236f8f.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331213; x=1759936013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u2utxhkX+sqm/78vx0PLpcnsUSPgNTq+5sqtMIdFotg=;
 b=gmTigabxhSUEiqAxFF041PIODyZBMpAZkqZ5qoF/N/9xO8f+7B3trs98mGZ2cVe8Dc
 pQiaavG7YzIf4edTIvC8Q14Q8pin1bu3tol64yLfr0L0nXS9DpqIfj2h2hmUK9HxBXZl
 fKviHNLALeoC1Xif2ZTEBVBzvga2B/4l9VluPb5vGHPQ04X31622XgEOjX4/NAjJc1h5
 Qae5aRnPSne2xAYzncDFNY/CTU8tTiRNFpiS0jqLgiT5gp/TU7jFqtDg8i24TO+1Mt9O
 cVv6RPqhIYN/+zyzmW2hj2YVNwtredrkbkPrVLJvt0YyP0aHm90Hm6C4GvCWGixiZ4Lu
 tzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331213; x=1759936013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u2utxhkX+sqm/78vx0PLpcnsUSPgNTq+5sqtMIdFotg=;
 b=mYGqnkxZ3h/sEZLhuwkjj9ngwykEKZlIROjACNrz+OTYV/wT3ns1BZuqLSCUl4p7fF
 0NL8f0s2cZc8TIUtpUuMsoij/ctPPbCMPRM378qXNAB1nhypGehKo5X4ps/4k14M+UPx
 MV6nnGt6QIH2HTRYqKnamLHlaYjsMwUFNWW+xMkiLsfL3NJ4DXpU9bxH/MgerX2W2NeI
 E5QvcG3SO0vLxhGsdHPW1klo8GP4370fEpb2h6R8fzXPJdPqwh2J/bgYcaTBtx/RpzPE
 IKMLNjo22tE0RrzNN4zUfOpnkZFJX8S2Uyplub2RPNB+p5XZsnY1uzoxP9N3qRm71yaD
 nNrQ==
X-Gm-Message-State: AOJu0Yx4GAUtXXXvAzICGInbZzUs+ra7FweI2ABhHgdq4txRcuSvsK5I
 xTr3fz0c9uLVhiP8iPAGi3ZuyEexKsccawIis0iIeTNppFWfX4sMsT50EBO6wiWlYxinkAXU86J
 nEKR73AwqlA==
X-Gm-Gg: ASbGnct67xL2NCl2Hn/PPGyJ+gkJQ/fCDbcGZh1iia+OnqRS2HItXecvx6uTzCCXSC8
 EIXm7lBeXGOU3rm+oixUPkaUwagh0qm6kB26liuscbaakJumoOpNdA6e050gO0m8MI0nDndTJ/x
 or45A+HFx5DqwMVnSfAmzXr9/C0BeFME3ZgEZh8VeYMsuxpbk1Er3fNm8osDihGARtF/cwqAave
 RRROqB6k9QHiItYg7IXy+vc729d5a/vRHWgFf2cOAkpa3Ajot2XdUnY6WdxtATFUTxEE5KwUQsW
 WsB24kLVLwoqmqLAw4Unc3w0j4iIXyo7ejNqQvnD5WGBr7C6OBz95M02Mkt4Yz3oXIEM/gC8jtw
 PjhVH31plFAjDZaNbdwLpM347zmSn9pPvkKWelbObzobLoW98lYF9dORYgUbY/kO1lDvTjQ4yZI
 r0hobBgnsANPbNHmS7PHAZ
X-Google-Smtp-Source: AGHT+IHQlTiEIstk+7CUIQ9ughVxQI2O9HjYcxri7FE/tcqSvLzS7IOVOzvkQ6bzZxQnQnC8KmW1Tg==
X-Received: by 2002:a05:6000:2282:b0:415:15eb:216f with SMTP id
 ffacd0b85a97d-425577761d4mr3497423f8f.2.1759331213296; 
 Wed, 01 Oct 2025 08:06:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fb017sm27360874f8f.3.2025.10.01.08.06.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 08:06:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 16/22] target/microblaze: Get cpu first addr space with
 cpu_get_address_space()
Date: Wed,  1 Oct 2025 17:05:21 +0200
Message-ID: <20251001150529.14122-17-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001150529.14122-1-philmd@linaro.org>
References: <20251001150529.14122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

In order to remove the convenient CPUState::as field, access
the vcpu first address space using the cpu_get_address_space()
helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/op_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index b8365b3b1d2..f07d795bdf3 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -448,8 +448,9 @@ void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
 uint32_t HELPER(NAME)(CPUMBState *env, uint64_t ea)                     \
 {                                                                       \
     CPUState *cs = env_cpu(env);                                        \
+    AddressSpace *as = cpu_get_address_space(cs, 0);                    \
     MemTxResult txres;                                                  \
-    TYPE ret = FUNC(cs->as, ea, MEMTXATTRS_UNSPECIFIED, &txres);        \
+    TYPE ret = FUNC(as, ea, MEMTXATTRS_UNSPECIFIED, &txres);            \
     if (unlikely(txres != MEMTX_OK)) {                                  \
         mb_transaction_failed_internal(cs, ea, ea, sizeof(TYPE),        \
                                        MMU_DATA_LOAD, GETPC());         \
@@ -467,8 +468,9 @@ LD_EA(lwea_le, uint32_t, address_space_ldl_le)
 void HELPER(NAME)(CPUMBState *env, uint32_t data, uint64_t ea)          \
 {                                                                       \
     CPUState *cs = env_cpu(env);                                        \
+    AddressSpace *as = cpu_get_address_space(cs, 0);                    \
     MemTxResult txres;                                                  \
-    FUNC(cs->as, ea, data, MEMTXATTRS_UNSPECIFIED, &txres);             \
+    FUNC(as, ea, data, MEMTXATTRS_UNSPECIFIED, &txres);                 \
     if (unlikely(txres != MEMTX_OK)) {                                  \
         mb_transaction_failed_internal(cs, ea, ea, sizeof(TYPE),        \
                                        MMU_DATA_STORE, GETPC());        \
-- 
2.51.0


