Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44976CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 20:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3gqj-0001BN-Ra; Tue, 30 Sep 2025 16:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3gqh-00019p-Ew
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:21:23 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3gqQ-0005hP-Fu
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:21:21 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so286280b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759263660; x=1759868460; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=chroxaMcXXklg0mNDfVK0K+0CQfyf+yZccQB34+TIgE=;
 b=YfsV8lf4ue3373X0EhkOhcDlAcZHOMvCNlwHIi9Uot5MPV1ic/9yLSu5SW/EpyK1kQ
 qvs33gRusGGi/l7heFWTMULJ/29iDFwO2qaLKA5xILZEkO9thOrKExVCbDZxBk8DAWMd
 QiQILQFHMCat7qocESri9J8s1n5OY/O+PqYi3pOF0IVdC9SkZNe64fS2a183uzQqQMCH
 qZHwvGwb1n8S6oQ2MC6nd+xgnbhWo/wD8D+S34DVFCBHFyw+FhiFG9LgS5DNQBPGkSWi
 WMMSaQOqhppWYDgNAKZ3m+maKEwlppurJabceWYDq3bvvdzGkGCHkYoxUk8UagmkQQVW
 nZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759263660; x=1759868460;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=chroxaMcXXklg0mNDfVK0K+0CQfyf+yZccQB34+TIgE=;
 b=Gjfj/HHXsjOiSO9qRSTlF7z0THHhG6kN+eNyAFGAnL12VkiDnr4D6sfbY0iyiyM5AX
 0lvNK90UfSe3lLrJ3WblRCVwk9j/ZKv4NiCLwaV1ZXm/HtvRsh9vOyTxRW1OVpWxUI7J
 xSTGf6yR4v9h98CvoXYMGv9ABPoLbSmgere4MYzZEMqKLk7ZpqMZOUtQjYRElZnVVt2/
 2nDX6u9+1TsZpvX4aqNt21jFEmZ1LacEWo3PpBi5qd54jc4uLDs0Z/haxMTpyEcaA9QX
 b3yChvQaKLOk+eVsR8t2pM3ZIR2/Wr/zKYDT8AKA2YF/9lKYdPKKMx5AxPSRnRyoTWIa
 h1lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOfEdkcqjaikcoRirqF38IONe6JZuWBpuxyBmMV0WbGZODM0pA2xdt7wf8XXGqApbYXWc/ra7QEGgt@nongnu.org
X-Gm-Message-State: AOJu0YzU+hmDd9oCgFcbOfwzJ/zFoEjYypTDqHj7N0iOljINgxfLHiao
 idTHYpqTPFVEaDp/zXTn7KFO9sXRC2oEiQ8vDPhNpGYejEq6tjF/4ecgjnp9Df8rlnY=
X-Gm-Gg: ASbGncvKsB6X1mixqZSDmaHOIwCYgPtd8mLOD09kX+jE2K+Mkx/0Goh85g+E023r9Bp
 xLy+NGMPh8L9ou4fwQoge2bbg72MaKwcPh5dI6PYjuX8uSX1K/7KVDxljvwAlV+fep1rId40v4a
 Pa4VZrpQW/CDkFj837tFUeoE6R4bNr9EUT/oqOOP/fDK5C9F6XVyiN+LrA3Daf4TlfxX/rfZld4
 PO4nKcMsgeR4qXQOHV5eB6oSgsy3FjOwLWXznVa/lzSxoPTrjljW6AK0fiYRUO76oSsAXyY45W4
 nQn6gDbij/BtCIANns8colYL45ec9a7/0UP2nOFhwdE00NDesm0EWuJdxXMxB108gDQFtsZ5XO1
 Bu79CZ+YBF5etPzPo/YVM+6nr8+2hihYep0TdvF2bCN0TfJBoe1wyCzO6hPZn
X-Google-Smtp-Source: AGHT+IFNcVddUbZwcCF6131IGAyZiGpyA/YQDy2N8Srw/AA/Aq5793bCQtwNUbj+RWvKk+WKOYMVUQ==
X-Received: by 2002:a05:6a20:2d1f:b0:263:4717:559 with SMTP id
 adf61e73a8af0-32199e7e1afmr1232634637.20.1759263660529; 
 Tue, 30 Sep 2025 13:21:00 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7822f628080sm8594429b3a.89.2025.09.30.13.21.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 13:21:00 -0700 (PDT)
Message-ID: <a8063046-b283-43a4-b156-3d04c8499cc6@linaro.org>
Date: Tue, 30 Sep 2025 13:20:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/18] hw/s390x/sclp: Replace [cpu_physical_memory ->
 address_space]_r/w()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
 <20250930082126.28618-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250930082126.28618-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/30/25 01:21, Philippe Mathieu-Daudé wrote:
> cpu_physical_memory_read() and cpu_physical_memory_write() are
> legacy (see commit b7ecba0f6f6), replace by address_space_read()
> and address_space_write().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/sclp.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

