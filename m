Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560E8CDE00E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd2bd-0005oo-2K; Fri, 26 Jun 2026 05:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd2bY-0005ng-5w
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 05:12:09 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd2bW-0003VL-JR
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 05:12:07 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-662bf1dab83so1177769d50.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 02:12:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782465125; cv=none;
 d=google.com; s=arc-20260327;
 b=spkTmH+YR5YIXKvyIGI91K+TSzGspUbSUAHFqQgjO0qIOrDA5PtBuVuX5/CyxNBpr3
 hOJBmDcKa8Y8M5l2zJh9SJd/4L+vbvUAbCLALtxAeOYMfMP1AUEtyfqeFjCBF3CQoEX/
 /OTDG1zqwD6YySVDlnHTMYfklGB842pWMYtwgY3z0j1DOKgQy/sC0yqxrM9So+Hbk530
 avzLH+Ctm457jA2KaXr7ZqE509Ja2rJzT53YwuFjWc0zikCCkYh0JjpyGsEi/VgBj6Y1
 4Fr3HEhQkbj6q7XrXCEN6oUt57oYkboU/0Gle6FAvAe1kpXZNxHEkbLRRMiILCnchS4n
 0ZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1aviLi2/Rh3IL2Ysy0j/MTvHuB0C2Lb1ZZWo7AyKS6M=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=E2d/ev+/smFtxSmGIBEBKbUJRlRECK/9sA9n6Gq49QGHTBHxrurZkdHB6f8dT8d5Ge
 iNfrBtVK4V8+0/SXAMwCxyJB7bAE4hc7tyEmWwykCStK4x9/WpMMOIC53d1NKdbPGKs6
 3A1orB7V7Nzu1GpcBxp9cw9TL59kFM0YAVnN6Q5I67hRlpIR+d4DsmmONGZ3PytfNI78
 9vbJ7pha4KtNTtSMFfPW9CU+fGOEJqU5jIpN/OEZcHXgPiYnhqudDhsbxbapjJwOjuD1
 45negPrqBKpsQrOlG/g5KYVqgu5amOrt0D45pfAdWuvaQ7EW+0c+mdXbpjlqj/RIlBCe
 UGpQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782465125; x=1783069925; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1aviLi2/Rh3IL2Ysy0j/MTvHuB0C2Lb1ZZWo7AyKS6M=;
 b=ddKItAm6FBgshLMreZ1g1YVym7s+oe4QzLAGCjr8HXdnP26c+xmSHmOf12C81yCYHe
 7UEzBJ/hJXSBQUXiizoa9oLzm0SBQuOwbLL6j++fkCSgrHDgGsPG9V0ZGV8/Azd+N2JQ
 t8RmTeaEOKDnDq8dPgw2bCWa/JCnhoyZiqfRSUeINtFfTz79mZsV7ZRQw5hDt1qVeVSV
 GdcerxgNS2T6D6PY8hj8aN0l4G5IThJASJkmc9Um1oaN6iGYw+A/EcAtbgYofPfWw1uY
 FBTxatVbr2xuvb9Eph2rim8IZeAcwz+RvvJkBCPFFaCGCKN26NnABfZw5kPj+8qbrOx2
 KQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782465125; x=1783069925;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1aviLi2/Rh3IL2Ysy0j/MTvHuB0C2Lb1ZZWo7AyKS6M=;
 b=Gec5kq9Ia+N0fSrAoa2Rw7zasqhokiUcw6j9g93fx/0PCtjIDSumEN5NujHxLkcRLJ
 Kxmv5lMstmwNpJ8ZDGzF+b3KrUUdd/ibCH5AZ4jCnkpaVNIeZdsp+XQ266xInQLEjDjw
 TomgN7xCSwGVfnNWb29AKkmRCEnfUS2bQbybF4O/jwqXRxvbr4RaQbDx+OOQLSlwDbqh
 ijfJ4Nu2YCAJLgED3CTI3iTOIO64lpNqnpPn+9iOh5gqGEyRzrP5ynlK4hbRUovqSwpr
 w2oZFW2pTCe23FGbeYPH0Wvw4vfkCp1dKr3YabtgsHGSmrmFlJeh1em6ln+XRcA6yL8a
 uF1w==
X-Gm-Message-State: AOJu0Yx8AmH7iNLFRWDtMy7oZHfKU1HgFMzsARoSIz0xig7/305lhFWG
 HVfQ/kcjT+MAjVgyQDsUkJS2s3DEkF+5vSADhBKKy/yYkTZTolIVgelyvNKc5q/t8D2/q9Sljqm
 gFPffHbD2n4f5T6zuhKVCMgq0eSIs7MUl1kctfD90tg==
X-Gm-Gg: AfdE7cmlLg/UQIZlzTwi0wrlqlvb0jUPpHtN7ZwUN4mMng0TBwl5TMGnXqkJvU4zNgB
 noyaLAPtFIxiEPao+wW8xQDMiYTQFqhS4pgXBUpK1tjhBGLINRGRw2FjKDvEqAKYT5Hu1wEc1cQ
 N5MQKxUpAzHrhrAhY+WEAJ9LXnnUVbmA0bZrEdR7Ych6xwgEPRDEU1OzrQvXfoGVDTwhSBTk2L8
 DsRX2+U7NoLWnt2aETYq+BJCVeRhgWviAJBn/9EblGiEwLAJoB0+6EwgdnaF31JTtaxNwu8X/Ae
 HZ2pFKPsLdi69gWRfPwyGhzA/PGpATUNaS2ubp+FXocQv1XEpjuhLd6f
X-Received: by 2002:a05:690e:128c:b0:664:8d90:25db with SMTP id
 956f58d0204a3-6648d902b19mr4110387d50.61.1782465124973; Fri, 26 Jun 2026
 02:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260625015159.719300-1-richard.henderson@linaro.org>
 <20260625015159.719300-4-richard.henderson@linaro.org>
In-Reply-To: <20260625015159.719300-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 10:11:52 +0100
X-Gm-Features: AVVi8CfSZLxrDjQwhClRfBX9gVXZVUslKdVlasNTu6KI-jf_gHDWxU02B5Cy-WM
Message-ID: <CAFEAcA_rO2nPO+iQXHO5qbgekxPscVEtsgD7V6WdJtEXwcSyBA@mail.gmail.com>
Subject: Re: [PATCH 03/10] target/arm: Implement FMLAL (multiple, multiple and
 single, FP8 to FP16)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Thu, 25 Jun 2026 at 02:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 9 +++++++++
>  target/arm/tcg/sme.decode      | 7 +++++++
>  2 files changed, 16 insertions(+)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

