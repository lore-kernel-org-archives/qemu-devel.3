Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA9FEF070B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 05:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpJNu-0000zi-3J; Mon, 09 Feb 2026 00:00:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpJNp-0000zF-Db
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 00:00:27 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpJNc-0005Wx-G5
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 00:00:15 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c6c444e89bcso1429182a12.2
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 21:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770613209; x=1771218009; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BGE/+xwSc4Hh0s32nfOa3ei12tI+LjHdNW7Uiw62Kqk=;
 b=R17GW9OvHihi6n2qIxpli5IhE0JbwewpNMYSx5KueCdFL6LulAJ15iPDU5eZJ68QHn
 5NCbqXtwzbWA11j2Raz8iQt72rm5Bn6bjIAiwVb8Qmq8TmzAjcwnkpBZnZClnuzCAF5I
 B01JJryRIF+x1D4CzIoWvoOtBGN4hH0iTx41R+2uYIcegQwr0ZzPX/0VKIxhp7Z3STZD
 FcNuwg7gpXhZIWUwPxwWOoQmqdAXV2XVrA9l2nkcIytQh74T2Dj2SLT5SWhMdJlSYqsZ
 r4yNOtUWTo/X0LPLU8o5zU//Nx2wAW9hOTOTLbmaDwGLdQB6vTr0IKdSdzFbNGVOfV3Q
 QjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770613209; x=1771218009;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BGE/+xwSc4Hh0s32nfOa3ei12tI+LjHdNW7Uiw62Kqk=;
 b=RCmgS3Le/RdjcNTxAL8Lna5i02EscdiBHUeY+HyrzX1QunZDNq/RUhd2Xmifv3kKDC
 TUcQTc0yIYLsMjFLxr8xzLJ/M3BtcS/JwRFjJGvYdS8LcflpT0U23xdgU16UUwOt1enS
 JoUGy7icGxk2caRvwkcZ2aVz/vBi8y6P9UoFvcgn4OGHqWsAie2Yrspe2FntEIlg+4Kd
 i7eg+cx9uzgBVEs95BVgWZzNmONKfb8MaxpWA1SvlQxBjuKSbQikxdLN0+JGft5Fw7xU
 Hn+i5cojJJ7VCOSIWQY06TR29Pz9x6Mj9RdIaVdg1/LY0KfwkBVG5LZEYDIShf4JXhFI
 a/VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRGu4LeXW98meEEEGGyzAzaXRWlYRpdG4LbrlkyGzWt/uMT3620tbkreYTSlkZU0x9hDb2X3KBRn8t@nongnu.org
X-Gm-Message-State: AOJu0Yx4ZerG0mq9TY0BZbkYyuvTZcHOvWdTrEsSAnCGdH2xU6HW09Ll
 s1Fb//oMCwj7QbOAgf6Tv6T+9BhBScZ87bQBpMdAPnJxmH0TwCuzkg9EMdHBlStMfMs=
X-Gm-Gg: AZuq6aJOGqdypxzp1nFhY7qONFkqS5kJnRARYj5mNFYr8EQAwwvASd4x8Q/YfuHk6Us
 vjs9XRddB/IHRZnXiMF/xEshpgO26y71zvK7uWo43MinU1hS8UForuN4eEfXUjRCI5mBbmeCXkN
 Uch5DL5qylND0moOHboHgbMtMTOzH0J56x2UnAKnSrwE769gULzz66syWpln16ZtvbDZ3GVVQsY
 NtrqXJEGWQIScLJd2NEWhWL/QHH2XjnkVGY4ZHq9r0sOdbIRsh2joe+0h9BNhAgMMgiqDa4W65q
 qyTdzwS0CWhI6/FBIMDyDEpsfS3uxENvTnOP5uAEN935WCjCDVnS+U/7J7S1tcKLMIh+DoCIyH6
 myJiKnjnfEqOExJlBwMpQvqWS0e8BCqWotIMTGrVeGjxySSbWalU97+qCZsiivHHoX6JKaEQxnT
 0muAuZrJXpyx3c16r8Rhda8Sj0HgEz83K+TqvwpiDDB0cMX/t2qNp1mNXrIKPVuORXgbMAgFOd0
 Q==
X-Received: by 2002:a17:903:2ac6:b0:2a9:cb10:42b with SMTP id
 d9443c01a7336-2a9cb100973mr62690615ad.44.1770613208567; 
 Sun, 08 Feb 2026 21:00:08 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:9c4:a3d:914:f9b?
 ([2001:8003:e109:dd00:9c4:a3d:914:f9b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a952217ffdsm104199295ad.88.2026.02.08.21.00.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 21:00:08 -0800 (PST)
Message-ID: <6c5eb308-56e6-487a-ad7b-8f0da70ab7cd@linaro.org>
Date: Mon, 9 Feb 2026 15:00:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] target/arm/tcg: duplicate tcg/arith_helper.c and
 tcg/crypto_helper.c between user/system
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Jim MacArthur <jim.macarthur@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org
References: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
 <20260206042150.912578-7-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260206042150.912578-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 2/6/26 14:21, Pierrick Bouvier wrote:
> In next commit, we'll apply same helper pattern for base helpers
> remaining.
> 
> Our new helper pattern always include helper-*-common.h, which ends up
> including include/tcg/tcg.h, which contains one occurrence of
> CONFIG_USER_ONLY.
> Thus, common files not being duplicated between system and target
> relying on helpers will fail to compile. Existing occurrences are:
> - target/arm/tcg/arith_helper.c
> - target/arm/tcg/crypto_helper.c
> 
> There is a single occurrence of CONFIG_USER_ONLY, for defining variable
> tcg_use_softmmu. The fix seemed simple, always define it.
> However, it prevents some dead code elimination which ends up triggering:
> include/qemu/osdep.h:283:35: error: call to 'qemu_build_not_reached_always' declared with attribute error: code path is reachable
>    283 | #define qemu_build_not_reached()  qemu_build_not_reached_always()
>        |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> tcg/x86_64/tcg-target.c.inc:1907:45: note: in expansion of macro 'qemu_build_not_reached'
>   1907 | # define x86_guest_base (*(HostAddress *)({ qemu_build_not_reached(); NULL; }))
>        |                                             ^~~~~~~~~~~~~~~~~~~~~~
> tcg/x86_64/tcg-target.c.inc:1934:14: note: in expansion of macro 'x86_guest_base'
>   1934 |         *h = x86_guest_base;
>        |              ^~~~~~~~~~~~~~
> 
> So, roll your eyes, then rollback code, and simply duplicate the two
> files concerned. We could also do a "special include trick" to prevent
> pulling helper-*-common.h but it would be sad since the whole point of
> the series up to here is to have something coherent using the exact same
> pattern.

tcg_use_softmmu is a stub, waiting for softmmu to be enabled for user-only.
Which is a long way away.

It's also not used outside of tcg/, which means we should move it to tcg/tcg-internal.h.


r~

