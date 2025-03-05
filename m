Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73CEC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpeVw-00024g-0w; Tue, 04 Mar 2025 21:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpeVs-00024N-F9
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 21:29:36 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpeVq-0000Ym-O6
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 21:29:36 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2fe821570e4so9178780a91.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 18:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741141773; x=1741746573; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SktsCfhHvUlMeUwk3PbUs24ca/xziyWPr9rC1KMmCzg=;
 b=E821KpfNSd3YBlmGj5qrulUvjzlR3tfd765/YDRY6CZwoYif0/eFEDuY8AWK084t3Z
 PwjYqm1cKmRoJPh8k36SeZ36HSqkwUom4U2aiKlep6giyC2+PPMt+l6w4kZCLswAhoCB
 pgsWNNIwHRijm3bMPSjswabAL5YFASh+4/Ip84CH9ABmcZLq+ld8ZI+kHnr+mi7Dircv
 SbFwRrZVNZXglm0jlHA9ZrzBVJ391voZJkF2BekK17tmexCsIL5eZlZKR8YRQmK+0KVt
 W+/0tk9fcT6ZbnS48G3yxfZ+QWX/8IhMXU5Uxhno/SSjuXNrUY8Py0l/myu1vzc8Rnf3
 xNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741141773; x=1741746573;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SktsCfhHvUlMeUwk3PbUs24ca/xziyWPr9rC1KMmCzg=;
 b=A+K3W+F71d5d5nONC7nuAxK1fKw5xXRMjk5OdOOocV3pPUnsOaggxk7M+LCNk2N9sX
 6pPFjJBz8vJzCzD/2vS1zqfxuGrTierAQCxSDxXugxamw1kSe/rlyW8Nby59zYzgB+ei
 XbV6JwVqrBqLmtdG+jROtqcOFfwYcvDtuUA1NBWIYy0uexdBop/H0L6fb4wWPhQdvGUw
 7T+nAJkmIq5w0uwAIgS4WMBvFc1aAr/4biM4UpTRWXV8auBB0CDX6wIXrGJV1OyHkv4V
 GzsVJnRRvK5KiR8mbuNXAKu8YNSoW1h56WZnrZQxIDk5meeSMQoO3YSGJpzdfWgj0K8F
 3UBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU09xlcjamh8uFBUWCaP4gnF4twboXVAOXCT5ZWjMAWdqzZnRnyj3iRYpJws2o5EWeFt9c2/pSopsme@nongnu.org
X-Gm-Message-State: AOJu0YzIqYPVQxOkNg2xtENW9mCt7M8Mky+P2Hntv5hV4Zn+/S3rPwHZ
 qV9Ew2R7tpUY0HZriZinHa2u3Wgo4rS65JnegFWHl7036sXYrV4Pw/pLUE4JOFo=
X-Gm-Gg: ASbGnctje28KadOFyLfE9eou33OuqzcN90t/VDs41tvou1w1LMnRZlrcKxTtM+r4041
 OW0wxVR5kflBZOH3UbIHX/pTLSXQEUQTYyZ4MRw033IwnafsZBZngQRHXyvqQ37dcI+izHjThEG
 YhmTygqtrFeKcR/C8KeDUnJZXZa9dZVA9ea2eDNJ+s5BNfoupgSHhmHCiSn63eMSH7rros8eN4F
 3JShGczIgPY89ZJt47lWxIvHROcCGBLp2Gf1V2PRlwqdax+1/fBxQE2yjt3etpKzHshR4CBDWtp
 7Ny+LyXeq8dib2dXwzlNqE0bJFg1u18r1IqhVXkNZz7qaPlDM9/1ZSBiRbZGiZ1sI4iHjvumk1g
 JbS9x5QNx
X-Google-Smtp-Source: AGHT+IFIEl9q8T/O6H0NwNK6U/uVQNqkYq0C7T9MFDMQPsd+OFXRN6SAeTAkmlfje9T/MwTW+xZ0TQ==
X-Received: by 2002:a17:90b:3b47:b0:2ee:cded:9ac7 with SMTP id
 98e67ed59e1d1-2ff497ac991mr2629409a91.20.1741141772963; 
 Tue, 04 Mar 2025 18:29:32 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e789392sm163355a91.28.2025.03.04.18.29.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 18:29:32 -0800 (PST)
Message-ID: <d9d6e0a1-f2be-4caa-b7bc-0d7d52ae5377@linaro.org>
Date: Tue, 4 Mar 2025 18:29:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/11] system: Replace arch_type global by
 qemu_arch_available() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250305005225.95051-1-philmd@linaro.org>
 <20250305005225.95051-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250305005225.95051-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 3/4/25 16:52, Philippe Mathieu-Daudé wrote:
> qemu_arch_available() is a bit simpler to understand while
> reviewing than the undocumented arch_type variable.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/arch_init.h | 2 +-
>   hw/scsi/scsi-disk.c        | 2 +-
>   system/arch_init.c         | 5 ++++-
>   system/qdev-monitor.c      | 4 ++--
>   system/vl.c                | 6 +++---
>   5 files changed, 11 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

