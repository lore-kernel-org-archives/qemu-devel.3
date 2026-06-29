Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1ED9C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weDxu-0008EV-RV; Mon, 29 Jun 2026 11:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weDxt-0008EH-Ew
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:32:05 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weDxr-0001lx-VY
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:32:05 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-664d910cc75so1192894d50.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 08:32:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782747122; cv=none;
 d=google.com; s=arc-20260327;
 b=brtLMlRAmjB44THVVuoLwAyeO3GdOUfVRJDoWKOiRpGLeFT8+llDBlBV3a0oqme1zq
 eYMgRayb4YqVK5JSGB5cmogf21NUKR2ml2H30k2/4t0YDu1lwIVulHawoQB+L3WBYzvq
 isk0aGXpfrqpdA+WfIc8S8YW5wBlcAYaslyxef63BEm9jxOTNHEmWwe6zxskjWOHtOF6
 Z4tadX5/McXd5osykjMZBlp60aYSaDtJoucc/nN/9uq5IR855nwJOaPmxl7vpDMDE+01
 XeuITOCMw+/i6FW5cZ0lVdqT24UNbaJR82s7r02NuEGMh6Ger1nHJp/7Ls/XnxXsFUOn
 5RjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CoAv2pJkFyzgenNvhG/unQFeb+okYdZcOqZT+ZNdzUY=;
 fh=YoLpMh5YadSd1SUFRuzOwiR+EAmVcwfqZdaYDd98lIk=;
 b=U4OeCPWVGQijUIU4qiS2tDOvF3bVxR1Fncz1DqyaccHBtzB75akTjdF/Tdugyxbbfq
 CREVtYeakasMuwM5hVR+/lgB0oXmPM42bxuKKapc86YXwZSGv7cPbwnWhyokkTk/3kTu
 OKDzmWGybgVeFGjR4yMg5QojawQcXSOTiDxole5jTp2EGmqyFreVyMDrFmw/wMfvfDJ/
 Weo4PeyWI6jruzPu1rPXSFiOJBQ0ziiyAQLH2T7FmvUXeAgWCKHsSJ19NlsMCEeAdf36
 lxQsvHx+1VPagjdmJJghnJglYxJUV4do0jxEmW9RZGzRmsi+S9b3M5FIQznl4QgWFeSR
 nkQQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782747122; x=1783351922; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CoAv2pJkFyzgenNvhG/unQFeb+okYdZcOqZT+ZNdzUY=;
 b=U9zSf4VY6l111Nx2h6d2LN7Ij2VMSsDZBYqNJUKebT3HgYbmO0vBQ6RQFrxZjFcXm5
 ossFHZ4WA5qoO9VfdjPrxf84axT7EZ+9gl+Il/+X+hvKICq7etZjkoZ/rnKyWv0bZwUQ
 KdpzAd1EEo//hajer7p4VxjRwoUGKC+Go9SeiCXlyjSp1+bQ9gVCNBauoo8L5JnP8hf7
 v1uN1BY1H3qmaT2bCHv8ZjTkC89bkeScBn2L+IiwoU7vyqsaA+ap6cg87+hf4Z4i/ty5
 c6lNbWtVFDaqA3eED0xprxpOdLOEGFJo3rKoZIIwHjAZ3SooAGhJqRKgYkS5kr5h3ROk
 KBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782747122; x=1783351922;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CoAv2pJkFyzgenNvhG/unQFeb+okYdZcOqZT+ZNdzUY=;
 b=j16ZRt/d87JvZH1ngzvVvw6/UapHjDHXrjHiBxnPOzJ4++OmXgfJJA1xuOcsZ10ueq
 3SjhuPs4VqnFDZplHqbGwNgo8i+QqTkJjaZ7WePAMgu58tHMzAEYdXNGGKcDAPrPuAqo
 uWfq98TKxcBF9dBsIhyF+xMcyV47PYaEHzcCn/+eRnFmzm5/LfsGSkykeMbXRYqAZjdp
 VrO03n36jowAoehJRCs+pHrx7QbmegvnsxL/u6ejkVeLb5kaOA5/ZMWBz82oEEp6s/lN
 nIYk7EFwBFyN5ohtow0UaTSK3BzvT+I/mbIENJNiEmYrqPsLS7KSEsRVSYNfp8kdpL4k
 9myA==
X-Gm-Message-State: AOJu0YyHaiiCsvPv/FyhZMFMtgN2EF0yOpookXOOLXarFarUjyHM1wQd
 DTQNiHmPG3oRrPOq2zm2iA+C16T1qZfj6050GZgdg+Gvd13pzS0kEjhRovNo6o112ShFDMzx7II
 KkAr+UmH1f/Z03VW6jIC4z8tTVVceE3NJrdP4BBgBeA==
X-Gm-Gg: AfdE7cnY+8i4+8vYSZX+8M6o9mXnosoHmEpPYcPbyii0Eu/09Hm70CIbTp0ZckqUkO7
 rBN/Td7K/4wyns99Jk8+GOCecbpoFGWZTCpBo8xUGlBVJU3fzFv08hjPysimrDmUe61XvS9+aKj
 MRTmB6nvOfgfnYIEMglpzoFX2PSM9wC8ZLqp9w0xOUXKWUMnIxKbiYndTFT9vkzi/K3P2dYgjIf
 C44lmLRv+IoxlTGNbZdfqkt1yrIsZxc16J7HYjUVlz1+bSVq61yT651zTcxY2YHX73GFhCTt6jT
 /Q1Lb/Gm+V+UkPywZG519quVVz/hvASAJZL2En2IrW0E0/FTeY08fdakoKzAdO3gztc=
X-Received: by 2002:a53:ad4f:0:b0:664:ae6a:f0b with SMTP id
 956f58d0204a3-664f9ab36a8mr58486d50.85.1782747122219; Mon, 29 Jun 2026
 08:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260629105837.71103-1-alex.bennee@linaro.org>
In-Reply-To: <20260629105837.71103-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jun 2026 16:31:50 +0100
X-Gm-Features: AVVi8Cfi-E88EJiUJvcIsTTL_HRZ_nS-MZVyc97kLOwvMurqwV7UBqfMDsJMwxY
Message-ID: <CAFEAcA_ok8uq0SinJ24EJK+0ZTMVp=tCmpM3X+331PMRRs0XZQ@mail.gmail.com>
Subject: Re: [PATCH v2] docs/system: rewrite gdb breakpoint and watchpoint
 explanation
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, 29 Jun 2026 at 11:59, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> There are a couple of gotchas we should point out:
>
>   - software breakpoints can fail on early boot
>   - TCG treats all breakpoints as "hardware" breakpoints
>
> Rewrite the text to explain this more clearly and call out the gotchas
> in a note and warning sections.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3596
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v2
>   - made the soft breakpoint section a warning
>   - moved discussion about TCG's unlimited break and watchpoints to a
>   new note
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

