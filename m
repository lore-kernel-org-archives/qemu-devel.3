Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C9EC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 19:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgr5Z-0005JC-DC; Wed, 21 Aug 2024 15:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgr5X-0005GY-Oo
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 15:33:47 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgr5Q-0005SA-Uo
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 15:33:47 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5334a8a1af7so54732e87.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 12:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724268818; x=1724873618; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3k5da5UIjlB9USuy7SHe4VIMO8RsOIXabHKZWckV2EI=;
 b=Iu95fGITaCQ1CaqWF/j66KepP5H9WnfeqIpZfy+Nh6e/DhGEg7pEzFmVQN7HQbuFlb
 HfoNAjUS67C5Gd9JJbqRC8WZ1KZFzI04w0MjGu1PJ6hUsNmx9H09PXSZrRP5LG+UvkM5
 EA0whs9ElW32hFweB39kURpO9evbKF1zz/bYiaBOmeJ1Qnidxvuk7qhbvXkTkxFvRiFi
 t/GjFiZQlVoVbGdla/ARURtgqNS2+ez/BS8/4ukpt2tQ6NhF9ekzXgtHtTc4ROOrLEPt
 I/p069A0UpXS0qd+DatiTwznrt5HiKvF36rszosopAEeTJZE510IglY2eAT2D16DhRdG
 b+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724268818; x=1724873618;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3k5da5UIjlB9USuy7SHe4VIMO8RsOIXabHKZWckV2EI=;
 b=OxfnuvYAvGmTfn0hj4uG23Omb7GoxtktHvHn30z8ABCqUDu/pCn2bl9LJX5Bdoy3aV
 R7b4xhxF2qvr7BA97xmcKwfZeszs0Foav922aP2SsXMkzl8UeV/50NogpbDfE3hCsB1F
 eW0Jon42pshQP/5s5RnpVeKYxUy0W0DqhG9B7jfD4X4vwO3iwBRb31gqD5STt55mT8DP
 9AG8koKddmwtvRSVoy3oIDNvxS5/bWG1ych8GrZFyVeFX2qKGwd/ju8d72cyaTyza6qB
 t7hLiDmIB4OllUygDZVM9eUcKe7DChhMMuL/FZTS8FOGV+8nicHJJi0Cn3NGWcYGsKgi
 0fCA==
X-Gm-Message-State: AOJu0Yw1zH1Jn4EUd7k21cb2fvhN9iZyoPh/1xCgJBpuq+rpoQTobCdD
 TMnWdvTH/gE9IVu/0dBxEEh0K5gCq093NqX7zS3aNcaiXh77geRrhL/omMgIKC3dQjRpzJRp57a
 e8O4PXJdUJsXJ4aHuRRQ68LSYhJsVLCG3cvobCw==
X-Google-Smtp-Source: AGHT+IFHfLckA+8LhWjpLkYgAd01cxNoDqjueppIhGmFfMUSXxNVsiYOwlp7rcMu8tmPtVwYyK56EeT4dor0WyB5Tdw=
X-Received: by 2002:a05:6512:3f12:b0:52c:dc57:868b with SMTP id
 2adb3069b0e04-5334858981emr2244004e87.13.1724268817885; Wed, 21 Aug 2024
 12:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240820145514.63046-1-nabiev.arman13@gmail.com>
 <CAFEAcA8WPfynQyjB1_S5z=OA6k-xhxr7DNOZBR0mC9gtD-mCnA@mail.gmail.com>
 <CAGMt57c=Nv2Teu_=cqteCGs1yjPWQT7vfUs42hFL+MCZjbJEeQ@mail.gmail.com>
 <CAFEAcA_wpbEaX+iEz7syNd1tB7A77UVT75vzups=yZogJmiEaQ@mail.gmail.com>
 <CAGMt57d7f1WwfvoCoOtFSEDm8eqMZAEP17DsZuo09dLi0j-A9w@mail.gmail.com>
In-Reply-To: <CAGMt57d7f1WwfvoCoOtFSEDm8eqMZAEP17DsZuo09dLi0j-A9w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Aug 2024 20:33:26 +0100
Message-ID: <CAFEAcA-Tp8v-DTOBVfyJApb8-Wv=RuO_Qda1zHN9-jSgVW7g0A@mail.gmail.com>
Subject: Re: [PATCH] ppc: fixed incorrect name filed in vmstate_tlbemb_entry
To: Arman Nabiev <nabiev.arman13@gmail.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

On Wed, 21 Aug 2024 at 19:56, Arman Nabiev <nabiev.arman13@gmail.com> wrote=
:
>
> In my example in https://gitlab.com/qemu-project/qemu/-/issues/2522 the .=
needed function returns true for vmstate_tlbemb, but not for vmstate_tlb6xx=
. I tried to do some tests without fixing the typo. When I changed the .fie=
lds in the two structures to the same value so that the size of the data th=
ey stored matched, everything worked. I also changed the order of vmstate_t=
lb6xx and vmstate_tlbemb in the subsections field of vmstate_ppc_cpu, every=
thing worked as well.
> According to https://www.qemu.org/docs/master/devel/migration/main.html#:=
~:text=3DOn%20the%20receiving%20side%2C%20if,that%20didn%E2%80%99t%20send%2=
0the%20subsection and on my own tests I think the problem is that when read=
ing saved data, qemu uses the device name to determine an object that extra=
cts a certain size of data. Since the names are the same for vmstate_tlb6xx=
 and vmstate_tlbemb, it uses the functions for the first one due to a certa=
in order, which leads to an error, since the data from the second one was s=
aved.

Aha, yes, that would explain it -- the PPC CPU has both
subsections in its subsection list, but they have the
same name, so we pick the wrong one when we see the
name in the incoming data.

In that case we can take this fix without worrying
about a migration compat break, because clearly
migration has never worked for this CPU type...

-- PMM

