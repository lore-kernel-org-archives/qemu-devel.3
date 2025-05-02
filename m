Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC99C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 12:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uApi9-0004xb-IO; Fri, 02 May 2025 08:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uApi7-0004x1-Hk
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:41:47 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uApi5-00068L-MI
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:41:47 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-708b9b5299eso13722997b3.3
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 05:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746189704; x=1746794504; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IgowHAI3/kZtlh/kj+syzyZsBmIkO2bSa3hEw3inqXk=;
 b=H9UWGB2oeMZOjCSIiyjDGNtLm0+b8FDy07PiCDFBiwaziAr1/XAYZRiSdfuh2RcOJt
 XJXVGczIoIR8E99ZsJv1HECmefHvf1IUS6zmp5ZvW6/WuIXepdb/RLt42hZ/dK/G2r1D
 s5aVHW3bYCatYEY2mFKjo/FAFGwrh2vzX6Y0eZSiso97qip0ErD5tsd0Iof52GJjhpFZ
 oIl2VFPnQSX5xSBIE2FA2hXY9NLbPIA4NMxhowNqjVmQbTzEoiaRu1+25QxO4VkCjo5L
 xzZ2pS5ydnEHvdQo+tl/M7IiW43WbHTCKW5vzuO4EiN3FB97lVx8/rHU7Cq2nhJqawhc
 y45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746189704; x=1746794504;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IgowHAI3/kZtlh/kj+syzyZsBmIkO2bSa3hEw3inqXk=;
 b=enm19HK08CPA9/SLxRrHeZ++BEyCwA+SKYt7NSj/7ejqqM52UDHIaOO10nLZV9CO/U
 +NaHygcqR+qkwbjcMyuTj7ZS7CPhk1VpcLFvXmihfpJruyBdgYb4bXN+7Lwe6Xz3HVuh
 1fuEy7+T5iBqyIG45tTC+WafGjRDBkcz6rYSpMU2FoEFS7/ERom8UiD7F6ulhcrbWNfS
 FKIsPqXwnnZqNkrHZdienBKp3Vo/29kNKwOIeakhmLMhoIxzSKwvX8mSwRiY0XAq50MC
 KKhwOC8JSHSDm1TUdyEyMtFu9jqEURAodOtkNDB1st6Rqzj9KAeE3KuCqkWRHJoGzvPO
 AW6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0uGVgWQKvgupPUl1hx2BP8NM/4rvMVFslin+62Ox7IMYAy2ef7Sqro7TONXOneKGmECFBloW6HfJB@nongnu.org
X-Gm-Message-State: AOJu0YzkIWwSAqekeiIqEEpCJgrxSgOBY6DgE/nyMGo3Lc6dRDgtKcaA
 dGx5C5HVXzucmO2eCtKTNVGq9gy0lLGTgl0e0mHvDLqAVo8+pRMPQxxdVoI+r5XNUlzECpB8Ksy
 eIkMJDAzO8TwL+FjkZhy2Bo4ha16y3/w8cq1lYA==
X-Gm-Gg: ASbGnctYojQP3WNzYvshKQsW/tKixIKc1CMC5kUNF+DGxqRUuhVKv9JUbw+IJuhJdRx
 +98Ge1/vp1BSzbSrDf4XQAQvkGWfb2okIEggFdvhytNleZe27YgtqCaNmpKKIWgOGBunydnJRCJ
 FPDcaj1K4Hh+8WY+R9oepRBIo=
X-Google-Smtp-Source: AGHT+IHilamIVsWLL+jflUC6KGq0AiOgbq73QMNH0ZEQedooVm108PuLMYfvEM3dD9xjKDNupkNy7rxyNoFZl+xZA8c=
X-Received: by 2002:a05:690c:4b8d:b0:6fe:b701:6403 with SMTP id
 00721157ae682-708ced445c2mr44890507b3.11.1746189704329; Fri, 02 May 2025
 05:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250418091208.1888768-1-timlee660101@gmail.com>
In-Reply-To: <20250418091208.1888768-1-timlee660101@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 May 2025 13:41:32 +0100
X-Gm-Features: ATxdqUGhnxgOsRlTbHGr9cPTmOtw3x2WbbH84nU1oA4t5stwvVsAq6HPFK5Y8OA
Message-ID: <CAFEAcA_d4iBF54_3jcr2c7Ts=aLmdTb+Qu-iZZJ3Bgt9v4-q4Q@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest: Add qtest for NPCM8XX PSPI module
To: Tim Lee <timlee660101@gmail.com>
Cc: farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, 
 wuhaotsh@google.com, kfting@nuvoton.com, chli30@nuvoton.com, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Fri, 18 Apr 2025 at 10:12, Tim Lee <timlee660101@gmail.com> wrote:
>
> - Created qtest to check initialization of registers in PSPI Module
> - Implemented test into Build File
>
> Tested:
> ./build/tests/qtest/npcm8xx-pspi_test

Hi -- I'm picking this patch as a random npcm one
to suggest that people in the Nuvoton MAINTAINERS file
should be doing code review on patches to the boards.
I can collect them up to go in to the tree, and I will do
review-of-last-resort, but these boards should not be "we
send the code upstream but we otherwise don't have any
interaction or do anything", please...

If people with an interest in the Nuvoton boards don't
collectively review each others' patches, this is likely
to mean that fixes get upstream rather slower than they
would otherwise do.

Other relevant recent patches:

https://patchew.org/QEMU/20250418091208.1888768-1-timlee660101@gmail.com/
https://patchew.org/QEMU/20250414020629.1867106-1-timlee660101@gmail.com/
https://patchew.org/QEMU/20250315142050.3642741-1-linux@roeck-us.net/
https://patchew.org/QEMU/20250401085903.224787-1-timlee660101@gmail.com/

thanks
-- PMM

