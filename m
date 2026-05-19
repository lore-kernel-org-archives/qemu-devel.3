Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A4DCD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 23:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPUDz-0008Rv-NY; Tue, 19 May 2026 19:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPUDy-0008R3-0J
 for qemu-devel@nongnu.org; Tue, 19 May 2026 19:51:46 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPUDv-0006jU-HA
 for qemu-devel@nongnu.org; Tue, 19 May 2026 19:51:45 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ba4a1a0325so26456555ad.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 16:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779234700; x=1779839500; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EqeZZuZsBBLR8Z6tsIAr4hqac7Tco5qJExwQTAgT7fs=;
 b=wPj5DMjmDU84tjU4gJUXK/wgPUlnkWwnDKE49caiLMFmDQRxo6J173WZTbW5/7tdOY
 JkVIGtScHpYAz7Jjk8hZZiYnV+of1/rXRkDdCIzxuxkO2JnQpw8KXwMY+N2fnMUQNjur
 HldVsVNNTbUH7XvgnVoAYVwh05bVNhGXCRfKtYwF+5mbODzjmrU5hMeyFTaSgRYqV6l1
 03DYHa+fbGlObbeJDYFC6mBv99wqQ0G8NfJ6k990ajoupwHR4YlyHg7fTy78BVEL3pS5
 7lewtqMV71+wcgaKMTa7glV/xK5q468xhoF/T0fInBJO53d3/ZEV/tVtQwM/paYwe4QJ
 75eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779234700; x=1779839500;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EqeZZuZsBBLR8Z6tsIAr4hqac7Tco5qJExwQTAgT7fs=;
 b=DVWFxBc+0LRrIRvgMmSw5slxZoaY8+qSebHCPpRleSBL6IXi6kzsi1AwkLtuKgT64G
 /3zl51Wp1BgLQJ3yaZ3UBgZS+HDb6LQbjczemguT+f25xrfA9t2O9306BB79KbFmkCep
 mQ1hMKKxVvvsOT9XbANS6Gq5ATclsf15S1v5s5qljxsaSUCGWagTAnbCfXMesnXHT8P3
 dAr347j031a981Knp1yktkNbFD0sB/F5+eO3MCaZy1OHvr8GC2T3ppncFSGxhpCqFnJz
 1pGSTcEmjcq+IZGxLqeAklgmkgXHzI2but6x3rUBu8KJ70btagA74vufaKwRJrVS/X8s
 rEZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0zblseTSZDOWDcZ8cS44BD2d5DWudxoivvZLxBWAGDcFc2mITUjbAUVEPwi/aeydBqxFHYEByLHii@nongnu.org
X-Gm-Message-State: AOJu0YwLz7b2YWxb4RT8Fz3ttKZdrYp/AQDvsxFc8hF0Lu9OSp+YoE1E
 ITa+baWFL3Vuaei6tvhxc5syb45U+hRfNWCSULIUaNSQlZCIQoqG8lbw4db/L31hoNY=
X-Gm-Gg: Acq92OG4J/vhNJ+fhAMc4TeCW3HtSlZQZG3kCB33XHVeWVxCvo4q5jTEfHiJlc45L/W
 ib3fxTfdGz+zPYNnOywQkybLkWyHW917oQS1N2y9XU+MGTPQQwwiSY6+A7LhKDwGnLUCQAgF5MO
 Q0x2Mzk13oiXCajNjNd6FIdikOWZiEyRnthyjUjgQUY+EPs/TL7mIQC12o6HFk2hW7iLdSl06I6
 BUBTdxTdkVqg5dRU94IzQLS2kzjtuAj8GEJ0gI7+8NyahhuovrttPc+HJ1n5FkUR7v5j/ncFn2u
 mZEe1Z1L9YviWQn0ZQ0OT/nFRG6/Ta1z0AhdI5pkoOFh84ZDtd1ClIrZD29DbdKDYvsuEu0qJ1E
 OabVwxlFh9/C+kW4BjFL2rbPaTvZ9zW3f4IUqqfBKIS59Ael8hhenkdHGxQ1UrsP6UbIYrksiEN
 94hb8Pi0V1OaN98iU5UTk/kHo04iLVFlMd8kEH
X-Received: by 2002:a17:902:e354:b0:2b9:6458:1a2c with SMTP id
 d9443c01a7336-2bd7e7ca939mr155883045ad.13.1779234700372; 
 Tue, 19 May 2026 16:51:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5cfe6512sm202570145ad.52.2026.05.19.16.51.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 16:51:40 -0700 (PDT)
Message-ID: <15eee3b8-533a-494f-9f50-383cf4391e2e@linaro.org>
Date: Tue, 19 May 2026 16:51:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 26/40] target/mips: add Octeon CRC COP2 helpers
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
 <20260519-mips-octeon-missing-insns-v2-v9-26-d7dd735ecddd@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-26-d7dd735ecddd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 5/19/26 09:22, James Hilliard wrote:
>       crypto->shared_mode = mode;
>   }
> +static inline uint32_t octeon_crc_reflect32_by_byte(uint32_t v)

Missing newline.  There are several other instances in this file.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Ideally, patch 37 would be split so that we see the decode and such that use these 
helpers.  And so that patch 37 isn't 548 lines.


r~

