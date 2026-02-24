Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C38F4BB62
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 17:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuw8t-0007UT-5w; Tue, 24 Feb 2026 12:24:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuw8s-0007UG-10
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:24:14 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuw8q-0000xA-Le
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:24:13 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64ca6595c8aso251450d50.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 09:24:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771953851; cv=none;
 d=google.com; s=arc-20240605;
 b=DNI7YHv7LZzaVSKrFUWOROgnODBh0repNRX7nArg9Y4iNeNZiSwb8vpDzyqRi89zYK
 GOf58IQoLVmHER3dkgXTPMmvRDEPEWaph8dqrdam0UFvoeDIE7OzrrV+8G51p3rua5KG
 IBDDbDr4OSj7YWTSHdqUwEajfWUUskyeqOX0NtNX7gBgZCcFH71mk82i4RMKgJWNoe2j
 fzb9IN+bKKjkJhMUW/l4S4gBefhRs2xcap5Su1kquy0uKHUfHctPwTFPww/jdXBfxR2r
 GLExyRZiaZ+j/kft0GjpL8yXo5Q6OfBpRtHJzDBJMJ1GePjbCHG96czT+uW/0x1I6q0D
 yNfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wC1UPtHhtlWJTjC7sqqH1h33/7ZzACAopqISVguGnBI=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=fmz+30GMOSYNO3XYCr5m0TtH+6zUoDNQg1962ND1heTYTruDlLnDfM9qeMC0g+ysdt
 2aNdB3LnUNQMByHlHxCVS3Z6bcTzBLgg7M2ZU5O09TKspqVYT84GmG2yi+SxpPGSefYT
 NWmv9E/pxgn/5xqfmf/y053cLjhI8nPjIoT5WeFV/IpToJeZ8pzNm51eNK4ufEjPp9EG
 UqBqmtDlLmKD7SaMDX3Kd/LWyMwMm31hB5yBQjgPDCqpuOSoSHTpbjfSVhCgBizQwWw3
 hdbWzDfHPVAfAGkLroBaLkuP+cBP3P/lRDkCw/8Va0TS4e24j0+QtLSDd8J6C4oNW22j
 wiRw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771953851; x=1772558651; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wC1UPtHhtlWJTjC7sqqH1h33/7ZzACAopqISVguGnBI=;
 b=FwjbbLBuIhYrRQAJdoHLiAfzLaoTldFPl9HHkGGmjZsRKJcQ0x5JpPXh/qSyYhJEH4
 /IctfvxrNzxkQXMNxoitS2KqvgVw9sYnnU5xvf/+/l2kHFVt078RN7l1pevvG8pjyxm8
 a3tvkcSb8REZ/iQ53U5upQyFpY5XEZYL3iVHl0V5zOvswMkvOwpU9ej6OTdbqXKRZuze
 bpPIM/OYRNI0t4x3VU/Kx2lNaPh1YgpSlKDV3E6nvk7COQl5JlV2WQxQtYFSP7wBDHb0
 9RpR+mbJBUkZq/FYiksMWOQJCox9uwGwqk9tPub3SEi5lhJ0DL3LJi8pgqNZyxBOH7z+
 6QfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771953851; x=1772558651;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wC1UPtHhtlWJTjC7sqqH1h33/7ZzACAopqISVguGnBI=;
 b=mSwO64RJc8TNuji3Y4fjWhXqqxtI2h7GpIxwW/wk70hDhLkwosUwsXbZhLDRb6IkVm
 sXdCQfAzLL7Paodmf7VJqLBFqE5U990vU3FqjHKUhTg/2ae3BXJrL3Aa/p36U+cKWQNi
 cebDuZ0gvapxRwcsujqPwCUZXm6pilEUKDC6tNt7ZYOTKYmnXtUDC3pBiuIcbq/iV7E8
 MPbZo0tLOOH74XHi3YVd5ldasIRS5thN401HtIsqcekKjq8K/CgemU1RRnK7fuvZ6JUp
 Uluq1LhrA7IHT+I9nJmFXA1nXCbpYK+vj7BzY3BiuZg1r+iFmoyQm+aut3gQDmfAg13h
 LiIA==
X-Gm-Message-State: AOJu0YzZZdFWD/k5RirC6uEMvJP9nSsYJ/zuduB/FEQ3MTs3jGEb7fcD
 NuvJWV+He4R13ExTQruInmTn1ngLmRVZc3FHqJESO2wwIrkNoIZ7ViPFBzjezxFCUfL/mIdyzbu
 Wuor3TvDz6Jf9AsVVPm8b4nfJ/F/jewyzVWFFJ/1XeLnRdB/qLAp5
X-Gm-Gg: ATEYQzzTxOqD9+UQkKRoxkfPtOVhh+fxly81zsZWMV+1GGzGJkg/tma4ZUAcXM8RwJi
 Kmi5K5yUd50LyPny4xMLCiF+bdLMdLkJvwTL+5OOpFx69w7OSdIL4H0CYBzKw2SzX1GEX18ozoU
 Nj0qBbBsGMR0DfVLQf20iEeYZqEWh5aHuUZey9wvgfKFGzMMOGwb9B/P5EVHbbvmodz43mO2T/v
 /sv73VKyO/qauLOaquC2nQ0OAI8LkzDOa64lyevPvB8GVTwtV1r70YshM8/7Mh2EJyYI6vnpt1E
 QAEbiPtBHB4Wto5zA7MhZs56bSUwhtMeG1aBjufDJbfei4kRPQTfN1b0V9opcEeU+0NDmHYGrBq
 vyA==
X-Received: by 2002:a05:690e:14c5:b0:64a:ee12:e7ca with SMTP id
 956f58d0204a3-64c78ac9d95mr10317839d50.22.1771953851261; Tue, 24 Feb 2026
 09:24:11 -0800 (PST)
MIME-Version: 1.0
References: <20260216034432.23912-1-richard.henderson@linaro.org>
 <20260216034432.23912-14-richard.henderson@linaro.org>
In-Reply-To: <20260216034432.23912-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 17:23:58 +0000
X-Gm-Features: AaiRm51J_Gb82UVpEWacCrU0OZMT00EA4j32Y67Kznp6tIhSOuNZwvvszpeRdmY
Message-ID: <CAFEAcA_q+UoOv-_+uvwcs-kPJoPcrFp+0sV-0sydZ1pHuMZaFQ@mail.gmail.com>
Subject: Re: [RFC PATCH 13/13] target/arm: Add SME properties for KVM
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Mon, 16 Feb 2026 at 03:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Add the properties even if SME is not supported, akin to how
> we unconditionally add the SVE properties.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

