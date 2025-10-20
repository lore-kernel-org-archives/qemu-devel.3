Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF2ECCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 15:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArTl-0001cy-0L; Mon, 20 Oct 2025 11:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.anderson@linux.dev>)
 id 1vArTa-0001XQ-ML
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:07:11 -0400
Received: from out-181.mta0.migadu.com ([2001:41d0:1004:224b::b5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.anderson@linux.dev>)
 id 1vArTX-00077D-MI
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:07:10 -0400
Message-ID: <a8bd9ca0-3b65-4581-9ed9-b123aa38af52@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1760972821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ybE+BuGmmeUy8hJ2CkCWLW/fn7XSQ9a4rtkI4CI9MYM=;
 b=cVKfv6eUFdc42pSIWGgy2rzM6JOoFHdr2cMUmvzsur45Wmt9/m+uih5TakwlSWD2yq1cJT
 g11rn/YLcqpBqbABN9Qe0l3sZFy/8D58K7jQKKodqaaZnmVbS8CHyuSp9QTYB+g25ICGVs
 0eeUSA+kWPCZgWgQ0zEGayhFs23vruE=
Date: Mon, 20 Oct 2025 11:06:58 -0400
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] semihosting: Fix a few semihosting bugs
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Luc Michel <lmichel@kalray.eu>
References: <20251017213529.998267-1-sean.anderson@linux.dev>
 <871pmx8vk1.fsf@draig.linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <871pmx8vk1.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::b5;
 envelope-from=sean.anderson@linux.dev; helo=out-181.mta0.migadu.com
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

On 10/20/25 11:03, Alex Bennée wrote:
> Sean Anderson <sean.anderson@linux.dev> writes:
> 
>> While discussing [1], it came to my attention that QEMU does not
>> properly truncate/error SYS_FLEN on 32-bit systems.
> 
> TIL that semihostingfs was a thing!
> 
>> Fix this, and some
>> other bugs with GDB File I/O that I found while working on this series.
>> That said, GDB File I/O has been substantially broken for two years now,
>> so it makes me wonder if anyone actually uses it!
> 
> I suspect this is at the upper end of things to use semihosting for as
> its real purpose is to help bootstrap things on the barest of metal
> until you have enough bits going to selfhost. In QEMU land it is a
> convenient way to do host calls for test cases.
> 
> We don't have much actual testing of semihosting in the tree although I
> do run Peter's semihosting tests from time to time:
> 
>   https://git.linaro.org/people/peter.maydell/semihosting-tests.git/
> 
> the tests do include flen() but obviously don't cover the extreme
> filesize cases or overflow.
> 
>> It would certainly
>> simplify the implementation if we didn't have to support it.
> 
> While semihosting does have the concept of optional extensions SYS_FLEN
> is not one of them.

The above comments refer to GDB File I/O, which currently cannot open
files due to the problem fixed in patch 1/3. FLEN is not really broken
for most use-cases (as long as the user doesn't access large files).

--Sean

