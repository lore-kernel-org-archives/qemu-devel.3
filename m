Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8686DC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvR2-00046q-DT; Fri, 01 Aug 2025 15:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtq8-0001Dt-7h
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:46:47 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtq6-0006yr-NS
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:46:44 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-71b737ec362so9199557b3.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754070402; x=1754675202; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JCuRV6cLzx5d+EbeplFae4OP3RLND2cQiCwl5I0rEj4=;
 b=T9SWJy2AmExAxgQ8WoKCrYLm2ZmIbpQmxzSbbBifFAz5me5o2aJjJighpX4iWVS1QS
 zuX+NxNU2dU3v7zqy/oyQ7Zd544zU6h8SwY1oRx/Nyz8UfREQE56Sbj2gcyoEgQli4gY
 s7ZiRp6vSmOQQl3xfxyq7DZipKik5hPWJ2r9X2XtSGpV+WNxwHwLDDlJNdUDxQxcFbPI
 aGJ0wNKuJ/uZ3RttPserJ1a6n7tNceFEqfwmDN1ekKJ3XMwo0ZcEnZ9+g1wPRUzkMdD5
 414g/jJVZBvbtwDf+rAaJHsyUqHe3Wsa2ysb2U57sl1HMj7ORTeETNL9kXFrqgThNloq
 M5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754070402; x=1754675202;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JCuRV6cLzx5d+EbeplFae4OP3RLND2cQiCwl5I0rEj4=;
 b=FIDHsjmE/IXFP1Sd/fkAfChd7a8odehbsWjZxx4myFPI7yopoxqAlLopWeV3rPO1/h
 2vjQoK5Ht+U/UU1Pz/B7F6uTX75JQoq+Tk+H7XRlHUfuHdZgRVl5yoqhGkJkBCPrNYBV
 yGTmfnbfYkZmqSnJgg8wdvqO4gRXLvpR3Fxxgkx+1AeGzms62bANs8Nualjo3fUdB+LF
 yV1f9G/Njv/eIFl4HsPrfrx4kESZaxOvB0LBbObpSvSYLWaX6Hz7bKCqSe3AcTP8Cdlm
 BmI7/kPplCFt7cMJxck43WMrXBp3Rue1IY6AaFtwBDEtKuC6QYZ8oxxa0xEt5QPyC/rl
 VPQQ==
X-Gm-Message-State: AOJu0Yx+h061o0QaZzo58BVeCwBxr2om0gWNBW09zyyiSolUjad+6DSy
 6D75zGR0zoHuhe5Xce0IrE6D//V3OlTniYeQjSQeNy+Zz4D3japLefPr1B9rJ3QXW1JEC0/knn2
 Af6XDeAD6V8YiwrCULTMJR5MumzA/hw1Nw+c43Z+WOg==
X-Gm-Gg: ASbGnctfRML/Z+NlS+2UB5gGTAHIJixY/MZYQpN5d48hlplGL1liLJxXA+XI5FKRT0j
 aMyf+dBdQ3ib02Fe0WyX77XIiQgnGZPLyJ/eN+02uEuKybyksBbt1bPx96z90cI6ugh7DJiEMBO
 ujwp6yb+B6EhrpjLzRcAtQwZ1hyvHv07IV2orgRmr4UABCWV2FUiwXWeY6NlLEiypWYbsiV7UAU
 NLswIf5
X-Google-Smtp-Source: AGHT+IE2NBU0EOk6BDUQQQVLGsfP1uSSn/VCGqvascVYnX9mamT7QK/E1b3uQLUyw5XdE6mE6Fhsanvw5IcaDbQbWEk=
X-Received: by 2002:a05:690c:10d:b0:71a:156e:ebaa with SMTP id
 00721157ae682-71b7ef5527dmr7305337b3.10.1754070401621; Fri, 01 Aug 2025
 10:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-44-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-44-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:46:29 +0100
X-Gm-Features: Ac12FXzlyWjR0VRZtMlBmXBVk4JLwD8ER_Ia5XfV2fkTCAPlMSaKrQ9TuIWbFdc
Message-ID: <CAFEAcA_QbTSqAX7B+O8hEONX=GSLQFHnYiAvjbwkunXug+9Upw@mail.gmail.com>
Subject: Re: [PATCH 43/89] linux-user/arm: Split out target_coredump.c.inc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Wed, 30 Jul 2025 at 01:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c                 | 27 +--------------------------
>  linux-user/arm/target_coredump.c.inc | 28 ++++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 26 deletions(-)
>  create mode 100644 linux-user/arm/target_coredump.c.inc
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

