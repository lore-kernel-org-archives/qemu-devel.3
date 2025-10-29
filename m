Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C63CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 07:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE0qf-0005jA-SJ; Wed, 29 Oct 2025 03:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE0qc-0005j2-HD
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 03:43:58 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE0qZ-0000sp-0X
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 03:43:57 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4771b03267bso10340785e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 00:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761723832; x=1762328632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L1CwPX4njVcEOio7vbRUzYzA8dhQHfxyrSBDykpNKQs=;
 b=MetNX6+6gr6styiCp3P0E+L/++q1TPkwhVDgeX4kyEhR/fXVvt5aMy6l11kyGzkRhE
 sGLP+xdPCcMAq+cz6InPQAC6GizlEM1EJikF764EGYmLjDhznLEFtKi9yVjXGxWNz7R+
 IguX60LUDA7ixtLqL3v0M2JMFSr6071iX0wVWQdMVPHS0c5h7ViW5dmqznDSMscVbyxP
 RUF8yNiu8YBCQeUgH/nKBRj5L6A46Q+VIUF2syeh9Q6Pc3D9FyeseA5KPkMgYvJu4bIJ
 j4L0GZDRvdAz/tLpeXsNtYjxS8dut5AG+3JkjcnTspRpCnXCOde0xM5C2/WUnXAye6dI
 qrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761723832; x=1762328632;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L1CwPX4njVcEOio7vbRUzYzA8dhQHfxyrSBDykpNKQs=;
 b=EEtL92aMb4X2RDIlST3WevqDgiBS9iV4fx4sjeoTRsLbagYd8/kP/7dRZbSOCaohxJ
 ezbdqSVvyr5boeYuXZvrjRaaSsDeF44l4PUURu74ksWWEv1O8lSEPWl/4/Vo0ZipVMJw
 w/hHR2qQYansJ0h24Mi4978jNpf/UEqbIsZ2AxT2TlEtNxBKI/MI54rv60zOQI1z93k3
 IW61zJQgCkfRc6sn/QI2WnvCbiqQoeeoQdnvrnrAJUJZttmerSXvhgCjNQLiYn5+ajIG
 ZBZA2jnxvGGObeeIhZtLYhRtlDifW1EbjYvQ35M8Ixo/gAABCuKcbf1YW17W32dBXr3/
 5v0w==
X-Gm-Message-State: AOJu0YwIGQxuGjf6/BuB/9fepwgSHSopIFCHeaaAOsS7+gZoaCwGlnyc
 gac9DkOdbWMNtLVmMw6/58cylZBsrD2WTdSQixkWESL5WUGg4eAvM6REFsFzFl6fQpABs+nHu5d
 N8077WdM=
X-Gm-Gg: ASbGnct7XPPOFrsyRBK+r6LFnUn/V0vN4haSfbCxvym7i+3p1piIf2cBn1pN/MDTRPM
 +x5LgoXlWuyGQgleGzsy/DHc0dX8uS9hShJEEMPf3I3a3pX5Jlc7A2z7EtV/xMBjwW/WkAua3Cl
 UlCKRsu8nbVsmcgeJjD/SRQVnaTaj6Sx+6AknQRLRQLmQAH7Oed2A3iwIrkOufqLaGdrOi9AoCM
 PHahxt2DCj/zrxSBnZ0ZflqNpDUlTed9qjq5AJ8gdOqH2AwpdW8dTLV63gFov6/DanXtPWtxAS3
 X3TuNu8OHzFkJHiSZAgTUq0R2vn+Nvt4luZRh4DgB4IH1DCM+zRz46kwMP0LguQgemJROAFDmgR
 KHrW3jSfYOq7uq5uyrK1/YVQGj7fZUQkqbE4/5b/yDr+mmLr58xnNFgiGtkZegJQIrAXm9xcSsh
 PQPSSAihPO6XOA0UJc
X-Google-Smtp-Source: AGHT+IEMYyZ03lEzGCHLPEhSxTE5htFaVTJdWAZrgnG8H2RcY1hJxdlytZODkfueH/w68/mUhdpVYg==
X-Received: by 2002:a05:600c:46c4:b0:476:84e9:b571 with SMTP id
 5b1f17b1804b1-4771e183b35mr19068535e9.14.1761723831548; 
 Wed, 29 Oct 2025 00:43:51 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e202182sm37735375e9.10.2025.10.29.00.43.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 00:43:51 -0700 (PDT)
Message-ID: <ad0f776b-c712-4855-a034-8f93f3a3c0af@linaro.org>
Date: Wed, 29 Oct 2025 08:43:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: Use correct type for FIBMAP and FIGETBSZ
 emulation
To: qemu-devel@nongnu.org
References: <l6slswtmabktu6g23so3sldafschilwbp3kqolny3lppjezosi@hn6ptmklek4q>
 <aaa82a95-e15c-4e0a-b229-16761bc7793a@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <aaa82a95-e15c-4e0a-b229-16761bc7793a@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

On 10/28/25 14:55, Michael Tokarev wrote:
> On 10/28/25 15:16, Bastian Blank wrote:
>> Both the FIBMAP and FIGETBSZ ioctl get "int *" (pointer to 32bit
>> integer) as argument, not "long *" as specified in qemu.  Using the
>> correct type makes the emulation work in cross endian context.
>>
>> Both ioctl does not seem to be documented. However the kernel
>> implementation has always used "int *".
>>
>> Signed-off-by: Bastian Blank <waldi@debian.org>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3185
> 
> Reviwed-by: Michael Tokarev <mjt@tls.msk.ru>
> 
> Again, I can pick this up through qemu-trivial if there's no
> objection, Laurent?

Please do.

r~

