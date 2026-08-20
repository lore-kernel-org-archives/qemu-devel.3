Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFBEC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 23:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxCNE-0004yJ-HH; Thu, 20 Aug 2026 19:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxCNC-0004y5-Tv
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 19:40:38 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxCNB-0002ou-As
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 19:40:38 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3811f512167so441456a91.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 16:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787269235; x=1787874035; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bcqaz9snVJ78VBL2ZoUqruuCSyEI+hDYLUhmYtAdKHc=;
 b=aEuQztHtpjDi92Oc6uWn5x3rBXj5mO1V4XjuuUHA38aBxLX5JIAsCQNNypT6GmQDi8
 ajrfCTDgWOwlkXdSp7waBuVUF3xLHREX2rKC76SjjLKmStixWi+HVcP4XS+z7Ifsy7Dy
 S7CBcZCkLcHtl4dPox/UWbZMP0mai7KfS1M4Wdc+3ll/m7SLMKz8tZEsgT/+DIuVJ+PB
 01ZlNMeBBuGvGo5Y1haRUb7+F2qX3U2nbb8Ewxw+dyf0KLeSewdrM3Nb9QopHmp1KY5C
 WOfPMPb6UXeSFN1WSWNLDFCeI6aZ3W+Ik1WBLYpmv6XPil3cJ15MpK6da6zgHeKvAnmV
 PxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787269235; x=1787874035;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Bcqaz9snVJ78VBL2ZoUqruuCSyEI+hDYLUhmYtAdKHc=;
 b=K0PWoF+n1v/y8LHv91/xPBpwnhOf3E5Ee5kTK24wMOGju2QvCFXOKoylwJpK/sjGap
 vWk3h0qQM2bJoJroQGJJ7CnjbUYRM3iEmOVIlCc48TBypCpS5E8J5+LzgM1GAbvPZQBx
 eNErVDYLGS8mDU3WULuE/hxGmpiFgA7032f/arc7+yXit7dsp5JZy0Cu4kX02YOHgnkm
 sTsCwVnemF/UtshXCz+kI0GH+4ntYUxb8egVc+KRc2W3vawXPVY3Y5cRniM6hFsWywpF
 xd59J0tC59gM1nqOl/LKT/ag0xc1+oz5y+BPIqIl0JPf6t+yVtrQP/zeUmnnW/Huyss+
 9kjA==
X-Gm-Message-State: AFuF++kJnReSOND+a8q+0+gB9KxUKqllBmmf0y55DrgeuwGDwShC9l7U
 AFBPiMKRRHe+ZhhmX3A/KytU9bvgxIj2ZdAu1tT+b6uRkhrQaHin9zuVo7ixer/uRyMGFvySZAT
 DrO2o
X-Gm-Gg: AR+sD125qwUkR0+Jm0nA7oA8AZ14nZGGg5aL+O5EFf6WZyr5e2pkFQUV5MGkEic1cXK
 oQmooKPl8RtJrU0KpdpPuOr4pq/Z9kAFl9oome3uY1lsNZfQ2Zpx4Ymk+GzY3iR0L8pPJ+HeaIq
 cIIqTappFE4Rt99otDpevlRehpNkdi8YO2fK8BW7cdAS5AGKPna5VMvLgpSUGberC72Ch3Qt+th
 zSY4kKC4i6yBTIaAfxejwCMuGc74ADX+86iw7GXl9q/Uity+be3YaeEa/rOinnk0hYWHKWKEcEa
 XU39+a15pvvb838EXfYtdXwZH9bTh6j+YqN1utgcgDC1iovizg9KcNAnh0BqEX4kjbz50Lrl5IV
 GQxmvTZm0aLu5gNa4Xtu6aWKJEJbzUknF70TpgsfVNV/SifpervfEmqEd+DopoHxlS2rY6sg9Ng
 ajhjn64vxPTIvUlhonhAfqF0v08QaDkc5QdwqMbR/6DxHWCx/QOXXiiwBUqdp1Mn5iPFYPjpGKc
 1Yy/d+jL80wpXs=
X-Received: by 2002:a17:90b:1b41:b0:383:5a16:bd70 with SMTP id
 98e67ed59e1d1-395c39f97e8mr2809295a91.16.1787269235282; 
 Thu, 20 Aug 2026 16:40:35 -0700 (PDT)
Received: from [172.20.6.151] ([108.174.179.84])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c45530absm691710a91.4.2026.08.20.16.40.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 16:40:34 -0700 (PDT)
Message-ID: <52f421c4-89fa-4af4-92da-1ebd101636dc@linaro.org>
Date: Thu, 20 Aug 2026 16:40:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/hexagon: invalidate translated code for user
 icinva
To: qemu-devel@nongnu.org
References: <20260819045339.3661773-1-brian.cain@oss.qualcomm.com>
 <20260819045339.3661773-2-brian.cain@oss.qualcomm.com>
 <39d5f3bf-4f04-4e90-8c32-8132ced0b4cb@oss.qualcomm.com>
 <00d99c24-0cda-47e1-adb0-e3a836509ba0@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <00d99c24-0cda-47e1-adb0-e3a836509ba0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 8/20/26 12:00, Brian Cain wrote:
> 
> On 8/20/2026 1:37 PM, Pierrick Bouvier wrote:
>> On 8/18/2026 9:53 PM, Brian Cain wrote:
>>> Route linux-user icinva through a helper that invalidates the addressed
>>> icache line under mmap_lock
>>>
>>> For system mode icinva has nothing left to do, so it stays a nop.
>>>
>> Why does system mode icinva is a nop?
>> Shouldn't we invalidate translated code also?
> 
> The normal behavior of instruction translation in QEMU is conservative relative to the ISA 
> constraint.  QEMU will invalidate translated blocks that become dirty/stale from a store 
> instruction, so icinva can't flush anything: it's already flushed.

We do the same in user mode, trapping the stores via read-only pages.  See 
handle_sigsegv_accerr_write and page_unprotect.

So why do you believe that you need to invalidate pages manually here?


r~

