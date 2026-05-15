Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09782CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 07:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNnRf-0005g0-U1; Fri, 15 May 2026 03:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNnRc-0005Z1-Ox
 for qemu-devel@nongnu.org; Fri, 15 May 2026 03:58:52 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNnRb-0008HQ-7l
 for qemu-devel@nongnu.org; Fri, 15 May 2026 03:58:52 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-65c7efdb7d8so11498518d50.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 00:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778831930; cv=none;
 d=google.com; s=arc-20240605;
 b=hv2IuIjHgsIVAKME2l0kqKGcY3mgrtblsH1w/aLAsPFryz3Y91gAlkEMFqiYoV8ojb
 ApbA+e870OmxiKdwYvFZHhPwhBDmfEEZRB/QD/MT0zAxFVyBnvoYcR7J7rwXSEFYfp4+
 X02PPiNQqUtZL8RnTjXgMIlJKhV31x3oyf94HpZgfGnlsDR93KNasZ/meGBZ0qLSUZOv
 6shhLCMK/wWppUi0zYJDydv6t0s+o58Dl32VvEtY6eUqtbZ5UpF25t8Q2mv8piJzC8LY
 xyD9gkxLxIBBrVtuMD6SQveOMrz3P2AObYNusbkAida4/uMbT2tBfSc4TcortRflvfko
 y3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aCWPdUf0X0iXViYYDjRF8om0aPEQZ7+tPs0RhD55C64=;
 fh=EdBdORVnIz9RJ3k79sfiFvVWk8SqTTyCtMFfcByd7Tg=;
 b=LbRFfiJItlqW/kXeU+xOyTVCsRN3CQlRK2xr97gmN3soLGUzKp6bOOYunMSmo7gqN3
 hpGTbXvWiBwnXOsGfAVIaiYlk5KvJQhJRQg4ZwYULnsWiQ/hf0VdlOBM4Nblxd03vTgT
 Hg4k5MFnuj5K7rFvXUgzRxgEtesSZAP2nE1/7o3e/Q4nKL+jhYFFFoPwRduorXgUAezE
 vmhyP5k0qUKI6k5fgAiQlmqrpCnrfTPJpdDOh62zzcstKcbE6sFU9OZit50XaBWSDVy2
 UgXfFg1aZiMnKd57cmOWxz9fWH77GGgrCyU5657aYkvOiQH+BiILUWj9gKvdPrl+bmde
 QaqQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778831930; x=1779436730; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aCWPdUf0X0iXViYYDjRF8om0aPEQZ7+tPs0RhD55C64=;
 b=bxSK66GiFHBYY/jt6IHL/Bqugw402vNwstDLDKTW0W4dNegkxQGPeKMyTOMdfi3Tu4
 OPD5MPHqYIv0ZvjSvTbeI52QpvlYqMrpK/x9WVX/tKylJ3pwqVYdMvBp62JsYlI/MX5D
 CVjCfItx4yRT3nesAn6pk/nJtTdSf4QFoDyrQsE/SjhzcW1dFWBqIsIa6kejUMfAjT1N
 1M5btPXt0Xbhigcgs0NVMPviJvF947pYRoCu41jk8QH81tv4ZBVAPG7n83VZdhcRhyJa
 V1hOTj8h4e7yXzGwbaT4ta0Q0GHjaK1ilhReWJJfU60/thOPWjE43L8/ChZB1PSHcbv8
 ZT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778831930; x=1779436730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aCWPdUf0X0iXViYYDjRF8om0aPEQZ7+tPs0RhD55C64=;
 b=fk1Z3hoOITSx05cmg9F6MxdAyYzFegqETwAGP2qSDK7LnOZc8Okjr4CUwAuhSNaDCa
 Za39UJutpvxNjSkxrRNkyMO0jZzipdZnuf6jljWIY4OggednAF/bdkMY7zf1WH5XeXes
 EmgOs8lEA/wYmY5nzlOr+n3+MmvCKbKiE6of5kBkTQJQBotnVduOYODv4VJFL0XFRifA
 UKR7QERQ2p8ueYYSI+lZP2jK0zIbvvPiakOrcp0qnlWDfzEUmmEWSIvAnhN2h8X45QO7
 vkg8LLWJx/x09F1sjn3hyIs/CknxrwGhgYV2dkXZLAawHFkr+0QFM5FiHv6O8OvJp2tG
 n3Xw==
X-Gm-Message-State: AOJu0YzokecgMZ2iIT2ecmj8tzEYbdh4qDhhhflv7JGV0LCPb9dhdd/f
 qj/kXs7ZixLAHWgGNhEBNtXMqJ4QBFUl8VuH1LTMgNSBUCFK3WYvq7775SpS473lNgKSP03bMJo
 hrFAOtDAr5i2t7rhGjaytfJMx3PmjfjdD+LAulSuhcw==
X-Gm-Gg: Acq92OFfeRXRFBZq1y5w0TET26de2hUVSZHl+4p7gEcFu8uB/pI0mh+wzXVWP0vlnIn
 gb/PQ0ATySuK+6tPx3Oi0Tz1PT9bXtVna1EzXutGkrGva3DlviPDxq0lV0u8XpbjOLLgJs4V7z3
 CvSLs7qinIMDGh4+mREG/IUqf7MdCLXdySuAzAhHOYOCeG+6/3XNZNz1GpdBc54kN866tflLqFT
 ThZg5DcIZLQt3wcqJWmcRFIyCrqtCzHfmEuDUBEmD6VHA6RmArCE6E+B4QibJCi2lQBAHNHhkFC
 lr7tmosHPdrWlWyVX5LKPhHwEyG7BMuz3vdPIg7hpTNYHasDb9TriOKkN4O/B/VrcLg=
X-Received: by 2002:a05:690e:4192:b0:651:c642:92a6 with SMTP id
 956f58d0204a3-65e2276af55mr2483744d50.21.1778831929890; Fri, 15 May 2026
 00:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260427232116.50586-1-scottjgo@gmail.com>
In-Reply-To: <20260427232116.50586-1-scottjgo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2026 08:58:38 +0100
X-Gm-Features: AVHnY4KkODd0CK1xC4rM8ECOFUrrGHLW2FhY5PEekLSGhg4ZO1_3B9Lqm13-vuM
Message-ID: <CAFEAcA8_egumRiafxt88nFYBGgfAPaEW=1Gteei=4Mp+pimH2g@mail.gmail.com>
Subject: Re: [PATCH 0/2] target/{arm,i386}/hvf: Fix HVF migration
To: "Scott J. Goldman" <scottjgo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, "Scott J. Goldman" <scottjg@umich.edu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Tue, 28 Apr 2026 at 00:22, Scott J. Goldman <scottjgo@gmail.com> wrote:
>
> From: "Scott J. Goldman" <scottjg@umich.edu>
>
> I've included two small HVF fixes that allow migration to work again.
> I've only tested on ARM, but beforehand, starting the migration would
> segfault immediately and now it works.
>
> Scott J. Goldman (2):
>   target/arm/hvf, target/i386/hvf: Pass MR-relative offset to
>     memory_region_set_dirty()
>   target/arm/hvf: Stop pre-allocating cpreg_vmstate arrays

It looks like patch 1 has already been picked up into git;
I'm taking patch 2 into target-arm.next.

thanks
-- PMM

