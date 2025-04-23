Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E375C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WVL-0007J8-Fd; Wed, 23 Apr 2025 05:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WVG-0007Ge-Au
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:34:50 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WVC-0007XA-O4
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:34:48 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so43704735e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745400884; x=1746005684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VN8bcQmVRjvzwIdw9ZhvlhusCRz3l7u7rz/rEZAhAUE=;
 b=G16EEyfTcHGVX4im50LZqhb/fI1035RPBajwp0H0zY8Mjv3ucRRR2sKiwslT6VFo8+
 VInJG0C27QOxWJZaG5UzWGF1vo0292NOTCh8TE8eiHtuGV1OtjmI4P4k5FjFnolmJbNb
 8RGbMmdMxtR/bo/DkOvT5ke+lz+G+qzfPIkUTJ62z9Wep5OBpLwNNAv719TsupXAodTF
 JWivEgq6vY2K/x2Ufe+8tcM8lBP/k5QQsileJj+b7CmRrUxISaRoQ+u5TwqPm+kj7LeV
 OIs9TQyc3yzLguktBuLoyTH1mNI9D+RBFJsdDftLzaIQaw60FD87AepURph7iOMhC0tE
 sHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745400884; x=1746005684;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VN8bcQmVRjvzwIdw9ZhvlhusCRz3l7u7rz/rEZAhAUE=;
 b=BoQDX9Xr1T1QJvhC23wAlEabzDoE1OeKypT1cvAscSYmWaLV9LBrVorjQ1/4y8zbwT
 3d/JG52lObNAj03ye9kPhl9cxXyNRphjW3ngOXqFUD2uwylZ3mhcNayq8JKFijbC5gVg
 f8XFbTu4JMlXCrRU7/KL5CYunOOFksdrimweFZZw+fs7JYo7zRbFr37hTAotJ/+RDj2X
 gGYezsEdczaQqZuvjy34mp/MsJHb4JHIbnTqcQWtm2hdgikE4EWjZZvv3T6Ei3pJUebT
 lFnJkb6jqDkjvkpUml1y0pAiuL1qkDaIMA50yMYZPgbuNwRfZt9ERSdXKR9fmQKjNXaW
 xYmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6+NexGeKSraLqY5laal1tIRNRnOPBx9a0zyuQpGh4SmlSOe85J1Y1qYgjzShSyfVpZBRh6JOG58bY@nongnu.org
X-Gm-Message-State: AOJu0YwvSMkZyR7/1pOAM68aPWgvAGHZV65rvteNHU7kNrzYBLDaFyLY
 WgqZCkwRPoBfY/xSf8jLfJZJmpuxAVGDaQOuH28xP3avdqHHyP5IJMCBF0qW9Es=
X-Gm-Gg: ASbGncsxapkyCX6MaPbu4ZFFhZAJnF3b5FXFflFFbz2k+mgdMrEdkvnfAfZLUxRlh5H
 qF3bRUw4otbVOfhqVV0rkIKPYKLX7NCRleuyzFd2Ug10YY6yxQYEQ9yOVrhJU+zSqPODgNwNB1Y
 BVpZ5XffUyGKqKaIkcqIR0z91SIGa3CED7bKCVMKZTa1tBWTpegCaJ6oeQO6nuPUDisNlH9x+by
 a8Q8belTScDXak5o6D6/Mx2M3QIdOm+PkhtVNS+jewp2SJa72pmxUt/sDcpxr+Em+YV0l/gih/5
 yKNorPE0gRH8+K7D2QKFC6fT0qFdDcnNGrWY+IpJUGacHOKyHnvh2csKZMcSBt2sb4mpX1p9eaq
 uLc32zu56
X-Google-Smtp-Source: AGHT+IG6Sy4fAzQfQ5vPbJPGDveIUs2UzkksDUbvzkxbaumTXWVBLgvrT23N/99lyyDDEdjUPPcqnw==
X-Received: by 2002:a05:600c:3b92:b0:43c:e70d:450c with SMTP id
 5b1f17b1804b1-4406abfba9bmr140675325e9.22.1745400884629; 
 Wed, 23 Apr 2025 02:34:44 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d2d4fesm19343025e9.20.2025.04.23.02.34.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 02:34:44 -0700 (PDT)
Message-ID: <8b670611-ec47-4759-8415-c17f1b9c2091@linaro.org>
Date: Wed, 23 Apr 2025 11:34:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 044/147] target/mips: Restrict semihosting tests to system
 mode
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-45-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-45-richard.henderson@linaro.org>
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

On 22/4/25 21:26, Richard Henderson wrote:
> We do not set CONFIG_SEMIHOSTING in
> configs/targets/mips*-linux-user.mak.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/mips/cpu.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


