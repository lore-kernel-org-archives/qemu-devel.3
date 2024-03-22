Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E555C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 11:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rncf6-00040q-NS; Fri, 22 Mar 2024 07:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rncf4-00040H-VU
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 07:02:10 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rncf3-0006uq-Dc
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 07:02:10 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5688eaf1165so2799271a12.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 04:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711105327; x=1711710127; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FMYQc2Vlfm2Mfe3HQG57A4ryw/bHoYwII3eCLLu5vaE=;
 b=jDlILrz1oIiB7bLOAFUtf0zZNsPSGUQ8Q6OFLX90WmAr8cpv6pHI18X3JMO9fCeG0i
 QasG1kLki9efXyFWvoGiTvtKHEFpklarf+VKe0mahmtCnBeCoBT9yJmhrQerymUK1wan
 VPaZR+smyBfFpkbCE0wFZApB6H1952mQ9hYVqtUmO4k8IqsA+bv53Y2onlX/3KFDxziI
 suDJlE/kucV4vCD4zSavOGSPb2qlQPj5SdOJoE4Tms5dLyiwUZkOWa1gOZSbN8t9vKEq
 nQMDZj9SlbOJ8axwMrE1Rw1OyuvjIqw4e1Y2rlexeCaN6MQe3DfP02zkP3MwPK7sVlId
 jqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711105327; x=1711710127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FMYQc2Vlfm2Mfe3HQG57A4ryw/bHoYwII3eCLLu5vaE=;
 b=JFg+vqVetrwsPOxhTcwhcwTJigTadk/6G9VPo6V8elcG6rvncb3JfN5PNgzr5afRgk
 k2I6FJIZ7k6InD3MPR+mMZGc83ts/34aKWHhlWmIHuQWUGPlbZXMKufIoLty3ug0QziF
 pHKCCVrtEsx6zXflIOTouzvhFeaJWyZPAA7oKzxAn/UeRGORVg5reUnSecSjx/JsuuL9
 GZEJYDDYlV3pIz3Il+IJ7LKrqi7dAPIRybC5lLY4fMEhGw43PbfjPwsT7QCR+Ey+QA8q
 T39g06RlnPC7BpJ7TCC/Vsqlzj2sHIhucz84vH7YvcDyv5S+mqpjiZyvYRq41STFNLah
 Q7hQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM+yKCi2GuTPOoMJNYYyv4r53YmqD7juuIMulblLub1IrmxBdyYowXYmNpskFhKE2j5YanOOIoUeTeBjZXjNe5Fg/vKNc=
X-Gm-Message-State: AOJu0YyjPLu8vw4nXeK6tSkFrO55tnxoYnHu2tsxJwzlk0Jb52tOQ3sY
 vmiMsIoye2cetTLq2FzLwnJOsHsuvizFrAYtIQM9MmgJlvK59+EnJEo05VYYDJJmzQ7q0eRxIHT
 w4itUjDolH6HtxlFRflA9jbtcMzqEVefWdEG7NA==
X-Google-Smtp-Source: AGHT+IETPNbd+G0SKtiYUsDTcASpwFsaAAp4iFw+Sar2be7CSNaS9/rr/hZgnL0k/wpUdRiD9IjGuL+Pj6FKas/kDvo=
X-Received: by 2002:a50:8ade:0:b0:56b:a03c:4eb with SMTP id
 k30-20020a508ade000000b0056ba03c04ebmr1421840edk.31.1711105327612; Fri, 22
 Mar 2024 04:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240321130812.2983113-1-ruanjinjie@huawei.com>
In-Reply-To: <20240321130812.2983113-1-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 11:01:56 +0000
Message-ID: <CAFEAcA-EJi593UWJHuSoBeNF8F8+Q+m0idVzn-eMK=gEJUdipA@mail.gmail.com>
Subject: Re: [RFC PATCH v9 00/23] target/arm: Implement FEAT_NMI and
 FEAT_GICv3_NMI
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Thu, 21 Mar 2024 at 13:10, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> This patch set implements FEAT_NMI and FEAT_GICv3_NMI for armv8. These
> introduce support for a new category of interrupts in the architecture
> which we can use to provide NMI like functionality.

By the way, when you send the next version of this you can
drop the "RFC" tag -- I think this patchset is in basically
good shape and we're just into the process of finding minor
bugs and missing pieces.

thanks
-- PMM

