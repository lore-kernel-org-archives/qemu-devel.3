Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C23E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNu1I-0008Cg-3d; Wed, 18 Dec 2024 08:23:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNu1G-0008CF-ED
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:23:18 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNu1E-0007AR-IB
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:23:18 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43618283d48so46905105e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734528195; x=1735132995; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5R+q3EEnkqoIYML4dZGTYRvWcQAtQyPXlr2A56GNhRI=;
 b=EWorjAywRxnTvlr0EdTxD56JEa4L33M4YlppT8KGsTLY+QxZwbNLCE5jgRlIrortRf
 hm2bsEOLA3Ir/SwJvoFXohH1AUlFeuu8s+9oXoVsAp8EtT5a4isfrWUH4fiTJHP63+Zd
 U8WEleWfEReZ0HuafpYDeTjqKTjVQll/2gG3f3Wjcb3BtwenIP4Fb/SD+qeeWS3MUgK7
 9OC6DulehJTJoj0MIztzwGVCEfZL2oFuNq46125BkBNa8HV/uHNQI9v+4R4/eX8X4EFa
 VHgcct/YwexgIjcvLwqAfv4ypyqpl78TI8g5VeRQ8LGvg2sji40z/MF15y4MDh9s1LC4
 XY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734528195; x=1735132995;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5R+q3EEnkqoIYML4dZGTYRvWcQAtQyPXlr2A56GNhRI=;
 b=jx6kc7Dh8JCK1qrWEylDBdEf8rgpw3bCo1grzK7M4Ct0iIpwJd6yGZVNWZO+BPi7S+
 xEzq6cJtkcB+qln78DPxDxAxUGSKSHWEigq3rUdxuIr+5YAjm1d+OhKsGyXuAeoXTQzD
 n/d9nTYoE0EMKdWis+D/yiGazXHiM20NhrLDBOpvKHTEdc57CK4jP+mie2saGL2EY03+
 v4rkSkz02YuzQv4UFofJfGVgPPTay61zQffOEohkSMR53YkUWiqlwkcCpWvmB531vOtV
 U5fXtzP4TdVy5xvqjlBwB8oWcEK4aJI4OQYL3NvTrZQK5fohfF7NAXT9jvLcdVSEWLEq
 AfSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjvNVrpY6OPf1vEMsl2wz1Mh829n6zBfz7+j8UdtKaJHmXy6bcqBPBFWn/Yw7dM5kKll8ldNjd/8iw@nongnu.org
X-Gm-Message-State: AOJu0YwuskUAcIZUl4QPUtEb/3vVcSv3g74T39r/pgpYJdP1TUYPwwZX
 Cu9Gi1txdttczRrHn5LPopJHQs3NJ6ZbsbvIhevpYJdmGycXBNDW9RqL+xaJ804=
X-Gm-Gg: ASbGnct3WBVMi63k3hZ1UaxDyVjfEQksvhHbuKZtk2pmDgFie9A6F8AzDJXc8Qw08Cv
 w/9lMZanblAj4HFwjkGQwTegMsGHt+wWtzgDi35ylOEcKlCgeqzMrVsENeBFGQ+rkcUJYpaJcXu
 5UJGnz6pgR6WynhTP8B4jsYSk2dQKCaq32fAxUeXx+hDdWQ9FvhU6etYe7R/1BfDYLd88dnsBlm
 w6QCFUrV2KvFB+jgI7o7I1zYUXdJEBr2PdYzv+TXSV6gzr3rTkeiYQFgexbnJ9ok5g8dwcH
X-Google-Smtp-Source: AGHT+IGiQcfHIa7orcQGPTW8DVBDnSllyf78Yu/RmNWep91TIs+vxLZ7xFsyQDV3uZf17vk/UY3A4A==
X-Received: by 2002:a05:6000:4703:b0:385:f271:a22c with SMTP id
 ffacd0b85a97d-388e4da3fcbmr2411054f8f.59.1734528193416; 
 Wed, 18 Dec 2024 05:23:13 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c801637esm13979100f8f.28.2024.12.18.05.23.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 05:23:13 -0800 (PST)
Message-ID: <c89e9f97-240e-45c1-afbf-cdd478077952@linaro.org>
Date: Wed, 18 Dec 2024 14:23:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] rust: pl011: fix declaration of LineControl bits
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
References: <20241212172209.533779-1-pbonzini@redhat.com>
 <20241212172209.533779-2-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212172209.533779-2-pbonzini@redhat.com>
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

On 12/12/24 18:21, Paolo Bonzini wrote:
> The bits in the LineControl struct were backwards. :(
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   rust/hw/char/pl011/src/lib.rs | 82 +++++++++++++++++------------------
>   1 file changed, 41 insertions(+), 41 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


