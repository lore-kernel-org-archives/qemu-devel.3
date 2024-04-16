Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4503BC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwioC-0007MG-Ix; Tue, 16 Apr 2024 09:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwioA-0007Kq-Jq
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:25:10 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwio7-0004Vl-W2
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:25:10 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-346f4266e59so3212241f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 06:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713273905; x=1713878705; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D8QWZczldhoNgDTxlg5jy8u9DQ2z6caDSruEYLFiW4M=;
 b=S7KaJGL6kCj7DzrWfbm3nt1yNlHBO19JRcu3r5tumjwLNii3pWPTU/VK8fxwNUalHL
 KF6t+m5dF++D21D5PPFmNS+naGCNO5zOxTWwXT0hWIQEO35eHqwjTk7cK44UycNJV+ri
 pG5VfsklAMfs59Bu9BFjKR267C0aHHzTbGAiRA6DomMuwSQlUuGlJmeBDAGVQx/+LsVp
 0blZUrZ/rGOkFgWTcLp1X9hInZbQKLNrBViNZ48pu0mNqN8AfcOCXf8o6gOcLlLqUyVh
 dGl1qQO4HIJeeXMIpIUSvYvKUSSe7bm978qbDNQNIQbHXoCLWFdm/0ZE2NoLmOTgCAnp
 cdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713273905; x=1713878705;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D8QWZczldhoNgDTxlg5jy8u9DQ2z6caDSruEYLFiW4M=;
 b=gStRmfyr/IBaUbMYEMhK/taeT7q6tPfaS87Z693sgcZl6hznT3ILuvJIKBbvnsJ1Lv
 ye8PLq7ogpjOzccyUNsa7Jz7G/YpDS5alhporueXOsAP4evbR9p0ULej5d6x/IzVhuhe
 ai52lX5d3UqCeV9NqhMJ0A6pSHyZiMIKaMNwbog0HD8VOKFSIgm3zMyIDqY090z0AMrx
 LS9TyrE7o0pZzzObzT0XgwD9CBqzP9f1JM8HLi48viXCrhTsMl5mE0u6Ua0UObxUgbjo
 07XaBSlEsLyes8VOnTo7jZ4N4aHBsLj8eqRTJKkVr08d1Pb4H0eFdU7ERBoCW1kdge/h
 Vg2A==
X-Gm-Message-State: AOJu0Yxj2sAyjHvZDxmcDZo7aZXjjJCW/DFLoE/dMzUt/UVPG70Kg57x
 QCQat+AAnuMGnWMbJMtSMTajS/WsTA4Yv6CUwC8dEpsHoPwfKvyxXD5wPwgyLZAzvOFfJwh/lAR
 S
X-Google-Smtp-Source: AGHT+IE1zfsjXDeF1wBf1JXF09VaCAGu9iqn9fEUmRzySFW1yFdEIicGpsTUoQeMH3D/HfZ3SkHxSg==
X-Received: by 2002:a5d:5223:0:b0:33e:b719:8bec with SMTP id
 i3-20020a5d5223000000b0033eb7198becmr7358323wra.24.1713273904475; 
 Tue, 16 Apr 2024 06:25:04 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 bl40-20020adfe268000000b00346d886f3d8sm13770911wrb.16.2024.04.16.06.25.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 06:25:04 -0700 (PDT)
Message-ID: <d19bbada-5ce7-4e21-a566-6f7771020a54@linaro.org>
Date: Tue, 16 Apr 2024 15:25:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x: Include missing 'cpu.h' header
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, David Hildenbrand <david@redhat.com>
References: <20240322162822.7391-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240322162822.7391-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 22/3/24 17:28, Philippe Mathieu-Daudé wrote:
> "cpu.h" is implicitly included. Include it explicitly to
> avoid the following error when refactoring headers:
> 
>    hw/s390x/s390-stattrib.c:86:40: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
>        len = sac->peek_stattr(sas, addr / TARGET_PAGE_SIZE, buflen, vals);
>                                           ^
>    hw/s390x/s390-stattrib.c:94:58: error: use of undeclared identifier 'TARGET_PAGE_MASK'
>                       addr / TARGET_PAGE_SIZE, len, addr & ~TARGET_PAGE_MASK);
>                                                           ^
>    hw/s390x/s390-stattrib.c:224:40: error: use of undeclared identifier 'TARGET_PAGE_BITS'
>            qemu_put_be64(f, (start_gfn << TARGET_PAGE_BITS) | STATTR_FLAG_MORE);
>                                           ^
>    In file included from hw/s390x/s390-virtio-ccw.c:17:
>    hw/s390x/s390-virtio-hcall.h:22:27: error: unknown type name 'CPUS390XState'
>    int s390_virtio_hypercall(CPUS390XState *env);
>                              ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/s390x/s390-virtio-hcall.h | 2 ++
>   hw/s390x/s390-stattrib.c     | 1 +
>   2 files changed, 3 insertions(+)

Patch queued via hw-misc, thanks.

