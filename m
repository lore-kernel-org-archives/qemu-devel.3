Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343CEC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuH0o-0003jP-Jc; Wed, 12 Aug 2026 18:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuH0i-0003iq-NC
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:01:24 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuH0h-00054h-19
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:01:20 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-84847482584so311154b3a.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786572077; x=1787176877; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SEM1Ruj6SZmdf0f8fylixqfLhhc5wxUiRJwP5PrX5g0=;
 b=o28YBXoU/4Pm5uYs3lgiJioYPT2i8lTjaIvC8AW/NhSJu/4EGCYLiLFCux3h4BkAPc
 a62SYk8LdHHBh7l5mIuYyaHj+Ffbct+RwJ3EOgKFq/Rx29hgXVOLzWKhhTH6jwpusAOd
 vDkUPz+eRAi38jRyIPF543Rfjp0AYTIUBXjCZr07nWOUup9bcq5qwv3IltsuKqlmdR8J
 20ZIIU9cCLiktDf+Xc60cVQUrpoxCFh2HaAv/G1cEnO9Tu7rzbln9xwY4AlJTpR8K8bA
 9TIH8rafEatYOXMhRMmRZ0k/QBb0BWqKnLGybUW1nmAZN6odb4vFxHaocE7/1tA/fuMB
 /+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786572077; x=1787176877;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SEM1Ruj6SZmdf0f8fylixqfLhhc5wxUiRJwP5PrX5g0=;
 b=TT1FUanRro/RjcbPN0VJFnEs3XLNIx7DlN59kCGs7vzgdVqgdbRT66xBZRILvVkIFn
 CIys4Jg/UDMHioL0gm6178x91BJ2+tAQ6lKopkIpZTpCT3Z1Fq7rebeEYaWYzmiCU5+A
 iXgRDSg/PzJQ44SQvZg74wjeKB1ewNziSsHQ02OWUxSpyDJwJX+UK80qoih/ru++IKqv
 I6eD8mNWJT5jTGdPaRceJUmQMIcvW6aB/GmvKyYI9I0B+oThKtOHrtSaepknc23gvYCx
 MNhqLmbZ9q9PLyOJwbnOO1cnJs0kOn30m6hvTIRLIcnOMaOQ9X+ANqvWH2pdjntFSQG+
 h9QA==
X-Gm-Message-State: AOJu0Yzw+53s13fGZjkzuqdGAfuo0ooPujcb3TIWA/YfxJYAi9X0EMeo
 rfV+miGDX+ou5AE1M4KAo3Ert2ic/lxY+ec6akeQoVCBJq3u7hpYVZWw+AzB+xi62mxdbtSwF4S
 Mqcvo
X-Gm-Gg: AR+sD11t0s0cm75zPi26imr3XwgkiQ+IK16ESnsDMyfdvKDKi6/McNimAKKQX11p2N2
 4CN8J1apa3Un+poog/sk/wJGPCZKgTMXqKqcviI87iaG7QOE6sfPVH7xU3o66PCM4tzOWCgHuxH
 M1J+DY1aea0mF2EOSDWbeWFhMqOyyfTKIA93bsAckIesYxXNX3Ml8s+TNiauc0kKK1invv7wjjd
 YA298s/2EUTtWew1oVolhoH3N/TptasCh6pJp/TBZPLhFniAM3xBDASVKBUTNopfTUfVXfvdNWI
 rcQ7pMTU3IfiWLfxxPOr4c6wYueRCrXbdTjJFQcZ4SMNuYcoo1w6t6OnTTj5AswWZDzmdGDFW0d
 UxYXYiz50c5HQbXNA1aVZrGtNclnoJJrbYM9XC8NXTa1LTby0r+qeb2Fmlz7UPbid/edjGCMvt/
 S38VM/3oeBiJjGmlDuyV9Ed1D69XMed6f4xi6BD2YXW+m5FSfFo59aKQIWX9L4x6LxPAJ4Mya70
 8wJIv5u0qKeP+/0gdJ45onw3x30TPrySy5KV/g=
X-Received: by 2002:a05:6a00:4c94:b0:848:2a69:97be with SMTP id
 d2e1a72fcca58-84fc8119183mr677437b3a.10.1786572077017; 
 Wed, 12 Aug 2026 15:01:17 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fc5a1cd63sm149936b3a.34.2026.08.12.15.01.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 15:01:16 -0700 (PDT)
Message-ID: <f0a852af-1859-4133-9d96-be8b9231888d@linaro.org>
Date: Wed, 12 Aug 2026 15:01:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] Next patches
To: qemu-devel@nongnu.org
References: <20260812151444.2611689-1-peterx@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260812151444.2611689-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 8/12/26 08:14, Peter Xu wrote:
> The following changes since commit 84f07211cc5b4fc6a371559bf8a5de4fb068e648:
> 
>    Update version for v11.1.0 release (2026-08-11 10:04:46 -0400)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/peterx/qemu.git tags/next-pull-request
> 
> for you to fetch changes up to 2375e9b1239eb6ad794eaae29245b94f429c87c5:
> 
>    migration: Fix rare hang of migration_channel_read_peek() (2026-08-12 10:42:09 -0400)
> 
> ----------------------------------------------------------------
> migration/mem pull for 11.2
> 
> next 11.2:
> - Dongli's patch to add cpr-transfer support for HMP
> - Fabiano's doc update for migration on security issues
> - Gavin's fix for MMIO access support for memory APIs, reverting ram_device ops
> - Sam's migration test build fix for !ASN1
> - Peter's a few migration hardening fixes

MacOS build failures:

https://gitlab.com/qemu-project/qemu/-/jobs/15865084063
https://gitlab.com/qemu-project/qemu/-/jobs/15865084064

../migration/ram.c:4291:54: error: incompatible pointer types passing 'ram_addr_t *' (aka 
'unsigned long *') to parameter of type 'uint64_t *' (aka 'unsigned long long *') 
[-Werror,-Wincompatible-pointer-types]
  4291 |         if (usub64_overflow(total_ram_bytes, length, &total_ram_bytes)) {
       |                                                      ^~~~~~~~~~~~~~~~
/Users/gitlab/builds/qemu-project/qemu/include/qemu/host-utils.h:552:70: note: passing 
argument to parameter 'ret' here
   552 | static inline bool usub64_overflow(uint64_t x, uint64_t y, uint64_t *ret)
       |                                                                      ^

Note that ram_addr_t maps to uintptr_t not uint64_t.
Which should be functionally the same, but is probably
an 'unsigned long' vs 'unsigned long long' mismatch.

Perhaps we should just be using __builtin_add_overflow via a macro instead of inlines so 
that we get the full functionality of the types accepted by the builtin.


r~

