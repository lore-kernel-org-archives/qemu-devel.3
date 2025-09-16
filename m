Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9CECAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya5k-0004VJ-NG; Tue, 16 Sep 2025 14:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4x-0003Aq-Ba
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:59 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4s-0001eG-3a
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:59 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3e8ea11a325so4025786f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758046010; x=1758650810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lxKnBCOImWIkwJQbGUGHvGVkNj52S0Z0jeayxRUvfM8=;
 b=GW1/WWSJqjBZoIPea/2DmYHO55vlBVtCnwcg+bA/8zXCAlGRQjnfhs9ZSt/2DjNOis
 ICdtBhXN1C7arU/t3m+FMhr250C3GIFIKerO/HJi4lsL5L8f//yvtdGjLlgR7x1e8vGo
 QHnM8bjmCBBInxy/mxk92vHZroLd+dIzSA5oJsxO0EIZibfviJ9EFo9RkZJJpEjy3l7e
 +2CF805iJKyBhiPtHOvdd13knVQZ0fKK0O9ImtC5JWRw1zQYUpi4aRRKPJEER+vr21aa
 S8oPpfZBmwMmMhhe2182Q/CrW8Z53FgkvFAuYoyLGp568/0Y6M0OV+9HbcD+QhRtP7pA
 sYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758046010; x=1758650810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lxKnBCOImWIkwJQbGUGHvGVkNj52S0Z0jeayxRUvfM8=;
 b=BhNR99R6f8QtdC5cG0Ks0ps9TrTIg0699VFm6tYl05eCOBH+lTZzctTkUCePNXHVda
 vMNHKLcrhj0y+SUcim4QchKOwhpiCqRmw0009CgXo/GOe6lNpchOsEsOKlNMjO2wUjmY
 P4srW3Rg/8DiE2yFOYqvwz+/XpBUWgJNA0QD71OKSmu9RxyPy7F0Amj1sE9Fq2cy9qPB
 JHcoSJwxcvGPliW/amc2/iJbxOTMA8vwcnwb5QkKMqchejNstqsuJff9YkzN3tpXzzWP
 FFeArDfyYbrXBn7YH+Hfm1VAvhq6cJQAGptTvAms/I4XWanxZF4iotIQyplgdLm5rPhS
 nfeg==
X-Gm-Message-State: AOJu0YwTH5gxqF27P4Y82qt8WcQQutoITGHPqhKI9slHo5iZBV7e1kCM
 h0WY5Dp1tpJQmiKEgT6AqYh6Y5FWR9qh7/byo1XYDGzCw1eW7zv/C1/TGW4bBDB6qVfQ8agbRnN
 a1lcT
X-Gm-Gg: ASbGncvhlKbbkZ24LgvrpmkQ/WZw4N9U0r/M4AmK7BE7lWruc78OqKkS/Pgwjqi1CVE
 0QKFFft3Vr176J4BuCTjWJzBHaoeLcZlqBjzTiu0zVxyS8Rbv3tTf/CGXzkiunHidkXS65aApJz
 k6RW47Zvec/bOQhkalOym9kFYP44ogzawlvqCNkN2oyNM4Ye/OyKJ2reR/+G7Tq1AlZOU03Nlv2
 4gY7W5XwWWSIBOcVhtVltuhTLISME4xYHk9VqVhy+WklDugCyg0QxRxG/IQ0nyUUBRklgXfT8IE
 rVgL1HoKaavNqsBLf7SDfa0ut5fvVK57OBMHOR0xhurDn7OESVDrnDcIIDcXKgrdZlTU75oE1ul
 HTe8iCZGlUeYqiexHNRTxXcI9+RdU
X-Google-Smtp-Source: AGHT+IHHs5iKR/6eQ4r5PhZvRxl/MonntUZZ4/DBZ1pdfnj8W/qAZAv0qR3SNv0TGnQAFqkTl6Z7Og==
X-Received: by 2002:a5d:5d05:0:b0:3e2:c41c:bfe3 with SMTP id
 ffacd0b85a97d-3e7659d3a79mr16790645f8f.38.1758046009888; 
 Tue, 16 Sep 2025 11:06:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/36] qemu-options.hx: Document the arm-smmuv3 device
Date: Tue, 16 Sep 2025 19:06:06 +0100
Message-ID: <20250916180611.1481266-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Now that arm,virt can have user-creatable smmuv3 devices, document it.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Donald Dutile <ddutile@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Message-id: 20250829082543.7680-9-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qemu-options.hx | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index aa44b0e34ae..075f4be2e3e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1231,6 +1231,13 @@ SRST
     ``aw-bits=val`` (val between 32 and 64, default depends on machine)
         This decides the address width of the IOVA address space.
 
+``-device arm-smmuv3,primary-bus=id``
+    This is only supported by ``-machine virt`` (ARM).
+
+    ``primary-bus=id``
+        Accepts either the default root complex (pcie.0) or a
+        pxb-pcie based root complex.
+
 ERST
 
 DEF("name", HAS_ARG, QEMU_OPTION_name,
-- 
2.43.0


