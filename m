Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC50CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShHx-0000qJ-GO; Thu, 28 May 2026 16:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShHo-0000XY-DJ
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:25:03 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShHm-00051k-Cu
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:24:59 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4906869f0cbso52363855e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999896; x=1780604696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YSEQRbn3l0io9yhr3T8YsgNy3yJtdxIGruyK16V/CRo=;
 b=LDVuZte9tKZQwD1Sd0HZOn64upmmVKq/XgGmZzTU7Vdyb0jkRSool7HMAiG3IGx63m
 hTKzkQgpl/uPo2qG+FlcAOfCNts07p9Jgj4lTDXpsNvZx6L7vxCPPliGHZBtfWe6Bgi9
 cpaY/2MY+sl/J/8gpA+zCRYBMecxqRJsyAi6/nPppLHIMt8qvKJjRWzT20vP0k3kX7jC
 w6n50/bK7JXUTgvC4EcLPNf9fDLmbjq1b4R0lr5jHB22LEGsGqJZiCxBQtz0SSK7kS1t
 Iou4MSzqGbl1GxQhCnzXAE94QZ2JYCuPi7a6UQNZBGeE7S6Uzbvkvb/Xmrz986rESVbw
 C40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999896; x=1780604696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YSEQRbn3l0io9yhr3T8YsgNy3yJtdxIGruyK16V/CRo=;
 b=MrHyK9t2RdX6Yaf3fawBLeB7EmTSCJplGMl9bBLQofxua4HKaj1KGwqacYvdq/1MG2
 +qDHeCu5NzfzU0alYXINxxtQG02FXrl68mldGCgNAtG072qUJ5uPr3HrRUG9rm1178xC
 83usW93dAY4cxbNEgq+70YgFcQeVh5m12KGF43T8NWwmzt6INympfex6FMqw8do0UgEJ
 3d+BliqqlUfoaMH8EA8c2QNeasyIPY72l64P4i/KnCwJKgz0SuvcREcOcI2YjgCfy06K
 r7FlTBMu6uT/2Blzrt8wxxkpC+fLRiP6vlmRhaDvpEmNq4qb+FQuHXyDSZzOmqIClKaf
 WNng==
X-Gm-Message-State: AOJu0YwwwJqo4XRdmh23bt9I3wWDNYva/JV4wfbJmmu44awm8zG0ZzRN
 Fiz+cs85XxA8clr6umwPDpbBs1ddPQD3fPUFSASaAltV9J5JR9sxoEWSo7uU7S20/CMxlwMk3MY
 +K+bpqMNMYw==
X-Gm-Gg: Acq92OHXcMrn28cLWJJmjSZgVF21MFgACqfyVIMDD1fByCAr5wSlqw8iOeNgDcFjC9y
 Ck9GiSdqY6eU0uGjfFV/iapKADoT4r+dCr7YhkNxrX4AHesbY1cK71Mqy8eQ5M0FxrT8jJasF7c
 XiGwelT9NpQfh2guXX/XNNyw3hYtLCClhVSQnFnVa5tbnziol3P0fHwbZIjN1J3BhDtnPdTZlwE
 J5d3JPIkeDt0kDMbJqCdr6/iPSSqQc+oT3XlBQ4CgUX3TycKiTDlgyNrSaM3EcHnvxgNOMHykT7
 k8FGXvk5UYEfhWDbeqyXLcn3yjVRFzpglCG/F8AG4xYyFwud2zSHR6DYA7pDwR5kb4836STGftl
 IktXERKWHEbJYl10qEz44il+U123bt+MsQ7DblOpJfJrntjsHm6KWHcdTsgsAixY8PBt3AAWl2N
 KP9uinND/7tgCVTCmL573Ra6BsrTnXgFLHCeTRgOhdteFxaJxEXRQmm3yf2h1zF4/Vpw==
X-Received: by 2002:a05:600c:568a:b0:490:3b84:c106 with SMTP id
 5b1f17b1804b1-4909c0b6d5bmr216275e9.26.1779999895778; 
 Thu, 28 May 2026 13:24:55 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49092657a1esm55798975e9.7.2026.05.28.13.24.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 13:24:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/22] mailmap: Update email addresses for Daniel Henrique
 Barboza
Date: Thu, 28 May 2026 22:22:46 +0200
Message-ID: <20260528202253.49122-17-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528202253.49122-1-philmd@linaro.org>
References: <20260528202253.49122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-Id: <20260528083814.32795-1-philmd@linaro.org>
---
 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.mailmap b/.mailmap
index 273661c758e..a35de7cfbd4 100644
--- a/.mailmap
+++ b/.mailmap
@@ -82,6 +82,9 @@ Brian Cain <brian.cain@oss.qualcomm.com> <bcain@quicinc.com>
 Brian Cain <brian.cain@oss.qualcomm.com> <quic_bcain@quicinc.com>
 Christian Borntraeger <borntraeger@linux.ibm.com> <borntraeger@de.ibm.com>
 Damien Hedde <damien.hedde@dahe.fr> <damien.hedde@greensocs.com>
+Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com> <dbarboza@ventanamicro.com>
+Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com> <danielhb413@gmail.com>
+Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com> <danielhb@linux.vnet.ibm.com>
 David Hildenbrand <david@kernel.org> <david@redhat.com>
 Filip Bozuta <filip.bozuta@syrmia.com> <filip.bozuta@rt-rk.com.com>
 Frederic Konrad <konrad.frederic@yahoo.fr> <fred.konrad@greensocs.com>
-- 
2.53.0


