Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA95C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 20:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHT9r-0004Ut-08; Tue, 20 May 2025 16:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHT9f-0004Sr-2d
 for qemu-devel@nongnu.org; Tue, 20 May 2025 16:01:40 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHT9U-0007yk-ID
 for qemu-devel@nongnu.org; Tue, 20 May 2025 16:01:35 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-30ea559c18aso4485748a91.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 13:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747771285; x=1748376085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JSx7/myuJN6RoX/DrlMn7WxYYSRNtaC2cA12R1bsSUw=;
 b=hsFtnRtQgqsm74J8gMpqveOOi4e/IAoYJZn9Sz8FLeUx756nqzFW2zYs8oDhOgyeuF
 f5wo+LxeTmJxt4RRuSnUIoNRgX8plDd16LoW58mVtp0kUBLzGl54SfPNwBzjLAeTGgtv
 nVPm9/hjvFCWlyTS5R51UIAnE8m+3FISNFc5+3XtPNAwTtiw8I9KM4fS980GX1NW3loN
 XrT07GH+A2QvKMVlLmztF0bqywj4HBBsS71oZJC+VNnWQDb7uyqgOJ2DpqTpub1oGwuN
 61wVZaK3pWzLqEQ9BdT8brZKykfvei61bZjg7PVto6kDvIhPx7tfZsu1iSGWvkaVbAC5
 trCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747771285; x=1748376085;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JSx7/myuJN6RoX/DrlMn7WxYYSRNtaC2cA12R1bsSUw=;
 b=H5YWWuMCWCvJ/uv287m99Qjy66MtbpYo7fFXHxFmZ8oklfluQshcQX7du7ffPGUg90
 uRO710mb0vRri9YJklQMN6/32WIYn3bvZ5wAFOOILC3kNPaVh8l7iyLP9y0Ji6ejuhUB
 jNd0xoFqkksNBcy5/cBQvoElVFRJp0ohzf1Od9GprgRpHeKJkDVxnPwgrz1CvDhcq3C5
 UKUwqU/UW45svnQk9A27Mqqs1xn7UBhw7/xKiGIQRbuUGmc1LnELpiVNoiuaSLoXKdiZ
 GVX4Wa2eh0P2gCiPbAYloGXZwHZKMQrvKbOkXfUmbphOrtZlczD6lwo7884J1dIEF/T2
 P3Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwMA8vyW7TuZhtXzlyOjFfw6BwVvnJFUO/bvwUfZ5O90L8zFdn11X90V5hZH19kQmOCsS814yvVOR6@nongnu.org
X-Gm-Message-State: AOJu0YzZag5wbg7ReS/rVGKAl4BMPuALl3n3Tsap+Nvs1VIz16WJ7h19
 qsSFNwGmodsFkEvTMgGdqDV9GpgfriLimWum3qwMZlW+a9LnYXLb8C62EP+Ds3kk5IU=
X-Gm-Gg: ASbGncufWJ0eX/20KIw96PTRwKueHrVc8of7s2TG3p0PNSUzsXGDV8EWLoOQ+owqqQX
 RP2ezLuPrc2/yoN5mlunzZW5Rud5rLMeP3gqtjwIlGQGUezwJU3aHMlnrNKQqCALd8Jm/+9bC0x
 v2odzvu5eUSxPmom2s4EM634/jasYjAn6j9xH7AO0C6IJZWZuhxKW9FyMiSBooZvYWYEXE7U6pR
 AQ2vhx7rHwhTvhd2KAuk+aeGFKvMbLL87YB+coPWwcyoF8EogoCh+t1GrO5U75X4b1kWO127/O2
 TERYdPizLotV6vFhDE6YMH7UlE5bMbNZfZrnrxobksMk3OQXStenWBQI4YbRwr/9
X-Google-Smtp-Source: AGHT+IEymaMcbXywX8h5oNSlCPlVs2f/X3jT5XYD/wLnQ5lPzVmNTiR+j1q0pf+MUmJ2TYsgIkC++g==
X-Received: by 2002:a17:90b:1343:b0:30e:9349:2d93 with SMTP id
 98e67ed59e1d1-30e93493283mr27945335a91.28.1747771284780; 
 Tue, 20 May 2025 13:01:24 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f3638649esm2151166a91.13.2025.05.20.13.01.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 13:01:23 -0700 (PDT)
Message-ID: <dbf71afe-1ae2-4110-8f83-fe1b1823a774@linaro.org>
Date: Tue, 20 May 2025 13:01:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/25] tests: add plugin asserting correctness of
 discon event's to_pc
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <cover.1747666625.git.neither@nut.email>
 <2a30a629012f39f8495415f87568fe9b3a0eb32b.1747666625.git.neither@nut.email>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <2a30a629012f39f8495415f87568fe9b3a0eb32b.1747666625.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

On 5/19/25 8:24 AM, Julian Ganz wrote:
> We recently introduced plugin API for the registration of callbacks for
> discontinuity events, specifically for interrupts, exceptions and host
> call events. The callback receives various bits of information,
> including the VCPU index and PCs.
> 
> This change introduces a test plugin asserting the correctness of that
> behaviour in cases where this is possible with reasonable effort. Since
> instruction PCs are recorded at translation blocks translation time and
> a TB may be used in multiple processes running in distinct virtual
> memory, the plugin allows comparing not full addresses but a subset of
> address bits via the `compare-addr-bits` option.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
> 
> Pierrick: I did implement the changes you requested, but I did not add
> your Reviewed-By because I felt the changes were not trivial enough to
> not require a new, coarse review.
>

Looks good to me, thanks.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Regarding the issue with the same tb being mapped at different virtual 
addresses, I'm ok with the current solution of comparing only page bits.

That said, a better solution could be to compare physical addresses when 
a discon is detected (on plugin side), and confirm it's really a 
discontinuity or just a different mapping. With this approach, it's not 
even needed to have a dedicated option, and there would be no false 
positive in the plugin. It's just a suggestion though.

Regards,
Pierrick

