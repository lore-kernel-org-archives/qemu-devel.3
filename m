Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1DBCDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 15:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclmY-0000xD-3n; Thu, 25 Jun 2026 11:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wclmW-0000ws-Oa
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:14:21 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wclmU-0006Tk-TC
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:14:20 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49241a577d8so15330455e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 08:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782400457; x=1783005257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o4/Os1wOfWAcwDetYN2I4rq76jj7eladgrYbeprHSW0=;
 b=mv6gaYJsa0nKPHxtn2u49RXBo8tuHDiMFCFsqIzvBo96hk3KJdmOfcmfW8ytVuYqJT
 M8iaEgToSjUyTdljZb3H6kW/HIV8ACyeq8krCHUTYC7tlBNcy4ej4Mk6VKViRHpHef6E
 B0gGyZpVf32WQsMF9k/yZ4jZFJG8tnAgAG15ULuokeIoGTPr0ZLqvC4VN9i5Zz8LEDJJ
 0mcv34+/nTSGRWY5mexlhoWYxJ5nST1+2DkUc5oKhMwq+nW3avCgLG02LIYbut5HiOgs
 Yhm0WfGk0Ia6/TmBEor4jByK67yd3ztg+McSTb5Wvf6rTSNVQsRHeTay1aj2c3QCzvIq
 yHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782400457; x=1783005257;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o4/Os1wOfWAcwDetYN2I4rq76jj7eladgrYbeprHSW0=;
 b=f05KSouzi67ZTrA0M26vzglUoPmDZirXJjRXnfqPCrh42cPX0Npk6zZPIQUa8vJqAB
 GYOZbHkrtYHIGdpwCPtiiDfNJB1N1gHEc4yuguyXzQC9hjQqFY5+qDqADkCLFXV7seyw
 EexWr62gM3B5qtyBW+HMwOdJ0axbm9yKhanRxqRdneA59t1fHUQ5d+BjCXgGlpNVoCCv
 Y5FI7B8CF7+pfb1WGnil6VUKySQnPbEZVRSwGrKTBuZFBTcAekDzjPGWwsUsrl3GQLRV
 Z3vdal5Mg8nia+19Dkp6LoAp9qfz2/VSIY5PJ5RK/7iIq5EI5QueGAOIt3nYXZLzeouk
 0dyQ==
X-Gm-Message-State: AOJu0YyltLn++mm+VHG11zKk8vJRnuXlZrTAVQqoHGovO7JO97upvwgm
 83CM3J/nldLGH86dXuQDher86I9+A+dg4tWVSXLDM0m4VlH9Nme0Lsa7G6CzWkWK9AE=
X-Gm-Gg: AfdE7cmEKUOxeEfYbZAS90cL9t5VseTWTwbqUb/zO8WGeHEqlcrTxuflfhg5NEPaktO
 8BlAYXRM+ePHqmW/D6ZfWLAOr58c55InaLlCYw9d+uTF8eNNXiC7HhtyiEfLXuuhoM0+lOpCwB5
 FOiANjOl2bHnkGAGb0+WDH3Rr1sLvSESLbb0wFlGAZ6XNrv1wmbbpepQHpGl77F9A8Os38kFEeC
 Dq7fYHX5JZZMrZzg6YMyujEEMqq0zWz2mPZgD2hmRAwAXIqhoXp4V4EvjzdBurrCJ5sgu8uu2hB
 yLLt4guaNvIdDozulxucprwa/9QTPmknvm8IMM1EUkRXJMx2QjtW4ZlNPqy5Qdnc451co+UEIQg
 MfFAHinoNFbVB7Jqbl9X82D7RRkMw+RjpywLsLAITCO1Ypo1TJC6egF/VG9N+wjOBlHtvQ4uafe
 LbGRb1X2U6bzdNeIsrsIQnK6s=
X-Received: by 2002:a05:600c:e54a:10b0:490:b8ee:d6a5 with SMTP id
 5b1f17b1804b1-4926683b8ebmr29557135e9.6.1782400457011; 
 Thu, 25 Jun 2026 08:14:17 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926543be74sm49706485e9.1.2026.06.25.08.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 08:14:16 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6C4905F8E5;
 Thu, 25 Jun 2026 16:14:15 +0100 (BST)
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
Date: Thu, 25 Jun 2026 16:14:15 +0100
Message-ID: <874iiqireg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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
>      /* And now with ARM alternative FP16 */
>  #if defined(__arm__)
>      asm("vmrs r1, fpscr\n\t"

Ok with the following:

--8<---------------cut here---------------start------------->8---
modified   =EE=98=9E target/arm/tcg/translate-a64.c
@@ -9882,6 +9882,9 @@ static bool do_cvtf_scalar(DisasContext *s, MemOp esz=
, int rd, int shift,
 static bool do_cvtf_g(DisasContext *s, arg_fcvt *a, bool is_signed)
 {
     TCGv_i64 tcg_int;
+    g_assert(s->is_nonstreaming =3D=3D false);
+
+    g_assert_not_reached();
     int check =3D fp_access_check_scalar_hsd(s, a->esz);
=20
     if (check <=3D 0) {
@@ -9917,6 +9920,10 @@ static bool do_cvtf_f(DisasContext *s, arg_fcvt *a, =
MemOp src_mop_int,
     TCGv_i64 tcg_int;
     int check;
=20
+    g_assert(s->is_nonstreaming =3D=3D false);
+
+    g_assert_not_reached();
+
     /* FEAT_FPRCVT allows vector forms in streaming mode */
     if (dc_isar_feature(aa64_fprcvt, s)) {
         s->is_nonstreaming =3D false;
@@ -10065,6 +10072,11 @@ static bool do_fcvt_simd(DisasContext *s, arg_fcvt=
 *a,
                       ARMFPRounding rmode, bool is_signed)
 {
     TCGv_i64 tcg_int;
+
+    g_assert(s->is_nonstreaming =3D=3D false);
+
+    /* g_assert_not_reached(); */
+
     int check =3D fp_access_check_scalar_hsd(s, a->esz);
=20
--8<---------------cut here---------------end--------------->8---

I could verify that do_fcvt_simd is called and is_nonstreaming is set by
the "hidden" decode logic. However the other two cases don't get
touched. What would we need to expand the test to them?


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

