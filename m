Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67C7CF34B0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 17:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swPIU-0000rB-1f; Thu, 03 Oct 2024 13:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swPIO-0000qn-5w
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 13:07:20 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swPIL-0004ef-V7
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 13:07:19 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2fac787f39fso14742151fa.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 10:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727975232; x=1728580032; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ypgCN7X3Tp1ClBP+wNOOozvav5VEYC8sq6Nl8zmhF9Y=;
 b=SL/rGlT2Z4FwkZ/QRbSaTz321XV0PPL7jSVSWeAVWWLNtg1IK8AXVjKUDF2QTK4Zjr
 EMlfYEfZP88p0FiTKSCeUVd7pI71fVd5yuBSPOadltAud4Pg3XHhiM7zsMpiiZ7AYgzS
 Vsv1y7M5iuQK98/6bJKOs4TOem4ankWL1RhTXIp0X22IEjChVItXfKPjsnzNHLR4Owx4
 ks5KdQ+pix/Qo1ehzvdGUv5v1M6M/jsuMnEe9MddUFnkG8yBVmMsgIU1ptsMLPijQy9q
 j6yxGJZLw4UFgxgYtzDgPsrf25rFwI9KdQ8aAPWMMntgAZe1aIFdCdSq+F1mgqXWDeYc
 n/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727975232; x=1728580032;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ypgCN7X3Tp1ClBP+wNOOozvav5VEYC8sq6Nl8zmhF9Y=;
 b=MYj4o1AaomDHfL5+Kz/VVwvGh1djeooj/IbIgCEf0TDAUSPBZywjfINqmRJRrbygf5
 DKfo412UyXYXh7FdGR6FgO3MTWy9fbvpJLeojBZDa/rXmEVs5+xFbKOSX5IQmYwyVagr
 7AA7ljPiZJdAXtbPrayfl6u0GlwiMMgtWlhCQwZpEH0JzzTbMhNymJOY9sHg3CMIo4/T
 xBU2M0+oTs7EwLQBxL78hiqsSvezj4slO6D58HQ3BkxJwAgU1M5R2RJMQAmHquicHUj8
 ivGdFYZMfZvFI2Z11NZQ2yHTnAX+MmJPiPJF0o0v++6s/tNlqGYmmeLr54wY1VpIrnJu
 tYxw==
X-Gm-Message-State: AOJu0YwKCNKp9bVOcWKnbSa3SbSX/FiJYeOmdUEPWx4elIDB1Unb+pQa
 te8nZszmxfl0kDx5mbpFbrIu6fdsltufTKRdfvGWage+yI5hRr7AYRO1Ro94jau3WpcoUOl5zuN
 btBc8yzn4zTcZCaoGaA0kNbSkQyb4iSp5k4LKlw==
X-Google-Smtp-Source: AGHT+IEjaRr1MVAuuZhPyS6nHjR7OmrTiZ3hOaG5K16qWrzZDv7Ce52sQ7+eSCIr3FBf8S0Ed2Ky22MwxS6vYEwm5ug=
X-Received: by 2002:a2e:a983:0:b0:2f4:3de7:ac4c with SMTP id
 38308e7fff4ca-2fae1023128mr47777331fa.8.1727975232264; Thu, 03 Oct 2024
 10:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241003143103.1476805-1-edgar.iglesias@gmail.com>
In-Reply-To: <20241003143103.1476805-1-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Oct 2024 18:07:00 +0100
Message-ID: <CAFEAcA9tST+-mZTcdBtwVOeVmxnBDrO=VJBMj=C0iFw5GAojLw@mail.gmail.com>
Subject: Re: [PULL v1 0/5] Xen Queue
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, edgar.iglesias@amd.com, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
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

On Thu, 3 Oct 2024 at 15:31, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
>
> The following changes since commit 423be09ab9492735924e73a2d36069784441ebc6:
>
>   Merge tag 'warn-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2024-10-03 10:32:54 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/edgar.iglesias/qemu.git tags/edgar/xen-queue-2024-10-03.for-upstream
>
> for you to fetch changes up to 507118c2a066b70e8069702c120461ad8c98ccd5:
>
>   hw/arm: xenpvh: Enable PCI for ARM PVH (2024-10-03 15:24:42 +0200)
>
> ----------------------------------------------------------------
> Edgars Xen Queue.
>
> ----------------------------------------------------------------
> Dr. David Alan Gilbert (1):
>       hw/xen: Remove deadcode
>
> Edgar E. Iglesias (4):
>       hw/xen: Expose handle_bufioreq in xen_register_ioreq
>       hw/xen: xenpvh: Disable buffered IOREQs for ARM
>       hw/xen: xenpvh: Add pci-intx-irq-base property
>       hw/arm: xenpvh: Enable PCI for ARM PVH

Hi; this failed the tsan-build CI job:

https://gitlab.com/qemu-project/qemu/-/jobs/7986783747

../hw/xen/xen-hvm-common.c:711:48: error: variable 'ioreq_pfn' is
uninitialized when used here [-Werror,-Wuninitialized]
trace_xen_map_ioreq_server_shared_page(ioreq_pfn);
                                       ^~~~~~~~~
../hw/xen/xen-hvm-common.c:667:24: note: initialize the variable
'ioreq_pfn' to silence this warning
xen_pfn_t ioreq_pfn;
                   ^
                   = 0


thanks
-- PMM

