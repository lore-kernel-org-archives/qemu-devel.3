Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDED4C44536
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 11:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vispj-0002vP-9r; Thu, 22 Jan 2026 06:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vispS-0002ly-Ar
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:26:31 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vispP-0006Gs-Rl
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:26:21 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-7942fca0da6so2916257b3.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 03:26:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769081178; cv=none;
 d=google.com; s=arc-20240605;
 b=FFnfdPHGk32eWyQ84HPH8bfv5YRN04QU2gkt1/AaGZ/HkxvP/2trvONT8vfIpY939c
 HKXcSyABADXy3cSGidD9MAiEisV6gtL722p7u5CFv65MFosUdKYFAnoFfYckVh9R+o1m
 p5TGm2+fuI53PB2ATbuxBkaLKSWYkFXvFN0VEfHgRlFWqUm/lPj5iy9PqAfBm3ShoztF
 96cxsAERtcRqKMkPtje4ReL20s1w/IdbNpq1aSVFxVtvxa2x0m7nmBnr3m0EbQISGDBR
 N/M9wUKTH/lmB1x1UHRE6FVbcrHpaXpLP0Z6a8qe5Lng8L9JvrK32LGprkEHEe9OaWUM
 XgZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rgEvRkwGXbRvC0M7mP1KpwNQ5+3DO4/lNkgAX/APsq4=;
 fh=qDEitYY2TPRRMZ4OARbMiUT09q8rCCMKzcZWPtML1Tk=;
 b=ioUxnXksrB+aGHTTUeNA+AB8erv7XygFYOMRMcq87fTVSh1ygfcPRzrwqPcj7DELrg
 /6hoSOchBb//mZDonb/FktMo1HTDCPrpPrXKFlxagX7ckEPVgPBmy3FIVV9FwQc0OY+w
 2N3sKyhnf/1SGbn9PZggvxOmh/7duxQmCPqMNq3NdAWHfhar67Agl09lmgf4an8Bk3p+
 dZLif/BKx1u2VmMw0OYvakp73nkK7sRKTppnpZMAqDetLrtdLshqTlGIzgjoi3MARhVm
 jugLh0xzmd8EloaKDm2ZSDPoBiI8ycfmxFkLJ7EmgcPKlICYWh0UEcp3GbRvh1m34U7q
 pHeQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769081178; x=1769685978; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rgEvRkwGXbRvC0M7mP1KpwNQ5+3DO4/lNkgAX/APsq4=;
 b=XIE3c8sYVK4ZLD6eAEFRuxDDb3XJ8L3q69qWoRPQ5lBAfQ2WZXMEF5cl7uFXG0rymL
 BKbFLtm+t98Tzl+lJnFK8gig70ObpG43jIHWSZhJUj9nie/OLD8VpdVlptPzi9HE3zID
 JwGIo3D24spTqDUeGua1RgOkEy6F2n9RwLfaQNAWKGQZMHctG90cfTJrNjuaarhu0vEh
 9QQ1nVyfvb9qCS6ilq1wbpXXWE1KtIiLxR1BPeN9beB1aSFdMyF/mun5kxl8OG7QyoL+
 SGsg4pP3V1MOfjxkpboYPO8mkwr1ehocpyZaeOBwYqJrcspCdCCuY7Gz0dA8t4Vk0uGA
 oszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769081178; x=1769685978;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rgEvRkwGXbRvC0M7mP1KpwNQ5+3DO4/lNkgAX/APsq4=;
 b=JsXAlXrq6Gj19EjysaJRdURHZa45IUcSZd94zOycyPkiKHHDmRvkFdxJTv0Iu/bV5B
 qtK7WNn3qRKI/qhl62UkzVkr+p8u6fjZ16JBsfCO08pRufEgj5ahY3806MBufxdC6N5+
 NuF5/wpfmlZ0ZurPMpVc1xnKODt+sAmxAyl+VTEal1IWXLNhGX9pMm/gGY+JPIVWb+2x
 UpXmVzpIvSLsanzoEhZavZo9WubiVu4fKQ3S65R6LSbPNY/6lk8aRyA07zM6W5Am4k5k
 UGOLqL5oAY+XKy2secaHWAwam67QxV0EXcz98pA3wounQkS22G7iP5xnvQhYAHshFFIf
 0u/g==
X-Gm-Message-State: AOJu0YztdSTi1muve7SkXkB5tyI31CnLFCv0QPp9nfhrrWil+Deokmcp
 n8VeBHT/F1eVmKT9zKolUBfhrjPf8YFil+26tBn/q7m/QygXM0MtnIJD4xTrWCWD8lJSSsA9KR2
 xcDGktx9qCItkaR2OGOvFItAVVZ4bKsCpeYzLrxhSzNhSjtomXs1c
X-Gm-Gg: AZuq6aIF8L3cvxmcabTRXYE3AF6oVsY2yOg/YfaBBzoYcbCc+Wp87MS8Kx9kY618uxT
 sKXWxmuFES+U59tCMi8nxP0W8J+CVgj1TZ0dwwZ702A/j15uLhpGtGWmLJtFkTRDJ15akUPj8Wa
 FYH23ZUjoZqtFW1nyoOqZv22YZY43GXUfFOhNZI219ub/1hZji3DXa3Vn5DmxZPrKutyZLeS6cf
 FKvGcLBzY8d7FrvE4yvE7Y7VGNv7m3QCsWb4CrHpJXM7PF6/JKQyswSWDbMnLY2nkJH2A==
X-Received: by 2002:a05:690c:3701:b0:794:35b:af87 with SMTP id
 00721157ae682-794035bb38dmr75835117b3.63.1769081176391; Thu, 22 Jan 2026
 03:26:16 -0800 (PST)
MIME-Version: 1.0
References: <20260121105932.135676-1-alex.bennee@linaro.org>
In-Reply-To: <20260121105932.135676-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jan 2026 11:26:05 +0000
X-Gm-Features: AZwV_QigehipCatmEcqYer0yuU5Rag9xnEYyjpgG-Gw1DXFzh8ruUV6KeOCYYJk
Message-ID: <CAFEAcA-cnf1Q4VU2xOpukc7D3wYrxJ6U8hTS+Yme3p7EzcmsJA@mail.gmail.com>
Subject: Re: [PATCH 0/4] GIC DEVICE_LITTLE_ENDIAN clean-ups and potential bug
 fix
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 21 Jan 2026 at 10:59, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Following on from my RFC on Monday I have split the
> DEVICE_LITTLE_ENDIAN changes apart from the corner case bug fix as
> well as updating the other GIC regions.
>
> Alex.
>
> Alex Benn=C3=A9e (4):
>   hw/intc: declare NVIC regions as little endian
>   hw/intc: declare GIC regions as little endian
>   hw/intc: declare GICv3 regions as little endian
>   hw/intc: avoid byte swap fiddling in gicv3 its path



Applied to target-arm.next, thanks.

-- PMM

