Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB011FF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 11:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHK3H-0000yp-WD; Mon, 27 Apr 2026 07:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHK38-0000tn-EG
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 07:22:52 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHK34-00085e-N2
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 07:22:49 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-65890a6ca20so947773d50.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 04:22:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777288965; cv=none;
 d=google.com; s=arc-20240605;
 b=FJjqXDil/LivEQi1LHaEyZoyFITVxSGZr9swRoOYDVcXThwUzJgpQ1tkm3C43dMb/j
 dHXL2I6GWNEYVyLdOY9Cz6XV3yXU4raPOpFqjYiWzmA5fe5Bo0Uma2bJ/o01pIFRockn
 LF3m9pwURN5uHzqgIxwHPxxcdqNjp3bA3En4NE8ov/6DDl0ofG85q6bv8HZq3ff/mN+6
 LCrXmQpF6Kctrx9IzhL0HLXCcL825iuSE4WW12p8zWISdXFMhmuL9Q/KNm5TMhWtPJ/E
 YnFk+Rmbw1uGWZMoRny55XALtVQs6ucJIkkj+QB/y6fIwjaAuhRjFF79aT8BnErf11/d
 ZmiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NKjhzn06sNkk8mjBc0Rnn3sUoHjtQBDdTSKSL9EnVqw=;
 fh=qsSgpkl+6XmdYWhRLMAbTUE72QWsJeCxh+IYdLSlTrk=;
 b=hXNW46Ua3ZOogwvxyrbfXtOebjkzAg3ULlFtkLLROwczAFeF2iEdcTVDMARgRi7pwD
 OI9iBBlGMjrbZ4uoo6766aoi12ave4qaC6GMzRFLEw/qKoXPPAgmfRVpXuPXBPErnwZH
 SvQPep6ROSZ6JE+DMnL8x1xoqUeOctAcgpMubthJhZNhhKZ8N9EgNgERk9zQ1JDG5SDc
 lJkhBUUraghHO/yzpPAjKnb2ubM0UareITRd4lKMrnq9ueIAHCj9977tQgoffCcLjvca
 RcsC5AkKBmP7+ICPpOAvpLbt9QlzdpEVrXbGwqbTS+U1WT5zb1xrdlhi8CisKmJWu8Po
 q0sw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777288965; x=1777893765; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NKjhzn06sNkk8mjBc0Rnn3sUoHjtQBDdTSKSL9EnVqw=;
 b=wPc7xA/mbxIKfseVvwDlIQfj0eEdjjFsUcLAdd6/TBNMNxkOjAjkE0JkhkSgXOMZ3Z
 y5voXXtUz6uua+1q+xaejY89YkaTvwqxuT1QEFPLJvXZwC7V0qJUOFg3CPbkXKCNS/tB
 IbR+TTi6wmPw8Jjn7XavXl2YdXCW3bRSRdN35amSsgO8Y2b+72PffO7aDxOG6WJ7gtpL
 lwLntP1bnP1E1M2qz8BDMOd7LM2HGhWYg9eHkpajNJozV3L6Qxuemh/qoYDD06IEXWne
 EyweralRiTmoxbBqWys9glqaMBTaYRxf9bxmeIiHY3OavMGBDjaFoOZ6jZ6vfq6OKZbg
 c+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777288965; x=1777893765;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKjhzn06sNkk8mjBc0Rnn3sUoHjtQBDdTSKSL9EnVqw=;
 b=geUOPCkae2ydFF+F9QX+/P8t8PJZ0gvJ+OLo119tZIVhHFyVnpzMIjfJxznCqLdaNA
 ji45JtG076QtxorNvR5OqrHrMHJ3hV6BOJ48dYgJm2yrwYGIwxd7nGGC5clePEP9pLvH
 rMiXCLazHj90D0lT3Vmx/uVvPcKtiSLpxXjBnY+x4pLJE7Ooj4SQIEUXX3Cg1qzBnP26
 OqgiI+TrQtOR1PKe8o9nrRCi+JjFV2uDq97Y2oQNs60UtzZw1ETGQWF8tVM7bET6eBlA
 afDcd7f+YA7NROz92TPUI9aIksTjYKuWuL9MfX8O7XTbhfTW7v70R2R0XyOGfNE1Gnpf
 dyqg==
X-Gm-Message-State: AOJu0YwHtVZLac+uQ30I4iiBqOlTIXo5JLqBYXXBREBjZV+Osa3IQZm/
 cuKZh/5qZrNse/+O3kQ0APwdWSey/Z26olZTu7+yVdxFIVXm2L3zPyPSB4ZiuYVp34luwzA3NYK
 nuZjw4FZYOvJVeOzBEZwno0U3LXOiCgMb4gdUDaLkJA==
X-Gm-Gg: AeBDieushO/mG9RPHk6sSrXu+3nxYdbjvL8T6hmZXBAwUjtCH4ujfEaHPwdgNQ4UJqo
 jR0eb99IGfrQ+lYaoB9GWt4+Taqg5RqsjrNXtzBagq9NCjTUdTU/JS8StTWVOJjYLIa4yTmhsjS
 J8tWUra4T+M4ncR+MNlm0B7jyIXkIIsXmMWNoFtwE0OzAdk64C53Op/OKijUG7h31lly+G3V5u1
 qtqUDaTeYjgKiyKjBRG30+Hwb0BmL0J/hq9NpHERw6zTLL1YTM2dHoLW7pAE7ICJvbH6UzQdagP
 my+mTHDXYo8lj0lhlkqTHT8q8wtzS0GXT2DZJ2mo/CdaoPJ5HzdNEly1P8h8iaoqS5zpfrpUa6g
 o1Q==
X-Received: by 2002:a05:690e:4192:b0:652:c12f:18bc with SMTP id
 956f58d0204a3-65310a3a628mr32618634d50.43.1777288965320; Mon, 27 Apr 2026
 04:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260422-arm-v1-1-106a9a9e22dd@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260422-arm-v1-1-106a9a9e22dd@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 12:22:34 +0100
X-Gm-Features: AQROBzADG4QwKVW78l2Y-krxUGH0JZTq2v5PrDXl03f_kk4zSO8vVSythrH3RFc
Message-ID: <CAFEAcA99QzC6D=H8jet0aLrp1BByhOq9x6T8bUJ7SY6qTvoWcw@mail.gmail.com>
Subject: Re: [PATCH] target/arm/kvm: Mark host feature cache valid last
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Wed, 22 Apr 2026 at 13:13, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> kvm_arm_set_cpu_features_from_host() treats dtb_compatible as the host
> feature cache valid bit, but kvm_arm_get_host_cpu_features() set it
> before later register reads could fail.
>
> Set target and dtb_compatible only after the feature data is complete.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> This fixes a semantic issue I found while writing the next version of [1].
> I am not aware of any case where it manifests as a real bug.

We're not currently consistent since we have one check that might
return false from kvm_arm_get_host_cpu_features() before we set
dtb_compatible and then several after. But I think that the
right thing to do is to set dtb_compatible right at the top,
and adjust kvm_arm_set_cpu_features_from_host() to copy
cpu->host_cpu_probe_failed in its "populate from cache" codepath.

That is, if we have an SMP config and we can't get the host
CPU features the first time we call kvm_arm_get_host_cpu_features()
there's no point in repeating that attempt over and over for
every other CPU. We should instead treat the "host probe failed"
indication as part of our cached data and copy that.

On the other hand, if we do that then the practical upshot will
be that we print the error message once per CPU rather than
just once...

thanks
-- PMM

