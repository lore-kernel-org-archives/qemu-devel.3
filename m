Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BD5CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDLuz-0004SF-BF; Mon, 27 Oct 2025 08:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDLuc-0004Ix-Iq
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:01:25 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDLuY-0000K4-3C
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:01:22 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47109187c32so24035715e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 05:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761566471; x=1762171271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BXmG4rPJzsExvgDltHVu7249ESkbN7O+AY3Sm1krET8=;
 b=qlShkdCyC9FfjEA76EXbNNZxH1VXCYVpNeijYIRnGcDMMJ8f7DYc0ckMFpjLshLct9
 ZMbOnIE3tu5Y/nEwy3x0gMl5nGsIaJ3JG3eL2AL6Z7DoNQSi0Rg0ENMkuwV+SPpWNy9P
 P7s5fzfvyWKXhS00x5lNMjJOEB6I31/Q6BOA3aPZbDOoreXaglIqHByDkGqAyJFHAJIh
 DodCqKjEfD9qXv74PtoYGhe56Q4f2PpnB2oR5ReJlnqEKgV7qoOrLto38YIMyZd2YjZC
 ACUcD5YpyqyVd+lwweihi7k6RvnVMXMPxStuPCox5YlkDWXvhbCYvHWDOhmXvvB4m+Zf
 CwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761566471; x=1762171271;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BXmG4rPJzsExvgDltHVu7249ESkbN7O+AY3Sm1krET8=;
 b=GK7P+LvFBeqH/nkAFkietkRXoW0zCJYLLVUbZRhiS9DDpdYKrHszb0rilT5cRsAsS8
 mYl3bWhMzD97txFzF+tlDIuHC6k13fReOTekcgwEzpvWqsyxS0N0l+N0sgcrIWO5Xa/X
 erZzyTE9Xtea0K78LIlEK6XEsyjRzehy+gdmNVQwcdlBaInU95HEAFOxTBeAtKXqg5iX
 cKaag0J9FaSjBX4hNu+HkTFNDd2+XliDiAPRPo9O9P5CvU8ZDEy9z8MpYW6tTS5JvPnN
 YDe+4rBD8WW1EMfM+JfFzuyGVDx10YjTMwnUcCr7A1ycRDPU2Z/cfcddtONgN4iCB5B1
 IiLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPJf1y60Tk89DRUQNEePf3awu0pdvbTHiyX+ZTBnuNQfziQTsS19XNKbsFjHQJErHNEfFcwOJw5GR5@nongnu.org
X-Gm-Message-State: AOJu0YwWKy1bob3ZdCj0WZi/8akPpfXAiTkxjS1miDnn5zjcQFrmDp+u
 fcaw4hlE7xxk4n7i0BclCOG44o3LqRnNStrCbBY17rUnUV5xg15gS+gvroVOjE80Vtg=
X-Gm-Gg: ASbGnctAl6uF110ZG9qz0GK1z6BJ5ZQD+CYjOo5/TqqPAaSeX56x2gvRADQVVVDZj8I
 S7/W1AliNUQ2q+20JpfDcTRfyClg5aE9G3SegShI5nAnfz+lYo6cEXKCHMy4LJXnhZFiP1CAqny
 hn+ZQ1TWxYHtIwWIm0MwlNtqQD+Ra2mKeRxstJJa/FYDaGKNGaA+txW2hcI50E8X+QzliREBWJK
 BmXlqwqjQoPY8yPOCEPKWWnUMUGhN5LmcASd5IcxGpxMRlrbBdcoViawP3wP1TY6QC41yHo9S9F
 T/JN/m0itBuHFCxXg0fKycRFJKmwtpr1vM8yUHrDwYSWwaCG4vg+4PjsZh7LDmlQevX5w5yWR2r
 jNVU1YZWw8d/FDLFoTM8RjeTjCEJA/3LbrDW9liI3R8RDcCPZQ6394OM7ucMSyiSL00QQRNNZsZ
 75nvHl8eKKRIh3Qhbvpltp6e8uVCJ67BYC5FiB1su6Yeo=
X-Google-Smtp-Source: AGHT+IF8m3ukDmgT1ef+UwiXVMOA4QUDsO0KtxTwBMHpDKZiWoXEX8dZTimr/8CJH12qvIPO7cs/vA==
X-Received: by 2002:a05:600c:1d9b:b0:46f:b32e:528f with SMTP id
 5b1f17b1804b1-4711787639amr274798645e9.5.1761566470629; 
 Mon, 27 Oct 2025 05:01:10 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd01dfc7sm65349145e9.2.2025.10.27.05.01.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 05:01:10 -0700 (PDT)
Message-ID: <c3aec42a-467c-4320-802b-a80e19cc78e6@linaro.org>
Date: Mon, 27 Oct 2025 13:01:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/migration: Fix bad indentation
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20251027112347.54190-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027112347.54190-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 27/10/25 12:23, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> pylint complains about bad indentation in two lines. Use 12 spaces
> instead of 11 spaces to get it right.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/migration.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


