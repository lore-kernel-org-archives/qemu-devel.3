Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A981ED41D68
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTjXA-0008IB-8v; Thu, 11 Dec 2025 11:28:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTjX9-0008I0-8k
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:28:51 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTjX7-0002TW-NV
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:28:51 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7cac8243bcdso167151a34.3
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 08:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765470528; x=1766075328; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BXUcBOtXHFZBjKGwB9YfvorN38NhNaG/ae6xbMhDPDg=;
 b=FHKLfeKnB9TedfDPEnUe2kq3MZBO/YL3sPWmQYwE3fZys8OucWJISkTqXa5G+ESMu9
 0fibqmOU9bahjwv8H0B5gJ1sk5s4OI6bvm/hZXbursNmeg4OXmqVSnyjHKSYs5HFn0oH
 MShSoTcadDRGNkV4XGAjG11POdxkeTZ3QdDKpZ65NCsIBHkrZoE6vMDtleUafSTSOhSz
 G7XHl0TDA1x3pzabGDAzdFyvB73yPLlhBXw5Ln3LTcbNQnDBc5E7Wpz/9PT6SnYsNFgu
 VAUsqdjd6ilZUDxcC7hTnv1jIkih40kcXHF0ym/lusl1zPPmK/OTS11HqBIO4P20ldln
 2d7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765470528; x=1766075328;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BXUcBOtXHFZBjKGwB9YfvorN38NhNaG/ae6xbMhDPDg=;
 b=Nox8LO/dFkUTkOzoexQn/CiHqYv9IkOm8gMpDs7p3c5o2jvLIPt3huPARaBSggy1hp
 5z8zVkha7WzLVW486X8QnwnndIc8vwW0d5LekedtvWyDohvXwBqQbf1Sm6La6ZVmx1TS
 9sN3x331/HkfPIVzJd80lR+7oXGTgXUDGQ7lxAUvnSzh7jg2FVtL6eVk+1ZhSuGYHQUk
 UaHCxCc4mKKn8VUq0djBbS4QCgOldSgxvWrV2rG9ReiBf8RfTxpVNMk+X+oZ3vfUywCH
 yxJz9Ycg5b1VCGej/vAjnDi6W28ECYUo/9T7DEwBO7615iE99eYvQvDShV5DpdJNAmE1
 5wtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPx+hSSv2hQCZ42RBmFpew05dNKCFk3wmEIrC/fYp8tbGe6JsqNsx8CFPxnRj4sm4UEjHXT/ALzFdX@nongnu.org
X-Gm-Message-State: AOJu0YzQFuTLurXauynl5Q4jT5Jzc+Gj0EUROvN6bumyt2337J4farwP
 aQO+QQlIAawSyOZd+yKQFZSZuUzsoFtFU4dRAXsHNPJmcJgsWvb3GSzaUIl7YJFmenzciZUimF2
 MwQM4Gsk=
X-Gm-Gg: AY/fxX4JeA4PQzCJM+urB9uAwP5ma82sbVC0GgP8UQQyt9kzT3TRKsUeTPTCH8egjwF
 JY63kBwZFLdQrRwCYTvnYWboeMCIHJ/LrUetompRMAvv/Sez1EZh224P1vd/VSZhlHZ3V5i2Bal
 1A0b2oG++q6EjPVoOCeeP1shKqz/IEozwvhxpFKynde8z3uhdEDvccSI0oo4TcZE89ed504hYJl
 JfMgqrAiWUilcCgohNGCA/lv8VOXF8q8e9srHMqo6E0KkUkUS6mSNiK0Yo3Ay58N+vn5pINk+MK
 ufbkNiyw/aXUWyjhynHQZ0rIQJL8WpQ9yzeKu9dv9t6PP/VSaTWqhD2Y8ITy2ihiIUdGCDR/XsE
 ALraqNJD0lIGa/fVqHC2SQgE4OaU+we7IYu+JOOKI9OPnZ4biR88gk916x5Fp/enfFJKYgKj19y
 Ggkr09NxJe3GVG6tDrBWb2rdD9bYSk5NrEAA9qOAS+e1apzZwKgBVg2kzbt1j5rHfM
X-Google-Smtp-Source: AGHT+IE4R/+7fvs2mwbPpoEGcOdufmi4BPCK27ORMCsQ0zXjLuFC3c+mqs0DaEFPMwzf0VCgEE3wrw==
X-Received: by 2002:a05:6830:2649:b0:7c7:8161:b7bb with SMTP id
 46e09a7af769-7cacec5fe5cmr3596004a34.35.1765470527954; 
 Thu, 11 Dec 2025 08:28:47 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb1ff5ffsm1740568a34.9.2025.12.11.08.28.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 08:28:47 -0800 (PST)
Message-ID: <23e74264-b2e7-41a6-bc3c-3ec7333a235c@linaro.org>
Date: Thu, 11 Dec 2025 10:28:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/18] target/i386/tcg: kill tmp1_i64
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-15-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251210131653.852163-15-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

On 12/10/25 07:16, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 66 ++++++++++++++++++++--------------
>   target/i386/tcg/emit.c.inc  | 72 ++++++++++++++++++++++---------------
>   2 files changed, 84 insertions(+), 54 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

