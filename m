Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E2EC28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5Mv-0002GH-UJ; Tue, 11 Mar 2025 15:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts5Mh-00029M-4G
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:34:12 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts5Mb-0005C9-Uu
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:34:08 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-223378e2b0dso86776825ad.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741721642; x=1742326442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mbX7u79SL+BjzoBWFWipwKj/0mZKQswVf4SmUtgJHs0=;
 b=NgmBEVICR3jL4CjDHhWMuTLkhlQ79uOA/RYI1mwwPNei2T0f06iDhloTa+9WffmfeW
 KqrohdeeckG2BSLEhKUwOfZU7xd2Gy0IAQsA/xNw4vNn6JdPlbsmTBn/9y+OGuCQ8Mrq
 RT4yDDhf4hGGGFdFVo7BKl+Xxm28tpoMTwu5pbh/8W9sqFkl643O7Q+1wywcziU2tXb4
 WKQvJLzJBqAEODfWy03GKyeOmfS843f4h1025CWRuvAOsLLB4EIXDbo314v4ytt41NK7
 wzjlzgC17nfSgZvLGnw+KyTejA0gAdQ+MS89eqJVLkAKzEj+kw89d+mAdfaxGoDWXS1V
 Q2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741721642; x=1742326442;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mbX7u79SL+BjzoBWFWipwKj/0mZKQswVf4SmUtgJHs0=;
 b=wwesBklRtZUrJRDZ1kMxlGvqDY3OW0SygQet6FtBe7FL/mEBHx3HleSJtfuAZ1U41E
 rrj6LWfLYz0DrJKhNQuYHTzeOSjQKY+Naefn1F7s8T2jNqhN3zdVnf4K7gI5ySMhtiSt
 kNc0PAHVKlqrz91kBKeJGea7iQ4Bs4HNmMFWERB4MYl2wUN0tfWZ7WtjNlXrBd1A/XzW
 2Q5WjctJaWcxzj0ePOjEbtDjIvi+SarNfMAOqn96tanfz/nuJLS8DMVkGkgtyI8syexJ
 0spnqQeZ9A/y34u9QILmeYy8glnlN+VeNC4Usb/1ZnuWVjZgCeAuQgiswoz2vtLmhLzr
 TMPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkoBMSNB4E/tqqSDihmbDt22DgC4fdHXRv3Q/AJM2aZcMM19pPxv3AU6JwZfbHMsFoiGrZdzeBDEI/@nongnu.org
X-Gm-Message-State: AOJu0Yx2Fs4k1ecf4Ym+/5Jqgdn5Q8eqk1O6+hgfb49WB2xZuy4qC84Y
 trE4t9/JT0bUwmvTfujnZCPOrIVMmiCNYsfMQtr8AQ61Mk/T4fJXlfw8JglB9+0=
X-Gm-Gg: ASbGncvu7VsKZlYHsH0EFjt5scEltT2mCu4/hRopeBSF+AtwaYzlS4Xm9HRPcJiz/JH
 PRPW83wE8qHQz3RwrYcuTZMR9osV+6zf0EYdipJ4qiZ1lDUb6dww3GK2SpRgM3g9WAvVozDH5F2
 ymvgHaJhre3Pr3wajCIxcDfu578ixH8VF4lAXa7E/hMUYLvsFhiAtxLna3uGi7aHd783yXZjpEL
 nt5+4PxJCiVRM9ztmUbNu9NSEy2WKAnxWHbJu0h5jt44CiBnXxoEHSWzUwWji1Rm28S4lORiLl8
 1kRIyfdNCpZzCWWfytbo0BO07zzu/9L9W9HpYUsH5mSU93OH8dPpao3L8wVzbJlMDCwfGgq6aLt
 VRpLXGH+/
X-Google-Smtp-Source: AGHT+IFLtfnNkc+Ll8gXgLOHSZR6uAs9gy5RBLdgn1F3V9wJCOZlk7wGkjT2sgumeXHEl1Wm/7++ug==
X-Received: by 2002:a05:6a00:2351:b0:736:491b:536d with SMTP id
 d2e1a72fcca58-736aab02cbdmr28285522b3a.20.1741721641788; 
 Tue, 11 Mar 2025 12:34:01 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af281287626sm9853660a12.66.2025.03.11.12.34.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 12:34:01 -0700 (PDT)
Message-ID: <35e25ae4-ee44-43a1-b66c-5f5186d30a7d@linaro.org>
Date: Tue, 11 Mar 2025 12:33:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/16] system/memory: make compilation unit common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
 <20250311040838.3937136-16-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250311040838.3937136-16-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/10/25 21:08, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   system/memory.c    | 17 +++++------------
>   system/meson.build |  2 +-
>   2 files changed, 6 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

