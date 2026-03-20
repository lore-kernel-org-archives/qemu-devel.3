Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0AF108B8F7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 11:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3YMO-0000r2-Qb; Fri, 20 Mar 2026 07:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3YMI-0000pw-TP
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 07:49:42 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3YMD-0001EY-Ds
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 07:49:41 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64d5a7926cfso2028006d50.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 04:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774007376; cv=none;
 d=google.com; s=arc-20240605;
 b=Eany3YRAXFarov3OqrKGk4hsY8Q62Ji5X5YEHHG6AoXjQxtXzuMCc/3ALXbop19KRx
 vy5FwX01Um+9jy0YlaozltTd7+gn07ypul+DQnBnbwup82vq8AjLnA7gx4nkS3PTZnHq
 0wmGTnIW4o6fvIV8f9/kG/nCowgqYhVygy2uaGm4LTr4Z/8//1zeXvLQeSCDWn2/a1iJ
 FZPTCxE7CB9kE7UZgrZ1uuN7PBDj6+uveglP4JpgwS1GJYPNbLug+pN6qwzLu65yCBDF
 IB7B/WjlwIPkvQYEBLlh2dHtZ5WLzBuuPue6DqO/Tya11skPigqWr1IG90huRFacC0l7
 VcaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fb9ytM/y0hoRFfJW+Syp8kwkmbhECMVJMFv4RYlul6U=;
 fh=kMw62p/HLqf6b5lD87Y5haPqtGefAR8biFg3XNGEb8k=;
 b=X4akexhsX0A7htlHanvtSUX2lcHLo18fYf+h5Jt0pEbbUiJVdqTajFG2zbjg5wDF4t
 IHSmgbu6i9iMHUt+0lIseVDHZjSMH0eMZ3wBZhmug6R0Pv71fdIDDBsPKtuXC6xZfXY+
 nr06SDznsriSWgYT8jScwSoCjH4Ym4VNHqueAQyezFyAE7v9Lecr3EwifRVjbbchinH3
 TY9TnInlj/5ZbUtfMHeeqPY2KhfzQHi71RVXms3bIAZCdH+7x8X27YUSggdzHj18B8pq
 xzeuPCgxyM4bHNbeT5Q1vjsqWwSvYi4u7j0ByOsFJ7OYWyhzexju+mp+NmhcpRoG+ixc
 6/wQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774007376; x=1774612176; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fb9ytM/y0hoRFfJW+Syp8kwkmbhECMVJMFv4RYlul6U=;
 b=OGjZr+XlnDg1ZDTsJoU6PxDoWmSNQoW1XrWCgChHv24URDzLFNkxO9koKMR21KfzBx
 efI9ISgZLxkXMp0s1rsvlWvCgk4jAZbUVOORX/ajF/UGe+dWvd5DIF4cUH97eAc8ijSg
 F8KkHDI0JagpMbk7U8Vx3EFFYMh91BfJ/bP5JLxEDJHrb7MKzYAzHrsKOXeWshy2LtCJ
 Sa01kcDlHJU7TaxOFSiE5wzfYSGVizYbvCQ2UIdNJfvfhkPH1Vki2Ryw9a8Q44LVdE+a
 dNhnu1q/YOrDGFXojcrJKsBX0d9mIkwMvb6wJQwOW714INkrBkEDjFTr784SuOYOXPxD
 0U2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774007376; x=1774612176;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fb9ytM/y0hoRFfJW+Syp8kwkmbhECMVJMFv4RYlul6U=;
 b=dDU/kWIGiXp5X+EGkYruUhr4DzA8OhM+dl1hDnXrBNByIl60j1Df0wRLiipvH8af+p
 aD2gZ6+jr5Qvw4dvWXr6Xy1v3m+xFssqgyO29tH60RQu87vhZcQNN0NkbZlfM6Kq2d+p
 akBvO23eY9+9wz8CcRaAGOZBhPBuK0OLfVdWhO10VOOGBV07D+9E7XAOW7AWuhT95C0H
 207xQ8UqVQdOJHVZIQybSxvqnlWA8n51YDmByH/E8vrY95HhiJPa96OdiuTsvuC1JXdU
 5884S3hp3JCdPF0MXtlZJsJxMNZhHp9EBMPA/+mr3d1rKcwQcYKe9jAIp0FTPb+tAeNw
 iVnw==
X-Gm-Message-State: AOJu0YxtofMReJbpb0AVLCBbZIdHIi0SMKH0Bx4cBmmmMbEmQlmg7VSo
 LtvUQ65us21yhxF/Ak0pfmdawdO/T3YvVK+dK7U1WafxQq8ls2BHBY9heUitUuptt/N4JEObY5B
 f0FyX6L51fW8mdzNWG/vlBNtODoXAz0A36ghZQLUWqlUfXABFf1Xb
X-Gm-Gg: ATEYQzz7koUPcvbXy4enx+i0UoBaKJ48rfAcPAGFP1vwUpFDrp7pg9rM1THFuakQkim
 2ve/l+58Dmd6bSPcvTLiDTG8uBq+NE89ik6lxpdQeAhgzKnTkES85Y9/43zMf3TvesgMYI56fcu
 g+dKDsCXx3APQjOGJg7XlBimwoIiy+jLhXmeyLBNVdvwrVNFJdlLwD2Ouf930fBgBGlmhqHGVcF
 PhTarsK9Ngu6xWqVyh82rFlr4ttJamva6t2NE2FqLJeTv6tuSBjRhorvhBDIPser/ufiT2IlUjh
 4XWZLkhBDh++q8vgaI3+GpOWNW9AW/sAEWhLDr9InyGkj/Xo5TmRvCiQKdmX7M9itMo=
X-Received: by 2002:a05:690e:74e:b0:64c:f1d7:6356 with SMTP id
 956f58d0204a3-64eaa7a4653mr2199907d50.42.1774007375783; Fri, 20 Mar 2026
 04:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260319211239.7902-1-deller@kernel.org>
In-Reply-To: <20260319211239.7902-1-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2026 11:49:23 +0000
X-Gm-Features: AaiRm52uJb_OXiXe89oiSO3VfmpseeBVt24AQzmrrxdkVCV6vxcY22QqxAHcEug
Message-ID: <CAFEAcA-LZvEHt0d9BzeVcVhBfQh9v3iQQ6MOD3NpEc_XX0S9RA@mail.gmail.com>
Subject: Re: [PULL 0/6] Hppa fixes for v11 patches
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Helge Deller <deller@gmx.de>, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Thu, 19 Mar 2026 at 21:14, Helge Deller <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> The following changes since commit 559919ce54927d59b215a4665eda7ab6118a48aa:
>
>   Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2026-03-16 13:07:33 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/hdeller/qemu-hppa.git tags/hppa-fixes-for-v11-pull-request
>
> for you to fetch changes up to fa2d5d84e023d79d1ad35b952c0f9a3aa8f442e9:
>
>   target/hppa: Update SeaBIOS-hppa to version 23 (2026-03-19 22:06:49 +0100)
>
> ----------------------------------------------------------------
> HPPA fixes for v11
>
> Some late fixes for QEMU-v11
>
> Various fixes in SeaBIOS-hppa and qemu code, most importantly
> this fixes boot of the C3700, which broke while we added
> support for CPUs with 40 and 44 bits physical address space.
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

