Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99CBCF884E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swkqh-0008By-W8; Fri, 04 Oct 2024 12:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swkqX-00088Y-PI
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:08:03 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swkqW-0002d1-5R
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:08:01 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2facf481587so21919541fa.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728058078; x=1728662878; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wYjyGMnIxNup7gKRsx4s2998ILa01TuDEJqD/qsxzYE=;
 b=kRRXKgEaJMV0NsJmEcDbxsWf3bhpUnCUbOYW5bLQHmD7MCC1YD2xcdLC62jIunQQWH
 JeVAT6iSbNOo8nw+S7Gvmn5dJkuWRJ+PRnNlGKRMaSoeeef3rdZsDszTbN4jcseFqK9e
 5vnLq/4/8Z08gOccaee1gIbtXvEWMC3wvw0joCRnI+hjo0CANt5GlE+kzUU7Kat1xnw7
 WFOSPVBZb49cCz1lx+jaqSGXXyRmpIUZILg/vOk3hLK3XU68aAG3dvXr0rvo0Paw3hW6
 fLxcbAX4lHCnXNKJR8sJUM+fKCyN90UoO8cnzkUhU3luBFhixGP4g3OBigCf0UN4aPFI
 y5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728058078; x=1728662878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wYjyGMnIxNup7gKRsx4s2998ILa01TuDEJqD/qsxzYE=;
 b=KvMx3i2SOdAYx4NIT3YwRaRTeQjJfY84UIdjy/ljB2K1aRQSxuWAnq+zuF5wGgTgpU
 eqElWUJUNbUQae92zyNsHUdTPlom2no+fkgECEYik/B+4DsZTGknZnuPIGN8s+yLYM0O
 NKCm//rFaH84CiKgdKPo6jRn6rWPE0Ljc5zH/eFFn10P5YMQQ75XmL/F4u0d3Vbfuh6S
 C3MagjzKjozbveB+7EOEX6U7+6ZbtyZtkwfyFThjiSBkHG3R6JBOBAu8oqyzc6UVm7RR
 lqcFZmR9sKHW/T3Bt5V/r6hwRIkKt6kPoHdL1GRO7AV3MgFhCwevpRYTre56Z7QBJ7cc
 3Tbw==
X-Gm-Message-State: AOJu0Yz/yA0OfKI3t3I7lYhAxklxfofxu0a2z7O+rWG2fMtZAO5BsY7X
 L8j3qpjuZuUkV9x2YWMPBKj5hKMsOlEUeK5tyzaPgTqF3rTO8ctQCw8I+IvWVuiRt3JaK2J7v8e
 2RSSbYpM2R/Vqbf53j42yNljSdJDaDR8u9ALnTA==
X-Google-Smtp-Source: AGHT+IFQSSW1Qqbr+FutV4pww9x20cyMzPY/mKFV/3n2pOfi9CeNC1DV7dZFCXWo5Sf/N16k3K/dc3naDSjqLmf9IPE=
X-Received: by 2002:a2e:9e18:0:b0:2f3:f7cf:2f01 with SMTP id
 38308e7fff4ca-2faf3d71ab3mr13946611fa.41.1728058078036; Fri, 04 Oct 2024
 09:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20241003185655.1480819-1-edgar.iglesias@gmail.com>
In-Reply-To: <20241003185655.1480819-1-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Oct 2024 17:07:47 +0100
Message-ID: <CAFEAcA_NuLpau9KdKFGxa9yCMdgB9LSEB-3WVBAb=2aFwU2PxQ@mail.gmail.com>
Subject: Re: [PULL v2 0/5] Xen Queue
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, edgar.iglesias@amd.com, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
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

On Thu, 3 Oct 2024 at 19:57, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
>
> The following changes since commit 423be09ab9492735924e73a2d36069784441ebc6:
>
>   Merge tag 'warn-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2024-10-03 10:32:54 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/edgar.iglesias/qemu.git tags/edgar/xen-queue-2024-10-03-v2.for-upstream
>
> for you to fetch changes up to ca9275a4b11aced3074219d1712e29fce5036f72:
>
>   hw/arm: xenpvh: Enable PCI for ARM PVH (2024-10-03 19:37:35 +0200)
>
> ----------------------------------------------------------------
> Edgars Xen Queue.
>
> ----------------------------------------------------------------
>
> ChangeLog:
>
> v1 -> v2:
> * Removed left over trace call
>
> ----------------------------------------------------------------
>
> Dr. David Alan Gilbert (1):
>       hw/xen: Remove deadcode
>
> Edgar E. Iglesias (4):
>       hw/xen: Expose handle_bufioreq in xen_register_ioreq
>       hw/xen: xenpvh: Disable buffered IOREQs for ARM
>       hw/xen: xenpvh: Add pci-intx-irq-base property
>       hw/arm: xenpvh: Enable PCI for ARM PVH
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

