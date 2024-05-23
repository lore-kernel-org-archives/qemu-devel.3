Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6F9C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 07:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA2nQ-0003Il-QR; Thu, 23 May 2024 03:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sA2nO-0003FE-QN
 for qemu-devel@nongnu.org; Thu, 23 May 2024 03:23:26 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sA2nN-0007uM-Bk
 for qemu-devel@nongnu.org; Thu, 23 May 2024 03:23:26 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3504f34a086so4752500f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 00:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716449003; x=1717053803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3FGKLdbpUt4Mrb46Js/x7JG5VPr8Qb7HNxg3+Jp4sy0=;
 b=FCfg3jHEudBi/LXktrVYPMNnENZC+S8Paa6/S1k1rndxcfDgMMV2+lxA2E7VrXCisr
 xx7/CaZFKJJTZdaI476wvrlbYhnCVP8zLpJqHvT7uFK2cYjrPXF6ehazWXoxmldaEKjn
 /oOvDaUC1H6aBiBZ8dHl+kyhsimKBHRvXrj8M4CG7MqS4fLmJ2SK0H2rD48p36z3o7Xm
 fQIEt6JDpuLRFI7oqg2TF3bY/XcGo88mY5O4KVaSxvYbzCyQEk3bZPb+qQGfU0dM/RYx
 l33fZMYylM4hzUM9AbMl9LX8yZnt2gnIMaia78vizm8mCyC2pgXTpdLrGGaNY1Aq5R5v
 neuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716449003; x=1717053803;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3FGKLdbpUt4Mrb46Js/x7JG5VPr8Qb7HNxg3+Jp4sy0=;
 b=EQXnZQiKlEux+jV8ZayCfIjvg802++74D7yaynt+IxlDwr0oz/yfSckx6vArM1Enlh
 S5uK6r88lwSC1jHQ5jGe6K0aOWDXQwQRLU0637JFOiuXz6RzSYqjIHmNhA4VFxZ2o1w9
 9PNdqQv4mO2x4KQpCaX8WUrGV6l7kibGB400PKelud1CdHrMcgmgVRqaEoqz8wtZILKL
 TyqAk+FbxQme9KFb+0QH1XTqB5BoaTs3s38Px60RoahIlb9ye0iQ73exkrTB2ozrm3Ko
 wo/uCBQdabAEP4zlcAgrQyeDDFMS4BQP8MnxD1djHyHDdfd/L+n2+OXKcVVtaC0kohr3
 qcTg==
X-Gm-Message-State: AOJu0Yyyq5WmAoeIkzYRzcmhSzw413qSbKsjH6x+gytPlXxpaIF6YSuc
 27pSLz88HlL1B34AjfFA0ohVH8Esdt6eACqxlbN7R1yGIqhQqw+aCxTSvl/Wl//WoMaVr8UOvMj
 E
X-Google-Smtp-Source: AGHT+IGopUWqNNu/3/S2p/eDAVTpCN+RXYSS7MmeBdMEd3XFtFkBUP8yP9N/VGtgXQg/RYpe0kRcxQ==
X-Received: by 2002:a5d:6908:0:b0:34c:81e0:bce5 with SMTP id
 ffacd0b85a97d-354d8dac945mr3031362f8f.64.1716449003140; 
 Thu, 23 May 2024 00:23:23 -0700 (PDT)
Received: from meli-email.org (adsl-73.37.6.3.tellas.gr. [37.6.3.73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b895887sm35863611f8f.40.2024.05.23.00.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 00:23:22 -0700 (PDT)
Date: Thu, 23 May 2024 10:22:56 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 3/4] MAINTAINERS: drop virtio-gpu maintainership
User-Agent: meli 0.8.5
References: <20240516120344.531521-1-kraxel@redhat.com>
 <20240516120344.531521-4-kraxel@redhat.com>
In-Reply-To: <20240516120344.531521-4-kraxel@redhat.com>
Message-ID: <dxgix.gs9o4m8aj4o@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x432.google.com
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

On Thu, 16 May 2024 15:03, Gerd Hoffmann <kraxel@redhat.com> wrote:
>Remove myself from virtio-gpu entries.
>Flip status to "Orphan" for entries which have nobody else listed.
>
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> MAINTAINERS | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index d81376f84746..4d9f4fd09823 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -2572,8 +2572,7 @@ F: hw/display/ramfb*.c
> F: include/hw/display/ramfb.h
> 
> virtio-gpu
>-M: Gerd Hoffmann <kraxel@redhat.com>
>-S: Odd Fixes
>+S: Orphan
> F: hw/display/virtio-gpu*
> F: hw/display/virtio-vga.*
> F: include/hw/virtio/virtio-gpu.h
>@@ -2595,7 +2594,6 @@ F: include/hw/virtio/virtio-blk-common.h
> 
> vhost-user-gpu
> M: Marc-André Lureau <marcandre.lureau@redhat.com>
>-R: Gerd Hoffmann <kraxel@redhat.com>
> S: Maintained
> F: docs/interop/vhost-user-gpu.rst
> F: contrib/vhost-user-gpu
>-- 
>2.45.0
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

