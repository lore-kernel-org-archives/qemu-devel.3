Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129E4CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa9p7-0000OC-9t; Thu, 18 Jun 2026 06:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wa9p4-0000Nr-Su
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:18:12 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wa9p0-0008OK-Jp
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:18:10 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-662d484ff3bso906519d50.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 03:18:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781777883; cv=none;
 d=google.com; s=arc-20240605;
 b=a5Va7A6vSgO4EIKxr3m4RSczRssT2dCFUC2fwcwplpsKkQqGVJ/EqpOFJTExrI53Ra
 URocmummFwEmO/6sH0y6+YmMTA4a+bvmalNcNahEMtmsGBWtCEqVIjOIHK9q59Vu5nm9
 W6gvhHzyjqEZ/hByZ/QrULcePM+DmcnBp05XhnapHWc0D2MvpkW+X8OooRKQL0P+eoBy
 uUQLOjJAWHNlbOUx9E4RfVPVzjsPbjBGK0pNscqaD/yF03h/f3/KuQKS1uSu9/bX7D7m
 yWOj7KGsf2CUXfclTCQW/E44edc0hsRtnw8LSf4+uxdGenwjRqNyDj/rWqyYY+IA2JOR
 H44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4biI3e+H+eEjnFRRNElJ478o9TT58k6Cx6ZjjZcCIIQ=;
 fh=8vnd/QvVSFmWnnfwwYhiTGJs/61BtskuRGZOYIDAZkU=;
 b=bLMlMHk3KH6m8cLiTT9cWVDYbG1ileyyrY5lSp1JOulQSK+ZNHaozIazm9sSn4esnC
 yPQZcU99LeaaNg8jWT8XPonjHvxh2cqYjocIJ4DJeUXuV0yCueZXhpKzfxc37XXqtA6m
 zsPbePGIibgxKIIjfkUTHO0WknZMfxqEBW9HpAk1EGRtgLGomAnalhkG7JK1BJk6TJEK
 9U6w9H5Nrbf0fvnlbOqfGZyPBfs2E9NuGPWN5HVUgf5yF0lzVAG2bKf5FVEDDYR+MaGX
 Zjn0EBcTCxLjMf/1CZseea7NV0ymA/Z7XBFqte8r1+9zIumHZCOV/tadlEksS1qYBG34
 xIug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781777883; x=1782382683; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4biI3e+H+eEjnFRRNElJ478o9TT58k6Cx6ZjjZcCIIQ=;
 b=bH4l5dej04QhrLUPcxhHIOdkUbJj36OaUGrWfT2le6E1OTcvbCU9GtdQ0pm/8VrDVj
 xrnnnFtTUhedha2P4mZH6/dAK0oAYB2ZcMhVsNfTumG7V1fYqvVemQTf0Kb7+LX2ho9d
 wCzknQ881XZXrM6SyySh0uDN55/XiwfW2caaxodzsqp0INM26cWomzbVN07D5laXv4mK
 tjszl28S8YcP2uTQN5OeRI7sYo3Px7fvUTeNu7zYD1AhkSfrCPbCpZxRLzmnJ/flO6Qq
 UqPSLUJzQQN7KqUk3L8taa6MyiwVFGU9NpKhY+s/L8fqi/KW6PSFNTSBCYEEO/bArYYb
 A5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781777883; x=1782382683;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4biI3e+H+eEjnFRRNElJ478o9TT58k6Cx6ZjjZcCIIQ=;
 b=plpBF7AL9oN59B/3Ycv4X653waXN8zBsxbilIwT5Twcmae5LQe7y7k75AEjHYuopn9
 tQTQEx3Zy3raQ78jY8KMfXEJqPFSiemtyJqu1EtcNZw+M4FY4rPj5eJuJ+36v4gdXaR6
 nSssd1MIcDb5M2+VTcUTwM9OoIHITuwjtJr547bCghg4F0fdXXj6QgHPRn37oZTxTc3L
 aCmT8dXkzjt6zBCGFW8L1wzERYS5pYXmdBVyGUsdd3b3UBexyN9WfIZyongfRKXPzkLx
 qnYdZgPq5yw1PaI+2LImT0edb3TPJSICh+TDoeY38hjnTIUDJMXOdhxXrMwMpvE5Ha+j
 xspQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ktPdpHtGmCKw8qMKJwf9g2HMUfFKK7D7ZGc5kmyyBZ/ItFd8Ryjrcwc6WM/5MQC/iO4nW+6m6HRIJ@nongnu.org
X-Gm-Message-State: AOJu0YxSj9B4RtENBsQfLjYvUjhE0Tg5kJiaTQuy4LTV8Y/XsKJW6opM
 IIyirmREaIs7f3tLKuVd3i7YHNmmmT8YxH4uzUYTO3c+eQcOKxC59f9THvf4heloMomIYGLKFUE
 f0T+XiYQ+tn8iDfI2vZgBwztpyWze7BhfiP9q73PSCg==
X-Gm-Gg: AfdE7cmxhcbTYbJ3DexYE6tNF2EydzFDLcQXQm3ld7k5pNf5wMYp6nSStiCflMUxQ6C
 VeKn2qWcYB+V/cRYPTVS9sOmzZ+19wlBLu2TDZntjpb1QGevd/vNOMzkc0bwYYTdVI7aRK/nIPB
 f/TK+NIUxqbwNZ2QPhoAeGDihgSaj0Y63WhDMWMVgqMGHAYgOBF1WvL28JYYkgaEsv/J3fbgmO2
 pWPrAY7L5kUVJBJFbM2oBGLHWOmSDG06h+w8cwZhAZssJ4YVYTsru14jJ+8Pm2r/0Q7RDTQQvon
 Oj6vrQI4CP9Q28LqMpvGfjbJPPLZpZbXa+4lIrTVHXPfQGfarT1XGi4/tziOz+1nVoo=
X-Received: by 2002:a53:930e:0:b0:660:8253:b836 with SMTP id
 956f58d0204a3-662cb92ae75mr6480129d50.5.1781777883081; Thu, 18 Jun 2026
 03:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260618093615.3793919-1-alex.bennee@linaro.org>
 <42927637-2e5b-46eb-9d25-8315cd36fda8@oss.qualcomm.com>
In-Reply-To: <42927637-2e5b-46eb-9d25-8315cd36fda8@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2026 11:17:51 +0100
X-Gm-Features: AVVi8CcjOb5gM5JtLwhaMA192aJScDhhojp0M1r9Bb6c9w5kj2WFlmtWIzlpqV8
Message-ID: <CAFEAcA9EUJrmdjee2PiLzObN0JagR2swd5x_fydDf6PVvD64Hw@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/arm: use correct base address when setting CBAR
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Arnd Bergmann <arnd@linaro.org>,
 Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, "open list:Nuvoton NPCM7xx" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Thu, 18 Jun 2026 at 11:07, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 18/6/26 11:36, Alex Benn=C3=83=C2=A9e wrote:
> > This should point at the base of the Cortex-A9 MPCore private address
> > space. If it doesn't we will confuse the Linux kernel as it probes the
> > SCU registers and erroneously assumes the system is a buggy Aegis SOC
> > and nerf the emission of SEV instructions, deadlocking any WFE's in
> > the kernel (or QEMU smpboot code).
>
> I'm confused...
>
>    The Configuration Base Address Register holds the physical base
>    address of the memory-mapped GIC CPU interface registers.

Where did this quote come from? Note that the CBAR is an IMPDEF
sysreg, so its exact behaviour varies depending on the CPU model.

The A9 TRM says:

https://developer.arm.com/documentation/ddi0388/i/system-control/register-d=
escriptions/configuration-base-address-register?lang=3Den

In Cortex-A9 MPCore implementations, the base address is reset to
PERIPHBASE[31:13] so that software can determine the location of the
private memory region.

and then in the A9 MPCore TRM
https://developer.arm.com/documentation/ddi0407/g/Introduction/Private-Memo=
ry-Region

you can see that the private memory region has all the per-core
devices; the SCU happens to be the one at the start.

-- PMM

