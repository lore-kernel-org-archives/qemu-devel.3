Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A86C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd67S-0000Go-5d; Fri, 26 Jun 2026 08:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd67O-0000GG-Ug
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:57:14 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd67N-0000JY-Gi
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:57:14 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6647c26a4a3so870721d50.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 05:57:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782478632; cv=none;
 d=google.com; s=arc-20260327;
 b=ohkfWnte8p4Adl1bC5DjjT2NkNslGeu4cXypqsrfKM0kZeG+p22z2/MW/DyMgiDNc+
 w/wcrwL7p+gbrxOlXfawlATZO8l6CR4wvzDVJLLh2wiazD7uZDkrtM7hdGtu0Pl9rXFt
 APfqdHMG5qm2Smizmr8fFj0FJ6oTxSUZI3V9mn9DYes72FVPQG8rGtzZcE+1nmvA8yjM
 kTU+DmzYl1qqyM1thmuxPt/p0GXTSWZkn67ZmxPdIOucQFs6JPGTEMzmx5XgWatkk+3E
 ov+kJVlmnT2nI6C7C+7W6WeKuFeBuRc4k0pzH1wKpogc7QPFmvUNPLw+wp1Oljt4y30y
 fPHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tgBnfMwlUMNw7p4i4lOtsIMyHlEjCIC3XfIHvDD4MbM=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=cCNxTQT4kjOh3yZ31d6kuLc2Af+GWwoAtR/wyuAP0MHC8n2eO09hH1Yxr3mfCRm/fu
 KiZx/KDINmVCohnX/3nkJi9dMen1K27Af20i3RcMryfcpSJFhx2FXTX4p7/mj9LcHiWi
 eUj9gWh1DE7IDhZkkskwYSBXpMtxyUWw1baj+yKmOguTZnW3LRjT5pzV3KnITLCoG574
 Y6NmazuA0zpY4i8rbeF2zncf/lUy2BHo0xCRhJmJ3nQO5D+DB1vLeM2JfmTdCPkrCBqj
 CTK2gVpMJThOx6Z4zvWLqgXGDO3WM5WVi3wuJKfjdKK8LmGKsXD+RtjIJV7NzWtGCbuq
 O8gw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782478632; x=1783083432; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tgBnfMwlUMNw7p4i4lOtsIMyHlEjCIC3XfIHvDD4MbM=;
 b=jKBfvVsQJCa9eYOipwlKgqYMHdz1IGD2mlkmllXOoCFxojp03WMgtpRkQNwn1Arge9
 IKN8Blkq7VudYTVBHATqS8xVkTMoc3WlcwnodAi9D7RuvcgDC7BztUAZXOgBW9UK6az5
 ishwxT9PhrQAxHX9EYl2ITMCPCFHIkhMMBng/TrD9JjqeUi2log+e0W0HXQbOeMc5Wxv
 QoRK9kNjgbp451enDPpMzVnQPB/ja9hJ4g9EVhL1a6PJyLWRAVgHXClRt1oBAGIfK2pg
 jl6DABc/sc/OP/85OdhXH6FKJeZ+Ef8AeRzt3qlEflTMdqUlajDLXfCNMw1Zzk3zYbjO
 6zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782478632; x=1783083432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tgBnfMwlUMNw7p4i4lOtsIMyHlEjCIC3XfIHvDD4MbM=;
 b=SXaLGvWwaRDGlLPIHazuLVLwCbmcKsdSQ8jPAiQhTfEKgwez8bP6tY/srUR7Rcmic8
 1AtOsmEOi8acnPxXKU2FT/Q9U870BreCMJj+mXWO6a4rgNxb4J6YiG+4TsqLM4ofEnYs
 tCF4L219QldmAG/9KRbad98V3yxIOCnWatPNKGix6d6Lur8NjfZ6DndGyQfTguFBiH22
 Xh3QuIfwbbewKYbhSLC4GOM94YipB05X3Aw0kDPQGMfRIO9Ho0wcZXKXovYFWOUfdmUs
 XBxSRIMnys5mNzHoXXKOjUlzPqrGc095+kEbarqB0FM9FFvYLzDWfjWpbxMANOxUi8A1
 BHwA==
X-Gm-Message-State: AOJu0YycdDiZUV0h6JQsW4BWrW4cKbcUhJunQjBMSsk44zSZP9lcvhMZ
 BxmAgUlw+YFwfpIf77g+wPatFzYrJywAImN3v2QBuRV6eY/Qcp+idjNNaQYT61Z9kgXoIpl7O7g
 VdtmY6M4dHVKK5exfJxplmA7fNGMzoMC9aQtzD7+cRQ==
X-Gm-Gg: AfdE7cnnnGu0R/5AI3XSe8LCaLZk//wSJSF7944OHuCtNPWFvRxYSKHhgqsAiM6T6nh
 BM/oZd6/seYBX3npAtkJcmZwDznPv2uhBypaBr4+YON//N4i8EPtSh9UHEr707UAMpbyMrCRHDN
 pmGaCciUKsBx5VlEDhTZ7IUBH2WWiJTX8hi/X1XBQiYCh2FX6ZOr9cWSXca69kQhGYHigwNrq60
 A2H/vwZppxbR/li/0teOSjCQ1W3uI1RC5QKdpGsCPtaBKKy1i+WzVEdhnpTDHcf7EjCEilIKnBq
 A3FnIEkTbhi9Y6mE6MeFuR4WccflZp/YulF62YBYctRncr3xi+i1x8g7
X-Received: by 2002:a05:690e:1289:b0:664:94d6:78d with SMTP id
 956f58d0204a3-66494d60a4fmr3877605d50.41.1782478631584; Fri, 26 Jun 2026
 05:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260625223200.763198-1-richard.henderson@linaro.org>
 <20260625223200.763198-5-richard.henderson@linaro.org>
In-Reply-To: <20260625223200.763198-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 13:56:59 +0100
X-Gm-Features: AVVi8CeZiHpBtMR5uUEaHWPAPQAjCmN0LsKdoqIxGkp9huh0EyenFBsyDXJ_XAU
Message-ID: <CAFEAcA8yue2nvC_ycgWDnNp90xQFD4esEyccFGNzfXxToHBHxw@mail.gmail.com>
Subject: Re: [PATCH 04/15] target/arm: Implement BFMOP4 (non-widening)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Thu, 25 Jun 2026 at 23:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

