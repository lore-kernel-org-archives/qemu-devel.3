Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C29D1D493
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdweE-0004dI-DM; Thu, 08 Jan 2026 15:30:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdweA-0004bG-Jb
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:30:18 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwe8-0005Rh-Jd
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:30:17 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a07f8dd9cdso27186975ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767904215; x=1768509015; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4QsFoHppP+UKBgxOVKmvRxqOsUmnLNyygUI5t2IzMYg=;
 b=Dg3ZIbgpX1T864amDC7urVkPANNH7lY7Wk8RVn+64avxB2PMFzlZ8XSrh0Bnz7tSmk
 IsCb5nASbnJjJyVA/TFErNYbiVXbZ8hZt1jYT5Jwi+TzOtjrLXLy1BExWBT+IF0i52Lf
 rmi9WHr6gx1qKutKwB+YJa6u1zJvCYTQGU68OTqnoy9avaHoGPafqh50hl/v5h3+tunm
 XLXptEN9woYTO3ZVSS14ejZ0UNMiTNY7riI9cnBlMdCs8ZtFRwltI+kJQuG2wgfLN4Em
 WKqRuCFf+yrZ1KiQIVA1Q16gQ8NqCGORuPw/KE0ndB7JWiUw484wwZDrFRWT/sKFQmn/
 VSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767904215; x=1768509015;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4QsFoHppP+UKBgxOVKmvRxqOsUmnLNyygUI5t2IzMYg=;
 b=jxVPhJUljAFkrn0i15XTJ+Ke7cnn971uKkJH0QylLTpWt8YV4auxRls7Botxlvv8K3
 TVfGbhT4B9ayQ43yPMsrh6RRWl5CN3NYPZjtqexYILpIHwCNOFfby8wtNUIbyJ+Mnxei
 AEWphrdT059fLTAyiRd3bxz4+HVWoUBFPn5WueG12oIvsVD8whGQA7XDHjkxMuEGNG2s
 nu7N6Ej5+CNrV7wA19F9bAMV7CZxzwzd1J70qOygcRTqZbvVlrKzzqiAC11QEiPBAw69
 PMfj/4aS8ZlDzrHmCWhDqBj8FZB532auP06Fqxq8QEhBaGQI8VIEp1s7aW/I5WSVL1R0
 3OoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRiDDuU7hLvrcNmIYZsFCki6mkVEKLVx6y2kyRB4SpdroX59tdnHyDTCOgzGSMwnuW54zkQvZLwF16@nongnu.org
X-Gm-Message-State: AOJu0YzMY0QIWBIo/3hRUIeMz75vCFlgtJRqxuG8MOKupYQAfLK+3nH4
 ujreid8+WTINZUwqGEH93ZQi1f5+//sb5XBUYyTO+JKS83jVLA95eG0415Qm6pwej+xiw0xk6hy
 i18he
X-Gm-Gg: AY/fxX4mKeRtX1Tmme5jcCCzW9dsuS88DvfqubswkaYiYZ3Ews0v8oUmjqb8RVUAnfm
 QobQGLMamnCwKBxhPcnsW4TTlUlRgqlF6cxyd/LCqeShhYwleYzshlaGlJ3ShbVf/2wYV/lEyIj
 VdObNMUXpst1jp5I+j5YkaFZ7qVotJ0YbgF83br86UtdK2eFlOiyz0mKp4Y2srhPfDbcRoHZUQK
 pCxkcOwfeVDQ+deYJFMjRnfFhGA9KDN/oVX+glK4nJTJ7XQW4kMCrjlA1SXb9LUKIdXAIYJH85v
 7EZrop7wTYm70+h5ehBZcWNV7Whl5iOMPz82VIddqaSGuifK5idg7Q7tjMoRkZcStak2+PMMFR1
 SIZBjBdm+p5R50Hx1xIHnDeKSWuiviZmVMS1t8Hs7h4SdbnwQ1/+YAtxikLW8Juy10P22BkU/9k
 UEmnkJyu0spMGeXcu/PQbBN7Mpe7nszxWjlg5QQiEstpf7y99mcn3qNo1FGpKJ214x8dg=
X-Google-Smtp-Source: AGHT+IG6zfRUi56iEzOjnxTsJ7K8xpsIKVkGASaGXjHxQU2cyYDg9CkGemIaTlwYWBwKLCp71I2OGA==
X-Received: by 2002:a17:903:2ec6:b0:2a1:388d:8ef5 with SMTP id
 d9443c01a7336-2a3ee424ad7mr67530795ad.19.1767904215035; 
 Thu, 08 Jan 2026 12:30:15 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cd2acdsm85490565ad.89.2026.01.08.12.30.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:30:14 -0800 (PST)
Message-ID: <e548ccc7-8c2e-4882-a490-03891def10d7@linaro.org>
Date: Thu, 8 Jan 2026 12:30:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/50] tcg: Remove INDEX_op_dup2_vec
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-22-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> This opcode was exclusively for 32-bit hosts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h |  1 -
>   tcg/optimize.c        | 18 ---------
>   tcg/tcg-op-vec.c      | 14 +------
>   tcg/tcg.c             | 94 -------------------------------------------
>   4 files changed, 2 insertions(+), 125 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

