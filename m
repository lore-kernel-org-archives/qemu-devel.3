Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96995FB3CF7
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w79ZP-0003ls-Ko; Mon, 30 Mar 2026 06:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w79ZO-0003ka-6s
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 06:10:06 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w79ZM-0002sO-BK
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 06:10:05 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-650182d19e0so1366301d50.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 03:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774865403; cv=none;
 d=google.com; s=arc-20240605;
 b=DG17K7byh3xCpCZxThoSZKC4E4EiyzTAaLJaA3BYF5cbvw2Pvi0GzsK5Qi8ASYG9EQ
 igpSRmycFuL9A7n7rQwYaMHPx0MUEH39AYZUBW0+pDncvmoAWlMzqdmBO9Sf7sFeT/ak
 Vx2gscUKIfaodGUc624V65k1ByGvSdb2MFeve0JDB06G4jjoLodqN0C3l60ulFLzC+Hk
 WIDDaM6dogSCzpXncU7jzIeRksbPv8RgoA50Carltc0xbT+P2WR+tnXSPF9gEScydzQL
 jiQ4ocvYDUN99PcgJp7sVH1M2Y09KRqUsopjb9pPULCD+WRYyeUitXmAbuK3qjnhLkaS
 ZS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=K3opmYsD7dopOYZ/VB18ouJMRAPd9BW6H6/1Qiqeuc4=;
 fh=AjWIacz84c2xLM+drRLbcIvcH3WYzRuA6qqyeMttniE=;
 b=imVnhnz+gOk9wBAuirkVGVk4xF6EIQI5EbcyZNvBbwm5Sk9TE9MrTs0k+9PW1pZZo2
 WFKLjvQjPDSlSc400rm0oNND1M/vw5RO3f5d4zrF+rLPCteEwzFuHwUvnuQSUAGiDEZR
 CDmj9YILT/xiaIaVdL9wThTlaBQZPomzFeGfJLF8R+t18F82Kf2wvTZEHhUpT9/RkRkG
 5eO8Nume4emUExOkPtUhdGs1+5rOyYgxsOOhG8sL0lq2iDhwDObRQAwHvItb+gdi2KyK
 tSP5MRJtBZ9kBXGLXKyldQD5Cyx6+27joN5eqipmN9us4RVMocaD0xfMr62wGqFDFfTf
 c9rQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774865403; x=1775470203; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K3opmYsD7dopOYZ/VB18ouJMRAPd9BW6H6/1Qiqeuc4=;
 b=hCRphnsSbTNyRSMqgcWcyzZaOlsKtsRjvjU++2OV4Dm/poZQFuERrt2sJmyVwruE61
 PE+QFHPHF4ZDNJlu/YMSPiNH8rN48vmRCYzyH8OPxlzv4erO+ijJGF/TpvaXWQtx4UpS
 pntFc5Kgj99ZWc7vsM+4INXGV+X3SWpQb/dW/9zbKyLdpGtYQKYl9+QEgVUOHua5XgZh
 AYDHOzKZfyv26QLT0KMztSVpIFPpNGOdEspL8kWW5CUCZzYhk/30BHwO21C6b1MPYidf
 TlDVa4yb1fFjSLBjfyCfVrPWdFz+5nghTde5VjD2fyWYsxHfD2q27Hqkg8Y3YHZAV0J4
 ENrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774865403; x=1775470203;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K3opmYsD7dopOYZ/VB18ouJMRAPd9BW6H6/1Qiqeuc4=;
 b=h2ZGphEPqhDaIdFHQutsoHycPXCqa5RqNJUw3H+bDhJ3KJ5kwu400M3L7Tlps4rJqo
 tv+OUT+Ly5U79R5zrm46HM9H97+oY+5Tvr3gTVbO6r7iHMlrREugAA1QX+CuL1vSnvxI
 zgUc318iZvIVHpMboiqUsGln+fpCA7iTEpOXy1lYC5SMDPNPiSORlA1544kkb6hQ4/Os
 HMo2rsr52EOJucJcd9TDegfW3syxRrwsKM5V0/p5Gwst3LCRVsQ/2FhwtpnEh3Xl3cFB
 zhlIn1BhjTzoHBriUHRIEzYqrNqR6Era+qpoQYjY5+M/Igeag+nuDRD6iY9h9xxNAIbH
 RQvg==
X-Gm-Message-State: AOJu0Yyt8LuPLvs/ktdoEN+IJhlHvsQz5UHfXOLDGNNV2RXP0CP6vLKO
 tXo1Yat05GebtOzyAxIgIzHHjdHP5PK8C49TTzDZf96ZwkHUZUTxXQV3PbpcGljrWjh4RlkJfid
 GS+BM7QUzkJnEbhbCnstRkJ58zPTpg1b7Ohk+/e+XIg==
X-Gm-Gg: ATEYQzzB31x5xfEPChVx60W1agxxjcfOqZtttUJvIB8ELhO/MAN7lPzj+AjFk8KP/XF
 Vk1LuXbwqskOhYGw6rIE+y2e8tIM0Nq3bUZ03NF0qATxSczsgiwwU0z96hSFI1KlXpw4BFXTBNS
 wCUnA9QW43zaWBcjy9DXfs1B8z2uOxEdahecK2AmCc06JV5cFVjK0QVj3IAGY3GJ6UcsWNS8zFk
 I8Qx9ycFDAhKiEWFGh/BZPgztOinZdyKvCshbd1K1Pq6YHxBhILEFtKBIQPyO6w8UyvrvUruP5i
 U96zgaN/u0iW9Y3N2PaEAOPf553stzK6YMZYS1Bhs/R+DfhAUeP1KiAKHc5Xdb19YVQ=
X-Received: by 2002:a05:690e:1308:b0:650:1485:26cc with SMTP id
 956f58d0204a3-65014852a30mr4877323d50.12.1774865402737; Mon, 30 Mar 2026
 03:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260329113732.482619-1-vikingtc4@gmail.com>
In-Reply-To: <20260329113732.482619-1-vikingtc4@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Mar 2026 11:09:50 +0100
X-Gm-Features: AQROBzBdSZBj2QYMo-gQr5mr2A1R1pc_VSID0ZobgQu4J14VBsIz0Nl_CcFUREg
Message-ID: <CAFEAcA_Gr7yb1Kns+GrLdW7mw=iKdZKJcdR_qh+vtRhe1LS4cA@mail.gmail.com>
Subject: Re: [PATCH] target/mips: save CP0 timer in vmstate
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: qemu-devel@nongnu.org, Huacai Chen <chenhuacai@kernel.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Sun, 29 Mar 2026 at 12:38, Trieu Huynh <vikingtc4@gmail.com> wrote:
>
> The MIPS R4K CP0 timer (env->timer) is not included in vmstate_mips_cpu,
> so after loadvm the QEMUTimer has no scheduled expiry. This causes
> qemu_poll_ns() to block indefinitely and the guest to freeze until an
> external I/O event (e.g. a keypress) wakes the main loop.
>
> Fix by adding an optional vmstate subsection for the timer, following
> the same pattern used by ARM (gt_timer), RISC-V (env.stimer), SPARC
> (qtimer), and OpenRISC (timer).
>
> The .needed callback returns false when env->timer is NULL (KVM mode),
> keeping the subsection optional for backwards compatibility with
> existing snapshots.
>
> nit: when trying to reproduce of this bug requires savevm to work on
> MIPS Malta. That is currently broken by a separate crash in
> vmsd_can_compress() introduced by commit 7aa563630b ("pc: Start with
> modern CPU hotplug interface by default"), which is being tracked and
> fixed independently [1], [2]. This fix is independent of that crash and
> touches no shared code.

This paragraph should IMHO go below the '---' line so it isn't in the
commit message proper.

> [1] https://lore.kernel.org/qemu-devel/20260316194759.22672-1-farosas@suse.de/
> [2] https://lore.kernel.org/qemu-devel/87341zsvmc.fsf@suse.de/
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1987

That bug's been hanging around a long time, and the writeup wasn't
exactly pointing a very strong finger at this as the problem --
nice work figuring out the cause.

> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

For the current savevm-crash bug, I think this patch is probably
what we're going to take to fix it:

https://patchew.org/QEMU/20260330053008.2721532-1-zhao1.liu@intel.com/

thanks
-- PMM

