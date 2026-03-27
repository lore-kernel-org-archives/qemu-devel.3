Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96AA10A88E5
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 14:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w67vH-0000dC-TO; Fri, 27 Mar 2026 10:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w67vE-0000Y8-1G
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:12:25 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w67vC-0006Er-8n
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:12:23 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-65005a8840dso32490d50.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 07:12:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774620741; cv=none;
 d=google.com; s=arc-20240605;
 b=iEhkQbjedZ+UHeLUB4AFLEgyYOEbfj4hyCy9YJ73wDCiG1DctFM9LxwsJL4eNHtBG9
 e3zBZvvyDcw4iptUzpidrJ4TyiqGkt/nLj+IkGsLW8azFTC1XkZSDdYI5FJaFoOa9zaj
 r7cQNPmwUmzUrYtYCGIrSGjfyRaRE+rXTo+hRuG9q5rBBd9628zWxVL6xXNJ+oZwzoJ5
 Alhc+pswJTh4Fl91KARTB5+pX94v/FlQ0m2YiM5ClkAsRcfzUomxiPxop8XDN5JPgk8m
 NiZn0cSzqjkS/WuO+hfaaR8x39j2g01cAMdZb/YsWmIi5itufVRrFrCqitEYEIIdnh/i
 6T5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DwmiyYtGoJqAEUhTtMs4TtwNly6jB9R+afoAutyJvhI=;
 fh=B885fNHk+Oo8zf7KKq5V7D/ahWjkCL8X/PGpcRDaxLc=;
 b=F2vsTH+aOG2QjtyPeamJ1rKY4YllfsYcK1aBkFN7K/VTYwPDLlx61FaHCcNPtsN1X8
 u6XjFsplW9ezH3xhF4SHBO/xXkhOC0zAMvFmLK1pdt6D9YdQKFLORpXHZj/yyZRNVygh
 7wD6wHlWuF3MabhfJLl7r8Kct3u5ZcUqPuu1ACvRQHvRPQQ5usV5eO505m04MOojPc5K
 rN0N2Tn8MkO7tPwIb9j4Z4tlpwjZWxkvEK4ugOFfRy62IlFKGGPXs3mwhEz4haVz/Hto
 6HbX0Fw1G+VNoVDHW78RDjnvqVUbv3UjsW7Jvjqa8glQiWeaxfM/7H4Oam9b7viL/ZbU
 C+2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774620741; x=1775225541; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DwmiyYtGoJqAEUhTtMs4TtwNly6jB9R+afoAutyJvhI=;
 b=RC9iQvzARgxaRSZYXfAq/IKsJzf6+1eDthrnF/Hj7wibRLnJxxWzWKGCnH33YpJq+y
 85AAX1IaV/1bfjw05EmA7Zsd9JA/UlxGjSm/sN8p0sivOeVwIvAGjXYhezWynTbUK7dL
 CNiVkvzcTDe89z5rjaG2j7eduSjftXtux7Hi1Ly03JvsPLMN4omReSerNj4TUlsccQny
 IakZOEEnAXuBZIpDQYwFslvlwhrayBs3gfNPBTPMCGD6c6UF39L23x8SWtSo+5jsmbPK
 2HWIEvwREjh9uz8UALLnaEPysCY0pqIFWxGHnBphlDonirjYG3q3nW2rUmL1a2yrVz51
 bhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774620741; x=1775225541;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DwmiyYtGoJqAEUhTtMs4TtwNly6jB9R+afoAutyJvhI=;
 b=lMVLXRlbfFTVajvLxtpeOSrVmAXX9mxHSadhBRQ0h/clB7PCOH0oTcWaj4cDcFw7rj
 AcZH2jKFJtQXcQQ/2KEXGMCnBQ+RBjZyM01URp4uNPBeEh+6MSsXZpy4NPJ+4azBrgZt
 MSlKGlqe2z580sHud1UPUU+wFOM0fWW9+ZYtZ0TohcsQUaJZBpYjshWqdwJWa9s2diDQ
 8Wwnjp9A3zf40+oE8tCUMj+0/1EUUBtlbkZxWj44UUt51F03+IVOk+59WwIrGBqyiLMj
 DQPG6ClykLg9nwkGNcAOSeh2nrTUg2FhVXMcgImTgbdVlrTj7pdpgFj7708eXG9+/CHH
 KrKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb8v4qIcIPcXmpsYvbUnxZX/A9sVUEH25bKIKV3UsBKkIpGEsf+rsm2xNc6iyPBqshELShAxW4kk8A@nongnu.org
X-Gm-Message-State: AOJu0Yy1k5BcXYfeaQ/6fRIjPxVEjHTK/5bSc83WrtsdqlyDtD56fy6t
 6gQx4/LktgodZ1xLsvUBxI895Pc/Sk5gZn1zri5uQrG9Piu6Ca/7XDsCBF9zUtXfCjWcM8cEhyI
 UcYsKju++aWZvGdE6TRmltCaqznZbxt6DYvYoevGbpg==
X-Gm-Gg: ATEYQzy/Ge/uSfbXBZhtjxpAfYSYx3yqF2nNZ2rAoBqiEoNsSGjFWF4NKJXMsaZAuP0
 EPu1mQCYj1rHG+8H9yabCqS2EmLMwZkKRU1Hb56gaqIaiGZAUsN8fT0X2x3ZuW7uAN3dCzsjQQr
 oDh4WuegsjfQv4encUFDdqmPTuXIiOYMI+eCk6ZNCQE38Cpay1Fm4138o4MPtft62hs+wOaKls9
 QqdcaXtIR225iJXQaCPKT7NZpeQFSlGvmwj1+PMI3aERaq7BJ1TPY3iuNqqIH6SYMyIBI0KJNBr
 KWiDnwx2cfta62DopoyjXttu0/fRSK+vvjP3mcS37v+pDT1TJ8TmKqFvtN8DiXZKM6U=
X-Received: by 2002:a53:d005:0:b0:64f:fd17:806d with SMTP id
 956f58d0204a3-64ffd17b4cbmr1492710d50.64.1774620741030; Fri, 27 Mar 2026
 07:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com>
 <20260327134401.270186-5-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-5-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:12:09 +0000
X-Gm-Features: AQROBzC0Po7v_TD4hj1ivk19f6IZ_jZkws9bNEFEW5yubspfFBco_Aru46Dv7U4
Message-ID: <CAFEAcA-7mgMk8oqoL2teS8Phd6Eif0d7HX65VAXXCOZTWndO6w@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] io: Use glib2 instead of strcasecmp/strncasecmp
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Fri, 27 Mar 2026 at 13:44, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> This is a change in semantics. g_ascii_strcasecmp() doesn't honour
> locale but strcasecmp() does. But this is OK for at least one reason:
>  (1) QEMU always runs with the C locale so there's not an actual
>      behaviour change here
>  (2) we want the comparison data in HTTP header and it should be a plain
>      ASCII one, not to do weird things with "I" in Turkish locales,
>      so g_ascii_strcasecmp() is better as it's explicit about that
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

