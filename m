Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB52DCA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmcW-0007Ph-Mj; Wed, 03 Sep 2025 08:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmcT-0007Or-LQ
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:29:47 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmcR-0001kQ-HS
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:29:45 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-61a8c134533so11731031a12.3
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 05:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756902580; x=1757507380; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ydnZO+VM3S3kIJv+S6YVLdhWmwHrGhN7NRWu1XKBpLk=;
 b=rPUzAsG48Df5YWvDZUQ71JcjFMcOhUB3mMc5uQELX7LRkVlfu7Dq5LzpNCug1eydOE
 iGKKyzjtnX0Hsm/N8bRTAQtdSEcqqdGs2/LlfhgMOt3lWEq2VUe8jUQg+7RuYEkw94Ym
 4D55ignPiUVz4PAL0GsKKaMWeYd8EB1QFoaXGC1zrrfO27X4KiJK/EesFA95AF0Can3z
 DIydnaqEBfmLvjwVWsZFHyb2/3G/8ETXprs8ZytVWqrPqPIZLDRN2xOXjNPd1Yo8d3Iz
 lrh6GQDuM5tOkNf9SW5UqmS/om6hno0k3EBpj7lMa9pPDu0a3o+6TezAvTTXy1eJN4wy
 3rVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756902580; x=1757507380;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ydnZO+VM3S3kIJv+S6YVLdhWmwHrGhN7NRWu1XKBpLk=;
 b=AnRBIoRrWkquIfgrdRay+gQdtKeWMolA1hjgMe/NNlky0gwP2bPi1TzEZGsMcaxMVg
 XIFn6RZwpjMYE3x6uenZdjDW34Z8NdHZB6jnanwtXBYQFzf4cFviG8HItaFCaKnUcKsk
 9PEnO/HcZ55mm1Fl8qdxRksfzfx0e7TpzeFsCmBg4U1jTLM0rb/SoVmY+3ZNOIZe8Xzz
 N0S4DGvdRFwvFA/dRk5NuJUNOLFCwt2GUnk92IjPUpbnM35VVkfL+BJGnmaCw2uYWyue
 7afjQYtxuS/kqljS3fha9nX0teZjM18BUYfy40bbdmOGbN7mVNkaynOF4WsGoydbLZit
 TJcQ==
X-Gm-Message-State: AOJu0YwmhDztD33p2v+eB57XANVH1VRZw/C88R3d+Gfy20uiZkgznEfz
 gSrBfFRz0Pao/FYX5FYhqaOuKGuTLVaDwU99TkI+k+aYD/MHRRPR8moMSCkU75ECCBSj4EgJ2IK
 OrL08vw8=
X-Gm-Gg: ASbGncsvevzdNdNjlHhh4MtzssRDhJNNBEAYLzL+FmbLC+Fv79advU0xrlNFUYK2f2/
 a+I+UWPE3EJnKDdswg1lYeiPOg+Pab7lgrq8lF9sL6hCkKAQ5OpsSs4l2wA5u4In8Q6yzw/D+tH
 O6wJjWYVwF102AdFnFUxiowZCKVEuw+ttCNZuPp73j+zgiW1afLwkNGGOQpcoFCIKKw8SbI/yF8
 Aezc+iLfUOFzuidINhEIpRrjDVBIitO8FoCkhGszxypDPVJXJbrvbaTAgOA7WH3ZJIgz3Bd65kN
 +pzrkIGq6LC3QHZGFxKmE3I9FjIuiBoJPoNxq7mVsYzLgOlicWRdJlGqHHeC38VylWUmes913dd
 pnu+3jE2QYCQI2Cb8+w60amdD3HHXCeYaS6343w7usOsfjYrnJ5NPD7EeX48Y4BtcAoezz94=
X-Google-Smtp-Source: AGHT+IHOpBELOIJRXqIyjGwQFiaUuW14fsZW9zzB0QuoHZIxrvW3UnwPloW285Y7xPB4tg5T0EI4qQ==
X-Received: by 2002:a05:6402:44c2:b0:61c:c034:ba0 with SMTP id
 4fb4d7f45d1cf-61d26fe5e5fmr12664863a12.26.1756902580536; 
 Wed, 03 Sep 2025 05:29:40 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc1c7ed1sm12140828a12.1.2025.09.03.05.29.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 05:29:39 -0700 (PDT)
Message-ID: <d51e36ca-5634-4b81-b537-297d728a3eb7@linaro.org>
Date: Wed, 3 Sep 2025 14:29:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] Trivial patches for 2025-09-03
To: qemu-devel@nongnu.org
References: <20250903075952.481585-1-mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903075952.481585-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x530.google.com
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

On 9/3/25 09:59, Michael Tokarev wrote:
> The following changes since commit 8415b0619f65bff12f10c774659df92d3f61daca:
> 
>    Merge tag 'qga-pull-2025-08-29-v2' ofhttps://github.com/kostyanf14/qemu into staging (2025-09-02 12:07:05 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches
> 
> for you to fetch changes up to 25fef09ce17ac1ae22638a0b57d97c2bd5cd7d83:
> 
>    docs: fix typo in xive doc (2025-09-03 10:57:50 +0300)
> 
> ----------------------------------------------------------------
> trivial patches for 2025-09-03
> 
> A few assorted fixes.
> Including not-so-trivial (but simple) fix for curl (https)
> block protocol with recent curl versions.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

