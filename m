Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A28C88E66
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x65Vr-0008SS-ME; Mon, 14 Sep 2026 08:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x65Vf-0008KW-3m
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 08:10:08 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x65Vd-0000Kt-4F
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 08:10:06 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-66c70f69d3fso2988883d50.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 05:10:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789387803; cv=none;
 d=google.com; s=arc-20260327;
 b=VYtTC2Uu8WGnA80wigGGE3Gm3sWqUCdxtg7GbJl0OAIaQJlaOWa1RzRhyy4ZGi64q+
 l+FPeqvwGbtbtJTONl/JoVth5kZeDNXdIv58l7BovR00MmAapc7wrlgPVjUFmugY9UOo
 YR6grt1k6iiec2fbnMJLO4/y4IW4JzUnFJk3YcoK+dOlN7g5j+zPKEDc2Y5TXcRYtpyf
 swMmqCiGkP6TfmvWF86auSp90sOlorRoLhOfNH+oyrXCl3ncFLWvO4FBIoQjVz8nfzEM
 xB1kPCHqK/uWw7rFGLYtQJ0r/2U7+HrTged9z9MLBqT/X8q+Gn8cW8dHi0Oa/nV4lAav
 5MAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xqTkDfmaB7hre0Cg3OHV6CiwKrtiYY1ZRxnL5ridHyE=;
 fh=RUr5Elz6NvOzGyG7hmvzM6pZlhdsteCTBafBV73AUiA=;
 b=NylkZx0dr6YqaFcrcadV9DVZPbOTA2Ie2I5AxUKjyMVzlfm502CdBvzsVoY7cKcitt
 0gqYTp5B77rTIcFeXYCGpNREMTmzP06uXsZWH4HWC93e00EAzgse1sutnw/z3h8V7fX9
 ZV8OAYwLdbfhfjv2BDY1T0kNVC/YFF8BJ3vfT3unhc6b1/e2203EHxsAch+4Wj/sLnrz
 6wlVmeW8vFSbwxysHRPIXEB81oh3CRb/++m4dLFw/22+iioj/nWN76Kbb5TwhOKXNxKD
 Tx5EiJjAx9Ajrp2rzQ0WXiVgjOO5morU4wz3dvNfqUAyVpvflL3MY2HJUtG/fK/f+IIL
 n4uQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789387803; x=1789992603; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xqTkDfmaB7hre0Cg3OHV6CiwKrtiYY1ZRxnL5ridHyE=;
 b=DBkFd7qfw92x5p3l/tS1ZzHz95YjxkCODvG5RjLqOK18AhHQ2UerOevfdaZzX1F3cd
 fjv6fsFCat7QuKWI6NFsru+ux3U3FMWL9m2D1OZ2jGQDwK05Ek1wW9V4CMFgLhl6bfKS
 SFOBFLWIOxKFXh1QSAzHDctlDmXQ5kPAkYtVFfwh+3Q1yKxwESPtqpOWNBRsWLyjoHc9
 KxWMuITGebiuyOZqmSS0WLDYnSzPT/eTtzMaIi+KSI6cUSf5Aswy+tVomSv4k53kOxa9
 QcFmwdWKYm54al8jyzwh0yM9wN2u/GKdekNsBb3i8HfhUm+TqohImdtkakU6d0hiS/Hb
 utCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789387803; x=1789992603;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xqTkDfmaB7hre0Cg3OHV6CiwKrtiYY1ZRxnL5ridHyE=;
 b=j1F0Smp6Qrm9HwebVOgj4fQKnIdTiJskPwhKfwi/DfxoXeTewaFdbcfU7dhqvQ51Lf
 Yeg16Ae+qpxpQS8wo4Q2g8/6gUD+h2VuMGh8fYSJ0FU9YWoOpxaMyRVW1fJ4GkiUqaHg
 lidlpk3WX1NaC1B5OO1Vmv7cRYNDaw7+QilAuQEtlr0XPUuZAGt2aRaeabdWP4yHEmbn
 DA8NWucNS+SgUSMcyQv0vUxg81OTUm4lgl7f/xKylV22TLYtrIPiKMdLHRtPiyCJYXTP
 odyZKJU6xulsQs/3s1bS21LxXlC85foGHTlY5cNg+66T+Y4J3cmywWKb9arc9ZGP77aK
 aBQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZclBwC+a0IhmhVEW5SAryzg7n+ITPHochH3OZp8iEZkecbTCai/HVbyx4UKio7IQGytvMbWexxscQ@nongnu.org
X-Gm-Message-State: AFuF++lrK3QB69/a0rcwiaUevMeWIK4yFmLaumHf+oyjfYjSPkl17zIC
 gDKnjCuHRv0nC61NMBvVY2KrHmVDWSw/pMq2sGFFnaWgcxUiOQc45G/7kRNwbmnaylK+SdmmRnX
 rwFbXgtWWV8qrlrPaf+yFWdrWjfNBOvqdNtF2qgfTrg==
X-Gm-Gg: AYBFou2BCbWP9IA85pRJfK4fT+BgEpPoBFM2OagdRMiYbhX/0E06PMhqpPsBF0nBFZl
 Ml7axXS4lgvF3WTdMrOsFJrMLBMJ5ykF8gN2TYkeUE8kg2XM5lT32K/n7nzQUskuPGICRPBUyfW
 n+VIrQJj5wEXAvIIH2uU+appnnJiEzAS69AJ26vPrIbQy+/YRWa5hUJJuSSh8xysdt2w2hZRQOm
 xYEw878+Aw59y6MAD7jL6vDdelP/fUcGT6i2AHIi4mw849xLF5EGJ1zxPRCpUypTaAoROaVux92
 OeThvKCC7ibImNeErigM0SbRkYThyDJ3ptF6dSo9OXowIVxtIhN5ZKhNhr13F1KvGn6Bz0eKsnW
 7G2sz7gzPQlnNHSo0CkKWAs9wIusuPvuZ+gGtBdLZ8wyBpwZwQQ==
X-Received: by 2002:a05:690e:1658:b0:671:1d59:2998 with SMTP id
 956f58d0204a3-6714e00d4d5mr318707d50.33.1789387803286; Mon, 14 Sep 2026
 05:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260909144151.26803-1-sebott@redhat.com>
 <20260909144151.26803-3-sebott@redhat.com>
In-Reply-To: <20260909144151.26803-3-sebott@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 13:09:50 +0100
X-Gm-Features: AcwNN1WoHt6vQuYGBoZKVhohe2eUesrERibYwrEiE5R47Fa1bXekzUMHLN7KTFg
Message-ID: <CAFEAcA8v70ZPUvC6fbJiA7uxz40gRGzqKGHArDyXGEB11N2=OQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] arm: handle CCSIDR_EL1 as a demuxed register
To: Sebastian Ott <sebott@redhat.com>
Cc: Eric Auger <eauger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Alireza Sanaee <alireza.sanaee@huawei.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, 
 khushit.shah@nutanix.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Wed, 9 Sept 2026 at 15:42, Sebastian Ott <sebott@redhat.com> wrote:
>
> From: Cornelia Huck <cohuck@redhat.com>
>
> Move handling of CCSIDR_EL1 over to the new *_IDREG_DEMUX
> infrastructure.
>
> Note: the existing size of 16 is kept and might be extended
> at a later time.
>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> ---
>  target/arm/cpu.h             |  6 ----
>  target/arm/cpu-sysregs.h.inc |  1 +
>  hw/arm/virt.c                | 19 ++++------
>  hw/intc/armv7m_nvic.c        |  2 +-
>  target/arm/cpu-max.c         |  6 ++--
>  target/arm/cpu64.c           |  6 ++--
>  target/arm/helper.c          |  2 +-
>  target/arm/tcg/cpu32.c       | 26 +++++++-------
>  target/arm/tcg/cpu64.c       | 68 ++++++++++++++++++------------------
>  9 files changed, 63 insertions(+), 73 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 9652f8b0bf..f832cdd7e1 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1121,10 +1121,6 @@ struct ArchCPU {
>      uint64_t pmceid0;
>      uint64_t pmceid1;
>      uint64_t mp_affinity; /* MP ID without feature bits */
> -    /* The elements of this array are the CCSIDR values for each cache,
> -     * in the order L1DCache, L1ICache, L2DCache, L2ICache, etc.
> -     */
> -    uint64_t ccsidr[16];

Something somewhere should be providing the equivalent of this
documentation comment. That should also mention that currently
we only support 16 indexes into CCSIDR because we don't implement
separate MTE Allocation Tag caches.

>      uint64_t reset_cbar;
>      uint32_t reset_auxcr;
>      bool reset_hivecs;
> @@ -2138,8 +2134,6 @@ FIELD(MFAR, FPA, 12, 40)
>  FIELD(MFAR, NSE, 62, 1)
>  FIELD(MFAR, NS, 63, 1)
>
> -QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
> -

This change has lost this compile-time assertion that is checking
that when we read from the CCSIDR we aren't using an out-of-bounds
index.

-- PMM

