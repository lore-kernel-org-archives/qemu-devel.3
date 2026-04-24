Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538F7FB44CA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBgI-0006oO-5g; Fri, 24 Apr 2026 04:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGBgG-0006o9-R6
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 04:14:32 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGBgF-0004WP-3K
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 04:14:32 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-79a46260385so80519757b3.3
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 01:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777018470; cv=none;
 d=google.com; s=arc-20240605;
 b=PdLf8yZti8XlKLC/yB4DSRUiKiHEfxakO9G/1FqWOBAoce15WjSX7g/2GH51oqmExm
 dhOrun800uO6FXkxDUiRSaCArqSaydTMgb2LhfbhPU03tfwgRQZxpDMROVzWdsRC0OaM
 3NDbmnZXkHjp1jgkWRiRPn/pncU8D93TH8c649sxGZoMHgjUHRYOx5kme47uY0jc7DFJ
 Kk84sv/+NhLKKTuWe/HDh5y8ZDdi+wzVYE7VChtpK5lfGnUxXh9cxGeRRLCfr6WDWSAU
 Ap+xHasJRYmK2yWUPMXkKUG5LnHxlz9SftzKI0gum2bdaB5Yv9b3+QTfnlJEYt5ls+tC
 eUXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=D1lOfS+NOYNb3uPXxn+cBG87ElzyennEyByg+awGcak=;
 fh=qg2LoZOT+JJEFbndu52VSpAVN26Lr/U0h/dF88E73Zg=;
 b=cwgVE60augwdp9BUs7iDrTxeHVkAz7U3yt2IJLJSTFCTte/YtiSWwFfv3X44uYJADh
 nl6Lmrb8g9TbUR/CmJb76yIoacIGSLOPtV8epA2/YWVm7aERtywb/QyfpQYBfY9FRJfy
 SstdHNmt/KEjx4S47bZa/8P085nUWVxvdc2vZKRmEIxWadJOFhIIZa7HHGIfheMOkPCH
 hIWEzV/b7HRiEI07n/tBOiQeTqaBSrxlIUuSW2hg2mWJ+uViuH2Ozd6/aGGXhRS333Xx
 zy5rKA4rt1+bnbaIXM6VOUFf3h8r2XC3gyGoaRXfmyealnHw86nzfYiuLKAmgJ5SryxZ
 kgrg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777018470; x=1777623270; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D1lOfS+NOYNb3uPXxn+cBG87ElzyennEyByg+awGcak=;
 b=MzfIASAjDKmDLVZEb5aIKLs2Ewl14L6W9DuSjoaSCnhzqADLck+7FQ1yD5FMMfDcgU
 hkwqesSugw5JOArQyd4Tq+hZDeV4CFSwofPj8CLunuxkWcJlJnDlfIqjba5QWM/UfuAI
 /ez8NnHqcRgnWkDAzP8YxrGa1bIxbRjAYnmww/pj3dn+k9jVHUkffZOi/OlyHsdEeQr8
 3OBhcyGQoORnJ1vUs9JJ+O//1RejP/Oo4POPCgVkvViz6Q5BrqHSiWiFU/+9RxuFZeb3
 prDdJvb1eib5x1YTpXcZ5XEYwIYyzPoeCyMKWlLsk5oSgeERkdLYGYZLG3ptitt6y2Zp
 vjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777018470; x=1777623270;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D1lOfS+NOYNb3uPXxn+cBG87ElzyennEyByg+awGcak=;
 b=niGZSwJrPBrunHVtSgRYpyxtSvMRlJvtbhUi7IiBUqoLNtNjIJi8HoXT85KFlnj6uK
 jkctxFt+RjIRdrXriYAhW7/o9mmsc/qbn701ksq7GJ9XPSbWZQ6PUXQxlGuznw5SnVzm
 FLU5vUZUkpqkLAQFwY9ihjlM2CdY95Hu9HJ1W3avAWUgGiiNvZkZ9ppkdfap6pm9MnGY
 UzS/FrGnMCw6ThJ6hHktl0Nd57S+YDrbWi2qiN1ArV+Zd83m2wtKHDfIckZAUb/QOc9t
 z7qLSSeKYkQv9GeQX+oeyAH+bgCq3Ux2fpOQTrfbcTDz1gKW3rhFT8IBp82GZJJ4dueQ
 6lRQ==
X-Gm-Message-State: AOJu0YwIX0AlOh3cMsADvSIRnmtjPQzERl0lNYFZmMOhOCZ8/nA9iss+
 knhEnhVXs3lw9kx/4dBaa5MeAr/wMvDjtDQtBFJJJ+AXZmoqHnyAh9/83+5eEaU8acAirC+/hNx
 Iv2/v7ZquBujjyocJuccmykdiowThVhpkrxwEb8/vleSP15NzF4Lz
X-Gm-Gg: AeBDietrwMdDdko9QAbaid3ga3Xz9k95SWxj4pFy/H1USz/jysEXIdm8VXdnpIOoQEg
 blkHDpZKuM8nXmhjimxc6pcUKZgZhKHT7LwO1uTPDtTduzs1rksJBDjQUqE9zPnEkGmfGcBzZ/T
 sH+IXqyl4L/gVygkZBgXHk8EwiUgkNYul5fWoxW941iYSGGcEphuCkvfLmbaMEIn7f0Pbhwqlxr
 ZHEFErW6RZWrVQVCVbjIpwkQj1lWlVaRsQZz6B1+4Hdu7T4KpPgETj4rF+UfJWC3czJ/5lQkkWP
 6XfQbW/g56gWp/OxB6BZvLM1bZuWZLAG46bLMQnM0PZZ/BYViLTolowwiuOowY/7haHiYX2aYE0
 12Q==
X-Received: by 2002:a05:690e:134f:b0:654:1261:8b4a with SMTP id
 956f58d0204a3-654126194afmr23429630d50.3.1777018469698; Fri, 24 Apr 2026
 01:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <1107055211.1670477.1776980733834.ref@mail.yahoo.com>
 <1107055211.1670477.1776980733834@mail.yahoo.com>
In-Reply-To: <1107055211.1670477.1776980733834@mail.yahoo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Apr 2026 09:14:18 +0100
X-Gm-Features: AQROBzAGOSFuRLNE91MWWBd_-pDTSfkjCONlpQKZh8DAPNJ7g0Rf6BZZ2QIsQsY
Message-ID: <CAFEAcA9ykiYDdwWPoT15eTA_hHAxM_Bn3q2xHmYnd+uZ5W9B4A@mail.gmail.com>
Subject: Re: [PATCH] raspi4b: Disable L2 cache
To: Alec Ari <neotheuser@ymail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Fri, 24 Apr 2026 at 01:44, Alec Ari <neotheuser@ymail.com> wrote:
>
> From 8d72a46d3653a46422360e2f6c19b6747ca05abb Mon Sep 17 00:00:00 2001
> From: Alec Ari <neotheuser@ymail.com>
> Date: Thu, 23 Apr 2026 16:42:06 -0500
> Subject: raspi4b: Disable L2 cache
>
>
> Signed-off-by: Alec Ari <neotheuser@ymail.com>

Hi; thanks for this patch. Could you provide a commit
message for it, please? The commit message ought to
explain why the change is made, what user-visible problem
or bug it's fixing, and that kind of thing.


> ---
> hw/arm/raspi4b.c | 1 +
> 1 file changed, 1 insertion(+)
>
>
> diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
> index 3eeb8f4..9580711 100644
> --- a/hw/arm/raspi4b.c
> +++ b/hw/arm/raspi4b.c
> @@ -68,6 +68,7 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
> "brcm,bcm2711-rng200",
> "brcm,bcm2711-thermal",
> "brcm,bcm2711-genet-v5",
> + "brcm,bcm2711-l2-intc",
> };
>
> for (int i = 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
> --
> 2.53.0

-- PMM

