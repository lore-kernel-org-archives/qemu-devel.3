Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5ECBCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 18:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7IHq-0005V8-Nd; Fri, 10 Oct 2025 14:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7IHo-0005Tk-MX
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:56:16 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7IHm-00049X-50
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:56:16 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b5515eaefceso2048897a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 11:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760122571; x=1760727371; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iaW2HMqZdNDZ3dJAHUPCzq8ayuBvZoy2YO+kZYysxLc=;
 b=vNq5bQUzwD39p6vM+NxdInPZrOPWIdplgWwGIPHfY1EE6guQxrz54y+RyJkoWs1N6V
 PXzE6hB0qnQFz62Uf81+ZRW+eY3gTW/RqlJssgttIuK6PbQgQ20X3+frrY/RZC8KJDQA
 Lf80E0e0AfNixZPcoLLdJZx10dkQMho2J4RXWIftIpbtnc/YD72egMXAU84I+5lhi/G7
 5OYtarSEx1BXxUgulghkHK1zen+88+tyWT0qsGnZFg3PMc3ZVPXda2O7g2GEYJ9SxdxU
 TnSYQ85wDNSJjgwNXILi7Gv9Ag8HHDokMkc501OhXa44Ux9v9eBTB+EgNuHU8dShu2HL
 9bbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760122571; x=1760727371;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iaW2HMqZdNDZ3dJAHUPCzq8ayuBvZoy2YO+kZYysxLc=;
 b=g8ULRrI1tB9kPl+NQJtjBYvM8UYDbO+trspu/1TMma4/351dXkVAd5h0A8vI0yJAk7
 7xWy9mp4evEZDgxIBKIARznREEX6aHxJjIEbTSCEsZDXcXlQTAhtFGnnCymjVrsvyHpf
 yVrHEv2jAr9gdkY+hUAtZLs/GP3fhN+Ycs0pgZI6mJenr5OGhUpi2rRBrkJLAPFFncGp
 KWZkvRND3g/VezfthX4FgQ6LkvE30VYJz1tFNjEHJg8H1Ci6kfJldPkOT4ifpmiSn9Vx
 hCKDFncJPlb4Zr6O5O+KJ6jXKgIcZgBfBThO5E19HPtLgO68sapB6LtfhIqGEbmkvxXq
 ZEUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUN5GLMw2z6L51GCzpPAKGfXM8hQAPXqFz2B0e7+Ubegczd12jrtuZHgAC7JiYxDaiGSRzmHnBXV2A@nongnu.org
X-Gm-Message-State: AOJu0YwOyDTUyuVACkmzrICYaV9j9qf1dv72DGAeeQoIANWbyT7hAVrc
 HEtE2eYExAS4+uxCwvCImPT3t2A7KqtIgwhqlaYcLYoxhQmRpizUJutv9vLN9NrDTgaXwJ8I6Ec
 llbwkkJA=
X-Gm-Gg: ASbGncsm1TivJmEn8MQI7N/J8cvZuXw/g9Q64MNQv8WyduvMdQ0I8HPX+AmD8Z6DuNb
 a0E8Z4Ws4kx4n9zTFwcteEQCvDQGDtqWA+tumYaD7J0Z+8L6yx9JaYegHIU8c8b+y6HiAfSAp6j
 guo2TGXhIpKiRAbEYJkirLHxlqNo2n0zmwx5/+/l4gfkdznI6XSV+pxPBlr3EWdL+8+ggtA1i0F
 PB50fXrNVLmi6zlTMZXeyNwdtWmfIDSEznzYxmzIYzcY1S7KbYuhJid30nMvsxaEY2urk1UqVsC
 x+DriXscwerGnaT6IjxycAAUBwYWtGGJMNA7wbx0RpB+FO7pq5Jofdvi/GT2l9ZcTBuduFO1eC3
 UFqiXV+HMThPPjYHVDbsaKca4gBxcecqlJYMtrRoOmnphPaFNJbWHrNk94a0=
X-Google-Smtp-Source: AGHT+IG2OcUzi96+1UGHj2Op7w7f9KzLOORHi+jIxt+p7BJ5cHHMBOFXZNdJgVgLDudzfpgd25fhRA==
X-Received: by 2002:a17:903:1ae4:b0:27d:69de:edd3 with SMTP id
 d9443c01a7336-29027374b2cmr157068825ad.20.1760122570761; 
 Fri, 10 Oct 2025 11:56:10 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034de658bsm64123905ad.22.2025.10.10.11.56.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 11:56:10 -0700 (PDT)
Message-ID: <102f29ac-2e57-4eaf-93e9-fcf0ed289ab8@linaro.org>
Date: Fri, 10 Oct 2025 11:56:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/13] target/openrisc: Conceal MO_TE within do_load()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Anton Johansson <anjo@rev.ng>
References: <20251010070702.51484-1-philmd@linaro.org>
 <20251010070702.51484-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010070702.51484-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 10/10/25 00:06, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/openrisc/translate.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

