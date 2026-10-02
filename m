Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9610ACA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 06:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCWsO-0000HR-I8; Fri, 02 Oct 2026 02:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xCWsI-0000HA-35
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 02:36:06 -0400
Received: from mail-wr2-x0e.google.com ([2a00:1450:4864:30::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xCWsG-0005VH-Ew
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 02:36:05 -0400
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48af4663da5so2879815f8f.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 23:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790922960; x=1791527760; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0ot0/F1UZ9OdzvNJCJHB4AspsDbbKE65XrKDIZ/WD38=;
 b=x8KxISp6HoFIavD5pOGtJJSmjJ1EDumXXWdasGqfX4xsKI+5Ctjefh3LJiw2tDFXL+
 Otfnrm43/brOuR56dJh0+56WPHEkgOiJ56cNccYU0LhnE7ih4T3GhkFd9jlpT3N9RoRG
 mIPGVtRq5VRnis3BrlJQG1JQpXVz4/wgCugImHme3V972RHRqOLSkUrgvebQz+kWpOxD
 oSDze6ZEGLPE7SFPQXYolQCr4EGoAs01PbFGkfyssuts+ZXpQle+Xih9TQh5r+cUTMUs
 PskTkZplI0TSQoDs0X5Szya4ICwmipH3klDb8jeY9BhfesHaV5sjsQ9FdFbSxt7zsF/B
 N2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790922960; x=1791527760;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0ot0/F1UZ9OdzvNJCJHB4AspsDbbKE65XrKDIZ/WD38=;
 b=Nrbyw9Gfzf6qWqVEpRcgtF4MErasVFxs/anE7kOGupD7np33zDjC9VH5Y07+nYHALH
 4gyUfF5qw/FLBNI3+c48D5TMDI9iVAC2RLEFKaNyxdZ3ptxbukfcuxbuTFFozxBFghKl
 +9vZ06XIAapHMPKF44hSbSe5kjV/Dk+tdfFY3NbhmxuKoZ4nXBfC5ZTxHd/k9Xpeapm4
 zs5TKQZHDg5xX28/RMMlPcVY3evHsBmsfDhbvLYXfJZTWWk2FBsZoI62pXuFqP3X5RT/
 zK3JjBepRW3GazJI16NG5zi8LB0NQigMT56T/8N3bTtXVJHhTpev5N/tpUtg5mIqrjev
 dOfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwc3yCpC3tYxhe2qqDjp0cfSemI7jxjPQesmx68bEv93fIcuxZvejHK16vvHV/tYyQbd1rMXIl3cg2M@nongnu.org
X-Gm-Message-State: AFq9FYLvHptdD2Lbky4/noOAKQXp+m4RFpEQ/ow+/t0I4B6jToYdCnSv
 4wCcZAcR+A5u2eBMpZVnbbOINMA5CSU9FOiG9eblvo4psYLyQo9uTY2bnFZiUINhnnU=
X-Gm-Gg: AYBFou3OrqPn44/UM6YYx6l4zx/c76MoNqBG+BtwKOT7CrbrF7hP5JNS5AD9sOG1BK2
 1O6O267Q38ojDD9z546q9FUc5ZspGRVOMeKap+zFecb75TaS/8eYhFYQx3Dd3ByQClufoVmiA1b
 Qfyt5njcEuXQcfKn8s2S+e3evoRf+0gnvfzpZ4pTwSsUPB663UPfgflbN4jaU7bkNR6HcmtibZ9
 RRX9W5odLXcDmV3aIFjWdcmnnsllzLlCikMm7uyX2LxtsO1O+M5DJz2/W7s0AN/sMmKC+s/lHlU
 Mk3HAxzZrGT7jxh3hNmd793bBOlwJG65S7i/y0UGCegX7xLaL2q+jTMWEZNyKmfo97yNOFBnPg7
 VnMM2Vzoydq15w/2LczwEo0+D4wtmBbyCSJD9Ekz+2Zk4UHFJtU9JbkURaOxBimK6LWMwnpQdXM
 9FLzSYOsWRsqHp70XYmeI6LvPUvuiGqPWWYpjj7QXAO3b1ji3NmMlwR3cgLPoij59VyF9i4TQyW
 wIKV7N10KiXsz5CfoZLrlehOhL+EH7EqWsJlOQ/Da6AAua2kYEI
X-Received: by 2002:a05:6000:420d:b0:48a:fcf9:acb5 with SMTP id
 ffacd0b85a97d-48b126d2a49mr3171603f8f.2.1790922959687; 
 Thu, 01 Oct 2026 23:35:59 -0700 (PDT)
Received: from [10.9.5.233] (vpn-konference.ms.mff.cuni.cz. [195.113.20.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38104f89sm3845146f8f.30.2026.10.01.23.35.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 23:35:59 -0700 (PDT)
Message-ID: <e959773c-49ac-423b-bf9d-0d637fd45f48@linaro.org>
Date: Fri, 2 Oct 2026 08:35:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 010/101] tcg: Generic expansion of tcg_gen_movi_*
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-11-richard.henderson@linaro.org>
 <5f762124-6163-433d-b8df-90ad0ae76353@oss.qualcomm.com>
 <aa750bd3-39b0-4409-9fe2-802098b356f4@linaro.org>
 <8fd00af1-330e-4685-8512-70a484df523f@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <8fd00af1-330e-4685-8512-70a484df523f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr2-x0e.google.com
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

On 9/29/26 14:45, Philippe Mathieu-Daudé wrote:
> On 27/9/26 19:57, Richard Henderson wrote:
> 
> [*]
> 
>> On 9/27/26 08:31, Philippe Mathieu-Daudé wrote:
>>> On 27/9/26 10:58, Richard Henderson wrote:
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>> ---
>>>>   include/tcg/tcg-op-common.h  |  2 --
>>>>   include/tcg/tcg-op-def.h.inc |  1 +
>>>>   tcg/tcg-op.c                 | 15 +++++----------
>>>>   3 files changed, 6 insertions(+), 12 deletions(-)
>>>
>>>
>>>> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
>>>> index 77ed34fcb8f..b2fa509cd1f 100644
>>>> --- a/tcg/tcg-op.c
>>>> +++ b/tcg/tcg-op.c
>>>> @@ -370,6 +370,11 @@ void tcg_gen_mov(TCGType type, TCGTemp *dst, 
>>>> TCGTemp *src)
>>>>       }
>>>>   }
>>>> +void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
>>>
>>> Maybe this commit (the first converting opcode with an integer arg)
>>> could have a description explaining / reminding now all args are
>>> passed as int64_t.
>> Where would you place such a comment that would be useful?
>> I can't see how or where.
> In the commit description? [*]. Smth in the lines of "We've dropped
> 32-bit host support; now all integer are passed as 64-bit arguments."
> 
> Anyway,
So there's some confusion then.

The argument for tcg_gen_movi_i32 is still int32_t.  The new internal 
function uses the union of tcg_gen_movi_{i32,i64}.

So the comment you're suggesting is wrong -- there is no API change.


r~

