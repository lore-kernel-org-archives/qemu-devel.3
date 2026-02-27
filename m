Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D8F104891D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw5tT-00006L-Qm; Fri, 27 Feb 2026 17:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5tS-00006A-4D
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:01:06 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5tQ-0005SP-Ii
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:01:05 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso20052065e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 14:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772229663; x=1772834463; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=trSDE7pd39gnBsa+dl0LZBIcXUIYPLYUecv07VK9dXw=;
 b=kvCsV4sXrq2lkFADQKEFUwOeoFsYBwUTpU2NDDxnpjuhFAMGktKjaU/7N+CKnkHlw5
 aEqAP0OShEJcMx+epPlLtwW3YpjU0LzWXfzVR5/8ZRjbO6Oc92OJIATL8SnuV8AxZ3AU
 MInEBsflxrDA14RGT6lBs+qXE67pl0C+SjkwQZ+8db3xl6iooXUB1ZeIDUyAozqdz+q5
 1EofLAZwIfoOMlpgx7h+k5/pFvAQ6G2XBTat3cOeb4fUdTFqELZ/HQu/ZNLKBntiawgh
 BBXmkUgIl3udYGZYK7scGGbjFntccCdwW+NO6T8xdHzgWZUQ/s/aqL5/tjipLyUDiaNt
 OZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772229663; x=1772834463;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=trSDE7pd39gnBsa+dl0LZBIcXUIYPLYUecv07VK9dXw=;
 b=JikxdmDIHS7JLu8lKP2z8CeI/NqTB35X/KCRGt8dDvx+nsI0FDIsT1+E06NxuKw+AE
 qWZGXDOpR4HgBwQi0PBKh0gljmk1h7Kvu4ZUzIYI3iazVblQMoOr4LUQCTEoGUSOoLF1
 AQOPUqoZ/lLJywihs+DsUc127aGLZ2E2t6nXMf9SACIVBkRt3YoSTBt6j80eRQw6eZjR
 EkXvJVCOj3rkwx8nQEfsDBoYn/jhacFaABx3WgioHRMsZ6O6PQYm8du/qkXW5px1TZwh
 she4qPN8U/wgdeoeL9O9Zslk9a7v1VWUqx2OEbtAKLx6oH4Wf3w4nYqXi0fLciW1s5Bi
 OGcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSzU8D/MyDDxleo7vsGxQaM48e5QZxW8Ua4Y5X7dQwzKFJvAYjk/qjr1GNSZJakVPZ4Rf3S3foiSiz@nongnu.org
X-Gm-Message-State: AOJu0YziQmQhEfHi1xZIx35GzqL9qRqnlQt4f03h9IiGRCcT9jj3S7GZ
 7kzqzPU2qFgj/1hF9qhTb1MxH3iJtg2xuqsxqxfQWqJfO7OcQFI5q/Xa/sqpzDmQwZ4=
X-Gm-Gg: ATEYQzyEVgoHzfpZmMy93cTN32X86+pEjPAwJEdzHAZd4S5LAyztF7IKsdamMFZ1U3r
 /gX6xK6PExRLs+1YgvqVLDybKwiUNc8MNKlWigLOL+fnflf3l7M6Yfm2GtczWL0tDrT00/4novo
 y7caxJHeP/pFdELKj0KeMvSfyahodMAHcXNJ2mmKGR4Xo2bUa+7iBdB9PWMrEPBN0G+/Gx4LDJ/
 xtPJ/cyIpBprsft8ayYbp6UVEfDKMNfu8NjM5ndspiY9QGxvp39YkLiQY9fHgHDfO58nL8cFoqm
 zmBPmOyUVottekZEZor+B7RHvQ5F8xeZX+PR5DKFB0HW1k7yUyVKBXenmemlb9xfcMy+HnyEoXw
 0QGQZADhNOywQDhW5+EPYvEAa4CPgx8FzTnjLdvZtWlVo2+TeF+iq/eC3gkKXtxBxDIrvVLP+li
 khtvZWQ+DeivP40HTaEBgNSn2AQUXtINffOgTuUYL8nn7wHxt3492FFK8XQABpd1eWcw==
X-Received: by 2002:a05:600c:1f06:b0:477:55ce:f3c2 with SMTP id
 5b1f17b1804b1-483c9bc42c7mr68080365e9.14.1772229661557; 
 Fri, 27 Feb 2026 14:01:01 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f3124sm235980485e9.1.2026.02.27.14.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 14:01:01 -0800 (PST)
Message-ID: <1ffc80ba-de20-4957-b506-453772ed84a6@linaro.org>
Date: Fri, 27 Feb 2026 23:01:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/37] target/hexagon: Add memory order definition
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Brian Cain <bcain@quicinc.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-11-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260227203627.932864-11-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 27/2/26 21:36, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu-param.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
> index 45ee7b46409..ccaf6a9d28d 100644
> --- a/target/hexagon/cpu-param.h
> +++ b/target/hexagon/cpu-param.h
> @@ -23,4 +23,9 @@
>   #define TARGET_PHYS_ADDR_SPACE_BITS 36
>   #define TARGET_VIRT_ADDR_SPACE_BITS 32
>   
> +/*
> + * Hexagon processors have a strong memory model.
> + */
> +#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL)

This definition is poisoned since commit 98c7c146988.

Commit 7dc2af9786e ("tcg: Remove the TCG_GUEST_DEFAULT_MO
definition globally") already sets
hexagon_tcg_ops::guest_default_memory_order = TCG_MO_ALL.

Maybe just drop this patch?

