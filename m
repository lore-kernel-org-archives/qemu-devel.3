Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D7CCAC5A0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 16:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyuwf-0001TY-J7; Wed, 17 Sep 2025 12:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyuwd-0001TC-Kb
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 12:23:47 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyuwb-0001gc-Kl
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 12:23:47 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-77ce812f200so25048b3a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 09:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758126223; x=1758731023; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+2ZHD4I35dg9NpFtArXWRXwnmHPkc9txZtW5XaArP+c=;
 b=FsLq8sjFrCgreyxzzsQLDIxixu7cDwpFgPjuY62QdU3Pokhz4WUE1IDvY4uauYILpK
 Qxgf2pyZPxBXDNp1f4VoO9XfokkZHu39R9XMHcbhAYghn5XNi/vIO/uNhxWBfqTXtSb4
 BiaSntNx138mrvpR7uiVqlMv+HXN/c4ELe6533+/aZZJDAccxZgfcn1VstnvuvZC7CiL
 LNxRUsS2ksjQFYaS76ZyB8bW42DQk3JIqBN5852Zn4cy2xXeH9x5cBFzXl8s6XBh+y6O
 abUD1hqX9dYzgZC+YL6VAQj1KPhA0uDUgGVnmaRB+2/vrU7d4MEb+YyyWP0ew4lEzsVn
 7f1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758126223; x=1758731023;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+2ZHD4I35dg9NpFtArXWRXwnmHPkc9txZtW5XaArP+c=;
 b=ev8hpje++HhSX3x+B05FgzvqetY4ry+05qoaKeLQRe9LEELB/0/Cyjmg2j/nTQqtPt
 5D9x35a8kwW4pQnEEYCkiS/pf1IBRBYFUybsdiQGJMVycLl8dk7SoDBtG3+KRlZr6tZK
 grsCjzVF2XszF050Wq6fxb9QIJMI8IjKhq068uArxMHXfBh7zpP0vxy7YNMjgWCKXnkR
 qwkNEeTiks/JyW43LauGcxiMCGCwdJvibuUTUixzy4ehfClBd06Qja0q+NfSUr17X/Nq
 I239Iv+DfB8BSDB2WHdzToQVPzYuwGVj8WUSvCsMP0ybOPjD9zcSCR7PAzh0w68no/7L
 /R1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9ZGJR2jvCfLBG9JspRpmYHqEICorTp4bysN/jvPXf/Ir8T0zWz4ClnZqo/CCJ1IAJEwgNkZHIh9FI@nongnu.org
X-Gm-Message-State: AOJu0YzQtHT9kXtKriDDo3XRLZMPrw4Sf2GjR8QS2CGpQLwftRc8Ji6q
 iTqFBie68p0q3imAZ1fP4fK3H/L+UMTepaRe3pav2Z/wyZu+i5Z9utqwHATxSMLllkY=
X-Gm-Gg: ASbGncsbRyT03fZqENUDyLm+QjYGuP6hx9ciZsTYJ6PLa+7c9STCcXoFKaCVsYYqJg1
 n77jwaS4g90B/GQIWOm+PYcQ8sv9LbUOzlVvTk8Tvq0lb/Z+KzQTut3DL6WlU6nqH5LDqumGV8E
 xalh7b8Ep/eKGxeKQfcAs+K/eECtm+zXRrliy8tzECL2aW1noldGcC1noqMRyU4kzpGQV8G2FNt
 adM4dgn7PgCSPupsrpaS4AWnBFUX+m52VtZD3PFLoRurKK23qTrEX1qaNUFsbgv1tXjIPgBFPOm
 2IP+SyBpEMcEYzJrpy8QCYFBbp/q9QOpSBk7u9T/OrGHodYDRwdTUPeFbX/dUsAbNDk1ZRQxWvr
 eAwSO6Daae8JyCWbW/yPmJhUHT5mkcCOP6nij
X-Google-Smtp-Source: AGHT+IESjN5oIDcr9BbewKQyqymH8f1mcMYrT37oziJFqszeqJdRydmALNMayqtW+uFaLa8VA062Aw==
X-Received: by 2002:a05:6a20:3ca5:b0:244:aefe:71f6 with SMTP id
 adf61e73a8af0-2845641b900mr257050637.19.1758126223272; 
 Wed, 17 Sep 2025 09:23:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b54ff41325dsm108147a12.38.2025.09.17.09.23.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 09:23:42 -0700 (PDT)
Message-ID: <3e8721f5-f390-4050-9621-7a0bd9b8022d@linaro.org>
Date: Wed, 17 Sep 2025 09:23:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] tcg: Fix error reporting on mprotect() failure
 in tcg_region_init()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 berrange@redhat.com
References: <20250917115207.1730186-1-armbru@redhat.com>
 <20250917115207.1730186-3-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250917115207.1730186-3-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 9/17/25 04:51, Markus Armbruster wrote:
> tcg_region_init() calls one of qemu_mprotect_rwx(),
> qemu_mprotect_rw(), and mprotect(), then reports failure with
> error_setg_errno(&error_fatal, errno, ...).
> 
> The use of &error_fatal is undesirable.  qapi/error.h advises:
> 
>   * Please don't error_setg(&error_fatal, ...), use error_report() and
>   * exit(), because that's more obvious.
> 
> The use of errno is wrong.  qemu_mprotect_rwx() and qemu_mprotect_rw()
> wrap around qemu_mprotect__osdep().  qemu_mprotect__osdep() calls
> mprotect() on POSIX, VirtualProtect() on Windows, and reports failure
> with error_report().  VirtualProtect() doesn't set errno.  mprotect()
> does, but error_report() may clobber it.
> 
> Fix tcg_region_init() to report errors only when it calls mprotect(),
> and rely on qemu_mprotect_rwx()'s and qemu_mprotect_rw()'s error
> reporting otherwise.  Use error_report(), not error_setg().
> 
> Fixes: 22c6a9938f75 (tcg: Merge buffer protection and guard page protection)
> Fixes: 6bc144237a85 (tcg: Use Error with alloc_code_gen_buffer)
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tcg/region.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

