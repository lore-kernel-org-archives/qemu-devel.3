Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE42FEC0EE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 18:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w56ZI-0006Dx-M6; Tue, 24 Mar 2026 14:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w56ZB-0006B5-I3
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:33:27 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w56Z5-0002Uy-N8
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:33:23 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-7986e538decso26470357b3.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 11:33:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774377195; cv=none;
 d=google.com; s=arc-20240605;
 b=dhwZUnMvDhdqKoiTGnsvD6bTnZbupmRD1kbFFJai+LTFTrUgu2Lp/Xt1Dfdv42sX54
 VBF5Lc5YKTAe7/AFGAoH8E/PpRHOduxit46U9aN7O9+Es9RAqXf+Tr1kCP1Fbiffv+qB
 SajKocRpccJxvwuiirlcdrBgOUa6swqmhgZVI39z10qF1gHBr+C+djwYpxFbqZEqbNbb
 +CHHInz7hK2WjlPURr/BLLFUkrjVCGAoguwaXoS5tWR6cDvmqUUKGI9xzyTb3qjVkb+5
 IupJ9GKJ78dK9xv9OvUUX01c8qOFgaj8Bd7CHDDqQG6zWjwVwv9feW3UpmA+AlaJw5Jk
 QkNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SeawxHzR7oIIWD7L6euV6+64EIJePGXDgqnHC/QlMpA=;
 fh=ukGBM0tMLB2EjwjNTNJYtsaiPL9O0ZLy/kYJk8b684I=;
 b=Q6d4Hoym4ZgSyxQFs738CQp08D95iTCOZ0a8ouiGET9K1YBAaqGz6iUosrstZIL+AI
 MmdrbMvAk4maCRQAFFEC5erUn302MaSpRNe5SnkgDlPoq1KT29uOIAkFfJ7/VtJh2hrA
 x+okMhmOr80J7lrg28tod38PM30QE/whjumviO/EqX1aQwPdvn1oahjZV4xVpWFd4Blg
 U9q/GnhKCILchwUlMUyMdDiN1DKxJ6JbZth6Kx6Wse+3mgKpmyNbARGa6PIGw9lOTFQX
 0DYRY6YzDJ7AqNo8I9q6ygeKoWC5dX0iEM84w6HcdqKb8hyLOVQlHFXtjs6GEtZVxd3i
 KlKg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774377195; x=1774981995; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SeawxHzR7oIIWD7L6euV6+64EIJePGXDgqnHC/QlMpA=;
 b=Z6sAEjiD5dk300MdgDVMIELCsJ2T4auLyPeZ4eW2b0ZS6e7PaiuWOIyx3JAnUCx10C
 OW3B+nG7jhnGAt0+79npsYxyp5wTdW+gZ3ytFPESL5N7vNDFMHzW/xCOZ0vJctAm42RT
 QrPsn57xhPF6b9YzbD+PvIF8B7OoB5FWwd+MogMsje2y6+Y+SpCZjf7G029SY1X/MmOQ
 rK+/92zut5ztPC3fizffy1fEGFglvtVHVAPfSCfOTgQlgEBCnoWbevxiJHZZnXRiVoR8
 yDGFVgNJ+UT5R9SRoJtpQy8xIWZzEgU3acRaSN667rFSxZH5uvvrNiUoZTeZwquDRdDf
 5Wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774377195; x=1774981995;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SeawxHzR7oIIWD7L6euV6+64EIJePGXDgqnHC/QlMpA=;
 b=G6Z+dmWjVrCJcdKdht278avC9VCo0kuGMxcMnFyPyX2YxcT5VQ1f4K2Qy/Q5SrZzqG
 GejEcqQJ0AFU2THijlhrDG/aT/tQ97CRkophU80n1hkzXxftWjF46BjzPUYmf8p0ZePA
 HeWmAx/UPKzeyjSgEqECjfZbENQSNt92JGSoU09d+mTLs7WtPhp+9ogenuINTIIZnYuq
 kaDKFA81elb8ARGaYwaOWaDy5w94YR7idWnN2X0hF82pZ0OWW4sBdg5G3V/ZLVqnvAM+
 GkdbY/GkoJ1es193eoAsJhOhg/5zzUnwk+tPV4Ill6h6OEOppSitVFXMd7MleX22QxeO
 XAbw==
X-Gm-Message-State: AOJu0YxxC2tpnZE66/rntXI09ftyyogf3xef6VEOyj2eE5VVyvcEb4ky
 S1UpUoJgfiNJ74DSMBaR4pN/qkXAwE8sNn31W0TenInRwuhd4QhcJduFLgjkg7waELtzt002BL0
 s2WRMMqzDB4erdSOIi5DEkZxi+G2ynBPL6uoMYTuSlQ==
X-Gm-Gg: ATEYQzzTWxm2NXMQPcSd3ZqPa44oEJTSmGsPcUSKB9I4Afpkz9ZDvMiUmQrIJqRLiMr
 C572VuxADx/NW1kqB8/Zd0eD+ZzQXCnrfE9Js3xIpF8R2Po+1ZdEXlOJLatkVP6+x78Z4tycvpS
 X3TpNj/enfZ1xXhwgM4u+ASYWyNKbUcfCD9FNeK2bgAwVmjIhkc8YCk+YLBj6kuaz1bYEbg34Oc
 NLINjL4tz6jOtNcwOXDy1i6l6xXVdlgrsmbZh8XY4+rSSWRiS99lafigzngdsbAT/K2Nl13gcWO
 fZciZWxjiAPy7qWe4dPJWX0A4qo0Yp2DXT4PQRmSL72RjtM77Akd1x2Raopz/p/W60E=
X-Received: by 2002:a05:690c:e05a:b0:79a:67a1:3e66 with SMTP id
 00721157ae682-79acf6fd6d1mr7004987b3.56.1774377195229; Tue, 24 Mar 2026
 11:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com>
 <ef2a0d92-c7f6-438b-a15a-2712e1c4373a@linaro.org>
In-Reply-To: <ef2a0d92-c7f6-438b-a15a-2712e1c4373a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2026 18:33:02 +0000
X-Gm-Features: AaiRm532v5a4rDYc3Z3oozR9YeCBIWO7RYlMkNheOPoHFhRpsGed8j2qjXSqRYw
Message-ID: <CAFEAcA-kk29mjGWLrAGjd9AiAW64v0TvWdedZypSH0i43WgQzw@mail.gmail.com>
Subject: Re: Cleaning up contrib/ and tools/
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Tue, 24 Mar 2026 at 18:28, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 3/24/26 10:09 AM, Peter Maydell wrote:
> > And for contrib/, easy ones first:
> >   * contrib/vhost-user-{blk,bridge,gpu,input,scsi} move to tools/
> >   * contrib/elf2dmp moves to tools/
> >   * contrib/ivshmem-client and contrib/ivshmem-server move to tools/
> >   * contrib/plugins moves to plugins/plugins (or a different subdir
> >     name of your choice)
> >
>
> I would suggest plugins/contrib or plugins/community, to make clear they
> are the community contributed ones.
> @Alex, do you have a different suggestion/preference?

I firmly do not want us to have anything that claims to be
"contrib" or "community" or similar. Everything in QEMU is
community contributed in some sense. Either we care about
and maintain these plugins, in which case call them "plugins",
or we do not in fact care about and maintain them, in which
case delete them. "In the tree but not maintained" is not
a category I think we should have, and that is what "contrib"
generally implies.

> Moving those sources will break build folder hierarchy also, which is an
> issue for all existing binaries built from contrib anyway.
> I'm not sure there is anything sane to do to fix that except accepting
> the breaking change.

What are we breaking here ? Nothing outside QEMU ought to be
depending on the layout of our source tree. When we move things
around we'll update the meson.build and the documentation.
I don't think we have 'contrib' in our installed-locations
layout (tools get installed into the bin/ dir, for instance),
but I might have missed something.

-- PMM

