Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B7ACF34BC
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 18:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swQqv-0007Xs-4v; Thu, 03 Oct 2024 14:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1swQqs-0007XB-Jk
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:47:03 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1swQqr-0000um-2I
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:47:02 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53959a88668so1698621e87.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 11:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727981219; x=1728586019; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zxNVqecRvkYD7Yjb7qO/AnPWEEM5Fp2WZf3IfrDzV2U=;
 b=fpxQ4nRvVLS1qONq1EQDeljWLJzBsKKWRH7zQbQzkxVqWiZ86gQJOEOIemWiFL/f5X
 MDJyw4djsTNishD9rv3vDOIDJdh2CuAiN07bow5i5njQthl+V0WHUgQ5ULCe+tk4gFKl
 N7F0kAzRyz9t01uvZl01h7gIRGDfsPMTf9PiP88DmXkju36jFrp+IIEP0PQ5l6H/Xqat
 2YnpUPIFV6ahLKm9G2Sd1fWKAP5hnTCBzgByq9m4eyQ6tHQ2dtSgKi8EpcHIlzFLl/V6
 eleVAXsPAK9sIS8k+AbfRKJe+fp1wzhry8KbFGZsJoQ6RSRjmlp53AKjcDtsSMrOd5D8
 YEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727981219; x=1728586019;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zxNVqecRvkYD7Yjb7qO/AnPWEEM5Fp2WZf3IfrDzV2U=;
 b=a+i9qiShIxdTr+8xJqVLAy7c7HoP1cNQ3X+8LeVoPWoOYM2aDfoCpO28KIiv6iLLtK
 Pb/ZlSA7SA/e/BCnvRQUYlKcG3pkP33ugiBDUfRRMIw2BZatTW1pgF+PH04xNqydB/fk
 l6zTyzLUNPDXOEcJk9GMR75ybcEuOogAjH+sBZu1vrdUP928smq1FEzvtKJ7AAC7GILs
 DBU+SCnFD12ZW3x6TFH1PE+dPtyGacOKjzrJENTboOUldGjv0EGyeBz/Y5E5OKH2g+NS
 YkqkfpVdD5UV87UbHzifpvvz4Hxaho4Iu/pxKMp/17v1cA0t36FidF3xhZIxxsb/U3lQ
 UH+w==
X-Gm-Message-State: AOJu0YwSR9oxWqeBNYSiquDW7Cw7EOrjZ7htzHA2BN1ZbEhRb+kZQ9Zd
 htfDoD+oja5FNypyc5lErJX4RfE1in2OErEkFO+gKKx469/flZD7
X-Google-Smtp-Source: AGHT+IEDANPzn9Tbpg9Me56OPCcgs/2usC+PJjRqvZAj8AZFAClQd1shccGdZN2d1m+U1EFvic1mTg==
X-Received: by 2002:a05:6512:1591:b0:534:543e:1895 with SMTP id
 2adb3069b0e04-539ab9e17aamr178407e87.39.1727981218692; 
 Thu, 03 Oct 2024 11:46:58 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539a82a3890sm235298e87.216.2024.10.03.11.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 11:46:57 -0700 (PDT)
Date: Thu, 3 Oct 2024 19:52:06 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org,
 paul@xen.org, edgar.iglesias@amd.com, xen-devel@lists.xenproject.org
Subject: Re: [PULL v1 0/5] Xen Queue
Message-ID: <Zv7ZxuDujOtgrs22@zapote>
References: <20241003143103.1476805-1-edgar.iglesias@gmail.com>
 <CAFEAcA9tST+-mZTcdBtwVOeVmxnBDrO=VJBMj=C0iFw5GAojLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9tST+-mZTcdBtwVOeVmxnBDrO=VJBMj=C0iFw5GAojLw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Oct 03, 2024 at 06:07:00PM +0100, Peter Maydell wrote:
> On Thu, 3 Oct 2024 at 15:31, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> >
> > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> >
> > The following changes since commit 423be09ab9492735924e73a2d36069784441ebc6:
> >
> >   Merge tag 'warn-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2024-10-03 10:32:54 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/edgar.iglesias/qemu.git tags/edgar/xen-queue-2024-10-03.for-upstream
> >
> > for you to fetch changes up to 507118c2a066b70e8069702c120461ad8c98ccd5:
> >
> >   hw/arm: xenpvh: Enable PCI for ARM PVH (2024-10-03 15:24:42 +0200)
> >
> > ----------------------------------------------------------------
> > Edgars Xen Queue.
> >
> > ----------------------------------------------------------------
> > Dr. David Alan Gilbert (1):
> >       hw/xen: Remove deadcode
> >
> > Edgar E. Iglesias (4):
> >       hw/xen: Expose handle_bufioreq in xen_register_ioreq
> >       hw/xen: xenpvh: Disable buffered IOREQs for ARM
> >       hw/xen: xenpvh: Add pci-intx-irq-base property
> >       hw/arm: xenpvh: Enable PCI for ARM PVH
> 
> Hi; this failed the tsan-build CI job:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/7986783747
> 
> ../hw/xen/xen-hvm-common.c:711:48: error: variable 'ioreq_pfn' is
> uninitialized when used here [-Werror,-Wuninitialized]
> trace_xen_map_ioreq_server_shared_page(ioreq_pfn);
>                                        ^~~~~~~~~
> ../hw/xen/xen-hvm-common.c:667:24: note: initialize the variable
> 'ioreq_pfn' to silence this warning
> xen_pfn_t ioreq_pfn;
>                    ^
>                    = 0
>

Thanks Peter,

I had moved that trace call but forgot to remove the original line.
Will send a v2 PR.

Cheers,
Edgar

