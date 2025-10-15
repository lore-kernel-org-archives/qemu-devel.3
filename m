Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9D6CCD194
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 17:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95AK-0002tT-Sk; Wed, 15 Oct 2025 13:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95AJ-0002tL-M3
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:19:55 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95AD-00062m-4x
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:19:55 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e2e6a708fso42884665e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 10:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760548781; x=1761153581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BQCmOrrumX80gUCMInb8wwaOxkJtjhgXyhfk3xnzr7A=;
 b=vnwDEs51lI0coKfZXAVJVZtccK8QWRgpKk+MVz/0s/AJW50sM9rcVMgPPSTjmyq22l
 8EVfZnGvGaUn6C6Rnhj2+DnZQsBCUwpl3Hua0tiT3mxduwifABFpvNdRzdQnt5VaCwoC
 kexHOSUXoJPA5mlKj5Ruw74nlGVpgXIhKA8EUYKT1VGYEVSRQIlI+hcomzBXpJGn+BVr
 XTdlPu/PBoZk6pJhP90Pt0zDanaWNSuzL4lbK2VKUIpTVru6Du/FzsgnShHAR5NFj2S/
 J+CsIh1NorFDNFHSOi9LjjWkPKF3T6wXSVB8SB5wC3zUPSvDd/O4/S8y34jYjVU7wad2
 rg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760548781; x=1761153581;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BQCmOrrumX80gUCMInb8wwaOxkJtjhgXyhfk3xnzr7A=;
 b=CbkGU6bniZEz53HEOBAm6yGkDxc63/oarZLAoKTmyzYWQYGj4URZaDlFy57Hk74c8J
 fwERGdWUSl7zG3Q1MLuScK3sbzRCMG9gb+Bjr8aqQ3Zmw+6n9asZCrokFGiFfUJ4HfJn
 EoWHbC4h6jPO2ByU5hXo9xUvGLeKGR6v1ae26XUYrGKPkvjYPXP14k4Wj0zZD3jqnv6c
 SoT0AK+MyX2PG6jyITeEQjTJPqi83m5C2Byvd2iDBGrPLazAZhMfC98ki86saw5NLDdO
 o7TRgrYh/rUCzUGVd8IIE7nhJG4kqwmsPv8KbU3hubK4Ld6QjG3u2j07TkD5y60Kvjdg
 sm4w==
X-Gm-Message-State: AOJu0YyjjWq3MEzOpeKAdqyhXKWSjw+aio2gOKTtvJj4lEm1alX0ChwL
 7sIW8ZLJdmfNj5w/xMQokvLfWlXre7ZQGYZ9dXzBLUN5NeBn1TrHBCTOYJK/ud6q3zhHXl+JF7x
 oFYR85yUCwg==
X-Gm-Gg: ASbGncuNztM4IdNJJYjQSI24LNr0SpxfbaxdpG9YGP3tQs0VWs6q2DMDDC2WsuMvM8/
 8AA/Rl1tj6e/j73LaQa8Tp4AR0QIG1ABODmRYo/JkzwPNKW8CtDa0fSGjeDIMXcr/GC2FueJA0S
 GoUk+sreanIGjmicRRV6bFLJq3LXH9+czyT2oLGuf56IRXGY1LhTT0HdcyfpYoggSGJ9/a8fAVk
 QAp+HPW9Nz4ZWrTAjsPAW6HpESVt0xltw+iz8PzbeAbvGUjQ/4sJqED9X6Zn+FWk6pyiDhpFz6/
 DkVN1dguS9Ftg/A4USbFZmpTWq7mPZycbvfEiRoLZEJJ3yXqAokQ5aKBJNolxwKwEwwX/446ihV
 2DJA6mOu0qB1DIVkLtphFck2pPPZ3Z8Zz3Dx7N82Z+0pXVRM8ji3gPfG5uNRBHVNJp3j0Tfd16v
 oJM8knyFFTmJ6Y
X-Google-Smtp-Source: AGHT+IESfxmiS5e2cXMAlRPLPK3XA1HToDddkk6EDVYB1ZoSzuHoKYsUNNxkQ82IkGxYvB8tfpuHww==
X-Received: by 2002:a05:600c:8206:b0:46e:19f8:88d3 with SMTP id
 5b1f17b1804b1-46fa9af313bmr207681755e9.22.1760548781366; 
 Wed, 15 Oct 2025 10:19:41 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47101c03644sm44367235e9.8.2025.10.15.10.19.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 10:19:40 -0700 (PDT)
Message-ID: <4966a261-0daf-461c-b814-a6792281e911@linaro.org>
Date: Wed, 15 Oct 2025 19:19:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] target/rx: Remove target_ulong and MO_TE uses
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251009151607.26278-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251009151607.26278-1-philmd@linaro.org>
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

On 9/10/25 17:15, Philippe Mathieu-Daudé wrote:
> The RX target is 32-bit / little endian only.
> Remove an invalid target_ulong use, then replace MO_TE -> MO_LE.
> 
> Philippe Mathieu-Daudé (8):
>    target/rx: Replace target_ulong -> vaddr for translator API uses
>    target/rx: Use MemOp type in gen_ld[u]() and gen_st()
>    target/rx: Propagate DisasContext to generated helpers
>    target/rx: Propagate DisasContext to push() / pop()
>    target/rx: Propagate DisasContext to gen_ld[u]() and gen_st()
>    target/rx: Factor mo_endian() helper out
>    target/rx: Replace MO_TE -> MO_LE
>    target/rx: Expand TCG register definitions for 32-bit target

Series queued, thanks.

