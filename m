Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BA0CA5FC1
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 12:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCyf9-0001zW-OC; Sat, 03 Oct 2026 08:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xCyf8-0001zA-0u
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 08:16:22 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xCyf6-0001AR-3F
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 08:16:21 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-48b08452cafso242642f8f.3
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2026 05:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791029778; x=1791634578; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9EXh0fuEw0Td9znZxJqhz6/1m5mzrfa9qNK7JLNrQcI=;
 b=fYDUAJ/mDJkoidbAfWlUskz3Rd67wnuTxKdb5cbSlrzT5tyBe75cZchfiShL83g+lq
 T9j+aG2ZlyEl1bt/M65dRdCSBUchy2/CHsu54kw1bs5TaV/NiCA//YEpCCQWqeoEBgWu
 Uu9niZYxDgbmBy6WQAfP9CC6HASQkQDPa8vLJUbJAMo9vbmuhtDZ162ut+kkdJ9IOPtB
 8JE7D5RgTVVG6u8VQyIQJOfLaMRT6AreCmxnGPxM+/j3JTmhbijxSEY/eSHMqb2SsglF
 C3NaWYMtU1+1jI9BqzfjnHTQmLutKjP+zC/2Gqoi06NoqiHuv7IxNvRBvDa0KcWR3V6G
 hoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791029778; x=1791634578;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9EXh0fuEw0Td9znZxJqhz6/1m5mzrfa9qNK7JLNrQcI=;
 b=FfaNwGzPaOwHjECdxdFFyQIMBm3luo7YDaSBzUIInLiEa7mYvW+zTdc8mT72DVKU1h
 oCan9GsORn8r+uDjAAlDjPa4uAqIX3vsHnzz1RL7Upq88AJG26IumL1OMEu/1EmFNhj5
 apDpjKGgPB/1y5yRSMSbL3rCK0H8rYrqdBYI1IlURxiijA7yZl8srkWgsUU33/6LD2eq
 G2fk1u6zgN/RUKibjyfDBI3QFM2tXNKXSuVTqeBDLSugSGtqhpy5gO36O2JgV1i499SQ
 7mR2vw3mpI17liNCDQfyb3Tia0n4ycPsV0t8MZBAv9u6VwyPrWdYRZYUPEaK4JkPrfbm
 Kt0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZs/MUN7I19LDrXavRPvY3bvdHtJmn96+L5oCjBZ1bXOvbFjkkdb89JFiBDYAhzCzCqKtrvetWskRw@nongnu.org
X-Gm-Message-State: AFq9FYKqosve5c9TwE0F2ZXFyYWxYJTvD2FjWt/EZkFXulvW9EPVtJ24
 89qjUi+QWf8AArGsCx3GLztB9EREv7/Af/3oQvpVwGihSgNQ9my/kz+EpZydQP/7H2U=
X-Gm-Gg: AYBFou1wMUlteDT/Ak8TtE+MC+DRQ0pIx4+jcHozTJaoqpGd47v+B/+4Ke7qRZEZNXZ
 1ryCUe/g6F80R+xaou/rcM/Lj+LuXWyNOJwr8ZuAOWTXnEK6PxGe/45dCXBK6lK/zrGNfgGlCKs
 nGmNZICor6r3OKbmFEUW4rcgQQLu9CY9lc1Qek8aPprR46yR+8wwBAmdkMkFCDX1W6dIyGCWJIt
 9eKjpumgdfSD3Au14bIcqvjtIQQxWG+s3a9KeLIsxk/RZD/9T9wtXuClOcwHV0nt769xvT2VKRF
 DMTwKcf/SK9KEtK55TP+cmFi4YQeZ6Ze7AwL9bIbMWRx0r8b/7A2sERWxmiocJBtme++5+fCK6W
 OrtH2fjz8pL1jPSv5OBpcESYvSHMMTD7a8Yycgu2PInPXfilfJ1m/6XfWP78PAJlXs4vBm5oGM+
 K8E3tASje8Q7wDv5ZubkuC46XO4125SZ9X0CebN0R6nukBu6Z9xDG5zbv581GDnKN7+712gGMUW
 MdkghzuqeGYcU5lIMi+4kr54P6e8Dj+m+DKDjUrUQ==
X-Received: by 2002:a05:6000:1869:b0:488:8525:4979 with SMTP id
 ffacd0b85a97d-48b12726233mr10371571f8f.45.1791029777943; 
 Sat, 03 Oct 2026 05:16:17 -0700 (PDT)
Received: from [10.9.5.233] (vpn-konference.ms.mff.cuni.cz. [195.113.20.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b82253e6bsm11571060f8f.6.2026.10.03.05.16.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2026 05:16:17 -0700 (PDT)
Message-ID: <c6a89114-120e-49eb-b62b-be3038cdfc1d@linaro.org>
Date: Sat, 3 Oct 2026 14:16:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/32] target/i386 and misc changes for 2026-09-28
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20261002091518.1139575-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261002091518.1139575-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:30::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr2-x0f.google.com
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

On 10/2/26 11:15, Paolo Bonzini wrote:
> The following changes since commit 9c88811b81a935a172c5c873b2ada2d9b38a5f74:
> 
>    Merge tag 'pull-target-arm-20260929' of https://gitlab.com/pm215/qemu into staging (2026-09-30 06:25:37 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 7b596a6918055eee8e17a78c84127b934ae4531e:
> 
>    agents: Add a skill for finding your way around QEMU (2026-10-02 11:11:37 +0200)
> 
> v1->v2: move validate_vex() before all operand decoding (patches 6-8)
> 
> ----------------------------------------------------------------
> * target/i386/tcg: fix EFLAGS reads in TCG plugin callbacks
> * target/i386/tcg: raise #GP(0) on null SS load with RPL != CPL
> * target/i386/tcg: Don't clear C1 for FCOMI/FCOMIP/FUCOMI/FUCOMIP
> * target/i386/tcg: implement APX
> * target/i386: Migrate error code only with an exception
> * agents: Add a skill for finding your way around QEMU
> * tdx: fix buffer overflow in tdx_parse_panic_message
> * accel/kvm: fixes

This has a number of failures:

https://gitlab.com/qemu-project/qemu/-/jobs/16911681150#L902

I tried bisecting the issue to make sure, but the patch set isn't 
bisectable.  At

commit a6d1cac8651b2a2d5eb56abbe1cea698e72e4e3f (HEAD)
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed Sep 23 14:33:32 2026 +0200

     target/i386/tcg: use zextT1 for CMPXCHG

I get

In file included from ../publish/target/i386/tcg/translate.c:3339:
../publish/target/i386/tcg/decode-new.c.inc:2765:10: error: use of 
undeclared identifier 'X86_EVEX_APX'; did you mean 'X86_VEX_LIG'?
  2765 |     case X86_EVEX_APX:
       |          ^~~~~~~~~~~~
       |          X86_VEX_LIG
../publish/target/i386/tcg/decode-new.h:273:5: note: 'X86_VEX_LIG' 
declared here
   273 |     X86_VEX_LIG,
       |     ^
In file included from ../publish/target/i386/tcg/translate.c:3339:
../publish/target/i386/tcg/decode-new.c.inc:2766:10: error: use of 
undeclared identifier 'X86_EVEX_APX_cmp'
  2766 |     case X86_EVEX_APX_cmp:
       |          ^~~~~~~~~~~~~~~~
../publish/target/i386/tcg/decode-new.c.inc:2767:10: error: use of 
undeclared identifier 'X86_EVEX_APX_pp2'
  2767 |     case X86_EVEX_APX_pp2:
       |          ^~~~~~~~~~~~~~~~
../publish/target/i386/tcg/decode-new.c.inc:2768:10: error: use of 
undeclared identifier 'X86_EVEX_APX_zu'
  2768 |     case X86_EVEX_APX_zu:
       |          ^~~~~~~~~~~~~~~
4 errors generated.


r~

