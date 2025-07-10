Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9890C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 15:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZt4l-0004tn-BM; Thu, 10 Jul 2025 11:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZt4X-0004jv-M4
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:20:29 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZt4V-0001xN-Pq
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:20:29 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e898fb745beso2352679276.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 08:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752160826; x=1752765626; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lStpNvlclqQGLHSJg5wy7W8AoeA01L1kwc4/Dsb2mGo=;
 b=knb2VQnnZA0vxfbPXb1p+D3X5/ezFQK/5qe6zJPOmN0AK1Jay2p5q8YmCGB+3YjRMI
 LhOiGEwhaeukMyZ7YpF/vQJn3o+UmnBrI2BzoHPyOIxBE2urOjTilre5l3hAyLE2fbnj
 qCsWoQkgC/5WIwfrT7dFP2FApSRYHSZ9aOvjVA2zK6dndxAt2DQZCycjlF2p7jWzE7LR
 tmOyhOeJpb8/2AJ1zHFx8OPxHraHVOvhYcouRHCl7z9mro0YsfCI2XrI4QtBWp0Jc1uC
 u6PxmjehYNqwnQg09Rcpi9ZdradyjYxZ2P+7m/oAd7QHZgSFwQOOsx+t6Xahnagsq4Yq
 DkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752160826; x=1752765626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lStpNvlclqQGLHSJg5wy7W8AoeA01L1kwc4/Dsb2mGo=;
 b=gtNZevo1CzpV3Js7TSl137wfYnivOk12ifTpMOIJY/Km1My8ZUsCXpzXqMWXdUAnMV
 scWpSY00YYQIqw6H02sa4RGj5TO9HOhKHrEZWsA6LQap9Wimsf9VMb1xTSAk/QaiTyEZ
 wa7lP9YstHw7GXswnjVlwixZeBYQliO7VnFWXAn88Hor9rSjiiiADxbHo2lM2PifzNO4
 J6hiodW07BTswADZdK3jK40aSWJAcxa5qJep65HHtUxPAC1GdJ/C4LwAahJZ7UjAeo7Q
 ZHDsIUKdAjSrRt5vwyQIFMuhRl01nVb+3lbGkMX9RjfEyGoJochAo5qy7XZBbhe5awuh
 g/Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl06dx9iHmD0XKE50M/hSeavhDWPtbqci3blF8U+qvLbQXyo19RlESmtTFQwesyhRwab/FUZTwIJz1@nongnu.org
X-Gm-Message-State: AOJu0YyEMqjQKsM5lvo9IdHffmr8NynorWi5pJSiAXygrhZqeivfOfK9
 eWtOLOgtjLaLZU+3nAYu3Qu+XYcPVqw5S+f/2M7HJcKwE59rDRjEpEOVnXWJsYDbBsC1buj/HZy
 OOwZba6h9JuRjKk9FjZyutM9Hclv6dzAZoI8wtt5ciw==
X-Gm-Gg: ASbGncvAJ01JAXL5v3pJg+PP3gXqDYaqmaDkj3zlb4jDhnnf2NbMXEhk1EOPg0gbSd7
 qdRSDn+cpSs9aQcCFOj6z9YBq2frc8MQCMJi9mZRG79kYCIQuLsLUSBGUEpfba+cwidDVPDUUyS
 9XXUb5Vssr1rwAIbwJpeoHEt+FTpRAZcYNlzhAmew2Xl6l
X-Google-Smtp-Source: AGHT+IEGFB2jIbBsNQKCoBKAUJcFeenrGSdoTYoGbo+6mPQIitw21TZDUxjNfourt7paa/N95Z0zMh14wTbk0PTvM5c=
X-Received: by 2002:a05:690c:6601:b0:712:c55c:4e5c with SMTP id
 00721157ae682-717c14d8b82mr57192967b3.5.1752160826429; Thu, 10 Jul 2025
 08:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
 <20250708154055.101012-2-shameerali.kolothum.thodi@huawei.com>
 <61464e90-9be3-4be5-a0af-ab15b92776e5@redhat.com>
In-Reply-To: <61464e90-9be3-4be5-a0af-ab15b92776e5@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 16:20:14 +0100
X-Gm-Features: Ac12FXwXrK49iN8S6SpNmQv1IC1bvkSc-LrO3vFcRIuFuupyeCT_lLTt9sxkxfI
Message-ID: <CAFEAcA8YYrkwaU3ghdCDiA3rqLVj_to++yg3R69EVY+2dP0R2w@mail.gmail.com>
Subject: Re: [PATCH v7 01/12] hw/arm/virt-acpi-build: Don't create ITS id
 mappings by default
To: eric.auger@redhat.com
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, jgg@nvidia.com, nicolinc@nvidia.com, 
 ddutile@redhat.com, berrange@redhat.com, imammedo@redhat.com, 
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com, 
 gustavo.romero@linaro.org, mst@redhat.com, marcel.apfelbaum@gmail.com, 
 linuxarm@huawei.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com, 
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Thu, 10 Jul 2025 at 15:00, Eric Auger <eric.auger@redhat.com> wrote:
>
> Hi Peter,
>
> On 7/8/25 5:40 PM, Shameer Kolothum wrote:
> > Commit d6afe18b7242 ("hw/arm/virt-acpi-build: Fix ACPI IORT and MADT tables
> > when its=off") moved ITS group node generation under the its=on condition.
> > However, it still creates rc_its_idmaps unconditionally, which results in
> > duplicate ID mappings in the IORT table.
> >
> > Fixes:d6afe18b7242 ("hw/arm/virt-acpi-build: Fix ACPI IORT and MADT tables when its=off")
>
> At least please could you take this fix?

Sure; I've taken this patch into target-arm.next.

-- PMM

