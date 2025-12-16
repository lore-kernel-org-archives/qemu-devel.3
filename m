Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BCAD609B1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 15:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVX78-0007wa-GT; Tue, 16 Dec 2025 10:37:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVX73-0007vr-3I
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 10:37:22 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVX71-0004g6-3P
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 10:37:20 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a1360e1392so9544215ad.2
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 07:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765899436; x=1766504236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JbiIxxrPql1WmzeJfJL3TQeVLmySl714rfDJsxIf+Zg=;
 b=moNb8JxFTFEfP92JfRDyT/SgU14fWSVEOvJvyLlDcqGSB4ByV15AKIoYt29lv86UcS
 Ss0RNf+tqNOMmjmMK8nAzSYpjnWchVZ6B2HPFqTW3BhHEpjjD4uLXj3fTQ8prz0c/6/F
 23Bihild/9BV60AOvwklDyj0e1rURH+VYMjv4YzSi1umV92ZK9qwaMOgSYnevY2wyjxa
 yDK6YX5Bbl00AjGS4ksBnLM2mPb3qej6yDAA8TjQ6VGB3ssOyzVaeEH41SmaC6Cj83DB
 HTr/NQ5Tkc+kmsa0AQHnYyFxk2vp1BnKNlSy+4/efsZ+2IbMhDa8SoVPXJ1x/U/9bw6R
 /juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765899436; x=1766504236;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JbiIxxrPql1WmzeJfJL3TQeVLmySl714rfDJsxIf+Zg=;
 b=mM1BWENjv2/5fBcc7JyV4ZCbCU7HjXZZhn1i1Iot/DfnMpq12jobNJf+criS+zfTTm
 bP79P0/5MgV1eN8ax+TMD8nzmFIR8C20zEovtiPmeZhrQUwYZgnSlVjoUJIsQLM2X6PQ
 wXKWvSDeu3Fy3HTMqDn/7UFq6remxSrf5nSKxeBE0rfKSOkVX2KlxsUgbyoJgrwTbhXb
 HbjiD9IYqysrIZ8ZkcgvaNJH+sw3HoMR4rFZ0mTS0nheho20QitLdnPE9uy3II34+wUL
 PTXqTdIZXcnIKKV1NQavwIG8PNwWON9HfUHMXHHuwep8CyeQCFVxAsQOPGd9ScoZOYAn
 R5tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFlRW6h2yy3F9OaYNJYCgzwEBiSLlcev9MiP4Ar71ZN8L3IhAZEyAu/z1OVx0n6psEpET5l/YLL53W@nongnu.org
X-Gm-Message-State: AOJu0YzfWrNBARVAFZBNgUm+5t/3yBBbZbCP9576W4vyIFRLsbSLG9mZ
 n19QHhfMl4YsOK6IV0XqIFycdB3QzpyvWRY2l5wXekdOJUTv8FwoHpzoaybz3zYIdUA=
X-Gm-Gg: AY/fxX4zYeX8czmm6sWFForusE48cnLMd2JjREk0K+O4fJB/oz86eblURu7zaC/nr2Y
 RNULit9IgVFgq48KXJ3yIwxpORp83uNhq4xx/na+wLPm2vtIMoobVBHu+/fW5BYEwMD8jL4BL8m
 DKx543MX19LDFz8temQ66DndKGgLAFLajGGi9BvJdHYd2AcXnWxnPyGOsTVPQWXq+v2Vg211Qh/
 nlR8/tKem1j/28k1mBaI5MTKBZK1YKQ/5O9/8NCzPYzfPURsPLmA6cBN/3mRLl+HSo+LF4JnSHb
 8nE7OPHCBdG3UFQYrobYy55OJLRmDr9EjMY8jE061L21De98vkA5W6fnpEYZghDuudVm3Fww8bI
 YP+kHycURVTTAZV7T0aI6Qo6IWph/ek6xRRgegEDd0zZPYl48W9P4drrPoggr/nNOkMV+pP/KVk
 ZvqTrkwwGN+QkhRu5Vqvv0aegMZ1mOfA==
X-Google-Smtp-Source: AGHT+IG7Tzni8Fto+P2DQzlr4LwMlyY+x+7TCf/3JFklTVf2uMmjgOj3HWcnNu43sRAP1oX+iFR5dQ==
X-Received: by 2002:a17:902:d4cb:b0:2a0:b467:a7cf with SMTP id
 d9443c01a7336-2a0b467ac9amr102892085ad.0.1765899435746; 
 Tue, 16 Dec 2025 07:37:15 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29eea016e21sm170687405ad.55.2025.12.16.07.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 07:37:15 -0800 (PST)
Message-ID: <3d984359-03e7-4cff-b16d-1e7e9a31c816@linaro.org>
Date: Wed, 17 Dec 2025 02:37:07 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL for-10.2 0/1] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
References: <20251215145703.31841-1-stefanha@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251215145703.31841-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 12/16/25 01:57, Stefan Hajnoczi wrote:
> The following changes since commit 9c23f2a7b0b45277693a14074b1aaa827eecdb92:
> 
>    Update version for v10.2.0-rc3 release (2025-12-09 16:44:49 -0600)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git tags/block-pull-request
> 
> for you to fetch changes up to b002acacc1d72521351501fa0af81d146106c9ed:
> 
>    Revert "nvme: Fix coroutine waking" (2025-12-15 09:50:41 -0500)
> 
> ----------------------------------------------------------------
> Pull request
> 
> - Hanna's fix a regression that hangs the userspace NVMe block driver.
> 
> ----------------------------------------------------------------
> 
> Hanna Czenczek (1):
>    Revert "nvme: Fix coroutine waking"
> 
>   block/nvme.c | 56 +++++++++++++++++++++++++---------------------------
>   1 file changed, 27 insertions(+), 29 deletions(-)
> 


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

