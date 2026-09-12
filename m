Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8223C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 11:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5LaZ-0005RB-6z; Sat, 12 Sep 2026 07:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5LaX-0005Qw-7u
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 07:08:05 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5LaU-0000V3-Ds
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 07:08:04 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccdaea76so198691a91.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 04:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789211280; x=1789816080; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PMe2b9XHuw0Ra5YEx0GV5LfHsp/+TrpksiK5Cdj3rvE=;
 b=fzjKfqdBUaIWIWBWCG3q07jumBVMKmfwqqCJuC/7HrQmVRiY29jBD7g/wI6bDzkQp0
 PIrxK0SKoqDeV5qF4sPWMElRFZ8Tcs3t9KgjW7QJXHdbpk3tJADjJypLJi3dYn5JAN7N
 UH87peNPGJQTHjWSybZ4RwRHtAOcDlwEaXsOLaSRwlCJ5FkCGDxA7cK1PJAwaid4tUiJ
 wO4NZty1Y2paHVfw9XW8T9ypPbsui9g8Lmk+pj53ycSPHRzIHfLlzJWIDezw9jxoBHhN
 0+tU86yE2GiN+WiDKiE5Comrf6rwiunbXXdyRQJoupLcPaS2mTVlhLZs28uYMvdfsu6z
 GK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789211280; x=1789816080;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PMe2b9XHuw0Ra5YEx0GV5LfHsp/+TrpksiK5Cdj3rvE=;
 b=YmKGwauSGoMPGWxnpB6i0YKC9O39QQ3xkqVTwBz4WbARbUHSv+EzlHPNaxVuitnF2B
 7FUYqkZbUIcPUluyte7AB5NQV1oueZYg/Hg05dv/cbrvZy+eWXrhrLbVFfa3DCwWjqhQ
 9zEL82rElwamH9jaFbGZkt0v3QXRNhxjdiE7VzajZ/4eJ58AkAmDt4FZfhw/Rl3DSyXq
 dRI4EcBBArTuRqQgGoDjdz+naNkpLh9HewD0NZ8YuvE1xsTsKiO0z9ZCD7quN+Rzn4Sg
 5ZK3mlVLDWOZ3pD4SkmhEzeAiR7Tz6VeIUv0yrCFlqCr1A7CV8S5EgzkFVPsXuyagVd6
 sLbA==
X-Gm-Message-State: AFuF++k1+W78g2KpjCWAH3P466/DsYD4oEquizHpMy5MpSoEW50GZ2li
 ZqlO+X4zQZNLx5RDk4Bxo7NNsmzF0Mh/3Emv39YcrRZbTiEOkRU3U48DiKyD9dn4+0qm5kvJc4W
 GioQznYY=
X-Gm-Gg: AYBFou0Pzf8N6SCcioUhAm86uHlKkMosnIje9mJjgAPFjCl7gi3I5Rx7uik9bBvVzR9
 LwL3RkKZhHMowkSnVQIIlY9AwARD8138vp43Hlnl/yrWJhgzXHbck5EGHWNSHXDIJ7LrNwgs3OZ
 azJxiYPFgJUbfXrWCcDwNqQsZpIKLxkJXnBw0UDUxTnD7yf3aS5ORa9n+qmld+r4tAiX/5RZ1H6
 3xWXfdX6xfW0pzVQvv1Eh31MT74lcOktH7nrS+LklwdeQ7aDjo1zMLjBVNUbfZMxUanUy6YWIJM
 xCkl0n4g6k7qtQcMmR2zBqlNhtHEbRzw1bPWegphdyrnvQhi7l2lR4+7CumULa0BgK8WIoD7Wj4
 bGBxuy70/EKF1sECY/VTlaaR89JVtVk9zKsI1RHyjwaofkrOi0Pdw+iGXoygxZYlv4AY3d7JLts
 8L4SdJrEf3C3VNxZh78P0r3wKygWqfBgt1+0touxkhHgspiHZ7upXfGbq4O4Ja4hjV7/XDxLkX1
 qCSTwBOYG17wzUIO1pz73VDpg6LvBbOkT8zx94kCTmWUBrTw5ByxWVu05XbHQ==
X-Received: by 2002:a17:90a:f947:b0:398:baa7:4c2f with SMTP id
 98e67ed59e1d1-39d97eeac5cmr8358467a91.5.1789211280140; 
 Sat, 12 Sep 2026 04:08:00 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:bf2d:a6f5:e308:cd27?
 ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4cf72dbsm14413979eec.3.2026.09.12.04.07.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2026 04:07:59 -0700 (PDT)
Message-ID: <47bc110d-3775-4d2a-a4b3-626d304089ce@linaro.org>
Date: Sat, 12 Sep 2026 01:07:56 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] target/riscv: mask RV32 XTheadBb th.srri shift
 amount
To: qemu-devel@nongnu.org
References: <20260908124755-v3-0-wangyang25@otcaix.iscas.ac.cn>
 <20260908124755-v3-2-wangyang25@otcaix.iscas.ac.cn>
 <aqOKQ0WfB0vTTFMG@MacBook-Pro-4.local>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <aqOKQ0WfB0vTTFMG@MacBook-Pro-4.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/10/26 19:22, Chao Liu wrote:
> On Tue, Sep 08, 2026 at 12:47:55PM +0800, wangyang wrote:
>> The XTheadBb th.srri instruction uses the low log2(XLEN) bits of
>> imm6. The generic shift helper rejects values greater than or equal to
>> XLEN, which incorrectly rejects imm6 values 32 through 63 on RV32.
>> Normalize the operand before calling the helper.
>>
>> Tested: RV32 imm6 0, 31, 32, and 63 witnesses with XTheadBb
>> enabled and disabled.
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4413
>> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>>
>> Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
>> ---
>>   target/riscv/tcg/insn_trans/trans_xthead.c.inc | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/target/riscv/tcg/insn_trans/trans_xthead.c.inc b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
>> index 681f70e5bc..34226b1be5 100644
>> --- a/target/riscv/tcg/insn_trans/trans_xthead.c.inc
>> +++ b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
>> @@ -141,6 +141,7 @@ GEN_TRANS_TH_ADDSL(3)
>>   static bool trans_th_srri(DisasContext *ctx, arg_th_srri * a)
>>   {
>>       REQUIRE_XTHEADBB(ctx);
>> +    a->shamt &= get_olen(ctx) - 1;
> Looks right, but usually we handle this in decodetree. We don't
> normally modify the decoded arguments directly, so could you move
> the normalization into decodetree instead—e.g. a dedicated RV32
> pattern/trans like zext_h_32/pack?
> 
> just like:
> 
> {
>    th_srri_rv32  000100 -..... ..... 001 ..... 0001011 @sh5
>    th_srri       000100 ...... ..... 001 ..... 0001011 @sh6
> }
Given that the cpu seems to decoode rather than reject the bit, I'd 
handle this in translation rather than decode.


r~

