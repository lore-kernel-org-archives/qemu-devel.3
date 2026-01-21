Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1ACC4451C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viWVt-0007lE-Qe; Wed, 21 Jan 2026 06:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viWVn-0007XE-0j
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:36:35 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viWVk-0001py-Eg
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:36:34 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-790948758c1so57820117b3.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 03:36:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768995391; cv=none;
 d=google.com; s=arc-20240605;
 b=IbZh2zaO+EYBcvR65CqYxrltVIFGXB47enfwkpoqaCQyfWRX+hV7+6Tq2kwpZ09XqI
 cULavLexnsKmcZGa9lEabS8P9NOm4Iei90OP9j2EixyBhkZB4SUA/DXJ/SZRHaqz+wGE
 0J98ufDa+FXPdcqjY4G0Tz/s1dg+62ZNDrPXLgoook+/D/Dpz36DCMrW2TG45PjkXlQz
 xStAs48JTFHgB/UMT53XGHOzFIGqgur75Y07D3GlOS1QVmx6GyKE2R5xcYalzMyHmkA2
 Z6BLShtoGkeO6bCsarAT70R6kYKmGLapIMurJl8SyQ8Bh4j38Kuf4AfRWKI2ys3oAaow
 CRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=F7jneCj+QYd1mBy4/r1F9DmQVgBwkANu6BpQHpfadcc=;
 fh=ihDb9kIS7rV8qvbfVXQ1L3n9dCNu/nz4N3ECoKPJgCA=;
 b=VJKuZHFIy9YlzVPRug0SRgwjHob0G1bQ+pEVX/ykNFZ1sHBuU6LJOZzhcU0aX5fCHd
 Wy6xz7jcHCMKINmbWKsyJJNByGjlHbFosGWFtdTAlyP1Hp+PMl6uN4NCiYBVQhqpjiKW
 My10vDFDmWX0hx84Zj4o+/5F5ZNLnO4z4SX8LJ/Cmo/xN2dNxRODbT2Y0/WiCrcGSJ2e
 N57ikVMG89O89KiXwrniX9YT+FKRGWF8SgwobGyv8iNhOMK0G60hOGZdh+Iax7FhOSZ2
 dfxSekZTJxZMJnEssvc87DbSwfaIkyHriHOEDfkQks6o6a3lUojPzdgweTRtrXmafMxX
 N0Kg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768995391; x=1769600191; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7jneCj+QYd1mBy4/r1F9DmQVgBwkANu6BpQHpfadcc=;
 b=g9BszXDUS7B1ZNsTRVXUZgWWRl3ElYvzKQ3NwapHL5YrtzHSNUae1nctqN+Qvy6CwG
 saEimV2FnFzzma1LKm2ijnJkRhdlo/MIAFTpolUvt8NKONc9Ug17WyojafhU8Z6u3b1P
 8sqvQv6TJONIcdT+zKgTcN5Y1g4DLVOtKzxUDePdBBwHcDquKX4eTxSb2HJ7qEUp1g8x
 Z9x5q27n92HjjXAWW2zDovBQPRL5+noam01Chb+713u4RqI3WjvzRTtOPs04+v14RnG+
 Fq1z5Ef+kRyBKZFoVdBBuJxjwzSNkOufJ16IolVQ1MSw7kF6ojgetJIGVO+slxokN1n9
 Nf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768995391; x=1769600191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F7jneCj+QYd1mBy4/r1F9DmQVgBwkANu6BpQHpfadcc=;
 b=YthVyNqDRP/V4hsZ9IsJaaqNa7tg34FfiVLOpHfhgqhJe42wT34DlYikFzSuPL1T8z
 enzC/CivXW9ksCAl5Pzq4k/M39VnMdynrXzvmXwN6bzz/XR6El1/7gDDGM1ogepBsew1
 D0GrGmJSRcgCrSTSluDUYm6kt1bRTSknArYXiaZWVbFO3Rtm5gAyUbaDKPX57RzxYV7A
 EZTkoB7DLX44YsUpUrk2v1Sv2zsGn8R2+wTUqOQJUov/ODedjRV2beJlzP0iw8vmTlkP
 GH+f9Zc7Wx3XCoSx85Lqg35n+bFpq/BKVSKtx3I+BfOQEGRsyot9DTNLeGdNC1nDsq8G
 9kGg==
X-Gm-Message-State: AOJu0Yzdt3UQMcNZwSpiUrnA6w40ygr8JzoJAYLN+jzs9GigsCPf72pO
 qB77sM+5rO12oy4Mb5XP0QPPK35gVyqctIHS86AvCGb/n8JaVyTlxpOfvUTT4ilSjVBz7z3BCHW
 ZHhhuPVHy2hCH81iMwv9QZ4j8pt5bQzv6zFTnW1m0fgmChpxOmYJw
X-Gm-Gg: AZuq6aKqvzOioE8swUWFuwcRTSeRda7vg8MvgY5PnnpOdMYgqx1zRTylRP/Qs7mHFWB
 5G9455vqQ/3SZU668lSg9o8mQUQy7ErHUyiIuDPPBHSZG+Iv/FNh8LI9Pe3QMPoaSQkCoBFlZG5
 6rcDh4PaO4zJVPzxrDRdwx9FM73ZnI0hhWYSEq817HSqnL7dU4jP/NbgjZLaFRvH4wYH0mPzHi5
 8LSCL7qrRnXcu6y/+ED8uGysoooeNYi0LsaP+4lqo7Qmk7w/B8HLFYCzAPyr8gzsPtkcg==
X-Received: by 2002:a05:690c:e3cb:b0:78c:2c4d:3dfd with SMTP id
 00721157ae682-793c525d183mr155486087b3.4.1768995391220; Wed, 21 Jan 2026
 03:36:31 -0800 (PST)
MIME-Version: 1.0
References: <20260121105932.135676-1-alex.bennee@linaro.org>
 <20260121105932.135676-5-alex.bennee@linaro.org>
In-Reply-To: <20260121105932.135676-5-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Jan 2026 11:36:19 +0000
X-Gm-Features: AZwV_QgenkRK-I15l3G7kL2_V-dQC0mqSjTfnTGD6T24oqCOVx6rGK47hyTfY6k
Message-ID: <CAFEAcA9L+e-C7+SQKJ_UDptbyporc3uoqGxeZi2McO3XVXj3Lw@mail.gmail.com>
Subject: Re: [PATCH 4/4] hw/intc: avoid byte swap fiddling in gicv3 its path
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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
> This allows us to keep the MSI data in plain host order all the way
> from the MemoryRegionOps write method to the final KVM_SIGNAL_MSI
> ioctl. This fixes a theoretical bug on big-endian hosts because we
> were using different size byte swaps which would have truncated the data.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: qemu-stable@nongnu.org
>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

