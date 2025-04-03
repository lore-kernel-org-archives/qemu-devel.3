Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BE3C3601A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0McW-0003zz-6R; Thu, 03 Apr 2025 11:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0McT-0003zg-AX
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:36:41 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0McR-0004xW-Ip
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:36:41 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-227d6b530d8so10791575ad.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743694598; x=1744299398; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XrClrizAdMP5KVBktG+sEc0T7eXyhG22MngZFVsDqVY=;
 b=PcyFezZSOXQYISxbkbUYhvV8gajHcCynshjNS6qyjAKZjDGFbeTju1QUMIf6epmK6I
 SkouE5CyRx3fjGXBO0g+dzjVgxv6HKI0qGRz/xVSdiN6f89TZPBZsrWsdGx/DQVjI8fR
 SKpanaj8QL89wVTDboae0RCpBvXqeWoo5Nk+pW39ssNnA8ka1vehg8A+JUzy+IB3AroL
 CDH7yYyt8/3cfuD9zpJIzHNsQW7cKcQDECYNVkaClK2k2NX0UvRVwC8/BDb8Qg8wWpGJ
 AsbNaHKkn1wFeCCcxNs3pwztLOaTQ5chsYlXKJWXzrkzy8/5zy4WXAQseACz7sfG0tsB
 8IPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743694598; x=1744299398;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XrClrizAdMP5KVBktG+sEc0T7eXyhG22MngZFVsDqVY=;
 b=BNnW00t4b9pViQpIlH214kgGK0cXLESJ9ylfOp+KW+7ohkPLfLT9uRFWwnNkFPRIsr
 oDg3BmNxHfiSAwNtv0JSL1TCFmJfqeUn06Bq59fIMUXVWVFjdhnX4/d7V3W4/LHsTSk8
 zhde1691iY24oLvBGb9xxokt1HY6W/5E3xJ8sc3i4rIVNnylfgW56tE0bId0u89++WVc
 Fw5HY1cv2mDaz1F01aRLXefpRieUveZAkYqpGJK+5SlbKmMpllsIHpb0efmvmHu0YkKy
 Vou/JgbCZSgwbYkP+hNklSP763D/IMcvKmYw44bAMAJHiTlaTljZUl52j2rP27xwMup6
 DomA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0vG0/VGZyvCbq9g3+nJcoAN/tRunHoy+Ck3mnofRo1uoYL6S7gjYhuv35TaBIBChHTTkkw2q7yNYT@nongnu.org
X-Gm-Message-State: AOJu0Yzm2WpPWqEsKyOKbB+VnIQ3owW62VjXhg4SH5cWoTQAefMeh8yB
 naKKu4+34TSPkf5a/t7TmnUXq94Z70ZQPYgEhWZWULGgHebiTaSnXwz4WPrPN/o=
X-Gm-Gg: ASbGnct3kvJss9qFR43KB9PsR0UOXv2cygM7KIWZ9zURE9OvUuFeJJ3Ea2Hn5JD4LPc
 AhdUK2nk1ifK6vb1Sfn/h7TAX3Tk0cfrEFlvQs8DSOuzWbs2hbTBo6E1MMqjrpAfKUoXaHcmsNi
 w3qNsIpVB2cLIRRdLHWh62LqUzkrZ3wMGfZu+IyRJi033mr0n+yqorZatdecHQSakc3EEMktTN0
 4xsHy85QAPUfJ/kVHPqPs+P+mOo1YwWiYp90H9JzW4ZJfsmaZ3scNR7NvlyzNZ0cFzbL0pieHZi
 um5ISvd+1p9wCozhGNxR2R3NDB5LuJ8WH/qQv4KAncMmZ/B42WGYYDawqTTVMoI9lfsSlbTQRwM
 ae/m6JX5C
X-Google-Smtp-Source: AGHT+IE/9bkrLyVSbpyCjyGTLz+ClQOQU9qqWMjWlIETMCoRYn/p5OTESGEX6Nm1EKvz7qXlKexBcg==
X-Received: by 2002:a17:902:c942:b0:224:1c41:a4c0 with SMTP id
 d9443c01a7336-22993bf68d9mr38710055ad.9.1743694597799; 
 Thu, 03 Apr 2025 08:36:37 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297865e97bsm15959045ad.119.2025.04.03.08.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 08:36:36 -0700 (PDT)
Message-ID: <bf4dd94c-7020-4ebc-a2be-c36bc1f68a42@linaro.org>
Date: Thu, 3 Apr 2025 08:36:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 42/43] tcg: Convert TARGET_SUPPORTS_MTTCG to
 TCGCPUOps::mttcg_supported field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250402212319.58349-1-philmd@linaro.org>
 <20250402212319.58349-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250402212319.58349-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 4/2/25 14:23, Philippe Mathieu-Daudé wrote:
> Instead of having a compile-time TARGET_SUPPORTS_MTTCG definition,
> have each target set the 'mttcg_supported' field in the TCGCPUOps
> structure.
> 
> Since so far we only emulate one target architecture at a time,
> tcg_init_machine() gets whether MTTCG is supported via the
> current CPU class (CPU_RESOLVING_TYPE).
> 
> Since TARGET_SUPPORTS_MTTCG isn't available anymore,
> instead of emiting a warning when the 'thread' property
> is set in tcg_set_thread(), emit it in tcg_init_machine()
> where it is consumed.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Anton Johansson<anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

