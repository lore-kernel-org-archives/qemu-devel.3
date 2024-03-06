Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A088C54E58
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhkX9-00063i-25; Wed, 06 Mar 2024 01:13:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkWV-00057s-0Y
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:13:03 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkWT-0006Hp-Ho
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:13:02 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dcce5e84bcso52583755ad.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 22:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709705579; x=1710310379;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ahxRZ3SD7lLMx3muKeGeJx9aSeKYvKbViQJskOgE7S0=;
 b=cxr/aPYzdIXinC2AZHHHUP6bGgxFnX65waBbeJuWsfjfoTwrrkTtIOYxtZlFxGkyzk
 Uzzh+Ajuc6iC0kmex10u9qFF9daN9iKxmZNPKLy0sq8V7zlQnF2ejUvkG874O/1NvmmR
 ZMOGrLhRWncJpd+nF5hT/qloLM/E8gDgpwwYPIRFpLinSL4grfexBo7lyP0Q7cxkbznC
 Fwx4C670PytF16GAUMkATpAuMNyN1RHOWQ2kfEqodhaBy9gDPM+jGtdmpHCzREbh34q+
 sCRzn7hFE8VPnMjF11pRbexaYMcvuKKoURDeQMVCvsG+3JjGkDHhsM/0jGRCxBSplnqG
 X0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709705579; x=1710310379;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahxRZ3SD7lLMx3muKeGeJx9aSeKYvKbViQJskOgE7S0=;
 b=fcxcekxfxu9E73Pafj6NrM4e5oCf0sxsW2UtHLkx1+5EK3gz80JENNvZ3Gn/a2r4ec
 lGQhe/n135fHwxIb8aP+inwdXIkmqajO9xPFRmVZ8VpGyIi8U5XQet+/X7/cbalNOCOb
 dXbJuDJVu+XJsp8bTum+KqXa4xCUPHSLhpl07i7VhQY+zRrQs8Nk6epbuJ1KpzHPXqCk
 rZYko4UqW4TOvSFEmBk+SoXsXmAJep2GqSxoWldFPSEU1/p/VdY2ByikE11WTsDdll7N
 n9Bpl6IKyY06xQrtMvVdOSYuUg0PyEbolfHDaGTYdJFrdbaiOFDBFDrD40pLGn2Xm5Hi
 zzhQ==
X-Gm-Message-State: AOJu0YzTFo3lk2UvIMemPnWmbYXnKEmjBexeYh+br6/LqibmhBzai8e5
 5aBX3vqh9o04T9MG6Xz/unocWP9b4mP1SK8Ggp9sOcSJAwVSCQvT0w4uMkEIoJE7pv+SFgEgrtr
 r
X-Google-Smtp-Source: AGHT+IHUdOqjMEk4lzZrCVvQ7wruyQPMJvSNJyVFBjpPqbE2BcGa+kfyv1Z2xgmaGl2DgCzvPOBdCg==
X-Received: by 2002:a17:903:1cc:b0:1dc:b48f:3c8d with SMTP id
 e12-20020a17090301cc00b001dcb48f3c8dmr4562684plh.52.1709705579610; 
 Tue, 05 Mar 2024 22:12:59 -0800 (PST)
Received: from localhost ([157.82.206.27]) by smtp.gmail.com with UTF8SMTPSA id
 o12-20020a170902bccc00b001dc486f0cbesm11569927pls.222.2024.03.05.22.12.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 22:12:59 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 06 Mar 2024 15:12:21 +0900
Subject: [PATCH v3 15/19] MAINTAINERS: Add Akihiko Odaki as a elf2dmp reviewer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-elf2dmp-v3-15-d74e6c3da49c@daynix.com>
References: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
In-Reply-To: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 65dfdc9677e4..d25403f3709b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3583,6 +3583,7 @@ F: util/iova-tree.c
 
 elf2dmp
 M: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
+R: Akihiko Odaki <akihiko.odaki@daynix.com>
 S: Maintained
 F: contrib/elf2dmp/
 

-- 
2.44.0


