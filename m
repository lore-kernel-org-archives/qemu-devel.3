Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6038ECCD183
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 15:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAVlQ-0005Bo-TO; Sun, 19 Oct 2025 11:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAVlO-0005BJ-OB
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:56:07 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAVlK-0007fL-T3
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:56:06 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4712c6d9495so9736015e9.2
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 08:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760889361; x=1761494161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kzPYkaMLEOKY/3gCfsAwT/WbN2Ufc9KKCEd0Mx8JIV8=;
 b=LAnjWZ1X14rXrr8j5BrIAYaNglJ5yH2lfSna/UNV9gRBuuhoeTfAEAvBN+bJXBAzEv
 HAjojZxlDyP4FK+IPDHW/9Nb2hzx2ozGparWz/QertZxkTtW8m5rK1gwIUsGwyYNJPho
 Yx8O8Hl1XeIjm4o3IFpN4xsvs5ktuuDDLxvgqKWktFk0BGBKwfMiSVMk95W+tpz2edxz
 TE4x7shz99snZ4BqEBKKHVQqQbg7b6hbqTcZkwwKNwPxriF+BgRGupOR+wph1bv0c5w4
 FSlAdLyNdbU0CAcakecxYIoSXJZ1eoy359fbDRkTEEt5QT1teJPRuGtzheVHFGj+j+g7
 Soeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760889361; x=1761494161;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kzPYkaMLEOKY/3gCfsAwT/WbN2Ufc9KKCEd0Mx8JIV8=;
 b=PaYQlW9BPVTEI+23c9gatJH6ZQtLcPfzS7VJnDBKieZXKfhM/6hG93/rsJJwatv8+i
 MbI67hR0ORFFgrJkSq77lU0qPCeJW79Es9eK5n1h+l3+qnqKCuJ+arCKP0BlEn9MppXv
 1of5iQsPYVXTVCdhhezVNiLIMzSbbCytOr0Th9rRoj+fgxqkVXT70Xe/IBkRpnS9azC+
 Ucl9b0QPcDcCyuUKt+encT/Nr6srNjB2LQzLQb4f/FWRhSeOOR4v3QDqA91ZW8+MpWv2
 7d+MQMKI4y+KpP7ZJYALhOJWdgzJ7hOdena93NLiuyWc+Nlkv6tqTs6W9o6QTO5EUt5b
 1GDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8OAjqXGMpopOCqAo4h10bUNpMoLxGpryN03fOkn5fmeAElsy9Nfc41iPQ9eMo9WK4r/nlzJWPBaOT@nongnu.org
X-Gm-Message-State: AOJu0YyNelI9XUgG6MxlHOqbqo3JhOoxJraha8IAjKYyDD7oS2TNtwdU
 STCAg9/JkYKsyvlM4ATz0P/XD99/+RsXf0HGPTXh8lgESZo+zMGou7hZ9ib5aGXJ5x8=
X-Gm-Gg: ASbGnctaGUJPJENuDEEJjquGiNZWJBIDL7RPnk39wTP+Jm9FqPqAfnjiXv1B0QMsFDL
 eO1c2YSxgdgmueiiQ7Qk1GyD1CoFob4Bd/GwuvKx1mkmKJTFYZFYb+YdDgYl/j17du4RYM/cHr2
 VQ1IizpPC6Xw/iwFTYN4we+UFI4MO5YOOurlQE2q3z6ayEcG7wT3L92tjpkbpsc5R4JOI3gjI4H
 WHbp3UyytD0NWv66gPgSCgEOBIKBacQ6gzwsyfQhornRNlkxfccnFUY4coNbwnk78rmaYwCJuBp
 tLh55WIktJeQMmZD9oi/mgq8KgaMB8o66TNsNrvQNjcNQtQFLtgzyqN5BsgI7sGHV/tfbeeMh6U
 M4brrBedHQ6+xHk9KkvHh58BkwojHK1kngSTMJtkp0UeuwiN04FEcwGXFK48Vg/ThkgvvtnISA9
 ZR0bS+zhRVrNo/+tNMGGdFsGYEJoK0eiChAFr1KtoVxq/Tx7dTtshQTw==
X-Google-Smtp-Source: AGHT+IF76GVeGhlXHxsD6cAy4MDuNZFgUZW1KI4YF8gJK/+uFyEvV59/g4Nal1PlXH0V7Cm/6i44PA==
X-Received: by 2002:a05:600c:8b0c:b0:46e:731b:db0f with SMTP id
 5b1f17b1804b1-47117912b5fmr85324105e9.28.1760889360625; 
 Sun, 19 Oct 2025 08:56:00 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144239bdsm229095995e9.3.2025.10.19.08.55.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Oct 2025 08:55:59 -0700 (PDT)
Message-ID: <bd17f5cb-2dec-4297-ad78-0d5f088a35c7@linaro.org>
Date: Sun, 19 Oct 2025 17:55:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] .gitlab-ci.d/buildtest.yml: Install 'file' for the
 Coverity job
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20251017133156.926094-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251017133156.926094-1-peter.maydell@linaro.org>
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

On 17/10/25 15:31, Peter Maydell wrote:
> The coverity-scan upload job has started failing as of 30th
> September:
> 
> [ERROR] Cannot find '/usr/bin/file' command, and no 'file' command is found in the PATH
>          Coverity Capture uses this tool to identify the file type of executables.
>          Please ensure '/usr/bin/file' is available, or add the 'file' utility to your PATH.
> 
> This seems to have broken when we moved our containers from Fedora 40
> to 41 -- probably F40 indirectly pulled in 'file' via some other
> dependency, but in F41 it does not.
> 
> Explicitly install 'file' for the coverity job, in the same way we
> already do for curl and wget.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I don't know any way to test this except by applying it and letting the
> coverity job run when it hits upstream git... Possibly we might find that
> it complains about some other missing dependency and we need to iterate
> on this.
> ---
>   .gitlab-ci.d/buildtest.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


