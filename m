Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774A4D3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 21:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZyHg-0000J3-Gj; Sun, 28 Dec 2025 16:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZyHc-0000EV-Sh
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 16:26:38 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZyHb-0005sX-Cy
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 16:26:36 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso69597745e9.3
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 13:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766957193; x=1767561993; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yKI+C4ldvsZNoD/dy3z0rvdKNo8G0h0NOyVUYNo74uA=;
 b=NzEMdc3gKqVKL/6O/+20njEpSa68n44wZikN28oLPPeTjFp+Zp1RgGiycqimWcSGc2
 7+y8XFCCH0E91gaDIrBCFKhPGMyiTPhltXKRKUFsQSfQCItNtzf5SniHkVR2kXMmlEEc
 ynVXnoE872q7js/DhJ7303MnBEOonM+Jd3LRXGc59oOr3DNrrHJfuHoLCGXqKRtTQxiV
 vxJbWCOLdeVyV2imeGGcPLIa9lOHLkB4Xe3Ti0hGjaFL1QLHW9gsmv7KjUDwhXFlkErJ
 Labq3jpizc8O9FWdvvoM6tHev5BwuSKBYrANY7sfQl8f4qPx1k78bNqauZ6kRBcVJuu+
 T/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766957193; x=1767561993;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yKI+C4ldvsZNoD/dy3z0rvdKNo8G0h0NOyVUYNo74uA=;
 b=JoIigHpVt2o50/9Y6QkF/dNhxOuE63hc0X9peb2o9xnuTb4l86W3OF4pw0cRqdVXiL
 I3R/0MfofZPlPmnY7s646woSpBc8qeJZagAxn9UPxMuEidzCiDM5kEepVdgtQBC/ozBZ
 IiCkryqMei+d3xHZfKSq8cNm2lHaflRq1iI9Cte2eWp9KsgmkrUiUS1ol109MSzubsAI
 Put9RrgxwNhdi4HnYcGEXkq0fHi6UWUE0lL5noer7E2v5MjAfbeDBjcZE4BXO5iOTEYL
 GFadmmfiGVvF/zXZEt3lc1V1U3gXpeXNi6nQbkMp3bS7a6shuC1vGC724eLocRnOjfdo
 A8hg==
X-Gm-Message-State: AOJu0Ywd1ebb81H2YLPQb/vSu1hPdcot50eys9HCMg97PCRZfXLGVLSV
 V8Z83EJw7KPAE543yumg/PvniwMI3sAm/78AAorM78ALUE+MaqbIX7pp8B1e8t8uvCI=
X-Gm-Gg: AY/fxX6t1Cb/x/dq08/FHsZTJ0w+8hyEhT1WZPPQM4JnI7LeJBs1qPUmT6QTNfhMZQF
 Af9LIccxFCW59VB0UXqB9Qxrtw7/irwAG9vFhTUivF4Q4RpDiWuzmikw7MWkcZypvIn1onQYqE6
 R+hCVcGDdCWbtgPchfjm/xRjG92PykhVJ3fJq5NjUbmveCNPu5uVZfaOtOuPb7IE03hdCYsoPDV
 MY84bBD7x1lnSL/5GSGf9kVBuVBKZvXBO/j3JcVsyQcYA77cdC1/2OH3Oo3A0lO5IkDqOVpTqqu
 bSRWSf/BcE0Yx0+pTmukSis0ATldwHz9QOeugWmds8Hh0vwypAR7X5dZXHEPMJsM/7snvKuBrMK
 7vw3uLSL+1m3WT7tltzqDSVMTr+nJiHBZWPdYAXUs+cb+fC+jeDp1fadoYxIdOrk75qqYlULRgT
 OUGXE7yWK9jpIE04PaJudw0JSosNU2tp/ipwXuxqCD/cu9/z8dZ/gFWCmmbzWB9zgjJ2uKLsET
X-Google-Smtp-Source: AGHT+IFGlP5JkuA7fc7oS18pZTqpw6ulZX5HOXTX52A+LzflvMNvoh7xDwa9o0k6HRqmqk3W77W5rg==
X-Received: by 2002:a05:600c:4f94:b0:477:c71:1fc1 with SMTP id
 5b1f17b1804b1-47d19595e3dmr323748255e9.19.1766957193287; 
 Sun, 28 Dec 2025 13:26:33 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be27c2260sm546863665e9.15.2025.12.28.13.26.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 13:26:32 -0800 (PST)
Message-ID: <5795688b-5030-4446-b839-a257b74d1f63@linaro.org>
Date: Sun, 28 Dec 2025 22:26:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] system/memory: Remove ldn_he_p() and stn_he_p()
 helpers
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20251228161837.12413-1-philmd@linaro.org>
 <20251228161837.12413-2-philmd@linaro.org>
 <CABgObfYx8KsRB+6gdWx_U=pJgax8DE6wJMpXSstLDpLpsguu9A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfYx8KsRB+6gdWx_U=pJgax8DE6wJMpXSstLDpLpsguu9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 28/12/25 21:29, Paolo Bonzini wrote:
> 
> 
> Il dom 28 dic 2025, 17:18 Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> ha scritto:
> 
>     ldn_he_p() and stn_he_p() helpers expand to a plain
>     memcpy(), but in a convoluted way. We are not using
>     them, just remove so we are not tempted to start to.
> 
> 
> I am confused, doesn't ati_2d.c use them? And in the future they could 
> also be used by ram_device_ops etc.

Yeah sorry, this patch is crap, I should better get some rest.

