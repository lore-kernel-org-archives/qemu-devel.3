Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493A0C47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUlCE-0005Dn-7N; Tue, 30 Jan 2024 05:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUlCA-00055k-Pk
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:18:22 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUlC9-0005JK-8n
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:18:22 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a2a17f3217aso517472966b.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 02:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706609899; x=1707214699; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pefoji9VsUlEMmyQtliMeRlNDQVVnfBhMfEnpti8Av0=;
 b=VGjLScqvElLcW0g5jR2JZxw3Jf8cwrHrhdh7BD8uiRSZKPJXRSHyLvdn5B8CeCuCZ8
 SAg5g7hYlE1fKbiE40hYdviVd6IBsgGZM/iqHOWYXj0FJz91Oa3cRK9jLo+IgS5v9lDG
 ko9aWpMkiZv2gRiuj3+HE2MbmS08tyRZxdqOux478g23Fv+plA8c+Jz3SQSVcBcFSgHB
 BRkPIcEdMzurhsZf6srwNRMUS7y8ZxMC7BM5XuhM3e2OjuYa6NgcRKNTfQ8jSlEVQAam
 SrpQmILuaDYuBYqs3A2LW4ttsjenYt7gIlRXUKLE05jFxGhCXztHH9uCwrph1jyDFcMe
 qQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706609899; x=1707214699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pefoji9VsUlEMmyQtliMeRlNDQVVnfBhMfEnpti8Av0=;
 b=fB9RXI5hl4uVeDHGM8dqy5iCnDIScg0xWnadVwuTXPFxwgMiA0BbOkEW1i9UE+WhnS
 b2F69ns4lqrNfZPO+yxpHfb8lprF6NU4ktdqKOjVl66AdCvqnFxcE3enTIbcmBjcNSTw
 7diuq8EYWrSQtnSq/goCgt4FPsGsssnnZL0fqsEDlMCRXJusbP4fLNn/btHEQBXPIxL3
 xr4/jU7a2b/zvUUO1puIDNO+zaDa+A5Y5Okwzut4SyI4YHl9UxmkI+G3Bdiw7c4M8aoH
 rOndkyaZGG/2GwULhCzDbhpwImAxreNVfmdTohh+sQxyaq80iaOf2GWzPFJ/ujBX8IAF
 gB6A==
X-Gm-Message-State: AOJu0Yw42biBA7CTCcj8cTpDAgArCqHa60lih4HvSQPRWzc+oMclfjOR
 4s0/hxLzovXGZQfH9v+5B3/iDA8dk/oc+n3/Tvrxmjj9VrJtsqlbPdgJp1ZF2LRhykxMf/+z4De
 E83u8RHT6dAQiLOp+HQM1o9mhfsVSttvIvf4New==
X-Google-Smtp-Source: AGHT+IEulnw+w82KbxR4YPB/tYbZFWCi3GJRaDlRU12sFNmAv3hirxlfNlw1EDyoQ0Dg90mAleOeNrJYTOl4F3R4sjQ=
X-Received: by 2002:a17:906:c093:b0:a2f:d73d:e99c with SMTP id
 f19-20020a170906c09300b00a2fd73de99cmr6462724ejz.14.1706609899292; Tue, 30
 Jan 2024 02:18:19 -0800 (PST)
MIME-Version: 1.0
References: <20240126041725.124562-1-peterx@redhat.com>
 <20240126041725.124562-7-peterx@redhat.com>
 <87le8c6u1d.fsf@suse.de>
 <CAFEAcA-x4WqvPsN-KZOA3SPN0F=vvYi=NFZ2qom2iT7-CN0RSg@mail.gmail.com>
 <87il3g6t7b.fsf@suse.de> <ZbcSqyGNLGu7ugBb@x1n> <87sf2ge3qu.fsf@suse.de>
 <87y1c7ogze.fsf@suse.de>
In-Reply-To: <87y1c7ogze.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jan 2024 10:18:07 +0000
Message-ID: <CAFEAcA_BPf4LSh-JF1NVVVdaLoKgUcsnGeP7sHt-f73r4zyh7g@mail.gmail.com>
Subject: Re: [PULL 06/15] tests/qtest/migration: Don't use -cpu max for aarch64
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 29 Jan 2024 at 23:31, Fabiano Rosas <farosas@suse.de> wrote:
>
> Fabiano Rosas <farosas@suse.de> writes:
>
> > Peter Xu <peterx@redhat.com> writes:
> >
> >> On Fri, Jan 26, 2024 at 11:54:32AM -0300, Fabiano Rosas wrote:
> > The issue that occurs to me now is that 'cpu host' will not work with
> > TCG. We might actually need to go poking /dev/kvm for this to work.
>
> Nevermind this last part. There's not going to be a scenario where we
> build with CONFIG_KVM, but run in an environment that does not support
> KVM.

Yes, there is. We'll build with CONFIG_KVM on any aarch64 host,
but that doesn't imply that the user running the build and
test has permissions for /dev/kvm.

thanks
-- PMM

