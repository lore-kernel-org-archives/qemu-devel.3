Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A62C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkOFg-0003KA-Dt; Thu, 16 Jul 2026 11:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wkOFe-0003Jr-J9
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 11:43:54 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wkOFW-0001lM-Rw
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 11:43:49 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-39b3931e259so62170521fa.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 08:43:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784216621; cv=none;
 d=google.com; s=arc-20260327;
 b=G/9mKPrCyrJh5fHCLIWw8T4ND6WFVANTjix1Zh6CZ3Cr8dZVaPiwaU5ec3uNy9bWsq
 T5FRhDBcGJKj5Au5c66xtWifiLijGKYtYnxraCEceorgBQt6CiaPP7gckdz4Uf+afQBP
 yEWuRLIbDMFPvu4Z+m7jcORwTEEsHyArofFSA0PG7ZcVXewLpDNCfV2+1gYgppgwb7pO
 mfzCxokxN8zyCFew5B79Tf8lN/1zWNtGjNJenGZYyMD7eP+XP3f9QjgqPibPE7Gc0sI0
 +riArcySXMKpeo8JuQIVzT/2ezsSswkgpYNOMWzMnsxY3DC2NORJyXCQkI38BFqzaMCx
 M/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=t2R5ffQoZ2FgXGVQvC9DVFqR7MMPZTq3/qNNCDmHGiU=;
 fh=ch309eY2Or78ift7qkjQt59r4AD7D2IMT9oBqo17Vxs=;
 b=jDzwmJIuk8Rj0EbjMgTntr7kF6pXiMGG5smOe+Cs/kYXC6c0DIP91kUD9Bne9t39pn
 GAV/+sOL4hqOi+KTko0FjGjlKvUGnuV94g8KH21BMPYnEMkpM/RSuW0qC9SUDnnqPUf9
 BWB5lW0mZGSi7jxmH6XwaMr1cYzgyOjSyj2Pjg47T99Xmk98fC9RAvncDiBm3HVuLJvw
 51nVWyU87SPX/LluYWUh1e6eu4LhlcnOv/cWy2jiwDVNfVGk/nS7P+YU0LPAYHRK5m5F
 H7sgkpMCLGSv5c6xrkw220umb98JC8lbfTHrKSsSyn7nIY6QqUJiNmdlT6hov8se20od
 Hc8A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784216621; x=1784821421; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t2R5ffQoZ2FgXGVQvC9DVFqR7MMPZTq3/qNNCDmHGiU=;
 b=YPR4gy2wg0NtcENth7dWMBkEJs1taT0RmWWS4D1luKJrNzn5u/N7G2Aus39I63GaLD
 IvFEenAXRcR4qxXdn4N/Cz6Z3HzV/tV5arGvYEphK9kH9DF4Wuh6bP60+Yk1o3+MnJdJ
 dzfSAt9XxiKE6PLCigcztt0L4J7IXac5JgXViHwOYPM0vLW4WUUENUM0RA0hM67hHClz
 6eetUX7OvP2BmbkvIFRguxinD+bli5VGlHDhx/zneDzlilJGlzphxQRLqBXsn/ns9dM9
 oapfzpGAzUJEpRNqUYaUXimBXncVpRb0s3gM4ccpqTHdC1taAOIVqe/zqeGunLS7V32K
 eQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784216621; x=1784821421;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t2R5ffQoZ2FgXGVQvC9DVFqR7MMPZTq3/qNNCDmHGiU=;
 b=gITlu/OgrzhWnJaS3XsjaBc5CiOZ710xH/5gx8gPRERSVANLRlKPe8oAG1AZ5oSo3O
 RAMF3cM4iCh/KQ8agqVJq0lv6gONjI9ah1DmE0OL7glWf0kTFDYLran0rGdDaeSERw9D
 VjasK8IMbAfpG7v+KDx3aeKqNnA+XUpcR8f09AYLx4lcfTbtmwMfik3jwntWNTUu1BRw
 TvwEnd1UiEwNJZfHfjDLkiNtq/mDDtPzRvio4T8JTj76OTbCTUkncSTWcKw7eI1GzbER
 YH3nzDfoTN5MlzJKY0h9oFqtKthFQHKlx8xVpjK18TNVP8uhpC1/0ABF+98IgxD9yP4J
 v0FA==
X-Gm-Message-State: AOJu0YzPOW5qGV6lFfzDvzcMP3Ql6hreajM2xIapD5520+reJY6r4gAt
 zH4Wt/YhburTZednXIajm28FDgkb460mXObEooR+wetuS35s5MrhsE/mSSXYcVXie8XNbO/OZqK
 mcb2XiPBQ5Mmabeg1/TeVJIAyswIBxZE=
X-Gm-Gg: AfdE7ckm8dq2qTiOK5huGxhBsSAwxHQ9aLEAsYQSyCMC4hhSSiJpC0YPTUWuLoEyFk4
 v76o/5aASBB69PSd57MenrT1+YBhHuo1vBN3xxwDt96Es8U3r/yftadd95HUgMOZUKYmOJk+oJK
 J5qRpvUDde/Qg9Ug8Wkdpphaa2KMC8K19hBgQox0Co1+o+inzGetKKTECI40HgnbErkjfdzO4On
 4W+FnFMPjYjKxaXbBx5zsE8qDOhOZkKKvCBzUKO2YjT5QPpoSQ877RpDVs1fQeOhUEjf/NiGILU
 s5KqNUD/ciE5tpeq0v9c
X-Received: by 2002:a2e:bcc7:0:b0:39a:cfe9:247f with SMTP id
 38308e7fff4ca-39db6d68aa5mr17965981fa.31.1784216621388; Thu, 16 Jul 2026
 08:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260713013610.2691128-1-mattst88@gmail.com>
 <9e63ffe6-fa13-4b85-8f9d-5c6d78e793b2@tls.msk.ru>
In-Reply-To: <9e63ffe6-fa13-4b85-8f9d-5c6d78e793b2@tls.msk.ru>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 16 Jul 2026 11:43:28 -0400
X-Gm-Features: AUfX_mzWlihxLj9rs883pkpLvqJdtKeTlqGscMJnCMW0vZLsGbynqpuXPbbhqmQ
Message-ID: <CAEdQ38FwC-ZVSP95BOjXncT-Csue1un3ihqYOogNDGdAd8-3qw@mail.gmail.com>
Subject: Re: [PATCH] linux-user/alpha: populate AT_HWCAP from env->amask
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jul 15, 2026 at 7:23=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 7/13/26 04:36, Matt Turner wrote:
> > Alpha has never set AT_HWCAP in linux-user emulation, so getauxval(AT_H=
WCAP)
> > always returned 0 regardless of the emulated CPU model.
> >
> > The Linux kernel computes ELF_HWCAP as ~amask(-1), i.e. the set of ISA
> > extension bits that the amask instruction reports as supported (cleared=
 in
> > its output).  env->amask stores exactly those bits with the same layout
> > (BWX=3D0x1, FIX=3D0x2, CIX=3D0x4, MVI=3D0x100, TRAP=3D0x200, PREFETCH=
=3D0x1000), so
> > returning it directly from get_elf_hwcap matches the kernel convention.
> >
> > Add HAVE_ELF_HWCAP to target_elf.h and implement get_elf_hwcap() in
> > elfload.c to expose the emulated CPU's capability mask to user-space
> > programs via the auxiliary vector.
> >
> > Without this fix, programs using getauxval(AT_HWCAP) to detect BWX/FIX/=
CIX
> > (such as glibc's memcpy or JIT compilers targeting Alpha) incorrectly
> > concluded that no extensions were available even when emulating ev56+.
>
> In stable 10.0.x qemu series, things are different from what we have
> now, - there, everything is in single linux-user/elfload.c and the
> context is a bit different too.
>
> Here's my backport of this change to 10.0.x:
> https://gitlab.com/mjt0k/qemu/-/commit/e4c1bf9b1fe030ef1d0d4c74086cccb62c=
6b0442
>
> I appreciate a quick look at the result, whenever it looks good for
> 10.0.x or not.

Looks good to me. Thank you!

