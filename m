Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA17CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 18:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPOv3-0006Ye-HS; Tue, 19 May 2026 14:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPOuv-0006R3-5B
 for qemu-devel@nongnu.org; Tue, 19 May 2026 14:11:45 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPOut-0006vm-GW
 for qemu-devel@nongnu.org; Tue, 19 May 2026 14:11:44 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso39653475e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 11:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779214302; x=1779819102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vnz1XzFSJSStdUnA1rS4qejoripcLv3ca0rE7CWko2M=;
 b=Y3MFZjQnOZW13xafAQaRmZ+apdrv2o4y0cSKLqE0NfP3BStLzUagtqYLV5jxu//IYf
 Pmvy9eEo3hOtGEjQ70Zi7BcJrCD/X8YYBeZTpZtleuiCx82qYiC6REqYc7dRwpCdQ2uZ
 2O3Y72j3xAKtd6iLsxRIvppq3bv2GzvI0qZwy0WxXg2WDxZbCAyfCB26BV6ss+iGXvn8
 Ur3Cc0GP4BeNkjomS5CatCazV/MlvoYFi8MhTJ/XrE8cjaStnSuNPw5GNP/ygLomqGIc
 0QpfuRAqBi3RDYa5SeXn3W8ayZtXMMjoCHDPSWidq870oZOpy1KjPR6bJkH/ET4EF9Yk
 +40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779214302; x=1779819102;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vnz1XzFSJSStdUnA1rS4qejoripcLv3ca0rE7CWko2M=;
 b=p1vYcw3hbOyzFJ0EuAOnobqnw/PacGFrxG56WAHc2QIlCpFtDRRyHfUKn2qap2ML5+
 bDiSgv4BmtTJFLbG7QIBPDXnZuS9ur+R9iSIwXPtDO8UyA6AChG+Rap6WJbwcy7kuej+
 ZTE/lmYKhiiFz7VKi8aoY7UxPMg9soQ/YEI1EQLmTlRMyKCa8YeCU4EMMlSmSXxFnmdg
 vwj/4+KCCnJGiKie1mHTjoXpN8DIqx5mveTqDIJhCwoMmgVZW2TLOFpm0V8kn97oFPdY
 zmlEGKqtzXMXr5gDleaNO8SQZBcV3+KUFGbzVVTnwfR26L6zyvzLd2D2FsveEM2YJpg0
 jYsQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sABKlOPCGoxu+WylaspGpUJ7XVEYOPbUy4VHD8/oNwj2sRMrbp+DS5ikG53JMEmmwI8k2SbJsE0Qd@nongnu.org
X-Gm-Message-State: AOJu0Yx2vdgEe1Cwn+evZkYI4KBxYiF3u2WFCu3zuFkrHLbAw9KZElge
 gAs+gZq7c8+MsisBu/+HdlnLK3VGC5h0KLnGbweVmpZ5ApwndHZUAmNm01z2oz1CUsw=
X-Gm-Gg: Acq92OEqyD4QsC30KUToyRw8vZzj9n4gDzaJY0OJRvFFocdwLUVHMz6a92dmF//t6KK
 VTdAyPGJjhbpZo9AJpsUioMnKJ3yw1+ThWqyZI9+dX7SakCUppBfZRioOdAf1EgTKGBXEih7IyD
 AbWiwHDyC+rnPY76uerQtgX6By8maQn43BJK2WDIdS/whhiG2pQA2WwTu8FVQ/YInisCXfAWd9h
 HD+9zgOja1vFWl2aS16SwtqsUs4eusMn9odaarX/DrbaHQuzejifGAktuZ9EO8og1lYs0/jZwoq
 /43bM+oPbai4Nu4rteuwev/Dl5ldij+gppBzK9JEoMqqfn1xbBuYEllne/NA2uhUTfXwpKMmUsY
 Osq20C0VEsajg5rnyhIInycdSyb7yn8+OR8Fu/Ms7TzDxhaN8hvJvZa0jbEYPmBRWJUcCxWOjjg
 n/q0omx1kF/w2Y2rG6PTzHIYmgL/mlg2gzDW1+p4F9WPGinEUydC5KoulgET+Jgmoi7SmUFzm5F
 Vvt
X-Received: by 2002:a05:600c:46d0:b0:489:1abb:5559 with SMTP id
 5b1f17b1804b1-48fe4dad784mr287304465e9.5.1779214301619; 
 Tue, 19 May 2026 11:11:41 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feab26ed9sm164215255e9.2.2026.05.19.11.11.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 11:11:40 -0700 (PDT)
Message-ID: <045ef26d-a90f-4418-b420-b49d43b64431@linaro.org>
Date: Tue, 19 May 2026 20:11:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 40/40] target/mips: expose Octeon68XX floating-point
 support
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
 <20260519-mips-octeon-missing-insns-v2-v9-40-d7dd735ecddd@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-40-d7dd735ecddd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 19/5/26 18:22, James Hilliard wrote:
> Octeon68XX cores implement CP1. Advertise that in the CPU definition by
> setting Config1.FP, enabling the writable Status bits, and providing the
> FCR0/FCR31 defaults used by this CPU model.
> 
> This lets guests observe the expected floating-point feature bits and use
> CP1 with -cpu Octeon68XX.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v1 -> v2:
>    - Move this CPU-model correction into a separate final patch.
>      (suggested by Philippe Mathieu-Daudé)
> ---
>   target/mips/cpu-defs.c.inc | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

