Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87095C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 16:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTP7V-0007NX-1Y; Fri, 26 Jan 2024 11:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rTP7N-0007Io-1b
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 11:31:49 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rTP7K-0002zs-FI
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 11:31:48 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40e490c2115so12261405e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 08:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706286704; x=1706891504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T5kZ8tCa/uQi3HiKM4BC04We44wo34mfdztb6VQ3hJw=;
 b=pdARSUn+zUdXrpKL2pbhf2Cf5WFQQDDdqajpV/lTMD36fpG0dyvrIWfxtPlsG6vW8T
 3To7OkWL4OCezLd+Z66JEhWWozGrQ6IqkQ9Ggd7lwVH6WX8OYxtP6ZtR+MgzoN/f4bTI
 ur+IaKMQbixwcPCKzrXKTq5bHeoHOfszVZ9y1VbH84V24dE13qh7+27nQIurKGPvwgm+
 QUJNFGrSQKehnSDuPtOmd9T2DjRa2zgQMVjWHziI7fmL8iRKC3VD5y26BeTFpBsSkWUU
 1+mCjsfbpHcBZ5X2eL2MOgaWUrbnXHTb+SvOB4olxOVTpRYsecCHJ/ql/yBtj/VzSsTE
 7eYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706286704; x=1706891504;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T5kZ8tCa/uQi3HiKM4BC04We44wo34mfdztb6VQ3hJw=;
 b=cLdZ4IYcRpKU32bma4yjjqPwcKE8xyTkMnMc66xoOlI3+6tYTbZgR14yj+eX6sdgb6
 c/lGKyRqriOyZfXIjDodAH+p1yYADHd030SkXcrASI5oSnG5yrZnHfD9HLlpDFPxOQWp
 UDI9K+kUWWvkdXuf35qdOv6tfdkNGUbAOvK9xSclH29cTaSlToBNV5xQMkmAU2m7HruI
 +m/Mhmp2CvBMZl25Ee6hSOm75iOCCipYfh6G0ZN8F2gYgyvNkY2HMwyGiS5M5KuIFTSe
 UyMVfXQdlSP0pMHKM1D0zTqiGZzCDayLiZQtlAZAC1YbIOeo0wVJKW/Widk91U0cuHgl
 AajQ==
X-Gm-Message-State: AOJu0Yy8TTmihIajKyBdzSd34t0FzOiI5RzWQjQVSQUeg1wJ9lsoJuHB
 0ZMJttOUCi/D2DgNDM39xF9HqZOg7rCPXCT0GJdaPVqhcJasBmtwtmxGxN+4HSE=
X-Google-Smtp-Source: AGHT+IGlhX2PSbWcsAD8wd+LGJA3anNj6TwUyFRLJuw/V65GI2FpsGJqFmKSUSHYqGaxcTIA3MsEIg==
X-Received: by 2002:a05:600c:3b85:b0:40e:e8cd:93cb with SMTP id
 n5-20020a05600c3b8500b0040ee8cd93cbmr56698wms.103.1706286703794; 
 Fri, 26 Jan 2024 08:31:43 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l5-20020a05600c4f0500b0040e5951f199sm2340640wmq.34.2024.01.26.08.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 08:31:43 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 321BC5F78A;
 Fri, 26 Jan 2024 16:31:43 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH v2 14/14] contrib/plugins/execlog: fix new warnings
In-Reply-To: <20240118032400.3762658-15-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 18 Jan 2024 07:23:59 +0400")
References: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
 <20240118032400.3762658-15-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 26 Jan 2024 16:31:43 +0000
Message-ID: <87msssqcnk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> =E2=80=98g_pattern_match_string=E2=80=99 is deprecated,
> Use 'g_pattern_spec_match_string' instead.

Unfortunately this isn't enough as we can still build on older glibs:

  /* Ask for warnings for anything that was marked deprecated in
   * the defined version, or before. It is a candidate for rewrite.
   */
  #define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_56

You can do something like:

  /*
   * g_pattern_match_string has been deprecated in Glib since 2.70 and
   * will complain about it if you try to use it. Fortunately the
   * signature of both functions is the same making it easy to work
   * around.
   */
  static inline
  gboolean g_pattern_spec_match_string_qemu(GPatternSpec *pspec,
                                            const gchar *string)
  {
  #if GLIB_CHECK_VERSION(2, 70, 0)
      return g_pattern_spec_match_string(pspec, string);
  #else
      return g_pattern_match_string(pspec, string);
  #endif
  };
  #define g_pattern_spec_match_string(p, s) g_pattern_spec_match_string_qem=
u(p, s)

in glib-compat.h but I was wondering if it would be valid to add that
dependency to plugins. We might get away with it as it doesn't include
anything from QEMU itself.

>
> passing argument 2 of =E2=80=98g_ptr_array_add=E2=80=99 discards =E2=80=
=98const=E2=80=99 qualifier from
> pointer target type
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  contrib/plugins/execlog.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
> index 5a4de1c93be..d12137ce5c0 100644
> --- a/contrib/plugins/execlog.c
> +++ b/contrib/plugins/execlog.c
> @@ -336,8 +336,8 @@ static void registers_init(int vcpu_index)
>              for (int p =3D 0; p < rmatches->len; p++) {
>                  g_autoptr(GPatternSpec) pat =3D g_pattern_spec_new(rmatc=
hes->pdata[p]);
>                  g_autofree gchar *rd_lower =3D g_utf8_strdown(rd->name, =
-1);
> -                if (g_pattern_match_string(pat, rd->name) ||
> -                    g_pattern_match_string(pat, rd_lower)) {
> +                if (g_pattern_spec_match_string(pat, rd->name) ||
> +                    g_pattern_spec_match_string(pat, rd_lower)) {
>                      Register *reg =3D init_vcpu_register(vcpu_index, rd);
>                      g_ptr_array_add(registers, reg);
>=20=20
> @@ -345,7 +345,7 @@ static void registers_init(int vcpu_index)
>                      if (disas_assist) {
>                          g_mutex_lock(&add_reg_name_lock);
>                          if (!g_ptr_array_find(all_reg_names, reg->name, =
NULL)) {
> -                            g_ptr_array_add(all_reg_names, reg->name);
> +                            g_ptr_array_add(all_reg_names, (gpointer)reg=
->name);
>                          }
>                          g_mutex_unlock(&add_reg_name_lock);
>                      }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

