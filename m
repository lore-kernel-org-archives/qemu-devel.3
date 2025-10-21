Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A3ECCD1AF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBIYO-0006EO-6Y; Tue, 21 Oct 2025 16:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBIYL-0006DZ-PK
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:01:54 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBIYJ-0000Sy-Ua
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:01:53 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-475c1f433d8so5713805e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761076910; x=1761681710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3t6jljj2ZTmv6gwX1KY3njvVAgWGqPCmbyoVVZKjRXE=;
 b=xGsNgMFYxSTZjLJARFKlukxks6YB6r66vRsKMxYiHulvxP7r4kCgL/CR3fMdu/mhSq
 XId2sYu5xeDPNVMWqH5pMzFztIDNkNmePwH8FklUdiy2fiAX4SFOdbU+vxvmu7kz6jU1
 dz874+LHjHpWjX1oYRMGJEniY1O8HV+u2IIJzCadPwaIoXXoqENgd2AgIlkS+Xzxws3n
 YWMZ7hnKQaJGw4kufC2r4ogYl4eKCBdkNvk5CK5iDlC8XFe41IBhSg3IbAqTSzQpPNkN
 uondHOYnMLMPPjGbQHsPbriOLti8ds0r3jZBzezlZGPEztgW2UuJcbp8iSlyTFN9EkHq
 J6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761076910; x=1761681710;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3t6jljj2ZTmv6gwX1KY3njvVAgWGqPCmbyoVVZKjRXE=;
 b=Cv+EWEzxMkqOQyVOR2RweVbotHvtan7rxm2jin/5Z/JU0mmfp15yaSBkMlDqJ94waC
 B8k0hx5wlCkNKPg1bFLx6yV3upAj5N4MsWc7DtqYMFTD1yIjugkGILyfUh8W24+SDXuT
 pZBOFUXfZifjZPgWgewzu8JDowVIBMlAFSvWlumZkTjmARn41JqpO12sW2SY+dPlEQ48
 8Vk5Z8c74CMsMhMeBPm0SjSAdHPDnfMl/Lr22Z/RUSnkPEcO+w4+VqsD8DyUmh7h6IHC
 THuzvMUa9Uni9b7T0iCaa6KvUkgjpx5bTzZwWWRs1a2zqm8+kAXHOnqszHqhhQ2vzXPG
 +Kqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd7YRvSLTRLFqEK4Iw5P/V3+6pjFGWRO8dpSKoJDlNk0NolQMPIo0KXaZmq2lP4n0CHje8piDEkDZS@nongnu.org
X-Gm-Message-State: AOJu0Yy5Uf9vUnMsS5X/pXAcADOpIJjaTk4gRCtHfjjJLksCa7TTrHLt
 HD6HcrU0QW6Z8uFR5xLYpk1BNNxY7J4kO8b8khmM61gndETfhBCbgAK5gMqs6okNQiw=
X-Gm-Gg: ASbGncsta3tCfrSDPdpMoEamH2E1C88thS8oDaFq313PqaTNgPHzTZ0oHWNo8gVOSCZ
 poLl60jgV6CwlOIa7b1OP3oaDQLA4jR6WDHGMA7RzHUOBmYXRUeZwj5ytg5xhPgI8jSPQso5Mzw
 8uo5n/EiL9il47pu3MTdG7PyIxkb/BBMsLUS8bAAGHBxhOE1UsmTmgYtCSWEXgjT+XjGYJN8i1J
 i+edQJSDZvlpotDFYLDVMRL9mxG5pn6HBgfuwEXKJeCk0OrciSJJWXpjo3Nam552pjXNk5aLOhl
 +0cV0OGpc8K7S24/+ij5cDx42ex968EZRp5EinACf9TwZCMA/ooloc5oKyTlVrQ0JBF/OBidh/a
 jEINS7T8xF5/7twGSADGGRUjhzfMp0glwEPHDVHZoVK+NLamkH35zOkXcsHV99Jx6pevmYzvueC
 DtNwgtjTguR/71cWyMQkfu27UNN7vVZ9BuPTNcQ2M2iBfLiSDy73s/1Q==
X-Google-Smtp-Source: AGHT+IFpeWZEwGdFFlRCxN6+Ir9dKwNteGxH0MzWSlLOKSVwwYrY+hD5vbGe4lsapuuRY/eBEel+2g==
X-Received: by 2002:a05:600c:444d:b0:471:15bb:ad7f with SMTP id
 5b1f17b1804b1-471178b04cfmr119573135e9.17.1761076910141; 
 Tue, 21 Oct 2025 13:01:50 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-474949f0312sm24387635e9.0.2025.10.21.13.01.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 13:01:49 -0700 (PDT)
Message-ID: <a6e30c8f-4e6c-4c62-81ca-ce5c77499d98@linaro.org>
Date: Tue, 21 Oct 2025 22:01:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 20/25] target/sparc: call plugin trap callbacks
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <cover.1760884672.git.neither@nut.email>
 <fd15fe51fb446f9549445f82df659e092275debc.1760884672.git.neither@nut.email>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <fd15fe51fb446f9549445f82df659e092275debc.1760884672.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 19/10/25 17:15, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for SPARC (32bit and 64bit) targets. We treat
> any interrupt other than EXTINT and IVEC as exceptions as they appear to
> be synchroneous events.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/sparc/int32_helper.c |  7 +++++++
>   target/sparc/int64_helper.c | 10 ++++++++++
>   2 files changed, 17 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


