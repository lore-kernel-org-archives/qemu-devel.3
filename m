Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE64C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr6D-0008Kk-SH; Fri, 17 Jan 2025 13:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5r-0006b2-LV
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:20 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5p-0000L6-Kf
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:19 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ee709715d9so3560412a91.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138554; x=1737743354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VnAY5AK7GVGkWUkhZpxNBk2WcY053ri+rky+3yoomPk=;
 b=VD+GDSptTjAdDKHZO6FEb3apHCt5nEV1btM2+3s2CXtuHyn1UYFNOwq9I0mNDvfuS0
 aWfAalYFdsWizylrOBVDTe5Rb1xWUz3/t6D27B57OpvJdeGwYIpbfClpJJsuoiU0xwFY
 IhQkMod6kGu/+gZyFfqUAnANWYJef9QlIIYnEBcYhEhZRqM7zgqAJZ/VI9LaiHCIakyb
 LbuT/Lj1FlvPVab2WQsFJAkk1VuygHNZj3HK3N6RIFIXyRATyY5O9UqU8gE5CVaKfzGi
 vbE3+FZ1OGeyXPDLXe42cHKniep2rbmP3gB5cL1Xa90xMt+p6xy398qqRZls3dv162Rr
 S9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138554; x=1737743354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VnAY5AK7GVGkWUkhZpxNBk2WcY053ri+rky+3yoomPk=;
 b=Xe1RrtpKXWaU/gg5419gqJS3h4WJjm2Asw/scR74vo4pJPKujtqzCnugHvrJQoJ7Js
 zWL8Q/JR43LM8ac00hD22RG3OvvPQQ7rQkE56Un5nDfJBWZ/I54CeIJPsF55e9CbtQbs
 S6ac+8lSIO/7Gh1KhzVaQBq+d2OGu99DFyiok3v+phvRjnVZsAHScp6JJwsyUJa9jsZ5
 aoVIhVODctp3lRFEt18fGSXuiNYyTaYme4REL9NzclEg/Mo4I2riKw/K90rKyJmdoFaN
 LCWRpPaE7lNOWsOxeswykI8HXu4L4Bka0BSROtbXq69DIbhVbFm4aJaqRvi1/udlnAAK
 U7fQ==
X-Gm-Message-State: AOJu0YwdYdsr/oCaAyRlDaCYmENb6qDnyl8FkxUrLEvFzhW9FiLeXjEn
 u5dr+tLMNMCt5uKhLJK5sSWWQb5laIe+WoXIzadEuLIZ6IRmCX80FelevRmeN/QIFgU9RCl3ir1
 I
X-Gm-Gg: ASbGncuFGNNNo7+VcJAtNG0f1mdahfwZkkAebS29QhDN0JhQSzuL0Uzes2JEMesVznj
 bb43gUalLEnUUCu1AbLUZHUOh8PyhD7PRGx/V5CON6kozhXaHYf2RahajLq+sa5Lj66oHm/wYKM
 Psfo7Y2X2YS8YTBjQstPR9N3O/+DS2rLRFa8Wwroi5HsY937jLc6Squr7VSMbs8nrp096SxU+wm
 L4uQ/kLmtX1L1RT31ijtenCwiR4tWy6mdZJqCoRb99Q/CIu3TzhbhEwFxKhECmuipTn5jMvdKbC
 OifLKWCyfX7waTo=
X-Google-Smtp-Source: AGHT+IEaKR4MpHx8aCyATc+sj5zhBbBd0xw0Y7SPwxYl/Z2Ey2+TtJ7jGrcXcalsESCMbVrpfzhJfA==
X-Received: by 2002:a17:90b:5249:b0:2ee:e518:c1cb with SMTP id
 98e67ed59e1d1-2f782c4bdd2mr5615223a91.7.1737138554175; 
 Fri, 17 Jan 2025 10:29:14 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:29:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 67/68] accel/tcg: Call tcg_tb_insert() for one-insn TBs
Date: Fri, 17 Jan 2025 10:24:55 -0800
Message-ID: <20250117182456.2077110-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Currently one-insn TBs created from I/O memory are not added to
region_trees. Therefore, when they generate exceptions, they are not
handled by cpu_restore_state_from_tb().

For x86 this is not a problem, because x86_restore_state_to_opc() only
restores pc and cc, which already have the correct values if the first
TB instruction causes an exception. However, on several other
architectures, restore_state_to_opc() is not stricly limited to state
restoration and affects some exception-related registers, where guests
can notice incorrect values, for example:

- arm's exception.syndrome;
- hppa's unwind_breg;
- riscv's excp_uw2;
- s390x's int_pgm_ilen.

Fix by always calling tcg_tb_insert(). This may increase the size of
region_trees, but tcg_region_reset_all() clears it once code_gen_buffer
fills up, so it will not grow uncontrollably.

Do not call tb_link_page(), which would add such TBs to the QHT, to
prevent tb_lookup() from finding them. These TBs are single-use, since
subsequent reads from I/O memory may return different values; they are
not removed from code_gen_buffer only in order to keep things simple.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250116213214.5695-2-iii@linux.ibm.com>
---
 accel/tcg/translate-all.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 453eb20ec9..7ec1c53f24 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -531,16 +531,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         tb_reset_jump(tb, 1);
     }
 
-    /*
-     * If the TB is not associated with a physical RAM page then it must be
-     * a temporary one-insn TB, and we have nothing left to do. Return early
-     * before attempting to link to other TBs or add to the lookup table.
-     */
-    if (tb_page_addr0(tb) == -1) {
-        assert_no_pages_locked();
-        return tb;
-    }
-
     /*
      * Insert TB into the corresponding region tree before publishing it
      * through QHT. Otherwise rewinding happened in the TB might fail to
@@ -548,6 +538,25 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
      */
     tcg_tb_insert(tb);
 
+    /*
+     * If the TB is not associated with a physical RAM page then it must be
+     * a temporary one-insn TB.
+     *
+     * Such TBs must be added to region trees in order to make sure that
+     * restore_state_to_opc() - which on some architectures is not limited to
+     * rewinding, but also affects exception handling! - is called when such a
+     * TB causes an exception.
+     *
+     * At the same time, temporary one-insn TBs must be executed at most once,
+     * because subsequent reads from, e.g., I/O memory may return different
+     * values. So return early before attempting to link to other TBs or add
+     * to the QHT.
+     */
+    if (tb_page_addr0(tb) == -1) {
+        assert_no_pages_locked();
+        return tb;
+    }
+
     /*
      * No explicit memory barrier is required -- tb_link_page() makes the
      * TB visible in a consistent state.
-- 
2.43.0


