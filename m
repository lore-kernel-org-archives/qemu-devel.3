Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABE1C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 19:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx8AL-0003e3-Nc; Thu, 20 Aug 2026 15:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wx8AJ-0003dO-Ap
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:11:03 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wx8AH-0008Os-OX
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:11:03 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47fecbbafdaso124779f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 12:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787253060; x=1787857860; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Tjwvc11JytmjOIygBxocCPyzqfIt9mXRdAnWAahqAUU=;
 b=zXYG7cmOl0a5nFy1VXyeHoCtsM9aiAXnzk5Q4kmU0VZDGb+ScwpOzZe2uw6QxxeC+V
 srI+4697alfrUk/N+pnSKXnWsM2vVl4ruHilP2dhXFbfCKNIulU/e86WQBqpFnMIjbHi
 tKvwZQ4KYYnHvvjjl0jEQ1bjXnnGnfQmxO6HMMgf2ycd8hoP+tkq8lFUnIVQAYgqbtSs
 6eH8htQ7kR5BAYmU6K+PZTdsgmf5SowiPDh7ochChSlrmq77f19DdiKtZ4zdBEPyQcvi
 tRp2IDDLnTx5ZRqGlG3hjmKOTRXVflzF336uDO7v2SS48Fa0tCaM0tyAWvpKL0cMf9DX
 zADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787253060; x=1787857860;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tjwvc11JytmjOIygBxocCPyzqfIt9mXRdAnWAahqAUU=;
 b=B8cMheG4Cr2Ov5cbvojEPxISR3bRbDx0AJsafdHnt4T1mfFqkW45vqL88IaCO0AsAh
 lyzKM3/UF7RfeExtEhL1aZGewn92NYuLPtoTeVNVmvwWUEtUigrr1R1XPdHExnI2+sr6
 N1sGxGEOF7Gg5QrD1CWplUN8JBmLl33q5zu4wUii00dNX3TQ8L0KoElwacBRcN+paN7D
 JkLKqTb5llDj0RLmjs6viUDjdF/DmVszOMvG7FwDswfd0eHC3JxJsF7ESpUZlcFUNMdV
 lR0Kz2R7x8rYxjv2Rq9jzCPJ8YQtTabjGJMNVYFfx4dXKUjee4zKlpQfnQW7HC1J2JOz
 g42w==
X-Gm-Message-State: AFuF++lWTWEf/PmrQA4g2+81F8S6FYUCcZvQ720Y/AOkQpp6hRKZ1yM5
 WQobKg+ORldfhhJuuIH9S1oeiZYzSnKHG8QpgMrdT1CT+ToDGjNrD4SFlvsth5XvfkE=
X-Gm-Gg: AR+sD116UbSxEG/VPOwNuqksPQHQcfLUpVjKmAyksQuxAnsAeJfpDY6C/0wxp9bUZq4
 pk5X2ou0kZHv78Nabup7Dr66IuWa6vo8xgK6W+EaYbwGXdHoKEEt63RkU/0eLvVqMoJFBQN9byx
 N0e+rUV0QPcdafr2uwj6SKZb5eHczGw66B+8Hn8iBOo2eA9i63t88M8TO+NGpp3CSecb0i8tjns
 gC8QdCG+A8fAtwIvzclkBupJcj3Vpl6b7m5Y2wTeFreHq5enabbMDhvsRpNdfuuMkfYEohgVrwN
 MUILqzewpVpYdlYDh+JpvqTIeexFmikz9Mca2GEIHocdhJwkE5w2XF3DszEoXAlGc8Q66kBvn6j
 mK2NkSTeC4HlRMOL+O3J1OyrKNWaIBHtcGn8FDD7VARq6JWSJaJ3yXJrxlqu+1cQaF1jkWEM3HN
 DNaqqQvUyXbYpLMndabj2i+fFiE9W7KBHv2nGD9JH1CRvmWSC3YlP22hhfvkKK
X-Received: by 2002:a05:6000:4903:b0:47f:90cb:630c with SMTP id
 ffacd0b85a97d-482c0b4cff9mr1862839f8f.8.1787253059781; 
 Thu, 20 Aug 2026 12:10:59 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b7d3asm14008304f8f.23.2026.08.20.12.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 12:10:57 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B90135F94C;
 Thu, 20 Aug 2026 20:10:55 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <laurent@vivier.eu>,  Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Helge
 Deller <deller@gmx.de>,  Paolo Bonzini <pbonzini@redhat.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,  Aniket
 Sahu <asahu1x@linux.ibm.com>
Subject: Re: [PATCH v7 033/104] tests/tcg/Makefile: skip user/system tests
 if target Makefile is not present
In-Reply-To: <397f9e15-8be5-4e7d-8f5d-0eb686283154@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Thu, 20 Aug 2026 09:16:17 -0700")
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
 <20260818192309.22169-34-pierrick.bouvier@oss.qualcomm.com>
 <87y0e2p4hy.fsf@draig.linaro.org>
 <397f9e15-8be5-4e7d-8f5d-0eb686283154@oss.qualcomm.com>
User-Agent: mu4e 1.14.3; emacs 30.1
Date: Thu, 20 Aug 2026 20:10:55 +0100
Message-ID: <87ecfsppz4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 8/19/2026 7:30 AM, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>=20
>>> In the next commits, we'll port each architecture from Makefile to
>>> meson, and it's easier to review those changes if we remove Makefiles
>>> step by step.
>>>
>>> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>=20
>> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>
> It seems like you are the official maintainer for
> tests/tcg/Makefile.target, thus I'm not sure what is the Acked-by
> semantic for a component you "own".

It means go ahead, I've acknowledged I've seen it although not looked
too closely. Generally when a maintainer acks something they trust the
poster taking it forward via their tree/pr.

Given its a temp patch for the migration I don't think you need worry
about having more review on it.

>
> Do you expect another change to be able to send a reviewed-by?
>
> Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

