Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DEDCD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waZYR-0002pV-PN; Fri, 19 Jun 2026 09:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZYQ-0002ov-9y
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:46:42 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZYO-00017J-OU
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:46:41 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-662b95934dcso2163503d50.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:46:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781876799; cv=none;
 d=google.com; s=arc-20240605;
 b=JMNUTyywwa3d4ZPAWDQv7E05rOEHjjGgNAHfQSurxqYgxXNBDGKkRLCxgEOfNuOg4D
 XdFjD5n1UPYCnxvDwwG98bLGNgrdv7w8YP9SmoyEF8rWyjL39NSYJXQuo0A7ZkTCGwW0
 v3mwPdQ7sNlEBQIWjb1ckRkpGmz0oDNeFd7b67dOAp5EJ0NYtnkFOSa1jM+mk1ipZVav
 nDmojDnZHmbk4XkloUPbXHg0SSfgbi+1CG6MfRsljNeP0EZJHzAMXnaXP2745Lvj8kjg
 1i+bXfD5xAnGqBhih7eoEk1BVuW2GFBDSEnL8ba/DOlELKvf/EBpqr0BXw+LiBmdvDVL
 ZEpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=o70uc1PPgHqF8LTvbKiopBY04kSIrgeY4U7KWcDSt/0=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=SVTsiVVjxWOEoetuqXloL9JQ7LE6FtGyAfjKKB52E7qOHoudmK8p1v/scj1vHPZWAv
 eHCaoFkEwrhLqtA7dpP6VoXbgzz7B4wsODkmKCXUQfBUtOtmSUm7udDCvACNkImzbTeL
 2hZNRiJgDESL4gIzMPQ4Jcn+Fg2t3Ci6b6ntbPxN8RIKN1bZeQ5cCnrnsl3RTv82V42k
 7QZQfCyXp1Ueh77sRUy3roZ3ezEfkuCfPMc/jrxsyYa6qNo3o0s68DVy6bVbJpKQ6bI7
 lop9G1XagUpX5i3ShRb+lgTqOFkrDoRPwxXO7Idi9HQz+uYKUKAtfhgHDw9LXbo9A32B
 EaHQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781876799; x=1782481599; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o70uc1PPgHqF8LTvbKiopBY04kSIrgeY4U7KWcDSt/0=;
 b=VoaRV6iNv2Ozw0Jk3x2PHmy7X0ar2WfrsGESXihR6acyOFrM2ddyH4IT/jf9A9lSr5
 RmCQranQswDRT/Il/fX1Ojiple0oTbhV1hP70+z+2xAaaCD376Gw+dGe0KdpBj9pT8BG
 NluA0a68QkfkeVl96/oa7byPwQI3OMsJ+q0JzLGLOZmbDFIMT2qD+8r1QjOuvgyEjD1g
 SsoEveBuKojjbF5sjpv6mPMA/VxQMX0wFzCY5eXMqXgGgnD8+fIoYNeRN+imAa4jkExS
 /+E83z3oP3dTbcZz/IeU0lJ5JJFz+1lN6MyVeG9Nr2rYPqQAXE3dCF0r7NdBG5qvngaA
 cikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781876799; x=1782481599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o70uc1PPgHqF8LTvbKiopBY04kSIrgeY4U7KWcDSt/0=;
 b=FKfa/SQaRIHk+a/SZXff8arAYYN70kvUxGAH9jjvbNvMLWc33GI5z7/POeso30VXn8
 gdS1tQm4XrCvoFy5bxmMDi/oWj0AKbDp9/f0TZSI4i9BHdoWb2+yT/YfgXprpyKqLmp6
 xDQwaG9MYhXJjjijV6QuPxfiESe0pZGcQNalDyf1NIr4GHZ7wuuGPt9YCPBwMrbMlAnC
 kp8kwss6fNunwCl5SzsDJ/KFMQKKIzVYsZ6iNU0DFeN3Q9/ATntx0wk7xFS6LFLebre6
 NyASjtYGL44aXVRlsP7txvKKORcqVVtqSIX2AyGJI+je7K/p3BU94Tg/bLTEgCvQnCrS
 qf2w==
X-Gm-Message-State: AOJu0YzZAATGcdiMBat2+yEHMTqYj8NZYllw64xnpMcICKrrKCRy6Kf7
 g7JzN9hK/pou1wfBcFP4Zmch4Mf4UKukQLv2meWIOyqpEVuxB5acm9OW9xN2dBouT7UFVj+uXmb
 ELeQUvVexDlf+ZN+N4B3k5eT5nBk9q+/P0KaI144dTA==
X-Gm-Gg: AfdE7cnUZ5bejHbs5KNerPHbYpvcCkeyOrTZHX7ZnActG5ZsyHqEdgxA2TmiE5j5Xtk
 WOrqkpjBofCYGkdJTtKYcUq74rKbdUo+IlVD9OH4X83EHXhsd1wy8ye94k+zXhGsmDwteaTJzJz
 AQ1GRHhShUra0B2gjtWiY1y1G5nNwnahMxPO4BrZvqdtj39CyhRBAdrQUQvkyZSIbpuIuTs5u44
 brdhJU7m3rWetfOFX5mDo0W4cX32OYzdBN0QJvUF1NSUXz/VujYXxKTQrXT6bS6qqGZTkPazzry
 toPWFT9Sn8pjgOKkyb3vx6v3es7yxncXkVRGJ8JwE+UMd4VqLFcojsMI
X-Received: by 2002:a05:690e:d0d:b0:662:eb42:dc36 with SMTP id
 956f58d0204a3-663036e75aamr2126382d50.53.1781876799407; Fri, 19 Jun 2026
 06:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260618041517.573469-1-richard.henderson@linaro.org>
 <20260618041517.573469-8-richard.henderson@linaro.org>
In-Reply-To: <20260618041517.573469-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2026 14:46:27 +0100
X-Gm-Features: AVVi8CeRIdzoIUGdYkpEFGp4YzSJ1LMfs2GO7XmRREMsyj7X2XL2ZfJBN93F1tA
Message-ID: <CAFEAcA9mrB8a+ochgYeKOPdo2kdccGFSB2wiBuCxSso6P=TB2A@mail.gmail.com>
Subject: Re: [PATCH 07/10] target/arm: Implement FDOT (multiple vector)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Thu, 18 Jun 2026 at 05:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 1 +
>  target/arm/tcg/sme.decode      | 3 +++
>  2 files changed, 4 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

