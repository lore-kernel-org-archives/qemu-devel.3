Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8F3CCF9FF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETuF-0006YG-TT; Thu, 30 Oct 2025 10:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vETuD-0006Y8-Ux
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:45:37 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vETu5-0000vy-1h
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:45:37 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-7814273415cso11103547b3.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 07:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761835520; x=1762440320; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9J9wHQbA/kKVr0yq6epzgo3+TVSD+4ue8c/WpSXMd9g=;
 b=rM+PMXtFei54I9Y88tqWVEVyuH54CO3EdjH++0xt/6ohRJcJfRtWs6n2myt4j39tg6
 3jokAn+OXJVcuHN4PQWPsHlS63pYCc8UGRJczKv9yjVhmVWfc61YrEIJwD5fJr8GxavA
 ej/PPz6RFtVIp+vipQCCeEDq245vSz0pFzYXz1XRpJ/KA5z4zNJGPNqgP/nMl6LE4jIr
 0aTevLgsKKzpAwM6duWBzv/rmEeT55gmt8R2LzEYYiHXGEESf/ZCDU/8mBj6w1+ZN4CX
 d41C32iJzd2pYcuGBWWNJNTlFYjzoVnMcXnaCVN42cG3FqDA3eyZiWn15iJH5IYaPBPY
 YF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761835520; x=1762440320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9J9wHQbA/kKVr0yq6epzgo3+TVSD+4ue8c/WpSXMd9g=;
 b=Py3/M9k6tvx816aq49XT+AqVwYGIxmhUQkTScj5lk2jkAIDK3Xs/+wyf1sk2MnRVN3
 +2bUUqtE3sLvTMsiYRme2K+Z6bdVH5j9X26iQJVMfvq5YUc7kkTXlsOz7C3OWjS2Tnr2
 34K7dwytXugqvf2LpayGTuNc6861MCkkN2+8sSYdxuitfwoZH1V1StcfGL2sbKm93XNX
 3TYQPUkVb1hinB9Dw0ZAY0SKR1+V8r7WS1uhoKtpxo8JsFgLksBx4Etc7p4wVl3Ll685
 WwnWkNub/HZXmy6lempdBzszyt+RG9ePw/UAo4sBxz1JM+dT1OXAQOjg1f8Y0NHTo77g
 2ubg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN5dYYcMZAinJwvC5AecLYAjPDeUrMtIutxiiWjd5rYvzYS0jRFCMXVh/UZkHuM4oWjo4dHkKaEPwL@nongnu.org
X-Gm-Message-State: AOJu0YyFEi0UJ+MCxJljWB8XXoNq12B9X8r3d+sRbsDgwZGW0tv2ey0U
 V536AmZM9gw3+y8KvRhnJ6miGRHv9QU+AxBIRLg3hYX4xb5fpLrQclb+xoC9cDEpRR2HUpwOvgG
 RSDNwc84fFTq9SUWkwYWH/1i79xiBLa7b2Eo+XO0LRA==
X-Gm-Gg: ASbGncvj1p8Mx0FTc2S/jbWO3Fs9bNosU/eOnYBHniFM3hUHhubo+inIsWekjOFlYkq
 WYbYAGczSSyR7C3M4ocn8ceQaPNXclLD/tkMvB0dGEPdQM9yj32B9bfwG7pTMTmQMM4UjbnFnhT
 diZeVD7sfgKML1M3fG+7dQyhIn2ks4E176/Mp+NZkgh7iQvbKNhrEhYHcAJCVmLD7jrgmf9sEhA
 AZKckiCVqVuASlsNJVLcfVL0OIwamXmOHn1VkbDdrDDE3HeESfmv1MBer00HRO7ecxm0kbT
X-Google-Smtp-Source: AGHT+IEsnvZS6xGb6EPf/gXUlbr0EUx2ubg4X7NCniIB2axE39qiegQ7bVBmRbZxtM3L8GP+kyb2iZ2dQflkKCJFmAI=
X-Received: by 2002:a05:690c:368a:b0:780:fbb7:2bd5 with SMTP id
 00721157ae682-78628cfa811mr59585897b3.0.1761835519581; Thu, 30 Oct 2025
 07:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20251028080551.92722-1-shivangu@linux.ibm.com>
 <20251028080551.92722-2-shivangu@linux.ibm.com>
 <8d5a8cce-d769-4cd8-9753-7e9ad37d8a47@linaro.org>
 <dio77m3m5jj6ccgqpswkifiqztf5fz45qsjpspu2yszgwrfgha@mcwjruxszkn5>
 <47ac6382-3270-4179-8455-43cee36a9ca9@linux.ibm.com>
 <c089e14f-69a3-fe9c-cc80-b0c7bba4105a@eik.bme.hu>
 <fz5bixswyqecp2tgbobkz2vlncuhdm4cxagdndn77qpprltssl@opqtjw4ixgpk>
In-Reply-To: <fz5bixswyqecp2tgbobkz2vlncuhdm4cxagdndn77qpprltssl@opqtjw4ixgpk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Oct 2025 14:45:07 +0000
X-Gm-Features: AWmQ_bkUJ784ocrrzm4RkllAxfGQaGYV-BBcNlR2atYFtbqI3EqtgsWBZMpu9fI
Message-ID: <CAFEAcA8gZ5MEJvabd__asKLEA_+jf4=SPKaAy952pr6S0oJnqA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hw/ppc: Fix missing return on allocation failure
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Aditya Gupta <adityag@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, sourabhjain@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Thu, 30 Oct 2025 at 14:23, Shivang Upadhyay <shivangu@linux.ibm.com> wrote:
> Also I noticed a pattern to use `g_malloc` for critical things instead
> of `g_try_malloc`. But it will kill the full application if failure happens.
> So maybe just `error_report` is fine here(?).

docs/devel/style.rst has some notes on malloc choices, including this:

# Care should be taken to avoid introducing places where the guest could
# trigger an exit by causing a large allocation. For small allocations,
# of the order of 4k, a failure to allocate is likely indicative of an
# overloaded host and allowing ``g_malloc`` to ``exit`` is a reasonable
# approach. However for larger allocations where we could realistically
# fall-back to a smaller one if need be we should use functions like
# ``g_try_new`` and check the result. For example this is valid approach
# for a time/space trade-off like ``tlb_mmu_resize_locked`` in the
# SoftMMU TLB code.

Since we're trying to allocate 32MB at once and this is during
the guest run rather than at startup, this is probably a reasonable
place to use g_try_malloc().

There are other places in this code that use LOG_GUEST_ERROR
for things that aren't exactly guest errors, so my suggestion
is that we take this patch as-is to fix the logic error.
We can consider whether we want to try to improve the error
reporting of this group of functions as a separate patch.

thanks
-- PMM

