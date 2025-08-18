Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE045CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 13:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo0Ai-0004UT-Ao; Mon, 18 Aug 2025 09:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uo0Ac-0004Qg-NU
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 09:45:08 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uo0Ab-00087H-7I
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 09:45:06 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e94d86cae3aso509767276.3
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 06:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755524703; x=1756129503; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B5zxMdUiJZoLLAH3MeBZgRIfGQ33xoY7R1O30qOfsLI=;
 b=rR5nF1s32J/MRrJ5qmqqnUmlNxC3Xg2V04h7Sr/7tVHIfpBeifRvcGdJmSHjZzCS+N
 u99taQbEcM1wWv+wcPUc1gnJqOYA45Pe9oXMtM+oIyR6U8uPfEjKkd7OFsUYNfweUEfU
 Xj6UkLqTCCumSOKhAcNkhCTYjXxABR0nkT7dRE8u0DjEu+VXoueOWAd3iF3202wnVa6w
 h6NnPlUELonW0NKSkURfaLMZwKrkbUkeUHLgxFCpZbgzYEFeOBmup+0Ra1pX3U8lIqRK
 3B87YnCPqsLrVgBcMvWmRZ9a0Y0EEg1+/EqgtrGQfWWjfWg9vjRKFFRy106X90gBO/+/
 dtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755524703; x=1756129503;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B5zxMdUiJZoLLAH3MeBZgRIfGQ33xoY7R1O30qOfsLI=;
 b=EK+quHtvvmf/011mtFrcWzozP0v4klWeFrNL3yBrFZDF0UEKspunW68fpSQj7q52vY
 +F6tNUvRWq4IJuN/NmMpxV4/KpoHf0lSq2uoBzd1MZJQntRJk1IRxucr9NqylzguWHIZ
 LByFASKVPFTXRw+2AiVXK3+gdZfKhmX94ZXt3Hp6pIlT32yRomtMX99hLcSkJ3Hry6Sa
 Z0eclaHxJCbSvr1uxKM10+o0HmXX6uvrshgsz7x/cQ+2YcBPJhsQcKB8H6OoQDj8xIGf
 lHJrn/95UWiwvGAf7rPr6jCozIHwSkbl8MMRlfmCDcp+ICVr+o32HuDpCHER8vfEnSe4
 9oiQ==
X-Gm-Message-State: AOJu0YwuyZeiV5BPGuXBXHhzkJsr3avNe1WBhKrU6o3cHub2OxgDGMPj
 JwuUqaFQFtZPWO9dFgd+wUTAF4gQz6GC0ticksGSXIhrV4abJrrkh7EbG/dNbhpKpJCfJHUMgwM
 qoQvcKdm9XTY7xxdjPb9BvY1aGPttR4/lPt+3KCK2QA==
X-Gm-Gg: ASbGncsjIAibrZSi+tBquFdGLLK74Qsm2ajreQKXUh4qDseIJgen8GPbZ7BdBGt7fk1
 YrxLhNGn+tClLfbJCgG86Cs4118iIcs1X3/TiamIesNHaIHWblgHYe0CucqHm2JS+vZT3yF2NTN
 U857DpPF3yPYEZ4klw4e9B8oSYdH6iCj6/nwK3qVxpatOgcLA9uCkYciY6xU66BB4sGvvt+N2SU
 PTk7L6g
X-Google-Smtp-Source: AGHT+IErEBpGdZZ6BQuUNvaUQL8D/zvR3Uns3spJtAPbvWmXB35duS0x07n3Hn/mUfUGmRSrH5KnMW3/m2nFA8lMe4w=
X-Received: by 2002:a05:6902:20c4:b0:e8f:e77b:a404 with SMTP id
 3f1490d57ef6-e93323d628cmr14804693276.2.1755524702706; Mon, 18 Aug 2025
 06:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250727074202.83141-1-richard.henderson@linaro.org>
 <CAFEAcA-Cm6rn6N+H=v1aaeDZBeJVUQQ2v3XDVsTu=PeLpc76QQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-Cm6rn6N+H=v1aaeDZBeJVUQQ2v3XDVsTu=PeLpc76QQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Aug 2025 14:44:49 +0100
X-Gm-Features: Ac12FXw3r2AhHhg7TToFSX5X3GgzwGq_hSDf3fLVtC05siOcRQlftEozsoYrJ28
Message-ID: <CAFEAcA_sURdG7vafcPcxf-Qr6mc49j0+-26mxOsmTdxCT5PeAg@mail.gmail.com>
Subject: Re: [PATCH for-10.2 v9 0/6] target/arm: Add FEAT_MEC to max cpu
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Fri, 15 Aug 2025 at 14:03, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Sun, 27 Jul 2025 at 08:43, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Changes for v9:
> >   - Set bits in arm_hcrx_el2_eff has bits whose effective value
> >     is 1 when EL2 is disabled.
> >   - Include Pierrick's firmware updates.
> >
>
> Applied to target-arm.next for 10.2, thanks.

I've just noticed a couple of late things about the FEAT_MEC
parts of this patchset, so I'm going to drop patches 5 and 6
from target-arm.next.

thanks
-- PMM

