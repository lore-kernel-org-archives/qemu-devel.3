Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EF8C61CE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 09:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyQcH-0001jx-QF; Mon, 24 Aug 2026 05:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyQcG-0001jm-05
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 05:05:16 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyQcE-0002vK-Dz
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 05:05:15 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66d06b5f023so1136488d50.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 02:05:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787562312; cv=none;
 d=google.com; s=arc-20260327;
 b=pU0Sd+VITX2/MVu0qeA8hpH8mkpcP8SLkABk3x+78fopLCTKXBAMUZbr7y6Ysc5TBj
 XVHfi5pPbWTZ0y6eXuNEjPvD8hbjYnmhN8n55byiwAy+Hjsj+c8vd/3Td4wAiPTcmi2x
 KQc4hzsTLIIAOOlN7v+Dzt9p52R1WudW0e+j1Ls1bHHWRF97DGYXc8JuAsf6RYF8d3XC
 2H7BOFh7iJCV3O3jXaH1JRUc7XpTOyVTMVGNWnz30dNBi5pt7GKQddaqkgr51wZgcqc8
 NbkKaR8yH2Du2Yv5PhBqE/cR3oxB8a22cVyAFzb1UQ8StOZSi8rdcQZpjchP7AlehUYG
 9E6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5d/KCjOomgKDhEvM1T3lormN8XRkwxtrm/74Hy1Ljno=;
 fh=fMfr6U9vqZWyCHK3rqr7ZLaoP9Sdvf4Q6WFrB1e877c=;
 b=Ds81EH2aLh1CKSkqRk1rIwZjFhUvfH5MXp3s/TvwykOnqxyzfJopOZfKXOaEyKdEq1
 Sw1saL88a9A3GE5vdijkcl+qPAPh60WcrkuSUUT/2NB/cGTJFuXtkMRV83FFzT0BTOE5
 MOq7Ocvgo+nq9fNFJ54rjDo+YN8eOmJvbFIR6xsubBLqmoJevessAwBFnlmYt72vFqa0
 k2DPBS5DtLtbFgwVPYgKd22z22oPQjdK64bfENlPIPJ/KqUKynvq6eNxVfX/TdSTWdX4
 Du1ifUtU8l2tC8mNtla9ySGE+V9lKUuezEIjH1+OdIyq9xo44XvDQ4q5oI7N8iyE1NL5
 QNHA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787562312; x=1788167112; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5d/KCjOomgKDhEvM1T3lormN8XRkwxtrm/74Hy1Ljno=;
 b=bSJLwajJ/JzdpFYRYbdgrEoA506wxktDzf3NXHcwXU5oB8HGAR6NhjRPrqqfUtR5cR
 ubJclHnPaVLXcRoF5/sH2IiqZe2ORmhm4bCVBVM7mt1YPbn+Fi7R0rLdLMwVdjUKcm7K
 5F+fn7oj5P5RWhwYHP58s2lfM/fC20kzS7WugIwZMA+SHbO3WL8ffm1s1pgjkE7Dn+11
 KyAZcxblKP/VFjTZheX5HHVODCz+hXCa9w8y3Rpd53HDrEP7Xj8bO17Xp7SlvS1aGPkj
 PDTCQOKMW7YMeYtu1+kH2dhW3DjkzQzf+APFVo3+se0n+VGH/U0RrbfTPiSVN0WXbYU9
 CG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787562312; x=1788167112;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5d/KCjOomgKDhEvM1T3lormN8XRkwxtrm/74Hy1Ljno=;
 b=Kv1T+6ZcKUDM4CPBYz9wjpqmmvB60LtTJFUNcK8dzVzhpZJ8ck5ih2gW/1kqzTkYvM
 NOnVUdVH5scpfP4RXFYm/TIuewD8sSY00vA0DRn8nSeyBQ9sm/f9UhnKARSlepATLbPE
 CHyzV3FgJjnKkuuIRyREsa2xWaM7eYilMkwWhRsmZ9u4wQDMbDueI3S+7b2YJNHxRjJj
 IILjlihsmHgJnuDC7thrkBmfne7JiF4BpS3lEJ/9NI+nXTeiZPfozU2atDHJI7qen70f
 QgEcKUSUYv70czwcFdfxEef4gU6X8DswOO+dByUYA+Jmeo7vMvGADwJ+ZAHfF9++mNtE
 UtBw==
X-Gm-Message-State: AFuF++kp4d6LopLeVOLbEYnlEHpyfztyWR3n7mmgO9lwmriveJvUwSgL
 TSyUYME4X466YKJ0DGBHLxwjQ0LMjOSdkaluLPFz5DWi2usaNGtDGUVCa73kXKzi4SCWjPzXTlV
 kLU10krCFkPu0nXhlcUXMe6ElVIfJSWhd/WYXCtSqow==
X-Gm-Gg: AR+sD13v1A5AJWhn3tqtwwtE45TFMKiV+YI3vB4bxcTzKV+sCyzIc6yyCOHAPomD5TV
 Ou8Xp3tHgjLN2Vh6JeCjBNd2xehtDDcBRCRoMWdPSnOMge+k68m7JdiuCfR3O5ChU57rKETwIzT
 ixG87zM7Ldf3VaX9U6uwsKWgyqXe+OaSebASqIvR8UzjuLvBsaIWj29snysI6sq+29jx4sfsZ1O
 kkM3ZJIsiI4KEA7j8hOITgiUq3xXzFvBy3oYdpKsME8/gK7aZbQMoNCKrFpTO8oBA4IrJFPxuc3
 R/KmQ1GMEr4bYkrhOpbaqLFakiVXdxWustUTUTuKxJAKZFHG3bG8kHUGAmFUqD+xWoBKMNwnFh2
 Ge/2at9G0UOG+hfg/UeT6aQAqIwGq
X-Received: by 2002:a05:690e:12ce:b0:66c:6167:92b5 with SMTP id
 956f58d0204a3-66ce4b5a4b4mr8050769d50.49.1787562311911; Mon, 24 Aug 2026
 02:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
 <20260818170155.1907006-10-richard.henderson@linaro.org>
In-Reply-To: <20260818170155.1907006-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2026 10:05:00 +0100
X-Gm-Features: AcwNN1UZ_TS2PDAtPNp1h1rOQU2PLKHL9VSnFXrf9G_HNYoFa4uM5n-QCYaxo4w
Message-ID: <CAFEAcA8pSuhgPAoM0VbEsZUyVrw8NqVrtKjmpg0-dhM1y9r96A@mail.gmail.com>
Subject: Re: [PULL 09/38] tcg: Simplify bswap/hswap expansion using bitswap
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Tue, 18 Aug 2026 at 18:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Hi -- this commit is reported to cause a regression where an
aarch64 rev64 can now trigger a TCG assertion:
https://gitlab.com/qemu-project/qemu/-/work_items/4229

Could you have a look at that, please?

thanks
-- PMM

