Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E71C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wohlj-0004E7-2u; Tue, 28 Jul 2026 09:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wohlg-0004Ds-S1
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:22:49 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wohlf-0004ZR-48
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:22:48 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-66807ba2f0fso5040250d50.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 06:22:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785244966; cv=none;
 d=google.com; s=arc-20260327;
 b=e7zZlRFRYqJJEpYHl3ANZxCxx2eqlKZGqFSvqLlE/OfGAlB2jRB1qBeq7YeBSyBYVd
 Vi+oB4ajQSh29b1aEDDv70T5vjMN+DH7UDw1A4XmIZnUgK2L/D4jPF90ZreHh0qPH2Yc
 mQpiF1g08kbh+sepaTSAzp63s17Q5MHchOk9TgvV6Ri7oB/6dXu44TeR9NZWmch96IJR
 6hLP+mkTpoOmOP8qqzh62HirgWfJ29wyfxx5gICDsmCMok7LZ5UdROmrU/jTddP5LD+C
 j2s8ZGgQDUnNgT4HqH11T2zPXAEpQ+K2grTRlH3YjMx5rNOXlFP/KvlQX7pDaE991era
 5LCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dg+cQhw1P79xDNwC0bgZO5F0AU21hjZ1JN6fS+THde0=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=npPo5Sbk7+Z6fsERJ8pDQy0gJBEwrybqcBg3JlCCpfH0FFTHjK3lC52Po9a3jos41j
 KGWYND/MbShWEMx3MYZRwnPXTO6B2bezEUSjI36d1DNJ8GT9jOeNiJ0qDEKBHyB/j+B6
 dTrZQwLr7Q7ftY0CDGh8mcaknngLxM2OT4s3a3Qmc6EKSmeQOqJ+v5HEiz//rxirVMGr
 tVEH5gaYXFYNBYvK5NPbw1KupjKVR56O1Gi5W8GWQP4OfJ8RfH/xFrdoWAj8LdJgbaf+
 cOqeCXv9vDQC9CJVtyQXuSuCtbVfuXl/tkpDFBsHJqhzOdnhtO3NJJOY325zKqRy/n+6
 L4Mw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785244966; x=1785849766; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dg+cQhw1P79xDNwC0bgZO5F0AU21hjZ1JN6fS+THde0=;
 b=CpCQF0eZoO/yuaVJLZbuAKsNNjBCvfPRUDgTLCtZ6rfwqsd9IXNvEC+un5KD2GB8cI
 z5aZDIREALWRLwwF9fT+D0AsYqXYcmDIx5eEl1HDCbKOR099YIC8CYgxgYu1rvI4a6Fj
 Ox1GlniKgeGmvHFBXlHmod+vE3VEUVu8Z3Z57pWX0mrBf+sJvAuj+cE/CUwdbTqCUUHB
 TtEWAtGxTnGhbc76kGiVROVUri6sD6nNoNzSY5FkE+mjVz5B+U3RLjjQy0JZDrFFzwWF
 LhYJ//tPC4JsFgYZu2Edbloy+OOu6HagkHuzDcmR87CDr7Ory6ii/iDCw8hgCe/ZmRha
 1TLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785244966; x=1785849766;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dg+cQhw1P79xDNwC0bgZO5F0AU21hjZ1JN6fS+THde0=;
 b=aKLnn7Q043NYGj7+yMRy0G2iZoKexYTZ6qRQ+IYA6/qci06xbdA4557qxy8TYF1lGC
 mgNicGMPyLXnSsRYnGxV5lBc1j9QWfU3dCXExX8hEAkoTu7YKECpIWs+CJE8iOs4VA3V
 b8vKtSUDDNrw6igZB628z5Y6MkSrvfDdaN1LtCfCTY1+BbIPWuOFFhTLcliPGhrHD+vf
 dt9YsTn2kHbfF0C/GA0pd1pe/ZrxFbok7RCKelE+NCDx6VW7hz30VLraFKGthjaiWyZn
 li80VqGvgG5ECOAjOzGR6U1IP/aHpHFNtO7Py+qe8hh64QZ0HlFNhhSSOiHX4Wu2mqx9
 fd2g==
X-Gm-Message-State: AOJu0YxrEj9Tv/eZpxw9UI0fL6754qhGbAZ+0ZU0SaFVnN+lg3k3dxAF
 f8tHod7o2fOGPIRWzlp7gE5HQzLG4nO+SkYmCoLQ4OuzJ/yqdfHxS+Vh24CCEKg33oexfYJAsn6
 1JokaQaAwIdOS6gTqLOUFMSWv0I+sk3QBDQQMpgrhyA==
X-Gm-Gg: AR+sD126f/uQFno9kBJpNkeHyOseLMhPYniUZ8xsu3NddfFMS1NVh5la5xAMFcj3FNh
 pJif7B0XJGVVtONConJtn0oZUxbxbcFQpXzC2dTbh4IIa+6qbcniroYd5uBwXXC5EZQb3O3gS8Q
 3WcnSb0Et1AYKshSXa0lTJYN+yD8ALQy0RWqZ6v5IckPlWg2aERPvCNX88xdO5YkeOwulO33wSS
 nyYijREToVKty7K0RzMu/MqhJRJCP45tS+Mp28B8Cc7O/wGWupr5MGDKEDvARLeAdRA99W2Y7c4
 /X72WoeI6R+iBNhUNvsEocX3/0iolGoyc0jLHJbPWsIS8Kk1MilKIXdo
X-Received: by 2002:a05:690e:4548:20b0:667:e412:6add with SMTP id
 956f58d0204a3-66905490791mr603360d50.9.1785244965478; Tue, 28 Jul 2026
 06:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260713230244.70174-1-richard.henderson@linaro.org>
 <20260713230244.70174-9-richard.henderson@linaro.org>
In-Reply-To: <20260713230244.70174-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 14:22:33 +0100
X-Gm-Features: AUfX_myMdN0w0AuWVElSisOp64PlLAX9-N4neSb_yWocmftwb8RvxtLzD-dFwXU
Message-ID: <CAFEAcA-OkMNpdu-6eJ+ihQY2HSWTHb7589ZSk5wQMPATvbpFEQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] target/arm: Implement [SU]TMOPA (2-way)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Tue, 14 Jul 2026 at 00:03, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sme-defs.h |  3 +++
>  target/arm/tcg/sme_helper.c      | 12 ++++++++++++
>  target/arm/tcg/translate-sme.c   | 21 +++++++++++++++++++++
>  target/arm/tcg/sme.decode        |  3 +++
>  4 files changed, 39 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

