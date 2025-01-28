Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073BEC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 13:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcm3s-0005A7-2r; Tue, 28 Jan 2025 08:55:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcm3m-0004wd-5p
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:55:22 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcm3k-0006rx-Lr
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:55:21 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so64916685e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 05:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738072518; x=1738677318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EuF8TqW3BoU78k2FZEB27haNC1pqnIVFIUhTQA3t3AM=;
 b=baIBsuSTw5h7skYh0dhcozAvYTTaypwWWmAw0rQlfs8z4P1i4jrzj4+lHJgDnfw3LX
 qH/pVNdABXG384ZvxFmVWOQd7nwA45GY+WPRtLHygwbSJ9pE+0eGYv97novLScTzsvaA
 EJ03tsxuhdZ8G2tt7g63FvrErrPG8I5h4X5tIVbsQ6oj0hDDZ8wAvDo3VvY8JqHJI02H
 bplkJuVxlozSeE2ZINnAUdIV/CGhtWhpiawqnQBbMmm0ZuJsZL5K0LQ8HQH2Q2dCoj6M
 +rAO9AriguciUkfxbN0Z/TjQFU+lgotGKdrXc09mn5VKwqygthxibRR1A6G9qWQ2d8i+
 nkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738072518; x=1738677318;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EuF8TqW3BoU78k2FZEB27haNC1pqnIVFIUhTQA3t3AM=;
 b=JsLGvgOLGRe+iKn1fT238lXBgj/Xww9o4fmN5vS3zCzVs6QFFCqRXVM6MCwGKIebC3
 dmljghxk8ans9pfsTMtoywpJqo1YPh4upfEFM1lLQmSa+uqSgNGwJKpiGldGhhShDCtm
 jns1FMCCNSrF1SHvWY2U1IyRc6VI4CC8VRA95zvAstSNSnM6M1/49wswmxgfr8JBuC1e
 wu6OU/K2g7Hog5G5LEQ5Eucp/9XGV0CoeAsC6VTfxG8sS2onFa6R9r6el00w9sMEBB4W
 zNe7jta48s7Ev7jzeUfm077uVWvTtQDXp6xEShaGHLhsrEBubhXiPPucWYSFHfCzCRIm
 LyOA==
X-Gm-Message-State: AOJu0Yx3nbJ//zLCEXzCm4QlxNec32HavfepDhBcNLXQTLNTj1eka/aK
 jbhf34A7EtKlOkcmh86HdFD38Ug7H1gj/cA1O42VWwr+TUhLrSycU+lt8+kIfxzs4mGjnu71xnD
 98Fw=
X-Gm-Gg: ASbGncsXm16zHC7e9ItFXWzzj7TbOWoQ6EZpMJX3apgKVcS3DFiccyMulBfFl9SY96E
 7ARxU5vmG+b18d9IN3SOeJksPnwilOUMOt/Vs2D+jGCJistCSsQJm7GVqRJ6uHxtfxJ+9c2ynZ2
 KcKyYuwOUGxc72WqF3V7q+y9gMbjvUYxiHz/8WIFxw5fVQgrko8PtpZw7nFveyF89CaoKJry0F4
 QNVFYw3KfCPf9aG8i5xFRL+RryCCwg/XauUy9eHy5GJqOWkg2wmOQB1Di42gVPh8WmqKTBmLC7e
 cu39xoHLb/5MsQSC4U82BXZ1IS+VIR4HzEIK1ktbQ3B+O2H6JUn7UYVGhAe+ucJTlzcgkw==
X-Google-Smtp-Source: AGHT+IGxSnOH6mUt7jlgPVb0bdBfQLkOjVM+vbExeIOEvZ+NjBS9Yw/V5AY35rAQOl/imsa9W4r7WQ==
X-Received: by 2002:a05:600c:a45:b0:436:6460:e680 with SMTP id
 5b1f17b1804b1-438913e0af8mr440932665e9.16.1738072518160; 
 Tue, 28 Jan 2025 05:55:18 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd48ae29sm175397825e9.22.2025.01.28.05.55.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 05:55:17 -0800 (PST)
Message-ID: <0328dd4b-12ed-4adf-928f-4464c47b341c@linaro.org>
Date: Tue, 28 Jan 2025 14:55:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] tests/qtest/migration: Update framework to allow
 using HVF accelerator
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20250128135429.8500-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250128135429.8500-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 28/1/25 14:54, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> This series modify few bits of the migration QTest framework
> to allow running the tests using the HVF framework (also
> leaving the possibilty for other ones, removing the KVM/TCG
> restriction).

Forgot to mention:
Based-on: <20250128111821.93767-1-philmd@linaro.org>
           "tests/qtest: Make qtest_has_accel() generic"

> Philippe Mathieu-Daudé (7):
>    migration/dirtyrate: Do not unlock cpu_list lock twice
>    tests/qtest/migration: Make 'has_dirty_ring' generic
>    tests/qtest/migration: Initialize MigrationTestEnv::arch early
>    tests/qtest/migration: Pass accelerator arguments as machine option
>    tests/qtest/migration: Add MigrationTestEnv::has_hvf field
>    tests/qtest/migration: Run aarch64/HVF tests using GICv2
>    tests/qtest/migration: Allow using accelerators different of TCG / KVM


