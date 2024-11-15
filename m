Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3950ED68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBzo7-0006q7-7B; Fri, 15 Nov 2024 12:08:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBzo0-0006pd-Fg
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:08:24 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBznt-0006NK-Hk
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:08:22 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5cf8ef104a8so1367054a12.2
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 09:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731690495; x=1732295295; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xEztyymN/5RLgE6ZfeIG0HjojZRRmBc3K3JhZw7fk1U=;
 b=tNP4BpI2IJIrGxspm1+tEkZ93Dtf2WBqaIR9XAPTmL9vsNL4XsGohGdU9r7Ngg3ZOl
 L3JQh3U8kBsO0EW0riPaf6F6RmRkpMVUPrH87g4BAkj04zJKU6hggLUbRTGuV4fNmY2U
 lNbttIiRXPOzU0X1G16o2CQ7jfBy9YY41/jwqvpuoZZpas2PNK6v3+RWr+NM8GE6mNQS
 x876F3otKeZ7cPcNAFHCpYvWKpjg4JKSWT3dvShwSVho9HJcUDVxTRikZLPHMXDfoBDn
 Ekn1JD988N9JeNkzwPpYn3ZWx3igDz2OTz7DnT8inrzHlHg+OKRR2WChAv6+FPKnABE7
 Yjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731690495; x=1732295295;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xEztyymN/5RLgE6ZfeIG0HjojZRRmBc3K3JhZw7fk1U=;
 b=mDWrUFgNCgYylbp2tIMxRnEHP23uideY4eWdkNFH+8EBlkMQazuaX8IDgfXbXMKqSQ
 rTzLGmDoI0fGdIF3PGLK42qijtYvrNrzt2j+aW/1tzblYUPtljdgVQQjRbHo/aCXUWMy
 yRpxr5c992DAaKixgjIMiv+HgYsfE55rQ5+f5/apg62ixJ9TCepmNoyE4H/57Fg7oaPp
 hAcW+DuFdJuYQ8LrcHmvFlgMiLjYrOlpJFUDkYvG3uEB67S0APINz3jcYAlJZcNP6Mq6
 17eaudvPUvC7nk3MM/EXzGc9hV7bU60+c785ybejWgbq7/cSgfvlmBjFzw7TO5XbVTYt
 zrkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYcR6ojpOxkMMgEAmErrmx6u0As+zChvR5uxy9XeqLbh5lPsHh8m7D85t9tZqwrHxpNVLHQra9Dj20@nongnu.org
X-Gm-Message-State: AOJu0Yx+Pe0pOeK+70g3VZLNJ9hAT2+FJcWho4OjtS9C4qn/6bvn8qiQ
 xSjRr9zMPPlJqdhxQtDRXH+zetujjqXEtf2jP2DpDQfQW2rhBeiZOh892ZAH3v8T5VmJDuWMXl2
 fbpo7ak531LaQ6hge47jNw9iHmRqoTEjmAkajRbeRBX5LmTVQ
X-Google-Smtp-Source: AGHT+IGsX+TleTeQJyVRSKKWhfoKSR07jmELEJUPT4hCnVyutNMJSL3+FszO7yayxV5FdsjynAN+jB5bCTjZLJm65OQ=
X-Received: by 2002:a05:6402:358b:b0:5cf:9039:84cc with SMTP id
 4fb4d7f45d1cf-5cf903987d8mr1966324a12.1.1731690495578; Fri, 15 Nov 2024
 09:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20241114165900.6399-1-paskripkin@gmail.com>
 <20241114165953.6894-1-paskripkin@gmail.com>
 <CAFEAcA9i+YmGj5tznoc9FQkDQKqN4vx_0grOjh_ZFGyj-aPgng@mail.gmail.com>
 <6303c5ee-e6f9-48f7-9cd4-f78680c2e785@gmail.com>
In-Reply-To: <6303c5ee-e6f9-48f7-9cd4-f78680c2e785@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2024 17:08:04 +0000
Message-ID: <CAFEAcA8cLSXYAcEjE97RucH1fz+Y4sB2_e53apVf8HZGzf2q=Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm/ptw: respect sctlr.{u}wxn in get_phys_addr_v6
To: Pavel Skripkin <paskripkin@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 15 Nov 2024 at 16:54, Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> Hi Peter,
>
> Peter Maydell <peter.maydell@linaro.org> says:
> > On Thu, 14 Nov 2024 at 16:59, Pavel Skripkin <paskripkin@gmail.com> wrote:
> >>
> >> get_phys_addr_v6() is used for decoding armv7's short descriptor format.
> >> Based on ARM ARM AArch32.S1SDHasPermissionsFault(), WXN should be
> >> respected in !LPAE mode as well.
> >>
> >> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> >> ---
> >>  target/arm/ptw.c | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >
> > Instead of this, would it be possible to have get_phys_addr_v6()
> > call get_S1prot() (replacing most of the existing open-coded
> > handling of PAN, simple vs classing AP model, etc) ? I haven't
> > looked at the fine detail, so we might need to tweak get_S1prot()
> > if it's missing logic that only matters in the short-descriptor
> > case, but I think that would be better than having two places
> > that need updating for new architectural features.
> >
>
> I also thought about that, but suspected there was a reason it was not
> used at the first place.

I think it's likely purely for historical reasons. The
short-descriptor handling code is older, and has
had to change less to accommodate new architectural
features. When we originally created get_S1prot()
we were doing it as a refactoring to deal with
increasing complexity in the previously open-coded
handling of access bits in get_phys_addr_lpae() and
I don't think we really thought much about the possibility
of code-sharing with the short-descriptor codepath.

thanks
-- PMM

