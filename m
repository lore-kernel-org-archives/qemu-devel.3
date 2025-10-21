Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC830CCD1AF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 16:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBFbI-0006eS-63; Tue, 21 Oct 2025 12:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBFbG-0006eJ-LC
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:52:42 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBFbE-0006yt-4y
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:52:42 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-63e1e1bf882so4266418d50.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 09:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761065558; x=1761670358; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F6LCpZExV/Y2MHFuRJhTSceHLkQkWX3L3d+KZrLtW28=;
 b=g6MHJukcGJ9RKnC/P9+slQdlx0pQ15bVp9cVpYfjkV9lhI8Wer81dV3oHAlUm5uIWw
 31K1ASOY0QjoOGbUwupxSWPRbdcsm6cMshCrgfclMYH0L3UP76Xod9JmOt0frTiD0hKX
 Yg67yDkBuHE8lYlowoZdiz87CJCaQewz3vmx+nThIFQuAP3Nbt9S135K8p46gQSInWY8
 Di/bPUJuVkJrHpugQ5wOdj9JAVmKg0LYdE337B0oHBOJ07rK3EXNU6gCAgb5dU+0dG90
 C6N2otIU/huW896VmUd35dnfcSdKVDYhv4QBS6MxnHO5mh55LxLxbNqlr4bNZ5XInoCE
 sm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761065558; x=1761670358;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F6LCpZExV/Y2MHFuRJhTSceHLkQkWX3L3d+KZrLtW28=;
 b=hsGui/Ac7H8ubKCcbLh4ui52+oJIVJaGv08Tj6QmAA8VaWPU95hO7MJDKtN5EOYrLJ
 /einHRvo/nkDpZsCgA/Pw+TpwrmmMYCn+/o98uKqJcj3adggGt//o8bJGsAcLjhJRHun
 hB6k5PiFcgYJF7taRtAzDeYzQnHGPvUUQs0nlRF16kTdG1I6HDT67wINffPH+oOW+A7t
 8pczQaOkYthQgpGxl2+e9+OPHtYdZbxemRglbiouGeuJ49342EX7oylgmJyQSS3pGWe8
 icHFF6U37b0mGBSa5hRe3Morf50X2T1EqZAzFReBZIy6rsZ8jCyryt0wykXcMt3qSSyy
 Ov/A==
X-Gm-Message-State: AOJu0Yy2xVWpRQ+mFsbTkySUTVZL/VFgNTYQVMY3KNLdA1dJaxmdysWB
 cvz456D5E6Uz3D/Xs2oBVihPFtvy9gyNAI+A31MoOv0RWttw0gfBbWhLi6ppFF4qG8BvaBZLBCS
 kN+nbdcU=
X-Gm-Gg: ASbGncv6NTf5u0RaJKNwtwwnaVH96P9Ob0VNyCa/WzDHPHh3rvDJLWMynUjAEkrjJU/
 zB3qtNLoJfRNke6EGp+R82uxZRGYEAYF3c9IIBD2hCI7vdlQbHOya4com/EptTXUSIvqL0GCD41
 hf/kbGAtfveTyAJZG3VOBBoAzRvMDR/r2FW3KJi8wQnAERmNl39MgXNnXYi8JMGym6kEUNg9aCN
 kcaB+nSwPpNd8xxdeLmzfi66XgEmfdAchW4uFYV3sCjH/aO4JyAgnAui0CHicBfNoO49ByhNvFE
 cMpbEm4TGATY8YX+nh7qawo088akzkXk6QlS78wC7+DrI/7fjqcBDcvMBo96FPMZfSOV98RYuff
 fpr+J4+RG5DjuRvG7VSz9G8feHeoB/++v3FgTxtbZ1lZFipPxgnfrfjj81LRwwwASwJdaEBI7+a
 6DtB+/F7ZbdDArMbMl14mFSYMqWk8tGKBQkGtdUFuN1Z1vjLbhnAp781LzZw==
X-Google-Smtp-Source: AGHT+IHtNcoQ4tM13uoNd/+TFkMlQA10R4ZIkzL/STC1uo4v6gmLcTnUtwguuwRm3aCWM+N71wTSyQ==
X-Received: by 2002:a05:690c:670b:b0:781:64f:2b15 with SMTP id
 00721157ae682-7836d341ecdmr279269417b3.55.1761065557447; 
 Tue, 21 Oct 2025 09:52:37 -0700 (PDT)
Received: from ?IPV6:2607:fb90:5ef2:c582:739c:d109:1083:110?
 ([2607:fb90:5ef2:c582:739c:d109:1083:110])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-63e2680da21sm3344078d50.24.2025.10.21.09.52.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 09:52:37 -0700 (PDT)
Message-ID: <ce7afe1a-0538-420c-858c-609e0cb8fb1a@linaro.org>
Date: Tue, 21 Oct 2025 11:52:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/10] maintainer updates (gitlab, check-tcg,
 virtio-gpu, plugins, docs)
To: qemu-devel@nongnu.org
References: <20251020124850.4122520-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251020124850.4122520-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb12d.google.com
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

On 10/20/25 07:48, Alex Bennée wrote:
> The following changes since commit 3a2d5612a7422732b648b46d4b934e2e54622fd6:
> 
>    .gitlab-ci.d/buildtest.yml: Install 'file' for the Coverity job (2025-10-19 11:49:36 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git tags/pull-10.2-maintainer-201025-2
> 
> for you to fetch changes up to faa29110b903fed29ba27bad3d0d8fcc7a8aa0fa:
> 
>    docs/system: merge vhost-user-input into vhost-user-contrib (2025-10-20 13:46:28 +0100)
> 
> ----------------------------------------------------------------
> maintainer updates (gitlab, check-tcg, virtio-gpu, plugins, docs)
> 
>    - drop aarch32 runner from custom runners
>    - use template for aarch64 custom jobs
>    - don't test for atime in linux-test
>    - drop extra draw call causing corruption in gtk-gl-area
>    - add trace event for blob map/unmap
>    - extend ufrace_symbols to generate dbg files
>    - group VirtIO devices in device documentation
>    - merge vhost-user device docs into single file

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

