Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC801109319C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Vzp-0003CQ-G6; Fri, 20 Mar 2026 05:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3Vzj-0003Bi-AH
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:18:15 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3Vzg-00051f-Ps
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:18:15 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64937edbc9eso365167d50.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 02:18:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773998291; cv=none;
 d=google.com; s=arc-20240605;
 b=UwvoxL9PfdKqRXFifgWpbjbRFl1TZAHQLb/DW/2h4YtYgZBz0ZqB9JpLceP0q3dUwa
 ZQhbFaVD4F4DTSG52djKuAIEjY/Gib/3InP3xNIaKVzkSoIWUfSNW5OP/q/KLBr6bzrx
 baJZVNTmWryioekH8OjOzBaZNvYcvrDc6jZK3e4+2cfGvbvJugex6uyJxCukPRteRlgS
 7P6TQDvQzQwnMTx3s5uql59Q5l5RiRDdfe208ZfM/twfhQr6BcYUt36FevWfQaKxU1iP
 YbtxH98j9Z/HBhkFCtKSx846USttj2l5wWYC0BFTcKPN+gcKHxfdeDf32hGZP/ORFEjl
 QdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=l4Z7aNuRjzUBmRND1DHS7Om+q5WS6ASYWfNDtxCuz/g=;
 fh=WibSQDncNgWSyywKvPHAKYpHRJ63hQ7/by0Ly3U6FhU=;
 b=beeP9DhA5XvLp8XTArPOvzqiCfSVw4ryvQC/7ifYUmaud703LCrQpQhCiyJlDJNPH0
 T/3b+WaWB82JoM/ZpmSx1jvMg430BzTps8t0hxWYsqRJMMCGOjlMByNz4THH9ddbzsHS
 tPeiqOSGEJtjuAOWR303SFAzbutys0R5citMsGndmAAXeGptr+2CSAcbTqN+xm7Nr8hm
 pxmlzyt+HW2jPsFi+Xd00J97pphm8zaYFHnMxKEQH8mcPsGOH8ImnKIHbVKhQwMSP4HG
 JJunjvzBBGD5JjmKVkSD4YrouB4AYyt4Br8uNipcK8dDIxmSOnfPEoVHhajQfeyCq4So
 Rh/w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773998291; x=1774603091; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l4Z7aNuRjzUBmRND1DHS7Om+q5WS6ASYWfNDtxCuz/g=;
 b=DZwEtEj0pJc/tfmGaOZ3dQhwW1xBEIyLTHE3WsoyyTrYYUEr1ZMTyc20Ew1ZsYkCm7
 junaKwjXh0IGMiQBtz9YPSKp3iOr80gsoXAoDK0qDVxo/nW2PbKTheZYMR4UrHwJaq1W
 y3Kf+b7a9LBoE4lsyxPJjc4OEn2cKxcf5Vmi8qs+fvJ2urrhhybGvtU1fyREtouutR/t
 JPIUSQX1FEt7MCU1trIU8Kz1gYqOT0ssjFp4Pyl5zTe1vcg2XvsiNFnRTOAirYLNeyqt
 nNYtU9RO4UK6skSqe3L3kwXqMMbBtbWFE+kY2SvVXt9Ca2olwNmx1ktwrOk3ven4zCu9
 mvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773998291; x=1774603091;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l4Z7aNuRjzUBmRND1DHS7Om+q5WS6ASYWfNDtxCuz/g=;
 b=XfVx/15x6ksJihLqhuiorcYhRAHBEHVCHxOtaALd7ZgwxK0pKcIvI39Qp9kfiHWjlF
 X/CTzDn7nM+Y440xTXmYdCT8bkcFxsGUrDten37/rnzrFIz3O8K/ypPUNB9+sVqoe427
 Zk5Pl2BGwW4VvqWkJ1x2xYWaff0jWu+ySmSjonzgW+fMU/rawlltfPGVGMf1wgbmPxc9
 iJRjlQxP8tiqBfBcT4h8SRjRXlGalBo1BUWxMUEi2EkYd7+flU5G+G3odFYnddlXZVLQ
 vQom4XOBXNPOu76dGbmwpC4w4BP7LPmMVya+pGFCMVdGZWaPkA4IGaSEWyDnFimIyPyK
 Za8w==
X-Gm-Message-State: AOJu0Yy261ndUGUc5Ia2qG4c87ZFp+A5aPiAnFGMkWn1MW6UxTce7rqE
 7CrYIWzWNlo+PtcuhGqcrXEJzHx6JLtE/MQuraimT9ZaQkfKS3MawKKPu6qFGCpoGTPMtMKPDDf
 Q6gpRQgWRJuwTz1gOyJQJ5KHbE+fcNFd+DGHLH1WeKQ==
X-Gm-Gg: ATEYQzz7LwzLCkjiqxcl8Epdzl/WhiUvvXXZVli9RWo/wrAstq636XZQu7XDcGewluk
 ONwpWI8FKBvkf1bumj6CVnpiDTSCFddSemnkFp7McWzEqrTClqTl58OznGAes0HK8XO/QZqZsDb
 EUjjUx+zptmxv7VtUudVTKKui7UQoJ/evq0p0dyFG3dZJVX+0+J0joFPrQhw4t8sWN81hwhlo5w
 pbu7T0XCSSZmrxxZ3hL/BsT540L95DpacyC72lM4k4lAMVaZCRKqxfnHG23OMgZsKxIfj2sFWbC
 d2W9HK4ZuIPiXiezGE6dY+0eexu3741+J1cBS3DAo7ps1mGppB2iQDA8gx8dSDxdHMs=
X-Received: by 2002:a53:da51:0:b0:64e:885b:412f with SMTP id
 956f58d0204a3-64eaa86cf57mr1833154d50.74.1773998291472; Fri, 20 Mar 2026
 02:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260314221529.47841-1-mohamed@unpredictable.fr>
 <20260314221529.47841-4-mohamed@unpredictable.fr>
 <CAFEAcA8v59wSwRvig6NRjWHyvBGY=gPhWFN1B_jD9k+aXqo9Ng@mail.gmail.com>
 <4387E53A-E140-48E9-80C3-721F9C0B9A9D@unpredictable.fr>
In-Reply-To: <4387E53A-E140-48E9-80C3-721F9C0B9A9D@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2026 09:17:59 +0000
X-Gm-Features: AaiRm52U5H1VAFgWENUse7TnvPutr7-mdKyQN69nWTB1e3TKSviiyWfJY2RaKG4
Message-ID: <CAFEAcA_wVD+mMFhwzDyHx1pY_aMtBvdHjZqQoFoniM_JUCcceA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] whpx: arm: enable more enlightements
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Thu, 19 Mar 2026 at 18:50, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
>
> > On 19. Mar 2026, at 19:13, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Sat, 14 Mar 2026 at 22:15, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
> >>
> >> Linux uses AccessVpRegs without checking availability and panics if it's not there. Expose it unconditionally.
> >
> > The commit message subject says we're enabling enlightenments...
> >
> >> @@ -953,13 +953,15 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
> >>     synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
> >>     synthetic_features.Bank0.AccessHypercallRegs = 1;
> >>     synthetic_features.Bank0.AccessVpIndex = 1;
> >> -    synthetic_features.Bank0.AccessHypercallRegs = 1;
> >
> > ...but the code change seems to be removing one as well as
> > adding the three new ones. Intentional?
> Hello,
>
> The AccessHypercallRegs bit was set twice - with the first one being two
> lines earlier - removed a spurious one of the two.

Ah, right. How about this for a commit message ?


    whpx: arm: enable more enlightenments

    Unconditionally enable some more enlightenments for whpx. In
    particular, linux uses AccessVpRegs without checking availability and
    panics if it's not there, so it's important to expose it.

    We also had a duplicate line where we set AccessHypercallRegs = 1
    twice; remove the duplicate.


If you have more rationale/info about the other two we're enabling,
that would also be nice to include.

thanks
-- PMM

