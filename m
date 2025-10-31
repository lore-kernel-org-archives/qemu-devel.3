Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E22CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 12:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEoTU-0007Y8-4Z; Fri, 31 Oct 2025 08:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu@bonslack.org>) id 1vEoTJ-0007X4-B6
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 08:43:14 -0400
Received: from bonnix2.bonnix.it ([37.247.49.194])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu@bonslack.org>) id 1vEoTA-0006p1-7j
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 08:43:12 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 bonnix2.bonnix.it 83E93264793
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bonslack.org;
 s=20220805; t=1761914571;
 bh=IqP5ZTLK8tK7TW57xXTTGyHckMIJ8t33c3Vg9hKt0VY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=NgR6tR2tc67yXIMKVyAw9OH1hzs0R//GtoIQkKtyoja9qZIS6YO6rXobYha8/UhCL
 y0yC+fraqdswU+7UbWFaS9AiYes8VL72JetMDhylvGb9bmxX6w59VK9CjtCHHzeks7
 agcbWT4TV9tUwP4HNduCYQBO32M7EMTaT1HFnK5U=
Received: from [10.0.0.70] (dynamic-adsl-84-220-72-247.clienti.tiscali.it
 [84.220.72.247])
 by bonnix2.bonnix.it (Postfix) with ESMTPSA id 83E93264793;
 Fri, 31 Oct 2025 13:42:51 +0100 (CET)
Message-ID: <fe3312be-05f8-463c-a62f-c09b82399321@bonslack.org>
Date: Fri, 31 Oct 2025 13:42:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] Add termios2 support to linux-user
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <4bfb150f-7f5a-459b-808f-b0d1abc3b830@bonslack.org>
 <87y0qzzjst.fsf@igel.home>
Content-Language: it
From: Luca Bonissi <qemu@bonslack.org>
In-Reply-To: <87y0qzzjst.fsf@igel.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=37.247.49.194; envelope-from=qemu@bonslack.org;
 helo=bonnix2.bonnix.it
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 31/08/25 15:45, Andreas Schwab wrote:
> On Aug 30 2025, Luca Bonissi wrote:
> 
>> +#ifdef TARGET_TCGETS2
>> +static void target_to_host_termios2 (void *dst, const void *src)
>> +{
>> +    struct host_termios2 *host = dst;
>> +    const struct target_termios2 *target = src;
>> +
>> [...]
>> +}
>> +
>> +static void host_to_target_termios2 (void *dst, const void *src)
>> +{
>> +    struct target_termios2 *target = dst;
>> +    const struct host_termios2 *host = src;
>> +
>> [...]
>> +}
> 
> That fails to copy c_[io]speed.
> 

You are right!!

I added also c-[io]speed copy. Will follow new patches.

