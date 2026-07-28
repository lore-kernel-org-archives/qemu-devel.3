Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274FBC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wohZ9-0006Ct-Uw; Tue, 28 Jul 2026 09:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wohZ8-0006By-2P
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:09:50 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wohZ5-0001jQ-Rf
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:09:49 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-667b0ced2d3so5115969d50.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 06:09:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785244185; cv=none;
 d=google.com; s=arc-20260327;
 b=f7LDzv/mtIdXuSbhCNEeGAxIfDfFbFRfG0qff4ILylP5u+666oJ2H+b4tziXOioXW4
 mKIz1r6bHcLK4OwAJUtvC1fh4KW6yNhb9x3GUxKPYzYuFNxpiAK/EahxCqemyx/gHkYa
 x3ukin9um3mrGmEATZtjGE0ZDz+0QZUHy5Ho4hEf273t1OvJgnUrCfWU6mGJY7GLR0SX
 R+K9OTJjyTbYMQ0tdzbKrAe8amIUN9fbbTYM3SkLgzweBRXzhV4Okqb1JFmeKeJ0Tq6h
 69VBwFQKYo7S/zN19E2xP5UhzjU/6Qf+zzpvl6by+GlMwKRy18Jcup1zW6dbmHq5rQ6M
 oqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zju3GeMwtSPiKXUgxlCqXU91qwnJyMRcuBsKA0ohWRE=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Q+oTAHXeN3jLKuLn+hJGdjno5FGSTXWVBIwfaNIt5k5bZwEKCK3Y+YWaJiX79d7gfW
 fj+Zrmz/DkBmIc0EjhUijYt7ACoDBHgXM8HjT5r7KVPpGcoBTKfgYHOGjHTVjZpLkIsh
 BcYkByfe5BM7+IpSmnbU97n5BpKkukyYMlqPWG/+njWOHKOHWCG8nV0q74FE4eECarV8
 7qdnSakw4JYX9X0Sxj+cJT9iYPxloXf6rMVRDvOfLmij6nAhAfAD5sK+4ICu0WIqf1HK
 x1JqOrhKy1wUG/UDuzh6Z/sn88/l31geVdX7xrd1RmfF1Xiy3EXjfO2FnOjlsyabd1f4
 2OOA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785244185; x=1785848985; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zju3GeMwtSPiKXUgxlCqXU91qwnJyMRcuBsKA0ohWRE=;
 b=c59GmQ/ZrBazO64CcnA1KRhIo0HHVHaLnPU5bgK3VyMGU6y5KyRJgtFdM7y4W0ICoG
 bMGXOazeJbgr0p8fcskk+Aip5OOfdz5yWO5Lri817nQJ4zXi6ZFJJZtupIvBOvDPTrbe
 NFhWmyIksEfzy3k7C0/bB4qOr1xPxcJU3JNPLzpl56+Cd+fJoZnIb+bIoLGY4xUVphr4
 6u1eOiNgLXZOoNWx6XX1YhEmeFNyqW/t49+6wuO9eQOVNzcthT32VQhDxgH/7MaiQ3Hw
 TmPST7xXvpuuleNEo/wo6SIH3rFqkyba0OPfp180jDMbY/dc4edXZz5Ezg+xc3F0l5F0
 qG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785244185; x=1785848985;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zju3GeMwtSPiKXUgxlCqXU91qwnJyMRcuBsKA0ohWRE=;
 b=q99SkpEf/yJOmsILOwFWDW3Q8dToj8LuOR19Qq6SSV0xUf2GmS3t6jBBqmcXXI8rR8
 5plQKHB0RZmLS3LJdkXFyqGqDbNn4IGzWXH3ljOXfJ3hDk+K6mug2MskKit6Q82QIikt
 9d8s7wtOZbTnq54Ky6I3RzZe53CSE40VvNAZoLU4J8EkuhUmFuoh/yL2n/y3m1s2rsv4
 th29xI9NZ114w6nyycPL4EKROp6p6xk51nmgzjb8qCqCafrjvVDmOwd9hUkjyuyoFNhV
 BEahe6APyr6vjDOq+/GULL5wtJbdEysPEKk8/emj/DDQV6LZ2R6bf2NP2AGuQpWdoX+j
 67ww==
X-Gm-Message-State: AOJu0YwCAHFXTWYD2uck1DakiZ2RrZQWjbCbZcb4G+jAGqkdieWQ7Ge9
 qPeg93gh81SL6pf3wowV3gVusYtC8guWzk57loIsFYJ78JDZHOs9GkSWNK7UiCGmE3kH7CAe6fm
 9W5DwuxROZcH7H4/E+qCRR+ngMbfCmDnj5KdqNa/Hpw==
X-Gm-Gg: AR+sD11Zm4z8mAFB1uupSNj6YVQOijwBP8gmjtIu5YTNaZsHPDTBds7DXX9QLSznUIO
 XQIDey+FqwwT532MtD8mA8Bdle/FBsVFLKf5N4d4ORZyQn24L/9JATY6y67cm4rDX9KVJUuaceX
 fRC5H2WVwniNd5Ozr9gfOeC5kmLhHmm+a4ju24as3b3dz2PyJ2sA2TvDycTeCbma1Bz6Ucdp9C0
 iU2nHghaKbCPtAvQqhXtCCQnmVNEaDyXJgfX+syk17Iwxysyj1+DUuaZJp9NUuv/stP7tP20Crm
 ZlOkb6yIDylEgky8OqscdXz16JyJo/IAFZLGVGcLALibdprwEMQDkRQ+Qduh5twJP56RxWej+K0
 cp+ywr4bzcHpiIITWtf6XK5F8ZH/l
X-Received: by 2002:a05:690e:1697:b0:667:8b90:3572 with SMTP id
 956f58d0204a3-6690587ef89mr1156445d50.100.1785244185133; Tue, 28 Jul 2026
 06:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260713230244.70174-1-richard.henderson@linaro.org>
 <20260713230244.70174-5-richard.henderson@linaro.org>
In-Reply-To: <20260713230244.70174-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 14:09:32 +0100
X-Gm-Features: AUfX_myNc4bA7rvIwAsOP2oKsYKIRAPESKwQM8WFSKCVA2kO1MGfj8CKdXHW0Hs
Message-ID: <CAFEAcA-X7hqFtivmjGrNqAaeep0CFfTX6wemF5ELoG4iP8uOLA@mail.gmail.com>
Subject: Re: [PATCH 04/10] target/arm: Implement BFTMOPA (widening)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Tue, 14 Jul 2026 at 00:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sme-defs.h |  2 ++
>  target/arm/tcg/sme_helper.c      | 54 ++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-sme.c   |  3 ++
>  target/arm/tcg/sme.decode        |  2 ++
>  4 files changed, 61 insertions(+)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

