Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8B2CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 14:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBZRS-0000fS-I3; Wed, 22 Oct 2025 10:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBZRR-0000f1-8n
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:03:53 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBZRO-0001pF-Dq
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:03:52 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3f99ac9acc4so2366156f8f.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761141828; x=1761746628; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CgUcTvhc/Itn5uetP9wr2VdFL3LDyvl8uYUjR39f4V0=;
 b=a8Y4QUY8zkTCcQy93myHyD/pgZ2uP/WWifseGkSe+Km6MuKEE5Trtfu/eqOpQPPK4r
 ptt+PueaOg9YEjtzZQ5SN26wnF0MGIjPUzWnbfzHSGPipvJBwOiHaD3mp3R7Uh1gyruk
 M6SXoyyJRavCoMwh0i3EbGS0OVajpjIcvQilfuod+UxRxREnkEagsMqv1/83uSTwiwWi
 hbQIlSwoedYyi7myfjn5Mo5fsUFgsT8RGC5xeS8DP+PDqE2S7pGBO5hyLRQEPKi/Km3G
 vmFLNzvEGgdNIHJ0AGOirchNzphDvdXMeIy4EXJBrDy63UIO8P7/GpEfsYUE1wyB3CTM
 0ZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761141828; x=1761746628;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CgUcTvhc/Itn5uetP9wr2VdFL3LDyvl8uYUjR39f4V0=;
 b=fxiEyXOWB5nrDeSI3CYF66EYbTGrZZ7lAEUKOLpnENbyGtm03XK8lHqKM0+/QYyzWl
 J6mDEteFY6jekXgvHumraXBj/HGA+D5Uc0xbA6GJXvemd2BX6Doi08CJI0zu4BRw2f/u
 nS8OmKn1PrMOCS7/N1dLCv4wxhxoTOY8H0lw+SKkj54mC83COX49rzj1fyakwyU7332b
 V9cyOzacgfwgymYpvLjSnb8OYk+/4ggUJ+3riyP6aVPOFCuZrh7L77IdGQTAmo7WPpTN
 G8vKpoJ/tLVz6l2NVATwJGRx/szPEja93+1wKp3om/IJpqjrROwtWdq+Wrnc2g689W/b
 oJ+A==
X-Gm-Message-State: AOJu0YxP9GRXc91osw5z+wTh1qlMMy8WYKrJfC+/iKOHkvXiCyUkwYxR
 cvbEd43VypOdsTSmaA5o7qdmuflv+k9mo64em+SkN3W8EijU1JXrnZL/vxuHdfmJJ4s=
X-Gm-Gg: ASbGncsyt73EIYeKYl4/qjHxmdOtmQVaO7s/rf/Cs8tml49JSYOvSzUP8SzHVwy+XA1
 7+kYmtgg8beCqVbLVz9dPleefIltiykNU8Rr3IRaroN/13DXV1iXHUqlQzWQX3wZ/OZzGnccVXw
 M8h5Npr13vAeWINWS7M1wC7w3lWf+DNmeu5bTJ+jh3wum4VRiJBBtGEy3s2tsigjg5qtHIMubDS
 7xMGZiAnkwvR6We+OLX97L6tzG90Dy3rysA9fMsQu772Rsvi2mNj9rUvJ5wyrSdLHsO+wgDGFlj
 UHW1XdhtACKy1HaOkkhjsZuaZBzcT0FuFasDk/LWwXF5vc8kEr2iTrV5VGQla/TprarhB7UowjU
 8wgWVEELqYuElror2RQQnEtLxnq/xn85wzaYgIdNto7/rXNoH5HD9XIpDNt623nx+7eUtAhlck/
 REu4P/LvCd6rfJd2AXBLdOBcUnWTbTQ8tGxyPrfV6FGBU=
X-Google-Smtp-Source: AGHT+IGyiU7BD1TK4Bc5fbUAg5DELawcYvAkctr4P23WdzDZ/hl6e/1+LeaMXZ6IJwRwSsPijbWCvw==
X-Received: by 2002:a05:6000:490c:b0:427:632:cd3f with SMTP id
 ffacd0b85a97d-4270632cd6amr14476322f8f.28.1761141827917; 
 Wed, 22 Oct 2025 07:03:47 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3dabsm26402898f8f.16.2025.10.22.07.03.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 07:03:47 -0700 (PDT)
Message-ID: <a244a654-7bd8-46cf-bc55-87ab5287bda5@linaro.org>
Date: Wed, 22 Oct 2025 16:03:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/19] single-binary: Make hw/arm/ common
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Anton Johansson
 <anjo@rev.ng>, Luc Michel <luc.michel@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20251021205741.57109-1-philmd@linaro.org>
 <CAFEAcA8A5xa0nJUczM_BDCvVu+sP-tdbt_CxDGos6hKW27qEZA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8A5xa0nJUczM_BDCvVu+sP-tdbt_CxDGos6hKW27qEZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22/10/25 13:50, Peter Maydell wrote:
> On Tue, 21 Oct 2025 at 21:57, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Series fully reviewed.
>>
>> Since v6:
>> - Addressed Jan comment
>> - Removed aspeed/raspi meson patches
> 
> I'm assuming you'll take this via your own tree like the
> other single-binary stuff -- let me know if you want me
> to take it into target-arm instead.

Since most files are hw/arm/ related, I tried to get it fully reviewed
before the last Tuesday before soft freeze so you could queue it;
however it is based on my hw-misc-20251021 pull request, which isn't
yet merged. I'm happy to merge myself, but would you mind to provide
your Acked-by tag?

Thanks,

Phil.

