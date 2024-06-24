Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703FCC2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 09:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLfuy-000156-UV; Mon, 24 Jun 2024 05:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLfux-00014s-Jf
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:23:19 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLfuv-00068M-Vg
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:23:19 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a724598cfe3so154435566b.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 02:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719220996; x=1719825796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q4BzCEV3H5pbYOJkluJc0bUCw0sfJUGWx6k8ihV4ovk=;
 b=d7X81Wsv0d42m6okWjFLU24LJMm+E8JuvZLixzcxIK+65p8X/GFkKRrQ6m4EMs1emF
 csWwXvSas0FubW0tPhhaqrgSrtVNmyKnYsIqHAEMLE2dyYJyTTXxkY/LUMT+Rnbs0TyQ
 9C5KweL9I8P8w/Dm6dNaJl575oh8cEZ1aObwIguN2aEpj6509GwVMouX+0D5+fSI2XYn
 BVI46aokmfVgBJb6yxzUgIJd6X4/Ps+5vms5k8VXuy3WdAcUCEH2FuZbHsNJBtFvscmi
 P2Aw6ZxFicGzSiPZAARhn79aD7GLP0MQ5/4MVJzU9wh9X3AksEACzqN7edv9wYWFQx63
 PEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719220996; x=1719825796;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q4BzCEV3H5pbYOJkluJc0bUCw0sfJUGWx6k8ihV4ovk=;
 b=E0N8ViAGOap5ioTJ3fmfoosdlQ9T0DqF9wdK6Flkv4z07njt81/Ga2hcNy4m1Q/ird
 Sm9L41gZ32nPP0fi/mAB3WZ8t/z6AjT6Ny7MSISCqLhVUzf8xJ34WpoP5sMcjmSvHUDy
 D/5AmsLchj4R6hkuKFiu+VIYeQ8ah6VE7++ycbguYLYQbqiAG8Yf4Km+5VznlKGkTP4w
 uU6howDLhqICTWi3C5wLZjykGYx/O9G/wM7H74Z+I4OJS5nEffzbVibxoPpQ2LWgUUyf
 rVvXsES8eYqmMsg+A70P5eBq/O7JmoAjmtAu6Gnl+hekZvo3RLzj6GnSs3VwHSD5Z+To
 hj6Q==
X-Gm-Message-State: AOJu0YyytvuKNbcf29zZT0HXjLxHPKCfx6MZWgT/tfJmzjt3EVAfXutw
 M27qJhpTzLFiZlEywQUxyAdxs2hBI4YFYRy/GyFDG8t6OFAT3OxB/as0STuXGe9zMV3HtP8Y0m0
 v
X-Google-Smtp-Source: AGHT+IHoTtYmruSBJ49zUEvM3An1mAih1lDDEFBjiVViYYBjuVslwJtnUsV8snX37BVz8Q2aW+RYfg==
X-Received: by 2002:a17:907:e9f:b0:a72:449e:e250 with SMTP id
 a640c23a62f3a-a7245b85073mr455055866b.12.1719220995488; 
 Mon, 24 Jun 2024 02:23:15 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7260eb1657sm12186966b.219.2024.06.24.02.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 02:23:14 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E4F4D5F789;
 Mon, 24 Jun 2024 10:23:13 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: tugouxp <13824125580@163.com>
Cc: qemu-devel@nongnu.org
Subject: Re: Did the "TCG" emulation mode has a full capability compare with
 the "KVM" emulation mode?
In-Reply-To: <75d15b4b.9cee.190497f83a1.Coremail.13824125580@163.com>
 (tugouxp's message of "Mon, 24 Jun 2024 17:06:51 +0800 (CST)")
References: <62981bf0.8f16.190495cbb92.Coremail.13824125580@163.com>
 <877ceera4b.fsf@draig.linaro.org>
 <75d15b4b.9cee.190497f83a1.Coremail.13824125580@163.com>
Date: Mon, 24 Jun 2024 10:23:13 +0100
Message-ID: <8734p2r8xq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

tugouxp  <13824125580@163.com> writes:

> Thank you!
>
> BTW, TCG also has two backends implemention, 1. Native host arch tranlati=
on. and 2. TCI byte code interpreter. The
> difference is that the first one will tranlation the target arch code to =
host arch instrtions and then executed in host cpu. but
> the latter is a high level interperation. compare these two backends, Are=
 there any capability difference on the system
> emulation about the two backends? thank you.

No - TCI is just a slower fallback to interpret TCG ops directly
compared to executing JITed code.

>
> At 2024-06-24 16:57:40, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> wrote:
>>tugouxp <13824125580@163.com> writes:
>>
>>> Hello folks:
>>>    I have a puzzle on qemu major two emuation implentions on whole syst=
em emulation, that is ,except the emuation speed,
>>> did the TCG work mode has any weakness than "KVM" work mode on whole sy=
stem emulations(including kernek and
>>> user-space)?
>>
>>It depends on the guest architecture. Some are more complete than
>>others. The x86 emulation for example doesn't cover all the modern x86
>>extensions although there have been some improvements to its vector
>>handling recently.
>>
>>One thing TCG can do that KVM can't is emulate code running at higher
>>priority than kernel-mode. For example for ARM we can emulate the
>>EL3/Root domain and secure and confidential realms. In KVM you can only
>>run a guest EL1 kernel and its user space.
>>
>>> is there any work that kvm can do but TCG cant?=20
>>>
>>> of course kvm is much faster than TCG, but my question just about the f=
untion, not care about speed.
>>>
>>> thanks for your kindly help!
>>> BRs
>>> zilong.
>>
>>--=20
>>Alex Benn=C3=A9e
>>Virtualisation Tech Lead @ Linaro

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

