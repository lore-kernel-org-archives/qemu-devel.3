Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2E1E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 18:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSgYN-0007tF-6u; Tue, 31 Dec 2024 13:01:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSgYJ-0007sj-9s
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 13:01:13 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSgYG-0002PW-9M
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 13:01:10 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so107736565e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 10:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735668066; x=1736272866; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CAy/h+byf5acdo41fAdmD5XWdSO7i9k/e2eErMWtT1Q=;
 b=x+6ujJbnKhYvnu1+EeAIKK1AGL5hlRbvjbkKqewA7+w2IDeW7eMNYbaUYAA2dCCkH7
 ls2aJd+TZbApWQCqXDgysnjuZKcOFhAmduqFGiRj83cWdTJzBH+EN7GzNrJkp8tkYMbD
 m5dVngBqy4TNRFhnqxkrOttqPpx2g/55taQ5WHQmXwOzMnJ7PbEBFU6p86IFraENCiay
 Q15mzVsppZW87k6q3nOgT9kH4wmjOd3L1ZrUPJzlvRQcREruIgcK+0EIWRPuQaBqx7ES
 Lq+lDrP6xBeXz1NwMD4NLPmOCU7ZfsU9JyM1g92fKr0T9QpJVl/w4KjsWPTAhrY8EHb8
 KAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735668066; x=1736272866;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CAy/h+byf5acdo41fAdmD5XWdSO7i9k/e2eErMWtT1Q=;
 b=F/4vrr1nV1Jio9sEARhuXPLw6+6VZOpVVMEZBjgP3FFLGhomZfvWbc1p2D40cbhylE
 u3EyqO/f3NSitZTlMxbL6bwRB0lzJbWSe7JNJTMj1Z/XOMXo6l7EJow5FlXsFi9ux/Xz
 IOfb4U5Yh8ZW3qEezlqjjxUsLTcn7JhT+fF2tDuYvFVVSh7znKn87LDMSuzeamrIH4o0
 DrJXY6sw3SDb7QNdBycNSUnkXP6LOrIuVyGN7vQ9tCko9CrkeRiS6Z8ijpF6EsiQ5eFc
 vkLf1hS1EbRmXcGtuenePLl2Ik07xev9A5ktRxTPwFtqXBFFVetisJbBNxh9KQyLGiO/
 E6Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW45TJClSSryVqb36h/9WHpoH8NfSy8nVfvbiB6Tqr9pteIpUlmizE8mYI7azKGYDQiPb97DIcMy6bf@nongnu.org
X-Gm-Message-State: AOJu0YxnX1jiERGc58Qa4sO7Q/Wi+i6+Bib+j3x0AXcHNDL9xUKUhF0R
 c5VmDemiTQQuy3hJol2kD2xuwjsWRPAPhQtcA9Us3JoIG2HIaHc/1FL9Iwpwg1U=
X-Gm-Gg: ASbGncte6JmmFJ4c8KIvzLh6D/8sKqnNUFyLhdhALrBIqrWl636XKyb43h9gnEDdF0J
 sWIKociBkbqN23xLXfd8Mz3WjJBWIBvrzR0PNDBxMhHranc2qqrib12/o5r5WC0rAXgDi7G2TqP
 HVMKfISuAcagi3WAE9TwAU45389uEiCEs0qx8aj9kbjbosXauzaY8Z5iLoXWo/exfK4hOiQ+nYc
 D0deNV+hlPDjaTX0kwGjoN/UWLsSEfuh/8QKhCwGxVkEk7ElhMKuxH9zRfsVmoDiim9wYLMqUbT
 7cKiULrUMFyMHpvjmihy/8nP
X-Google-Smtp-Source: AGHT+IFHex1vWyr7zaxqtjFYSOMXkGF/7fWPg4LRktsZayQpxgIrW49CXjmefvGk8X6/MMvOOpHWPA==
X-Received: by 2002:a05:6000:18a3:b0:386:8ff:d20b with SMTP id
 ffacd0b85a97d-38a221f2f2dmr31832561f8f.27.1735668065751; 
 Tue, 31 Dec 2024 10:01:05 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e3d9sm32744377f8f.67.2024.12.31.10.01.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2024 10:01:05 -0800 (PST)
Message-ID: <0a4d5893-d54a-4b4f-91ad-0fe35f195294@linaro.org>
Date: Tue, 31 Dec 2024 19:01:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] hw/misc/ivshmem-flat: Add ivshmem-flat device
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 armbru@redhat.com
References: <20241216141818.111255-1-gustavo.romero@linaro.org>
 <20241216141818.111255-2-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241216141818.111255-2-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 16/12/24 15:18, Gustavo Romero wrote:
> Add a new device, ivshmem-flat, which is similar to the ivshmem PCI but
> does not require a PCI bus. It's meant to be used on machines like those
> with Cortex-M MCUs, which usually lack a PCI/PCIe bus, e.g. lm3s6965evb
> and mps2-an385.
> 
> The device currently only supports the sysbus bus.
> 
> The new device, just like the ivshmem PCI device, supports both peer
> notification via hardware interrupts and shared memory.
> 
> The device shared memory size can be set using the 'shmem-size' option
> and it defaults to 4 MiB, which is the default size of shmem allocated
> by the ivshmem server.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1134
> Message-ID: <20231127052024.435743-2-gustavo.romero@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   docs/system/devices/ivshmem-flat.rst |  33 ++
>   hw/misc/Kconfig                      |   5 +
>   hw/misc/ivshmem-flat.c               | 463 +++++++++++++++++++++++++++
>   hw/misc/meson.build                  |   2 +
>   hw/misc/trace-events                 |  16 +
>   include/hw/misc/ivshmem-flat.h       |  85 +++++
>   6 files changed, 604 insertions(+)
>   create mode 100644 docs/system/devices/ivshmem-flat.rst
>   create mode 100644 hw/misc/ivshmem-flat.c
>   create mode 100644 include/hw/misc/ivshmem-flat.h

Missing MAINTAINERS entry. Please fix as a follow-up patch.

