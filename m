Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E72C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 12:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUnfG-0000Q4-1l; Tue, 30 Jan 2024 07:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rUnfD-0000Pq-J8
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 07:56:31 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rUnfB-00069U-PJ
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 07:56:31 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9B9B24E6006;
 Tue, 30 Jan 2024 13:56:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id SCRoa4W0JVYf; Tue, 30 Jan 2024 13:56:22 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A62AB4E6012; Tue, 30 Jan 2024 13:56:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A3B0B7456B4;
 Tue, 30 Jan 2024 13:56:22 +0100 (CET)
Date: Tue, 30 Jan 2024 13:56:22 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Richard Henderson <richard.henderson@linaro.org>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 16/22] target/split: Split ver from env->fsr
In-Reply-To: <fd01306a-4c81-4f49-8dc4-74080330653d@linaro.org>
Message-ID: <1a11fca4-4164-3431-f193-efe1fa2cf3f4@eik.bme.hu>
References: <20231103173841.33651-1-richard.henderson@linaro.org>
 <20231103173841.33651-17-richard.henderson@linaro.org>
 <fd01306a-4c81-4f49-8dc4-74080330653d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-566268640-1706619382=:2883"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-566268640-1706619382=:2883
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 30 Jan 2024, Philippe Mathieu-Daudé wrote:
> On 3/11/23 18:38, Richard Henderson wrote:
>> This field is read-only.  It is easier to store it separately
>> and merge it only upon read.
>> 
>> While we're at it, use FSR_VER_SHIFT to initialize fpu_version.
>> 
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/sparc/cpu.h        |  3 +++
>>   target/sparc/cpu.c        | 27 +++++++++++++--------------
>>   target/sparc/fop_helper.c |  9 +++++++--
>>   3 files changed, 23 insertions(+), 16 deletions(-)
>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Typo in subject: should be target/sparc not target/split.

Regards,
BALATON Zoltan
--3866299591-566268640-1706619382=:2883--

