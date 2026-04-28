Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CEFFF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 06:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHbax-00081r-PO; Tue, 28 Apr 2026 02:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbaI-0007oO-2m
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:06:23 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbaD-0006uU-Ue
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:06:12 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-445795cf6f1so797844f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 23:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777356368; x=1777961168; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+rm9Hoy31MeEj9OFlS9+anNDsh9EkzpabdHA7DEMnxU=;
 b=ov56OGCQ0IcZmGtSK/yXvnKRpgk3dZ5q/Tf0jm/LN5CCUmLGtp6FT61P5SsHJHaeIj
 uup4W2P/qAUyPLbAo0zdhZTSd9jmOK2DYHaO+UuxeB7IxecfVHfkeYMAkqXejS9RDkh5
 PdHtWX1N9j/XmPJmTorafE7yznBTO0Uhk67xV2KqH2N/PAGKA8z+FVeQz6p4piDF9LHY
 2jTgzew1IOCpFVRxEPeeOl5f+6di/KFO0F3Up7Fgz2Gbg9DiO5UQ5YKLsK1nH2P2sEUH
 JwWH+15RCGazdXFaI1vGYYeVNkvn23zuwT2NiZD7RnNOS1qKko4NpfC0bbAVKz0ulzKm
 nDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777356368; x=1777961168;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+rm9Hoy31MeEj9OFlS9+anNDsh9EkzpabdHA7DEMnxU=;
 b=gsjOrJGXBBof712urhuj7sO0882svieywbbu2V3U7HceV2MJd1IwlGOnSKbdUPUeHU
 tl5WWQSTus6XmeBr5/3aAEetTmSN3kkkDGsMDu/AWuyVerN/yaHG0mpTuQ65g17qF1Fk
 DQE8n1Rbs9bM6zlKymcZf/UrvZM4cW+YqfL9JhHkb4oFzB1ogjRbb0wMgeV0l3Jrs20V
 JaVaG4aiJRKdEAvq2+crKZkGNbgHOsAKPIRKdE8GeDH8THNlWVQn3qzFRn7JMHvzxwlf
 V1qYdOaFgh20HnTuLp1ANJI3ukX0FrVAPdzGrEG6XVH6oHzdWCsX5k2G6zDF37dSunjZ
 FU6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9fo3tC60ZGQK0Frsk3ZPjKmWO8rsgXtq4bup5g2qvPhynkwA+Bh74BYliz7epmtISpI2yQ5UH7Zt24@nongnu.org
X-Gm-Message-State: AOJu0Yy5u19eE21xKqwJYFJ9QTTxbyraYFlNGcW684aEaOYApMA2+wCO
 QhcRr/tw3PjpnjC7xvUjWsqeqrIUikzLsojj/Ov46Jwyq0Nkyt6eY8f6X/lrFEV55ec=
X-Gm-Gg: AeBDies0NzGwFrMbejSelJnAtRIKy+pwGXAg4lmvIZdUjWIhKz2+r8VMrylk8x2oRH1
 X6qQ+7GKZQYxig0T25k4GL5MT3N6xBt/bAuiK1HfFke9eQPDqhdgy2PVCuR50Tc2CCp9CRE4lN7
 Z486I5usLF8sk86z9s+FCRZvRI6BRfjkgogynURj6tlJveWBuTeLEuj4Z/9jTZniKpA8WLZ8UAY
 Hi2EEtCC5FulF4J1wUW/dmA3ClWC+wQmG2p8YchuLaXOOTwBZiWr5oandy+zFsjvMlLxDyk0V1Z
 vMbeRqd7klxh5JPKaumLAtR6bxN9Nij9p9RXDj71i++9EVla/Iooc3jv4+NodpxnJ307UIGD755
 W3akzDE80u07H5TA17+8yuqEtJ13A8esN5BTWWJsmnPo7p5QbgmA0RC5BBGAGwk3vcHk9VfoYTu
 7ihs4DMq9q9MWKlueHc5axzNHvFii9zvLCv6HbPAdzoQ15fitIiLKjqMDdTNw9OUMHLLfixFhVt
 yRt
X-Received: by 2002:a05:6000:18a4:b0:43d:7e11:1b72 with SMTP id
 ffacd0b85a97d-44648f28e43mr2973123f8f.9.1777356368194; 
 Mon, 27 Apr 2026 23:06:08 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463cb59acfsm4825274f8f.2.2026.04.27.23.06.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 23:06:07 -0700 (PDT)
Message-ID: <cd599efa-18ee-4cd6-84c8-9887aec6eaab@linaro.org>
Date: Tue, 28 Apr 2026 08:06:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 44/84] fpu: Inline floatx80_unpack_raw into only caller
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-45-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-45-richard.henderson@linaro.org>
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

On 26/4/26 15:39, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

