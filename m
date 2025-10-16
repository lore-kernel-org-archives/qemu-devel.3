Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB7CCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 13:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9OGM-0003CO-MJ; Thu, 16 Oct 2025 09:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9OGK-0003CF-PS
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:43:25 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9OGE-0003w3-1y
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:43:24 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6354f14b881so581841d50.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 06:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760622193; x=1761226993; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dO9XLCR3OPBZVTfEFxqwsFSfymizFjU8XFovONfNEFI=;
 b=fcfkT6reDWK2SNKA+wECIurC2kWxfVZW4KESGly4THYjoehOwqDk0A7twQKoiXWFSL
 L7t2XUHs3xCEscNsJLgCOaUjsEtT8j1w6ot4v9/zB9tka4G+K/T0RRjAywVqLaxhvfWX
 Oi6BdFxg8lzvkgxiNHkxHdqX+ibh5jR3cWv01rMZhlr8MzB3XWij6gFzJoocg/qVf6Bg
 PS3K+PMHO+9M10sR6C0lS5KeDrf4HxMH+uWCklnSZUFSs9TPFMgPd0jDuvaJFTutoQgD
 8QNoobVWk2ySZ6m+/ikd2wtqMhl9tFcZJOmLz0b13qPOIB34bF6yaqI7V9RZKbU8N9tT
 6OqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760622193; x=1761226993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dO9XLCR3OPBZVTfEFxqwsFSfymizFjU8XFovONfNEFI=;
 b=Y8AgjgRmH2JS+ZpjtqWC+1k9Hi+aj932n+C2CAgIRaikDJcrF8QdiMwxvHe1f9Gp31
 9nRSyQ3Gj0Q+dflE9RjAJCCBUuWN5RBehI7KYfZcuEeCc/iK22YipEnIx/MjfsZReLsk
 SjjdPbIU2vigAKYtP7w/Ze0HqDoJNF0XOFUmyGRg8jQipbtUmG03L+uNFeBO4QA1Pc2P
 u1z9PXWjmvZ+o8bSQL6S8r3FSupXK1kFOfLtTZ6hiir65VTKQr34QoYCbGjSJmzO1JXX
 1IxecMw/u/QYOR8xxInmAC6x++WL7MvUqyfSABoeM00kx3G5hQJVtYjN09fsCbf+yQEJ
 dWLw==
X-Gm-Message-State: AOJu0YyHYUv5yZcd37LzJDSrFbwO5D7KgI4g+JvPGPl58b0KCyM8jfpb
 x6c25P+yE21L5/Ng21wS0Z+5rCJXSRMONj6xuBwyfteDamTT03TAs1Bim/3k2GnE+fVn2Tqitth
 uEixKVbFQcAsqmT4yhHayL7W1KBHkQSZxCVoNuav3bA==
X-Gm-Gg: ASbGncuwQMlzAGCZeDy0OoEIBl7JBj56zP8l70VXdco05Ot2uA5pO8gAsCGt+26BWNc
 YZtqepsHDRaJM489aCg20u26KkyU3jrpd8IutzociDd0x89N9Nzb8HW1gC9lqrb/jhVyIOITh8E
 Y/6p5jrRwPG53xOSGtIMR+jHuHr12QKtkgOWwnZJH9mj2Q/JdAp+a9DWHTLpL+hQPaj5V+Zp9ji
 4UC6p4VGgQ+hFGSyEf4sD7/a8YS/I//kPGMIOTjxih7K2iza9q9XGoZqMu67yilc6cVo1Pi69e+
X-Google-Smtp-Source: AGHT+IE/wAv3GwjrrKYpVFObMzZuI3ctE10G3XLKImSlsE1EPAFpUJmJvY7AkVe+xiEqZi0xor8PjlEMebaC5Z5zVLE=
X-Received: by 2002:a05:690e:11ce:b0:63c:f5a7:3db with SMTP id
 956f58d0204a3-63e161f696emr211552d50.55.1760622193066; Thu, 16 Oct 2025
 06:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20251016133643.1659686-1-berrange@redhat.com>
In-Reply-To: <20251016133643.1659686-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Oct 2025 14:43:01 +0100
X-Gm-Features: AS18NWA19zO2mPMvAhAessuCR6t_bjVGd10eQCC8SDvw7tJhxS0zaRx0-bL5aBM
Message-ID: <CAFEAcA-nPOYtbH25J4aieniaGdypfxpnayrxSJjmqL6Utd-nwg@mail.gmail.com>
Subject: Re: [PATCH v2] tests: use macros for registering char tests for
 sockets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Thu, 16 Oct 2025 at 14:37, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The test-char.c has a couple of helper macros for registering tests that
> need to be repeated for both IP and UNIX sockets. One test case was not
> using the macro though.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>
> In v2:
>  - Placed in the server instead of client macro
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

