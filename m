Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3669D10A88D4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5nr3-00011v-6Y; Thu, 26 Mar 2026 12:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5nqw-0000nD-OI
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:46:40 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5nqq-0006oZ-7N
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:46:37 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64e8ae85700so1367848d50.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 09:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774543587; cv=none;
 d=google.com; s=arc-20240605;
 b=MVag1wgtNEGagDsXmrF6WHV+zN4ykaedsHzm6qLfMHUxaTWQi8Ij7HzaEqRiJB/RRc
 n20S4G5AuWS9UjZp+if13lA6qgghhgzhGyRGWkflcuB8yvGwuDTNNb3ju9JiCwt4QilV
 mSCYu9kj3ci2EmXfGdHVfVxxCbrcbmDVKbk5Qu6hFOunInUxZ+jybj8XWyBOQT6wysJ3
 1/EzLMXN+8ZFwa+ivr+Ji808Byg1uMSlne4X3sn9zw3rNartRO2RWHHG95Zx8UF1l68O
 TvquN4b2/uzrRF3rBSwUrrBRCQ88cNigkvRmaw1wGgXbhVUknLS+e38XAttbF52rHwS/
 nrxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mnyPeh6KmH7oLE/BbRTqALJJsRGykKyQvCC/hJxufdc=;
 fh=HTPvbb48pvvew7vhUKgLof3MF4iC/k4XA4OrNYti4Kg=;
 b=UCgnOcM1yHMTKDJiMpXBAlWXa/EfouUSvM11Wdevb5ee7Hb4IsOjYVwki7f/q35jP2
 lvq/CUL1WPEp6WVEjDXxIpsvhZjqkkm8S8IsZGSRIgiaU6rczjp3rvlD069J7j+CsT5O
 vv0bRXPsHt18fHL/5ZHw0eN456CqUCJIPIFXqj1AHh+0LA6T9qDm2xzRinZooCV+9B8Y
 gJpXmb/dhNRP8Da0KDmqH68tCqol++w+GlDuKfaWZ2S82yCuPMjtjmfzefOr1aqbPUi2
 U1CkJZTjBz6u+pKaZnFU1iEVGv2RxuTrzQ52yfcKeIxIKkFh9rTg+Av07cOi4zfvfifZ
 0JSA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774543587; x=1775148387; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mnyPeh6KmH7oLE/BbRTqALJJsRGykKyQvCC/hJxufdc=;
 b=Xrpt1JMHgCmSM05w0Y2ZiNCvwpHGpqLp2i9PBcZu4egtUv9me/WxVbfG0GAfOjDHjb
 PgAz7cUiCINXktSsbCdj19+5cJpcshCcYFdEUplSjNcUH8lLLj2UpAGX3MoYwoiVOQ1Q
 L3tMOTFrGAxgop7Plxc2QkEqXnN879Xlw3MAWwDHQhOR+LD2/26uUQ8hI/6+gaduKX0F
 YJszPf9JGpkLULqO7PdPWzJ3Ns/9N08OE776K7YgCbWJhQDiC92Ns4u9p760OfGOPZNS
 88QX/Q3QGH5OIyKXvnfTT1vVa2AWVmdknFJSoRMg+PA5f5FebuJkjcrN99/eSY0+XJBh
 +SVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774543587; x=1775148387;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mnyPeh6KmH7oLE/BbRTqALJJsRGykKyQvCC/hJxufdc=;
 b=SjqKwZwWsEN9wX9VSgT8CIo9wRg9HiIrY6CHsmMKVjtEf70wj1nDS6qS7MznTLHX/J
 s7JbFP9wsM37lgSbv3WihwuObI1C2+6dkk2xxtE29Sct0WEVBKhnU60FigTXWcmb4TI0
 DxHcqtjki2j/X+BGGaRXkpS+nYI3CgYsPbn1rO1UxkeE5vXnO3lLLIyOPjcz1SDzCEXd
 Qw6g4K64nvLCZlbq2MdM5YbwQhMcQejZKv2MT7SChpeYpPwsvcp0b7sA1XoVpIKltrzl
 4bARIfuPf40dlu4sJPiqZzFYuH+ZPctZHjJ/aYk0/I7kyRVxjRCL3sxmKg8YBMyxs1QA
 2gcQ==
X-Gm-Message-State: AOJu0YyBuiskBNVetBUPUWvsxptyQ5vOZBvyfgkqv5hZ7RMgAmOO0kTg
 kzD6ChEpX+gSgryZfO1qeuqOPo0T2TScBsqkAUaoIsq5gm1mMcetgJ5oBgK1goEq2VDCCzyasmU
 C8vbyiCD9dAHCnzA657ThpHhUP5m7Q3ErRGGBBnXeMg==
X-Gm-Gg: ATEYQzzJylZj8nWFO9fhKR29PQHGU1xLQwfJeFBIAprcRabLA1LyiAsIaBoS453n1kV
 bblLeR4w/9pS4CnCiG7uprtMy+MGf7Yrz2ypZMMufEWdohtzIjJ+n1FR73WDTsPc8jotVYPLuXF
 BQvdteQQ5koDlLJjZ18tAP/THnoNsSR8z0Xicx1O/rJFOXrf+iF1xnnY1KE6KeZ/JA+ueSWcqAl
 cYFm55S9p6AhF5s5gieMioN8RYFXa4hx+rIG07/RIsifJ2Yv0q7IOnqg0nB25VOoky4AF7H4yPc
 gkbwjfnRs9dnQQBe5/g2/RawPv8OTh9qTgSGCsMYoYcROQiUViyhiQ9E+VYBVF1R+zw=
X-Received: by 2002:a05:690e:408b:b0:64a:cff3:8f4c with SMTP id
 956f58d0204a3-64ee61574d3mr7882757d50.65.1774543586820; Thu, 26 Mar 2026
 09:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260326160033.68318-1-kkostiuk@redhat.com>
 <20260326160033.68318-3-kkostiuk@redhat.com>
In-Reply-To: <20260326160033.68318-3-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2026 16:46:15 +0000
X-Gm-Features: AQROBzDFd2j0h63dkWbI4PYZ64yiL7Gv4bgiGMNnvmw_hIBaunZGNiK652GQaSs
Message-ID: <CAFEAcA81M_3QaDDpDkNKZKh_m3yKSNGV1fMMKQqw8hKJvUekrA@mail.gmail.com>
Subject: Re: [PATCH 2/7] qom: Use g_ascii_strcasecmp instead of strcasecmp
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Thu, 26 Mar 2026 at 16:02, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>  qom/object.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qom/object.c b/qom/object.c
> index ff8ede8a32..e5c0c2f53e 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1193,8 +1193,8 @@ GSList *object_class_get_list(const char *implements_type,
>
>  static gint object_class_cmp(gconstpointer a, gconstpointer b, gpointer d)
>  {
> -    return strcasecmp(object_class_get_name((ObjectClass *)a),
> -                      object_class_get_name((ObjectClass *)b));
> +    return g_ascii_strcasecmp(object_class_get_name((ObjectClass *)a),
> +                              object_class_get_name((ObjectClass *)b));
>  }

The commit message should note that this is a change in semantics
(g_ascii_strcasecmp() doesn't honour locale but strcasecmp() does)
but that this is OK for two reasons:
 (1) we want the comparison on class names to be a plain ASCII
     one, not to do weird things with "I" in Turkish locales,
     so g_ascii_strcasecmp() is better as it's explicit about that
 (2) QEMU always runs with the C locale so there's not an actual
     behaviour change here

(I forgot about point (2) in my email on the other branch of
this thread -- apologies for the confusion.)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

