Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362EBE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 07:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW9X9-00079O-2H; Fri, 10 Jan 2025 02:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW9X7-000797-Kb
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 02:34:17 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW9X6-0002m4-4g
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 02:34:17 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361c705434so12875855e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 23:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736494454; x=1737099254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ovwsa803NY3IG6qXuSzCCU+qH3Cv826tbT3cvvpISIc=;
 b=jpwpqwBgI123I8Hd7ggL2mIsl9KHtIgr+0XKso66jFNH0a5hk3hU5i3aw5o8hUQA7d
 vXodci2iShQkLxs/TYb52G4ApqV2q2inA36tfVJnlcBAJClOnEp6VWhxxuhefRCf+Cup
 jASmPitQ/FnAWLYZ9Kdn6U9KyfHX3z378NFjnH3igpJ7oLervv3+5kt5KGvBDp/U+9p+
 Ke6mm/PViqsg3VKfy1EdV9OnbGmF3+A/GE9iPMwlQhTvH4hHXWJ4POPLL1UYqI5U9Pee
 V2BSEX5BPfIrqhdoH0h/qwREwHyCCYGM9wzRZU9zPGicJr+Ma+TKJvk2HATRbmKWb44H
 i+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736494454; x=1737099254;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ovwsa803NY3IG6qXuSzCCU+qH3Cv826tbT3cvvpISIc=;
 b=OSkp5O7GGVeLqymbraTkdKXJAF9ZaLr7WNyyKeMbCeNc3i/xOORjj08mMCvd+NbEEq
 QnqQBXtZxTBXLReyfpAQCF7xO3BtHhyG4c3BT3EuqORoyxbDzkbd2hozDQ6aVxJWc6Jk
 fr8hs9ZfYnoF5Nix6buNZoJpqWxYTDCXrGCdLiNEnvZ258L3hRdFx9371pjlTvbsW0EA
 8T0fh7hQv51XDjRcNtkMVjWGMzwZ8ytUhx+5Z2eXKGCH3wK/A0J8xt4U7ntQ/qeqo2ns
 I7UQbv/Ym10nWO55eRWrbum8KCLgbslizQrt2lK5cYlRZt41ErNo90R6RIZAYQRbnlyd
 5yFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ88v78LSkCsI0EUVzPAsalqXdXsRCTVXLyVJt1yDxq67rqNOtD668SLhXutfD0X/pf2hylLN/QxRj@nongnu.org
X-Gm-Message-State: AOJu0YwziNwF1i8EzY5B13AIBptwG8CywM6vInx/fE2nXWD9U+V9U7On
 OAAeP4hnWGG26lQpEk5QV83lhaM1PPwsHAocl3he05bydYpNoltgTAXgS3XMvY0=
X-Gm-Gg: ASbGncupt11p/DQ4pF8ctZSGqMXpLjJX40urOt5i6LNY9ri2zhon3PYu1Yc0F7ki2vv
 g1XJGWd4w+L9dZOW1FtAll0FcrYPaEdQ8bqY/45+X7a1pDvc/evo2iG2Fu1pNrFQ2/JuB5BD40w
 6SnOZaeg0zCVf+FMeZIsQVq+l4uPJMkpbi4wISSjqjNSxRYiQ0DUY8y3DXV5SnhiWT4XC43mSkM
 CQreim/GNayiQoFJ2F8ep9puyJf5iHV0RJ28AXUUDc5P8dJ2LQm2qbdf+mfyxltaDvpO8po4LIq
 4lRV3Stqi/6LHUJYW16Pbett+DY=
X-Google-Smtp-Source: AGHT+IFAj8XrWn42jJ50FUs9ks1fCMXa40pXYnAIqza4fAh99A3sh43H+CpNfiO8ThzVRzbmpA3fRg==
X-Received: by 2002:a05:600c:3114:b0:434:f609:1af7 with SMTP id
 5b1f17b1804b1-436e2677361mr85223835e9.4.1736494454250; 
 Thu, 09 Jan 2025 23:34:14 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e92794sm77056185e9.37.2025.01.09.23.34.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 23:34:13 -0800 (PST)
Message-ID: <a0b4a8e6-a397-4777-a075-9c926bcd20dd@linaro.org>
Date: Fri, 10 Jan 2025 08:34:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/22] system/vl: more error exit into config enumeration
 code
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
 <20250109170619.2271193-9-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250109170619.2271193-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 9/1/25 18:06, Alex Bennée wrote:
> All of the failures to configure devices will result in QEMU exiting
> with an error code. In preparation for passing Error * down the chain
> re-name the iterator to foreach_device_config_or_exit and exit using
> &error_fatal instead of returning a failure indication.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   system/vl.c | 31 ++++++++++++++++---------------
>   1 file changed, 16 insertions(+), 15 deletions(-)

Yay, simpler.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


