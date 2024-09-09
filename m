Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BBCECE589
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 22:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snmhF-0004dH-RB; Mon, 09 Sep 2024 18:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmhC-0004P6-66
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:17:18 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmhA-00004w-Ok
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:17:17 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5bef295a45bso2116587a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 15:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725920235; x=1726525035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xkJQfHdyf05TLvP7TtRyTlsuKGEK6wtMiUMavCz/5hc=;
 b=pEjDRGl7jRG7XTTan13ruCd1LRwhRWin1uyeQ7oKTzovq0TFoT6P/ddLAIdIQRB/Cs
 626koGJv6GTaQ2WLlkArcdU6dfiAwQyoVzEZwzp4CGMnKfe8N/ShB9M3iUymecG0vOuX
 umk5gwaAVWEd2CNCcf3HjkUWq7WjgwVxaC0cfEg4y1zKYg47T34b89eopBNcpTBnNI44
 TUav+9Ow/cie9vn0G6eL50WLVDykyL4kzAwzoLuiegs2buGc2my0xKXlU/6bn1qh2yJA
 09/cwMddv79W4/xiQ8UnuMsK+QWLCGoTaTUlCgJIbN2551I6RPJ8deoYRiIkzDDiedvI
 uL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725920235; x=1726525035;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xkJQfHdyf05TLvP7TtRyTlsuKGEK6wtMiUMavCz/5hc=;
 b=I279Hwe3Q8PgxpHPqNj9qCk0h2KooWibHeBsq/a1eiISHIF1R5lTQupf0E00Hnz5dN
 B84ZrRBWPJbQuMpjcIlJIZISlkvq7e1XV1jBUQedUEEd5Dh8Zjj3x3zbIBboIJxi9Y70
 4AFmJIbZCZ3WejdRUQNOPtQJOgbYqZE2q/sNVdQZ/5Yax0PDB3D1xcu3AOWc8pR9fsCc
 ApZB7sevKBxyMRoPObdk1bZQj0x/Ofc35FvjK2S2hm37ZIP883rZByPabFFI7kZxBxhm
 3jtokUu7linFFXWgVCddARb/5R5fEAcS23NiEn6tmE3KwkgHGQvXKsx+banxOFTCi04A
 /75Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw/6GbAVcKdT/PJUNQdxI/31HIeoLdFxR21UcDXWQH1eC1G1+itPlySr5VqKX7hPrhrJxtlEpr1D5N@nongnu.org
X-Gm-Message-State: AOJu0YwDKQ82kNfswgTt2VvQdDStCq5BK+oG8irdSlSNrJjqvjH4CWqb
 uPE7wKsXOgeMwYJVmYE/sTyA6KRysc293UHZKWt9zJTgcjjsFSdLBQU0B/ESYF5lEw/hJ8omEJr
 2
X-Google-Smtp-Source: AGHT+IHt/FSZwLYtrZFNwVKBp9GLsG+nToZrPOC8ZCHHdWk95NPMAAl0TZg1V8FdFnTMXMm0hgTj4Q==
X-Received: by 2002:a05:6402:2114:b0:5c2:60ac:fdda with SMTP id
 4fb4d7f45d1cf-5c3dc796f65mr12882361a12.17.1725920234681; 
 Mon, 09 Sep 2024 15:17:14 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd468a1sm3459325a12.26.2024.09.09.15.17.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 15:17:14 -0700 (PDT)
Message-ID: <23af61b0-85fc-42f7-b610-6c54dea9a475@linaro.org>
Date: Tue, 10 Sep 2024 00:17:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/26] target/m68k: Make vmstate variables static
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, daniel@0x0f.com
References: <20240909172823.649837-1-richard.henderson@linaro.org>
 <20240909172823.649837-26-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240909172823.649837-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

On 9/9/24 19:28, Richard Henderson wrote:
> These need not be exported beyond cpu.c.
> Fix a typo in vmstate_fpu.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/cpu.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


