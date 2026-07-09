Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D50AC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whjgm-0007kp-Kl; Thu, 09 Jul 2026 04:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whjgj-0007jF-Gn
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:00:53 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whjgf-00089U-1T
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:00:52 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47122683cf3so947107f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 01:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783584047; x=1784188847; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QkTr46NKSnY8Z/palWL7xVoYf+zkSnoEWMuDFsqMd10=;
 b=Nat21YKawk/auZOwW125SX1K75eMWg2f7jQ/ycL7jUeGvvsZHV3rDkTde1JfrU6E8A
 357UOGmZkNWZccVxMWKwuYF0ew8FEUOSQDf+uuI/6MLBY7lXd9MTyQrcsiyEOq45PUFU
 44aLVdl0dyS7Qw9KyBdmO14l6af2r91H8e8e2SzY7jLlBxYiF/2hcC9kXNBcFzgDRVd0
 vbppA8h6JgmJQosLNP8fU3BsZLuz9joIAVouUvei8N/WJuPl+x36nmSN0VXC1C0Ukj7j
 D9KFICWcVK8RmavKsCGjDGhT/+beBiIY+kFYoOfMR+RrJSsiOe/cV1Z95e/4m6DOWWrQ
 3VkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783584047; x=1784188847;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QkTr46NKSnY8Z/palWL7xVoYf+zkSnoEWMuDFsqMd10=;
 b=NHIWJQsuQ+iBi4ujRiubTZ7hHxOo8CXrq0vSuMSNbkAVjC0sKN+27RgKDqSFlhHe67
 o06ob3O9g0KSYZvE/ovuqPVeOo83bogL3s2dXCm3MV8B0HLZTQJDdYnZzou4IAs7mgqs
 OZZxv4OPoOd86rABYjV4hcTRDvZkW0MLJ9RdkVk2iGi+dKNi3FfpM++AXLNnSKrGBxDy
 HmNQXjX2NuOb8aSCEfmsaS9IBiyDmSO/omEgQsq2q+J/mylLp78LktlNrz19w0Ej0VNx
 3GS1aDJ09lvvCEohE/rqqGKRTcxGlvTstC1yxq17f64TEJmHdYQvTrJcCFuXzhoHiWGJ
 HoGA==
X-Gm-Message-State: AOJu0YwAPh8f+i4df4EgIkMTSTnmZb827K3y1U64wJSqEvtjBGOjop6s
 tcRItJ9VewDMfH3si9MdyT077ODAFGyrVGBXVn10pooHTltYKxOI1O7lJjOzudWStVY=
X-Gm-Gg: AfdE7cl7u90GhEdLzAdcVSBHnoZcVhbF2A/2Q1vFPFzYFCFDRK8nZkPKU7I47kvsy+R
 gB9AoKfzofmQ0wOEah5zwGxVTqdcJzKqSyXFhm64TtEeavOsd1GN0tlDnhPW2uMRJDqQ+MSeqSh
 6bg4E9HmrtQwv6xBfOI8h7WihSIYB+NKJ1sYs4L765wQJgdlD+NvJA0GgGlXEixJYku/HjCnQA1
 jN1B9+1wDCq7m5UB8ISf5rxBUv8O5aVZZjRqYRad8nyQA710h/BmfoeR8nq54J2+zmgQ+qA10/p
 gdZgSQr3G+1INx2opAwEV0lnIBrgzoLp594g6B6rmv0Nmvv9KexYs7B2aQrWg+M8GkFvvhr+59o
 Ly+Wmy41QzeC2wdzw0SvkUfN/u5WUqGJwyU+Y68DgrXo+JXa+3msvLL1PAEEGJIuuIJveu8n7GQ
 k99RFP1J++3w15
X-Received: by 2002:a05:6000:387:b0:46f:558:a42c with SMTP id
 ffacd0b85a97d-47df071e526mr5891622f8f.4.1783584046746; 
 Thu, 09 Jul 2026 01:00:46 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d91bsm54012173f8f.4.2026.07.09.01.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 01:00:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E6DB160157;
 Thu, 09 Jul 2026 09:00:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 8/9] contrib/gitdm: Update Qualcomm entries
Date: Thu,  9 Jul 2026 09:00:38 +0100
Message-ID: <20260709080040.4157324-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709080040.4157324-1-alex.bennee@linaro.org>
References: <20260709080040.4157324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Add an entry for Qualcomm Technologies, Inc.,
include previous quicinc.com contributions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260707153003.58914-1-philmd@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/gitdm/domain-map | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index c07dffc51bd..aef20c4949c 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -40,7 +40,8 @@ nuviainc.com    NUVIA
 nvidia.com      NVIDIA
 oracle.com      Oracle
 proxmox.com     Proxmox
-quicinc.com     Qualcomm Innovation Center
+oss.qualcomm.com Qualcomm Technologies, Inc.
+quicinc.com     Qualcomm Technologies, Inc.
 redhat.com      Red Hat
 rev.ng          rev.ng Labs
 rivosinc.com    Rivos Inc
-- 
2.47.3


