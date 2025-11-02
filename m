Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9CACCF9E3
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 11:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFWSz-0006w5-V4; Sun, 02 Nov 2025 06:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFWSq-0006vZ-M7
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 06:41:41 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFWSm-00036E-NU
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 06:41:39 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-633c1b740c5so3193301d50.3
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 03:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762083693; x=1762688493; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eUelu0rYTK/FnwSKyMt+Ato51Lz2Fvd1Q1rdIJQ6kYA=;
 b=gCqtWceDqR1r82BGCLtKZYq/mczOxyM/MhSIIHAOJ1HbBqiwWSSMYH335PtchPB4QE
 ew6pKPB52Vn78NP6+w0AUnLyXvokxBa04MWegpMO5PGWeikgK0GhS53i3XHuQFOj1X+f
 VJNPi6dZe8EQFbjId2AnEeuPL00mPwTkufqn+0yAzM/qXLQuwyOEdvoTycqh54BogihC
 d2L2TV9dGiyn7dFmtwp4mYYS7mGTV9COLGmIeHy3HuPYgvGn/MJsxBS/E8buFzslA6FQ
 Rk+pWtDV0Jy+31WQAr5HPog6cIALEwzehL72XRY/uU7s0Wm6/TFJ6IoIzibwqfZvaVwf
 LBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762083693; x=1762688493;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eUelu0rYTK/FnwSKyMt+Ato51Lz2Fvd1Q1rdIJQ6kYA=;
 b=esXUdP90Gig+XcC0JMZtvlDjFDo2nKENPuIG1M1LNck+NL3CSSXx3wNEPnBW1xm6Jy
 R3hfVcL6QLN1b1isEYdd7+WYCgB9m5Qvv93bYzRwI1S8iWV/9uNxN2GAkD4HwGf3yFx/
 kiegdEPBJ2zaCoCimDrERE+JEglWAkA10iWzjDyB/ux/WEZkpV8lVJ+ZkzkFyjMMb57x
 UzVJzcRvKIi7AKtiNMrDuXhm2mnPuQ6YrBFyhpNny1IJ9f3VZy+nW/W3u8Hc8yySBkQ/
 +YOjnWj+l2WdfCh7RxBkbS70UXufXu58axgfMnFZx9yPn3HIDFGSMh7WUPMOtBJwtLeT
 4iJg==
X-Gm-Message-State: AOJu0YzTDDEkf7+NqjhhfdoDVsSKB2uBeKKn8poJxrLE+7+esnvn8k7/
 UDl+KuzSo/sgY0jyACkc1unUswdWe1E/asg/RkvWL2Y9m8oZar+PgeReTSrJY6XTjyheZTGEpiN
 PgNFHCij0ag0D42dBhKXEFjr9Xaggn37wHmncaNITzA==
X-Gm-Gg: ASbGncuabMiVpx4o6GcmiwhgJorZ/8tyHgZ3dvqrsQaej5fK9cXo72O02MgWem6q//Q
 1L6CkC9ubiJskl9qfbJUDyoaUfXc83RcxGwV+saPwasgxHIgswWZx9rGHL9GrzbaHBqg45Tv6jn
 UafGm+GVtLl06J3Li4GwU7uPL18Unz+x4DOttn3ITSmBSkW/MTAqjEJquvSqAgNa7LWkNtgoX4y
 WUrmjaruqaP9S3HmgBoDu4a+Zd+jR8iqA2OzLGnUKhcS4ZAT8hrDuGpJPZD+8J3ey4pyrBA
X-Google-Smtp-Source: AGHT+IGu8HTsumHc1z9ohWtF1hhnAtV4G5Lx5mHf/R/menURAfOzgmgJpStgqpKopp7T80olZ4TjnDCnjyiwMfV6KjI=
X-Received: by 2002:a53:acd0:0:20b0:63f:a416:2673 with SMTP id
 956f58d0204a3-63fa41626d7mr2872928d50.68.1762083692633; Sun, 02 Nov 2025
 03:41:32 -0800 (PST)
MIME-Version: 1.0
References: <20251101165236.76E8B5972E3@zero.eik.bme.hu>
In-Reply-To: <20251101165236.76E8B5972E3@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 2 Nov 2025 11:41:19 +0000
X-Gm-Features: AWmQ_bnClJjaoDBkFvO2t7BQy3Hsaql0VrZ6I7Cbkdj5PzGxZ_25TafVcu3_Pak
Message-ID: <CAFEAcA9HMKVZt_p8uea7yTPmN0Of0cJwWXxpLfFT8bB6TvMZ6g@mail.gmail.com>
Subject: Re: [PATCH] hw/ppc/pegasos: Fix memory leak
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Sat, 1 Nov 2025 at 16:53, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> Commit 9099b430a4 introduced an early return that caused a leak of a
> GString. Allocate it later to avoid the leak.
>
> Fixes: 9099b430a4 (hw/ppc/pegasos2: Change device tree generation)
> Resolves: Coverity CID 1642027
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

