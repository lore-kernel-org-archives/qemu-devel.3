Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DEEC44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 09:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjDBx-0000IM-Ks; Mon, 13 Jul 2026 05:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjDBw-0000Ht-1a
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 05:43:12 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjDBu-00035C-F6
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 05:43:11 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-66628618509so3515535d50.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 02:43:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783935789; cv=none;
 d=google.com; s=arc-20260327;
 b=gvOITWmIPuh7umuaT7uKa65Ncl0YvoCQYHKYhgqcFMX7cKoWwJO1UU0m7yl55FoPK6
 md7LEw+r7YOE5016EE2QwmF2pBOz7Z1hlwPW43oGG/nqqB3ak95Bu5uzUK/CLZMZkdLG
 9XbgZ6M+1VVIEPbi6t72fvdUOOeKaMLw0eX307KMhfIrbHapO+V6uzdSQx8fHQJ3ZrkJ
 a4RMESleYO2GU/mzX3+oI6LI4JCyVxyk80dQTnC/iea1OJT0z2Kg4J3r+We+ltWxSqlO
 Mna9xfZ5erHGqEw7ewS4ah+/7KP2C1jTCaq8QK8MTkRCB7KNvIHKBlHh/zDKK10jj7XI
 F/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aE5tP3Rqpl1SE6ouyMMEn9SJLMeS7E6Fq36Zgln9/Og=;
 fh=0zHBLAYzyBXI1dAKa6UZfi64FavnmtYudnul5d96P+8=;
 b=sIUlAb9ysN9/kgtEpdpFrim5a/aemKONez5u8F6r+j+hYl8a/zmgzOTvzhsFz7s7r2
 ANBlWxfrMiG40kUU621BtoQI+CJ6XzRjcdXECoxymw59OBznF7v5upktj0EKT1iIQ/GU
 /TNDOhOoM+JQAxZEVHTtgFfIer17lfK0foRWgIWAV4TPgfJZJcD7r6eJfLEZ2jgm1sd9
 5xuYNyMPtwyqH0i6Nu8nByXQapu+DXAVqmdSAOSTSnFqSTWtFD79x/em0sJ/XDMOp+T+
 hob9YqJtZPJ4ahQA0Iemwz4020AhFz9aGjLYypPWiM7O1jGjKwfe+palh3gaLxaBqgaG
 Tt7Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783935789; x=1784540589; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aE5tP3Rqpl1SE6ouyMMEn9SJLMeS7E6Fq36Zgln9/Og=;
 b=bDfeLRxnzQMAzQhT6MlqUrfYedYE2Gp2cpXIVHxF6/hXzYR5ljRwJeBKsaQ0vIN/a4
 7ua2e/xmE+ZcsmTFQVajzqjfkW1RteMflVde8oQf2F1sgn4jeLk4byubrTzzihrz6okV
 iylzp+8VmnrMSPgVAu4GVv5vTHvDWVBqYqBjhjfbWK+jh2okj+yqgl5jM+A7Qqsl6kJH
 QpmtpykAdaXQv6H1ATQp1ywFyK/qddWVRNZzZ2xLnnz4y6gmuUsOpgDXejLDcxSZ2cML
 m+MoezUvSPTlUVJqUs3CxmErSxIxR2klxB3TwhdVFNJnAeRarZCeatxVpe/PclT2HrxX
 DQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783935789; x=1784540589;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aE5tP3Rqpl1SE6ouyMMEn9SJLMeS7E6Fq36Zgln9/Og=;
 b=s2S6f37YmdWdcWyxSON0Q+5yvFtWZQDH/5zFT4vZ63Z7jJhFWAuulG0uL/EuQck4P3
 7mHgv9IRFBTuvCkrD0aPlFvgBxXTJqI3jben/weQr7nEiic0vPIWMOwgQ0oH9tyJ9fLc
 0862cKSHzusjAhyturLG+tVikO7qZHgc1Fwa5/qLOdzKPam+SeAn0om4ebBiVw5IQ1f/
 Fe2s4GZKe3JxSNmxTTaf9KoV9sigst6P/7k1yK9DdwBhtXMX4CMPWhVhomaxB0xubiLC
 0OJ+hgMHJ7WC6YlfOXynpdrs46FzercbZTR3EbqRI16B4VgoMvjyhLKg3eo5L6xDin62
 ceTA==
X-Gm-Message-State: AOJu0Yw82kWZlRrFlcxl/FQjZ5bqBnOc142n8lGGlubgEFNOuU+/ZTXq
 Kd/j5jrncnZHJEsFcjg3sYNNM18KODe8m8sf2cTAL8yiKvsCilmHXoBTBIVhLRUHBMkBti1hKLZ
 wLFabc7Qkuf/zFLlHbVcAfGA2xGz5JS76X8MCHOdCkw==
X-Gm-Gg: AfdE7cmVZLu/fddLzNkqnZtlj/jB/tmiGA+93sq6JL6pgWPL2rhFsSGafEJHeRLh+Vj
 fdoY/sPXWoGcQoLXBTZOlZtGDeP8Q5VHxqECwrbKYPw9k7iRY3xdyVR4UpZ8cHe8120OueqJqCO
 DRAn8msuvPesMv0YOAdJHqQz+4xnQaFJP2zcxt239Q4abxHDCVDYqMWisVhtS8+vTwAlNkK3Rq1
 WE1k+2fjcNfTLnxP1Cp6LP8hJ6GthCRZ3VJlWL9axvho4HR0M6NdRMGiY2xDQ75N8l9x2JNjoB7
 3SLxvrbJp1ysOp4ikKR+b2U+j0zw8mDCyD498tL+wso4J9C2LMH+ndD1
X-Received: by 2002:a05:690e:4419:b0:667:cbb1:5f1b with SMTP id
 956f58d0204a3-667d7aec69bmr3863233d50.6.1783935788643; Mon, 13 Jul 2026
 02:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260706175408.905362-1-peter.maydell@linaro.org>
 <71ed76a7-f52e-4412-9e75-da9aae1f6b28@oss.qualcomm.com>
In-Reply-To: <71ed76a7-f52e-4412-9e75-da9aae1f6b28@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2026 10:42:57 +0100
X-Gm-Features: AVVi8CdXnB752mBBsb7Rsfdh7kesOCpyti_svsnNv3I5DAl6FnsL0bdw5cfLLOY
Message-ID: <CAFEAcA_kNBxNZ2xdByDE7u24QYkZxB+9051S5WKMU1U3jtM2PA@mail.gmail.com>
Subject: Re: [PATCH] hw/net/vmxnet3: Correct bounds check on tx queue index
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowangio@gmail.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, 6 Jul 2026 at 21:44, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 6/7/26 19:54, Peter Maydell wrote:
> > In vmxnet3_io_bar0_write(), we try to bounds-check the TX queue index
> > provided by the guest against the total number of queues.  However,
> > we have an off-by-one error: the valid indexes are from 0 to
> > txq_num-1, so we need a "<" comparison, not "<=3D".
> >
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3780
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/net/vmxnet3.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Thanks; I'll take this via target-arm.next as I'm putting
together a pullreq.

-- PMM

