Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B614CCD183
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 16:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6XQ5-0005MG-LS; Wed, 08 Oct 2025 12:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6XPx-0005Lv-4B
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:53:34 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6XPn-0003ts-Ev
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:53:32 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-78af743c232so25074b3a.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 09:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759942398; x=1760547198; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ku4fkkrwr7MrwaZwScQG5MeSbQl9rL/U/pOaFwjBcIs=;
 b=krsYWOnmNF43i/nSwibIJVXNCN95nI6MH+5u0Hte+GxxzKgiNf93pRUBKCSII7Kmgv
 fN6JpupvGlTVz0htsffVYwOIQFDalZkz6bRoZ7RsLWHjkurCxFt9qplyM6q0U0jeXq4o
 4xPV2xmwv59Ktx1ATE8sOvU2OHlnani3p6kZxJWZve+ZoUt8cAx+pwYQEzZCY1esDr2f
 fi+kPXeaqjEirJnGTK4HXkocHeyOHnE2tnYfDDwDFzOF4Ew5Q3CcJ+BpoOwKF/svMXCB
 PqZ9mam6dUVt3UNu6GxPZEfExtwlh4p76tEiaX5vAosJGTpjMEQbe3kj6sqoLKiPc9Ty
 dW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759942398; x=1760547198;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ku4fkkrwr7MrwaZwScQG5MeSbQl9rL/U/pOaFwjBcIs=;
 b=oJAi0DD1nkUsKd4dPAYlcwoTdwgpLKnZ/6EQQat1Z1jCw7vnFAbBnoaW/89ysk0R2t
 Av/LBXh1jeh2VuGBy1ajJcL5U+JKqoYWyegXbjgjZ2KtOD36gNoZwOEW8ZoX1imiNH2d
 bU89V8qmBiq92EunQCkI232F3U66sEA0FS97wDXK6ra7GOrrNZYSS7hSUhkOdvccFxeX
 /QwDqxBa/eSSYBzqr0iLPb9VmVDCjCLkFS9YdqesspXo9RcRl+bMgMLt/2Vj5i3VL3C1
 LvImOE7QKEci/fiIQ4hRwUnBbliHwv1LMvKSLZOrRyXYDayCEj2OKAjaIVEwYOdutuwZ
 KWZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnUyEBAZPqDfHfpfzOty3AAL34jwT/46ovdx0JY8+jAQyAGhhef70mGLJPpmyDNAVrJjffibrtKKn4@nongnu.org
X-Gm-Message-State: AOJu0YxhtCR1HSbrdzkvT9kKcMR8GbS5693qZqFuBBL5oJEBY4n5QyUB
 HkDQWfyQlbsS9x5aC/6cbwWkpq2OhE00kdudspWhmbVceEWR6D9ucHCcNKEV/59aVAM=
X-Gm-Gg: ASbGncv2K17WT6mJnw2cSvrtnlUAzViECRIFtWzKHmibcP4rL2qJN7LOSjOs2MfIOLo
 GgNhghw6dh4CrzmjR11tR6Zq8gXJVY+VorA5k84IaBKkwU2RlkMWTUGOCnptCzMh00aFLXVVtvA
 tFqXFVHrsLJ50Yg9i1S8/3SpLQqRVegfHxSN7L9rzQSaBZQr1kCRDiWkoujw/jOvC1qAaL6jqly
 iGq+l5w6onXxWSeo6+OlhFiOhSiq14jMKqLSRbJ+8nvbclNg+56LxntBAdwNGYPyHrjRVBWZzjW
 hIH11lg0kCH610bUTEsNod0qBnMapInNdCgjLGh+t+/B8V04aEZQHORvakwrxpjRAXptou01oD1
 ULPWWS01mgADmi81/X7u4sFAiHKkbgpfpOmGZvmiBr+dOHrNh2As1tWWaBLNjTvwI
X-Google-Smtp-Source: AGHT+IHf5BoK9NkNfxMEQITiqizc728YSmymIw1tP2d/I0CFUA6XvjxhZfY8loHkvHTMVYrhUxMmLw==
X-Received: by 2002:a05:6a00:990:b0:792:2dd9:d8e9 with SMTP id
 d2e1a72fcca58-79385327124mr4932579b3a.4.1759942397579; 
 Wed, 08 Oct 2025 09:53:17 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e33efe73sm210571b3a.73.2025.10.08.09.53.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 09:53:17 -0700 (PDT)
Message-ID: <badbd3be-f09b-4215-a179-bc13c98a9d26@linaro.org>
Date: Wed, 8 Oct 2025 09:53:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qobject: make refcount atomic
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251008152701.411964-1-pbonzini@redhat.com>
 <50578062-8b7a-4286-a154-eebf05f3be3c@linaro.org>
 <19ec9e38-8b34-420e-ade7-f82e9e7f5969@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <19ec9e38-8b34-420e-ade7-f82e9e7f5969@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 10/8/25 09:14, Paolo Bonzini wrote:
> On 10/8/25 18:06, Richard Henderson wrote:
>> On 10/8/25 08:27, Paolo Bonzini wrote:
>>> @@ -95,7 +96,7 @@ void qobject_destroy(QObject *obj);
>>>   static inline void qobject_unref_impl(QObject *obj)
>>>   {
>>>       assert(!obj || obj->base.refcnt);
>>> -    if (obj && --obj->base.refcnt == 0) {
>>> +    if (obj && qatomic_fetch_dec(&obj->base.refcnt) == 1) {
>>
>> qatomic_dec_fetch lets you compare against 0, which makes all isa's happier.
> 
> Happy to change all fetch_decs to dec_fetches, but wouldn't the compiler be able to change 
> one to the other?

Interesting.  I had just written "optimizations tend to get blocked around atomics, so I 
wouldn't count on it", but then I stopped to actually try it:

int f(int *p) { return __atomic_add_fetch(p, -1, 0) == 0; }
int g(int *p) { return __atomic_fetch_add(p, -1, 0) == 1; }

With current gcc, these two functions compile identically for x86_64, s390x, riscv, and 
aarch64.  I didn't bother testing further.

So, I'm happy with either formulation.


r~

