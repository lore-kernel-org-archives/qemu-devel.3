Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E323CA0FFF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 17:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut8Eq-0006Fs-HI; Mon, 01 Sep 2025 13:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut8Eo-00068K-2T
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 13:22:38 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut8Em-0001di-9G
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 13:22:37 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-71d6059f490so44229917b3.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 10:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756747355; x=1757352155; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W32JbMj7HdeUvsjOu6FpTcDvcbyBGjo1P+nBU4sazrw=;
 b=LhlQX25Qg7bR52yB6k9YCEzoONeLtHobIjC1RXB8YsIfkepXZHLnr/jP5gUMWRbug/
 fD4d2IUSI92EO4X2qgpeasZPODMquFfqMj6sE722l9h72KRMxKgxEYji62Yn9aPT9oaK
 SZ+c4OvAMMn2HHNdBBssWkgHPK51oFiNyGU+BR/HDsbjNBdwMwrZJnazbud+08CNsjgq
 coOoRVmVNkoR1/WFPOK1PFjuDQkAl9DeyYtdFicT5Yw7OUnLWzp+dYfH3P/ErTCNWIMS
 f330C4CNyVkcLeqWyGbhRRoaEbQguqKHNOexy4ZfKMkzIa68fO3csq80cM/zKn+y57+j
 atIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756747355; x=1757352155;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W32JbMj7HdeUvsjOu6FpTcDvcbyBGjo1P+nBU4sazrw=;
 b=unuUT4zhc7NbL5v8arwYf7I92w0K5PqNqFrrb8bsueIh74b1AdR+nl8o9YzZAsGx8o
 m49FAEw21+tTzWf2pWnyMEKUhjzAGpa9BhY6g1H7edh2qM46hSen7O12ajsBFrbftFcz
 3JjrP7wOXU1/Sd3V5uOS2iL+2GH5QrMc8ulXYBSaBk9URff4kQPsSXAl9HbCprcBepaj
 Tzb5mpknc/I4TzrKJB3lp6VTQifViH1Ru7mgWEy4m/zjkxVdgPZMaglEjlXWOSWCHgvT
 51rpoXn17EjfxlU8p/EoDrOZHa5dycgCFoVSGwbVTtyrNIrpZjPWmyFN28mlJDYuoQUY
 bEHQ==
X-Gm-Message-State: AOJu0YzhHkGm/e/jRIy09Vk1VUSYx2SaDCNs1FAeNV78NzTP6e+y8Fdz
 jmxBOrStEitXgZkOe7uOBKzGr4E1shwuUZdVzZOnlJ2zwTMlUA5WGwQUUnAS+BbRe1SZly/5TBg
 1eTUovFGvwR0jwQZKFBHP+3M0ReUFPoJKttESUSUMyQ==
X-Gm-Gg: ASbGnctQZy83wXJWzrcWtE9sU90I1EAM+5dvWfGmfpH1lwUiJ+P0KU3BBovEyx7HEUU
 kzogNNeqGQWlzVukDnkc0fhCAWzKcQb4kIK2Sk8wpNSK1Evk2nHJXwjfmWhFmHeCe3gkecsulg+
 Fu8VznnBVI2WHeS2llULOHlPMw7UDs17jk7hryarOq+aKSJRoWfbLXNyJWGOxirfS5oYAGtbOOg
 iTY/RzfiGpLjnyIQ94=
X-Google-Smtp-Source: AGHT+IFMBNAZpOfvX8SbnCB3gv+7ItfdwgvkhTuf6t2hwSVPw1ztr3LJLm91g41PCVIvBPMTH8T8y2DlJbGJ+ny2TR0=
X-Received: by 2002:a05:690c:9416:20b0:722:7a7f:5381 with SMTP id
 00721157ae682-7227a7f6e8cmr78637077b3.14.1756747354887; Mon, 01 Sep 2025
 10:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250822092410.25833-1-cjchen@igel.co.jp>
In-Reply-To: <20250822092410.25833-1-cjchen@igel.co.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Sep 2025 18:22:23 +0100
X-Gm-Features: Ac12FXx4bqVFmiV0CZPmFhtyvqOeF2ktAnEx6UW5G9ETXHK22vVaMgcmrLmZ4TQ
Message-ID: <CAFEAcA96Dk3s=SGfm-vtiuxCnjpHmA0Oh5P81wyvtWJzK6KPSQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/9] support unaligned access to xHCI Capability
To: CJ Chen <cjchen@igel.co.jp>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org, 
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Tomoyuki Hirose <hrstmyk811m@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Fri, 22 Aug 2025 at 10:25, CJ Chen <cjchen@igel.co.jp> wrote:
>
> This patch set aims to support unaligned access to xHCI Capability
> Registers.
>
> To achieve this, we introduce the emulation of an unaligned access
> through multiple aligned accesses. This patch set also adds a test
> device and several tests using this device to verify that the
> emulation functions correctly.

I think it would be good if we can land this series early in
the 10.2 cycle so we have plenty of time to fix any
unexpected issues that might crop up.

I've left my review comments on various of the patches.

thanks
-- PMM

