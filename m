Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27A5CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 07:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS8QL-0000j2-8U; Wed, 27 May 2026 03:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wS8Q6-0000hx-9A
 for qemu-devel@nongnu.org; Wed, 27 May 2026 03:11:17 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wS8Q0-0005PP-AM
 for qemu-devel@nongnu.org; Wed, 27 May 2026 03:11:12 -0400
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-44a74032ff8so8418328f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 00:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779865864; x=1780470664; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cX9AAQunfh7nFSqIKocFQrwgm+kCjja121/pRKimQSE=;
 b=HumiZeoEMnD3A2w2gwvjzI8/C0qYSxXT9N5AlckzUOuYVVm5AMRT2ffQqK7XHkJYmI
 XqZ/CUM65TCyNBCTs5thuV3B8VaGYT4H2StlfZblYNE1tBO9ASLrDEj6x9gQsBwHKqp5
 LRS4bA2BcqbgYRo/2KxrkXaKIAdjZiKxzPCqAbOkRvoXecJA+2AorTl61VEPoo5F9xQv
 UvQe0FKkJto59c2+ic9TjR3ozaVgyWSIm0+x3ykaNbHlnCWBukZgZaQIa/a+k4465ZVv
 wJjQj5doRgO5jsV8vai400pllEaKpVDn4SJNICStHXCESB9M+v3O44tpVDO9dJ+5o2TO
 2+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779865864; x=1780470664;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cX9AAQunfh7nFSqIKocFQrwgm+kCjja121/pRKimQSE=;
 b=FjYtGQ5J2ZwGiT1gUCtdwnXuO4k79UX9yeaNfgzFlhHPuPX7W/slgk4SbSE9BXV2JQ
 hWl8ZEBbk9sLlDJUUQk5XsZEKmuLIbIIiGlKq5fB5nAWYzvHflp08YWtg6R6b/VzvZx5
 k26+1C22Y4sr+H9nQgggdXxVOM+X5TwCzoT8AqcuHFj7VPnwCwFDfK+IJ4ZXXpuydZwP
 XTEvhyq8Gk5lhbuiQA3MrwoyihGMk11GmHGDA7t3w4Oo9YxiIMBY4j0djImdziLHZWNb
 AMVgQXd2gOJdRg71rNevmErP5vTMQC3idIqL6nS+6jl+YzfuUc1eSVEO4IxkfcUxwe+o
 yO5A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hUnpz9VeS8++MyXgQ/zW1QG/NoHozaAAcFG8OpLH2oDHQKNm8c1/QzWlrD6wxv1s+nL4roff+hwMX@nongnu.org
X-Gm-Message-State: AOJu0YyleRWZ7KFBqsTRB/16MfUY/jaOrFW/zqalTTu/sOOEvz9dDXYn
 eVAVq9l21RAC2mfvr+L7gm7ID10H3QeGarkf6SFfajXPUo35kBnWQ3PBX9sqOqEqUtU=
X-Gm-Gg: Acq92OFIMEq4/Ol5hPM2xG+IOV5DhAzycv3X+GrZ+fgxoewMhc+9OED8sjvjQRwHBTc
 eIRlsKBliesWA2HgnqAfbJFHpgA7y/Wpz5AJr7wGWgnIOccT3yRh7ZPuruRxt3Dijj3J6otyg2i
 gw+1T//JDcBGOY93ZqmH9Qk6v4Ek2yWbxbqYqhMtUuNbIheKcvUnTgfODolXaQsNr6V5SHZk9bZ
 u21mlrWu+wqhm8iWYRSqi7nl6k9s1Mg+AaYo4VhJuepv68S+ynrM6EBduWN6IkL6jkcWDta7m8O
 KpaFPZHJ+fmL26Qlw0KonO5yPuog3AZ5iJAAK+FOF631SZevClwX++M7pkYm0r6pzIjKakbMYNY
 awBvCJ5jn6Viv1S8YLpu4Kb6U2HH9A9vW/i5yqGyBtJfRF23Ba8iZwK39y+v0rm3hndsezg7PGA
 gR6E5CQoDT9xyrgVHEA1DsW3YHRdKmEO8s3fRrvmV7nSgSN+nW1BFJ72YqEEuGzMQgxg==
X-Received: by 2002:a05:6000:26ce:b0:45e:891c:648e with SMTP id
 ffacd0b85a97d-45eb36703damr35094420f8f.8.1779865864413; 
 Wed, 27 May 2026 00:11:04 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b2bbfsm4242928f8f.32.2026.05.27.00.11.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 00:11:03 -0700 (PDT)
Message-ID: <fdc6eaa4-fccf-46e7-99cb-1962fd8a47c0@linaro.org>
Date: Wed, 27 May 2026 09:11:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: on ai generated and code provenance
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <f0bc9023-28c4-4685-b0cc-fc7ad4e6d371@redhat.com>
 <CAFEAcA9wMRFJWrjGHcd2nfhgXovyuS=dDJvCXWZkgmD_eez27A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9wMRFJWrjGHcd2nfhgXovyuS=dDJvCXWZkgmD_eez27A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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

On 26/5/26 10:23, Peter Maydell wrote:

> I have quite a lot of sympathy with the rationale behind the
> Zig policy, for instance:
>   https://kristoff.it/blog/contributor-poker-and-ai/

Thanks for sharing this link!

> I spend quite a lot of time reviewing patches for things which
> are features I don't necessarily personally care about. I'm
> happy with doing that for other people who are hopefully
> learning and gaining something from the process; I'm much
> less interested in reviewing a mountain of LLM-generated patches.
> 
> thanks
> -- PMM
> 


