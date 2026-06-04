Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7458CD6E6D
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 06:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV1Qk-0000Je-1r; Thu, 04 Jun 2026 02:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>)
 id 1wV1Qf-0000Hw-Vh; Thu, 04 Jun 2026 02:19:45 -0400
Received: from msg-2.mailo.com ([213.182.54.12] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>)
 id 1wV1Qd-0007Kf-D9; Thu, 04 Jun 2026 02:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780553770; bh=GU/d5DtZ0imSx5OhDggY7Er7TuoxYvb43OdYwQGncbw=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=BTmI7B/U15HqGyKyokf37hdjuUp3+nIkCyoj2mptoi1vIMe8cQFNryiNnY8LTnBVC
 jn+cHnWKFMLzX2tQZ2Agu4wnwk3a52iJ6KBJW9q35s8ftXyw9OLlDeQH9nG0hU6MtH
 v9sucnbBLASN0jpaO9qi80wOtkPio6mwkWb1TrAg=
Received: by be1-8.in.mailobj.net [192.168.91.18] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Thu,  4 Jun 2026 08:15:29 +0200 (CEST)
X-EA-Auth: cThs8eykYyx5q8KYK8gRg+SeY624chqA3m3f271eKYBonuHhBxC5qsmSozuRd5C4PJkNVKHhi5hwcyuRWwLfZzuVBNAYk0Jz
Message-ID: <0c1e6301-e196-41cf-84f1-6c6cd33ec1a4@mailo.com>
Date: Thu, 4 Jun 2026 08:15:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] disas: sparc: Fix integer overflow in
 compare_opcodes() for loop
Content-Language: en-US
To: Christian Barry <christian.barry@usp.br>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-trivial@nongnu.org,
 Eduardo Augusto Cavalcanti <eduardoaugustoabc@ime.usp.br>
References: <20260603190446.10319-1-christian.barry@usp.br>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260603190446.10319-1-christian.barry@usp.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=213.182.54.12; envelope-from=philmd@mailo.com;
 helo=mailo.com
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

Hi Christian,

On 3/6/26 21:04, Christian Barry wrote:
> From: Christian Barry <christian.barry@usp.br>
> 
> Replaced left-shift of a literal 1 by i inside of two for loops in compare_opcodes() with 1ul type qualifier. This makes it so 1 is explicitly interpreted as an unsigned long int, preventing overflows.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2618
> 
> Signed-off-by: Christian Barry <christian.barry@usp.br>
> Co-developed-by: Eduardo Augusto Cavalcanti <eduardoaugustoabc@ime.usp.br>
> Signed-off-by: Eduardo Augusto Cavalcanti <eduardoaugustoabc@ime.usp.br>
> ---
>   disas/sparc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/disas/sparc.c b/disas/sparc.c
> index 5689533ce1..40c1164554 100644
> --- a/disas/sparc.c
> +++ b/disas/sparc.c
> @@ -2515,7 +2515,7 @@ compare_opcodes (const void * a, const void * b)
>        another, it is important to order the opcodes in the right order.  */
>     for (i = 0; i < 32; ++i)
>       {
> -      unsigned long int x = 1 << i;
> +      unsigned long int x = 1ul << i;
>         int x0 = (match0 & x) != 0;
>         int x1 = (match1 & x) != 0;

As Artyom suggested we should cherry-pick binutils commit 4383e1fc3b326.

Alternatively:

   if (match0 != match1) {
       return extract32(match1, clz32(match0 ^ match1), 1) ?: -1;
   }



