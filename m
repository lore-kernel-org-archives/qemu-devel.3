Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8808CFB42B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAM6-0007bv-TA; Sat, 05 Oct 2024 15:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxAM3-0007YN-Jm
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 15:22:16 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxAM2-0004TU-85
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 15:22:15 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20b90984971so33795415ad.3
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 12:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728156133; x=1728760933; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4qa5U/WRGKMBiecK9U1B9AdTSGmSBQnul2adtooYzuU=;
 b=XvVG+ISdDAshm8kFh52j8a5/evCTdoUX1UTqGC8U3WKahKJY+FvtZXDMX0A5EVl5lE
 KQX6K/FnQ4hhPSo3MWFb1h5CuQ40SCiHNOXbmq3JFYJ53FzZPxUQzZteGbpvec9Sq26Z
 kQOcpRR99JOryGCCr/qMIk1/x4THpTn0mOX4xiJbmXhQoEY7XJ3TfL3QOdKqcfJwGupM
 IrCDOq4+Ng/8VYDwr+oXHUIBr4nkHn/WUPUJSwghPStVnt2Vjg1pIS4lpivihyrpGzLq
 VNsVGzpC/M9Z9j7T6NjZddE4sy9coSRDtN3StfVo+RtrlzKy7bO8Cxv5xFnUlmYHOec8
 oIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728156133; x=1728760933;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4qa5U/WRGKMBiecK9U1B9AdTSGmSBQnul2adtooYzuU=;
 b=egW/tJIIGmpl1N7/Mj3iIKti3Klv6CsX41ZgaxUTybHSbfniYSSlAwQO92wUe6mpjA
 4V/YgaHqgn+JKeR4igWFu571P5Ev9bAVn6ueMhzmqRozck9pwF4YTylvgKJBg3HeX1bY
 UfjSvNFFq0YV4mQPQg5EHFLYoXASOYvbnSRz9Nw6yUvAtc6TeimaNhcrSKNFrMumHcFX
 8Zg7RscYbH2XAebk2qCCShKheMMyPDttiIM9QNQO91fqXsC8rvi1S4cwpq1J0fh1ZBaZ
 aaS7GTE/xV8dpuQBZPcHncdmVvxYyZlYbOW34MagZ+XsxoQIwJGkFvMqG4UuUJ09XGfj
 AHnQ==
X-Gm-Message-State: AOJu0YzkXYMAZzqM30Nnt4B4sWyTWq+e+1gKyfbJt5XbtiWS51Rur6Zo
 DSsIJbLqKRpjw7fBdnN9QXVzxT0rt/cjCa+Dq0AFas8XAQA3s2eQL1XbxycUqKI=
X-Google-Smtp-Source: AGHT+IG8wRJGLf1XX+sirWW0hXLsnFQpjT5kTG5I6IArsgTJzKy92jJrSpmtpiwWFIZzjrQPzX/usA==
X-Received: by 2002:a17:903:32cd:b0:20b:8341:d531 with SMTP id
 d9443c01a7336-20bfde659d3mr111975695ad.4.1728156132768; 
 Sat, 05 Oct 2024 12:22:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138b1395sm16298875ad.3.2024.10.05.12.22.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 12:22:12 -0700 (PDT)
Message-ID: <ba86812d-4612-45cf-b2c0-5857338c8a2c@linaro.org>
Date: Sat, 5 Oct 2024 12:22:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] gdbstub: Move gdb_syscall_mode to GDBSyscallState
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240923162208.90745-1-iii@linux.ibm.com>
 <20240923162208.90745-4-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240923162208.90745-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 9/23/24 09:12, Ilya Leoshkevich wrote:
> Follow the convention that all the pieces of the global stub state must
> be inside a single struct.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   gdbstub/syscalls.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

