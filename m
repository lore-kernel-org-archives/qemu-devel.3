Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04C7D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 20:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQAYJ-0002qL-QL; Mon, 01 Dec 2025 15:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAXj-0002eS-0Z
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:30:46 -0500
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAXf-0003UC-8b
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:30:40 -0500
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6432842cafdso4213845d50.2
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 12:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764621038; x=1765225838; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ul/gzOVzjbkr3PACK8ElMCdlQscV0JqsTPZbv1hV+ew=;
 b=Rasr9fWm88THLmVfUAMIgdmh/UVyPjqH68ahLOAjahl/+/AOYXUf2zMaDZslDY7kCe
 pXMAbcieBBXfYYqtT2+UeqhiNdULkM6c+ULPJ4Tr3TnneXpII2uqNo6lZ2UowRLUvRuS
 h1ZYyjtpGrBPM7xG+Nxu4dwTY/1CpYboy0fjSuqB2qfj0np29FLu2tOo1DzeyLhZxVR7
 k+OrM57gqS1RYwvjkdl4M9Hhb0t5mT6Ous2UJqPryj4VqdsupwkbxO7p7dAy+/xUT7jd
 SxJEOHsq8agfe4T+iImxZ4wh4t4L34idoq+L3tvaFZK3vVOZF6F+2Hl4AQMvl6B4vlYu
 67oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764621038; x=1765225838;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ul/gzOVzjbkr3PACK8ElMCdlQscV0JqsTPZbv1hV+ew=;
 b=Y8XVuZ1HpO1/BkLO5t6oDWAmj1Ulwcu0aqH3moQYGzCZqpYI1C/K4rSd6ueEkVYatW
 j6wZutAGVP9dyxJAiSZ7U2Iu3jBruyYgiLNbX9ArGEj1iSwXsFT+dmNq62DwlaIFQH6j
 x4xz5P52O8183NCybF63n8uWvbf3z9OybX97JqIiv79qPRpunL7oO748mIJ7wO9ndMUe
 nk0rYYnKiex1XlInXNKFOBP2bsiBs2NTXGG8t1RHxjIsdbRitzCBsewreByH+xyABSe4
 BPA/StHVr23w8bH0dWBz1d/4YHNuZV8Mho9bsiOQh8Q3scsPScDd6rxIeGLRtlfJJ9HJ
 CGeQ==
X-Gm-Message-State: AOJu0YwMm71cLfbskGqOt2U8P6fCdOI9GsFF7tsnP0IgnIeAv0D0GF5d
 h0WD5Pttcb1XQgcZpCpfoO+0E8QI3sh+fRWNtK+gnrXzwUSJW5+vlcMm+O1tFsMLNUaqSf9udsi
 xVbQpyakjpW9+R0sK9bfVRHXZeWNMTjVLXLwtQ0tuyQ==
X-Gm-Gg: ASbGncv1KYTDUbRHdDwxj+X+90+ELIG9jx66zmI/K6bKejdFa69OAaGbDzq3FqfrWlo
 S8Of8ikFBaiy0rXrlm5dtE67V9UGroOhLfgCCBytIRnfsVhpHwU0unVkeCN/2a3bf7lFLGrG9S2
 au3/3kota5aMZ/OIt8Jr8l3NWKxJguN5MPGyO5l0pogYWkidOYt15Ni/604dn0ntvIoVRlyRnbF
 xv768vnMRiOsPpwJiqIYinr0G2kE4UY8twkfPv9myD5HdjU5neYdGFrpoDeDyBOHnzQ+xly
X-Google-Smtp-Source: AGHT+IFM/Z85p0xHLBMwnGCJJgijS35Pd366Wv5GysLgNsSZvSTHYkXD7ZqvblDl5rUuVicfLQVSSTNR/QeYw1mGmpc=
X-Received: by 2002:a05:690c:6f0a:b0:781:534:e754 with SMTP id
 00721157ae682-78a8b491722mr306170477b3.21.1764621037889; Mon, 01 Dec 2025
 12:30:37 -0800 (PST)
MIME-Version: 1.0
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <20251119130027.3312971-9-gaurav.sharma_7@nxp.com>
In-Reply-To: <20251119130027.3312971-9-gaurav.sharma_7@nxp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Dec 2025 20:30:26 +0000
X-Gm-Features: AWmQ_bkdMWJ4Td-bwgop7KSaRB-tACM0AMOdEUOJLb034OdtmR4VGfjbV4btXbQ
Message-ID: <CAFEAcA9rdpa6sVxRYP6z0wDbOF26u41cpu919um7kYb0hBy3zw@mail.gmail.com>
Subject: Re: [PATCHv3 08/13] hw/arm/fsl-imx8mm: Adding support for SPI
 controller
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
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

On Wed, 19 Nov 2025 at 13:00, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote:
>
> It enables emulation of ECSPI in iMX8MM
> Added SPI IRQ lines
>
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

