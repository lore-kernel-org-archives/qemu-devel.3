Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DECD66BA2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 20:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVy0o-0002Ht-8H; Wed, 17 Dec 2025 15:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVy0n-0002HX-0c
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 15:20:41 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVy0l-0004JV-EN
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 15:20:40 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a0833b5aeeso70461845ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 12:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766002838; x=1766607638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RJChVFu6m7+xniEX8xnhjK9xZHOR6SfFi+/VyZ0s05I=;
 b=IECnt/RciBQS9AowzoN6Qvm2SPwMYzHD9QbHIrUtZV52FfumEOJ1CzHydsczoJKS6q
 T8tPd2JCrgdiEI85I6LJoue/31wYntGP0rlNmx0rUZ/9PSWBsI/u3GlT5zJzTFbXDqsv
 PYa8VaHRD7xmq8PUL0/4lrVLdgXG1AH7Fj/GwLhpvN6YHFmu5qMsSd68x2oj33v14x5J
 6dSjlu6Yw1fimkNIqPZHaed0FrA9nXXjIkgf/YiaRG3Y89BEe15bBvVIa/vxZZw37MUo
 fLpDrAzkk5PACp0Q+qT0i004FQxsS+nsB2zVRW2tNCOlc3pAN46LzPMMuUfEX9y2Ky3t
 6HbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766002838; x=1766607638;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RJChVFu6m7+xniEX8xnhjK9xZHOR6SfFi+/VyZ0s05I=;
 b=EZtbs6NtBLa05ZEwDfgOLR7IAN0YFi0gZIkanExPR2p9gVZEECZJPujHP0ZcSJDfd5
 t6UX9fYbXplt1rniLi2Ff02NJqB7n+6mjSceAv+bqK6rn0aTIsf3tahQBFqP3eYHc696
 4CGbYay+8NI0mwLXTosd3X+v72xuVyVNQvzwnZYmNc6mJKZE2U9dWLXow1jGozCpA35n
 zbWZ5QpsJKS1tIYpAVynIuU39gH9xv2GDHVbYkqF7Mmuy9sFtQCQzHokOSLvnDZf7e46
 IEd+VE1Z0ibf9eMhbqQMlvv53F9fykzkB5NYwNMp5F2ub4agueXehB0ZKWUFYougjWX6
 LkTg==
X-Gm-Message-State: AOJu0Ywy2ie6NsKZ3zC4S80ozsb77LZs+9jQt6J9Cihm62l1BxASQSoa
 9g0PVKhbuu+0id7+BOcIejKS7UJUUOsQZAcTAQtpbnRDThSHRIuHebsApJmFtNzX7Sm2TzziltR
 QDpBDr58=
X-Gm-Gg: AY/fxX5Hbco6cMV7e4VLRWUy8bC65CM/VTj0XMSHJXssm89cwq42yqk1ddWAaLTi/5S
 vWB8HZCeImGhJ1ZEmlQW65CfQvdB9+jh1v6C1WBHCeacwUeKRA/V59veQDaxR/YI2nepSugwmBs
 /co3z5jneeoIf4BZS3DHl1tPnHK/6MByqJ0RVbjNXZw9nRx0tXpPduKjN+saiauS+oojIk6eAKQ
 4LlybNgOy+ZJB2rQ4UyHg/Z0M01Ic1lsnDl4PkPrEkmQKhpwR3MirXGqdIE/k/cT/njObYdk9qu
 qWNQB5N1T4no9ffuvsiox0Tj5sGTC6hEz0/xqGayvSm9x+ggMOXgZgklmEM+VgNfF/y4ek9RDCp
 NzzFwa60SZGPHOhrhBRMcVYR4UjGWRyWIRARxnJDYXtoQ2x6BjuxNohoYaj0Emq2AEEbuHZTZzr
 TdOxP5nkRAvFl9OtAAGFHb+Q2j5icm9g==
X-Google-Smtp-Source: AGHT+IFDxJww9Rkl2fxH+S0QTlsEBTJtqJOWPnfyHFtrnbRlguqNdPRDfcnDUXtCmpUiNd5UrK7+zg==
X-Received: by 2002:a17:903:32ca:b0:2a0:de4f:cad with SMTP id
 d9443c01a7336-2a0de4f11b4mr96868445ad.60.1766002837731; 
 Wed, 17 Dec 2025 12:20:37 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2d193cfa3sm1678255ad.93.2025.12.17.12.20.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 12:20:37 -0800 (PST)
Message-ID: <73bc767e-4249-4dba-a060-663e5feab710@linaro.org>
Date: Thu, 18 Dec 2025 07:20:33 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] system/memory: Define address_space_ldst[W] endian
 variants via template
To: qemu-devel@nongnu.org
References: <20251217143150.94463-1-philmd@linaro.org>
 <20251217143150.94463-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251217143150.94463-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 12/18/25 01:31, Philippe Mathieu-Daudé wrote:
> Like we do for other LD/ST APIs, use one template to declare and
> define all endianness variants of the address_space_lduw() methods.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   MAINTAINERS                                  |  2 +
>   include/exec/memory_ldst.h.inc               | 21 ++++----
>   include/exec/memory_ldst_phys.h.inc          | 45 ++++------------
>   include/system/memory_ldst_endian.h.inc      | 25 +++++++++
>   include/system/memory_ldst_phys_endian.h.inc | 37 ++++++++++++++
>   system/memory_ldst.c.inc                     | 54 +++++---------------
>   system/memory_ldst_endian.c.inc              | 42 +++++++++++++++
>   7 files changed, 136 insertions(+), 90 deletions(-)
>   create mode 100644 include/system/memory_ldst_endian.h.inc
>   create mode 100644 include/system/memory_ldst_phys_endian.h.inc
>   create mode 100644 system/memory_ldst_endian.c.inc

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

