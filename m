Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4399CCCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 12:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v66M8-0001GV-H1; Tue, 07 Oct 2025 07:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v66M3-00017W-W8
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:59:44 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v66Ln-0001Y5-E7
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:59:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e47cca387so65023095e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 04:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759838361; x=1760443161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hO9yGaxXzTG2gwFjTYZH03NNYv5TSgIxXzEY1Xo45ks=;
 b=RvNFBd86ZcPlQQ6769TeV8wOtQtYDbtK5HhwcDNdeyEZ/lgEWUfYUoG/gzpEm1H8KH
 w3n6FYwRVst1agl9tfFyL8ww2YT0Rjf2y2NPl6yB0mMJjqnFrb0aVAWmoUXLoelTnOu+
 Rh8EXRVB4+vG2wiuK7Yu2AaaEySLxrPl+B/8mg5ipN5cnJ89z3+jnRnxsMf2l8s5qyMB
 LZVydkyb5VyCeUHh8WZ25Owt4GYw5qSW+MTs0/qJRuqHwOz2nrr+N+w2HcQEYHciABMF
 Jg4N6nOcQU14Q0EnKWEHGwxCagCQw0lsJN1mIKmLgUgqbT4IpKYPGujkJmwFvEw0O4MY
 CdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838361; x=1760443161;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hO9yGaxXzTG2gwFjTYZH03NNYv5TSgIxXzEY1Xo45ks=;
 b=gRYj3s1gqat6G/obeVV5I4dpRAHilC+suzEkw8H4k5E8sqfiIx2lEGqaaKAXIOi0d1
 geMot1mNimYETB3t7zaIYvbYiUUzSVSxl4W/GKf1Jwt8JGyq2H38TPBmfxhMbxQ938uT
 8MMss2IOFX9TaB9kMLzfdo7INsokuwcLihGSBRVMPqrKYW1Owporlua1lHykpKTWOL80
 scqsnM0ZnqsUvVMnQ0co+ztrCPsBsovvdImCgBXAZUvl1WDw8BRtpZ/3m/u3rSDtJ9Ac
 ug+sqXtAUpQH0kkSxz7ILPgbMxaWgWwGG5GNR7bUOQVr9h5Pb8d8BMALD/APoJG7R3WW
 BTCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYmRbulDGVNwdhLiyUxwDBP7Ubb6zIk6FOyCT/f90CVTA6zB8qXLoQX2MvN2txvcc/q0JbolO3r7dt@nongnu.org
X-Gm-Message-State: AOJu0YxyOLCpjPqum+YlRKiVpXm8atTQYiXKGogiSWhiTr2UBJkM+K7P
 zy7VcJZH75PJTl3ypiDRt0y1av5OuP22Fb2+ClQKnTjnZZOPOFakleDae0VOEykakf8=
X-Gm-Gg: ASbGncu3xKJMyjwkPtD2ug4douynJ+8DsulRh/4Tu+K/XHARMFKEkWalM/ELCYmZqHf
 Lx6/AybCvZ3ENnGa0MlWrzBjbppeqEL2ts/esLb64L3OM2VmHsgN9Yk1yjsQ6qUsO475EsZglO+
 fRWmwnvtgMECeaPwuWluUOxTuHGEuR1Z4J+eEDKgh+LhtJDLOik8CgvokRLU3GWCrhu6Ojr9KRT
 LH2deL/SOyjYpx05zofE1cciToFkz3SsFF66KnzY1lwnQf1vSsyhoUYofrqM0iSbf2/mYiOEDjE
 bN3muO5vZTZTJzFfDUrsSvVQnbXSwPPjv2KVovsdLCsdDwN+FXfpexeckTmcb64dunFjzU69BnF
 JQD37EtUGhyH1z6YyMlkDo5wJPeByJxhhQgPSZ5ALh6sy2fTJHPkG6k31FOWaIgWpijUuYryTrX
 kRtIwWApd0VaMIfwFNr1RUrTHAjPBp
X-Google-Smtp-Source: AGHT+IHJ7ghWfb92B3+cRjdyjhwLYhJ4hlUkwDOw5pZ1L1AUvuhHIGaELKT/HaCGjHvdo5JgC4nrIQ==
X-Received: by 2002:a05:600c:1f8d:b0:46e:1fb7:a1b3 with SMTP id
 5b1f17b1804b1-46e711457f8mr113826505e9.23.1759838361589; 
 Tue, 07 Oct 2025 04:59:21 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46f9c8873f1sm100260185e9.8.2025.10.07.04.59.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 04:59:21 -0700 (PDT)
Message-ID: <52e5ccab-7855-44b5-9035-eae463ac06cf@linaro.org>
Date: Tue, 7 Oct 2025 13:59:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 22/25] target/xtensa: call plugin trap callbacks
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>
References: <cover.1759744337.git.neither@nut.email>
 <1ea18c5c484ca0c1fc11738a3033cdacff3296e3.1759744337.git.neither@nut.email>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1ea18c5c484ca0c1fc11738a3033cdacff3296e3.1759744337.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 6/10/25 11:59, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for xtensa targets.
> 
> Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/xtensa/exc_helper.c  | 6 ++++++
>   target/xtensa/xtensa-semi.c | 3 +++
>   2 files changed, 9 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


