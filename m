Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF822CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWywC-0002Cd-Uy; Tue, 09 Jun 2026 12:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWyuz-0001Hp-MP
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:03:27 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWyuy-0002oE-Cp
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:03:09 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bef1e6423e7so644214866b.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 09:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781020987; cv=none;
 d=google.com; s=arc-20240605;
 b=A1HImZN8GAic7H5dKkBIprvYRYNNEarFKgH+fjb8lok5vBMW3md5a0c1vSOsVq5tnz
 pFcokeikxBIqlPfT4YJdu6fjO/iVsYBx4n7fr6c22O2w+BH2LaHUbB6GS4+IwG8ZsG0g
 0DlcOiVuaAt/4YC0dKjgMn+I/lbzq5oBSVsPJqICcrfaCLl7a6IUSO1awuphBv+e7BfS
 rJwipjr5mDDnRAS4gng1fJKwk4aKmuT7V1cmltxOZPqZ/ab9JD76DG/ZIE782qfW1jkJ
 EoKDpKEOmQvqn6NCkJDkd0B5ezAogild7BoaQLnKR6HysVRUwX+VVI5JgqxSdj/0OYUv
 CGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=C5vBW8iPqkDVLJMMuNst3+FGY0iTzbEm+AEpb51rgRY=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=NbFjVGJNQT0cMivsfY+FbFz/ARcDs5ky+2ZM26X+AsdpEpOQorP/Mg7pM2L//sfYkA
 eTmK2Yu6UiJivlFrbe8/OqBRMy9H369G4K+71L6xpUaHg+ZUKeqNmT4AWg5WJgHfmrxX
 lUHiXdTDdEqJXkMKkeA0Wn6SNkPVA2GSy/NZtg9/nIMcJXFR4f8ru3ptYb2JQkNV2lDA
 sEg6uhlzlQovj1KpjcwYhbEvBgThOuq+XOwYhIgZxQUzfBCSndZtLr5Ue6yifGgG48vd
 bwxs1CRHDXtaupI43XNwSDYnx/DAk1Gs0krVG8LEyT/aY87ZPNhyJ0tPiW1CA+gNWONZ
 wm6g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781020987; x=1781625787; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C5vBW8iPqkDVLJMMuNst3+FGY0iTzbEm+AEpb51rgRY=;
 b=jmjlDn5yPby7m97fEOAlu3oXAgjvX/LcaHuDEUGy5UzxlraPQZFE8lXbDmn3i6VPcv
 8zG4/CzywDCCmSVU4QahxEEf4XImp4aZ1rRgzfBxmhslPuEB7AqMcBWitYJCRpmFirvW
 roUDbPs6WMYgwoBm9aJTbj/B365cUvZHJvnw05A1w4If/+0YuRtmMg8oySqaBNTNq5V1
 ltYdUtN14bMwt7v4gmHDLThFocrV+dZegIZHdP+ek5fMjdFTcJFZq61mU+5v0mhfde4t
 CzpIhevj9Pr2/4O9K1x3riM9dhmQFClriFLyzy3DRCu0OsBnqBQQXsIxA6o8CM5xLh6p
 xkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781020987; x=1781625787;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C5vBW8iPqkDVLJMMuNst3+FGY0iTzbEm+AEpb51rgRY=;
 b=fDu2r0Ovpwo/QqrKBBlopS8fUPo0lahHUBE6Fxuk4IbBHWbNAL82EEUZHPK+AM1m1O
 AcPDSD5aG2d1KsanCYmuQunfNoJkCMCe4ghvRCSJmkv10mn9DCz48QSnCwZ4556kLyfh
 Vlrt9nSc7hcMCAszaBSp1y2tLNa+sG/vlAzuRMxFhURX3IgB6kvJeVZXNZFx3tGmvNq2
 YHcFkNp8Hdxp5xzLjwhv2Sa/2+NDnD16bIItgyXvuGtedrhFMoXEOSaBWstZDe7YhnvE
 XtzeRoXp+Mk1arfiNqbwCuLG0kwP92PIn4HNZ7c//kTZDV467aK0lVR6GWelUnX6ZOlB
 3sfQ==
X-Gm-Message-State: AOJu0YzsB/96HuDQN2yfS8ftv8+nHGh0FOUBZUtZCsWAZLrQj13aZRoU
 mEpLaNkVX9v47LT4LnWUDGKVxPodIPKaLYkLbB4EfZRhUfqRCjNzyhcH/aXPJvFyOzqc/mPdxyE
 PCJCHW7flASdWtKA9RsS93tBAF4s022M/GWQZs859oQ==
X-Gm-Gg: Acq92OFBsadbmqoByxjhc6yF9lizinWUIVxrIDpDhHTjEcaSeRiNMiv/mwZyGmK7VQ0
 TgtGgDJVNMpMBLaGIOj0PJnC+Wq+z2vAqXBPEL29939HiMfzq6/l5kzhdArjfKdwMnUgWoU9POD
 JGWjK8kQUAuumXwnqbvB/GqNM02ic+o+cGWoeoCqLpLfKRTYqFnJ8YKtsZi+v+3T91EJ/ckc6Lv
 g+6ZcUMgxBk4piJ18UBKrwDd10ZoIdC0NGOS2ryK6f2SiPpGjgFIiugZ8ypiU86n0TVnOA3UWnA
 i80Q8YmstgZhlBbC6h8+2a3gyA2p1Fq7nuty6GvG2N756tg38Xo/X9nmEewAGrLY8PMMp3cFmRW
 EDQ==
X-Received: by 2002:a17:907:c247:b0:bf0:3f52:72e9 with SMTP id
 a640c23a62f3a-bf3743ea0ebmr1047022866b.44.1781020984817; Tue, 09 Jun 2026
 09:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-31-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-31-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 17:02:50 +0100
X-Gm-Features: AVVi8CfgOk9Fm-18wZKXpe5Xs8nEGQkC46mlVE1IeVnvgD21ydSSJ5Sxr5IR4S0
Message-ID: <CAFEAcA8Hg2=7iHx18TtCE_NSEMJPoPfBukt+Uox70qqK+Sf4Xw@mail.gmail.com>
Subject: Re: [PATCH v9 30/45] target/arm: Implement FMLALB, FMLALT (FP8 to
 FP16) for SVE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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

On Wed, 3 Jun 2026 at 04:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h      |  5 +++++
>  target/arm/tcg/translate-sve.c | 33 +++++++++++++++++++++++++++++++++
>  target/arm/tcg/sve.decode      |  7 +++++++
>  3 files changed, 45 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

