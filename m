Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042FBE9B24E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqRh-0004PT-D3; Tue, 24 Feb 2026 06:19:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuqRa-0004Ja-Ou
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:19:12 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuqRW-0002NE-Po
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:19:10 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64ad019bbd4so4910399d50.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 03:19:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771931945; cv=none;
 d=google.com; s=arc-20240605;
 b=XhrkW7nV6zPfIUDof87SeCG1b2SnklhjkuEYqpaywIL2PpIdt8yo/VFNoB0gIFr7oh
 hykN3A8wa50gY30RNQZtKAZeUHam9okb8vWB4tuXEDCvoW/MeWanvq5RU5Bm9t81FbGV
 oVaGZMWbHMXTLRrJvAq3lGkRbINHlvD+QnycQwl/P7RSigzeL87LuYbj2vOHkFi8UOrl
 yZozuos+DYMLUWvqgybhFMqMFCBSsk8P4Jqoa/J13ZRFB+DPqebVwcsf4eMHzZWRxDUT
 MdP1yWaG8CbWEzRxQgqdUGNu47hLMbEh/YpWCbPnmJ7ruIsQV/vawlXN9QMw+VvmehQU
 GgFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fXYhvyDAiOB/gOJXVnRH5ArU8/halpbC2KbQVxyDFoo=;
 fh=x18+ItHhoMt1uQi9qFsD2UgJewF1CZzzz8hcug2Jd4g=;
 b=giOH+kYiNeTiizRvP/HhbETFdY5SYv7SWRbpzNv8n3fOVo8Oj5qJbHjGrTK41gs3qK
 P9X1rvunoFQtYT+0osc3FE9GdlNrI6scCXG2KC2GAYmeFyKGt/Th6vw1K5IGHi8DuGnN
 jYMPkahKVfK66V9AkTnwJXLg2tN2iVfWYr25bNEo9wedS1vf3GtDwPmQC1q6Qd38yCHP
 1p3nR+41cEPpNUeafBjEEO9xoy6Uxyr3ESDrd8tY/yvjIkqwEsbJytDuazEb3Jnyx/jM
 S3buvVG/9h7eQKi/BWEYNqyGPg3VYHC+dWHnddLV+ekMjlxY9grlDAjD4Al/+opC1lVB
 f8JA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771931945; x=1772536745; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fXYhvyDAiOB/gOJXVnRH5ArU8/halpbC2KbQVxyDFoo=;
 b=l7LMZAgF8N+ZFiEko3QQSM0X/caCakO+T3mU/AOMMamLSE2YRHzP1P5q7mUeugCFPz
 qEXqH5Lp6mF+DiwWROMwV/dcr6NC1F/Vtn6fGNWvlyPxYNKMAvMtg4g7vpqQ4DUniygu
 /34bG16zoHtbd/maXQTnRE74gNtHJZiJ0yQUERqf1jOju+gqAQccuZHqDp1EGE/5pE4y
 ZV1Z3bPokSEv1eXRhM4LsKwVTKP4/yWxRpoG3hR0xMBa4nje03Gf0I+ftlckTK4sTexZ
 DFGwLE9yQik9+00MvRfpENXv/HpEZ1Sue9tKL7tA14uQVjRNHmAH9lW9YVdk3AFieKkQ
 Gc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771931945; x=1772536745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fXYhvyDAiOB/gOJXVnRH5ArU8/halpbC2KbQVxyDFoo=;
 b=cIo3ISQU8JQxNXFriQDv1720DK8NYo+NEJVcB4akPftM8zG3lk2xkqmqw1QzdA9Xbx
 kqrQlPQ4yIyVoDVaaE3Fg4S4hHolUg8LCtCIeZ8GyISlCFZ4Ii4cJDkV0fEOkqZvloEN
 +FY8X/xisHXxCIOBBDFqdEYg1lFqL7paGY6IAS3t1WUtbjhKNBOMJy+78hrmR45Tvghv
 mRunESofKU4qQNw6yG+VUcIJfvG2gbzbzVV3jKqRXFViVBxsN1weBUKX4gp3ln555oJi
 2QC5J6fmtD3cpScGDEKtO6JadJQnrCt65l02GM3iv3EYmyhVV2jtw6dYLcUbQYoXVYN4
 Kvjw==
X-Gm-Message-State: AOJu0YwyoF4XK/besc9er79TQw615NGkWH0EO//YTaHeBU1VFuGW9P9Z
 efzg626029ymJyqsLTuMwd9RH6x6oV+uuRvqLvLeRS9NjMp4CqDzRohMDd0PLN3PsNhIPr5WtlM
 4ojG7Cs/ls9c4NwNm9ji4DeHs3O8tLsko20r4UQDVZw==
X-Gm-Gg: ATEYQzwQPms8lPSWEf20VGH0veGOzD7xOkCGICgM1cEIZjkJrCWx86Rg++BTqmN9oMu
 qez6wm1duyW+iH6f0VNPiYN4AL2IZ0j7YfC16wHQ1gA83M2bapB5EkOpGB+VMRfl0nkfPx8FEjw
 4oD0krH2ZnsaSgepf5K/DWAV95ScuJqWP9iWEb4So1fnMCHDOPkST5F5eLHv1ZVcTfBDS5XXDxE
 fLdAHwA38qX6kJc0DCcZ4iiHpX7FBEOD1jYI+JudznRgcnZNG6vlAqY/sNJJBV97y2wSSOwy4il
 Vbzq1rC9AQGS7Z04FGjl8AhyY7aNZPcGVFLT0cQsY24/zgiQ7dx3YiEfjhGRHhr1mG4=
X-Received: by 2002:a05:690e:dc8:b0:649:b31e:8f59 with SMTP id
 956f58d0204a3-64c78ad6e05mr9520591d50.35.1771931945561; Tue, 24 Feb 2026
 03:19:05 -0800 (PST)
MIME-Version: 1.0
References: <20260223095905.67709-1-cuiweixie@gmail.com>
In-Reply-To: <20260223095905.67709-1-cuiweixie@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 11:18:53 +0000
X-Gm-Features: AaiRm50ZiJwzN6_YO2HwKJYAQVkgfidkEpemKXOonTpRgvAOEJRWiPSYmktuSgo
Message-ID: <CAFEAcA_kOBAb2CB8GMD83RbybPsnH29awP_n3hSiO+MC8UxHCw@mail.gmail.com>
Subject: Re: [PATCH] hw: copy paste bug
To: Weixie Cui <cuiweixie@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 23 Feb 2026 at 13:38, Weixie Cui <cuiweixie@gmail.com> wrote:
>
> Signed-off-by: Weixie Cui <cuiweixie@gmail.com>
> ---
>  hw/ssi/xilinx_spips.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)



Applied to target-arm.next with an updated commit message,
thanks.

-- PMM

