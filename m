Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F96AC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFCL-0007Zz-9S; Tue, 08 Jul 2025 16:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZDmK-0003g6-2k
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:14:59 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZDmD-0006jd-4c
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:14:53 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7d9f5bf544cso147329185a.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752002045; x=1752606845; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VavxpCGYW3WjRI/O9ptGzHonaVxScT/pqQ/nt40jf1E=;
 b=J7aKhzcqzpX2LRJT00uwdnpfxj/Brzgqn0HMS6J2QpjYYXCz261xOJBJ41cvkFoyoF
 xN+OG8B+orjBkxiKqJleawaompPpr4wYB6s9s0exvFxjDJ0HDJ4EJ/kdsl75PfJVEt/3
 LLHtvbrpHt03T71SavCdmaocHl/3k6cRvCif/EW8taI4zT7RR5iJw03J+qiO53gaWAyP
 ugEjDKkqvRIkAU0tmrvhUF5OQmkzAo23ABhhSLz6OfK2QFbtYHHOUXe2FZatkNAFI/yb
 bCcaeYLZ8OvVMpQumPf+5sMleHxOl4WqfogfkzoU8tkwb3H3p/43zcW2ymDSFwxdfF4O
 CbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752002045; x=1752606845;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VavxpCGYW3WjRI/O9ptGzHonaVxScT/pqQ/nt40jf1E=;
 b=JcIOck6jeFTdx8aaaotBoERJXB++uzgs0snts6AZGC3xfGY07EeLBQdzZrdTCMRRIK
 0vUh6GIe5svoAf+XmWOz7ERaAmL/pgq3enYVbhFYMW+RU+CMfa5leHd0R9lqlOmfqPOf
 Vqzvojq5aIrusQGNnB1qvUG09IRuH/HTFckQq4AzAN2oVfXXHxpcKhYRiq/332OBZ1Sh
 n2C6Zs7rNFcwOG7uTB6YKNmXIvz+LAZB6uF8dhKFovLTOH1j9sCcKHBRFtz8KJj9egh3
 WKgYccBHDxosBLzswUJqefJMZQ4ECw08bDiKUwVQOj5o+2z8wxPlY3/PrnwgdIQtbJkm
 HzpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXhM+t5XoBKe6JBqvd/a6tx6tSgD/+NYBWUT61kqoiG81H+MtgKm5Pwihjy5mC3Qfl1fRf4NzrQ7tK@nongnu.org
X-Gm-Message-State: AOJu0YxKZWwD63O5DMdxeReL8wL7gor1lHM3HraHPNFYXkNUsomakcYR
 sM8/UKXHhd585T/8uZB4oq3cFwkeu32wRV68KQo3HKaEkqQyJv5HJhykPgrW1WKwb2pmzGjgydC
 GwbiI
X-Gm-Gg: ASbGnct7i3Pj53sQ7raYOulJCq4yIQKqEfA6tronsCQ12lyaP7xWP491L7dn0bBXpOo
 NmOtoaY3kjNr/c11DjHiMuLLVEJiG/gspaMBT6tLsU0W9wNzPeJe4bWHNfIC/9hpzDXeOHAvIq3
 BrJayDue+V4NpA4QwSAIh7b3n3LLbQUw4creQnTHEMDnV6QKSJKczu3SMzxq0Q526QiJj2FFcYG
 N4c0Zstt95F9T+bkB34J3y/g6mZfk690oh/zzPPZczdvY1jWYBG5FqLvrQditTdraawJf9IPf03
 B/PnXBb1jPP8uOXmerVdDnLoGVAZVjnJvvrG5oGkQMdJRa5ZLnsQSlyATMfZZWfaNAEBezSKT9k
 =
X-Google-Smtp-Source: AGHT+IH1TrqVdDZnL83UmlKP/eSa5V6sbdZmX/YtS9jzCRhNDrXt5cY1wnW4fzua/yxt3ZWtWHOZeg==
X-Received: by 2002:a05:6a00:2d8f:b0:746:26fe:8cdf with SMTP id
 d2e1a72fcca58-74e4162eb0dmr359749b3a.7.1751996013912; 
 Tue, 08 Jul 2025 10:33:33 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74ce417ddc9sm13152318b3a.105.2025.07.08.10.33.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 10:33:33 -0700 (PDT)
Message-ID: <a53d8594-3311-4b34-bef8-ef66c71f9b4f@linaro.org>
Date: Tue, 8 Jul 2025 10:33:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v7 5/8] qemu: Convert target_words_bigendian() to
 TargetInfo API
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
References: <20250708171949.62500-1-philmd@linaro.org>
 <20250708171949.62500-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250708171949.62500-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x731.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/8/25 10:19 AM, Philippe Mathieu-Daudé wrote:
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/tswap.h       | 13 +------------
>   include/qemu/target-info.h |  8 ++++++++
>   cpu-target.c               |  7 -------
>   hw/core/cpu-system.c       |  2 +-
>   hw/display/vga.c           |  2 +-
>   hw/virtio/virtio.c         |  2 +-
>   system/memory.c            |  1 +
>   system/qtest.c             |  1 +
>   target-info.c              |  5 +++++
>   9 files changed, 19 insertions(+), 22 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


