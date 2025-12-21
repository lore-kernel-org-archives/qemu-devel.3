Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD3DE67482
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 14:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXKti-0003Gc-Ao; Sun, 21 Dec 2025 09:59:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vXKtT-0003Fx-V8
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:58:48 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vXKtS-0002jj-DX
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:58:47 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so31272655e9.1
 for <qemu-devel@nongnu.org>; Sun, 21 Dec 2025 06:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766329122; x=1766933922; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7oEDRByIf/My1WbhFq441/alP4/MmpFH1kgaYPnGg0E=;
 b=TfSY3zoQ/bl5ZsBq2lCM12MdNndJ+yKZmC5RdS+H8k1NByHU85M6jY056gbjI0VxJG
 WIPUCgk0PYm7whxv/kGosOn4UB2G3QdjdGOseIENG6P7eMUrbctspU5NzD4tqTNcw2vS
 WxzJGp8LkQ2hensxQ2OCNtndvE8fo8yF0kgRQNfX/WNzD1HmxNBotToVwIJNAvtsmoWB
 EaM+y2SHoguAyEK6Di9NEJkDvp93cHa/HV5q5xT77yWp8KK/o3fGvHHJVHS3JlqT9KoL
 cm6WfIWk8afTjtZMFNJWjwTeGucDNuY0zB+njVjwwoTfcD/14fLXTjQtY+rrX/tEy7Z4
 VA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766329122; x=1766933922;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7oEDRByIf/My1WbhFq441/alP4/MmpFH1kgaYPnGg0E=;
 b=lTUHwxIXwnTlNcqq8gC4SHgYpXCmtQGOwVtX0rCj1BdVJ8zRGclAe0Y5cdM7qWnUcU
 rp+w1jVm3GmnxcrJJ9HXS+Vik1/0BtLR36tU5WiYGSGLdjxXL+wQZSyzg1jX7tP5FTe1
 a05NWtnsffdh9ywFDBWBhn32DRayvknA3qJb0iAm4n50dp/ro8KyE7heRjp9tGPgDugU
 TuxCwGkkqvGQYIesO6apsvsjjxb40fWh6ZptZt70mHYiicbl9xSSjMDqb16dr0rZb64s
 AfXLnPeDwPeMGzOWvgLnzfZFe4n6qci/cvmmnjTwWMz5UlcTzVBbnlo2yzNC+8tsjBXZ
 v7LA==
X-Gm-Message-State: AOJu0YxhcBS8JiPewAzoFwkvH9yxCQiFgsXuc4NAL3IIvITOeYCP1Bxy
 duZGxPrkPveAHzHu/nzuOb6uecCAavIAcspMNYg1Hw19pfbHXVUlN5hzWRln3aog0vbC2/BnYp3
 tDmh5+7M=
X-Gm-Gg: AY/fxX6SyhOCZK4dgHWQf33P9226U1KhCF7TcW6Nmyt3fE1WdEaoagtWFa53yWxotdC
 s1Kr9wfzeRauXALZaMVTdXEd36oWOQgQTAOl6gqouy9dXN6ES+dqg8V6U61fwikMC66PT6rx1Ue
 WeIsCiu9XrekI/iVnA3YhQVT6kFvQcNwSqLThahOjjYQ0BvsDx7ftsi2N4KWCmuuiG0bM8dZSA4
 g5CbLsqTEhGVggyWOiJdSbwZa7wOD1Ikt65rTXKkhuZaUQb7tB9YYEd5DrQNWhDdfLHP0icgTue
 ieMTYDpooX2pVkhj6SZUht5cPfG47JGhX9aacXC+VYku6h/8gD9c1UEs3/x2pLK0MFaEzHhj43r
 b8NGqRmrf3ZEtZLNjRKW1LC4oK4QH1TUro/bgXIBAozkXtNnejVbDUowczOWabmYsAyNRMHXIut
 b1djYIqPrXEuTDpql6zasOUBEifvSotnkTtDA71lcdSjriXghm6PFm2A==
X-Google-Smtp-Source: AGHT+IEEQNeOhFzCvJOt3myApQsAthmMtZLPpAE6EfHxTHNpPhTcM4IDZb+RYYifjQ3zUbZ+QNMVZQ==
X-Received: by 2002:a05:600c:3b8f:b0:475:e09c:960e with SMTP id
 5b1f17b1804b1-47d19593d0dmr108629285e9.32.1766329121961; 
 Sun, 21 Dec 2025 06:58:41 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2a94sm16621915f8f.43.2025.12.21.06.58.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Dec 2025 06:58:40 -0800 (PST)
Message-ID: <899ae0d7-e611-4c62-8499-6d54200a3924@linaro.org>
Date: Sun, 21 Dec 2025 15:58:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/loongarch/virt: Don't abort on access to unimplemented
 IOCSR
Content-Language: en-US
To: Yao Zi <me@ziyao.cc>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: qemu-devel@nongnu.org
References: <20251221122511.56544-2-me@ziyao.cc>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251221122511.56544-2-me@ziyao.cc>
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

On 21/12/25 13:25, Yao Zi wrote:
> Reading/writing unimplemented IOCSR on real LoongArch hardware doesn't
> trigger any exceptions, instead, reading always results in zero and
> writing is simply ignored.
> 
> Real-world applications, like memtest86plus, depend on the behavior to
> run. However, since commit f2e61edb2946 ("hw/loongarch/virt: Use
> MemTxAttrs interface for misc ops") which adds a call to
> g_assert_not_reached() in the path of handling unimplemented IOCSRs,
> QEMU would abort in the case.
> 
> Replace the assertion with qemu_log_mask(LOG_UNIMP, ...), so these
> applications could run. It's still possible to examine unimplemented
> IOCSR access through "-d unimp" command line arguments.
> 
> Fixes: f2e61edb2946 ("hw/loongarch/virt: Use MemTxAttrs interface for misc ops")
> Signed-off-by: Yao Zi <me@ziyao.cc>
> ---
>   hw/loongarch/virt.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


