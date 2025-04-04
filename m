Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2627CC3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 13:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0gt4-0004zE-NJ; Fri, 04 Apr 2025 09:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0gt0-0004we-Vb
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 09:15:08 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0gsy-0004up-Lc
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 09:15:06 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ff799d99dcso1895122a91.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 06:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1743772503; x=1744377303; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JwSA1LrA+gdPCuc648AN28U3mqTmQDlX8wziMIz8okU=;
 b=S3RUStyWQJ9HrbCPppZQTCIH9PJ+n2MI2RHJWLUyybKWMsNMRZ+NhU8GtR1lWlhFFU
 GKgcXWQXWK+jOQKSrvKrnczNpSQiFt/twAIE7P6nZnHHR51VC9uJI3H0R3mVVGwRLUiX
 r/FT+2ByaTS7YLBBYoz3iaqemDwF3MmNn0mFsXRn5vvGmEQ1A2ZMBrpkEEOd9OAiBMLW
 1wan6ErOk4PobBGehDBbni6hZZQP7qayU8HM7p1E56ewfJxbUm34EI3piIe9zTjq96Yu
 xvZSnGHx23pVb1AvwWCDpCJd2EEf/4jPenhTFj1hV0v16z38Ck63+/ayVFfZX9IgubEu
 ktLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743772503; x=1744377303;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JwSA1LrA+gdPCuc648AN28U3mqTmQDlX8wziMIz8okU=;
 b=iEa8D8oj5SL+qETZJwmu19f2rVlzpDIXFN1mHhgurzzSzPQBA2a8tLX2cVhPUbnZfy
 6TqfCMlRkO4bs2Kwhao6t2kPIRsDi2g6Fya6cUPtRbh8fz+IbhTi5okv9TGT7uMm+sJ1
 C2v6p08IvEUdHr6Z69bYcqzRDhhfp2PTzaDn+X1NPUs/F0+aw8Vsw9i8DlVc1V1kJ8TQ
 scXkUU0xLF6L14ZC/OiGByr3VEHYqGdKPWlaiUJ6ZTt+m7rMh6eB6YOXTosZ7JHMjGOv
 YU/EDxOFBFH1cLqUkJmFsCTGgQMZc1HPPsO6GJkbGjNoCXEX0eY1VYhjg+XL6twMgdY+
 BCVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWVgmTgTNs0xW4jOjOs7CGN08PYOzK74UL0ee2pVHEuq25Y3B2VxsRcsqR0f3BOrEu3lDCBaAXZg24@nongnu.org
X-Gm-Message-State: AOJu0Yw7Zvxz3IsRsbV3XWxzpSMlzRCvh4nbb8L3pnUpqVYvitk5vu5J
 p4BGQTedP0jkO6xcdaYnuQwiu80ymJ9abz8lNbt1WRBt670ME3T/nTFswwoaR2A=
X-Gm-Gg: ASbGncufplKjirOmZk2Y5x/VnbP5fO9NeIrVWOZXRXMXt2e3TFw/Ui9iDjNYFys+P2u
 353HDM9wMPFibVAk01jH84tYk3Sbe0RU/h+GevSFjTpuVDkeQIVGeQ2fH5wwK+sZtLHlDsZPs0S
 kmaSiFRijw3qGgQAVGqVmz5/AYtUZY4+s3Z0CC2r6r+S3CV1tdn8KIQF13t+TWf/BSgD98n79ul
 jq64hL3xQ9hI0SSnWx5MZ7t8/PT/xmXHkzYaP5/+Gv5kO1kAtIJ13c6vgVQewcL98VfVShNeKOw
 koYvJ4mfv2DJHyahyVMlYGNZst2vmjuJU815wvFYtqTanF1qJN+0SqkMBaMV
X-Google-Smtp-Source: AGHT+IEPDVJ2x/VQzBXIo/LJrRX0FqTy3cRUmMccyJV9u1ZlIAG3zhtzuXG6mIZjv1X0O8JcvOe5sQ==
X-Received: by 2002:a17:90b:2811:b0:2f2:a664:df1a with SMTP id
 98e67ed59e1d1-306a61208c8mr3997006a91.2.1743772502846; 
 Fri, 04 Apr 2025 06:15:02 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.227.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057cb9500dsm3955429a91.47.2025.04.04.06.14.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 06:15:02 -0700 (PDT)
Message-ID: <95b4102b-2501-4030-8c3d-32b642c6d603@ventanamicro.com>
Date: Fri, 4 Apr 2025 10:14:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0] docs: deprecate RISC-V default machine option
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20250404122858.241598-1-dbarboza@ventanamicro.com>
 <cfcf9a32-1745-4d46-a2a2-977a0d0af195@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <cfcf9a32-1745-4d46-a2a2-977a0d0af195@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1033.google.com
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



On 4/4/25 10:07 AM, Philippe Mathieu-Daudé wrote:
> On 4/4/25 14:28, Daniel Henrique Barboza wrote:
>> Commit 5b4beba124 ("RISC-V Spike Machines") added the Spike machine and
>> made it default for qemu-system-riscv32/64. It was the first RISC-V
>> machine added in QEMU so setting it as default was sensible.
>>
>> Today we have 7 riscv64 and 6 riscv32 machines and having 'spike' as
>> default machine is not intuitive. For example, [1] is a bug that was
>> opened with the 'virt' board in mind, but given that the user didn't
>> pass a '-machine' option, the user was using 'spike' without knowing.
>>
>> Being explicit in the command line is desirable when we have a handful
>> of boards available, so deprecate the default machine setting from
>> RISC-V.
>>
>> [1] https://gitlab.com/qemu-project/qemu/-/issues/2467
>>
>> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   docs/about/deprecated.rst | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 76291fdfd6..0f41a99c67 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -304,6 +304,23 @@ online to check that this board did not completely bitrot yet). It is
>>   recommended to use another MIPS machine for future MIPS code development
>>   instead.
>> +RISC-V default machine option (since 10.0)
>> +''''''''''''''''''''''''''''''''''''''''''
>> +
>> +RISC-V defines ``spike`` as the default machine if no machine option is
>> +given in the command line.  This happens because ``spike`` is the first
>> +RISC-V machine implemented in QEMU and setting it as default was
>> +convenient at that time.  Now we have 7 riscv64 and 6 riscv32 machines
>> +and having ``spike`` as a default is no longer justified.  This default
>> +will also promote situations where users think they're running ``virt``
>> +(the most used RISC-V machine type in 10.0) when in fact they're
>> +running ``spike``.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Having users specify "-M virt" doesn't seem much of a hassle IMHO,
> so I'd not use 'virt' as the /new/ default in 10.2 (but we aren't
> there yet).

The idea is to not have any default machine at all. Users will need to specify
"-M <machine_name>" in the command line for all RISC-V machines. Otherwise we
might run in the same problem again if another RISC-V board becomes more popular
than 'virt'.


Thanks,

Daniel

> 
>> +
>> +Removing the default machine option forces users to always set the machine
>> +they want to use and avoids confusion.  Existing users of the ``spike``
>> +machine must ensure that they're setting the ``spike`` machine in the
>> +command line (``-M spike``).
>> +


