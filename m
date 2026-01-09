Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C771D232E4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve5fx-00082t-Qd; Fri, 09 Jan 2026 01:08:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1ve5fw-0007x5-AV
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:08:44 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1ve5fu-0001qa-V4
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:08:44 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-29f102b013fso39459835ad.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767938920; x=1768543720; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WAarLkmwFp9SVRbOLD+AU6z0XBmQBbcEZe+JnpsUyqU=;
 b=l3Fx8ql/xRICVjxpjP4FEMew+8nMlkXoHN4tVEakl33oZYOMRnme92GMbAHSBBc+xA
 jtv0H0uFCYcu/B6Gf03g8Qx9gS9PaLwQZ8+wEnrR9lCN+enFt3D1m5xzmSCMWoWeWiVx
 bn/NzWOrhHue2uoGOhph9+zbHcJEZQx+Tn2wHTH+GRDoxwWPquOv/1lIyygaeIfg7kzb
 MXdv6O5M7t8UUjVU0w+kc++WB0M0Vj5xlmR4iHFueZUdpr2GRo0TnbNhLgPCUoDbViwR
 boR6qrVPwviK/o2EOV1IiKYdniH5TssQMd/tlPYbgcUEN+fH0KHT6C8f2uOAiDD4Y/db
 1KQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767938920; x=1768543720;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WAarLkmwFp9SVRbOLD+AU6z0XBmQBbcEZe+JnpsUyqU=;
 b=UBXKFAj8Tr52JCosQx4rszwT0ki9STFiA0dFp5jZzwXnE+t15xfxdfwh3TS97JweCz
 c8ooedF0elHAA/WqD21mRS1Jkt0+jGxsBzMt/DIITtIsgxVSA+GXROpqy1x4OYQ9Ku71
 VLRrgePuXDktpWxi5U17E1g5+v93VRRvhIl10YbGbd2gUXmSyYxPBIb1LclU6sTicnQv
 /GlMD8sARXORB0ZVjkWJV2jPppSRQmFJbKsDxhr5bGWbwuo8U+v9h8Zg+rbgGbLJZwWq
 JkyiSy49y0YeXhZg29m1fwZohBb6ghNq0k+ErSAnODXW7Zic92Bs+ZJdU/fLeZ4+7gyR
 6jWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNzHq07k9HWG2ABRK/B9udLwaJOznn1P0YebLc9ojgR9KLXKJyVOonrF8tLLQvNwlXPIa/u/5RheOC@nongnu.org
X-Gm-Message-State: AOJu0YxN48yqp0mL9nWt5gytBqiV2oH4xB1OnlN8xkhqv7dyE+tXb5yF
 /gTx3OdE+HXUXDuYwPUDLEW3+i/OZTOdHrxlDyuBrQUo3PsjqH1haX4Z
X-Gm-Gg: AY/fxX73jGR4AEBlbABq9rYHsMpVJ1kj8tIghDTTz/w+sPExwkdZ3w1YIcwE387rLs9
 BW71FfNCM0mS/sOMvkAtvcqZnULev5RCmv7Ify0/4diQoCfxtBuY9hn0NnOhbIDyWk8dc3QvSNw
 rVKfnqDw9vIR0mFPnZnnzIuzg6+M3Jxk2GV02T4pUHT38KWGJjH9byqLRM7/t7FovX+n8uAlrrf
 rJOIlbNO8BOHjQHx6X0wLGLES1oeQoxaR9Nve9Mgd2c84pLC9/x9dGQlnKJuofNdZ3BFPbFyJR3
 RnORYGNjv/XSEB+deT0JYCeWzBWeNXTHOubJqeTrdyFSymxsaYbsYfsnc4NC1aIYSaKJ3ojVoVj
 NyJP/1AY7hYq0xRFrm9cavtevZd15f66+6zDCxvA/WoUmkwoBorYCrH+/Z1O4KjNk4x11p5TAz4
 nz+I3Zw7POzOb7tlHg1Up0/jhZJDs=
X-Google-Smtp-Source: AGHT+IFLohIUbCEU+3FRlDl1oOrjo5iFO5fkrJsA6DhBNzVgLem47ykq6C0PoirhLdIGWp4FbZkKzQ==
X-Received: by 2002:a17:90a:e7cd:b0:340:d569:d295 with SMTP id
 98e67ed59e1d1-34f68d0bbf9mr9101498a91.24.1767938920194; 
 Thu, 08 Jan 2026 22:08:40 -0800 (PST)
Received: from [127.0.0.1] ([218.81.29.112]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6b29e117sm2983235a91.2.2026.01.08.22.08.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 22:08:39 -0800 (PST)
Message-ID: <44fbdde3-ec82-4c5a-a3ec-0d67540baae8@gmail.com>
Date: Fri, 9 Jan 2026 14:08:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/18] fpu/softfloat: Add OCP(Open Compute Project) OFP4
 data type
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
 <20260108151650.16329-5-max.chou@sifive.com>
From: Chao Liu <chao.liu.zevorn@gmail.com>
In-Reply-To: <20260108151650.16329-5-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pl1-x641.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


Hi, Max:

On 1/8/2026 11:16 PM, Max Chou wrote:
> This commit provides the basic operation support for the OCP float4 data
> type(e2m1).
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  include/fpu/softfloat-types.h |  7 +++++-
>  include/fpu/softfloat.h       | 45 +++++++++++++++++++++++++++++++++--
>  2 files changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
> index 835dd33bf1..82a54e9e6d 100644
> --- a/include/fpu/softfloat-types.h
> +++ b/include/fpu/softfloat-types.h
> @@ -120,7 +120,7 @@ typedef struct {
>  typedef uint16_t bfloat16;
>  
>  /*
> - * Software OCP(Open Compute Project) 8-bit floating point types
> + * Software OCP(Open Compute Project) floating point types
>   */
>  typedef uint8_t float8_e4m3;
>  typedef uint8_t float8_e5m2;
> @@ -131,6 +131,11 @@ typedef uint8_t float8_e5m2;
>  #define const_float8_e4m3(x) (x)
>  #define const_float8_e5m2(x) (x)
>  
> +typedef uint8_t float4_e2m1;
> +#define float4_e2m1_val(x) (x & 0xf)
> +#define make_float4_e2m1(x) (x & 0xf)
> +#define const_float4_e2m1(x) (x & 0xf)
> +
I recommend adding parentheses around the parameter `x`:

    #define float4_e2m1_val(x) ((x) & 0xf)
    #define make_float4_e2m1(x) ((x) & 0xf)
    #define const_float4_e2m1(x) ((x) & 0xf)

Thanks,
Chao


