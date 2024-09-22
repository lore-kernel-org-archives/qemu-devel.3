Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FD6CF9C69
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 04:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssEUh-0001NB-RT; Sun, 22 Sep 2024 00:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssEUZ-0001Jw-6j
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 00:46:41 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssEUX-0000HL-OH
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 00:46:38 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c5b9d2195eso839176a12.1
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2024 21:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726980395; x=1727585195; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z4wRGO3WMtZOMMRmXRpzMnVueAGeW7bgzBASsvxYp40=;
 b=erWiYaw02YajNjKiubaVAhOU7jBSOtbkN6pcfYQbFSyRTi3hm3KLJOCVWm6hNj9DW3
 daHQjzBgmNsogRfAcRSRwZEfOmcuoZyfk2U+VxGyaOQGOOKeS44ThRTL0mOf8zn+bHEL
 kPiDvJsjjJw1pIBHfx+A/42vdpZ9szWsNYJjk9UR5HhDRd1IVC/4EF2XZe6d2uc3GtDr
 NGj93lqo+wZpYx3avkmfEBG3oKsKyVJHGsghvzbOuDM1jZyhwo1gzOGVYCh1FsRZIBve
 Sl9D77zxP4ivMNg/UWN54nwpK0RYQ47nW3i58Wg8xeAbKwweI5hlPZVV8oWqaDP3hONE
 4zuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726980395; x=1727585195;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z4wRGO3WMtZOMMRmXRpzMnVueAGeW7bgzBASsvxYp40=;
 b=BZ5A3uNeVBuXBqnJNwddfDThQVqQ3lMcJYOoY9odDatSFdbV1iyV2XYIHhLro4QqJt
 +Npd/zTqG1Nd4C+Gexk7J3CzKRuhKGtAzJbuGMiJvVLqecx0g2JRR1BZ1x5G/6LNy0Gm
 kS3VBz0oDAi2SwT2Y4m5sXEq7XVO3w6MHR0dAGD8ql8svnfdEJdLbRcEB6+rmuNvJ1ly
 s+gM4OqQttfA4LHcJYTkX9dcETzyhYQO0984/DxJotm649H9VkCWDWVKg9QGZ4/BD77m
 19nHANRNbaFS5ggJK+kMB23tVbmklOeBI1jL3YW8zczXz8bahdgDlq98z9FW1ihAIs3Y
 gZqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnlEVB6apddWKEb9JT2P8v2MxLxCNUE+VbQdfl/sA2dIDK1h7ZUTF067H6pOcZrF8whPGtL1OiTt48@nongnu.org
X-Gm-Message-State: AOJu0YzPi2vALqK70H5GofXkjB/+zLwcLjyP7T3rKc8HoqvI9C/180FR
 V9JYv11QIwN+mR3oJxt0+YvTUwrMBN7/6ZzaawAZKSb5ZZulhFznnRiv+0l7/UlyK1WtK68ijqT
 /t9mLZg==
X-Google-Smtp-Source: AGHT+IFmYr52nzzI+F6Vk4Fnvs9/GvGw/ClnP4UBcO5sxIdB1mzMPxNCU+G/hSj6t51AUVaTgpXXHA==
X-Received: by 2002:a05:6402:208a:b0:5c4:bcd1:9c7a with SMTP id
 4fb4d7f45d1cf-5c4bcd19f20mr6736153a12.8.1726980395294; 
 Sat, 21 Sep 2024 21:46:35 -0700 (PDT)
Received: from [10.5.50.249] (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bb559d8sm8856309a12.22.2024.09.21.21.46.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Sep 2024 21:46:34 -0700 (PDT)
Message-ID: <0dba42ab-83fb-44f8-9802-1f2e53bb89ba@linaro.org>
Date: Sun, 22 Sep 2024 06:46:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] tcg/riscv: Add vset{i}vli and ld/st vec ops
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240911132630.461-1-zhiwei_liu@linux.alibaba.com>
 <20240911132630.461-4-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240911132630.461-4-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x529.google.com
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

On 9/11/24 15:26, LIU Zhiwei wrote:
> @@ -2129,6 +2389,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
>   
>   static void tcg_out_tb_start(TCGContext *s)
>   {
> +    s->riscv_cur_type = TCG_TYPE_COUNT;
>       /* nothing to do */
>   }
>   

I recently realized that the vector config is call-clobbered.
We need this reset as well in tcg_out_call_int(), and prepare_host_addr().

In prepare_host_addr, place the reset just after the two calls to new_ldst_label().


r~

