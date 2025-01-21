Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A08C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 04:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta61X-0003us-0j; Mon, 20 Jan 2025 23:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ta61V-0003uj-91
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 23:37:57 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ta61S-0001ZQ-Of
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 23:37:57 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso89315245ad.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 20:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737434270; x=1738039070; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=26pqvTNJhYhFtEV2v/4yM25rfonlWqim2cg//xyn5z0=;
 b=hB/0ChPsRnw2H9eJBeTUHgCk9NkYg/R2qXbfD0/XDWngU8r+v0+lvRbStEo/xge+Q3
 TGgGWe33kyQieueFqYjfdqf0k40pfstFZcb1Uj1tcZfEEH7jRV3NfxqfhUpFDwT+RJCd
 zw0jY/G+oZvOPr6AZDWspQGEajPwNJVA2Vd+4p0uJ1LvySmvxsToTBuZvMJl8u2AioIE
 qvrDy0aKMQMPevr4VVNs93I+eceP62wx4EN6q7piLiWUB9iNd3dlgcrWLS7dIPnHh/Ot
 NaoJbypjL9gOC0bQu7N8jWS0UQHBWbwoTsPihI4J/BEMEqYv6gfSNpu592v5xFTSCWlt
 hFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737434270; x=1738039070;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=26pqvTNJhYhFtEV2v/4yM25rfonlWqim2cg//xyn5z0=;
 b=xQKanHPzP49FTHrhOeNZvpXxpaIFI3rbsBRbKLm0/O5mLgBh4hoY8emZT4tPyjp02f
 J0KxRvTShDvmcR94jqlO00QtrJJUNdJJpgtQi4NahQthhqCl7qkzSo2urlv+ijFstMsL
 ic62L37ngODee7B1XYp+B/wr1t3k312AtnghXdD0hDGFT/4b5f+quuT1joI7VDyaFZ0v
 8J51fPbk9jEzY669amrkxnAm9620/8wrdb8Sad2NLkTxwraFJkuIyDAXuJPr+lwr4g3E
 66T68KgRd0otUSQ7/pKRIcItjQLga1suXWXcKy8UnukAl6HpIoN9u1L5ybY1FRejjmiD
 FW4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUek/PFlN+esrekCPHX/OLkvwkSA9+xL8Xc/iSoc8GC9C7u6ie0Lt9jHMFe+dd2UWaNSP6QXhTnJxKJ@nongnu.org
X-Gm-Message-State: AOJu0YzxeDeEzb8mi+/LxIVo1Op7jb25tbVoUPhzMUaJQFP9khJZ487M
 GogqaMXfxx0fW3MF7BKQZa+OPk+y6azwW6qeGdxhvHddiKY9+WJkv3bhsXZHwEM=
X-Gm-Gg: ASbGncvXszURsdgIwpvc7PTQgp/+ccz50YN5hOHzOjW+v7IvGITK2fz3cNgzLFVkgGx
 rq1IFu/Mnb1Zujlgbbvczp1k1HnVPdMLCoPgSSVFSQFY3Mcw+BJmn5DYKGeSR5w4A2/GqOraPk7
 DEebCWFvjkCeU/DkgpUoh/ozUUM0GbGC6z6zUBz+XEB2MO5+Qsa/YD/M1I1dpgsAfLSuUZAOJbW
 CRLoLnIcUjo3YClXl3LD0a2EQgYMbQPIpTggvcpvLHWC8LRELmPi03+eHTGkd8s8Azg90DbYpFy
 8DuP5xi0RBVKeEx5I5/hbCAL0qihgXSg0ozn
X-Google-Smtp-Source: AGHT+IFfmr8oW17Gsy5kunqDNu3Vi/laeFNoe8tJRSCjn+qGv7lCbmQ3tWs6cz15epD3gvVW1HgbRw==
X-Received: by 2002:a17:902:c94d:b0:216:7175:41bd with SMTP id
 d9443c01a7336-21c355c0257mr216977315ad.39.1737434269946; 
 Mon, 20 Jan 2025 20:37:49 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3e0df9sm69319875ad.196.2025.01.20.20.37.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2025 20:37:49 -0800 (PST)
Message-ID: <47e7d1c7-cf5c-4276-a9e6-67bf250f4133@linaro.org>
Date: Mon, 20 Jan 2025 20:37:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] accel/tcg: Constify various helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250120072758.87082-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250120072758.87082-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 1/19/25 23:27, Philippe Mathieu-Daudé wrote:
> Constify argument in preparation of constifying CPUClass helpers.
> 
> Philippe Mathieu-Daudé (8):
>    accel/tcg: Constify curr_cflags()
>    accel/tcg: Constify tcg_cflags_has()
>    accel/tcg: Constify cpu_in_serial_context()
>    accel/tcg: Consfity tlb_index() and tlb_entry()
>    accel/tcg: Constify tlb_hit_page_anyprot()
>    accel/tcg: Constify sizeof_tlb() and tlb_n_entries()
>    accel/tcg: Constify translator_use_goto_tb()
>    accel/tcg: Constify tb encode_search()
> 
>   accel/tcg/internal-common.h      |  4 ++--
>   include/exec/translation-block.h |  2 +-
>   include/exec/translator.h        |  2 +-
>   accel/tcg/cpu-exec.c             |  4 ++--
>   accel/tcg/cputlb.c               | 13 +++++++------
>   accel/tcg/translate-all.c        |  4 ++--
>   accel/tcg/translator.c           |  2 +-
>   7 files changed, 16 insertions(+), 15 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

