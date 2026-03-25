Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41208FEA83B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 10:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5L7H-0005Uj-VS; Wed, 25 Mar 2026 06:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5L6z-0005Qg-TX
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 06:05:19 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5L6w-0000n7-3R
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 06:05:16 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48541edecf9so20023715e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 03:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774433107; x=1775037907; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4rsSIMYRklV6x/NBmnMy6MFV6R33BbxL0Bov6Ucneds=;
 b=mCbHwYpmiY8pQFsyMQsQnzCG7ZBFzhdf8GrPbOx54UQILV1FRB69oDuyINZwww4rRp
 MjyzBcfvpR62LZnWfwoUd5t3Io8rmsQ4twxpU6PcfeWdPtMlJhn1v0xjf8zmObdn48sw
 BzJBAbHEvA3ROOOU4Uxuy2hGVq8z23SbZ3AzzBZgUIU/Jf1GEuvOEcuXtpz6Y49YEfBx
 5lo8tfVk4Z/KvUY0/K2QyobNs3P9+TcOcNMvDzNk/i0yAXphSjFXBkjtgS2Pnj9RamKh
 0/00hXto7F1cz0hgjF8UmbpGxbT9Y6Qib1CpC5lqSoTQJMmEJiVUmEhjzoML/5RdwJ8A
 Ve2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774433107; x=1775037907;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4rsSIMYRklV6x/NBmnMy6MFV6R33BbxL0Bov6Ucneds=;
 b=E8fOClCN+NDqdZVjO30dAmVxPIgsQsmTVGQfN7+3ljUbB5/CaUnysgVkES+gFtjk0z
 eR+auh62oDBixLHlSqwe7Rsp2/R6UUSFyFdfdUpR+B0DdVFTa9Y4Re7GbcMsDRAQ9HdP
 n/G2qNMWYDFILuEzY9F8xwMcIKdBk8EtaoROSJCV8ilb5GrEcKlwdRhAJyF4U0rLI80r
 xnsCiiI62g3qAwpxwhQ73yKUQlqa4nReYixeHxaIa5ofl/5ArZzFqmac544M+/hFdKAE
 TKEOQtHExzBvEWyOux/ndelC7Ji2ABXUEQjoJEXDE6wsvKEpxjoOhtnSujbj4bZtVORg
 uUgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKTpTvfNlPzq0YQI2ZW+m07hJRLNEY/Oqh6vTeEJJGnls92uCGhI9JMIdrWrxStmBNZGXiQGY/KnnJ@nongnu.org
X-Gm-Message-State: AOJu0YzHMe+X3CjtW4dNF58NAjPF4kKiFWzqbcNemR591gd+n8HAxImm
 crCbQ3Mw1/KkMPj6si5ko7OpTBKmy8rF+QCOL/HxoW+9UxDo2LakR/jPebU/gsu78xk=
X-Gm-Gg: ATEYQzytRWOCoRyhxXuq3Ex8ayuIvJbk+YMfQGz7BtUEG/ouV68F3iISBLZEvqX6Pd9
 3lLh1YtMWCJwTbHQT6VJxyyMIEbzafQEfvts3pb7JdQb3l0rhYlS6MraTdlHoOOyu/p2QH3ZjwC
 CKL5UEPA+IEC3oBBrYwNwDxrbCyVfJjYCqsO4IwSdyOwY+XZFV4EiY1SqWjQp5zxy6mFlut/P05
 MqrgqTbzS7azol5f+nnytVjG9miQjs/laFSgbC/GroSmxXXIXa9To5bb4prpxh1BsvczfD+m3ZO
 mkPA/Ic7KPkFM7IJbFWIOjubbDhOJwQHuxhY0BN3INCdNlZc4oF85XJX3ci5QdS8QwGYKoKJypc
 y4wLmh9aSRlrx6hEIwYgQs9XJXZrzb5mqRq+dXV2S+BebbA1WDTlLITJ11eGE9bIvWy5lX86EA5
 UVta4PSq9UMp9SwxFgvq4RSYyvLArcnupXIUNp+LlFlKG6JiM3YP6syyiSLIQXjYurtw==
X-Received: by 2002:a05:600c:3154:b0:485:3ee1:eba5 with SMTP id
 5b1f17b1804b1-4871608d862mr43935905e9.27.1774433106733; 
 Wed, 25 Mar 2026 03:05:06 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48711709b48sm113772105e9.7.2026.03.25.03.05.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 03:05:05 -0700 (PDT)
Message-ID: <337da0e3-42c2-4a6c-bf12-8491da9dd740@linaro.org>
Date: Wed, 25 Mar 2026 11:05:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tests/functional/qemu_test: Silence warnings from
 pylint in config.py
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260324163543.55503-1-thuth@redhat.com>
 <20260324163543.55503-5-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260324163543.55503-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 24/3/26 17:35, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Pylint complains here:
> 
>   config.py:1:0: C0114: Missing module docstring (missing-module-docstring)
>   config.py:28:4: W0719: Raising too general exception: Exception (broad-exception-raised)
> 
> Add a module description and replace the general Exception to fix this.
> And while we're at it, and since we've got a proper module description
> string now, also replace the copy-n-pasted comment at the top of the file
> with a proper SPDX identifier.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/qemu_test/config.py | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

