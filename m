Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41ACECDB47F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcfrN-0000kU-IY; Thu, 25 Jun 2026 04:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcfrM-0000k3-4n
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 04:54:56 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcfrK-0008UK-GS
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 04:54:55 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-464192ab2e1so1403032f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 01:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782377693; x=1782982493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lh6HzbC4Re3VfR2uLQWgIh408Lakm7hFEbKMJg51tw0=;
 b=vFPZwpz6j8WnHvrG6hLvCAMfyKOiyQ69m3nG2XLncInoUhsYZjBCfywwL0SCGkWVgo
 Baw3RQi2bCU9eS9oCpzUZTpU8ABzQJVg/F/BWOOZyuQz3pB6e6Qi9F42p+djsHfV7VIb
 2KBt15KBNF64DDYn9cRaUBckncesf/jCfK0ONEohSdg+dwYtpNS4tnjJmJjmg5x/bHvz
 D028QdTQeQRP4RzPfKun50eSawAhYNT/IQCXEHN+PferWhbykqqlJ4W5R+Xf7S2purIa
 eQP71R1PiRORKJn1JZrra3JjJAIZO+bW999UZi7EDdKk0V5QRf280alAPkKBrOOG5aNQ
 86bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782377693; x=1782982493;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lh6HzbC4Re3VfR2uLQWgIh408Lakm7hFEbKMJg51tw0=;
 b=tRs3ZB6Gti8I+bMyju1qM7IrXueKLFVFqqmk2rpOyS9IZ/xBqv0Mlg5ZThQnQPMBzZ
 t14CFV0u3o5yrdnroyIzBibLeWbq4i0SbQy29R1h3Ouw0/v9/Czdq2F2aQaVTriNc9xt
 owV0IMYv5dZq0oC5Bju8KKoSJBRu5W055eActxexRlQBxyDtdDTxRbRRHnEVnfhWRh2Y
 olOUj4lucjP4T9jgQkmhEhOi96B0q+TfCD9RrsYsjun/Nb3QaCTh8zc7657qYuW35VR+
 viWOxWmNUVGye8cHgzHAkQyzksjAE/UPH7uY+ECdGp2yop7f3946sEQZv7EC2B61+ape
 eiJA==
X-Gm-Message-State: AOJu0YzzYocVP1HYyLo/SQCh59N0CCq/a53dBGCptLJKcMapzNzOBUkr
 O6/j7dP2Svxspa3EXz8NPozmLNGpEvRqD06P7A9GOFHZ/Xy64Ag2OXcLT0TbhJ7l7OE=
X-Gm-Gg: AfdE7cnh767mQSejheQXa0bVMM9AvVm8ngTSEHOKXb9syugFxOUwWu02VfpmIQ4Dmd2
 mBG62SreMNWPGSkghvIGIpneslTuXbzBfb2JyR2VvnA7iRe0GB4PkMyiyQDjIbsvYllRqOsLxMn
 x7ULpCYUDXhCEx6/L/YQpHl1xGkCDG+8zobA2lnx+eF/9lKaC/eyyCCogXBPyIthm9slzGi6YsM
 voScMqoUQhzRTE2FFQ91sLLabJ99PEkRJgt9N2373NP4bs6vmLzgqjHeEV+WiKEBGx83Sbm2PuQ
 4sIIOcLf2SRNWXNLMHVbnd07Hl8SuRZ8K/116qDaH3znizZUHH6IwY0eHMAts/zGj0/clwIrN2H
 H+NavQ6DuDT/d+mZyLNFjy1kqVqEIAYXVYRgSRYqBS9GrMK/vFPKwYrDZL4uP1UBesPYGLbbK6/
 kYBic9rd0x3VUk
X-Received: by 2002:a05:6000:4692:b0:45e:73b3:4515 with SMTP id
 ffacd0b85a97d-46dc14cbeeemr1514353f8f.35.1782377692624; 
 Thu, 25 Jun 2026 01:54:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee01c3bsm14993113f8f.10.2026.06.25.01.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 01:54:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 09B6C5F7FF;
 Thu, 25 Jun 2026 09:54:51 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 6/6] tests/tcg/arm: Tests for new FPRCVT instructions
In-Reply-To: <20260624-jmac-fprcvt-v2-6-dc6cf8e512b6@linaro.org> (Jim
 MacArthur's message of "Wed, 24 Jun 2026 14:37:30 +0100")
References: <20260624-jmac-fprcvt-v2-0-dc6cf8e512b6@linaro.org>
 <20260624-jmac-fprcvt-v2-6-dc6cf8e512b6@linaro.org>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Thu, 25 Jun 2026 09:54:50 +0100
Message-ID: <87qzlvhued.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Jim MacArthur <jim.macarthur@linaro.org> writes:

> We autodetect the presence of FPRCVT in the test cross compiler,
> which is a recent feature in GCC and not supported by many distros
> yet. If this is in place, we compile the existing fcvt.c test with
> an extra compiler flag which uses the new SIMD instructions; the
> output from the test is unchanged.
>
> The existing [US]CVTF instructions do not have a test, so no new
> tests are added for the SIMD versions. They have been tested manually
> to check the new SIMD versions produce the same numerical results as
> the existing versions.
>
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>  tests/tcg/aarch64/Makefile.target | 14 +++++++++++++-
>  tests/tcg/arm/fcvt.c              |  7 +++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefi=
le.target
> index 6203ac9b51..32f2689273 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -28,9 +28,21 @@ config-cc.mak: Makefile
>  	    $(call cc-option,-march=3Darmv8.5-a,              CROSS_CC_HAS_ARMV=
8_5); \
>  	    $(call cc-option,-mbranch-protection=3Dstandard,  CROSS_CC_HAS_ARMV=
8_BTI); \
>  	    $(call cc-option,-march=3Darmv8.5-a+memtag,       CROSS_CC_HAS_ARMV=
8_MTE); \
> -	    $(call cc-option,-Wa$(COMMA)-march=3Darmv9-a+sme $$fnia, CROSS_AS_H=
AS_ARMV9_SME)) 3> config-cc.mak
> +	    $(call cc-option,-Wa$(COMMA)-march=3Darmv9-a+sme $$fnia, CROSS_AS_H=
AS_ARMV9_SME); \
> +	    $(call cc-option,-march=3Darmv9-a+fprcvt,         CROSS_CC_HAS_ARMV=
9_FPRCVT)) 3> config-cc.mak
>  -include config-cc.mak
>=20=20
> +ifneq ($(CROSS_CC_HAS_ARMV9_FPRCVT),)
> +AARCH64_TESTS +=3D fcvt-fprcvt
> +fcvt-fprcvt: LDFLAGS +=3D -lm
> +fcvt-fprcvt: CFLAGS +=3D $(CROSS_CC_HAS_ARMV9_FPRCVT) -DFPRCVT

Do you actually need $(CROSS_CC_HAS_ARMV9_FPRCVT) in the compile?
-DFPRCVT handles the compilation.

> +fcvt-fprcvt: fcvt.c
> +	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
> +run-fcvt-fprcvt: fcvt-fprcvt
> +	$(call run-test,$<,$(QEMU) $<)
> +	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
> +endif
> +
>  ifneq ($(CROSS_CC_HAS_ARMV8_2),)
>  AARCH64_TESTS +=3D dcpop
>  dcpop: CFLAGS +=3D $(CROSS_CC_HAS_ARMV8_2)
> diff --git a/tests/tcg/arm/fcvt.c b/tests/tcg/arm/fcvt.c
> index ecebbb0247..7c0cc4367e 100644
> --- a/tests/tcg/arm/fcvt.c
> +++ b/tests/tcg/arm/fcvt.c
> @@ -171,8 +171,14 @@ static void convert_single_to_integer(void)
>  #if defined(__arm__)
>          /* asm("vcvt.s32.f32 %s0, %s1" : "=3Dt" (output) : "t" (input));=
 */
>          output =3D input;
> +#else
> +#ifdef FPRCVT
> +        asm("fcvtzs d0, %s1\r\n"
> +            "fmov %0, d0" :
> +            "=3Dr" (output) : "w" (input));
>  #else
>          asm("fcvtzs %0, %s1" : "=3Dr" (output) : "w" (input));
> +#endif
>  #endif
>          print_int64(i, output);
>      }
> @@ -425,6 +431,7 @@ int main(int argc, char *argv[argc])
>      convert_double_to_integer();
>      convert_half_to_integer();
>=20=20
> +

stray space

Otherwise looks good with the clobber fix.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>      /* And now with ARM alternative FP16 */
>  #if defined(__arm__)
>      asm("vmrs r1, fpscr\n\t"

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

