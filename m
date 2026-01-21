Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315C0C4451C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viWVH-00063t-97; Wed, 21 Jan 2026 06:36:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viWV9-0005w4-CZ
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:35:56 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viWV6-0001fw-JA
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:35:54 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-78fb5764382so65546027b3.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 03:35:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768995351; cv=none;
 d=google.com; s=arc-20240605;
 b=FDvlj+JPPdnnO4DWm7q5DC9pMPWYLYOt6E0X33M3FJ9Fpq2y8qMKod4PDudHHNhfuS
 tYZ1GlUoi8cEfEp73S0jkeMVovLvBRJi6c2Uy1IBsgt/cVPdESHMTbHUG5lwwQuRpxLe
 50eAQMcPUfJpF13htgWidKmg88iYQMRh56V5WMDSAK7VNuM19lfVyIPVJO5KFX3+rOJA
 V0H6xlv9f2OcNVmS+C/Gr5esrcaP2Odi+tPItTZ+B8Pfie7l/+8LItggAH+N04nvv3/a
 lJANiJu3MhWMAoTZF3ZaXcQvKsTgl9NQdaP6D6iZHThWoxzluzt+NhdsyrQ6BTAoF6V7
 joyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iD168BTXwwJtIjCEYu2AK8BH9ffrZFt+7JKuYr47TDY=;
 fh=qDEitYY2TPRRMZ4OARbMiUT09q8rCCMKzcZWPtML1Tk=;
 b=YvO3c0aevC1EZfh16ZHKtOfum8Yrueg1nQo6H+2iq+/zxdO9qGlOTxIxMd/l6uRs0B
 ICxiLIVJHCUYuU0Z0pDmWdtsOyTpOWX2ka8g4bY6CBr4yivg0E7T7tTeOEgc2227AksF
 2ce5PUJRgdTBhimChsieUm1h15g7PIGqeo+bvX7Qc4WyXMd7JeuokdfZ4zOQbhNab0v4
 0iaBlm6G/Lo6YjHj74RDwFyLz7v/8PMIfxwg38n7PW6Uqy0MvQbZfIYaIftNUdasCjkD
 FgSXXC2XanByZvxk9nMM9mH6Zt+1S4eF/vj1xL//dWt44vYWwrAjWbN78OlV/5y+RpWd
 Jacg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768995351; x=1769600151; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iD168BTXwwJtIjCEYu2AK8BH9ffrZFt+7JKuYr47TDY=;
 b=sOwm4ozAVCCFLkcP59MptigBzDquXpqnOxj5FdeLLExwq77PZsGoeXfcQ9FonD9Z5B
 BeTH9UmXlUMAkwcPsCC4Q2zUceKqKm+KYDHaRVc7X+Xgyb6KJ0OpfNRI7m2PDoETlseS
 u2x5br0M82S3tr0FbuEwGJ2WUFIzyAJiGRNOM36S8rbqRd3pvX4NLBBVWeie/cf0pCRV
 IcvFY2EGZQGw3UPvGBOFVzNKdMz9DErVtrkDXFwEvy+uV9DggZHYW5VcfmOakIYnIbeV
 jxZo/7ETzO2kbfnGUHDX9qxnJ++Q9E9mjDcr4L9mi4+6VrvcW6YgsI25CYioQJCkkzNh
 ymfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768995351; x=1769600151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iD168BTXwwJtIjCEYu2AK8BH9ffrZFt+7JKuYr47TDY=;
 b=QzIKADmr+XgkL7QkIgpAQ8rvZ/TQ1T01aE1d8m1nGQ7gAZIwscLvZLxDbLhEpva24/
 vYFba3kBAY6wq7oZ8BGWfV8V5iR8q5ps4/NFjBHK5GcxpM7Hxrg/ezbOHXNWSGlUItpF
 iN5GKecHxvTk/F6Y04TqDv3Gkiz2UPGY3wfBzDywcp+ugEDQDWRUzxh7eoaXPTJoXOcQ
 y/DrdiG6Sul2rYFsjSAcMuR/HOGqz2HORElS1TdSr8dQ/Ttk5tTe1RX/4LmYyLpPCs24
 GEc9Re3iHWYzypeFxFTiNvdoJH0v0v7rMuuo2U4VWzFHZrMINCctFleglXDPsNVMsa33
 Kj0w==
X-Gm-Message-State: AOJu0YwNnHwW0EO5Q/DaC/dn9rRaiqaDGqpqnbJT87j+fadmQ0+gtX3p
 fFpZEnNw088DaxKlv4RmW4IoaM5XCBCB+o8UdVGZ85isTtGCGWp7UePWh7Gi2YStcG7T8es4eAh
 yKLcb8qS2o5vmDaRGQmJK89+JorSlDcuGyI1E1ttFhei6Dmkk9X+0
X-Gm-Gg: AZuq6aKo3t2BcAoog83JN/N54sl6JavDD/VhsbhVbfamOlvNfbDXe5RqIVL8BXjeeIn
 iES9mjVmVEZ/cjpJ0m7JFObmzPl3z3qfIeYU6hMgzo3GDgh2/7/tgt6A+8d+Z+iYk/1r7ACx9qZ
 Z5Fah0cTS5F2M57bNrPY6RFAPnhoyh7MZqPLhjs8yKVtJgLYvAuSj6a6tHuywsMJtvci1qZukP0
 gLIoe830jn6lIZGt7oNW835Vc9ha99cuV5oxfasUQ4T0doqOw+QqD0GC2F6yvE6McOoBQ==
X-Received: by 2002:a05:690c:990:b0:794:1eee:605b with SMTP id
 00721157ae682-7941eee6723mr6911097b3.3.1768995351514; Wed, 21 Jan 2026
 03:35:51 -0800 (PST)
MIME-Version: 1.0
References: <20260121105932.135676-1-alex.bennee@linaro.org>
 <20260121105932.135676-4-alex.bennee@linaro.org>
In-Reply-To: <20260121105932.135676-4-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Jan 2026 11:35:40 +0000
X-Gm-Features: AZwV_QisCTAmi-nyeEt4S0gol4lklIYRhmE3gOeq9PE2wplo2GDOuu7f-QThCeo
Message-ID: <CAFEAcA8s3DqGubp-h9wSaYMdsURL9GpuGNP9CYq+CUFaTA8eWA@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/intc: declare GICv3 regions as little endian
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 21 Jan 2026 at 10:59, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The GIC should always be a little-endian device as big-endian
> behaviour is a function of the current CPU configuration not the
> system as a whole. This should have no functional effect as the GIC
> cannot be instantiated on a BE system but will help the single binary
> efforts.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  hw/intc/arm_gicv3.c            | 4 ++--
>  hw/intc/arm_gicv3_its.c        | 4 ++--
>  hw/intc/arm_gicv3_its_common.c | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

