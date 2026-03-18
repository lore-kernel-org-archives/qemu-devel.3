Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6F2FCD0A6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2no0-0003lR-Ue; Wed, 18 Mar 2026 06:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2nny-0003l6-MJ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:07:10 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2nnx-0004ZI-1c
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:07:10 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-38a42a0d7f7so6426451fa.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:07:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773828427; cv=none;
 d=google.com; s=arc-20240605;
 b=ZBQUmJfGwCpkfpyH5/zFB/z5UVtdLB7qGWTQkrv4ZadAoiqTxSHJ9QkIuINzJ1dzIb
 /HLUfYvTByErIyBoopxocueu1c7TmCx82qEUc6QP8GfreKnWGWdx+wMUQSGuB0ZCZAZS
 NFX0fEcCFT2Hw0tZ4YQ+gWee7wBFuO5h94RJnvrc5QGhWPEuvvCOmpRWU7h3CnazDnR/
 zjxIXRflUt8BFGEMHxOmRO+NKX23owm62vb9oBg+VSNNT5XKu8YBe64Uhk6fuOFXOjCJ
 85X8csmceh7KIVnvIjs6Pu9LhvKaAKcEPVDnqb4GuVzl1qaLZqW5GhQL1jI1SB3gT2hv
 xwWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/R9/OSK/DKaqZPMUwiM3r7jZnekbVIwQZyVh0XFK1d4=;
 fh=PPOvtMHkqOkqS+s4WoZGxCoh6Ztf1gmLjaBoC9ThygE=;
 b=I5onauAic0chFt6S3UoBpfnb9EwC45zd0nXdgGYH/FnqDmG8CPBreYHUW5hPd7FJci
 +U+yAWqROltmVEdmqaVJGjdPJRCD5bpdLx/VzyFFAWDUREfBEY9VUaGgOgBui/RcCZ4d
 bJWS3JXT/0oSt+GUnP4cy19KQykIfuo8fbKXq9ODiL2P7Ei7n4TLJWjkJEvMZNSXxT+Z
 0/0Y2cqgljZTCoocDCmYiMAtbu6YAYwnSgFOLrIMbXVnU1lvsnvsjPD3y6jGYPy0mV4l
 9TgseKmo1uqNuUbA9PuzupPXM2RKeM/Hr2I4OqWfCB29RGN+sarTKevE6Qzu6Lr1tqz3
 mrtg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773828427; x=1774433227; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/R9/OSK/DKaqZPMUwiM3r7jZnekbVIwQZyVh0XFK1d4=;
 b=DRzGNuqkD3cgnIGvMGX2Gl204lrWxfMyWHFRXCOIipPGgspgF+10w7oN9SObxx5uhJ
 zblHe7FA8BhCgd5xScYcim3AqfAj/IFNQgRyJo/D/LJWhrUbFs2d9PSTddZ/x8Cp5hGK
 gC8XCivP2Y96zxbGcCaXU1In6WsIEPB8TtIj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773828427; x=1774433227;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/R9/OSK/DKaqZPMUwiM3r7jZnekbVIwQZyVh0XFK1d4=;
 b=AGYzjDLSK8DeiSCS+cyrJMLe1TQz5/4VFIX/pV9MXxVZMyE7I/+FO3M7ERa92eCNXq
 i2g7flCKbdcbCazGEVrWrCUPU9pYE+93/tdxnZ55xgrCYBpktmDpwEo1GTbgOShu2mVs
 Idd2+JrwfQO4aSA1UHTub879KMRmM+vPjo50qR2cXtvzidKIV9X1p0QxUSuAyYQuSXt+
 ykevi1kF4i1KDqHNz61Vu5T4Ia92Rrr8+FKWAWlsUdz9LtarCO89J23OtxJof1e1gOGm
 Q5nComK+nXP/AeHMV5t1fhU9KaKJXAPABUZvxV9ND7lwaMa6ZeVfzR/eN1DxOXxZitdy
 PYlA==
X-Gm-Message-State: AOJu0YyRjWeBzlciBI9SYc1JP51j/KjTL0U8N96Gmvb2r/KLCJx/7Ghj
 WFPQQ8isVbEpFn6EoXkFvGmmQLUcrceN3eHHYVOREeV8UFtnvnA/HC5PNxXg7GmnNc3KG9nqeDx
 Cgz1dybvfJzTxlE9lDOyh90xI1nUMAM6kHjItnuRC8g==
X-Gm-Gg: ATEYQzz3E4m3b4veUK6+revfy9HGxk7Vn5LW2hw4cb0Af8v6XAnQKp1AJmcFCX3kLUf
 KI47YlQJ7biRHVmfg8Z5qo4BvuA9pUErqH02H+Vj95s9AlakW0dbAeSeYkO0a9Rb9wc2/GymtuU
 m1uRLpCGvwGdYPlMQSN5DNUqcSzjEsi3+bSe31DdulmtgZryG+oqMVd382g3mf4rNi0gY+YQ6Nl
 RYaz5qPANcy07DrFwKe+LvYm2FDz/ipSt3MWOzz8GyGjsglH47oLuKUwIeANT08XHQyRZI6eMyq
 1aEnlT1/fvvPVKX1tUYDC2p+MSrlAPUIfRk7rTM=
X-Received: by 2002:a2e:8e99:0:b0:38a:78dc:844f with SMTP id
 38308e7fff4ca-38ace9112bfmr18972791fa.13.1773828426688; Wed, 18 Mar 2026
 03:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260317102708.126725-1-alexander@mihalicyn.com>
 <20260317102708.126725-3-alexander@mihalicyn.com> <abnKKguESqlptJdp@x1.local>
 <abnkFu0BAHYpQqo_@x1.local>
In-Reply-To: <abnkFu0BAHYpQqo_@x1.local>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 18 Mar 2026 11:06:55 +0100
X-Gm-Features: AaiRm51xfkys8u5YwApPYAEecxbjWT6w7Q_xG_kld4lZBbCNYAR86vDPrlc6qcE
Message-ID: <CAJqdLrpiu1ZVw5vRQpbAO2NPMbSAm-gY6Yy7=7Thgkxst0TeaA@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] migration: add
 VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8, 32}_ALLOC
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Jesper Devantier <foss@defmacro.it>, Klaus Jensen <its@irrelevant.dk>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=alexander@mihalicyn.com; helo=mail-lj1-x22c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am Mi., 18. M=C3=A4rz 2026 um 00:30 Uhr schrieb Peter Xu <peterx@redhat.com=
>:
>
> On Tue, Mar 17, 2026 at 05:39:54PM -0400, Peter Xu wrote:
> > I'll likely send something very soon just to show what I meant, it'll b=
e
> > good if you can have a look at that when it comes.
>
> I've posted the series as RFC here:
>
> https://lore.kernel.org/r/20260317232332.15209-1-peterx@redhat.com

HUGE thanks for this, Peter!

I've left my RWB and Tested-by tags on that series.

Kind regards,
Alex

>
> --
> Peter Xu
>

