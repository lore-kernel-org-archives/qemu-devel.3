Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376F1C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 19:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sClfx-0005cq-RG; Thu, 30 May 2024 15:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sClfw-0005bp-0k
 for qemu-devel@nongnu.org; Thu, 30 May 2024 15:43:00 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sClft-0006HI-0q
 for qemu-devel@nongnu.org; Thu, 30 May 2024 15:42:59 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a6267778b3aso104624566b.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 12:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717098172; x=1717702972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uF3iE8sM7cMEjCs0SvCbRt/oMMRILi0hvudECvvT8YU=;
 b=qyqnuRw7c9bVN8zdLBqsDWexKpOqpQDHUBq13VWQC5/mBjqMLXTQCl8r/eMW6tZPz7
 AIEy3MPSaqNaEImXCv1E4LqwBQvzS+6qrFUiOE8NFyoC3G/WTTHMCIU4Ne4Rn9LhHNnO
 XgXhdQh40IqxMs5A6TP6A7C03N9njojNxWnNFW1IQdY0//teAv0ZujUjhhUOw7lq0PcJ
 spAskfD2MCQ7cmnetjhDOAjN2h7NREBUDE58qg7kUUS3STkANlMaRhl32AAaevOvmBid
 lFlR1rvMHgD6ichbgygacVFh5cxIqb0AbMxtx6TT6IZvSxF3J28kR/4YkwE/PO/jNeyL
 sHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717098172; x=1717702972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uF3iE8sM7cMEjCs0SvCbRt/oMMRILi0hvudECvvT8YU=;
 b=LacK8uiUPGax5/XEKUcnVaDKSCTJSjKfyBvlrsz+uLc+GkWS6ZFLxbcaz2M3XWq5sL
 VuLZq1h8QnSFO044Pz6EJ72Tt4PbB9cz5B6KjQmioLdLtURjWhBVrFigPllVgo5YJcqT
 6tsP7AecLeeMuZqjKKGmRsVjAEjOcRwcfAdrlcd631KaAlo9eOelPWh2NvCvSLJWHd3j
 WPdl7P+YxYQf7yPnfhub1wKAigOx6ONURfri3v7CEBEwzHKlYMf0wVdGF1hEGJ5T/4RT
 KQ91Ta5+35a49pM72pZz1wB20h0MfJzoqPVSz5kCgmMa38bBw/KvYBLHuGoiTzhs5fwt
 GbTg==
X-Gm-Message-State: AOJu0YyeJERyLOX/n3VTjIUyv1rntjYWotfYMZznRgAobwgEqBJhS09D
 3sZgxMZqLK1cf1k2Xv3veon6Y01DR63qjEk7E+IniUrqRe2bwmLSpi6wpu8Lb4E=
X-Google-Smtp-Source: AGHT+IGq5go7pjxVXZoiDIctGP4OrpbOzSdrxavQVhZcrfZhYA5v6u0JB+p8JidVC79uF/koqWAkCw==
X-Received: by 2002:a17:906:ae8f:b0:a66:ebc8:ad2c with SMTP id
 a640c23a62f3a-a66ebd812e1mr100669966b.42.1717098171713; 
 Thu, 30 May 2024 12:42:51 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67e73faa76sm8314766b.75.2024.05.30.12.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 12:42:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A25505F8D5;
 Thu, 30 May 2024 20:42:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH 1/5] hw/core: expand on the alignment of CPUState
Date: Thu, 30 May 2024 20:42:46 +0100
Message-Id: <20240530194250.1801701-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240530194250.1801701-1-alex.bennee@linaro.org>
References: <20240530194250.1801701-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Make the relationship between CPUState, ArchCPU and cpu_env a bit
clearer in the kdoc comments.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/core/cpu.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index bb398e8237..35d345371b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -391,7 +391,8 @@ struct qemu_work_item;
 #define CPU_UNSET_NUMA_NODE_ID -1
 
 /**
- * CPUState:
+ * struct CPUState - common state of one CPU core or thread.
+ *
  * @cpu_index: CPU index (informative).
  * @cluster_index: Identifies which cluster this CPU is in.
  *   For boards which don't define clusters or for "loose" CPUs not assigned
@@ -439,10 +440,15 @@ struct qemu_work_item;
  * @kvm_fetch_index: Keeps the index that we last fetched from the per-vCPU
  *    dirty ring structure.
  *
- * State of one CPU core or thread.
+ * @neg_align: The CPUState is the common part of a concrete ArchCPU
+ * which is allocated when an individual CPU instance is created. As
+ * such care is taken is ensure there is no gap between between
+ * CPUState and CPUArchState within ArchCPU.
  *
- * Align, in order to match possible alignment required by CPUArchState,
- * and eliminate a hole between CPUState and CPUArchState within ArchCPU.
+ * @neg: The architectural register state ("cpu_env") immediately follows CPUState
+ * in ArchCPU and is passed to TCG code. The @neg structure holds some
+ * common TCG CPU variables which are accessed with a negative offset
+ * from cpu_env.
  */
 struct CPUState {
     /*< private >*/
-- 
2.39.2


