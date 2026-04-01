Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D36D35164
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7s3A-0004hi-TR; Wed, 01 Apr 2026 05:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7s38-0004hL-8g
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:39:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7s36-0007NY-P4
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:39:46 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-486ff3a0fc1so60909275e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775036383; x=1775641183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+9es278Om8ilMAsrzeE0bK2aBE8tizUX2YgUgtvOVck=;
 b=dY2v07hj0+ax7R1/UqfWcMtD51zj3VUv+rrOfRcLN5OUNv3MRPfzHZzyAkDoSFQlf1
 mfBC8xcSAiRJ130BhYCauxEro/s49E+/HZzw0dPNa0015jE0kwTWK5EhDSBBRVv9Hkv5
 SxqD2NqahZ72J2O+jDqoQnAONUqz0zxRo5nxiJ7CRHjazzaSSyykYnzWNvuitbxJXm/H
 jZro/TTxAnL68J6cB8H5Ei9sCrcCLH6VhQ6QOtFuFFxrmuoOISHzwV6kF3r/Lr9cwjkB
 gIAz2p65QLT19k9IvP5C/TRRj/E6+ZLAj5LsgIac4EPvlfGfZE+1ap0E/Kg5kDucaKVN
 zcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775036383; x=1775641183;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+9es278Om8ilMAsrzeE0bK2aBE8tizUX2YgUgtvOVck=;
 b=lUumi0YaV4CVrtRwmMR+1CueYSN9DuUVRRctFRz+J5mlxqdCvYFeqDThWRYbMo8shr
 EmyWJHHIA6vjb2ygGAZ2p50EYBWPZpr13Iq0zPU/HXtLIBoUDr1aOwfE8sGKwm1ceqg1
 jLvyGHdfPRfPE2h3Jq0fdoiRewV27q60S180+KYgkWiqRIgDU2KahIlt6+HpUccpC1f+
 835V/X46YT4mG1Eb8nCixNS0IGyd88mBWh4ad64qwvg7kCGx9gADaXP1vDr2+E5tsOg6
 5ysvchKJwcCIuf5IZ49mSo9zuGwpjRk3jThz7PGcyZwjRou9e5NVebKM/nviWP4KK9x+
 rLiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBANxNDqAOfFsuXQFs3PrqNdKbBb9/dCdfZ9z0HPL/QuBK+UQMnu8851eVOMqL2IN6iGmRYuIT9rzV@nongnu.org
X-Gm-Message-State: AOJu0Yx9CtBONOW5ycDVakpdZ40ZFrTXFky+TVwnnDK1wOs/WZTZUBBw
 8q8pL/FVzcnMa4BGZNb2FXTQY5jz52mXbkBHYAzJfQtWoHQ0t7bNEYhx2qQFb9NgQffwlktv4d+
 uCFmF9f0=
X-Gm-Gg: ATEYQzxca56mDjRLRJISghMWh87jBQXqrG/8rxiYfzbgvebHwSCO3LqAK5eIzY9Z6Xo
 QxjKzfTQ1OLEktyFBpw9F6cc6f7sXZ7iHOM9rL/mNu5e5qVwGrAKoV3+a4MXAkms009sRDYeLg/
 CnrGEK+bzL52AFYh9ZlRqV2Fc6+wgLFWvzpJcYbs7gnFoGgh6uq961Y0O+RxZ5n7/qUCk6YCiBD
 Vc5DfEPAzP1BfyE6qdHK6peORdxLvI7moasTB7OW4ksGrwogMBucvDF/KoygtViyH1+hdekQNaZ
 1nghksWdTD8LmdKVyeZHju4620QlCF9v6OiNKuW8NMuyOYhPa+ghKbwFG3OxmI1eaDpEYIS3Eag
 y0T0jMpf7u5Hu5sjbl+w3ESLHtO20Ogu0tVV/PjLk3gVvjLbg9KYuaZKmU1Z3tPZ42FEkwGeGEj
 wOzcGkpBJ8aWSE7w7H9/r7a9/BsMarHTsIygFUYDou0SO9h3Bspzx8XyzNAlPFx0HlRXs7eMs97
 M5f
X-Received: by 2002:a05:600c:890c:b0:486:fc5f:1ab9 with SMTP id
 5b1f17b1804b1-4888358cb46mr34547885e9.14.1775036383208; 
 Wed, 01 Apr 2026 02:39:43 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887aacb99csm41348995e9.1.2026.04.01.02.39.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:39:37 -0700 (PDT)
Message-ID: <6111e21c-0361-4be5-8b7a-ac939d1795fc@linaro.org>
Date: Wed, 1 Apr 2026 11:39:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 55/60] ui/console: move console_handle_touch_event() to
 input
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-55-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-55-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 17/3/26 09:51, Marc-André Lureau wrote:
> The function uses input.c functions to provide a simpler abstraction for
> touch events. Let's move it from the already overloaded console.c, and
> to avoid some unnecessary dependency from console.c on input.c.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/console.h | 14 -----------
>   include/ui/input.h   | 15 ++++++++++++
>   ui/console.c         | 65 ----------------------------------------------------
>   ui/dbus-console.c    |  6 ++---
>   ui/gtk.c             |  8 +++----
>   ui/input.c           | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   6 files changed, 87 insertions(+), 86 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

