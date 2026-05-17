Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52628CD4F4A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 15:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOdkN-0002FN-Pl; Sun, 17 May 2026 11:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOdkM-0002F0-1i
 for qemu-devel@nongnu.org; Sun, 17 May 2026 11:49:42 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOdkJ-0001in-Sg
 for qemu-devel@nongnu.org; Sun, 17 May 2026 11:49:41 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso19177395e9.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 08:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779032977; x=1779637777; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1o7AxidePstQIs6QuV65l1w7mXWlpHpS/ki75Cdah9g=;
 b=r/oGBolsgg7m11ykQbxMHls+zQuO8mnXCLLfWJVg9DWcRSzUevN6gSMTVyTEl6hUTm
 JxiNhpg79GNjAWxf2VJQhUUmFDXrH+e5U964eLYLJnrwhU+JBvtsYa6L7weV8b0gLEHD
 kSBtuCf5Kn01One601rUhqycZyDfkYjFreMkLxVrV7u9bEcOvl1A57JTPjC0ytFv7Nek
 9iqHbR/xqyRUBHGDd+mCQ4qbp6Y+kBblBDJSPh0pwQAYyEKeC1xyaxSLPEnaCCUL++a3
 CwB4mFRKXdefuG+iQBc9s9ccJS5ACGcrky39pT2f171XL+EQkq3HPS4qJQuRwbF2ndhc
 L9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779032977; x=1779637777;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1o7AxidePstQIs6QuV65l1w7mXWlpHpS/ki75Cdah9g=;
 b=ETQx+3hfFsSlKrPCwLIaJBUcMiW2tzrOlAjkqa9z1CPciL/ali+3K+x0+5Fz2dR/14
 yjjcrvliUJ4ieXGks/JxY8si4fN9U3IYPeqdUK2PGQLgaKFH3G45Xx0hK3hmYJWioQS8
 KV+EMoLS2JchVviEkIKLEy+ktx5/lwQWMy9mer0M+NGjffMNbWn6aOzSM7OYGnnCFE7g
 mNy+95+p7sefD5r9TSMS52HjpDoS/D+BuSXoYNF38qEWm7JizBPuiaQn9VLHJUdrgnQl
 FvuZWOjj9l+rEzheyVNAmumHgv4XRwEeQNNOsnuIyC9W7tKaMjoRtMpBEd+TdhEPlWD0
 6Cxw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zyoubASeVDlOugZM/4jWbpm3CYFEbEvC0di48Y7lIvvQBNdh8+5wXqOSrLAXg8qGbQBS5JatfVi4e@nongnu.org
X-Gm-Message-State: AOJu0Yxg1gN68FQBBeazib9CtxiSc4o7UxJZLdRdDmMhQMvjSj/fEIiF
 TwFTqQ5eW+URmNwRdcrbkjxRnA2JKmdJUynIebrESEC8CAAwpNue5Fpl7rsvJPecZiY=
X-Gm-Gg: Acq92OENrRmZObX212izoSxfE76iKT89U7IbuvfavJdfoUdC36tIi/V7oRFnJetJX97
 8j14nZA7T63X7zgSAdi8hW8YyEBsRMNPLWfguxgY4XcE5LpR0aZ8/BJetg9IEYKRbW18UaEDEi1
 D+PLdJhBG6dF2oU/i0F1EKFX7CoelEe21I2ZpH8RMRNsw4mVpyPm2vcYZVXNzO/GstFl+sEwxRI
 B6Uj6J6GRM5oVKnt4AqJuqVK4Nirbvx6KsBgm44AVLpVmyMhWS7jfZ2IWeYtse9WgSoGkJV+0ke
 RFw7DSGnp+XS7d03hR7vAfcRsm2EAmVewJ6E3rJN4ciD8bPsQ0Zgl15KwyMNjsXwnHrvjLJY+kW
 BPRwdMHLxXNLclMl+d0L/isd/3EoZgHZYpNgLNA1/z11Hn2CwqdY033GguNIY5iPAhQjysyPSpg
 PFuON0NCnvL8NIBimVINqn9kDEGml4qWNDEwVY8ORGu4uNA1k+4hA1NRcj2ReK9lryng==
X-Received: by 2002:a05:600c:34cc:b0:48e:635a:18d7 with SMTP id
 5b1f17b1804b1-48fe59b047bmr191452705e9.0.1779032977292; 
 Sun, 17 May 2026 08:49:37 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ed2ffdfsm28299896f8f.15.2026.05.17.08.49.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 08:49:36 -0700 (PDT)
Message-ID: <617a0ab5-9a3e-45b6-a0cf-6d11116c4415@linaro.org>
Date: Sun, 17 May 2026 17:49:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/12] fpu: Simplify 0 +/- N case in parts_addsub
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260517002550.321291-1-richard.henderson@linaro.org>
 <20260517002550.321291-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260517002550.321291-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 17/5/26 02:25, Richard Henderson wrote:
> Consolidate the tests for zero and anynorm.
> Add comments for a few cases.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat-parts.c.inc | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

