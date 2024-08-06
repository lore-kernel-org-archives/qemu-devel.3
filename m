Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79200C49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 14:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbKpP-0003Mc-Rx; Tue, 06 Aug 2024 10:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbKpK-0003JY-Jh
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:06:15 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbKpH-0002bI-AG
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:06:14 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2f032cb782dso6059611fa.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 07:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722953168; x=1723557968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0kRlxItGhhdEDJvViyrsmlRgxH5YInPX6tZL0SnUUEw=;
 b=QmvCfuUqfyjdg9K1XTLhNShvgo/pWZ1Ps38gOfDy7a6Hje0ZJ+1fJxKYC6KnbsyA4N
 qrnrEyik4aAHwdBCNMkqDM+FCjPvVWqwOEBel6mGzOju0+M5pvf9Jh0BpLjBQ7PA1hYo
 LhgKTD3j1JVl+FLuIS4b57yFfm5g+JZ9Qy/6fnBCTEHVrgSBYFHt5tf/v7LPcWnq2O5w
 1iUySCInAqYTn+4OhkCxiMBedcOqEL6g+Cv+ExHspV9QQLSwbR/Baunt7WU4NtqHU3Vt
 hMnRV0QvINEJnxAASitWw00ZJoVNTqXrByzqhQUXx1Re3OP0spygPOzaw3SeAgAsqhV3
 K9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722953168; x=1723557968;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0kRlxItGhhdEDJvViyrsmlRgxH5YInPX6tZL0SnUUEw=;
 b=KhSyuy8x4RSL+tc7z/8I73ktP/KF4lfoeG/vgo1IpeqgRfLBjvJZ7FKXwhPQtBB41B
 WXsBr6ecZ+lMyVCViBeU6/VwbehTsBG5+OFrHGxZv2v1QDQb3YpP/LDjwIile9d8eB67
 TqbOGx2ipANXtFYTRUFWxvImZYpqBDxnGBxqGU9BZgv02SVwWsz5IcZZb7rsOB6q9tgc
 tfbHo50RbXiCZUGeiKz0jWq3O4HCbAufi7bj2mRvSroil5e8do+rfq6feTcWNqKmKIX7
 7nsNseQgAnFvjibFus7861TxuZ0xlxhmd/UT4HB9f1N3aXG2MEWInP/7hHBWGLu50IQG
 CTcQ==
X-Gm-Message-State: AOJu0YxSAMyQSAHmUubNtSyR5rb0mIzRm0CJOH3cFJ2p2CkQanmXg7CP
 dGNHf9MEPiiBSWigTF0aW3fs8sSD9P2tEUv5URNm4njnuKkGZZrToMPnObFsSQY=
X-Google-Smtp-Source: AGHT+IFytsNyD6y38VKa89CugqDcL2gtldzVmk3Df7tyw1nQY/xLT5izrLRdQQpZ94VS7XJemfiahQ==
X-Received: by 2002:a2e:3501:0:b0:2ee:4dc6:fe28 with SMTP id
 38308e7fff4ca-2f15ab39673mr98839961fa.40.1722953167206; 
 Tue, 06 Aug 2024 07:06:07 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428ead4118fsm178069625e9.32.2024.08.06.07.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 07:06:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 67DB65F77B;
 Tue,  6 Aug 2024 15:06:05 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Octavian Purdila <tavip@google.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  stefanst@google.com,
 pbonzini@redhat.com,  thuth@redhat.com,  peter.maydell@linaro.org,
 marcandre.lureau@redhat.com,  alistair@alistair23.me,
 berrange@redhat.com,  philmd@linaro.org,  jsnow@redhat.com,
 crosa@redhat.com,  bleal@redhat.com
Subject: Re: [RFC PATCH 04/23] hw/arm: add SVD file for NXP i.MX RT595
In-Reply-To: <20240805201719.2345596-5-tavip@google.com> (Octavian Purdila's
 message of "Mon, 5 Aug 2024 13:16:59 -0700")
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-5-tavip@google.com>
Date: Tue, 06 Aug 2024 15:06:05 +0100
Message-ID: <87sevhrbjm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22e.google.com
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

Octavian Purdila <tavip@google.com> writes:

> Picked from:
>
> https://github.com/nxp-mcuxpresso/mcux-soc-svd/blob/main/MIMXRT595S/MIMXR=
T595S_cm33.xml
>
> NOTE: the file is truncated to keep the email size reasonable. Please
> use the link above and download the full file if you want to try out
> the patch.
>
> Signed-off-by: Octavian Purdila <tavip@google.com>
> ---
>  hw/arm/svd/MIMXRT595S_cm33.xml | 224052
> ++++++++++++++++++++++++++++++

I guess one thing we need to decide is if the source XML should live in
the repository as the preferred method of making changes or just the
translations generated by the tool.

>  1 file changed, 224052 insertions(+)
>  create mode 100644 hw/arm/svd/MIMXRT595S_cm33.xml
>
> diff --git a/hw/arm/svd/MIMXRT595S_cm33.xml b/hw/arm/svd/MIMXRT595S_cm33.=
xml
> new file mode 100644
> index 0000000000..8943aa3555
> --- /dev/null
> +++ b/hw/arm/svd/MIMXRT595S_cm33.xml
> @@ -0,0 +1,1725 @@
> +<?xml version=3D"1.0" encoding=3D"UTF-8"?>
> +<device schemaVersion=3D"1.3" xmlns:xs=3D"http://www.w3.org/2001/XMLSche=
ma-instance" xs:noNamespaceSchemaLocation=3D"CMSIS-SVD.xsd">
> +  <vendor>nxp.com</vendor>
> +  <name>MIMXRT595S_cm33</name>
> +  <version>1.0</version>
> +  <description>MIMXRT595SFAWC,MIMXRT595SFFOC</description>
> +  <licenseText>
> +Copyright 2016-2023 NXP
> +SPDX-License-Identifier: BSD-3-Clause
> +  </licenseText>

This certainly seems compatible. XML is not the medium I personally
would have chosen as a register specification language but I guess there
are no other alternatives?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

