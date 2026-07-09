Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84381C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whjXd-0005tJ-47; Thu, 09 Jul 2026 03:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1whjXb-0005t1-DF
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 03:51:27 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1whjXZ-0006C8-HT
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 03:51:27 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-698beff7178so2803064a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 00:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783583481; cv=none;
 d=google.com; s=arc-20260327;
 b=CmZ62C7l3aGFuLAUUMrKDmp72Nazc2B/h9zOOqMWqJa+b4RZ/1fKi0hvbAp6C7+6qJ
 ANvTXRjW5GjONqvDrsAjPttI2LEksiyadAnwYCEjiEiMU8TetQFME0x6fa73AVSjnYXj
 IAbuOtpWq8a6MvTALDpc1UhVUsmy/q8+x5wi7AJEIM2uWoyoXxmD293Bn7HPOAU89K0p
 ey8fEE2pzi9x+USMOlcxlWpZS5W3vJfDZgqaWmcks/9mE2uYJALVa9H8NDniiVYJdOwC
 d3CMTnbOSwev3LW9LAMN+ayxhMiud+sHd5T7fT/cf82GPGibC5H20AVoKj6ufYmMPLjG
 4KBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8dBrSKkmodvys/zPmjoV5MOSkM0unXHnQEVpx6UNnDM=;
 fh=3SG+hb5941NSVFlujro+TwWq1xL9yjNERMQxWFYubgA=;
 b=Quq2j9uUqT4knRnNkcD7/lwewxAWU18AtiAV74jjMMKXkzcMRRV1Q63j3ag10uXgLf
 x/Z0p4CTM8J6ASTShHE59/NK7tZZz3sNkyBgGNvbg892R11FkJIrVCueczRtKD+jzwfY
 GqberSkr9qPF4uir3ErNjPOCKoHoZGkAV1h26ZLn/4DgDv88EhA/OFAEdsmXi81lSAoZ
 sOkjyQRwqe68EiP+FFOLIsAKodQHu8EAxu04zucS67F8USRcjE4PCi68E3DjAwTomgzw
 NtcSuA+O5iD4ligtRFiyLtsNC0ZtRUsqOQpeLzHC9oDERN2biPBXB10LHA04nQ9jguaH
 F59w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783583481; x=1784188281; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8dBrSKkmodvys/zPmjoV5MOSkM0unXHnQEVpx6UNnDM=;
 b=royM/e34kZ9ijvyAfQOSY63KoZYi0GJB9AyUABZz3SX2AispbQ7rv046zQhNa7N5Y9
 BGFFyDAVuKMv9BY2dKzGbEZTSKKHWkP0mrQQxZgorbQZVFZ1goBhZnPCjTd/th3CHxrn
 4wqop1aQF5eHnF9ZGaX7doqzYkPyrWFFyfrG+5I72m5NV0Y1YmL+u8yXXeKZ6ePY9zn+
 lmKS1Pxvn9DCJHv8gX8W4Vs7dUQ1FDiruBsMq4rfo/8CvipymdvIEvfcvETwt4Vw7K/Q
 6aJQ40U011nKB2kmMNszQU0MGq7NRXn6hp9wgErLvzPQEG8aoSGtD6Icokbb8KLT08NL
 DICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783583481; x=1784188281;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8dBrSKkmodvys/zPmjoV5MOSkM0unXHnQEVpx6UNnDM=;
 b=Pliodl5NCHcGUDFs4FGhr1fR9sww1GiRG6FOHYDPoNvl2qq2+f0I8l52t5F2rR+ZAk
 X3M+l+xcI8sJYxH0qjkXeCYNhiPhX2xz99N6GEr48H8vmQhBmgg8f1/2iQ2Opedr64mL
 A5izAOr27W+iZ45LngslvDL/QY2Vif25A7wlwQ8F+FoQB/yxiS4RrQZp3mc9b8qQb88V
 Jbos2yLabToSoKCxQlyPPVCeDxG5ahifz7L1ewZ0X7dhd/c19VU2PUK662wsSO5no2iO
 ax1r4kP6ZgmwMVJvFlAnRDU3wBrv8lwA6JGNlZXvG7RqtLJiq0UpjNhfdmz8EjpH21+o
 jFQw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLT5uzR5Qfe2E9mQCbBc0JQdFqvAWmaHUCmb9NvhhTiDEU8jPhNC80Zm3A4vs+hPGk5pBP/zYxgCUj@nongnu.org
X-Gm-Message-State: AOJu0Yywq98/TirmJ6pmaoZMxT9hJddl1eloKv3OA6O5ZPNvEAfHN+Sn
 4h/MFiSRBe6LiCuTZpuSIWYi/S2Vk+j++4z9G/+vCDAMxWfhmziETyqzkx9qKziJaqHCXzOyIJ6
 ZlGICF/M29Dl8WpU/rnmDtPDsCjs0dzE=
X-Gm-Gg: AfdE7cks+fH9csFNbqKqdCkPf7RWGLGfsb54bXU8JM5jINqX+uHE79JrLHmRKu1VM2h
 WZtDi3zPlxmev5lxyT+wGETglRAFRAT8nMDNANFARUKB1CY4Ii8HH5HqooND2CebwBSIqO/vRMH
 A7fdUXlChtBwy93vI2N/z8frrwJo1t3bA/xRoqqCFmPSMVKFRWlDeL2z0VwRWnLZhaoyO5plyqS
 6d5L6NNL+ABSYya64yxXhzf0IoQmqylJR+4+lwJcZEo70eZlK0cNYeMssD/Z3Lzxk6LLn3DSU3z
 DjK4kDzCcAUADO2audmIqi8oJayCkRg=
X-Received: by 2002:a05:6402:e85:b0:698:81d7:b576 with SMTP id
 4fb4d7f45d1cf-69ab4472359mr2181609a12.10.1783583480607; Thu, 09 Jul 2026
 00:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <CH4PR02MB1068109FAF2014DE3A545D5EFB8E92@CH4PR02MB10681.namprd02.prod.outlook.com>
 <CAJSP0QX+aJJKes6zbxKZ0+NEhYydXhK61+cva26jTFw3dLRZMA@mail.gmail.com>
 <ba6246ab-38ad-4d32-be51-51c1c99d2569@oss.qualcomm.com>
In-Reply-To: <ba6246ab-38ad-4d32-be51-51c1c99d2569@oss.qualcomm.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 9 Jul 2026 09:51:07 +0200
X-Gm-Features: AUfX_mz4Y-z3aYQHkpAoNi7jZ6YcCZf9vmMZ66xGWgWvY9bQ6yyQy5R5SpE2t3o
Message-ID: <CAJSP0QV9rQSmcb-K609iSje4VHgs_NK88YXKv5-LtaLGOh-nZQ@mail.gmail.com>
Subject: Re: new roms/ content for hexagon: h2
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: Brian Cain <bcain@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "deller@gmx.de" <deller@gmx.de>, "thuth@redhat.com" <thuth@redhat.com>, 
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "berrange@redhat.com" <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Jul 1, 2026 at 10:21=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
> On 6/30/2026 11:01 AM, Stefan Hajnoczi wrote:
> > On Sun, Jun 28, 2026 at 9:46=E2=80=AFPM Brian Cain <bcain@quicinc.com> =
wrote:
> >> I'm working on upstreaming support for hexagon system emulation and it=
'd be useful to add the h2 vmm to QEMU's roms/ in order to simplify booting=
 OSs like Linux.
> >>
> >> To that end, I think the initial step in the process is to mirror the =
repo in the qemu-project?  https://github.com/qualcomm/hexagon-hypervisor/ =
is where the code is hosted now.  And once that is done I suppose I would a=
dd QEMU patches to add the build process and build output into roms/.  Can =
one of you do that mirror step or suggest how I can do it?
> > Hi Brian,
> > I have created a mirror of the stable branch here:
> > https://gitlab.com/qemu-project/hexagon-hypervisor
> >
> > Please take a look and let me know if you need any changes.
>
>
> Excellent, thanks!
>
>
> I have a feeling that the 'stable' branch of this repo was a 'good
> intention' that does not have a process by which it gets updated.  I've
> asked the maintainers if they plan to keep this branch active or prune
> it.  And I'll ask if they can generate a tag/release that we could use
> as a basis.

Hi Brian,
Would you like me to change the mirroring configuration to follow
"master" instead of "stable"?

> What's the process by which we update our fork?  It has an automated
> mirror process driven by gitlab?  What if we need changes that
> can't/won't be upstreamed - can we make those locally?  I don't yet have
> any plans to make local changes, just want to understand how the process
> works.

GitLab automatically mirrors the upstream repo.

It's possible to change the repo configuration to act as a fork where
you can push downstream-only patches, but at the moment it acts purely
as a mirror. There is only 1 repo I'm aware of where it was necessary
to do this. Usually it's possible to get patches upstream. Please let
me know in case you need downstream-only patches and we can set it up
(this should be a last resort).

Stefan

