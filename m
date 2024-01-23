Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C1BC47DDB
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 22:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSPKp-0002W6-CO; Tue, 23 Jan 2024 17:33:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSPKo-0002Vx-3E
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:33:34 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSPKm-00023u-Bb
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:33:33 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d41bb4da91so28105815ad.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 14:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706049211; x=1706654011; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zpKAFAZlHZYAs7Z1Z94s6N0555vzpR3MIlWpWFPkhew=;
 b=b/6gIyNoj5vAFUQWto9kAD0NbQ9RVcszYb3I8aUfPOFoRn/kju1jRGaqTKimxuouZB
 L6ReZUqxZPCUdgQ+mpC7Lo1xjkwCyu4aws7Y6aGK9jtgGK3Q7Xm7ZgsKQlFPpt1sNEc4
 0U0sbWByNQp5fjYBX3wBmRj0gMIqJqDI6cHbxMiSr5hvUDNi3K3m+isC/rOLMWYqnXhK
 hXAEz0QElIaBNadLjNaUR96FfFJTcliwPN7VAYxXEWIC6qWP0KvZGbMJOY061dlEd8oj
 iQ7Qe209oQbgypeOrIpa+swJE6xa9E5sZDTpj+G+VkHK9waaTVGmftfKP8Yxr4ZSA7Hr
 g72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706049211; x=1706654011;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zpKAFAZlHZYAs7Z1Z94s6N0555vzpR3MIlWpWFPkhew=;
 b=NKs09bmEkxtsQAeeWR6iYS4PPWFTPNYnNPtjGH6YDvL3Dx253AymZ/W+AaBVhgKDju
 AJE3HNlkQqTQuwkM68t/YGweGd71UvHlAlPtVAA3kpeWdFaxcMlCf82kZ+rNSE/ochpH
 dT/xdiYWrkBDTRwifswE4DgqI2gkcQiKG4icqEhck35cqkLwssIKIvsPyOtZ+pRRe1Yb
 mgTxw40pAFnj2UQld7DQ31B6VeP91wJWhZ1ogPPlqp8xYwRXYw43DA2LQsMI/LqyY4pe
 BUrUDygAEpuWWyCl/aGJL1oLaoqWJTPV6pakVAiReNLbdeeBsei+WHgxSv8HJUCBu1j6
 knQw==
X-Gm-Message-State: AOJu0Yzfgi5ttJ29RjWir7Zpl+chqBXMZ1SkfJB7AJv040BiXvaUOok6
 30EzxCBzM7CRX1YwRohYrwuklF9J2dEHtok29eRHAhuI7RhrBxcFKur2NG6lENo=
X-Google-Smtp-Source: AGHT+IEItXDOTy7IasgaDnrFJfZug7TuPqTRCnKOpn9IOCJ7e2i3dYapgm5w69MtWbbguL7EEUtLHw==
X-Received: by 2002:a17:902:c195:b0:1d4:3e0e:5d04 with SMTP id
 d21-20020a170902c19500b001d43e0e5d04mr3352238pld.98.1706049210955; 
 Tue, 23 Jan 2024 14:33:30 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 bc1-20020a170902930100b001d6f33c6541sm9297177plb.285.2024.01.23.14.33.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 14:33:29 -0800 (PST)
Message-ID: <6dccfc4c-1bfb-4355-ace7-b3f53957adc5@linaro.org>
Date: Wed, 24 Jan 2024 08:33:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/34] exec: [VADDR] Move vaddr defines to separate
 file
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-7-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-7-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/20/24 00:39, Anton Johansson wrote:
> +++ b/include/exec/vaddr.h
> @@ -0,0 +1,18 @@
> +/* Define vaddr if it exists.  */

s/if it exists//

Need a license line here.  Otherwise.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

