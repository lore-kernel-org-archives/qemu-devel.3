Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C0BC5516D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wprMB-0007Kz-E0; Fri, 31 Jul 2026 13:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wprM9-0007IB-AX
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:49:13 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wprM7-0008RA-VN
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:49:13 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8114a4542b2so19731707b3.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 10:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785520151; cv=none;
 d=google.com; s=arc-20260327;
 b=HTm4IysQ3H3LM+MtDFPwZGKdAMQswLiF2n3aII5vyqJS6w5waGXVg5jQfsxpAhw6lx
 7a8V8cmTmeEzR0PZUNF4rLOskKNU6JTCWHEl6zh8KogvEo/NTk2vxfATzLUl96YmQT4i
 zE5oV2Kb6jlCZOeDoudZXqH1soTUBAwx1qJ1lfoiAL/q0/ERzuuLNViCyNvmQYeG72B7
 dfjoRhmCShaTttYe4oqPyr9TB4Go1rtxl7qXEGmIXSNbZ/F56thihnET6eMK/0So53DZ
 o5mxM4E//VxYgTnhjGwtgikNNgaXpyuYc6u3L5DtL+0SEf6KZzpaS3uJzHDcUFoEPLwK
 B3LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tg3KSb9E5/pqu001+cu3W/Lq1boDE3D0/BkB1VuNc50=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=EK2gsyNtVQ9QfgBbgmYNGvMTQdXsECeiUxX6Bp9dvE0WQZ1RZczoWYYR71JbXdQDdM
 El6yvBmMIQRcpXSQ3DOYJmZgzXg76Gb9xMmObR4COD9F9zebxxkquCEN4ueOXiN3Et6J
 pd7vfpaGL83Ev8mwDGlQPPyI6CtQm2w4Lq4qZ1fOYk6/NzSZo5Js+SZGwrVT98fjdId4
 5nC+kedp+kqC/9UOpmpyQlHpBTyw40J6UV/sZ6A44Ixq4I0jf4EeXBdVuZ5DiscG+Fi0
 pKbb0kVQBJHew6vXnGbGaYOXYTjy0iu0wYPVBKSnVN6bHJbfe9jLJlkI/Qg7+min0Hlh
 8WmQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785520151; x=1786124951; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tg3KSb9E5/pqu001+cu3W/Lq1boDE3D0/BkB1VuNc50=;
 b=DKpep+Dex8OTXkRVosTwsfm4tmAJpQiekNde3aMJ6bVkjUKJhtMlVWGkQJB9HdVOWp
 G/rDeljvrfWe5WL0wzU7ZDViR/RcRmjk7xV0rVW/POUjKxC6imRQnUe8Dnb6UoHnLQ8i
 SwbNp0tsdka2lDgUVRKnFlKdAvKawLAm/FQpceLOGt7lMW/9PGPnndSpkO7yLiihWdDu
 4+SyK/BMHuOeve92kig2xWNWB5y5GP4qQ8goELmu759r0w3cahgZN1OX4CyownFNSB+Q
 iYaqpIc62T/UqkdBXZtDXyUJ6Alp5ZjhzsL56l/fXamMPTmx+okT8shUyTJwrn/CJvQH
 jWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785520151; x=1786124951;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tg3KSb9E5/pqu001+cu3W/Lq1boDE3D0/BkB1VuNc50=;
 b=cdTmwNfN00MNLpR/8SjS4JKnAhGJyc0jk0X++a9404mwdbMCYlzBtflEPiG+Y0cmn2
 /G1aAf3NWZo7ga+2DpWUUzpe7zbwYXQW03Z7rqrSfM7Z3CMI+b4oETDiBFeXiXRGH1bG
 OKzbRfjoaLX/VWxaQxO4rYd+9cZidsUtVzSILjsy0gKL3S78F8C8ixJ4es6bz16+QcHs
 MvhYnn6sXBkxW5mhe5jdnD1jrJqGsEyEv8rMm6ZqB6Q+OxAfulVsueTYukc/bkSjS6pa
 SxObqgLmN+7vdsWKwjb+Prk+wEDM7LA83gFCsHfujltARjvnABi4vlIWt2JUns8uAQbb
 TBWw==
X-Gm-Message-State: AOJu0YyI0RwAgAjwQ+5aPC7sXSKFHojCozCXImI1n/B3QzHvmac9uZLw
 Lw7bl6o33R82WDDXp146zdUN7yYOIfd5A84mSR5IuUq0ORxcBU7kWH1pNuUynkIPgZ71T3MiFed
 3nNhV4ytXkZBK9OnRadmOVI/VYY84M7uQMtiezDgeKngnM0abpUSK
X-Gm-Gg: AR+sD13Uutb4DtDZ5TE6T/ovuBO+oG0ikIC68cbpXAUCnzdc/B/Bvl2V+DW4FwTB3dK
 CqGtpnh2pR19+iv913rHBKOczuyA9cKdZ7H8eP/XxjjuwKy6EnDUMLgvhYv6xGTduus71Yxllz5
 96NKmmpJXKmxW5zn3cc0xK8ZTfQybTEzrPMkoA9h0KSEmkRWHxgdFI2r6zO4m+LbiOXAxo5CQ4S
 c1tCoqAbT3cPZfc6dOdlP2Ap0bXreIz+fusJ2DMfZEUuHw62kewGxq7Kx/ECo7IjeHJllWw+1XU
 oTd8BpGp/OM0pYLaGJuAmrbOmHqGbQEojUKAmb/HDI0tp00FHHqX/UeaYWBxDXvzaB46UeE1C3b
 Uk6HP1bDhy9A7doU92FgNTQ6mY6wT
X-Received: by 2002:a05:690c:670e:b0:81c:c77b:3546 with SMTP id
 00721157ae682-81fd4b5a1fcmr10601587b3.21.1785520150569; Fri, 31 Jul 2026
 10:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260724031123.76597-1-richard.henderson@linaro.org>
 <20260724031123.76597-6-richard.henderson@linaro.org>
In-Reply-To: <20260724031123.76597-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jul 2026 18:48:57 +0100
X-Gm-Features: AUfX_mxGk2F8aSh_JgVQt-7gXRA-omlK1T6Zse-BobWTZnkcNJnAUhbBzMBme60
Message-ID: <CAFEAcA8z9R28Um+ympuZ7xcAJoCn-EBynxRN=SGmF-XT+bi-0g@mail.gmail.com>
Subject: Re: [PATCH 5/6] target/arm: Implement SCR_EL3.TID5
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Fri, 24 Jul 2026 at 04:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

