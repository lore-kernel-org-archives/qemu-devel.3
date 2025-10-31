Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D7ACCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtwm-0004iO-OH; Fri, 31 Oct 2025 14:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwb-0004Sc-PW
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:51 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwM-0006Dl-JK
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:48 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3f0ae439b56so1549515f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935610; x=1762540410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ky8qouZZIqPMdqQhVv4oLwP8VZNBD8cex2YUmgYsXNc=;
 b=Vui9/Ayb8b33kv/lVIBkBEDoPAcheEFfl1/Ajtd0Q4QHzLuHetGfDPjr360GXMe8ab
 YPO4uxnMKWOyJ/DOvQLKW1i17ytnxW6YwI0A48ck9HJGxoI8hFRc9kNRgKwQTNqL6v99
 rVUV6nYrBGCiPuTxAUpWZC9UxZmvU8ezDRKM4v2LxNXxQvxjlT3oZcs4E90hVy88uNAb
 eTMjqo4q59xhkLH9Ruf0VsF8zxespfqYiKlVnBQlLRu5r2pOBi4RvObVq26yZtDw0h/e
 qnIpGOBrTR/4ILGQBQBHspozoK55nh466rr0zN5R/oiovPxYHq6W/wmQdaT0Pk4WyktI
 LdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935610; x=1762540410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ky8qouZZIqPMdqQhVv4oLwP8VZNBD8cex2YUmgYsXNc=;
 b=H+sTzCcNlf/aL03lQ1YzFNhHbHdlFVj3z1/dlD4y6L/u27OfzN7RZEJfS/JPkyj0lU
 hQDRhyUSvvsZ9UcgfG5R+nThgXmUloo1wMd/oPy+8tMNZLSXnKjic2vpF0fomHy9WmCm
 BbhwydmJH9c1YiWaMhb6Nns4JHb2p9WlwLvWx4TxC3vAsTk0XXLU/7pwxfPAMOf41uBf
 WcunTzMKLEYUiTFijxuSCXSZiMIFZTvA3H+DS1hd1h1atMmQZ1Dl1GLxTSL5sWFOCWfR
 lCwvAywlpEV3Sw6LkIyT1gWzBYYixcqy3Q+yxBJ59iofb4QRVwUptCG/BNn/kX3vW/pN
 UIFg==
X-Gm-Message-State: AOJu0YwMPp9zbzLHzdBP5dCMSqi+WYy5O85vajWbyXEM5FJb3/wUUSdD
 jUyrGBgya/R4tROA57LHZOcLPSPuF1fBalQXYs7Nts1ZT8I1I6cFk5Guq7pacgnasW1FE/aaZBU
 HczBo
X-Gm-Gg: ASbGncueztrCuHnFCAxPfX4n2sk2H32+yMt/dAKQbLSG/HDQHy3h2WYFHj+m/iEkDyO
 zfZFPXnLCIfSs2Ww0pYX8giNQ0OdzZyb7sKjV+yz1dVZs35h0fo276tiZgyRQKn9ceMRHG3J5ub
 cowr0rQ/M0zh0UQHID4IqFi1jiRjm9aKJunJ91e7Xa4r3Z4tpDQpUIqXD6l5uwjn5C8MpCCwudl
 /BIYcgL/nxmV0aUIpOKRlb3ay008Ru8P6IZFvt5pjCFnVjIXMglh5z3OBaJnElpd+H3nAxH2JDP
 3l7nt6m9eORJkoI9CKPBxFTqn4jb+ZDnN3eH0H6E+G7MEec7QTdwoqZuuWXS6jEjSCpmMBLFs2f
 YXv5sKVzblJJbMmqpHFidnZggbg/Nqu+Ccd93g6+kdB4VHkJ/8CAQqGA4tjjqfZSuffbjt06kZY
 Fp3ifg6iKuNtSdPvPM
X-Google-Smtp-Source: AGHT+IEpwqvX4rW7IefYq1RkmPnrK7VFyKu+54RKAtjdEgPqHLj0dQxKSACIwwdFx1bOhZKp6+6B4A==
X-Received: by 2002:a05:6000:1a8a:b0:429:bc68:6cb6 with SMTP id
 ffacd0b85a97d-429bd6a7f2dmr4061321f8f.45.1761935609716; 
 Fri, 31 Oct 2025 11:33:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/38] target/arm/hvf: Mention hvf_sync_vtimer() must run on
 vCPU thread
Date: Fri, 31 Oct 2025 18:32:49 +0000
Message-ID: <20251031183310.3778349-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since hvf_sync_vtimer() calls hv_vcpu_get_sys_reg(),
which must run on a vCPU, it also must. Mention it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8095cb0805a..bfccf5e9a2a 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1764,6 +1764,7 @@ static void hvf_wfi(CPUState *cpu)
     hvf_wait_for_ipi(cpu, &ts);
 }
 
+/* Must be called by the owning thread */
 static void hvf_sync_vtimer(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
-- 
2.43.0


