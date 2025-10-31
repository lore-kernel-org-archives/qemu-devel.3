Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A09CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtwu-0004p9-9d; Fri, 31 Oct 2025 14:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwq-0004lq-AO
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:04 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwP-0006EE-8F
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:03 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4270a3464bcso1797482f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935612; x=1762540412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bcg7GXTvqWbBwUT5qCuTYDd8DaBbj7mnR+TS0dZGLf4=;
 b=p/i773dFS7Un6WRLBpvG2UrPVot8k0G6ZZlzGe82PcuLN+3bb2pdbEmPNK+WN7Cdyl
 vm/XfaOLAX0wEoTdFgRisbP0GNE1iwyCcjqH7o3ICiPzWCxITeF2gXLdnAdo7nBhVDh1
 WS8pfZLzO2hLlvzki3IM4FI/oBDTLkDIGCzBlMaUCdM8GwmlCsczBsJz+607VMetbq+v
 ejxksXFVtnfr3TPjgCvQlrQzyw0z271girbQGM968LN4FxE1QPr+9Mh0E9+h9hKJki6s
 6v6236Sg3qciiW9Ktl3Ybd84Z40s2gzblS8vnLHxUzMvHs4Sjui0sn8x3qcxaAsRKAAb
 BlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935612; x=1762540412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bcg7GXTvqWbBwUT5qCuTYDd8DaBbj7mnR+TS0dZGLf4=;
 b=Zpc8tLZKck5FQ3UYBD9MfzlOS/HgMN/CqT8iMf6rO9sw9YynoUadEsEPs0rJDF1q9N
 rdZsD14vQmgPKCt9d12SeAJClrL2Q5DuVV2gDoWuVRS1qdnKuHQwglPnoVN8vVLsR454
 De1E50aA3EgNME7HOA61rtpmjJ4CkFhdRU0euprbPSPRTGzoGBkZpWkceXeGs9BYKgdS
 KklhN4Ww26XdPcP5ohzheY6Ug2jfgx4cvWWkQZzeQrzvw+WBfal6G6FQQf7IocFzLjcd
 8c8+5RJ3bxIyXtjC+JKxn/WcKQHIPB6Cd88qzWVY/yJejLb1dG62wpo/wbqIQNQMgiqG
 iIVQ==
X-Gm-Message-State: AOJu0Yx471wdhVBoWSz5d6P9Ni8Cmu6masQdtWs6Nw3XGqtQsVQ5FGtM
 dGCdTV0jVwlxR+r9DHe6brAjuUsdcNuXk8Gf9PANIdnaE1c9eam8yNK/0/i0naTyY5SJCaoxrd7
 UPUMs
X-Gm-Gg: ASbGncttHoTA1U1psL47FOIbb3iBx8jhD0PCKT7Xk2kqpieVc+1eWAfW4eYpHj/Sgl7
 xuqoXN8195pW9oSBnjeYJ1GsNBrpC+A0HgemtB+GTvymO55WopVCWoSuK2hhg/kstt3RQ8PMmLw
 YZZ0Vz6Vo+/BcFcHtI1OD39dfxSfJm9sVcmUYH4lEigauYAOgUNINUar7mtB4iFUUyWaebDWROI
 KxR/2zWp3PrYYOzc251WwWRpZ8qr693Jtvu5UYhk/YLj1PXUvzDjs2pTasx3sMvZI3xNI0nietw
 K+NTFtMV5yLbu/gKxdmk5LsEQrypE3IONZ9rahgyIXeWxSp59eAvH2owamI36ws2sOlnwyH6IPd
 lsR191a0GNXBAdsbbOwZax1BuyN5coBa2XSLDVLwKB2tdPGKJ8jAJ1BuO2v7L3c5/T6AO7679IJ
 w18s5Wn5lnYm2rgxZk
X-Google-Smtp-Source: AGHT+IHZlHrdPZg48A8koWkls+EhiRx6zMsRm7dh7868mmH4iCNqx0vNFsWCHmKPG1mUhi3NYuA3KA==
X-Received: by 2002:a5d:64c7:0:b0:429:ba36:5fa2 with SMTP id
 ffacd0b85a97d-429bd6c1837mr3812145f8f.59.1761935611949; 
 Fri, 31 Oct 2025 11:33:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/38] accel/hvf: Mention hvf_arch_update_guest_debug() must
 run on vCPU
Date: Fri, 31 Oct 2025 18:32:51 +0000
Message-ID: <20251031183310.3778349-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since hvf_arch_update_guest_debug() calls hvf_arch_set_traps()
and hvf_arch_update_guest_debug(), which must run on a vCPU, it
also must. Mention it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.43.0


