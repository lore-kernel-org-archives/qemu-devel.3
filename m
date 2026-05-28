Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18A3CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 14:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSc3R-0001wc-Uz; Thu, 28 May 2026 10:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSc3M-0001wD-I3
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:49:44 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSc3K-0001uW-UJ
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:49:44 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-7ca947f9b00so125111117b3.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 07:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779979781; cv=none;
 d=google.com; s=arc-20240605;
 b=G5jJgPqsuEcX5L9w92ty2kmyrEyt8STPaQqk39MYWa4JtjtVYNrivzABNa4/mXFWkV
 gYPti6xyskAzXYSav9o6YzLKBBenJBvVJz9Yg0p+BFmPnFU/Me1YHoRygvr4vUJda3D+
 vxVrVquYz7TgbUJHLYOyca58jAUCqD3H7LWc1sMWwsTrBsStyTgm7hpxFiPUxhtE063p
 eNZmWuB99KeSk9z8uuPZdpYMpf19/PDyM8DN8eIJekEI/PbWF1OtZEAk3edeCwQkUAVx
 eIDHIcTHx51fNg5gpBXGC3/LUWFwrbsVzAqAoKdtRQj3lL3k2iLMtYYOKjRQ7bp3Jdp/
 a1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KdHJt01D4pDF1WTllAWTZg36+SWPFwxbymsNRT9y4K0=;
 fh=Q3krpAQIA0wAxp6tS0EmfBAbNCwv1IVxVd0z2YXKEao=;
 b=kJgEiy+5GFUkXgEQTKqHxKXBbU3O4gTNc0l7KiYF6x0H6AeaucJkxGwbC/EQ630oPB
 6p3aEkWg0ZX7FIlddnX9VVMNZWoMXKcWHLMnQCCrGndrw1ymRTVowAJSWllejCNnd7qp
 LLB+Va1g31kZ0JPJ+M8cZnxv60T/JIW3g6XvssK8+qrVBHRC+1i1AXmA71P8zZRS61Xj
 ACftyYgZ2FAEAn0qjEVeRIDm4fgejOP/I2NqTd+7GbaAmuSZqCvhTZDB4DPjcBk1i4kc
 FN/c32GVq60/GOZqISNRI9baPiU3nav9E6aU0J3vJ+CVnpoIt204WM21AUcU9TCXJvXw
 IBig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779979781; x=1780584581; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KdHJt01D4pDF1WTllAWTZg36+SWPFwxbymsNRT9y4K0=;
 b=ffaw926DJifT2Toql1YgKWe3x0hdksO8YcvxoQnbHJH0DYOXAMCxKZQ9oM5WOKvyi7
 OdSK7EO0keNzEufmuExE/ZepruTbmuC+ZxGy86/xwdKMrggXRjii+VvBIqWHundg3N2J
 rrSwHvMZWwzR+8opg2hyAtrmJZI9CUA9WDjED5io3AKQzVPMYs5ePjWHEzti0MTLq8x6
 Oa4Ylej7kfuXLXNs1GM0k7Ydh68hSXD17Eo/x4vFoUhFaDUlK1pt70xLXwNxxenl1SD0
 6pqDtmk0awY3Hg92t7QhTBSMN+M0zrorXGuWEOT6ajcxJeKjJ8yAD+GPLyNp0spRtk30
 mhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779979781; x=1780584581;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KdHJt01D4pDF1WTllAWTZg36+SWPFwxbymsNRT9y4K0=;
 b=f06k2SlEBVPjXhyburgnhlPRSo795RgHJkd0GBP1UmO13iSkvqjmj7E/z9YehIoAYf
 1cV9itu7/DPOuWTTaNFdPVNXzeoU9oaWDfq0PwAsEySsZV5DrDUwEN2mKGRoctCPuObR
 YttygjBHCDS3yxDfE5NHQE2LT7SXaxbW6ydsBS7IsLU/dU2uKhWT8oM6f+JTp2UTWi0e
 gqm/5v+T9nswNlG4iCYP5rntfqsWSCjDqAc92kjqHWuiQi+FE3VGmdhyWTwyaLny1MDk
 XwkBSWeVyWh3sg7az9XugIWLolpGbHylEwGxOEEDh95tppOhTqBGPis+Zc4qsSCqIKbZ
 B0yg==
X-Gm-Message-State: AOJu0Yyhir9VsMAtjBx4FTLADLvO1YSq4dPuhoF8gzBZGfn85813Jop5
 NF+uwbh+zvTv+avpKz1OiglqORsMkqsm2QmWVpfByfdge0fB65ETsLQtZHvNrj0jcz8iDCk+kK7
 K9dhaZOO86MVkh2oPCcWH8mSYTESJLdhPoQKFA52UIA==
X-Gm-Gg: Acq92OHOXFMFNyF+W5XQc7jjKwleJEuBJ9uWBaR072Fci5uuQCmFG8DldF5Bk3VZ+4F
 2Zn0Olxp9IrZOBxJPWzHFBwW/kL390dqJFgb4eXsQL5SuaSRgCpweWkewJT9d3VpcvMD2kbWNG0
 4LMIAOOoFH2pDne4wD3m+VqVornxqXJf7HYsct9SNoADxxf1X+r2viQhYFgw08g3s5OkUygld43
 BQtoz6FdQfXY+4HMNcr4ZTLEKXr01gsDpfZc5/ajElpu96XjZ7vtbfdRPSf5EonIyOhq9RJz4jA
 rrbEBIONvxYizy4CRig8if8zuNmqSKMu4PQSsYjQ2jnDdYmhV4vtIF2HlxjTVez6C5r7oqC4eXL
 /4g==
X-Received: by 2002:a05:690c:6e05:b0:7dd:4c68:1a14 with SMTP id
 00721157ae682-7dd4c68223bmr9971937b3.21.1779979781391; Thu, 28 May 2026
 07:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
 <20260511-feat-mte4-v6-1-8557cc1313b9@gmail.com>
In-Reply-To: <20260511-feat-mte4-v6-1-8557cc1313b9@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 15:49:29 +0100
X-Gm-Features: AVHnY4I4LbQOF9BBQjQ77aFuonnAxwj8aKazh15g0AEzuUJMjIvVzZiHUctk4Dc
Message-ID: <CAFEAcA9eRSmSgSQ3dYx=gifQ-a2UikWDP8-MG439tk2=_3x16g@mail.gmail.com>
Subject: Re: [PATCH v6 01/15] target/arm: implement MTE_PERM
To: Gabriel Brookman <brookmangabriel@gmail.com>
Cc: qemu-devel@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Mon, 11 May 2026 at 15:01, Gabriel Brookman
<brookmangabriel@gmail.com> wrote:
>
> Introduces a new stage 2 memory attribute, NoTagAccess, that raises a
> stage 2 data abort on a tag check, tag read, or tag write.
>
> Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h   |  5 +++++
>  target/arm/ptw.c            | 25 ++++++++++++++++++++++---
>  target/arm/tcg/mte_helper.c | 38 ++++++++++++++++++++++++++++++++++++--
>  3 files changed, 63 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index 88fe3ed287..adfbdb9da5 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -1157,6 +1157,11 @@ static inline bool isar_feature_aa64_mte3(const ARMISARegisters *id)
>      return FIELD_EX64_IDREG(id, ID_AA64PFR1, MTE) >= 3;
>  }
>
> +static inline bool isar_feature_aa64_mteperm(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTEPERM) >= 1;
> +}
> +
>  static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
>  {
>      return FIELD_EX64_IDREG(id, ID_AA64PFR1, SME) != 0;
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 316e201cfe..467d815e0d 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -3414,7 +3414,7 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
>                                          ARMCacheAttrs s1, ARMCacheAttrs s2)
>  {
>      ARMCacheAttrs ret;
> -    bool tagged = false;
> +    bool tagged, notagaccess = false;

This drops the previous initialization of 'tagged', and clang
complains:

../../target/arm/ptw.c:3432:9: error: variable 'tagged' is used
uninitialized whenever 'if' condition is false
[-Werror,-Wsometimes-uninitialized]
 3432 |     if (s1.attrs == 0xf0) {
      |         ^~~~~~~~~~~~~~~~
../../target/arm/ptw.c:3488:9: note: uninitialized use occurs here
 3488 |     if (tagged && ret.attrs == 0xff) {
      |         ^~~~~~
../../target/arm/ptw.c:3432:5: note: remove the 'if' if its condition
is always true
 3432 |     if (s1.attrs == 0xf0) {
      |     ^~~~~~~~~~~~~~~~~~~~~
../../target/arm/ptw.c:3427:16: note: initialize the variable 'tagged'
to silence this warning
 3427 |     bool tagged, notagaccess = false;
      |                ^
      |                 = false


You want "bool tagged = false, notagaccess = false;".

thanks
-- PMM

