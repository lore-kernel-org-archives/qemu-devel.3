Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14ECCCCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 09:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6mqi-0002Jz-QH; Thu, 09 Oct 2025 05:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6mqd-0002IB-Sz
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 05:22:08 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6mqb-0008Hn-BH
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 05:22:07 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so4743775e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 02:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760001718; x=1760606518; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x4PTUjRAj8pRAtPl1ODWBTzVr7iM09LnqH5Jlh7j3hc=;
 b=RW7ByAwmsE4iByECGqhvt+FuaF1F39AmGFzYS8nN3qDxDUZDeKoQOyHmvyS4m/YZOo
 w/1haUttqRtQUb3PZCAfPLemZMDRG2iUGibfN+/SSAb8HHqg4Kom8kD2r2sfWAEEu0NR
 fzFkHnZpaznv9B39pXufvn1LSBEKg7xhJ55S2Y5wqJKrp+H7+39v65dW5qh0KXKgyQjS
 tAGMOm1ZN12FjdPZ7dQVg2acx3PPOTvVQIkdJOCYsRl4tqYmVLqeAKKfJGjbMXjM3zBD
 Y6idK9s1GxnkXHjAU1cT2QYLCJatvnCZawkgXcXsgJIuC7RxwEBnhPNKnJuGn1DEHyi/
 EfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760001718; x=1760606518;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x4PTUjRAj8pRAtPl1ODWBTzVr7iM09LnqH5Jlh7j3hc=;
 b=ewmNJTdLKAuG6S8ZWMWf1fU9BPLYy8S0z3V3BOZ18J6jPTwPOrW9IuEN0WUNKJXeMr
 x+epNq2HtceYW+JNAKBJwEK6xxfSoNOAJyKY52JQUxUgYqULkZJlrtj5pZWLZIgVKyfk
 GdAubQIhsGbF/05+WbnevUl2N+t6a6hoGOmSIR2tNx4AczEjAfnqU6cpcHu7a/jnuni/
 Kn0tAMEFhtrPN4n1ioKWRgmzpkX3d11xMUAOQ7W3cwY7ACACLZrOUFnSBanfBBTqt5TB
 TWNpNNsMt1bx8yiqFCPjq1VwmKnoemMHINg0IP/WcoIASA6EQ9FG+N2/bkTrwGvrnd4x
 jqBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHGWTE1FEXuxrsoaLQGhEpYb5BMWBgxsGYjIFfUo++i1pa7c9JD5JM+dpxggyW+9iNanAnkihyAIBV@nongnu.org
X-Gm-Message-State: AOJu0YxJzpzuYhvcCdXRg6OgTxI2ZOeCFf9FwJ2Th6MwaYleaXvF5gzy
 LuucuC4oTVeJC7RqsIUSAHpjUXCQIDoYW7kMuM7Mccu7QYWwplkBx9ecj5Bpnha+aaQ=
X-Gm-Gg: ASbGncs/GpnpE+YFUzoMgmLludiKTkLeMKkiBhtUQPndotqSrV7foB5qvsTeClxrzwN
 C0zwgqNyNhLwFfgXCbDTYp4JHyX9a879cHTNeLiCEJjHtuIot2e5f+3RcycN7tG9H5/S2oCzHoL
 NZAnkfNlO1QOtEmnbOkcc9vbDJXhh4Y7R5sFste0i3QbWEfsz+lBDNDxKPFZxSGFSXP28m2z/UF
 WeUs5+yLjx7ztWU5jTaVkIs2Bd6ZDQ/bVW4v5P3PJrwPAJStHfopYkIKlcqTmuaDNuMH0/BCFVQ
 5QM6NHunrPHSKobEuwhdgfPAVnbMeVtE+p+VFkZl5LiRBGf5oyR2rrzrs93Yt6RQM4UrRHJeHog
 GzffejcCUN47HHV40/PJM/z4a1Vx4o21wLKWp31HNXHCtQK2YFUJ6gyoKg07UfJCRJAschBwq4n
 57GxpzzCRSicNLl+rFdA==
X-Google-Smtp-Source: AGHT+IExgwxwbWckfpHBISW0fcq/yIc8Ev5ES+47Oj7rSVRKMi5OEU4SagdWODwrro6GOOJQAAzaeA==
X-Received: by 2002:a05:600c:1395:b0:46e:37fc:def0 with SMTP id
 5b1f17b1804b1-46fa9a9efaamr48489145e9.9.1760001718469; 
 Thu, 09 Oct 2025 02:21:58 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46faf17b82bsm37527155e9.15.2025.10.09.02.21.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 02:21:57 -0700 (PDT)
Message-ID: <39be0def-fc09-4f24-9457-00858daba247@linaro.org>
Date: Thu, 9 Oct 2025 11:21:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bql: Fix bql_locked status with condvar APIs
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
References: <20250904223158.1276992-1-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250904223158.1276992-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 5/9/25 00:31, Peter Xu wrote:
> QEMU has a per-thread "bql_locked" variable stored in TLS section, showing
> whether the current thread is holding the BQL lock.
> 
> It's a pretty handy variable.  Function-wise, QEMU have codes trying to
> conditionally take bql, relying on the var reflecting the locking status
> (e.g. BQL_LOCK_GUARD), or in a GDB debugging session, we could also look at
> the variable (in reality, co_tls_bql_locked), to see which thread is
> currently holding the bql.
> 
> When using that as a debugging facility, sometimes we can observe multiple
> threads holding bql at the same time. It's because QEMU's condvar APIs
> bypassed the bql_*() API, hence they do not update bql_locked even if they
> have released the mutex while waiting.
> 
> It can cause confusion if one does "thread apply all p co_tls_bql_locked"
> and see multiple threads reporting true.
> 
> Fix this by moving the bql status updates into the mutex debug hooks.  Now
> the variable should always reflect the reality.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> rfc->v1
> - Fix comment [Stefan]
> ---
>   include/qemu/main-loop.h  | 18 ++++++++++++++++++
>   util/qemu-thread-common.h |  7 +++++++
>   stubs/iothread-lock.c     |  9 +++++++++
>   system/cpus.c             | 14 ++++++++++++--
>   4 files changed, 46 insertions(+), 2 deletions(-)

Patch queued, thanks.

