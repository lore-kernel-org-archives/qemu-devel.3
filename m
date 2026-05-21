Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADA2CD5BB1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3Iy-0005uC-AB; Thu, 21 May 2026 09:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ3It-0005l8-G9
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:19:13 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ3Ir-0000jW-0B
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:19:10 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-65318dafbcbso6079432d50.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:19:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779369547; cv=none;
 d=google.com; s=arc-20240605;
 b=heEhKWepDCQhOlPgrfdGTTMCsJjoqkCqj2ob4DznTdCWSbsVah3zW/p8e+BP9lIM3U
 FKIVI+FnRkfd3JYnNx/gnYU7/3HMaAYgf22eowoD8ap5XSz+7nvz0UdrR+NbatT+Up28
 pnEP9vH5GwGaT9UT4BfV6ybTgkTKg65+2fU7Dwpn/ausAijD9HOg3SAEK7uZcRZB42sa
 GvQFN39Jfxhi5uexcTTdPn2fDVHyL/HnW25sw0Ht0seDcFA/f3Dqv0tkXyf3E9Hjd5ZS
 uh/2ZxLpnDTQn6Izeoi377RJbfIfsKfytqg/D8sOR1L+f7XstfAWrg7bSpNP8O/Tt7Q+
 thmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4ADeTWTbLEZgRpKwc8gUJG1eyXF4WIMUY624CQyg+ZQ=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=JmGy/I+JIuaUjX7cDwn6P4Y4GgG6h07PFb8LW/K99CdfcGfAZwoZXzE63/oWNVls6k
 cKClU20Fr1RxQTu66ACBmHub+XIMVXfirplL9mKoqIZ+wltpY8QlDv21MFg3IFM/QMIK
 uVaimDwl+DBj5ZS1dgegq1k30yXfDhe1ruvC3L+xGn2IrISf1dOITtNibfv8lUduzozO
 vzRHQLj9caa2Ac8n7xVb3MyYH+Si/qGdi0j/P9vsSnR+kyWP8963qnf8RO2yPaUS0KbP
 ZhoWmbYdnzti3m3RiMFpUCXAzGbOUo+mlIH4m2L7/XJl32m3GVU1z0rMh/i22MxEjM8G
 opHg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779369547; x=1779974347; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4ADeTWTbLEZgRpKwc8gUJG1eyXF4WIMUY624CQyg+ZQ=;
 b=QVhipjxQ0REumMyq0rGFuZWQ7k/KUurfGFxKNH9OVTnmonmXeYwa5dsd+/ffK+cz/N
 ij3fopIjTTVjY2oOaa991Wx5AN1Zpx0J/0Sk2R0p0cJyGucKJv2fL3M7NsrXSvyJcUVi
 fyCmlsOZoavvhj/VcQ96iopA4JcnmiRg8kjWjzsFuGRR7cXMyO/FvrIiQ/NzOJPgGXvm
 k4Gx9VsAqN/ACv9x8D9fPKYy6h7BpIfp8SdaGbgGrCa/qMAfpscapQmEH+aOyM5fbUxt
 /ZEHXnmKnywB3G/1Rxm/iHHn2vcMFr1aCqvbdqhLo0HM66unURRQuNYgjCdETRWUaWes
 RLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779369547; x=1779974347;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ADeTWTbLEZgRpKwc8gUJG1eyXF4WIMUY624CQyg+ZQ=;
 b=WFOgz020yR9WSuHbmRsEY6eZsOPESFhxpM98c8z42lFMgxbKWUaS8rgODbB+OyEOoT
 WVvpcg0tOAfpii6CFJsP3H7yBNHM+nLplayxAvxnaZZ9/E6XhPcQo0ZuLf2MxyVc+WVt
 5TNdlCFoDISEAjn1vggC8tL3pylWbIW1Xu9y6ffLp+3oeXwWBEbtDMPbr+6NvyzyCOIe
 xHT/ON2BK2inO04Gs3UIKGgHhS0rHGP+SRGDW4tqUy1Hr7VHFnCPOlpdVZWG1KI07ibF
 ril9Grf5g9Ehxwav10Tgsl8Y5vFk+klIx5ckyrrfNL5PyAOCMlpUhzdooc8UnnwXvWbD
 Yasg==
X-Gm-Message-State: AOJu0YwQXOh1ifm8bZf/bPJDptgRivO9BvCKw7OCVZPRhlr0pr7WZ+Wh
 X3q3KKvH8c8azobBBTX1xrXxeNMDdgyXQvqbcWPjgyX+L/TMJreturLirpjmPK1uVDvSXzk2RYF
 fHQ0xdy29sU88OWcyJyUzmRVFowEDlWTxvMnmWyKS1g==
X-Gm-Gg: Acq92OHC56/Hb2TF7dlFj/cXPrNZmlj51zAlOVaNtrAri7z/il2LQfW3tKTsqPryqOo
 ganC9F2EA5t4R1oyPCw6w33wDPhmKqLFqHd0sqi5JWQRJdZJAJMXcKijhjoRidhVjRorvI3Um7r
 DyReYK1lLedMB6J4Ohufo1NTH1fObgqvJXcbrqeh66Xfmb+o7CcGFCURuL1sfcp9Bvy0pgv0aLv
 JZPrff6b3Dez1GOg7SpsYYJOk9JFDj7+9wwcVHstd6mPRkyrfPzTM3D/Zp9TGqptfgN3CtaWMlY
 CNS5eX+gzat4RgPeW28+loPDtDPpgLUpaxK5bY1c5WpbbOd1Nb356JCV+8CJcsScsmU=
X-Received: by 2002:a05:690e:43c1:b0:651:bacc:77c with SMTP id
 956f58d0204a3-65eadfd336emr1605137d50.26.1779369547270; Thu, 21 May 2026
 06:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260520171820.848839-1-richard.henderson@linaro.org>
 <20260520171820.848839-29-richard.henderson@linaro.org>
In-Reply-To: <20260520171820.848839-29-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 14:18:55 +0100
X-Gm-Features: AVHnY4KagCTHOrZmxJxXHto_JjfpwLFPOmufqrJLgDI0jubjrm-GqO1PStTJduA
Message-ID: <CAFEAcA-JQxegrEPrhoTNx3Q_1ctiE0EYQCG5Q3t5sVKBvnSLBw@mail.gmail.com>
Subject: Re: [PATCH v5 28/30] fpu: Introduce float_status.e4m3_nan_is_snan
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Wed, 20 May 2026 at 18:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Introduce a separate control from float_snan_rule
> that applies only to the OCP E4M3 format.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

