Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32C6CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kMD-0007kq-LT; Fri, 17 Oct 2025 09:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9kMB-0007iD-Lk
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:18:55 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9kM6-0006Hb-ST
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:18:55 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-781421f5be6so25823687b3.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760707127; x=1761311927; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CVwhx/Y3jd9YTRbtqmLkOCCzKA/XZRPfggZEaUB8WTI=;
 b=CFaO67a/oLfMJ9QrBD2/c9qmMtGQE92gOx6Sg/pDRR8V5pGLwV+n6yCNQUREkIUQnq
 aD2lM7HlR09CsDUQrFGneEyL3fykL1tXcP3Bvt+Fug02RTmdNHvFObMs28fn4T1W3/50
 ETD2/49vImLah4MFEef5n5jmjemZl/FpMwdRISLwuNdkmU0sGZsduOYxzDJq5SxUDLvb
 siVhB5fzkMIeoRYb5rmBmvwPRSGQTuKtgKZGFKBZCdPeQeV84HkdPOC3gR46b7hVcfUL
 Lj5HIx+aCE9CAGHo67735KlJW1WmuNvPayfvE8abdRhhduqOKp8jOwCHexHbykD+4w13
 bYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707127; x=1761311927;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CVwhx/Y3jd9YTRbtqmLkOCCzKA/XZRPfggZEaUB8WTI=;
 b=GVejCyzVacSmbQrwJw+PxtQZxVV/74YPuYFwQlT+uH+HcULhsG06lpiLvfT+zpUsmj
 3bTS7hZfSFpp+YQhea3qbVp0KBhdt9VF5sxsQfw3qYt3dwRSHDc9vKiBagn4uA1Tm3DL
 HOy13JvYJ5gkUJ9+jsaCWKC8tS5j87T+PKXlbHfFVe6XO1K7xr/SZrPLEiX8VEpGHYMQ
 uOAgOOlPSM7lM0F5q5wM7Mh5KUR9EDwT3TvT8dHSdr78KN3aPvJd2ZtnvCq4Fud4C+dJ
 P7Xn9vLMT7E8tYSa5u/b2yTQe4fl4gdIBReLZ+kqZB04dPDdCw3uBI6a1CwbHTdmv38J
 TVUA==
X-Gm-Message-State: AOJu0YzTSrupyIu9zygsE8wdA21gqgl/LIabW2ZcDc73uoPVWsbhGidS
 OVDi/dK5fPMi8Quf8kIxLr2GTzfeNE+dWmcGMsP9XPK1aqVyBNVl87bqBM0xJOFeC0zNLWfQ6kw
 p+ltcobMSyN+a+i/olDlvcMLuXG429zAP7OR+eYtymg==
X-Gm-Gg: ASbGncs0QlwiDOLjP0SWaQsUrI4c1m+RnzvT83ADqwvdlhXR2VaRYVbDkI6Am2HcZu9
 8R+cP8tICAOfpNKKCQcIb7+QPgzrKHqcLM5z2fdLCgaHyskuvr+LiTwUOtpPj7LHJ0bx3mnQgEk
 F2D/JvokJe2wjWR/dAJuSfiKMQTOwdaMoDhPd/iRSNqCqU4hRzCMI1Vg5+VEoRchfHB2ABHOvo5
 /nRagXYPPMxFbgKQJPpJvt5/xNFe1G6Z/RtXoihm6aZvgW18x/89jcm1gPvY9yjKFvVftmr
X-Google-Smtp-Source: AGHT+IHfEwqoXakU6nTuWLFz3/JWHZ+0hbEjkn+LshmqaNjTUjwQl/cSptR2r+6F0A7aqt3Pjh1Mo/2q9IubPr+AMsM=
X-Received: by 2002:a05:690e:408b:b0:63e:2284:83c6 with SMTP id
 956f58d0204a3-63e22848539mr550523d50.49.1760707126795; Fri, 17 Oct 2025
 06:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-11-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Oct 2025 14:18:35 +0100
X-Gm-Features: AS18NWAE0aEdvQTkLUxgrpK93SLD59xlfe2VkVtmAec-F21-oiILg9wMbVS56XM
Message-ID: <CAFEAcA-AakSNHvFUDWz51h9MvdotBJMc94UdSxCYvaiRWyEHUA@mail.gmail.com>
Subject: Re: [PATCH v2 10/37] target/arm: Handle MO_128 in arm_gdb_get_sysreg
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 14 Oct 2025 at 21:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Handle gdb reads of 128-bit system registers.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

