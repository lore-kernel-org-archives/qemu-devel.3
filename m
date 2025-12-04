Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B3FD1F9A0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 09:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR5mO-00040E-Gf; Thu, 04 Dec 2025 04:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vR5m6-0003YS-3P
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:37:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vR5m4-0003kK-7m
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764841039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cg75oDZxYunqMu9nxWR9+TBcQVfxvNj5Ce7tlQLvazU=;
 b=QAVRXvQnyhKav7yh2phxJnk3zi94B8OFBEj2duMa0BCsjh7o2EXf6csKTjkJquslbdLIkQ
 GeHG/oUlVuBI3Paiqh16ZrWe/bhdvZtj66+mAmV4u8+vBErZTHTYDTUfdnuwtTzMA4xuq/
 Dzre5FoDfZD/4gdhb8Swo4cIWldG0z8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-7OUqKi99Mw-MGgxoDDHWhA-1; Thu, 04 Dec 2025 04:37:17 -0500
X-MC-Unique: 7OUqKi99Mw-MGgxoDDHWhA-1
X-Mimecast-MFC-AGG-ID: 7OUqKi99Mw-MGgxoDDHWhA_1764841036
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b3339cab7so449252f8f.0
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 01:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764841036; x=1765445836; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=cg75oDZxYunqMu9nxWR9+TBcQVfxvNj5Ce7tlQLvazU=;
 b=MmrffOXkb3YXjUHyGjqePEqMAEzK4G3YCEJljf3AbdjlBWrPXiIFr5cjGztzffKmyy
 Hgr2lmoiYhkraScsnWr8kSKFPusR1answjq2Lw9T4vZH0E1EdsLQk7CzZW0B2o9NSsY5
 hGRlSj7uE52DQsNnuXzR5RYgKQzSKMX5jnRMkscbeRhLgwZXHt506eGQCQJMx4nnc23W
 aFLmsAhgbaLYan+fTKgqZihyVq7rZUhYOEj0CEb4R+kACZBudE+vT6q3dE3LX5cAgA3z
 8slf5XqjMFEXzGV5SuTOx6gIs0aR3wp29cq2F+9wA26kaO2mUoB1WYOAAoaxjXrgDQHN
 sz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764841036; x=1765445836;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cg75oDZxYunqMu9nxWR9+TBcQVfxvNj5Ce7tlQLvazU=;
 b=hfrxl8h8pnWCAU1pcEwDGJkxnzr1LLRPx79ELftYs2ASBYzCaaECRxtxxReFwpeVPy
 I6crDRfThfGtvt1iIgSJ/pCW83oxuM/2lKV7U1ZSu2G1v5G3yr/e5Bexc4QMmv3dHWxF
 dqm2E3aMsu7iddbIiY1uEwhCnLl5ELEPVigugFKQKUPQijHxzi193DbDIM7R6rfiN+h7
 op81zZVkCaEgIE8pdua7LMpIsmjuCY/WQBU8y00mzjZG54CJri7qXVQPksphFRLFWmX5
 oO0rqdL838OZmLGPJ/3+yO7ODuBkoCC8/i14hA69/DKhYJMWpmsMUmAj//KDxuOUJnoB
 VJqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAq4KRmz5uQKVR/eUUs2c6XG/ngVqDSLKSRBMmqKknFBM44gQ9RRnGIvzlhHIpGOR/vNeh5yOhT8j4@nongnu.org
X-Gm-Message-State: AOJu0YxnuQ+2Ei8TbavMEp6L1cakgrDYBQsQ4SRYjfpXY+YS6ZUKaj1z
 SB3IyxZCJY5h8SZ5UpK0VuqM171cmMnIwQswtqyE9Vs5G2KVMVRtfSqSFznZXf2teZnhF8sAkK+
 UcGDS6we7dqDnOVig4krZdTX+l9FX9Ec2/PoErh5uzdmauQA/Slztby40QSBQfkDB
X-Gm-Gg: ASbGncvYsTK8HKujFEKkRqzDOSGe4MbJqBHBv9LP+ZcJRPLgfyCfDZ5vHuw613DOfb3
 gdsWiWyCliFzO5Hdc+SwcUe2qeYUk/oav+aIfY+3I6kA9utEXT4fPbjY3DCON6K61ndAwRoX/Kd
 Qzd/zCHCXqrp9/Ly4IE1OXIhIhuWZehhMkRw+FtSl7UVpqJ/vrQ1kvTsJoEsQ1idMmg17nffAsw
 jpvAqOhny+pdLBMYiP4Mr7QLJoI2uZ3555iQbX7XilLGlIRUo1FgtIUSiWDNu8T4Rzf3Xs1Kt+n
 plM1B/n+LkTVKkvPBDD6tGhWDXmE7nhTb83eWtblonydEhJynL3wpYQ7GuyleRNQmTQyBYuY+gY
 un4awLE4=
X-Received: by 2002:a05:6000:1a8d:b0:429:c709:7b58 with SMTP id
 ffacd0b85a97d-42f7985c6afmr1914047f8f.50.1764841036400; 
 Thu, 04 Dec 2025 01:37:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0SY25UtrYt6eRQNsdWR6CCkzLqjAbaEqbaqRyMFSgqWbPz7KoJ7eSS4UdOxdcOm7BbVU54Q==
X-Received: by 2002:a05:6000:1a8d:b0:429:c709:7b58 with SMTP id
 ffacd0b85a97d-42f7985c6afmr1914016f8f.50.1764841035945; 
 Thu, 04 Dec 2025 01:37:15 -0800 (PST)
Received: from [192.168.0.5] ([47.64.112.197])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbfeb38sm2158849f8f.12.2025.12.04.01.37.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 01:37:15 -0800 (PST)
Message-ID: <01700ae1-b5ef-43f2-af2b-2eb648c5a147@redhat.com>
Date: Thu, 4 Dec 2025 10:37:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] target/s390x: Fix infinite loop during replay
To: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
References: <20251201215514.1751994-1-iii@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251201215514.1751994-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 01/12/2025 22.49, Ilya Leoshkevich wrote:
> Hi,
> 
> Here is my attempt to fix [1] based on the discussion in [2].
> 
> I'm sending this as an RFC, because I have definitely misunderstood a
> thing or two about record-replay, missed some timer bookkeeping
> intricacies, and haven't split arch-dependent and independent parts
> into different patches.
> 
> This survives "make check" and "make check-tcg" with the test from [2],
> both with and without extra load in background.
> 
> Please let me know what you think about the approach.
> 
> Best regards,
> Ilya
> 
> [1] https://lore.kernel.org/qemu-devel/a0accce9-6042-4a7b-a7c7-218212818891@redhat.com/
> [2] https://lore.kernel.org/qemu-devel/20251128133949.181828-1-thuth@redhat.com/
> 
> ---
> 
> Replaying even trivial s390x kernels hangs, because:
> 
> - cpu_post_load() fires the TOD timer immediately.
> 
> - s390_tod_load() schedules work for firing the TOD timer.
> 
> - If rr loop sees work and then timer, we get one timer expiration.
> 
> - If rr loop sees timer and then work, we get two timer expirations.
> 
> - Record and replay may diverge due to this race.
> 
> - In this particular case divergence makes replay loop spin: it sees that
>    TOD timer has expired, but cannot invoke its callback, because there
>    is no recorded CHECKPOINT_CLOCK_VIRTUAL.
> 
> - The order in which rr loop sees work and timer depends on whether
>    and when rr loop wakes up during load_snapshot().
> 
> - rr loop may wake up after the main thread kicks the CPU and drops
>    the BQL, which may happen if it calls, e.g., qemu_cond_wait_bql().
> 
> Firing TOD timer twice is duplicate work, but it was introduced
> intentionally in commit 7c12f710bad6 ("s390x/tcg: rearm the CKC timer
> during migration") in order to avoid dependency on migration order.
> 
> The key culprits here are timers that are armed ready expired. They
> break the ordering between timers and CPU work, because they are not
> constrained by instruction execution, thus introducing non-determinism
> and record-replay divergence.
> 
> Fix by converting such timer callbacks to CPU work. Also add TOD clock
> updates to the save path, mirroring the load path, in order to have the
> same CHECKPOINT_CLOCK_VIRTUAL during recording and replaying.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   hw/s390x/tod.c           |  5 +++++
>   stubs/async-run-on-cpu.c |  7 +++++++
>   stubs/cpus-queue.c       |  4 ++++
>   stubs/meson.build        |  2 ++
>   target/s390x/machine.c   |  4 ++++
>   util/qemu-timer.c        | 30 ++++++++++++++++++++++++++++++
>   6 files changed, 52 insertions(+)
>   create mode 100644 stubs/async-run-on-cpu.c
>   create mode 100644 stubs/cpus-queue.c

Thanks, this indeed fixes the test for me, so:

Tested-by: Thomas Huth <thuth@redhat.com>


