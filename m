Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83530C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 17:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhtd5-00034t-Iq; Fri, 01 Aug 2025 13:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhs8D-00020T-V9
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:57:22 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhs8A-0001p8-7o
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:57:15 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-71b49a8adb2so18130907b3.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 08:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754063830; x=1754668630; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rqymJ02ej6aN3XKn5FTJkKpoJK+ExHZjjOV3QB93BVA=;
 b=wCnmjg2PCG7AUbiulLvmLTp8uiHF4WCEtALpePbllWfSjPGPpzL/7BobC+KZ0g31Eg
 wS/8kg7F/8tb1G8Cn2ofT8beFwNSfcvYsz50IloZQ3T6VTFAd9xzdLjLmtDBYuAaae4m
 Od7sXypUcbVnIvKKAnOcxCCYJ3AGLCnAnHkofbkddCT+rZ9BVrampYQ0v5VolgrwXVln
 HzRYO+NqGN4kznJ3M3twQ3M7+BN3/gLfjD4eoith540LaTOpYlavHhAM+HATydUEXXVD
 B/z2wqpkA6acJyypQacTJ2iJkPdfgC4xyhHvYZTCu6xsOIPYT8GztEuz174YgmxJUfX8
 1KSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754063830; x=1754668630;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rqymJ02ej6aN3XKn5FTJkKpoJK+ExHZjjOV3QB93BVA=;
 b=sV09x3Hogl+HlEqdaEEvJt7tTU/TjJp1lVSJDOrt7cJF3ctRZ7kbXXdcVHiGd8Di5B
 8ZXPBlr1sAoIycJIMxkCxFYMl+sDaz+s5G796YDbhA0TBtVRdXqFtLp5nMO6QK/S4Vju
 7FGhyXNpFFvGuBDXWnNakiSHNbWNATt88G9JoLsQC0vPyD5veoyMiN0/TxMWbXP8rY4o
 y+F8A9aUuia8BH93QfnnsxcozCWc7UD7WkNYkd4M0kt+EhanV6SW2AHNG+yk2psfBMgw
 y/Kq3fshKf1anUBWzBEsiBmyoR7tvGWPex8nNX3l4b0jyfSi9/foEUJrvy2W6RfDK7/o
 X8YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL3FihTZTgI6Caelg8abIJp8Ok52WyGsT7oxwFbqy7ZwZOOZAhtl5gpuMX4deuq680VV/p47+dLdyV@nongnu.org
X-Gm-Message-State: AOJu0Yxxxel/frfHikqeU80gugqIYhLWH8M0xSNYMopslF0lgwGKs/zC
 H5NC0A6NeqEmwYNkqLSeU9Uwvz9qivwfUqrPZaw3NBeZ96hSe1l3htor2T2Jd0IiLmdIpx6oRNs
 oEUPUevKMldO+FBAgsebgZhlurU122qB2xfaO0WoMBw==
X-Gm-Gg: ASbGncvS+UI7xhsEMfosZcQYmJ0CrMWAvID4pTvwHMwIyOYOcOyOJelbMcX3GdAP2Z0
 oTGiGx2lDBk16tnUDsAWDELZTyQMeo8DFn0iJMFPZZ0096XjNDIpjP/T/m0EvPWi25EbS+X89EE
 wJq3JagazanA2k1oy2EkZcgn36tYyzUj2K8ddQVGedSRShSnaHgCJiCcsUbmxVFHzQ+qQyX52AA
 3bWUO/P
X-Google-Smtp-Source: AGHT+IHwJaOTxbdDwazDzbzQPq4gqfbbSXcsu0rW+WDErkYV26F2FPqjNnAl3+iIlGl7WRGjmBV1O5b1Ra6T2zBBdhM=
X-Received: by 2002:a05:690c:102:b0:719:4c68:a70f with SMTP id
 00721157ae682-71b7f7f5e71mr1085617b3.20.1754063829857; Fri, 01 Aug 2025
 08:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250801023533.1458644-1-zhenzhong.duan@intel.com>
 <8b599c19-1901-4707-a8ca-943f61c0e2f9@redhat.com>
 <ed8451bd-853a-429e-987c-4ec86e01efe9@redhat.com>
In-Reply-To: <ed8451bd-853a-429e-987c-4ec86e01efe9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 16:56:58 +0100
X-Gm-Features: Ac12FXyWwDl71PARsmBbEqpCnGg8lJC1yPW1Yq9e6DTbXv4P7mBf_21TFYJN1T4
Message-ID: <CAFEAcA9uc7PFvD8e=+WS-1WSAsqoZR5BRSPDjNeYsHU=TUcrhQ@mail.gmail.com>
Subject: Re: [PATCH v3] vfio: Introduce helper vfio_pci_from_vfio_device()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org, 
 alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 1 Aug 2025 at 16:47, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> I have modified your patch with :
>
> +/**
> +  * vfio_pci_from_vfio_device: Transform from VFIODevice to
> +  * VFIOPCIDevice
> +  *
> +  * This function checks if the given @vbasedev is a VFIO PCI device.
> +  * If it is, it returns the containing VFIOPCIDevice.
> +  *
> +  * @vbasedev: The VFIODevice to transform
> +  *
> +  * Return: The VFIOPCIDevice on success, NULL on failure.
> +  */
>
> See https://github.com/legoater/qemu/tree/vfio-10.2.
>
> I don't think it's really necessary, as these are internal APIs and
> none are documented, but Philippe seems keen on it. I guess he plans
> to volunteer to document the rest ;)

This is one of those cases where we have a rule in place
that we apply on code review for newly added prototypes
in header files, as an exercise in trying to at least not
make an existing problem worse :-)

I think Philippe's intent was just to say "put that one
line comment by the prototype in the .h file rather than
by the implementation in the .c file", rather than to
require a full-on doc-comment format comment, though
I do appreciate having one.

thanks
-- PMM

