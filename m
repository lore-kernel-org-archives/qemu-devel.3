Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67746CCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnOb-0007OV-JN; Fri, 31 Oct 2025 07:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEnOV-0007KT-45
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:34:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEnON-0002NF-En
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761910432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=syJrmqveR8vJ/dhtzNUAQmF7YVN3SAro1vSaL4H1rdc=;
 b=h+urWABFlXKiZBzekvAdGYU6zBT7J3IU5CO6pfXWFLlbG3xH2McVPpdGPTiG/B/NRZD9yh
 YQEbY4w9zVCv1OT9TNLz6gxdK77bKHXouIJofXtesptTndnNdPJSlQDQCgXsQASFB2Jpc+
 HIEEogAbjcr9/G8FmhaJt7KGed87ahI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-11IB8F0FO5e4YfR__POpRg-1; Fri, 31 Oct 2025 07:33:51 -0400
X-MC-Unique: 11IB8F0FO5e4YfR__POpRg-1
X-Mimecast-MFC-AGG-ID: 11IB8F0FO5e4YfR__POpRg_1761910430
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-476b8c02445so18882825e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 04:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761910430; x=1762515230;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=syJrmqveR8vJ/dhtzNUAQmF7YVN3SAro1vSaL4H1rdc=;
 b=ln2gUjQqf44VnDENEPEQVwP3qVrLVZSiecpY5/9ZOVKJxmCxwwYBB8xdH/ljgePSb3
 KW+bTG7fFvqulBtdnbP99iX8/EcHzdbdykfCbY4jLUKopIZf1TlWfePPVY6N3qofaunP
 g7dZuzwLa+qKGtGpnNWq8KMcAoj9aaotwegshZtheuR1TRFG5kt8xWUN2xZ6Fuxo8RG3
 +S8MSjGkS+r9FZs140WbVeKoHGFtH48yTminQD5ohpVqhK37lLsYEPIVyj3mHm/GTbX4
 fUJHTXBPaPFLHjO0AHfWf8Y+DHzQ2bw+5rU2B2YWGDcu31K0z6Hc132fRSw6vLAzSUiE
 R8yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+LXiD9qW4vTj3jOi4SbBMMzPpzn/g/Nt9CR5VC6xxsqpLTJ7eaJupaf2VcVwEiyqgZRyYAbde1lrt@nongnu.org
X-Gm-Message-State: AOJu0Yz8/jOCUzyiFj9IMtlJYUEbVT7FiCJrV6Q0tVmYMDOjJQSw3TPt
 LwcM0zUBvXSPNGB7UT9X2ZRSl6/cTW85F8BuZtkMX9oQCWcI2zqgx+ASZYs9+7X0y5iVrvn95SM
 rsYJUT4mgxH0H4k5663hSt7Cg73/mAxej4TVoKl9oEhpnne0fX8hcRHaV
X-Gm-Gg: ASbGncvpWPCIhrOG5PGv1agMd9vQBGtlhdqTP5z6hqMYBtSTOUHI/Y/17ZG6c7vq30r
 XNMwLpMxnVfxYgXh3yTUUbo/8Nzqd/bq+hIRVDp/30lKHoaUTlqhS4RBN8sOcn6MMcgtJ8Dg+gZ
 05KvjKP2wEobOCpv1nRDz4eX2+N+xfcpTzk67SjXvmAXJ5sf9ZEdhLZS7RpJCbDMr5Nw1+p4c6Q
 v+fodYT8SU+fqj3e5TTukhezskukEJUfZreuPxZE52gua0lC9Qkosmye9FAV+hTit4/691ZylQu
 vuZ0iy4ZYKt+dWNaW7E4ncFpL8zcFujxyfg3lUcY8DoDeB64rvCcFk+Wx19AzSKZqtV7QVY=
X-Received: by 2002:a05:600c:828f:b0:46e:3d41:6001 with SMTP id
 5b1f17b1804b1-477308a7b5emr36110135e9.34.1761910429928; 
 Fri, 31 Oct 2025 04:33:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXy8BYfe7o7DolXHWv87EvxHkm3N2h4YZlij0F4SwYDFK+FRUHJsGdM0S+0IHfdeNOlAplaA==
X-Received: by 2002:a05:600c:828f:b0:46e:3d41:6001 with SMTP id
 5b1f17b1804b1-477308a7b5emr36109825e9.34.1761910429484; 
 Fri, 31 Oct 2025 04:33:49 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477289b0bb3sm91331445e9.8.2025.10.31.04.33.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 04:33:49 -0700 (PDT)
Message-ID: <171d963f-9543-4a1d-9852-3ba48e9e7310@redhat.com>
Date: Fri, 31 Oct 2025 12:33:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/functional: Mark the MIPS Debian Wheezy tests
 as flaky
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20251031094118.28440-1-philmd@linaro.org>
 <20251031094118.28440-3-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251031094118.28440-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 31/10/2025 10.41, Philippe Mathieu-Daudé wrote:
> test_malta.py sometimes times out (likely hang) under GitLab CI:
> 
>    1/57 qemu:func-thorough+func-mips-thorough+thorough / func-mips-malta    TIMEOUT   480.11s   killed by signal 15 SIGTERM

Do you have an URL from a test job where this happened? I clicked through a 
bunch of failed pipelines in the qemu-project, but I only saw failures of 
the replay test in recent runs...

Also, does it happen for all mips targets, or only for specific flavors?

  Thomas


