Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E684DD46BF0
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 02:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlHmL-0008B2-Lp; Wed, 28 Jan 2026 21:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vlHmI-0008AV-9b
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 21:29:03 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vlHmG-0000ry-O4
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 21:29:02 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82311f4070cso306332b3a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 18:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769653738; x=1770258538; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mL9XUgoHO1ryKkr53p5djzY/Q7BJjvZOj1NMg0iFB9I=;
 b=ra003ca6oFwIU4J4jdG5uuI509/EYPkKjtTAbnewFV2avupYrOCMcIDiLrgtc1PFOn
 5P6Hmte0hzyybQtrsLYv7IgeCAXu5zqPzPcv6HgCSwjCTdk7vmKKPUDZgsWneF7IeS0o
 CAt1bQoDCjCciwRlz0lOb4U6G6tM8MjhtfC6ORGz18+PcjC0Qjp/cs5rjgZJaBz240lC
 wjU5SAQLzyDEgdgqqV02GMOt+5YYsWFBnnJvzkISJR9P6JHivkZXcWERQkSOg9TqLuVt
 gvtX8DnLMQjHq2YyFVWFCiFZ/i0jwbZJwgGVedLhK10Rfwkq6DtZT7myXZhDhnswTtxc
 cx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769653738; x=1770258538;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mL9XUgoHO1ryKkr53p5djzY/Q7BJjvZOj1NMg0iFB9I=;
 b=ZVF7lUXtV0JOUwlNfQD684d/revczqGRsErj1q1QLxWTljQLvpDXX9L++8Xdc92FLH
 Y6ZVPxLxhoorHS7GDgwAGZ3IdCy/LVWVvsSfBp/ElnbBoxBOwwZh8hhYJkqNkW1Ui1Bc
 du7al0/KHWIEE25aJZOisKOm1o/hsmYV/QnLRYE/2c2pWIMSmAq8/joq8vPnxJUxs/Tu
 4/dVhdGUkQNmohqdRDEpQ1KHmHVcSf5yRrhMglgDI/irD68tPMkJcluK24uiYLxC0U/V
 TPYMNNsbE5eHjBve2LrmvaLVUqEBHf+Hrg/mbDqbn6hFe2NBuU45nwmXVi9wh9h3xuK1
 2WWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCuwZYTJ2jGIqv6r57c/hUy0M6aNGeq5WhK+NpddxaLcV+a2d9qaKraTMD9EbTLgpaL5EOvV4l+GV5@nongnu.org
X-Gm-Message-State: AOJu0Yz/ubQN7uK6O7w7YgT/2O8SwglcvZkyziS+Kf9xqTy3OFaJijDP
 U98d/Hd0mZ6zT/7V4Uj5Uq97FyseXE078BsNdBB8RUFNMmmM9dNLcdpxbKgs3zFiaJY=
X-Gm-Gg: AZuq6aKxMBP5Srsw/Rv/jo9BBEbNQWO/uPp9ouPje7yvrZrjI6fkkvgREqaBbpJwc1L
 LET/Z58Cqkz6sKUQx7EDuM0xUSg/NujrgVR2F7RTEhMpc7m4odYNiYytETub3rdzjzAu8iahb7T
 RRN4+JQY9kZeWfYTxYnG1CjT2hHhn/4pIQzcsE7SRLaVbwZIO6yxwiK0r+zDDq+7N9ZMycMWjYs
 XXtFIyrCyp+l1uSvhwNMnjsNr7VNQCdbNhGITq6yRK/cslbUcXqcTRqCNiWUqLgW5ZV9KpSczuS
 O96cEV2BAE7U7LGaUwcDlDok18AK2vZJ+j7EH4HDtgo1PqMG/kqdwO+bpTUN0zMAtKIAckGqfir
 F5DIQCjHd19HIIW61PAeckrNFwHZwzOYB4aWgiOsFMN6qkzXdHj+Wu+aySRfa7nR+Pfs4+z2dur
 Rn8+3eUqGtlHSu4qvv323Pk8777tG+uw==
X-Received: by 2002:a05:6a00:3e26:b0:823:5729:a125 with SMTP id
 d2e1a72fcca58-823920dc8edmr1013559b3a.30.1769653738470; 
 Wed, 28 Jan 2026 18:28:58 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b1f188sm4377691b3a.13.2026.01.28.18.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 18:28:57 -0800 (PST)
Message-ID: <a44ba710-25ca-44c2-bcdb-db917efaaaeb@linaro.org>
Date: Thu, 29 Jan 2026 13:28:53 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 06/20] linux-user: add plugin API to filter syscalls
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Ziyang Zhang <functioner@sjtu.edu.cn>, Mingyuan Xia <xiamy@ultrarisc.com>
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
 <20260129013134.3956938-7-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260129013134.3956938-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/29/26 12:31, Pierrick Bouvier wrote:
> --- a/include/user/syscall-trace.h
> +++ b/include/user/syscall-trace.h
> @@ -39,5 +39,22 @@ static inline void record_syscall_return(CPUState *cpu, int num, abi_long ret)
>       gdb_syscall_return(cpu, num);
>   }
>   
> +static bool send_through_syscall_filters(CPUState *cpu, int num,
> +                                         abi_long arg1, abi_long arg2,
> +                                         abi_long arg3, abi_long arg4,
> +                                         abi_long arg5, abi_long arg6,
> +                                         abi_long arg7, abi_long arg8,
> +                                         abi_long *sysret)
> +{
> +    uint64_t sysret64 = 0;
> +    bool filtered = qemu_plugin_vcpu_syscall_filter(cpu, num, arg1, arg2,
> +                                                    arg3, arg4, arg5, arg6,
> +                                                    arg7, arg8, &sysret64);
> +    if (filtered) {
> +        *sysret = sysret64;
> +    }
> +    return filtered;
> +}

FreeBSD build failure:

https://gitlab.com/qemu-project/qemu/-/jobs/12906481914

In file included from ../bsd-user/freebsd/os-syscall.c:34:
/tmp/cirrus-ci-build/include/user/syscall-trace.h:42:13: error: unused function 
'send_through_syscall_filters' [-Werror,-Wunused-function]
    42 | static bool send_through_syscall_filters(CPUState *cpu, int num,
       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.

Why is this in the header anyway?  If it really *should* be shared with FreeBSD, then it 
could just as well live somewhere in plugins/.  If it really is linux-specific, then it 
could just as well live in linux-user/syscall.c.


r~

