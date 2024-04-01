Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7C0CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 20:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrOi2-0006r2-U2; Mon, 01 Apr 2024 16:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rrOi0-0006qd-P5
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 16:56:48 -0400
Received: from catfish.pear.relay.mailchannels.net ([23.83.216.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rrOhy-0004uY-Nu
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 16:56:48 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 836136C398A
 for <qemu-devel@nongnu.org>; Mon,  1 Apr 2024 20:56:44 +0000 (UTC)
Received: from outbound5h.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id B57966C3F41
 for <qemu-devel@nongnu.org>; Mon,  1 Apr 2024 20:56:43 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1712005004; a=rsa-sha256;
 cv=pass;
 b=8HFzyvD/LewdmMTqNUlfqD1XRl8kxqJRlTpKCy8PfI3EImxXNfV1Izu1mRMVTioS+fB97a
 PV1C2JJunQ5ZieZp6uMCv6RW4vCCn6fqFuXcqTCilROwQLNSB5fiSeIeKWUw5cjvm3f+hS
 nbv2oDJqzbg2N+EplzTexvDkecUvKcuJvzw9Fph0dJwXK+uuebHOOBztouD9eMsDAx6paM
 SqZ317OobnpKrD8vM5GMNvSUfCF4UVGFenINnf8pg2bN/UIuozPGURx69lhxEQBYQCldFL
 rB2Z6V08NvdmzzADf1NojDycq+gykfJo+YrGxR3/BknqlQQdCYF1+6OB6mSWmg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1712005004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=cwxzOLguIUzbtGnK4x6zm0ZlvjSGeG2RJI/9m9KY9AA=;
 b=O93khtdiGMcL9oPXdd0XtCXw4DbMj3t0Y4dchLrOtc6hT4C3HMMhsHLbPPMcffKFqXE/vp
 oTl5rRna76xWw39CbQlnf+HEc3EaFgAvLIXNLzyuwyVPnDXtGbdvsse7VKTlcxtosWDmBT
 r+Hk+qvijChMj7+vssYjJ54RHP0KbF4z2evRZU6zxf39DVyEZimCR2LOoGWI2P9xvjGZ69
 D80T7UW2+vQ2cA9xapNh3bQddt40xVfGKawLP+76m2o6+ISqPdlvDs5pgJo9USnfPg6PPF
 lkHWo2IP+gINHqXLJpoFNYvB9DhbP2ruq3+6n2Y11PWOlHoDhO+QGJWpCOSc/g==
ARC-Authentication-Results: i=2; rspamd-5ffc56d49c-wk9jg;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Reign-Share: 018f49033c0d1543_1712005004227_2889533070
X-MC-Loop-Signature: 1712005004227:2739861608
X-MC-Ingress-Time: 1712005004227
Received: from outbound5h.eu.mailhop.org (outbound5h.eu.mailhop.org
 [18.156.94.234]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.113.47.137 (trex/6.9.2); Mon, 01 Apr 2024 20:56:44 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1712004875; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=ox0wQR9jGjYzOZ0JRNQfL3x2WS2n1VpMQ/RlMXt9t9I9Kdsi/bBJIa8R49fg0xpLkN3/MYBrnRqad
 FKB4oRefKnPazoP7wZnt9ziGhjUgmzx216wWkhDutYRseH/FBOSy4bkcRmd/TI/FilwzKJOzeanmV/
 frlsKMRc2RfeOzR3WsiNyZjQ3E/Q/HjiajhOO5dm52BW3DwenbbLPI9IIE17XB1fyUe1QE+nbIBSOX
 U0QwFAxEWTJzyGHQu4hlSxRx0dtxWOHybQqvWvGW91eB8kc8N08AwojIHOH1inbUASOvJIBv4Pbu0I
 Sdy4H/Auga08f23sGmk6mUIqUwLSqkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=cwxzOLguIUzbtGnK4x6zm0ZlvjSGeG2RJI/9m9KY9AA=;
 b=hxm3s9VyMRb0ZNhrNss3lTwaaY1LECDU5ef6Al29mCfDZVb1mTIfb7bUHZnUudDwrrbdvBdQStAt5
 GneR9EXTMMh3M9e+/yveXhZyLdub3TVWXPc1NbOI4T/mZvRblINswzGXU0oMzy1eHRfpJ40x7g5agb
 PDcoDT4waHtjFDNaYAqdXt2i61LOW7oWuzBt6eozkC0aWUHWBc0+gipXVudown5Ql2ls6drt7TOL4p
 JkCvrbzBchLrxDmzflMaVCxmmWkxihD1b9u2tneAuiVeYPx9Im2UD8p14+cHvJEk/YQjInr1Rek5q9
 CrH7vu0mos/RSqhDpVAektT6RuAL7zA==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=V/F73HAT; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=cwxzOLguIUzbtGnK4x6zm0ZlvjSGeG2RJI/9m9KY9AA=;
 b=Q2X53VZeimDi9Uc9a0EBnzLxJdaBPxfsAMywVhypIgs6qBDXyL8oxR8OP2H4FIK+pYsxcT1RFwT1H
 3xRxOQ+1e0FHM8fGSiU5WGY6YCU3qbpFLYi+EEbSy+WJzI+UAdaet32mtS2c3DbAAv5T03t+8QvQtn
 3GHFVVNYDBVsHgjw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=cwxzOLguIUzbtGnK4x6zm0ZlvjSGeG2RJI/9m9KY9AA=;
 b=uvJ+u1FyEOEx7H1cqZZNciJqWXzsMalBef7ExARVqiobt8MiBXIg6uuynewBH6KN55sZzUsX1wdAz
 RlXRKpMhi3TjPdIeoUBxbmnVVKlDmmAPQpJbPJfqI3I/hYOjtCRxtL6wfK0Cx6iF9tgU4mSiHgbjTm
 qS8BFGrxKsjRdNyRxvmnNLkCdPDTM6DCgdLsdrij0c/q22jl7wp7PAmBbTUu/XsC/XGMZPCZKLbvkq
 PHeFTbmbKo2xymCQ7RfPT2y+RgWhsJC4QN8nmwECnLvfiJuyVv+2sm8FY7QndnAz7y0Eyip/Trhjfl
 d49nlSI38h+zWpyMwvkhZUmToGzslog==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 0a37e64e-f06a-11ee-b8f0-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 0a37e64e-f06a-11ee-b8f0-9b9d9be6ef2c;
 Mon, 01 Apr 2024 20:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cwxzOLguIUzbtGnK4x6zm0ZlvjSGeG2RJI/9m9KY9AA=; b=V/F73HATxJd6v+TvQo1UqF3Q2L
 /jD3MqVImpcAi/i2BAS4stH4uV7OxW/AzNe/NUMGunnkgqQ4Yo7grcBWSz5OnQ87UP/u94mt7B3ok
 IwEhIG8htGsu73Du6CpoShz6i2AHKoFKU0uUnjbQEgxn6OxPownfioDZW1cJt2KIcju+vgskb20tV
 Kv36EuPegn9V67z9LvcNImcxmYWeAuSZxNcb/x+vpjVH1f4palGg/bTM549fpsSUaW9j0C55/bG+Z
 XtTP95YAQYBlYK4Rkjn1XHEqyNXV300EIR5GZeh2v4LBY5Jt7+Rc7BkSqTiffPeZaHm5PqPKXM7i/
 SE2v+9mA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rrOhr-0076Ga-1T;
 Mon, 01 Apr 2024 22:56:39 +0200
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] target/hppa: mask upper iaoq bits when returning to
 narrow mode
In-Reply-To: <87il10zu46.fsf@t14.stackframe.org> (Sven Schnelle's message of
 "Mon, 01 Apr 2024 22:49:13 +0200")
References: <20240401145201.2175873-1-svens@stackframe.org>
 <0f5697e6-da79-424b-866d-40d11b4db0bb@linaro.org>
 <87msqczujz.fsf@t14.stackframe.org>
 <87il10zu46.fsf@t14.stackframe.org>
Date: Mon, 01 Apr 2024 22:56:38 +0200
Message-ID: <87edboztrt.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.216.32; envelope-from=svens@stackframe.org;
 helo=catfish.pear.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Sven Schnelle <svens@stackframe.org> writes:

> Sven Schnelle <svens@stackframe.org> writes:
>
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>>> On 4/1/24 04:52, Sven Schnelle wrote:
>>>> For unknown reasons, Java 1.5 on 64-bit HP-UX 11.11 does signed
>>>> computation of the new IAOQ value in the signal handler. In the
>>>> current code these bits are not masked when returning to narrow
>>>> mode, causing java to crash.
>>>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>>>> ---
>>>>   target/hppa/sys_helper.c | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>> diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
>>>> index 208e51c086..3bbc2da71b 100644
>>>> --- a/target/hppa/sys_helper.c
>>>> +++ b/target/hppa/sys_helper.c
>>>> @@ -83,6 +83,10 @@ void HELPER(rfi)(CPUHPPAState *env)
>>>>       env->iaoq_f = env->cr[CR_IIAOQ];
>>>>       env->iaoq_b = env->cr_back[1];
>>>>   +    if (!(env->cr[CR_IPSW] & PSW_W)) {
>>>> +        env->iaoq_f &= 0xffffffff;
>>>> +        env->iaoq_b &= 0xffffffff;
>>>> +    }
>>>
>>> This shouldn't be needed, because we are already masking these bits
>>> later, in cpu_get_tb_cpu_state.  But I do have some cleanups in this
>>> area, and perhaps one of them matters.
>> Any thoughts? Otherwise i need to investigate and make a wrong patch
>> again :-)
>
> This seems to be caused by IIAOQ's containing the upper bits. With the
> patch below i'm able to boot. Not sure whether it's correct though.
>
> diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
> index 58c13d3e61..f7c4cca8f1 100644
> --- a/target/hppa/int_helper.c
> +++ b/target/hppa/int_helper.c
> @@ -123,8 +123,14 @@ void hppa_cpu_do_interrupt(CPUState *cs)
>          env->cr[CR_IIASQ] = 0;
>          env->cr_back[0] = 0;
>      }
> -    env->cr[CR_IIAOQ] = env->iaoq_f;
> -    env->cr_back[1] = env->iaoq_b;
> +    if (old_psw & PSW_W) {
> +        env->cr[CR_IIAOQ] = env->iaoq_f;
> +        env->cr_back[1] = env->iaoq_b;
> +    } else {
> +        env->cr[CR_IIAOQ] = (env->iaoq_f & 0xffffffff);
> +        env->cr_back[1] = env->iaoq_b & 0xffffffff;
> +    }
> +

I guess the interesting question where should these bits get masked out
- i would assume that this place is to late, and it should happen
earlier in trans_be/when the iaoq value is copied. On the other hand
you had one commit that removed the masking in copy_iaoq_entry()...

