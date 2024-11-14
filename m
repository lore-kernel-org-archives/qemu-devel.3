Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CC8D6A22D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 21:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBh9Q-0001Zw-LP; Thu, 14 Nov 2024 16:13:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBh9M-0001Xe-BV
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:13:12 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBh9J-0002MH-Sq
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:13:12 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso9150495e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 13:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731618788; x=1732223588; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BhQoEz1AwEdA7j3JwLiWaYoSglgpi7vLBsBQwLuEyRk=;
 b=xbK2xE8JhbY9H1YJZVNLqqmhp/jc5i/AIrKEtdf8EVIl0dXu14X3XbE/5ShTEtiUrC
 OaWfnhIPWDpQqg4Af8UnRwv5vSFrRMa2r5Q6X5MkTi8eN+KJavo3U2UNpPGhZggtsQWd
 MFqrZ0pBKrPgfrjcE3uk3lIa3U55/KEA3ByWxNLgfmj/svRMI7W+S6CnMbQ4lcZH9KSS
 tSBluN/LiVMx+xnDEej/Prx85XvyKTPDcqijznM8nWS8g8D2PRUwcEMgXyOnXP3s9Alh
 4ejG5+/LVJ6QB4792fxd9gE5nt0XSnoy3S5D8wYb4uro1E+FACA6nGHRNKaYFtjeEZVj
 J/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731618788; x=1732223588;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BhQoEz1AwEdA7j3JwLiWaYoSglgpi7vLBsBQwLuEyRk=;
 b=QjlHQkRw+6N8DReWi6eVd3jl/Dfb7dZOG/Xvd2o5pgjh6e7+ZJgnWsLmt6+W8DhzpD
 qMcLLJxqPFJnBYumPP21UvL5Rv7UpwBgZ6Wndy5qmKDOBWKX5QyVkcQq4ixwoCt/UpiE
 X82NZRXj/OtmkVgXQUiVS0+MONeYrcIhGSabKI7kWudAyF9rNNJfqKMJY9RPfs4elYH1
 CtTP20S55w2tDTBvUIcLU+t6XYjJmDTosvi4CRoihQzkUwdHFb/TXWhAml09GuB1wqIe
 HbFDU1x5zJR4zxZhJVyd3B2LlMz3XITnTAPH9BtsItyggKX/eGzBuO1M6zLtFJsl42EE
 vCjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY7Q56zlf9sZvc8ZlGrKRRxIolGd6VeKG0BAJ4PaFpo6bYGGja7/+/EJMKMtwn3LHvX/bNQa6f9jXb@nongnu.org
X-Gm-Message-State: AOJu0YxwLLUwoyy0zS99UyCcbWICWYLs8ySBpp45Z1BeNb4yqFyvpIyB
 9O4tdyI1BNy3tjoX57NMKcASb/VQbM4T2XhJbvlmXQl+2CygBAGl5reiBbOm2lw=
X-Google-Smtp-Source: AGHT+IECB3IOQPU8siDOvfjZDXK4zBWBRULODoRPPgw7oH+uWjCXOpwtKqXOcu5PAMOTNYT7ETulOw==
X-Received: by 2002:a05:600c:4713:b0:42f:823d:dddd with SMTP id
 5b1f17b1804b1-432df78d34amr1572435e9.27.1731618787971; 
 Thu, 14 Nov 2024 13:13:07 -0800 (PST)
Received: from [192.168.69.126] ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da28b698sm35778495e9.27.2024.11.14.13.13.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 13:13:06 -0800 (PST)
Message-ID: <2ff772ee-5abd-40a2-b672-b1189db36e35@linaro.org>
Date: Thu, 14 Nov 2024 22:13:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/24] exec: Declare tlb_init/destroy() in 'exec/cputlb.h'
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org
References: <20241114011310.3615-1-philmd@linaro.org>
 <20241114011310.3615-15-philmd@linaro.org>
 <d6a52090-a8d3-4cb6-881f-071a5668f1d3@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d6a52090-a8d3-4cb6-881f-071a5668f1d3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 14/11/24 19:21, Richard Henderson wrote:
> On 11/13/24 17:12, Philippe Mathieu-Daudé wrote:
>> Move CPU TLB related methods to "exec/cputlb.h".
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/exec/cputlb.h   | 28 +++++++++++++++++++++++-----
>>   include/exec/exec-all.h | 17 -----------------
>>   accel/tcg/cpu-exec.c    |  1 +
>>   3 files changed, 24 insertions(+), 22 deletions(-)
> 
> This is only within accel/tcg/.  Better to move to 
> accel/tcg/internal-common.h.

Yeah, and IIRC this is also true for some other helpers.
My thought was "better keep all the API public" but I
don't remember why I decided to go this way, since this
is of no use outside of accel/tcg/.

