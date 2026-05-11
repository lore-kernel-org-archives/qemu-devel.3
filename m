Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7E5CD37B2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 15:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMSr4-0007qb-Nq; Mon, 11 May 2026 11:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMSr3-0007qQ-By
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:47:37 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMSr1-00033m-HV
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:47:36 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-65c0bda7f15so4613607d50.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 08:47:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778514454; cv=none;
 d=google.com; s=arc-20240605;
 b=ipTD3vplmokbfJJUToW5G56N41sieFyFcp3LVsCs4CpNtFC2kW9xXtzU99bzEblRgv
 BOGVO/f/TFv3d5UbosCS+i3Ccn9fY41joOm6XF0RcvAAXbkrG4fkPD/zBMsNX2wYtef7
 ZA4jeOMJRaof8E/fbPrFFSvOfLauWTpGW+9HOm4RudSmpX6tMVDvJgi7wmYhdSwDEO7r
 ZkTtfKRJLh0ZzBAFiOsKcb2RUVg1UXqpL3UOU9U+fY+E/TDCEkqZpXIG0S2jKNA7EL2i
 7vnMZSotXTBOlkvrxAzD/YXdrSaU0FjM8b/bKsDQVT/Xc5ZpPs2DWmjInqM1Xy4HgSug
 osHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oXKqJOjVUUXo2/4UpUz3DfcvTtzOv9WA4qoF0cpXaLg=;
 fh=D9TiOsAcOSpRlHrkA38ELZyIVSvZmg48LLzTtJLYv+0=;
 b=BO5oZdhhREDuyQqYLgc2t8mQOFRu/4SOqhiBLwNaRoAQ5HNMrGAnWUGkRJC4858YV9
 SUq6EqJ2craqYJxcPtk/WA5qMQsTinvptqXOiGaxINpRSN63ejawNeHZE64JvvYK0BxH
 6Co1mIXYjk95roiOGPKAwtzRq2J4UjGw8vymJpmx3mETcNd9LaqktObTxAayTx3FBlu/
 lInmFP7q2uOHCpxCxpjkYGr9rNbJjs4gfV2gi1JfD9OfxdPn7uR/BBE8gn/YJfpQgPa9
 V42nZ+7iimthmK9lSKzYqMQQWv5zrYVCWwqIsC1Q8JKZEI6FFTNO8B2GjuMnnfrd/u+u
 mVEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778514454; x=1779119254; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oXKqJOjVUUXo2/4UpUz3DfcvTtzOv9WA4qoF0cpXaLg=;
 b=SYqAAqxR74Z7mocuLjE0/qpe3024BsS1ZtIeb5u1wulxAwGSQ4B8UwghwBueq9wDT7
 9CBS0i6QTkW00tYGvS/iEgy5hMAgaUYnBXH5iDvoaodzKCymARiM/EnF82e0FY134UNt
 Pgq2wow6cwmUIrFBA59auDan2ud7AA3MdGrXAHhJ5WpcabFlnZJLZYXbgj90IMxhGwdm
 GILhgb3vi5BvOCuKM1INn+IR+bxlfy6bZ0FXQe68KIcjhQb3UecY+jfpeAIaUWWwNsLz
 Yl55Er1iPmALRkYGAUhM07e9FClx+89j/7dmrsk80XqqkT6Ycj5wg3UEDOpSRkUcM1QM
 HlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778514454; x=1779119254;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXKqJOjVUUXo2/4UpUz3DfcvTtzOv9WA4qoF0cpXaLg=;
 b=qm+gL8x/BjqWrLQWKAfSkW5MlJnUxbfyxtHGPlXYW7U191k8CuK94HKip8ZLylzWj7
 Ktvq2NS8aQwVzlrtAiA6EHfEqz0Gh5kg5PxA7niDM90pvN3RcL63kW+RHxC256LCFIcU
 VG/Da4nEo4DRHTr8ex+dx3tCmuB7PPQGJq+MlR/p9SPYMZn41+NUtF/apW5Ie3fDmZ8i
 Ld4ViOAjD1hrAfKYwBhsz5Oe5MEXaKOfe3iqXTienDWyeetRwt3tV33kCygnIRTP3isP
 qfEoZRkmT9habB6kdl6M+6OkE3MP4au1nTTjx5tUc7VERsfUAaXVPocn/9WHMU0UMrhF
 rK6w==
X-Gm-Message-State: AOJu0YxoaU79QEV9qZC/M/GGl5E+488qbiymNSBzwbK9wNHAIq4yY48l
 S9C33LpM+xTHQdhM7/dzMN9hDGKeOeBkiMzWOzKjsk0jKA+d5ig+E/HY9MJ2KV1NW00YLSmNBVA
 x3B2UKzaQsAOCzkZFOOB1AchcEaRB8CzZY9JkjD6BRA==
X-Gm-Gg: Acq92OEOWgYcFhUJGDcMweBkIUN8WdfaNwJqR1jYigdmNi8zNNqyGrbB9QgOfWfqKkZ
 89jMGyknTaiHAD4aj8rD7fIUv3qeoJNOaOIGOesYrrqoP4DExASHW2gR4bEHKPAcUlS7/Qm/3WI
 tLOzGdMvel1wEPJQOt/+tZ+bvMtkP5I518/irMViL6UKquSbEkh0OEDrS8Nkvy7iWGP5tWmzY0I
 WzIkNLAM2zab+8D9nkLkHAVAlkuiA//gJhqtWzo9pwj6u5V7U8TvtKltR7dOQczmtotSuylYac4
 5pUTyPxmvm7RRPShTV2C5FccXm/eU7iqRJIQoSom/AodzTd+n6atOt8zL3WyTOpjOCk=
X-Received: by 2002:a05:690e:408f:b0:65c:5b88:849f with SMTP id
 956f58d0204a3-65da85c8cecmr9051622d50.45.1778514453941; Mon, 11 May 2026
 08:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260511152019.1316898-1-peterx@redhat.com>
In-Reply-To: <20260511152019.1316898-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2026 16:47:22 +0100
X-Gm-Features: AVHnY4Ihw4EAhkzRb0CB7DCYsp4OhO_IQ_e_bYE9dfZW_lvgX1_KeQTLBBXsiQ8
Message-ID: <CAFEAcA_Hk5EnPWK3Ho1fQVeN0o+2VFjjjz+1sZQk2f3f_CRmWg@mail.gmail.com>
Subject: Re: [PATCH v2] migration: Fix possible division by zero on calc
 expected downtime
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Mon, 11 May 2026 at 16:20, Peter Xu <peterx@redhat.com> wrote:
>
> Commit dd4fe8844b changed the reporting of expected downtime behavior, so
> that the value will be calculated on-demand.  One side effect on the change
> is QEMU will allow the calculation to happen anytime even if there's no
> transfer happening for a short while.
>
> PeterM reported an ubsan report from clang when running migration-test with
> aarch64 binary on x86_64 hosts.  I can also reproduce if I run the test
> concurrently so some of the src QEMU may not get chance to push any data,
> causing mbps to be 0:
>
> ../migration/migration.c:1051:12: runtime error: -nan is outside the range of representable values of type 'long'
>
> Fix it by properly handle both Inf and Nan.  One note is we can't use
> ">"/">=" check here otherwise we cannot cover Nan.
>
> Link: https://lore.kernel.org/r/CAFEAcA-MYH6C39xO0OLx4-M5pKurJpurwRsMqZe9q=W-NShAbw@mail.gmail.com
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: dd4fe8844b ("migration: Calculate expected downtime on demand")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index b6f78eb3ac..e4103cd3f0 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1044,12 +1044,28 @@ static bool migrate_show_downtime(MigrationState *s)
>  /* Return expected downtime (unit: milliseconds) */
>  int64_t migration_downtime_calc_expected(MigrationState *s)
>  {
> +    double expected_ms;
> +
>      if (mig_stats.dirty_sync_count <= 1) {
>          return migrate_downtime_limit();
>      }
>
> -    return mig_stats.dirty_bytes_last_sync /
> +    expected_ms = mig_stats.dirty_bytes_last_sync /
>          migration_get_switchover_bw(s) * 1000;
> +
> +    /*
> +     * This "<" check covers two cases where we want to fallback to
> +     * INT64_MAX, the 1st case is obvious, but the 2nd is not:
> +     *
> +     * (1) when expected_ms is Inf, or anything too big for int64_t
> +     * (2) when expected_ms is Nan (division by zero), evaluation of this

This should say "zero divided by zero" -- general division by
zero gives Inf, and it's only 0 / 0 that runs into NaN.

> +     *     if clause will be FALSE
> +     */
> +    if (expected_ms < (double)INT64_MAX) {

This works, but maybe we should write it out
      if (isnan(expected_ms) || expected_ms < (double)INT64_MAX) {

rather than being clever and then needing to write a big comment
to explain it?

But if you'd rather just adjust the comment, your patch's code
change does do the right thing.

-- PMM

