Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECA7C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 16:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpA32-0000MR-06; Tue, 26 Mar 2024 12:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rpA2y-0000Le-Ck
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 12:53:12 -0400
Received: from ivory.cherry.relay.mailchannels.net ([23.83.223.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rpA2v-0001eZ-7v
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 12:53:12 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 6C325900FA1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 16:53:06 +0000 (UTC)
Received: from outbound1g.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id C322B900C0D
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 16:53:05 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1711471986; a=rsa-sha256;
 cv=pass;
 b=qFYxu0rzakA3sF7jV19jCaAFRWOIhyLb+3nmtXpvCVsGByHpBRm4VWO3kzakKOUFHvkAgO
 t+rApbFmsKa/W3IareKP/O2QsIJ7ojlA1UmaTJNuq3ZjVao2JHUkJzCYe6jE0e8gz5o7a+
 htP0ndxyEo1+B8uhqpitbUHtK33ZQbhYjJlBlzW9/MFR4c7Zo+gh06kdGjPuAL+gyh9rZq
 afhL56+TSx0uSJwcDb8/NPlcl6bQ43w1eRc4XH+Wo+EdSoyOrSGHFdQAeqeUlhNXtMBHrW
 nMq/uuDhG9NGp816nXw1C4+XsDJKFUuEBMff3H0QRGRjuj/GS222HmRBY2ck5Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1711471986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=4C38izrPPN/JehTellfArrD9XF6xORrmePMPbDsJf+c=;
 b=BwhPLMx5aDpUdHccIDp4YnON4op7mssZgTkYRrBYpEwpICJFXQfzVwVplVsO5whhJTnRFb
 xiKFlgc/DplVgt56MBUXrzK7HAbR3X9WyW48ZFnTShJH2eCVOkfcgIJTtKL42ltx+0YqO2
 qAvdsgIF/q9pZaxL4NHza2YuZoKNZvtWsnwbFeOQJX9cCB7MMzSuTskKhPj4k5JVHfF9r8
 V6qbmRdrIZkwABCWTyLJGKhc5aT8SqmaSai/wqzkxX2XE4tfHRHrn+0swdAFQdeNMqBD2C
 i11NdEjl3b8l8ZqWL/jUEYyAfa4YqYouIuZEpN9EJU698MCx8AEHbehZ3UEMbA==
ARC-Authentication-Results: i=2; rspamd-7f6944c677-ns7tl;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Decisive-Little: 06b4cdbe7da21849_1711471986307_1113749707
X-MC-Loop-Signature: 1711471986306:2031886719
X-MC-Ingress-Time: 1711471986306
Received: from outbound1g.eu.mailhop.org (outbound1g.eu.mailhop.org
 [52.28.6.212]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.119.87.146 (trex/6.9.2); Tue, 26 Mar 2024 16:53:06 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1711471942; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=O7gSm9hZ8pHxqfQeouBMXI9bHcOQxVIwCJM1SmPUczJiVNPd1tEHBsJvsyp94gPl0jr4DkMJpJb81
 ypixyEe4KnUd69UWVuGBvtsghllAv5HV3HdPO94/JwtW9lTPPkX6deVG+cSHQRePeWNL71bjyIeaaY
 30gcgrXJIzx+hJ7OEghz89N0H/ptQP63lMvhoCIhv2DosMUPjF8SBCx0e7n9FYH0EkYzUtHAPJPkYy
 kmPYGa45JSAJgTNbbbx59npFjLCaN7RYtcbk1+tmLR3eXtwYI4zQD2i72fySGAAm3eCkazqcdpcjDf
 tmwWyqUarMaeGv5eV5U2udBskm0A05A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=4C38izrPPN/JehTellfArrD9XF6xORrmePMPbDsJf+c=;
 b=RjPhutonAoIiHvWm8pF60SlBWdAM3+YfoNRRNGr2GOqysjnjtg+eaGDDp/sNUpcr43Nc4L1DUxNsu
 xfZWZgeR2HNDNJAuVC3NV+hleWYtTGiuCDrunyVBfMvvsyTkXcZPdeveiCBQmD0/bJh+QBsB4YechS
 to35/MUnItzgeMw7fWtZfgDvIFaBggywEO8AaiInSz0LZgD434VzYH8MEDp+EfFzTcpaJIVnUPjEzN
 1GtVEmUO6Rnox1Yy1ar3pbgOL1QLNkstsy0C0J4jI+33zhvyiekYT7+Yi77jokRzcH41ZXLvSDKKME
 r4en53KqPIgJyEkvO3vwgCwPgKDOUkA==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=EnDlNhM5; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=4C38izrPPN/JehTellfArrD9XF6xORrmePMPbDsJf+c=;
 b=eTK+wkXU4/H8SBWs/B8goPM4e6G0Xd+ZupsdGcvxZE845Ooi5wCaaO1zAK6hWpviygpgjL/674zTk
 W6I3ofQtkp7m+SipSk5t0eKaCgwRSg61B2X0cX4ZKQ+tFd8hpFYlMPcKNrjVTPw4RpUpTW1xlNR800
 PYb4hfiBUkVOzt3Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=4C38izrPPN/JehTellfArrD9XF6xORrmePMPbDsJf+c=;
 b=uRobWV+Hf/ZdIDCReXzteaOiq92N2NrZVpdVK1ZtHx4D0VGeBpX3T3XGnUsZ5fK7k1EC1nj+DPcRG
 afvIc4G7M2RkB6Bo87iLAxy0DyShFcdWQkURN4ukxuIMlW4lvbkEPbIrhvWcAQYS8pVMo2GgrCymyb
 wcPRN7nYvVeULiOXNkcNkmiGFmj8m5l7BCNgggtK6oC9I91HZBUK61UhTgOC7XUIEbc5ZHiIuUdjrG
 6pCfGuZPVtnjnqAt0ZnwmYqbq4fnJkhaOginYGouNGZXtf0nMYwr/kRPJgZBicwvFbiVnq8qe0ancq
 c5iEDBklpRIg+wZXVAnA/99rSQbOHhA==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 34f3dc27-eb91-11ee-b2ad-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 34f3dc27-eb91-11ee-b2ad-eda7e384987e;
 Tue, 26 Mar 2024 16:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4C38izrPPN/JehTellfArrD9XF6xORrmePMPbDsJf+c=; b=EnDlNhM5dbNnh74BdslYs2qzeD
 060mew2vhcUaBePq+a8YmnhIcYrEXl2d3MECa2PzAg2pK4rycoho3psI+27OVfQdt2VmIfnknEEob
 cL9fiwGDujY4kG0y3CN0BAdi1I04EUMb1a/8c53z7C+x7XN30wGzzrguFRJVjwe+lU1swaMN8ewh+
 +24lpSTnfREmvpj+UZSDxlbmnSJN5+3FamUgARyrcke4C59thW4/MULID4Oq/XfOh9uJZgclIy+Qv
 Wshwjjn+qG3P4GN7Epr84QrqbiNj3KduM23zeYGKGxSz2/nzRzmn2edH6ayCRmNhsAFYZXdu27YGq
 ceWv6+bg==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rpA2h-005keK-0X;
 Tue, 26 Mar 2024 17:52:55 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>,  qemu-devel@nongnu.org
Subject: Re: target/hppa: be,n nullifying first insn at branch target?
In-Reply-To: <bcbf8200-1ffa-4a39-b7b5-e19a65257962@linaro.org> (Richard
 Henderson's message of "Mon, 25 Mar 2024 19:20:34 -1000")
References: <875xxa14z1.fsf@t14.stackframe.org>
 <bcbf8200-1ffa-4a39-b7b5-e19a65257962@linaro.org>
Date: Tue, 26 Mar 2024 17:52:54 +0100
Message-ID: <87r0fxyly1.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.223.94; envelope-from=svens@stackframe.org;
 helo=ivory.cherry.relay.mailchannels.net
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 3/25/24 09:33, Sven Schnelle wrote:
>> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
>> index 7546a5f5a2..56c68a7cbe 100644
>> --- a/target/hppa/translate.c
>> +++ b/target/hppa/translate.c
>> @@ -3847,7 +3849,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
>>           copy_iaoq_entry(ctx, cpu_gr[31], ctx->iaoq_n, ctx->iaoq_n_var);
>>           tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_b);
>>       }
>> -    if (a->n && use_nullify_skip(ctx)) {
>> +    if (0 && a->n && use_nullify_skip(ctx)) {
>>           copy_iaoq_entry(ctx, cpu_iaoq_f, -1, tmp);
>>           tcg_gen_addi_i64(tmp, tmp, 4);
>>           copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
>> So i think the problem is caused by this optimization. Does this
>> ring a
>> bell? Debugging this is rather hard, alone the logfile above is 6GB in
>> size...
>
> The problem is a missing
>
>     nullify_set(ctx, 0)
>
> within this block.
>
> I have patches queued to reorg the IAQ handling, which I hope will fix
> the problem Sven saw with spaces.  It would fix this as a consequence
> of other unification.  But I think it's a bit too big for 9.0.

Thanks Richard. Let me know if you want me to test patches.

