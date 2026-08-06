Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E943DC56205
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 16:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws0xP-0003GP-9J; Thu, 06 Aug 2026 12:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws0xO-0003G8-8i
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 12:28:34 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws0xL-0005Uz-Tg
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 12:28:34 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2cc97653887so28683455ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786033710; x=1786638510; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AEQnROxPeiLVayVjIWXAfWCCfoXfgrW5OLqp5/Dmi08=;
 b=nZ6EtjJgkQAmsn/1FMWhGHLXhf4E9m9uUz2Nbv+HOriPmOJW3J32W07cT57O9JDvZi
 c9sX3iIcX4z0Nvn03tgoxY+y3kzFNBMOKv9fThye9Dcfc+PpHGT7J224WOs4wCwHKABi
 sy96WEstRn3Zd5G9xPy8t46pPSHvWYB7jRidNqaOtrQHC5scN3uVor6uS7sW4Mr1OZ9C
 cLEHpWjRh5NiYAtoxWrD2jhsksSrmz+YhfEBKZQFT3olYyw0EvBgz0YmG6rNw51jdxVt
 kfDCjvQTx/GutxePnK8JOShVEu7WLgio8kePeO38kfmB/tID1GsVWzIAkj4rgTSbfYKV
 wWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786033710; x=1786638510;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AEQnROxPeiLVayVjIWXAfWCCfoXfgrW5OLqp5/Dmi08=;
 b=pC13CaI3Yr7mF1fgoGoPqYTkkCRX7WURZo9svNpK0Y3r90lLLww2krTCyX/igyYA9q
 4zGV3IsotTdioWiEHl7inKDJkGuOlVs7NE73rNCs0qdGm4xYnhIatUhwQG1nqM2Z5hDZ
 jRr6ZInMrbO5bS5182fMSLt/thW0L9ktBvyM/rBlIP0jZiuPVOnSzxs0Qi0lnhLdSP0r
 rrscJbmaWBgZEerDgiDe5xkEDrmsaryLtNnsY6qSmaJTHNcEn7pqBwJbdXNo9gcx9gVc
 SbY4RhpkNxrhEhQR6ZdWcwtNebxZ02Lt0FY8DJX2zKWNlJoQMBWGLk9gFqORa6ORpBTW
 85fA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq3aG+W4DVSFU8MskXw/7bsnyVZQFoH13jynlXS+wSar9XkFtrVwVK0tXX2mm7sEWTxWCp+/FUDK8wv@nongnu.org
X-Gm-Message-State: AOJu0YxukTfYq/mBUGI5j2133oSJq4soNYj/yKojxD0TAFPQWmuaRgWV
 J/YoKIblDrmiySCwVsPE83xGJCYuZ9LYwC9rq0+uOX70gOGjlx7hXqt1EMENqkhhRAE=
X-Gm-Gg: AR+sD10QDc45zXW8/spxQthKy2EQScLJQD62H6zy3Nd2BsDP7QYhbElYpvAe6GUtJfP
 KZKdezBK7qqoQzNeppuWb/dasE0Qj0hXOmS14ECrIn0zaiEOkpvUAtklJUJe5rHYpQKAo73H+r+
 Tp1/XVSalg8DmoWDTE9/3wpeVx/CZTQgVUWSdxF1/+d//GNM94OomX1sdDIL5B3Pzc7jCTn0aGV
 iyCS+vkJ3Rg61B5kfNHe8GObfmiEyVFCVj4ONNeBPLp1mQwz5JfnWSEluVjxtZi4+Jd2vIPkAuu
 Sz7vDYRknotiwTeOJSjb5YUoqa8JbbHLf0JFWpKQ7JPxuwJe9HD30t/W8+gzoMhhHnma+lGBUic
 F0km48OQS/UELS0TvBuCHxEgRRy8CklT+XThFz6LIsYZjtbwQyn9QrmTwU/uM+yL0z5C1NocDHq
 hGcMot5K/N+u1dfD6fWjc9BlrvB+Xt8lPmuGOtErUIdF3u51bZLbriACENk7ghtxFkD6UgRQr2F
 aD5tyiibHHJ2bCb69fEASzUfisx
X-Received: by 2002:a17:903:2450:b0:2ca:e19c:986 with SMTP id
 d9443c01a7336-2d0ca70e87bmr164843545ad.1.1786033709835; 
 Thu, 06 Aug 2026 09:28:29 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0a9f8fb4bsm34776005ad.5.2026.08.06.09.28.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 09:28:29 -0700 (PDT)
Message-ID: <0d0c9cc9-2952-4823-94db-a0203847109c@linaro.org>
Date: Thu, 6 Aug 2026 09:28:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Clear OF, SF, and AF for fcomi/fucomi
To: Simon Scherer <scherer.simon89@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20260806145224.184019-1-scherer.simon89@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260806145224.184019-1-scherer.simon89@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 8/6/26 07:52, Simon Scherer wrote:
> +    /* OF, SF, and AF are unconditionally cleared to 0 */
> +    eflags = cpu_cc_compute_all(env) &
> +                 ~(CC_O | CC_S | CC_Z | CC_A | CC_P | CC_C);

There are only 6 flags, and you have cleared all of them.
Which means you don't need to compute any of them, just

-     CC_SRC = eflags | fcomi_ccval[ret + 1];
+     CC_SRC = fcomi_ccval[ret + 1];


r~

