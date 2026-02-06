Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648F1ECD9BF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCJB-00086v-RT; Thu, 05 Feb 2026 22:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voCJA-00086S-Hi
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 22:15:00 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voCJ8-0006NE-J2
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 22:15:00 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a7d98c1879so10383825ad.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 19:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770347697; x=1770952497; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nxkVovlId2TbH2NmQxGIawcSncmFWAmTRXWTdinFzEg=;
 b=VWQGbH2Lq5SfsiwHNNIFy8Ed80SVB/aRHb9lrT4sX/ku+aa/bfj+0xRH8a2ra5mhkJ
 V3izjXgYh3oRDUq2pgPzDvk0Un0IewxgobHuyid9q2kAH+9gvnwsAWtAf/MLVymMtaks
 50chHYVL/wW+bDd/4QaBD+AvMxF0rCtWTNnzIgRsji0JfUYiqv9ZYLPsECmHZ9SlZAaC
 1uivpLqkwc+TV94H6VCZoPidMoXR1IiLTJ1tUZnYwyrvdXRK1/zobUzJQfaWe5zZ3+Fg
 ly59nQTNA1QZv8vimqxdid5XMvKMA9mER4XjOxr6jyx6smKEkvVacaE6qvLPTb0XTtBG
 n4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770347697; x=1770952497;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nxkVovlId2TbH2NmQxGIawcSncmFWAmTRXWTdinFzEg=;
 b=TEdkhwYAGzfcRxect4ZnYcEEl5f4E8JqDy+kQBHfR9ncVV5J9IQzi40BF22zNU+qkq
 HVolLypLIZiLkphigyXU8629woBR1q5HEEutg0MH1l3oIn8feb7uDUyI4Ak7k2ELC+jN
 gXiZkZIvyKvfbvIC9j0OivMQwcQqjvLja3tDiLOkXqCW/7n08Xpch2hYErPFwS8lSRMP
 KhPbX60/gfWwI1522ZjBCkjk4nheo2OlwW5aqKziNZlzfIjcaY2nCx1g/ibB5dM4kMon
 vR4VNzv+rRrNpRee19TIIgO4/SchxfWTgrHG87VOENmdzN7iF+iz5U92+nQUrnX92mlW
 kitg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIbJmdONU1ii1oDAbkGYKjvSpz1oZPFKyEVojZn9A2VEVyui8fBjQe7HLODfNy6s6tP/idntY1SEdQ@nongnu.org
X-Gm-Message-State: AOJu0YxsM08x9rftMAm20OC1guJtMPD17mlosW8VZGT7eGOOC2511CWT
 X2QtMF6wTkXxkI7cl/krLbaj7D6BIDrlhFBY3DFpOPCkElhSK0TuF/s/FjG1aQje4+k=
X-Gm-Gg: AZuq6aK2ZLytuwQhokkj+JdbUfo5ZbE1flHfuOiqyFoKjokJ9xEmjIzqaffCf9eKiN3
 rJZwDxjVT5Ac5rBO8NB+XXNVWGvS7vgFA5168rcnaptysPU2YbmPzCILAi4Is03J8HdvJqGMD6F
 n+U5NLICUGoBxxKzl/bozXIExySxL8ZLvvdqQdHLCqMtclWHTBMjyhi33BW9ufzmZMfMJIq2cVA
 buCwxApsbdDj3kds4AXa7zxU6Y+XCxMwXGLqDMEVhfX9PUf3xngCrLNqmX8Wf7aElcvnW4gVf1E
 R1/7T6N1ntCXVidPP2gHUvuVL5VOORZ0wRThgfosZlHdbrkWYCp0auJ8TalyrUNU8WHaCTBkbue
 dS0MKzziEabP281eOC97p+NtPXFz9BK9A2UClInQmNX3hINx25jzryohT3Pct3NFB+s72cxo8tk
 SvOzRMeiP6Gb6JhotGiPf6XRS3Tu7pOo58LVIS+c/kL6tsR9yOFDJLB4Ck2A9j1esUtx/r8TD4M
 ALcxS8yTuXJhnM/6shREdnHqihCWyXViVvvnH1sBtQ8WQrETP65fg==
X-Received: by 2002:a17:903:1105:b0:29e:9407:a8cb with SMTP id
 d9443c01a7336-2a951819f99mr14305565ad.40.1770347696508; 
 Thu, 05 Feb 2026 19:14:56 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1ced:e57b:71bf:567a?
 (bg30dhzpdc341w7g29yn.ip6.superloop.au.
 [2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a9521baf7fsm9898395ad.59.2026.02.05.19.14.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 19:14:56 -0800 (PST)
Message-ID: <279edcd7-bf6d-49a7-91c9-4c886f5d9d60@linaro.org>
Date: Fri, 6 Feb 2026 13:14:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/24] bsd-user: Add do_bsd_semop implementation
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-17-8d8ff0035372@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205-bsd-user-claude-v1-17-8d8ff0035372@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 2/6/26 03:26, Warner Losh wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Add implementation of semop(2) syscall to perform System V semaphore
> operations. Converts target sembuf array to host format and executes
> operations.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/bsd-misc.h | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

