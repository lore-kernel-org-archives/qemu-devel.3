Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE7EC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvypA-0000Hx-5Y; Mon, 17 Aug 2026 11:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvyp7-0000HD-Sc
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:00:25 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvyp6-0005K3-7r
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:00:25 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-836cb2fa1bcso49936627b3.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 08:00:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786978823; cv=none;
 d=google.com; s=arc-20260327;
 b=JSWiuZKuov5e1fr+9hlgOsW83XnuSIRbkZIwV3MZUqz/IRlkkGf3Y60wuAixFEmjRl
 74+biv7bbez75VxdUF6xa+wg8Fvwmw4OVizI5r6Hxa0ch7Bo21Y23Q88DgGPFM8LgiZw
 kTRwpdsOpd+pAsRxuHlHqZaVaxwK5hm7WCclCy6+CMS8oCI54Vi1mZf13y1JwotgEIeM
 irVyjloUijDcF6CCdiW0oFeSSMmcXDoUdLksgcLaagKs3BDspU0HBmFUH44nHUpIxCpN
 oJgaYQ/PdIWc+4uMKlrtc75i1pCO2EMfty6lXq4RvXda5bDbJa+/1QTfcWQcFTYCpeZC
 hHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aB2m+BEwHXwBW5rkwDofc3v6qq7ek2Q94aJJS3tSN6E=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=AJunfaIr3ahPPaz8JCmJfVzW1Gu5I0HY56gR8PSWTKqJJNxIH79ALduJXqxAOumEeq
 lNNhztCNCY04ZBTaQB/2VbddYv9pqCe0cosfI1ntOjHDbQbwP5x8OqvDSfBfdTp699PE
 wWqhEU74ik5NSvhXeHP9uEkpVvo4nW4iC6CNS7vt5maMb41/jV/HwVFadCwSAlNqNK9h
 JzUQFm6sTWf2rp2uV4ybpDvce7LWj7yiBLPb75LGJZlVXirZYTfTghqPUC8Z9HB78EfE
 zOV4zpQRDfBWxYP5NFiA5cQyoEUn8GjnhG5d30cdldWN+USemsjb/SdocCKBQlEG3VTb
 3fyA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786978823; x=1787583623; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aB2m+BEwHXwBW5rkwDofc3v6qq7ek2Q94aJJS3tSN6E=;
 b=iILl+9rIoKVLgGyCJCxjt+lW0oqMPuv8E1b83yMV0LQmuW3xH2bqt/uy7tNcunKHyl
 BIpYC+1STDGFJazqwkxHtgaH63nrdfERvnoQG3LWzDTnHd6FETO+MyvON+AYpeoD2Qbk
 KjMzjMQItilhtomnhwQsGRN0IPe5qx6gFW74Vcg1GOZpc3X1VIxsvnNXY+akkRFpCk1L
 8Izv/VXW78EexliwWdiYu1d+nI1uAq/KVWd6Pb9667soL7J8WmzJZET0xypBgjTe3Z/b
 nWD7TtxXi8HeEdXQqK8edyaIrnhRFvO6wYxmubtyIBC3MQ7RbMGxseXvmcAvtiU1VkEk
 Tg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786978823; x=1787583623;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aB2m+BEwHXwBW5rkwDofc3v6qq7ek2Q94aJJS3tSN6E=;
 b=PGb8IzhEl5nDoMNU3Ui+koyMVhZjgi6zHdjk3BkAaVbKCl8Eou7k4O67Nlv4+AihNW
 NwrSsfZj5SDM5hnESMmn09THNwp5moBkeG/0B9A2eTAYy2b5udpemgaAIO7gufSGwjIy
 rfxq2hNEDW3ae8XMD4AXnzd1/j3IOOPOE5p/QKyGZxpCbruJRGU2zGnrDbrYMuG4MV25
 XIrdFEgmdUxdyfTJyVjqG2ihGgzEC3LV/UPjPPuw5MJfg4f4ARwzzufcHFWubN7WQfSH
 peivt57J4KuD196+yc/FNEGw2oHUHA4oeooq7oDS2E9qEfDko4gtnIb70zg5/IpuMF6m
 HMtA==
X-Gm-Message-State: AOJu0YyPGsm6IF55U9RE+ziPWWIaSSyzTKzszurSTb+WSFEdqkXOxr7N
 VipybJltks3F2vDCSQmF82IJoC0kCfeKPBoXscMUYzPWOTDjaY3zYmntFUlLD0BczSdbDH8ewTJ
 JOcxy/BiDeTvPkNHKFgbzHErBbP6UCGpcn/6k9alwQg==
X-Gm-Gg: AR+sD11By4LuslG0g6xVYH6GPQQmglTmB7QOTejQMmebJz3/8X51yHHCXaLUK8KALdM
 7tgEFAaXRAVVM5C9j6lvJ1OJE/wr6w0Dda55lQcCwq9slaHVxN5DqkKJzlBymC+nkVDmSvMdoTX
 LCne+cDGgLkbBZJss04hzsN6H7qP7ghL8yeYSA4OBjpWGA+th4jyIi6Oxy3Q3bfv5JleBfypMLJ
 Q04lLPUb4pMne0J+VxAv4aZ8kbYTXJO4yfaYv/7k6aZS1N6wePIqadlK8R932xILKccov1uiYWF
 Sl7lC21TZMxHql6Wa9ipQYnNUsve9A+kYOndhjqdJqlpXurxRyoizEV6ios4WYSC3DbwQ1sR/70
 fKUGcnRPcGSBvLd4O76MCGo+isL58
X-Received: by 2002:a05:690c:c511:b0:81e:6cdf:b2f5 with SMTP id
 00721157ae682-837077121e3mr97009827b3.0.1786978822481; Mon, 17 Aug 2026
 08:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260812204435.295067-1-richard.henderson@linaro.org>
 <20260812204435.295067-10-richard.henderson@linaro.org>
In-Reply-To: <20260812204435.295067-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Aug 2026 16:00:11 +0100
X-Gm-Features: AcwNN1XYF2deQOsQyFiaeo04BEmMyTUmVuoEO80-1SviVzPGjFqkZS02qKhQypE
Message-ID: <CAFEAcA_yvCYpmmgs9N23c5HkB7+BZEvYB67HbbPPTt_eBC5HaA@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] target/arm: Annotate arch revisions in
 aarch64_max_tcg_initfn
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Wed, 12 Aug 2026 at 21:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Annotate the minimum revion from which each feature is OPTIONAL.
> Modulo some sorting of properties at the end, comment changes only.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/cpu64.c | 303 +++++++++++++++++++++--------------------
>  1 file changed, 159 insertions(+), 144 deletions(-)


>      t = GET_IDREG(isar, ID_AA64ISAR1);
> -    t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);      /* FEAT_DPB2 */
> -    t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_FPACCOMBINED);
> +    t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);      /* v8.1: FEAT_DPB2 */
> +    t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_FPACCOMBINED); /* v8.2 */
>      t = FIELD_DP64(t, ID_AA64ISAR1, API, 1);

Out of scope for this series, but this value for API is wrong:
if we implement FEAT_FPACCOMBINE (as we report with APA = 5)
then we should also report API = 5. aarch64_cpu_pauth_finalize()
fixes this up because it always rewrites these fields, but
probably better to start with a consistent set of values here.

-- PMM

