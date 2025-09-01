Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6FDCA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2dW-00087M-UO; Mon, 01 Sep 2025 07:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2dU-00084P-Ld
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:23:44 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2dR-0005xY-IP
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:23:44 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45b88bff3ebso7740025e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 04:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756725819; x=1757330619; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jTNAjdlrRrBe6EgxSuc7XLYVrTm34sBSQybmFywxObc=;
 b=KGYh5QvEplxOt8KlqrSYxL743KBfKcmQkpAqvi7MtK80w1P/KkJ9jCSzt8NI5czczH
 emRl1LLPZGW2HBEnW0CYdl4illGvvrcqmB25g+hoUhHUYYVD3AdXDQfGEK8yIHFIdBXO
 4dhMy4axQjOD+6ItHBaN2L9qAqsCJTUQpCY+DIwkCK2wHJToGuvXxFmwfFiI49Etr1Tr
 g3Mq0tslREdfiBsXgBMIMz81+YfuwMUwTOSlzGpMXnseOuYYOMDEqlad795e6fmZPF6l
 EcCkkQnpB34NlvxIZTZ8id+uel3Bu8GqWor2DfRc29nQeJi4TzK/pPH2bi8pWdvs862U
 Z18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756725819; x=1757330619;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jTNAjdlrRrBe6EgxSuc7XLYVrTm34sBSQybmFywxObc=;
 b=w5h40xqO3+v24TNqZ78s5+rV46T4WO8LQro2UkWq9F/4XgvW+kfJzzDieBoKG05NLt
 YtXqg3txQkiw81HlGGLbfeDo4VFVY+LsMKfKqV0eu+O5EoixrPaqz3Q1ttMd4KbFUeF5
 6ff+j3DPjIzq+ITLK97mS0txvE6UqKDEh06XbVyR4fkj/2aChX4MJYVG3rBC30fVlGxT
 gTnJLtjJC4TzoaGQvgVloD3vl/4UFPn5jA1MJmEhkb3FgYMVj6nYRp9/cFHF6bWZSpRT
 jIJjXfNQQgVjVgO9Zti4DjGVmQrtlGDQFpg4IenS555sIgFJY/xPhN1kvJU93zs/W81O
 hzxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJF2PlPL46b8l5AgsXe5qBxc5PfaS/87shhrQlkn21JrR01Pel4vF5XEptWb7IGF5oI6XBj4LWU0rT@nongnu.org
X-Gm-Message-State: AOJu0Yx/NiV0acKp8ACQhiTONULqsB/Szv2oM3hevGXTs5VYaYcdc4pd
 KCpIhKxI1mOYTKiKBzc72HzmvT2oF35uFayMmnyLEbq4PDLxT6/92ExksTe4NPJLtjh0iQ3/Jym
 wOQPQ
X-Gm-Gg: ASbGncsj31U0JBwIBF/3inOgVmOaTNPEE0s+yLDaAdmCru0kHp9z1aF7PXeyWTZ8LlG
 8CSRiz81obgizf/4Ve63uVsbFBSXUid85v2l9VHMu+5jiOlLyuD9mc0S4ttlVF36Cw+yDI3RVFD
 03lmxbnjxCbR/FmutnsxiqJCOQmzVwU+0M9RVMNDzPcqYAEyih9MVTs8dtrRPnrJ8oGE7nLjMhr
 yUDoZYzaV/2EivH5EGxuRakmO3K6EyNT7NV1fwovqztnSSA3bvrCt5aLWaYHejqV4+IsRUbVp4x
 IOlFe7A4LXT2kx+ZUvNVnzGGiZshAbv+sMs1plpXz4RL5rkAN80FbOvjbxbzT8UUuRKDN+HdCKU
 yIlRsrWxxC+y/J4EAaXnfKaNgId3cbZbYsrsbkTxDaCCZeWaksHnMswbaQBBEct6MpR4uEzvzAc
 re
X-Google-Smtp-Source: AGHT+IHEEvpV25qVgVu4oWhn+ouq1JQZbuSRY35zMgqra27TwmqYz95untIJCw+8dnrepFc4pXAJcw==
X-Received: by 2002:a05:600c:1f08:b0:45b:7bba:c7b5 with SMTP id
 5b1f17b1804b1-45b8557c880mr57841465e9.28.1756725819451; 
 Mon, 01 Sep 2025 04:23:39 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e9c41cfsm152480985e9.21.2025.09.01.04.23.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 04:23:38 -0700 (PDT)
Message-ID: <c81b9ccb-179a-4858-96be-b9b4baff1232@linaro.org>
Date: Mon, 1 Sep 2025 13:23:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/18] treewide: clear bits of cs->interrupt_request with
 cpu_reset_interrupt()
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, richard.henderson@linaro.org, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-2-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250829153115.1590048-2-pbonzini@redhat.com>
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

On 29/8/25 17:31, Paolo Bonzini wrote:
> ---
>   accel/tcg/cpu-exec.c                |  6 +++---
>   hw/core/cpu-system.c                |  2 +-
>   target/avr/helper.c                 |  4 ++--
>   target/i386/hvf/x86hvf.c            |  8 ++++----
>   target/i386/kvm/kvm.c               | 14 +++++++-------
>   target/i386/nvmm/nvmm-all.c         | 10 +++++-----
>   target/i386/tcg/system/seg_helper.c | 13 ++++++-------
>   target/i386/tcg/system/svm_helper.c |  2 +-
>   target/i386/whpx/whpx-all.c         | 12 ++++++------
>   target/openrisc/sys_helper.c        |  2 +-
>   target/rx/helper.c                  |  4 ++--
>   target/s390x/tcg/excp_helper.c      |  2 +-
>   12 files changed, 39 insertions(+), 40 deletions(-)

Good cleanup.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


