Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83361091903
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 18:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Hjt-0005iK-Hi; Thu, 19 Mar 2026 14:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3Hjq-0005i5-UD
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:04:55 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3Hjn-0000Ko-S9
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:04:54 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64e8ae85700so1524336d50.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 11:04:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773943487; cv=none;
 d=google.com; s=arc-20240605;
 b=YTA1WbM1COL1M54hL9Tpbla38psjU8wXUdqNFMANEHwaeqAr2lsmRbptpLzTJscAIq
 nYD0bZJSZjifeMP1Ss+u0VtdH94atWSE8tq2GrVroBpGltxuIlsEAu7KhKeUJ7/QlRVt
 NNPyN4euePNio5uUJynV5bOpcXoYaaLWfjbhHvcHxl0IWjlG2A5BYa2Jqd5WL+lPxmj1
 GG0RtZBYy/07dOvSviVXWm63Eo+e/3bc5RsCoKhC8gKZvBai5XQARuEvLkNaf/Q1Hs3L
 fhPZTE3qoevfFmxYw42YxXJHQgfub94pp1PYrVd50wf860m+pKd6VvLiUcH2y3GdT73k
 Kmmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1UvD4fAQjgtqKP3JgMnzdAwMrQooTWDEYsukSchaXus=;
 fh=GUYBhrF/kTXchbIZooTtA8LiLDp68FR7HCowT2sG4Xw=;
 b=BCXX4p38uYMlp0RBxx//1mJtdgH8QBcsVbN/Cr/4oFepLwdFccnvV3L0FImYthIV7N
 C7r8CtxB/A8c1d49mnvxiwEbxC0RTlFJw0ULGXL3HpSUZyXzJYkQNPjA0ARyCSwLSOdZ
 un8IxytH9B3G6StQkcqWwxHoU58bKPL8Rbtq00fpF0uGfir2VDWp8K8qPMA5b76lcO95
 6h8zBSDC6zgOtz8YzSiAvxftaCyN6XBDD/NN4r6TpCRkP3jJc8UlvrkSWyncg+WZUuj3
 9Tj8GvNYvkaQois+c7Pkc2PurVCJyo3QXQlGXuqMgdbE1fuTg+XG4iar7wyV1HwrQ18B
 bhvw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773943487; x=1774548287; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1UvD4fAQjgtqKP3JgMnzdAwMrQooTWDEYsukSchaXus=;
 b=o/69QQqKYYggT8lJ8PKGUDqFn9nVDiU2EWeQ4pWR0t7rXvIjOt+2Dt1D3CfM6G0gG2
 +r5LtDdLyl5NL4AHwNySTJOE5OW8Trz7A17yWdsLZ1YaKI/OmbFdZKKcHR/deOhwL71q
 KcMNc8Clcejsa4FCSc45dEsJDvlHtvi2MC4/ozX1RRAWqUUuM6DFiB3avujedgdir7sN
 g7739+Mhq9vIkK1LyruacqVEsWDRg3kxxRI41+Ni/M82BI57V0Xd6AoePWdYemZuWvKA
 t2mQ83mNIWFwLbM8FaeQTwgiy7XiVFYXLA7KzM34QR0JomUNsTwSGWtFhhs63zQ1LGSA
 pS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773943487; x=1774548287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1UvD4fAQjgtqKP3JgMnzdAwMrQooTWDEYsukSchaXus=;
 b=V5zfQBt8Xddp96wxn4QISVa5UfM7AxIuJgSchKCgijEZn4mAo2bW1U+VCMRiAggdvy
 MYTISZhGJOz3WLL6cbYNZOkq8Zr+LZmCZomQPKfwMEvIC94CT/lG0ZbCyqpiQL7uZBxB
 w2knd7P/9aZL7mPgkof8spQHBWu4ra/GaIAL/IyZ6E5F9xQs4UHpkR2aNzTzCUiarwRm
 LlmVgI/xHZaD+MiuKUTWLr+dMIIw8YkV+jm/0RDC3Mmfa9QP/XIItaDW9iS/JG13EXcx
 QitT1foHb0YDMhenPmVpIve/Jp2ruI7AWTmbYQKLTvANgTrokWfFFOsc68FOW13D/mIq
 RfGA==
X-Gm-Message-State: AOJu0YxQQTj+QpZ0Y5WUO11aSWSn95US7s0LstbeZqWQpNGaZfs0ys4k
 9i4Y+6TBirNwNrwFjt0q0JKHb5LL2c6rJ66wp98gcrIADfh/Oz868AdUvq0y1G9/EFTnhvhv8Ez
 wYg1ktrTV5XATRjyd6tMEcX2yn0AkD1YfsdnPIGufCe6EG85xg2wd
X-Gm-Gg: ATEYQzw+UKYW4xlJzw1sCepDhYh4Yh7QoHm2pV0eGJmles0f05wNBZpfwyWJCiRhEHS
 y5ScntNVeVJDnjydzDGQdGEfTaHGgs6ppeQBNKeehUs3oYftjwxf3lUid14aBYZ2ieIv2WC6Wwr
 RT1RqZFnsU795gA93DjIAD4yps3VKXOgOVYnz5vEHpn55CkYpb2ebwR9qjfBe4RI8qi8JvlL5VI
 W8yDo99zhOt5bEvu74nMk83c4g4F+ZKGUF64Zz9ixr0YBy0nS+VYluMqE2FItF65NCjFIiAymla
 yv+08H5lCxlOF3vlyi1E7GSRP0z9ltoey/ujKbog1xtKZzFfNJhKbvH5R69kwx6HiCg=
X-Received: by 2002:a05:690e:2490:b0:64e:a107:c3a3 with SMTP id
 956f58d0204a3-64eaa6df089mr366239d50.24.1773943484886; Thu, 19 Mar 2026
 11:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260318141415.8538-1-vikingtc4@gmail.com>
 <20260318141415.8538-3-vikingtc4@gmail.com>
In-Reply-To: <20260318141415.8538-3-vikingtc4@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Mar 2026 18:04:33 +0000
X-Gm-Features: AaiRm50tgSvfQ76RKYpzNN0AfBOEAIskI0fK7PmO4-05YfgqZvaV04DTCffsaJM
Message-ID: <CAFEAcA8pktQGG5Fd-F=0SRO9MTrC0GVcOf3p8BnneqG3F504xw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] hw/core/loader: fix error handling for
 get_image_size callers
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: qemu-devel@nongnu.org, Corey Minyard <minyard@acm.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Wed, 18 Mar 2026 at 14:15, Trieu Huynh <vikingtc4@gmail.com> wrote:
>
> Check the return value of get_image_size() and report failures
> for non-mandatory file such as FRU image.
>
> - Use ret < 0 to detect failures in getting image size.
> - No functional changes.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
>  hw/ipmi/ipmi_bmc_sim.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index 012e2ee4fe..fd875491f5 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -2561,6 +2561,8 @@ static void ipmi_fru_init(IPMIFru *fru)
>              g_free(fru->data);
>              fru->data = NULL;
>          }
> +    } else {
> +        error_report("Could not get file size '%s'", fru->filename);
>      }
>
>  out:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

