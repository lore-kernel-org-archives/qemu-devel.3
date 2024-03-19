Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A2EC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 07:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmTab-0004ho-NX; Tue, 19 Mar 2024 03:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rmTaX-0004gy-PH
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 03:08:47 -0400
Received: from jackal.cherry.relay.mailchannels.net ([23.83.223.95])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rmTaV-0004Xr-Ra
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 03:08:45 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 515DD141FE3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:08:38 +0000 (UTC)
Received: from outbound1g.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 75BB1142E2F
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:08:37 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1710832117; a=rsa-sha256;
 cv=pass;
 b=vOgcVn5/iUgBH2l6WRzpl9o6OdgAwCmmaXVskRpFFY1FTxIs1IhKEqgI9Q9Jjd1lBMerI9
 0r5xan8FJDi2xS93rsZppSyhg+S6rDmKL0uy8YUzXXsJoj+mL4z8h6L3QYPldcu4TcADgA
 wzht0GG7Sz5ff+GAO0uG/QHRiKbEymM+rG2ni4rYS//VOB15DcBDL1AGO1ZFGGUwSwGXxR
 wWurIRlFUSvIkhyspsq8bopHe1ZvwewT8i94uAOQ/sxOkPW6WJ+tE8Of+uCLfcBc5l5KQE
 ZMr9Ddkko+9ezBRMI1MkKFN1qDzxZDEQp6GgeraTqwYQT1/J7Tb3aNtVbE/CTA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1710832117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=vfwMYHJldgZOpkdqmoZkp2Kzx8Un242lbsDlt9M7l2I=;
 b=nlIOOycpY0bLXnvCJR4mUmuymrF/9Ppr1MbyD9stKSlxvtj/epSThLUPli+hYs4+MOsbIN
 GGV/MP1Z+pNP3WvgkYzKjPhtyTe8j/168+xPJGvXx2MzqGM0YX1GU91L2fJpqyz4qb6yJB
 32kM85MuuoMy2pYmO5tx3EmRKmCwFryconz4wl2jZzyMkTCnNHLmFy+spnJy8nfMW+fkmu
 NVGv7Ymq467pYuzxtBMllbuLaNyxCIRTwNuT+F1YajALJJQv6Kx3Inn2JapnBzV7Gf4LX+
 eCwunem28oC5MVWe1Kx8ltNixUl/VTtn12ribGtwyBVSUmXd1xp7YOPVEEAWgQ==
ARC-Authentication-Results: i=2; rspamd-76c7995f89-tbv7h;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Macabre-Oafish: 12f435c46cf246dd_1710832117975_213472892
X-MC-Loop-Signature: 1710832117975:4001825755
X-MC-Ingress-Time: 1710832117974
Received: from outbound1g.eu.mailhop.org (outbound1g.eu.mailhop.org
 [52.28.6.212]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.126.245.255 (trex/6.9.2); Tue, 19 Mar 2024 07:08:37 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1710832082; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=FwkzwYpR64wU+x75PtYNXlGb0Mrj2Sk2YbNeHjguTJfrTNriAPiZgtuzo5xEIUyvIW5sZwIl71JkV
 l3LiK9wigLaIm54DQ9+j2HmIhuHNS10EkMOiWOSgmF4GsjskpVJ3634cu7/mPVyexlIXYFZZRXwgPk
 nAOedOdsV6X0djrdIyh1PLu9z5+pl9q66GKIbgGQjaFqlKL97dBCsMV/QXvnGkoCVpHo1/rRPd3Yz+
 RGMeWncCpz0ML0Z8HZuCu3WuUMv1XNk4tlvpLR+1kQvJBcI57HtcDb8bTl0+kCe7TI6BZnrpsvH7sk
 SMhx+nCZjZtbjiUblVqtrrvcGkV+i+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=vfwMYHJldgZOpkdqmoZkp2Kzx8Un242lbsDlt9M7l2I=;
 b=Eer48JXrCqxKvuzmt8Oz4flkLPD4w/Oe6dB9qQ1WTPn5vQvMVFan4kVYZaA+g1jykPWdI140KdCbN
 JXA7KzTF8f66zYpnmRucdMVvlkPWdUcHZjjhvspDPJyxuHgiXeVxV5nQHBaU97HRYV2327f24dw9cj
 AL0wJRjKvVGfRzXbeUtiUbLZ6pHW9H6ztN98Mo/M50OXiuJQ9ops3HSX248yZgTvP6zi0JiNZJuSx2
 rDhF9poRIZhQtIO9UgZZzHMEk4LY3hSkwM5q5EtYDFPifnZXD8eohPxmfaBaxgHZwsyZooWeWjM/hP
 3CYjgMjyeE/DvI/46NgI9DszjlwmyyA==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=b5Q9Xnsq; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=vfwMYHJldgZOpkdqmoZkp2Kzx8Un242lbsDlt9M7l2I=;
 b=Z/xs5g+IxFuDxicezRMvYDGPm/qu2zOkQOOxADdt0Dh1GTNh4JvAxLTV1/S5JoIg9RK3XZhvZkpGZ
 Fxqq2LTGe1fdKYBdSQM2T5UOpvIXAzDkOYKUBzmJSuOqkzSn7aKggP4vK9wPe7yj5vZAuThT+aKq0E
 GJ3PSeQOij0ltcAA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=vfwMYHJldgZOpkdqmoZkp2Kzx8Un242lbsDlt9M7l2I=;
 b=AO4GpmnT+2TANgSTeCx8BlPwNS2+o6cP8DiDBFuMarqNFeg1nMmPQNA+wAv2yTq+/vKrDhoClkchi
 qtWArAZDD9ZBfoFN5ac0Qh8PHAVhrdxWeauxH6LcezvHyJyK06sDLeXmJOFPWXRiMVA4TLLmvskc5l
 HRqXcQd7QJ1FT1K8C9kXuS3tpymiMt2rpS2GcjB5rE4GfwSw6vYZYNEhmNsF1T07JLqPPe8edqPGqq
 0KggmSW7E8H5NwbmQuhgiHKzS6idGQmNWKdollxAzZ+gx8k3xqWd5VKZs5AgTgk+/g1j5ypyfTUhVF
 +le3P3tACn0XHMA8eoZOl23XSXiivQA==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 6b3c7b69-e5bf-11ee-b1cd-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 6b3c7b69-e5bf-11ee-b1cd-eda7e384987e;
 Tue, 19 Mar 2024 07:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vfwMYHJldgZOpkdqmoZkp2Kzx8Un242lbsDlt9M7l2I=; b=b5Q9XnsqDEJe1tnhsAgUqAqnZt
 mOuh8Vp8lJpqJ6a+DmBXVbLjjVq+mbBHdQI7U85/BpuMMzwI13qVui+FeofkdE+nyaVqz5+znvppi
 MAwY+jEWVdJzl8eVB8lna2lRXD2lbaybm/Gxbzv+p8OE9MkxzvbHj2G3TRTQ/zYW03bQD6Ls6sUKR
 aoQc/XGOa0SdoDoHcwx+v4Xz+xb74vRMQ/Sr3DQB0DqyDZ0WXYGY6m9OntqTc95JS0TG+BKyDXnK2
 cZQvtIqGY/xIjwGqXr03Y3M1zBlB7y6MgDNDONa0/X/Bu0C4/G82U1HwC2NU/SNQL9F70QOX0aaNl
 VVxWGgsQ==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rmTaK-004Qhl-1Y;
 Tue, 19 Mar 2024 08:08:32 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 5/7] target/hppa: copy new_spc to iasq_f on be,n
 instruction
In-Reply-To: <1572dd6f-7a39-44dc-9fd3-5d02f331da54@linaro.org> (Richard
 Henderson's message of "Mon, 18 Mar 2024 11:27:23 -1000")
References: <20240317221431.251515-1-svens@stackframe.org>
 <20240317221431.251515-6-svens@stackframe.org>
 <1572dd6f-7a39-44dc-9fd3-5d02f331da54@linaro.org>
Date: Tue, 19 Mar 2024 08:08:31 +0100
Message-ID: <87bk7aog0g.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.223.95; envelope-from=svens@stackframe.org;
 helo=jackal.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 3/17/24 12:14, Sven Schnelle wrote:
>> Otherwise the first instruction at the new location gets executed from
>> the old space.
>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>> ---
>>   target/hppa/translate.c | 3 +++
>>   1 file changed, 3 insertions(+)
>> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
>> index 58d7ec1ade..a09112e4ae 100644
>> --- a/target/hppa/translate.c
>> +++ b/target/hppa/translate.c
>> @@ -3777,6 +3777,9 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
>>           }
>>           copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
>>           tcg_gen_mov_i64(cpu_iasq_b, new_spc);
>> +        if (a->n) {
>> +            tcg_gen_mov_i64(cpu_iasq_f, new_spc);
>> +        }
>>           nullify_set(ctx, a->n);
>>       }
>>       tcg_gen_lookup_and_goto_ptr();
>
>
> Without use_nullify_skip(), we're going to execute the next
> instruction even if we know it is nullified (a->n).  This is usually
> because there's a page crossing or breakpoint, and we need to take the
> exception that might be raised there.
>
> So, we advance the queue:
>
>         copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
>         if (ctx->iaoq_b == -1) {
>             tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
>         }
>
> then put the branch destination at the back of the queue:
>
>         copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
>         tcg_gen_mov_i64(cpu_iasq_b, new_spc);
>
> Note that iaoq_b is always -1 on a space change.
>
> So your change does not look correct.
> What is the issue that you saw?

I was running the CPU instruction tests from HP Offline Diagnostics, and
some be instruction was ending up in the wrong space. I don't have the
details anymore. I'd say we drop the patch for now and I test it again
later and provide more details.

