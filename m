Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D64D2502D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 00:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veirp-0007cG-KS; Sat, 10 Jan 2026 18:59:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veirn-0007c8-UO
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 18:59:35 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veirm-00051e-Fq
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 18:59:35 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-81f46b5e2ccso180680b3a.0
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 15:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768089572; x=1768694372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=woOc4sWM2xF5F12Bb27H4miY/eA3CR8x238+DGoEIrI=;
 b=qgWX0N02/Iz6zTjN5l2rAmIgw1cfYE/IPNeIz8VkZw5XQLsz9aqtvioo/WL+YUvBkV
 hsOBAo/XOjvL+0xKiJ1wHO0hieRY+3P9JKokpN122+CLg1VYfWRqUpCJUZvZR28ctPj+
 w1dDed7kMvOyO/FH+3Q9/jotkxJwz/9IMY0YwkerICkR3cOGWLu8K9S/yUDXfEOWdvJy
 VCvuEvLWJZh3dE0sJAfu7Fr3SOVER8QVG8npEyjbzeLbAtqK3+QoQsjVqHDJpZZXGqu4
 MPOIzlvJ/X7lTRRKX5HxcoSAwg/EUPTJYgIU1Mk/WwVvk3EuBPVhf5snNCKvJxC/rr8l
 UmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768089572; x=1768694372;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=woOc4sWM2xF5F12Bb27H4miY/eA3CR8x238+DGoEIrI=;
 b=SSWuunzP3d7DOcn6efdKlYgAjkCEPLi02QrqZo9NMcFqNljIUjtaCOZxr6HXNe4op6
 vwJ4mtSQBP2jE33qG/RGToAWnnBL6IC37/kblloQNaxjCY0kVl9zg0Huh6HGAUXnqyk9
 tJqYt28aR8kr8DZKtu5jx7iqvyhI3oa75dl7VjJxDSyD5P9hhUJgFbt4jxhNceZyHHOF
 Qpn6GfYi6CT5MuTsmHYEx7zf1RN5YSeaBThTWHxBWkOCY7N/nbgfIvGEVqkSfgMDKlZp
 UIYu4Ma3aPL5LjQBRRb7FXwGtltlF0UvLPmEfW1aIhzqcKhaap9SNaokhS4preRuMMcj
 PXbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdtssiknuhLxT+5VcUr1SkSV58ocWY0TNmJu6lZbCW0k1k6ywVisZTsoH5lN5m+iHqqMreJsR72cDX@nongnu.org
X-Gm-Message-State: AOJu0YyMdl298+krTrEuspYWeAEJJCYUk1YGA0v7UpRBKXjtFY7o8H6T
 Vzk9hWTrbeJ0puVvef5R/nbxJX0jwU+irMJ2h9yVAUQbPgvRrOwU7TT52uPj/mt8pAM=
X-Gm-Gg: AY/fxX7ZAncOqqvLjfjCSJYzrWFZdfdmnA8kxXBeet81/o6CSXPEMCP9V++vJobI/F4
 mCclzmVyqBy1t6DGBgrbe1NOJdsAvwRfnLi8ZO+kEUuBZhHiWeSSUw6cCWj5Zc6fORI8YxzGEKt
 1JaJiqRN+lc9aMAHPVgQwHYXtpH8nkfu9RVvExz987+4NrSN3mfRW7nPOAktrwwAcwbs5mrh4GW
 w2D3+Ijewzn7wIHsIa968jL/I0Shg3q1qnKcydYfDTlfW8U06Ou/6EjeHovYjAy7tNEMNgkfAjQ
 p4Q0dzUxPVY2TCNKExdsQ2Np5k/FXfJaycDT06Rc5uCS2uvDl3ubNrDWxDqAKrJ+1/JGBvmhGYX
 FIWCJtYvX1AWU3DkDqupVf82pEAlCSRgGpkH1moPjW8/OR2xrAIDAN7CtDLPvxwxOkRH0p8LLc0
 a9SZyHGph6XrCJ1QZmWTK2Geh5tg==
X-Google-Smtp-Source: AGHT+IFnQgJOYOg9ITS7dcHyNiaNgkUzFHtF8jNHAcc7fWxyzl1KWRcracacCbmvnJLUfTTqtDz0sg==
X-Received: by 2002:a05:6a00:348b:b0:81f:50b1:51f2 with SMTP id
 d2e1a72fcca58-81f50b170bcmr348615b3a.41.1768089572147; 
 Sat, 10 Jan 2026 15:59:32 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819bb4c8187sm2139387b3a.29.2026.01.10.15.59.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 15:59:31 -0800 (PST)
Message-ID: <13f42f63-12fb-4f23-9daa-f06ff243f9bc@linaro.org>
Date: Sun, 11 Jan 2026 10:59:26 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] linux-user/syscall.c: consolidate statfs calls
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20260109214158.726916-1-mjt@tls.msk.ru>
 <20260109214158.726916-3-mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109214158.726916-3-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 1/10/26 08:41, Michael Tokarev wrote:
> group statfs&fstatfs together, eliminate goto into
> a different case label, eliminate struct statfs global
> to all syscalls.  Ditto for statfs64.
> 
> This makes code more readable and less scattered.
> 
> While at it, drop `#ifdef TARGET_NR_fstatfs` -- assume fstatfs()
> is present together with statfs() - just like for fstatfs64.

Even better would be to split out helper functions;
do_syscall1 and its switch statement is simply too big.


r~

