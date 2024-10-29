Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E45DD2AB3F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 13:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5mZP-0007ZQ-Gv; Tue, 29 Oct 2024 09:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5mZN-0007ZE-4u
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 09:47:37 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5mZL-0002oL-Cg
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 09:47:36 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c9404c0d50so5950308a12.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 06:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730209652; x=1730814452; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eINsxTFNM8wli4EjHi4+QVQohfopAR2Uk8qOq4u7RwY=;
 b=o65zwhd+OwISGSyvpSlGAAQcB3PAnDofAEL74LNu6DrS4lPoiflRAz4WUpgHKgltp4
 Pwv3kws+XNiJI8VDKAHJPvlbCD+lbIimdzFyP8Wli0w5eyzYM1kbuuwqSYHlmNzOmDk4
 yrSn29+lEzcQoXapALt/uhJZWDeYanhWcuit+jA+Sp05ULdfEuPFZ1CtGw1/Fn1iGpK2
 fkNVael/QDTTSdLYOONVgRkRo/pSZdkg7p+nvrjj4om5IoFrhJvKBMvcVzgVzkNqp+Qe
 shzKsoeLW8E0T5CxNfS1wOwgu+hgaVvht9g/RmV6s2rpR75YhiBX1QKcH/EQwCjRQWYU
 SIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730209652; x=1730814452;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eINsxTFNM8wli4EjHi4+QVQohfopAR2Uk8qOq4u7RwY=;
 b=s0PTDv4MEPgRJN6vjPZc0YSDH4fSuQvNU5z1I3oVqMuh256MrCvK3EeWKiBSXniUpm
 jQqmFvnE8er1mz7e/rvx9JtgSLdAFZbfGIG9FjiX+7FuApRCX3K6X/+E2+Lvjiwx7H94
 OKFpP/3T+r8NNOd3P+3wCO27ybVl2CB5+IBquAiJ8Sf1ntQfJHMTUrAxXAg9NHdesFYG
 mhopYhK5VyXxB+xqulF3QLJoXbzHrfD5aq/7+H1UizpEGpHJXhXuAtjnqluT4N7C3jhW
 7BpQapvFDsHlE0cbMhhiaTbLRIM4qK7n4l01mY36OaMRNMRsnTvSbsVk8uS/CjsSZIJq
 nQ3A==
X-Gm-Message-State: AOJu0YxcZIQaoXXxiO35WgIF/DDeoiSqKCKQxZmJUGXwW1o84xKb32Q6
 1o1WuU2jLwxoVnc5osYUwG+xSLsfWF5ZBEmsMort93IIqDDqVxn5gc+x0syWL11BGXIvnV2kidm
 hDQQPEPaRzffjTyvNhKRV4u/E0ViSoq6E7LwcHg==
X-Google-Smtp-Source: AGHT+IES70b4OA/ZOGI/ifU9fU8M/g3UtrfKL/AVbe1BCRQJua0FsMVfkW9c5+utV4mJrrP6giqjEo0N6u3U/m7RlmE=
X-Received: by 2002:a05:6402:27c6:b0:5c9:16e2:4db1 with SMTP id
 4fb4d7f45d1cf-5cbbf8953b9mr11803776a12.8.1730209651953; Tue, 29 Oct 2024
 06:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20241024113126.44343-1-pbonzini@redhat.com>
In-Reply-To: <20241024113126.44343-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Oct 2024 13:47:19 +0000
Message-ID: <CAFEAcA8L7HdR9Gpimqyn7+DR0o7vnHAn1a9xXQo2XpGbe+a79g@mail.gmail.com>
Subject: Re: [PATCH] target/arm: kvm: require KVM_CAP_DEVICE_CTRL
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Thu, 24 Oct 2024 at 12:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The device control API was added in 2013, assume that it is present.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/arm/kvm_arm.h  | 16 +++++++---------
>  hw/intc/arm_gic_kvm.c |  9 +--------
>  target/arm/kvm.c      | 17 +++++------------
>  3 files changed, 13 insertions(+), 29 deletions(-)



Applied to target-arm.next, thanks.

-- PMM

