Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C16ACD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 14:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUmUr-00021U-TW; Wed, 03 Jun 2026 10:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUmUq-00021M-FL
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 10:23:04 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUmUo-0002WX-Ts
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 10:23:04 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2c0c3184c71so26860175ad.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 07:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780496581; x=1781101381; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5RcW4QfYo+x0HtNnKe/k+Iy1vLlobEggfJqr+oVTKe8=;
 b=Jk5a+KBIP+Ot0s3VAjukskajM6C2B9+wt4uyBmxMFGJiHwx6o/IUNwIJdWmTs9CVI8
 WrDDWowC+HoljPyzJ+EOzWCHkSHTCHYdTnKRwWLeUsgNPkzbD44G03TPZ/zxNDmW1aRB
 1nv000be4dgjE8juVWAU/MNhkBjyvor660ZQJ25Q5yIhi2FT3ZtUs39y1Nr4aNT4QW1T
 1NLULop3wy/O1FyDqnxyq31ivHNEJuJaGaPe25dndxwjnaJQLFac48fE0iitEcJA/HWE
 fBsRzRNARsHyh5Gzoc3H61Rt4k4uGTvn+F8qmp0lzRGpvJ6tCZayrjfzSvT14om1s/Q/
 QPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780496581; x=1781101381;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5RcW4QfYo+x0HtNnKe/k+Iy1vLlobEggfJqr+oVTKe8=;
 b=bCFFWg1rgqMfYa1LkXVXLXcxPoVcC+GRHrUwwTR/Rrsh5F6RnW3obeipCMy+JCbh3v
 g8eOr1KkWkVMlXd3uRp+oVUM5PFRm+mWK7Nerz18sL1q+Orhibry9nMX0XN9yHej9htE
 lktUSacE8lhXlbZPlbV6+MxsO24dHQwfZ6GpQoI/E1/Ffep53Vlq3ex8rATKRQz0/UJw
 kOxsVC0pBXf5UY6rkFT3wod5a0PXinKTBQpsc5Cma9zsLsVqNPzMhY3f4Ks8aOoNCiXd
 QCzaUCBUYJ+ZCEMi3XBp7iKOPL8IFPInffiY75Y+Ukhw22qvjZYZGlm/iqFgAICs0ckr
 e6/Q==
X-Gm-Message-State: AOJu0YzOE/bkPILah8gqBBWGHYpWrKB9ExW5pZ1Wb3RYmBW6arEISEaz
 RfQH2mzY+bdewtYG3OpFmsBiUZ34Q3gPc5CRRBDfpjbVz2B/F0rLz1IElvTdK/+PGUY=
X-Gm-Gg: Acq92OGRASMQFa8jsAP8d2TdbDBTW5SRp7ImkXyjg3jF3XZEZrnxqzlCdy/kMjJajG6
 kHFDXFfI2YjQYC0eOfqdxaOXnMZg/FNISAbK+EIn27xKImMMVWIMZ1TlBX9GlOPZcqJiQipIOlR
 20CeFl4eNohYpob/YRjnKxWzojN88ceUntzlafD0gXuzm2/ssjnXY7FqA71uuGbexK78Oji7Ij8
 vQhoEzVf+JtpcYPTio32eYKJQcFIVzgt8HmElq2Q/Kp8mQj75DMaqFTofWztO1Kbj08ogwHwvyz
 MGwuWEHa0mBcUDchLfDhvZz0eMkKGyH57ptTmCFJgJw5xaNwTJJi8XwwplzD1KgBbrGJ6JDWskx
 xjD4vENDBrfWyltKBbvupQKYSdgBaAA2fiQKXg56xOZCvVUzbQqcBjnrmphhMN05CyoIhYDNFl4
 yqxNsasTwbnkRGa7mUcEkLiNX4Jg+oEYI9nSH827u8EF31KcU=
X-Received: by 2002:a17:903:2409:b0:2bf:379b:53ed with SMTP id
 d9443c01a7336-2c1641b7449mr43009615ad.27.1780496580879; 
 Wed, 03 Jun 2026 07:23:00 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16649d2d4sm26252005ad.77.2026.06.03.07.23.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 07:23:00 -0700 (PDT)
Message-ID: <17132c4d-c523-4459-b1aa-236c9046e2b6@linaro.org>
Date: Wed, 3 Jun 2026 07:22:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: replace cp_regs hashtable lookup with direct
 array index
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260518-enhance_arm_gdb_get_sysreg_performance-v1-1-f0a5b22003c0@gmail.com>
 <CAN1cRoPWtbqKgxKPT54=qF6p4Au1y2Hd8-9xEQ+CBSHffEMMVg@mail.gmail.com>
 <fff37ec8-1242-4c45-b2bb-d17c672757db@linaro.org>
 <877boguk7a.fsf@draig.linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <877boguk7a.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 6/3/26 01:00, Alex Bennée wrote:
>> This will not work, because each ARMCPU has separate cpreg info
>> structures, and these structures only have the lifetime of the ARMCPU
>> struct.  We create and destroy these at runtime, so at some point you
>> may end up with pointers to freed memory.
> 
> Shouldn't it be the same set for each CPU though?

I have thought for some time that the cpregs should be stored on the class, not the 
instance, so that these structures are shared, but it's non-trivial.

r~

