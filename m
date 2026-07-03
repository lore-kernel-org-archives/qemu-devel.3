Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620FDC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 20:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfkpE-0006nR-91; Fri, 03 Jul 2026 16:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.h5uv5rvsj5sc3l0=rmoi7tbbg9wh=gbt3t6dsw4bj9s@em1175899.techtravels.org>)
 id 1wfkpC-0006nD-Nl
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 16:49:26 -0400
Received: from a3i384.smtp2go.com ([203.31.37.128])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.h5uv5rvsj5sc3l0=rmoi7tbbg9wh=gbt3t6dsw4bj9s@em1175899.techtravels.org>)
 id 1wfkpB-0000rs-6f
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 16:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=techtravels.org;
 i=@techtravels.org; q=dns/txt; s=s1175899; t=1783111757; h=from :
 subject : to : message-id : date;
 bh=dR6ooKDCvaM9+YXZs+6qs4n18R6LgYW5cAMxFTo2218=;
 b=m0ruzS2XWU0DtMzMg76pek3q/mo15ucaaHxREfJJoDiDGQOqxziiLoo6WWCQ/xg4i3KRG
 q0U3Ms5P+wAtEz6coJojAPeZJvfbf49Ak536bfKGjh59JRGxzVjON0SJtJZBf6MTU2DkiKX
 dv6q44pDkqvMybxhYCz5+b4ffFLwO4bzZZfUWH6U7iFJ6t+JxsxXjMx69t5IlPCFukocihj
 7hg7SIBO1egU+hh/GTrn5Gn4mPLlhrlBHrGDEaPMwoUgedznNaYQQf9lvmbaQL2z+8Fu0nj
 wVgb6N8kuACw00qVIE6nFVh3CCoVoWy1aTIb51CvXA+XZ8t4WaWJI4YqYLrA==
Received: from [10.91.249.253] (helo=boxtwo.techtravels.org)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.99.4) (envelope-from <keith@techtravels.org>)
 id 1wfkou-4o5NDgrqV7R-wHeD; Fri, 03 Jul 2026 20:49:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=techtravels.org;
 s=mail; t=1783111745;
 bh=n/cWzOvaOj00HSJ5tH2VbE8HNzmSW/aAMi+udprspBw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jJsj3xup1ckGPRa/LYQ6ua8sxkl8L5GoHh5hsSXEeM14J/UBHmT5pQ9hJUbL6MS3k
 MrPFA6zh//4eEoCR0yRFMQBdyIDGesdV4ilw4j+70EOGM4CSfID9RNEXcSoyUopJrS
 IUGoHkCWRGGBV4nN06Zb4aul2NpTvdSXtr5nXnAd9econmWyyIOWUzsmT4KZ9NCQI1
 MKh2S+4er6xAogznNcJ+nTAxZsS2sFlrnwusrLx7CxWrlD9Mww/4FcOWoauiYKw4lp
 2NTKh+4XmNQTEORUXcmEkeRWEPOwLmFYMuZyEyeubh3o/bYRjmC8dshdeZq1cJtWZU
 4kQ/nJzvl1A2g==
Received: from authenticated-user (boxtwo.techtravels.org [54.196.37.146])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by boxtwo.techtravels.org (Postfix) with ESMTPSA id 88A523F195;
 Fri,  3 Jul 2026 16:49:05 -0400 (EDT)
Message-ID: <d8e25b48-5f01-478c-a22d-ccc18583b972@techtravels.org>
Date: Fri, 3 Jul 2026 16:49:05 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/4] hw/misc/lasi: derive IRR from pending and unmasked
 requests
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Maydell <peter.maydell@linaro.org>, BALATON Zoltan <balaton@eik.bme.hu>
References: <20260701213359.1855870-1-keith@techtravels.org>
 <20260701213359.1855870-2-keith@techtravels.org>
 <4bb3ec72-ba39-4846-ae7c-335121c16c41@gmx.de>
Content-Language: en-US
From: Keith Monahan <keith@techtravels.org>
In-Reply-To: <4bb3ec72-ba39-4846-ae7c-335121c16c41@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 1175899m:1175899aieqF3d:1175899sUUZLPzxzJ
X-smtpcorp-track: 44dQPvtCzCBH.tETuWCd5K7ZK.bqZciAlXno3
Received-SPF: pass client-ip=203.31.37.128;
 envelope-from=bounce.h5uv5rvsj5sc3l0=rmoi7tbbg9wh=gbt3t6dsw4bj9s@em1175899.techtravels.org;
 helo=a3i384.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Perfect, thanks for the help.

Keith


On 7/3/2026 10:00 AM, Helge Deller wrote:
> On 7/1/26 23:33, Keith Monahan wrote:
>> The LASI interrupt request register (IRR) was latched: set when a source
>> asserted and then never cleared or re-evaluated against the mask, so a
>> masked or dropped request stayed set forever. The parisc core I/O
>> dispatcher reads IRR to find its interrupt source, so the stuck bit was
>> returned on every later interrupt as an "unexpected core I/O interrupt".
>> On an installed HP-UX system an unacknowledged i82596 LAN interrupt
>> latched this way and the flood wedged the boot.
>>
>> Derive IRR as (pending & unmasked) with IPR tracking each source's level,
>> matching the hardware and the in-tree parisc gsc/lasi driver.
>>
>> Signed-off-by: Keith Monahan <keith@techtravels.org>
> 
> Reviewed-by: Helge Deller <deller@gmx.de>
> 
> Thanks Keith!
> I'll pick it up in my upcoming hppa git tree, so soon you don't need to 
> carry it
> extra. I hope this is OK?
> 
> Helge


