Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294CFC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 06:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uliK7-00026l-R8; Tue, 12 Aug 2025 02:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliK4-0001xZ-Eo
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:17:24 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliJy-0005At-4Q
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:17:24 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-458bc3ce3beso30674845e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 23:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754979435; x=1755584235; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0aaJFF9ub0BrIDT3m2SLdCBFzXbPk99xPmToZgy/WAM=;
 b=VmRBucVHsQC+O2BOyDsDkj8Oy+GH2ZdwKn7utX3Yf1R+Q4HgRiSJ4sAV+2528AprTB
 swc8orl5i4js2udTuIBqYdljNu5APN9D7hMjlYZRDsA5lUnXbE7s4NNi7NVWC5wruV0R
 8lh5CTAjqgUcFjduG9YzUJ+rgVBt6MIBig5jZmYLC2yPrUFCBkJLsfbh1KhTsuM3x+vV
 iPLGPIPaexDUmyhZsHEhd7uh2Oh46Y2OsHhZ/F/viTei6vbs8oFqyYU5KFUztgwU2IFC
 KdzCsvecmHIjo/Y23aYrJH3LojZUGUJIZSVFz2hNOAlr1yXhXEaIQfwBlJUkhqGmyV5a
 CpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754979435; x=1755584235;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0aaJFF9ub0BrIDT3m2SLdCBFzXbPk99xPmToZgy/WAM=;
 b=f+GMjYiK5jidvNOKDEypwgIn24eXJ3uvhv3yjpsRf7cF+rjCfciGEunek9rRsp7BKk
 pkC/SM/X2VCz1knDiwyMWiRSJ4NX10KLcMPtynzpDYUETNZRI2zJERfFID4NhUE+OkUM
 WW7+KiJV+EDrwMLPjYqrNQOmSKCyj3WKWcWMiS5PjyrGgdVqpyyhiyQKBLoW4E2Ipat4
 L7hKVmy/xUFuEzMa8QG1gEw+MhRoHpk9qpd68mKQOyPoWvhnfuXfl6HSt7M9CiKW0QXV
 vvR9NHoRp3ZsDRCg5W1kmTiMibgmYKvX7iUV288TcxeMRRRnxGoHeyP9fSvb859PGbj/
 c1jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6PPfGEBHVKAS7a3XlO97q62PEVL3a/qQjMe61zulIaCWwr6Mg39zhUp/uTCC/i6t8n8yU6bgD/vUu@nongnu.org
X-Gm-Message-State: AOJu0Yy0zp9zv9ifY6ybvdMxthkPzfPyB6T32Ip5U7ioIcn60TyCrhAh
 OU86iKzkubRDxrLcca3wQ4AqNPKT4eGImLPx51aY61C8OFRyf8/qq8hvU4uwSspMseg=
X-Gm-Gg: ASbGncvJL5JBrz+J7xxJhKH9NeQoSWhN+unvpP5v1YcWTZzLg3TnDheKYOvvM8RMhzO
 +lIz5Be+ccWKoCAutDrcHB2YP1o98DQHtx6lJVxo5zBL+pjOhU0y3f+Ee4j8haPhoDJ8UXVSdBG
 FfAT3wEPkTctaZomiTlx2mxhdan4RPbpvA0gxWblxuFTutRXqXErCIQGMJVdEVwpw2HpeHuou/i
 DksuY8KM6P0MkNuTGgZb9kFMoOco41EBmmS3r5AlEE82MajQL0Y7HbOlmewpJhWuJa2vDcBLSbJ
 A31xWP/1UBr+DeMNFASf2o1MdkXGfboEpY3EQ+xGjU2wfm5UZRL0d0hc9J+Nl4DFWmMiicuCA0H
 wlYLKcsF5W2XjdnSATeKdKHa/wOOBe3QtO8tjJ11xXUWK/m1EHHWKf6J5i2rqQ96thQ==
X-Google-Smtp-Source: AGHT+IEz8/ZP+sBRhuzJdAS7ObfoRFYXnes6/p4pL/dEU/HJljpRKs8lqG2vak5hi+9mGjEh9RucuQ==
X-Received: by 2002:a05:600c:4446:b0:456:25aa:e9c0 with SMTP id
 5b1f17b1804b1-459f4ecfb3amr147385125e9.14.1754979435228; 
 Mon, 11 Aug 2025 23:17:15 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e583f9fcsm276171115e9.4.2025.08.11.23.17.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 23:17:14 -0700 (PDT)
Message-ID: <df4fecb5-a709-47ef-918e-2c163d17dd80@linaro.org>
Date: Tue, 12 Aug 2025 08:17:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 32/85] target/arm: Split out mmuidx.h from cpu.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
 <20250802232953.413294-33-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250802232953.413294-33-richard.henderson@linaro.org>
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

On 3/8/25 01:29, Richard Henderson wrote:
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h    | 207 +-----------------------------------------

Cool.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   target/arm/mmuidx.h | 216 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 217 insertions(+), 206 deletions(-)
>   create mode 100644 target/arm/mmuidx.h


