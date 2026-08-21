Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A97EC5DF94
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxSML-0007UC-Av; Fri, 21 Aug 2026 12:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxSMK-0007TY-44
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:44:48 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxSMI-0000t4-1C
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:44:47 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-84a4d8fd6ecso1239350b3a.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787330684; x=1787935484; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AbqaBiunWuN/LvRZX1FaCwbCv223Zk9IBDABCk4POsg=;
 b=qq8EIPytYa/Voz7Gua0V72FgFgKBgjJ4xgl2jjCWqN0mkkzIABNnmMHXN5d/4MrWo4
 pd7DNF6fC45+iDky4XJ4zWA85+5N9nac7H7Cs+3yY8TxdDcM244QxKxN/gI/6IoUv5rS
 sX8C+i+JUdMzC2snzktmlrrGJEXk/yYhMcz0FB+AKs7jaPLR98fkfhgcpRZ0gvbuZc31
 V/CH9eNUS78BuvrfuVZdFVpaEoepBj+FLJJrIvs/jTTonIuRUQ2cHOwhr4i0PLy6ZAzD
 hJwUcSxL2jMWMIgA/Kvt8Dky5OJ2Ww2AiZJ6Nz8LVHpwijTCsk6eC0iDzaznZLm3Q4Ww
 Lo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787330684; x=1787935484;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AbqaBiunWuN/LvRZX1FaCwbCv223Zk9IBDABCk4POsg=;
 b=OeBcBJR2L+FEHUpgJB/foBPYzwLyWiIqJ8Gj54dCrvJ6BTQaN0VLyohnVCwNzuJEG+
 PTBAp5dpJ8NVfocrLpsTSPnfhR8WNd4slM91sk+f81zMM9RFvWMRrt8/2quA3UJzpoIh
 A4nBqgOEiuZcZVSI+SLrDAxI6eUKMRIofqNU88YG/rZASOpI8JZtOl569d0iXNp2B7Sx
 wiEmzJOY5GAbd3YVQ4i5eXa+Lhs6CoG0SlX4KaBP0s3gS/7IMbdhUxkq3bKGUfZwRR1W
 p2hDq1Ol0PRoUnVUDMeiJ4wDt6k+EZ8XWg3jE+Zu9eTD4Ohx4/dDIWy+jPuRyQ/MakLF
 iGmw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr8Sgr8wWjPRFuReSMDgGuny8zRx+lMtG2dGIeSkjipOkKUcgsAHZLrAK/+qjoiZrS8HzoFT+N51AtC@nongnu.org
X-Gm-Message-State: AFuF++kQ/fCou2cm6r3cCCawKrh2iD2s7UoryZ6jF2NvSQgjqC5tRQ7H
 0fyE/PD4SAhkkeLWyIFc+4BQ0eS13ubFzlqE2u/sDEpKQEqcDLl60TbtSCJktet+JPc=
X-Gm-Gg: AR+sD12bKGOvQW4+ekiWSrqp+FQE2W2nFpb5LHLbMh/Cxbzkzgj0vPNlrtgXDRSEzcp
 bqn59sS0kXFLbzbkl+S/if6kWinWrw+YBtXvVtuQ+hc9HESkhb6dgq4kT+MxCDn+HkN5sqDzw92
 1ZRTpAJN9ZegBhEBHKw4L533bV5cOZO8oHRPSuh2HCHx4eGE0rhSh7Znm7hRTL0+nvhdBw16++D
 O8bRNuXhXf56r9r899O3j34CkckrHE9aYmINZZ69+hPRwXf7W5dzhgx7pTvn16inpNa729pF7x9
 SEuCTxk98lpYZJ61oIv3Ggo3Ca7K1SCs4rbWU4y4N2hdFanAECx3kybFwmP+jKynyFI2yEffLUU
 Y1DNR7KWl+JO9uobhmCwuSxeiS6wYSUXPrBN82mqbtwc3+hjZN7t+NEppPUpUgWqfvD84FZNx/f
 dHC3HxyJvDan2oASUHG3yeKRvzEigJlDjtVGFtPTFxQe03g4fyPxX39fiIJ2x6WZ575A2hoHHoI
 0ot
X-Received: by 2002:a05:6a00:4195:b0:84f:b01d:3693 with SMTP id
 d2e1a72fcca58-851fa05af7dmr13403307b3a.15.1787330684425; 
 Fri, 21 Aug 2026 09:44:44 -0700 (PDT)
Received: from [172.20.6.168] ([108.174.179.84])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d366d65dsm3271690b3a.50.2026.08.21.09.44.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 09:44:44 -0700 (PDT)
Message-ID: <c9988841-9b74-4274-bf54-b7f5d411b70d@linaro.org>
Date: Fri, 21 Aug 2026 09:44:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/15] cpus: Add const-qualified CPU environment
 accessors
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260821104950.32108-1-philmd@oss.qualcomm.com>
 <20260821104950.32108-3-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260821104950.32108-3-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 8/21/26 03:49, Philippe Mathieu-Daudé wrote:
> +#define cpu_env(cpu) _Generic(*(cpu), \
> +        /* We validate that CPUArchState follows CPUState in cpu-target.c */ \

Out of date -- currently in target-info-stub.c.

r~

