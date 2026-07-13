Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DD9C44508
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIed-0000O9-OW; Mon, 13 Jul 2026 11:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeK-0008Sl-Qg
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:52 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeG-00018X-6n
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:51 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so24854865e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956765; x=1784561565; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8AsRaUA2T/PCVXg/2t2wX1Kskm449Q9GVMk5QIScFjU=;
 b=tmzkYgjYQfwmh/0mWbDQ7J1rDZzQEj8N7FtkLh6q2aGKSbr7lnnu6U3bjWux6L9FSe
 HzwVZbVTnwnbyryRL4Vn9jr20cAWYXbFQYqCXk7rCjTphdVOMO47MQJ2AFE+pmMVmCpo
 tchJqoUp7Sx+lFFsJ8qHVxSbJOFrLl92XuSH8WxnVXMy/CcVhT/JSpVPVJJGd6Hq/WQV
 praWAAAkYuP0tlAao+z4sVBk8Lp8s4YtJBZyuH4b4FecBbJLHHRtwQr7kCq4bjMrOmZ6
 KD5iDfevgb1Kv1nRr+3YSe2IJn6CUhVthOm6HiYGh83oSxCFcOGRD3ICCCw08eRMGyRO
 eVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956765; x=1784561565;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8AsRaUA2T/PCVXg/2t2wX1Kskm449Q9GVMk5QIScFjU=;
 b=YTOG6SypEy7qVd1HV5hXAiVdu4XnEQuQjvxP7IKbFaV9y3or2V6aWhYX8Y/z5f2MuH
 lv8XgIPrUL8KdD/TIn0bLUL18zzxBHJawObnL0phjm0p87+aoxR4FF7/4IZ6i8gZJZ6a
 +fnFaau8vS5CYw0Vey7LItmn2urufodDES3J7qb94GoeK8T3D4S3/7i+Z7WLC4fuxzz4
 qGS3ivepqdvWm3/3axYwX3fIIGDtQ3OZyP/K7H8QIhK4nvxwUV8q3S8uRtARxJNC/kmX
 6AL12NbxNSVazXirVytlciwLy8gGwf4z5cq80hmjsZvrw9oGD8fQRKJBDkfAdAF5Y5Jg
 ZdOg==
X-Gm-Message-State: AOJu0Yyu4Ig9YALl/1IiRqNN6SM7pICcQN3KRZwnfpVn7IrQfrjOlOwA
 xyzFOhNTDWPV6kRy38Loaua8MuA/BaKFYxXXjTuaDgMjs8AIAgAQRsfAd1fLKHL0mPAA4qiewsW
 dvhCx9eMuhA==
X-Gm-Gg: AfdE7cnlA3Gu3ikSUMOK0hSvgWHn/oVylinF1Vxd6wWX5nBuMxdzPaqPhkFGYFk2bDf
 mdGa308/RI+m7JzdTm74y7Zf6siYj1TNkXqA3NBxjgXYzvVug0sJuOcKGUBCdGWD70XXn5TbCob
 jqKoisgQ2XA9C5oeQMLYIQ2NcHims6I1+C+ZE5YC3HsaWgewlJ7GTzGxLcgbALrT21t2F4F2ZSl
 O+7XaLqhlSEx/xVciLMJl3yOOl8LXs2RbkQA6iw0K8rIY3HtFDLqY5N+Y/wRADZQL7s9Y4eWQw1
 1Q/yupdccNIo3QFFMkBS77EagIYYvEMrXxcbvy5jUQTo2esq36h/DTUJ9772UcTSLtXY67P3cXo
 DIuJXH4jIk8tu8AXmTLYPkHi6z2/uLBIRKx43+Hl1MzXq8+6TLJWKagH81C7DMtDcSWm52zx5pT
 3+ItD9LnnemtNBnp+zN2JdveH248DXaVQlUQe8+BA8duvm1bmZG4kGFqDW4ROMEzInqVHghJTDT
 gDsivz8Pf9NNEheL7z+Ow==
X-Received: by 2002:a05:600c:3e1b:b0:493:e890:9e0b with SMTP id
 5b1f17b1804b1-493f883157bmr102458485e9.26.1783956765279; 
 Mon, 13 Jul 2026 08:32:45 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/26] docs/system: document FEAT_Secure
Date: Mon, 13 Jul 2026 16:32:18 +0100
Message-ID: <20260713153233.3391818-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

We have had support for Secure state ever since the initial TrustZone
support.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260708145841.3032079-4-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index d19b6c04429..b751646e10e 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -162,6 +162,7 @@ the following architecture extensions:
 - FEAT_S2FWB (Stage 2 forced Write-Back)
 - FEAT_SB (Speculation Barrier)
 - FEAT_SCTLR2 (Extension to SCTLR_ELx)
+- FEAT_Secure (Support for Secure state)
 - FEAT_SEL2 (Secure EL2)
 - FEAT_SHA1 (SHA1 instructions)
 - FEAT_SHA256 (SHA256 instructions)
-- 
2.43.0


