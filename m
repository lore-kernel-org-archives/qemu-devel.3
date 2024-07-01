Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C07C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 19:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOMLE-0004x9-9C; Mon, 01 Jul 2024 15:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOMLC-0004w4-5X
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 15:05:30 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOMLA-0002AR-FD
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 15:05:29 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fab50496f0so19005815ad.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 12:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719860727; x=1720465527; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZRJ7LGfW8bFeCum3fC3UeBbLW9COKln/tOVIBfem8oY=;
 b=mJHf8Uc/yOOp68hWuZQ0sRutsRJj/7aDjDt8P5rKOSxojli01GtC0z1rV4Z3SlPr1J
 IqSS66bnKNQ4XOWLvdRAWBCsjSry2K/Jj3Fq8/yEKhTLi4DRiXbpi8Zw9esmm5WbIrRs
 EcmJIh8Di4Q5thk0U0pF3qVqEYuvJZXRv4x4o8ehTIRkeCarXWb/knviVxQx+S5XKMMw
 lLz9B91KarXo3Xq+hs0uRkeyRx2FdazZSLEkKs2KZu5nkGFjYFx/UGbO6rTxLxb2IwD8
 uSwZ7Qsr+pSOrhEdzPEPw2SP7QDreaC0/DVF23X1qu16veBOZZQqtPfuNcLnrkS7j64S
 HTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719860727; x=1720465527;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZRJ7LGfW8bFeCum3fC3UeBbLW9COKln/tOVIBfem8oY=;
 b=vnqpZPndk/Ug8v0N/c8AzIRQAINDVFEY02vNV7sGn5HuBowi1Xf1BKqwTqXGbpLDbm
 lU6KfL/JeYkF/BFulmm+V/1BYsaSEv0b30ySLvEZhw3t8dbntrlmyPKIDNW4oxIpRi15
 7oTstfo8hWN8PbVmhqayKWh/2tB56dFuQTA9Ea7W3GxkSyPEA53o1h/+ag/3Ba6SC0WW
 /kzdWQYNqOlaGVzJOT+CvAUSTszllKo3zEqCNbIHGCyArEocOwF0HlmHDuclJ8Kb6LEk
 0v0Pi9VfITl0+lD4KF38ZPrklivXblnLAR2pmkCsIPuW2g8WBh8T35k7fuZOTVaIAmQ8
 YgBg==
X-Gm-Message-State: AOJu0YzW4SNmMKcP882wFaohRrHYOCZ8N8rM1m6t3GvUAkg6gvB3/1Q7
 SXJ/9rj9JwU6SFH7AgZDWSfvB7d+CJxTmXMny/tbbqCbmSeZuZqKucvL4d5IFVU=
X-Google-Smtp-Source: AGHT+IEFKCI4aAHgJvwIRohmhmKIf7NcyVNocGBUVfSfegsX+9qGZKuwJ5Bdxz2ok7TvANSXcnCIBA==
X-Received: by 2002:a17:902:db10:b0:1f9:b681:1956 with SMTP id
 d9443c01a7336-1fadbd02092mr33559525ad.61.1719860726509; 
 Mon, 01 Jul 2024 12:05:26 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fad304311csm57232125ad.31.2024.07.01.12.05.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 12:05:26 -0700 (PDT)
Message-ID: <8036cb57-1474-4ff6-bcee-e7c3f7070119@linaro.org>
Date: Mon, 1 Jul 2024 12:05:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] target/i386: CCOp cleanups
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240701025115.1265117-1-richard.henderson@linaro.org>
 <CABgObfYq5Ti6UC7Os9nhyi5XU0VmLvT80rF2tZ4hR9A7cRHjBg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CABgObfYq5Ti6UC7Os9nhyi5XU0VmLvT80rF2tZ4hR9A7cRHjBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 7/1/24 10:48, Paolo Bonzini wrote:
> On Mon, Jul 1, 2024 at 4:51 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> While debugging #2413, I spent quite a bit of time trying to work
>> out if the CCOp value was incorrect.  I think the following is a
>> worthwhile cleanup, isolating potential problems to asserts.
> 
> Hi Richard,
> 
> no objections at all to introducing more asserts. I think keeping the
> array is a better underlying implementation for cc_op_live() however.

Hmm.  I had an implementation that would detect missing entries at runtime, but this one 
detects missing entries at compile time.

> 
> I'm also not very fond of mixing "sized" and "unsized" CCOps in the
> 4..7 range, there's no real reason why CC_OP_DYNAMIC and CC_OP_CLR
> must be close to CC_OP_EFLAGS and the ADCOX CCOps.  I also think it's
> clearer to keep CC_OP_POPCNT[BWLQ] (even though in practice only one
> will be used because popcnt needs zero extension anyway).

My objection to keeping the unused POPCNT* enumerators is that it interferes with proper 
cooperation with -Wswitch, to diagnose missing enumerators.  This is also why I removed 
CC_OP_NB.

If those extra enumerators are present, you either have to include them explicitly in the 
switch, which is less than desirable, or add a default case, which disables -Wswitch entirely.

If you don't like abusing 4..7, then we can use 8..11, placing POPCNT at 10 or 11.


> As an aside, I'm wondering if CC_OP_CLR is particularly important; I
> expect "xor reg, reg" to be followed by more ALU operations most of
> the time and to not be followed by a jump, so it only saves a spill if
> xor reg, reg is followed by a lot or store. If gen_XOR used either
> CC_OP_LOGICn or CC_OP_EFLAGS for "xor reg, reg", the values in
> decode->cc_op_* (CC_OP_DST=0 for CC_OP_LOGICn; CC_OP_SRC=CC_Z|CC_P for
> CC_OP_EFLAGS) would be constant and wouldn't add to register pressure.

You could easily be right.  Improvements to tcg in the last 11 years may have made it 
redundant, or it might have been wishful thinking even at the time.


r~

