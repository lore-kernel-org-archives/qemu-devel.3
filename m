Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05FECA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 14:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoN9Y-0001WT-El; Tue, 19 Aug 2025 10:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoN9W-0001Vm-5r
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:17:30 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoN9U-0004Oc-Ei
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:17:29 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-afcb7aea37cso665220566b.3
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 07:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755613046; x=1756217846; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rSZ28AYClv5A97VrSSD2pZD0rl053A9Cb+BWmCChBj0=;
 b=ahpzY/3SUzoQTIuexpRYbEbAytseNy1YYDlt/lt9xxfVMjRdryClqwrJeuUWGoXvIf
 AONRJ8v1/CBHwLjdxE7jQTXFFFm6/zdwnaRw7IrsIHslgB0Go/te65vL8JDPFhmYheJs
 GbtfZIGd1lZeX1En2aW8yVLTKhwTRuhgUqw+rOjIUIRLNnN4yVtYOPFRnwwY3eXa1+sA
 ucef0kriJoRO2KB4lmJoaRgaxFv2ioprtRTUahuCXtl9xYI5/PQFkFqAZBbpqxhuwxWv
 or1q5u2VeZv3wW5GNdtwMGMvTzpm8eVRPetdznytus14IOH2LGNa+H2SClGdux1FlBCv
 VenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755613046; x=1756217846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rSZ28AYClv5A97VrSSD2pZD0rl053A9Cb+BWmCChBj0=;
 b=IU73gkByzT5JU3ELlSt9QYFgyLyPOAHQQCn887EkWEG9sc8YflwjjgV/MVtmN5a/Qv
 kLk/PujCosriLsmsPLPu2UIiQ76ZotSlKUJnS/EXCWrWe5eA1Uvq5vCkpdqxf6KZe+lU
 j6lAnqe7m4qnClqDvuIUvpQIE+HIEkmVfAqGCE76ddgFx3IXgfGGawmkbmWB9EWObIYr
 poQEsoDW8pmeLvtQBkp5WtcXE6PoTUru+AHSqZkFbLRC0tZ5erRPg94xUJIOG8rV57sI
 +blEaiKl2zFpgyCSLOsRoC5mfRMrwXjCT8DK2mIXMlSHVa4MJ2bN8RQ8+JlbvVmUMuJ3
 MdMQ==
X-Gm-Message-State: AOJu0YxArJfEqcDdweI+x/W0bzwnMfxdv9zeSoONpFEIVZvpfLuS3i4Y
 JFrUOyLW1ofPycGY1F97Loom+r7lVRSUQ7hycQn/n/EuxBgnEbO7SOtGRXIYQNyOPuiU69MFxbt
 /bpo8izGG+R1Gi+X5WjkGOXKtiyQtjTi6GasatN7fG+UdTWylIDa/
X-Gm-Gg: ASbGncv9aCo/OXu+sZlJtAIAeXizYdk5gVVBQnTQ17N93qRVLx8Jb6x8d7R23Y+3OII
 t4Wr3on3yJBjy/r5OUYhewBK85otGSCVG0ExVkVgIVcDlsTN2+aLNQUXwDhTBVbH6wXx3UCL9mC
 5TaZssfsvs3uAfy6CRDJJNpIAiNM6MXiTNAvy+EOSDt2r+g8ybNIsi90xFewHkmzqC4SDjiYs2h
 6AhSUuB
X-Google-Smtp-Source: AGHT+IHSfxWiYXLhu2JP4SAOElnLculIMvhC6lCOCgvwf7GzC9EHEKtYJEmoX+/2vlzaTHj+Ebqlaur4IlZOibTza+c=
X-Received: by 2002:a17:907:7ea6:b0:ae0:ab3f:36b5 with SMTP id
 a640c23a62f3a-afddcb6297dmr276789566b.4.1755613046040; Tue, 19 Aug 2025
 07:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250815122653.701782-1-richard.henderson@linaro.org>
 <20250815122653.701782-5-richard.henderson@linaro.org>
In-Reply-To: <20250815122653.701782-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Aug 2025 15:17:12 +0100
X-Gm-Features: Ac12FXyTnRGeu4G_aIe0WDBwSU_Snlsr8g2EzSyUDy-y0lJUAbl3udhGrIZoDDc
Message-ID: <CAFEAcA8anV_u2jRNQHUvrG3_oDHS3jgU8QF4FbMskPOEZr5PVQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] tcg: Add tcg_gen_atomic_{xchg, fetch_and,
 fetch_or}_i128
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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

On Fri, 15 Aug 2025 at 13:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/tcg-runtime.h       | 12 +++++
>  include/tcg/tcg-op-common.h   |  7 +++
>  include/tcg/tcg-op.h          |  3 ++
>  tcg/tcg-op-ldst.c             | 97 +++++++++++++++++++++++++++++++++--
>  accel/tcg/atomic_common.c.inc |  9 ++++
>  5 files changed, 125 insertions(+), 3 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

