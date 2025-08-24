Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785DCCA0EED
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Aug 2025 22:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqJBz-00064Z-4O; Sun, 24 Aug 2025 18:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqJBr-000633-Au
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 18:27:56 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqJBn-0006An-RN
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 18:27:54 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-3366307712dso11476911fa.1
 for <qemu-devel@nongnu.org>; Sun, 24 Aug 2025 15:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756074469; x=1756679269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1WoT7s3OlYD8+G3GhjBVb2VoQPl7Qm4aiBJ1d2EKqNM=;
 b=ODuq/QdG/7DfZY5miQgB41NPmCdK0KSMlwVFLOsAejE1sbkmS9BjwLJa74vgrBDKh4
 fHqP6tJVv5Pp+Ecwq//NlNqq+flGeQs7mKuol0EHx/dbgGzYNYEAgGUK7qsiepMURMxX
 c/x/OZPvaO2faG1FI2PfkgW4VvD1qqVmHx+NZtr403Qwd7OHFbZXeN9VAcqymD7pgAg3
 +FH9W1XmZXnnEihlQ5sTYk2p+e9ArU+kZwa2nYpqYZ4i+DakP/zH4ZH9095HvGeRhEMJ
 xBFUguTjbdhJKkodrz+o2baDi7lIbLVnoUR2sE9boB4IRU6GmQ0nXkqRaDqm7xslYSMk
 k9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756074469; x=1756679269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1WoT7s3OlYD8+G3GhjBVb2VoQPl7Qm4aiBJ1d2EKqNM=;
 b=rsuz20frukficQevTdXC/d3nII3JanmOyO7hxUcnbWaRooIE1GeFWaBgl/3BHOFqYp
 IyRiCnpVr9s4F2yOTkw7neSaObyUq6BFuXZvMgbAgeRejbD8wg2Y6PuYfhWpepLBejwt
 oK7i9Pbj9O9aQBWdrSaqJEIj/VVoNLlanx356J+H47lhmQ9+zw/D7yWdrVblaltZF5A8
 /TD4x28XQASQyKuBGSv/67h7Zsun2H1kowzkxJULLo0S7mZb4lyG/Y/gm2ymfI7fmelU
 zNpzkScxAvMG1oWtFIZHplIeyDj0+oKeEUn0DRAdI8GlMzX/UCWo4J9gYmcejipDaZ1/
 Rvjw==
X-Gm-Message-State: AOJu0YxGYgdomQy7B8RCSMQErOMQE1ynfAY2tmj8EgWvXdxrvpOsgwvG
 cMZw/N7i0u5NHXacaw1BAA1FKXqAOe7B3rf/g9fEqsWaKZy1hven38Ar4H5TnZRG
X-Gm-Gg: ASbGnctz2mSMkwBO+vZZI4qK0BYDmw8JFOD+30E9WoGGGua9AqMsximn6LZgPqHo3bb
 Rwv+nXf2Jo8ENsUcRtepxKMGtemfH+cpGsJiRTeL8MtWo709iV60yrLWjKPdsvvhBftx+O4S/0g
 DKMLWF6qGd01aLw+aULse1s0GPDEn1+t3TgqOX+gN5kGTWjYeRPYEoc+RWnZUcKTmsJ6gPJGE3i
 pq1N7KshpWBEUzOtXD5H/ViB96kuzY1HgDd1M51YBSAaEu4a4Gy+6Hm80b84MRcSW4IL5pD5Ptw
 wD7ShM+Fv5+gd748dE5ySj6mBCVH5QJuD/poN4QEW2HQNStMygxg3mLsMFegjpYb+6dyJrUvJtO
 oqro9boyYaKR8wvH3x1GXzMogD8QxQjHgcZLGu+iBb3VftYgRRvCSTrYtrj2bZ+YKaeSsKK9V9w
 +MJz2K
X-Google-Smtp-Source: AGHT+IEV6a27k4eBXr5cm7mt613vzPVqNeVdyod6wtYoCah+hTH/0/d9cfUQJE73253IspCViKmMUA==
X-Received: by 2002:a05:651c:20cb:10b0:32c:be6e:6719 with SMTP id
 38308e7fff4ca-3354a18bd45mr27613181fa.1.1756074468669; 
 Sun, 24 Aug 2025 15:27:48 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3366fdea6eesm5708371fa.44.2025.08.24.15.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 15:27:47 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: richard.henderson@linaro.org,
	edgar.iglesias@amd.com
Subject: [PATCH v1 4/4] target/microblaze: Handle signed division overflows
Date: Mon, 25 Aug 2025 00:27:34 +0200
Message-ID: <20250824222734.4151956-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250824222734.4151956-1-edgar.iglesias@gmail.com>
References: <20250824222734.4151956-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Handle signed division overflows as specified in UG984:
https://docs.amd.com/r/en-US/ug984-vivado-microblaze-ref/idiv

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 target/microblaze/cpu.h       |  1 +
 target/microblaze/op_helper.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 3ce28b302f..7dd86653f0 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -87,6 +87,7 @@ typedef struct CPUArchState CPUMBState;
 #define          ESR_ESS_FSL_OFFSET     5
 
 #define          ESR_ESS_MASK  (0x7f << 5)
+#define          ESR_ESS_DEC_OF  (1 << 20) /* DEC: 0=DBZ, 1=OF */
 
 #define          ESR_EC_FSL             0
 #define          ESR_EC_UNALIGNED_DATA  1
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index d9444aee29..e5f13824d8 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -89,6 +89,21 @@ uint32_t helper_divs(CPUMBState *env, uint32_t ra, uint32_t rb)
         raise_divzero(env, ESR_EC_DIVZERO, GETPC());
         return 0;
     }
+
+    /*
+     * Check for division overflows.
+     *
+     * Spec: https://docs.amd.com/r/en-US/ug984-vivado-microblaze-ref/idiv
+     * UG984, Chapter 5 MicroBlaze Instruction Set Architecture, idiv.
+     *
+     * If the U bit is clear, the value of rA is -1, and the value of rB is
+     * -2147483648 (divide overflow), the DZO bit in MSR will be set and
+     * the value in rD will be -2147483648, unless an exception is generated.
+     */
+    if ((int32_t)ra == -1 && (int32_t)rb == INT32_MIN) {
+        raise_divzero(env, ESR_EC_DIVZERO | ESR_ESS_DEC_OF, GETPC());
+        return INT32_MIN;
+    }
     return (int32_t)rb / (int32_t)ra;
 }
 
-- 
2.43.0


