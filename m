Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A97EC0463
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxMIF-0000Hu-Vj; Tue, 03 Mar 2026 04:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMIC-0000HX-R4
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:43:52 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMIA-0007qi-Ui
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:43:52 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64ad019bbd4so4788993d50.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 01:43:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772531029; cv=none;
 d=google.com; s=arc-20240605;
 b=UilmDnAr/tCauR301TrFgfWqCuaG6Efd61vDdGHuA9er+qdFKD15t1zxqZNM0CaKP6
 BPWZSplHgGRDt9QFfwRQdfXLLcp2xUAnRigWTdXCloBb5rgVVmpmZfUw9+FUINnerZMr
 0grj+5FukFjnN27pYJXhaibWeMdqso+7DR6wnJbNlF6d5FgctsHLmR72+fQE+zSkVSmD
 yJDBedOmvhL3KnJrUu5Y0JK6G75wR3Z5Xw/jVD0XgKAjAzBqfUwFAObId0wNdc2GQBzr
 ImIEVEhulf/ZYERGUVz0ULwXd1LQnT/X95E04Zknovbqi+lEDSpJCCunfAINUNZfzpLm
 nJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Y1bTjwLv0JGYOy+rdgp84f/qyf4hcN3l3zuABPewSvg=;
 fh=+4lzQaMBfWrqkbnjBGVFOfNZa4niVxbsqWTgtU6L+wA=;
 b=VD2tS5LL5ntJn3sErsiWY6l7YOY1piNatfNkHpOJ42qGN4FZMeeL7iRX0l682so6nZ
 H/+UQFX0CpnUOslT6++2BVVsyV4OVAyqm6LyWT/ibymkoaPdFUrsxn9SNhfqVR9sjE1k
 64USx3tPg/juC+kZgzhlzUP+YCuZ1Y4cmukt7FSc3R8Y15XPuJ578RD0i5VcFkaLF7X5
 OPV9ztBAuWzOPfXXlG/tmPTy92TMuE1gauXhA3qfQDGSeYsUkpCCReyD0Qo68xQff8Ph
 7KM7wupSzIYxSlQ+b465+t6yuuzg/YpnmHW1jmpN4H6kje4D4KH0NUwQP3d/ijuzFJNq
 VpsA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772531029; x=1773135829; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y1bTjwLv0JGYOy+rdgp84f/qyf4hcN3l3zuABPewSvg=;
 b=xiQ6hMlZKa6wC36L7yn4cTqGi+3EQVig69ftGe/AD/iqTqsNP7oBDaF80ml9JMrFE9
 IJPBbOGdvL8h2mhD5cAvh790mw8GUqmtONy5x4oFi5yYhtf+9gLUkERtbJYlLnuLXIRQ
 gszWkQddVO3qCZtvo7RUW4i/VpD7ER1fu/XkiPbolVEYp751BUGoLpPiABFOXHUFuEyn
 oU7ZpvFIO+FsRzODWTTuegrNBEk/zn4slGGYY0wswUFlb9/+clxOgHNDS3AbzgtEp+we
 zNG6BJ63Lb4ILKNuYCEklhkR6tHNGQnLaXw/689cyt3VMduOUcyEva63h2eNGwu2JrNU
 oXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772531029; x=1773135829;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1bTjwLv0JGYOy+rdgp84f/qyf4hcN3l3zuABPewSvg=;
 b=l2in/QqxH+Maxw1jK9we35f1mMY/Vb1lryhgzYcGiZ5Nh3HgFPLM/BOqAx35Ih2EV6
 YJFFeOMnkmJujmClLtc6F7KR7wm+8ul49M1cjJL3GxoJXqj9du1UBdIgZT8KmS+q/0Ug
 /pbPJgCi2RPevNF9KyiM7lZW4pUO+vInT2sb8SEztM35+t7b9D/bsyECbNDPhie0evPg
 mtAqhWxsuozIGZ7WD7ejyBzZt29BccDKq+Zxr64KrDvR0TLi4Fmk45N3VKBbEoka1Hs3
 GdCHN0A9BJfSN0CwlP4xPiWlZ5ca/T3X/XKN+fGaM9+2Vx522Vu0/RE+MSLGud/0IU/G
 a6OA==
X-Gm-Message-State: AOJu0YynLOOPzrf8V0xZr5vhlUdlGBGM690zounFTth3+HFX3esUOjse
 4pFjPg/RoTqiAEo64r6KK4gd5Ny7QxfVqVSSOr+JktbE5bqa4DfjdN89W8zfB9KsdYgXEJfNmpY
 DBcoM9uF7WEpnS3+bjC9MsXR17gUmgqRYdEwlbabwWw==
X-Gm-Gg: ATEYQzyvx6Gh27/YZ4yQryxO3j/NLBjhF02j89xBzZIaHdTdi8iH1NeovYUcsXI9MOc
 SjKreOV071T670KqWBKXgN1E4XCD1dvd4KRgG4Z60xlpizhKcRXVm3nsPI+iC9QnmwBDBH/1VUw
 qqXYC5DAgCODQpVMCVkqs1cLvu1foJlxHzjYavgE6Dy30MlE+SlRwxsoE829Yz9uDhAM9m+ji2m
 H5fBJCGmB2V7LcyXh2YUt4mKU92dbMLEPaL4eg5OmgWJeS2sro1O2caATxiX/lOuRmZHicRrJJb
 wdklYQdojLBeJRsU1OkGYAYHChRAB7PTnBaIG+Cl53Wcr8Tw1IUKTmse7xkKNud03RI=
X-Received: by 2002:a05:690e:1616:b0:649:e9a1:c6b6 with SMTP id
 956f58d0204a3-64cc20e5d1cmr10278614d50.30.1772531029358; Tue, 03 Mar 2026
 01:43:49 -0800 (PST)
MIME-Version: 1.0
References: <20260302042115.83410-1-imp@bsdimp.com>
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 09:43:37 +0000
X-Gm-Features: AaiRm52AfWNGM849qYBc8PZg9NBJgnJsOCyrsc2AYY4fKgjBQJGaxUuQ-FQXf_0
Message-ID: <CAFEAcA9jZEYR1xFCVbjTWF5_bOaSXFVSJ-BAWSHdovgfb0ZLbA@mail.gmail.com>
Subject: Re: [PULL 00/27] Bsd user 2026q1 upstream patches
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, Reinoud Zandijk <reinoud@netbsd.org>, 
 Ryo ONODERA <ryoon@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Riku Voipio <riku.voipio@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Mon, 2 Mar 2026 at 04:23, Warner Losh <imp@bsdimp.com> wrote:
>
> The following changes since commit ffcf1a7981793973ffbd8100a7c3c6042d02ae23:
>
>   Merge tag 'pull-11.0-testing-updates-270226-2' of https://gitlab.com/stsquad/qemu into staging (2026-02-28 14:30:23 +0000)
>
> are available in the Git repository at:
>
>   ssh://git@github.com/bsdimp/qemu.git tags/bsd-user-2026q1-upstream-pull-request
>
> for you to fetch changes up to f0f6eae80fbdfb6943fc5d701118e78f2346818f:
>
>   bsd-user: update aarch64-bsd-user.mak gdb XML list (2026-03-01 20:50:11 -0700)
>
> ----------------------------------------------------------------
> git-publish --base upstream/master --pull --to qemu-devel@nongnu.org --no-check-url
>
> bsd-user: Upstream for 11.0
>
> This combines several batch streams that:
> (1) Upstream the bsd-misc.c system calls:
>     quoatctl, reboot, getdtablesize, uuidgen, semget, semop, semctl, msgctl
> (2) common-user drop __linux__ ifdef
> (3) Remove NetBSD and OpenBSD specific code for bsd-user (hasn't built in years)
> (4) Fix inotify issues on FreeBSD 15
> (5) Fix issues with gdb on aarch64
>
> All of thse have been reviewed, and the only problems with the check patch line
> length and about added files.



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

