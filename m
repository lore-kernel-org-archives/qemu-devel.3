Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB62FE77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 14:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVtjQ-0001su-UV; Thu, 09 Jan 2025 09:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVtjO-0001sB-IR
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:41:54 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVtjN-0007Ut-8K
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:41:54 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436637e8c8dso11433645e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 06:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736433711; x=1737038511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7avrwuXPDlwcqIEGRw9oeZdH8XXFubTJn2xydz6Y2xU=;
 b=Axn54Elbz5OFIBHooxttxxP3x15gD/gKKffrN3ZuawogYyvc9vjyloRKWgDpTVJfDP
 CLv39z4b7TUbtUlXY/aU5saAEpLzccssLLBtH9HbEJFZhzamfeiFyBONcCPwtNpIpvQ0
 R54aJN6DXQ/qA4EtRe564XPRWs+O0gA189M6d1C3O8E41MuK7ZjAdrEdV4LmGLzQgw6z
 UgKbVRQCfClbYaYit1MVaRw8AfFYwWbDva3Ybgm7q+w69JVGy2obxFSdImXGRubsyvGf
 ZKoymX/jC/YUjV9m1Qd6QyfMq2QvRy895WyONuWF10qJvDsiWyoC53ZdKSDbPNyCXOow
 inZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736433711; x=1737038511;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7avrwuXPDlwcqIEGRw9oeZdH8XXFubTJn2xydz6Y2xU=;
 b=dH9dih+Hn3JVgoYxZe9rNUbmeIawDQM8KCL5OxpsSZmcJPQR88qK94x2h7aJmTfEUX
 pbmcN33pPkwxYlvWj6fiLzj5CZLwVInvVLZ357BNGHoZUU8MR9IefKOL5B1TddTYk5Ea
 y1gCLVCfx0EfkHST7MW+2ZxXkoMZsSqX+PF43n1zE4lVa1T1dfStExL5EPhpZXjKaXOx
 0F/2BVr9zdHFIgjuRsOwnX2Ya/QzEkDoP5aaZjYUfaQ79MFToNIGeutfFvfXTt6ImkC3
 agZWJ5YySZ5VWep0G59sqgaaBWHvrnpYEOUQWI4voyhtaqitsuYr1+m+0f49mFhga+fQ
 1HPQ==
X-Gm-Message-State: AOJu0YxcB7YplqPpKNJX2OJsS9pTO05aTvKwtA5yNabU1TW4Lu3JTpi1
 z7tbZPphIYoGKvlp+/frV/+urKtOS/0ERHbLSECbqRzlOfz4V30APHnCulUBcT+iHs6vrm/jORo
 E78U=
X-Gm-Gg: ASbGncsNLc/x2lDImr8pcqv9AcHZsetCaSFcxaqNRzoM23xlM9Fm95Tx6Rjs0SFDGqx
 zUO+S1IRD8VXLIKqGtd7zN9hMLcbf6hWmcD2jWNMPmo0BPzkHf2OicdVzAKnn9eROUBC5DmPQ6j
 un/dQeo6ra7/0fFYtduELx1nn/0I66+u1yNVY70dtgQexpBSJ3KXpt5XESjz/lEGwJQP6fj/xb5
 ORa+ilboYPIY873JgFhT2Ca5bkdv0wUtmWiCREuxuIgZISSbGX3hkTIv/m3sQCitoBAOmDevTmu
 5ctHHSgSj7gyLzD2xOSFJJ9HaOU=
X-Google-Smtp-Source: AGHT+IFND7btiXqZJ095ryNFe8fL36RRjMiS8ksTlmNnyjDDIt0C4F/eCVfIx8MvZaD2NZMc1v8FGg==
X-Received: by 2002:a7b:c5ca:0:b0:436:e3e6:b725 with SMTP id
 5b1f17b1804b1-436e3e6b799mr54156915e9.6.1736433711377; 
 Thu, 09 Jan 2025 06:41:51 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e89df1sm56732615e9.27.2025.01.09.06.41.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 06:41:50 -0800 (PST)
Message-ID: <eb40868e-886c-4c6a-88df-f6dfd4a5ce57@linaro.org>
Date: Thu, 9 Jan 2025 15:41:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/misc/vmcoreinfo: Rename VMCOREINFO_DEVICE ->
 TYPE_VMCOREINFO
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250102132624.53443-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102132624.53443-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 2/1/25 14:26, Philippe Mathieu-Daudé wrote:
> Follow the assumed QOM type definition style, prefixing with
> 'TYPE_', and dropping the '_DEVICE' suffix which doesn't add
> any value.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Supersedes: <20241219153857.57450-5-philmd@linaro.org>
> Since v1:
> - Drop '_DEVICE' suffix (danpb)
> ---
>   include/hw/misc/vmcoreinfo.h | 7 +++----
>   hw/misc/vmcoreinfo.c         | 6 +++---
>   2 files changed, 6 insertions(+), 7 deletions(-)
Patch queued.

