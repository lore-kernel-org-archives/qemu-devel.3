Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F3D107639C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 19:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w81Xx-0003wG-RH; Wed, 01 Apr 2026 15:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w81Xu-0003pH-Me
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:48:11 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w81Xt-0006SQ-7e
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:48:10 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6500eae6d2fso177172d50.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 12:48:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775072888; cv=none;
 d=google.com; s=arc-20240605;
 b=BXJrqFNAqTbl+bHt3iLMVg/E9FdVo6UZ0DnT4DBw4GLUP3CMjrKBP13mwTHzmsaSjl
 Cg+HzJ0jzQSFVX511F/gOoOSyQZMbO6IajIv7Rs5MQlyYY8iqN1lyFbuZitvvYXx3OQA
 L0gALS3VnSwgHCPdCEzq5evsedA4Gzuy6MPy5yu9ZQPv797K85QlaIRlpiob6KQJtdZp
 qw3P9+6Z/Wahv+IVNHJVRVPZ4xChZgwMXwsOnNt5fu8NSs1oThCfmVJ5l8mL1MRrabLO
 kaJmbHRSUWFMlKSTryUIMz8KtskKtnOy2jeP2x/tp9zqRXcGc6JHSrGgaFHAt9vEiwLQ
 MVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uDP+z2xWv4sHyRMlwYY1B8MnRW0Wnoh0PH+tPHWNZWo=;
 fh=rvgLzTEGSQBPHYqEQQgFJrKgDd9vDNByUmE8aN20vBo=;
 b=BxXmYNFxMiE+YdQVNu8NW1n8NuLstT5mp/ZKM0Kimjv7hsv9JfLa2qnM/z8Lo8nlbL
 s0KTJSIhZ9hzSn1XM/6iGjDdzJYb1L/0aVkIgCMvTsLFRX1wtYy2apWHfdxSvEjZLv/E
 afanT2ykljdRjJmPgx8xEIVyvHIKw6F5fTaAiyrmsNMZ5YOorzlEQuC8+fgkTo1sID0C
 ouwGIJN9UuMp4h8PYayAYZrITh0zv7Bc71cGNVaYXgzJ9hcnOlK+YE7C5yV9UjsZctld
 QwCmDbKBl0GQORpBWW5qtxqSEfU47AQJ5ExNDEEvr1Gowl/rCSiyT2kJU1Qd9e9qigId
 jMeQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775072888; x=1775677688; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uDP+z2xWv4sHyRMlwYY1B8MnRW0Wnoh0PH+tPHWNZWo=;
 b=Lbi7iCpHmTyAthv4jS2vh3dXWr+lO5z9sR/NTH3kDO6NI7z4jQA9OR87QoCtYSRlxn
 cyfuoc3hrT8qPQnpJTbOgqjUPvr1kDn0NihYASmG15B8kroAH2KYixAm2/U1kM8fy/EZ
 PozDpReZFPElA2hbA8Xk6U14CtyudF446BffrRmW9PiWm9PxZpbekyga8lyUa7ut/59r
 14+8EF4u6GO5/AatGJxeeiUV90STyMWpsJO/Dx39aaB4CIngjWJB6MzBXsqGLm1diMMW
 J6Vk+RQF+Bb4wxnZXJSCRYKVCDcHB6k5WyY+pM45vd1Y2PF9JFqLDo75Y7KMCUo6gQs4
 gCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775072888; x=1775677688;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDP+z2xWv4sHyRMlwYY1B8MnRW0Wnoh0PH+tPHWNZWo=;
 b=oz1WqmzHhx4+WVE3qXCoPu8/fX15hTMCs4dZFu7cnJ08jiYQJnGlt/modmJofZt8Px
 mSyWc0iRsOmEWF2LxBKucYzYhbkoRK6iJO/u1MSe6bL8VojKyAPkxYDGbEegP6VliNHr
 +u5f8olvj1VKsrxKoh0CObL+8wnXDcw7UL2MFeahMQNkPQTy2XOMyGVQW7DNqBpyOKKN
 mU6RDIZXTYK+0ItmaBt00hi6WCvlAPh+nC2qdOoXqkB2Gpnm486Mftndc7uV8m9grpzp
 6tEJyD4giFpe3WYss3UkT96qW4rGpqmBlbRz4KhAtjL9HT5HHeyR1RYqYwHPxnKeY8Hm
 gsdg==
X-Gm-Message-State: AOJu0Yw2Mo7DuVvqcItR/xinCOukuI3RJs1u8iivMfcqtiy53XD482pj
 iRJh5kaKhgD/yNgNG/bqjWm3inx0++ySKacQjzGQncgqcSl777pTdx7Vc0UNt06+RUMfV9i6+DP
 Kcl9f0nzxx3flkJiISttQou0e7ctLLah8eeWtzZRxSA==
X-Gm-Gg: ATEYQzwj6RqjtSl0ZIREdVZzO/Y5PWVoZAsE5itMexhCBX5LMcNp4ivcxcNZHmBhP98
 es91x3NFJpWE1E95JP7VIiDDmKrWa7j/h2cGlrVVNSyZf8boGAmB9QFkXUwRCQy6/Ac5wNJlGDh
 Z3z0pXGs5o6oVLCzgmroXq1YjPRZyRDUod0dIfa3Wm81hM4mJA3pqPVsP2SDlKenaUCMK5XP5Pr
 9/JLq+iVm2ZMykOitaHb8At6QTIcJuGOyKQ47lHMOGeYHaYCNDHFnOaFSbjSrfyrcFbZwZb7mgx
 EtFF/QWPUJ1iKDZubDkTU2/OVgCXtYtTI4lzjFEI7O44GEFyhsJU8z/GEfY5sMxsLDs=
X-Received: by 2002:a53:8349:0:b0:64e:e90c:567f with SMTP id
 956f58d0204a3-6502fe846e2mr3525435d50.65.1775072887808; Wed, 01 Apr 2026
 12:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260401095024.1562621-1-kraxel@redhat.com>
In-Reply-To: <20260401095024.1562621-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Apr 2026 20:47:55 +0100
X-Gm-Features: AQROBzC_JkfoIrkWgWi22pHAbEmuq9iE3Ae9DYOVkj28o_ldKhyoJag0iVLC-o4
Message-ID: <CAFEAcA-oAeria=10qvywjsXum4AsKxG1OjbA8gat0HVCVW7QkQ@mail.gmail.com>
Subject: Re: [PULL 0/3] Firmware 20260401 for 11.0 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Wed, 1 Apr 2026 at 10:50, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit dd3ee9c63d96b223c8d41bf5d65392eb898be626:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-03-30 13:54:56 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/kraxel/qemu.git tags/firmware-20260401-for-11.0-pull-request
>
> for you to fetch changes up to 9b4edc3ecacf2f6ef3f2e7e3d423dfe9e67a781a:
>
>   igvm: fix parent object type in IgvmCfg struct (2026-03-31 08:53:47 +0200)
>
> ----------------------------------------------------------------
> igvm bugfixes
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

