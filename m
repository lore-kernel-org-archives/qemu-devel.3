Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABC9C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 15:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Qnb-0003ij-N6; Mon, 28 Apr 2025 11:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9QnY-0003fU-Hp
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 11:53:36 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9QnU-0004sh-Ek
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 11:53:36 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso43050665ad.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 08:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745855610; x=1746460410; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eQlBJdnxtxpKDLustuiX22zJ2ky2yazku7Tu+xOCF/0=;
 b=HFg3JUV9oqdPj8s92IYKm5QfCDe+CLOLCSv0ugUs3YoB1YF4qyhcuqbAgoP74A8nOi
 V1vnsgk1fGN0HfuFpKvrR7k1s4U4Kl94/63TcLIaEd5sM1mrpP7kTJcFoVD+ceMWoGOM
 wJLeZV0Cny1Tyx5UScFLq8gLzZssw/laddR9TfOOVO1HLCL4BBLPA5twZB2L1XNmVjkD
 8JFKjOozpa8tK1TMMs/NgcvGojg6QSwDD/pQgTncVqKgq5WU7Gx0Thi7ejMwSCuk9UxL
 WI1G+6qm85QAEbBQW0sCA4zlc0w8aoC8QTXKScOTkab93QHklwF+kOwaQD+H4PQB53cv
 bGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745855610; x=1746460410;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eQlBJdnxtxpKDLustuiX22zJ2ky2yazku7Tu+xOCF/0=;
 b=R56WFwuR9bQ7VYqIURgP6p9GhW1cBUUCsOKMIPcxgo6IZiYT7fcD7C1ajdg7GkQ4Ch
 TQRV4q9rqo4Sv/0eLMGpkCUp8N1T5NVRU0akEvsJQYDoNsXCKKCSxQsfmAbBkUOFkujh
 OyUKQVc5KxsQBSiRxG2EIfHoPAG6GxyJ0wQ9hQd05Q2XpqyW/Kp6yhTALvORnBw++qBY
 54JHSBbVvTwa0mgiIeMRRWgvpx45N7GnZVoSey0/uwcMscQ+wHJKfqe5f5k2+8AS20Hv
 YxEwLblCA9VXNH5i4GxrZKgZYH4b/R+kEtbxAehv612PvGgBT1wzjSiMLUngrYT7Vbhm
 Axow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlWPA1d5n+mrF9XoVwubhOo552ZO5I7Lhmcnpodi48PAeWUjxNinC5ZP8anfqWMZLLQfMpFlthKeqX@nongnu.org
X-Gm-Message-State: AOJu0YxUv10i38WOUMqSkNQg5DQ0cDdrygoRSQLs/F6M1kJ12dkCWGnn
 9XKeBTrPdjGjpKXnMPZZe/EJTA22s8OrtZxgGMgSNj3z6udUFqfKIjvVEnJRyWc=
X-Gm-Gg: ASbGnctbs16ZcB7lL13y/dqMYFo2hm8v3EDsfFHy6zOXLGfmhfEsHMP5oOiki9omCQP
 jW+bWN9NLbDhMug+3lB7y4ORGU+tf87g882bTGRayJA/3Tbk0ssB0v8bNwmXkczQwI2h5lIUeuv
 X/fkBbrBkvRTYjopxMdKxbSLq5nnCA9VCP/THM6Wjg0jlvVbM1/XH/1pPV1cV0FmmhM2jI6Nt+6
 7rCMMGbOPXE4u0EC/3ZrJc7nVZ3SVqQz/00E3o4bKczTk1HfpJUORRzElW9RI9QxBoOFlHgijjH
 d9qO3xSZ9j2B/9w6P+TmTVlI4yhs4N2zGPYSWLGEL8b+cD8Lcl9uzxzrIFfGpP/ymOLzeL6M1dv
 usiw1INc=
X-Google-Smtp-Source: AGHT+IG5R5YrVbhsBygDbTJW3RBFNhnxwZ5J7uRjEbmzF/HsFCfqXXh/EKX24bZJlDtE6Lar9+c7CQ==
X-Received: by 2002:a17:902:f68a:b0:223:fbbe:599c with SMTP id
 d9443c01a7336-22db4981ef9mr225411165ad.19.1745855610370; 
 Mon, 28 Apr 2025 08:53:30 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dda40fsm84483705ad.104.2025.04.28.08.53.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 08:53:29 -0700 (PDT)
Message-ID: <e6d50cb4-bdd9-48d5-8bc3-d8280f09baa2@linaro.org>
Date: Mon, 28 Apr 2025 08:53:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] include/system: make functions accessible from
 common code
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, philmd@linaro.org, manos.pitsidianakis@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
References: <20250424232829.141163-1-pierrick.bouvier@linaro.org>
 <20250424232829.141163-8-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250424232829.141163-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 4/24/25 16:28, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/system/kvm.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

