Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4BBC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 08:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVoLO-0007Si-WC; Mon, 22 Jul 2024 04:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@dram.page>) id 1sVoLL-0007Rg-TO
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 04:24:28 -0400
Received: from kuriko.dram.page ([65.108.252.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@dram.page>) id 1sVoLJ-0005QR-EX
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 04:24:27 -0400
Message-ID: <902417dd-2aa7-409a-b62d-7950e34c444a@dram.page>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dram.page; s=mail;
 t=1721636661; bh=NltPddG/kQPh+rP/tIkQxxIgi4gg9JyT9BNmfW2mGas=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Of9pY9raIaGMK0t40LLMzTg+DyOgZIVTjFAJf+jtpK+CvrtshK9W5wkdpeCLYeUwa
 RO/KhTqLhq2uFCdkia65ViBBD0fmI/FisLw9VwnqoVEMKZprLiWRNFXw3JjQ9LLuxT
 hTyvbr/mBN4x+TnySPZGOLllKlPPBawQyipYwR+Y=
Date: Mon, 22 Jul 2024 16:24:02 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] util/getauxval: Ensure setting errno if not found
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>
References: <20240721090817.120888-1-uwu@dram.page>
 <20240721090817.120888-2-uwu@dram.page>
 <OSZPR01MB6453807448D47F3EFA427C878DA82@OSZPR01MB6453.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Vivian Wang <uwu@dram.page>
Autocrypt: addr=uwu@dram.page; keydata=
 xjMEYCKGnBYJKwYBBAHaRw8BAQdAwFaJhAn7kfIDolkfKS0kHaovYtSrWdgPBvpf2Y4mMGXN
 G1ZpdmlhbiBXYW5nIDx1d3VAZHJhbS5wYWdlPsKTBBMWCgA7FiEE5m9lW8MCF4SCBOqVI586
 hxRi/RAFAmOj7bgCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQI586hxRi/RAa
 TwD+Msk9COeIk1OHprnzVSJpN1DQEbzy1v6ruze7EbFaHQAA/25EiTgJt74CEeh89LrZMdSg
 CuEMuuE0ZqXKt0Sda8kOzjgEYCKGzhIKKwYBBAGXVQEFAQEHQHWGHrayqlh2o4CIqwO7gcHb
 S2GCIg600hlKxwUkv/k/AwEIB8J4BBgWCAAgAhsMFiEE5m9lW8MCF4SCBOqVI586hxRi/RAF
 AmHRSJUACgkQI586hxRi/RDqdQEAieTWLWwmklDHF5sa9pLZ8fEXbxK9kGd4s6LEGWVj8ZAB
 AP++50uuPLCX+UbU15QVsfHdrXZQ+HAc+EgrnasvqQwM
In-Reply-To: <OSZPR01MB6453807448D47F3EFA427C878DA82@OSZPR01MB6453.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=65.108.252.55; envelope-from=uwu@dram.page;
 helo=kuriko.dram.page
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 7/22/24 08:18, Xingtao Yao (Fujitsu) wrote:
>
>> -----Original Message-----
>> From: qemu-devel-bounces+yaoxt.fnst=fujitsu.com@nongnu.org
>> <qemu-devel-bounces+yaoxt.fnst=fujitsu.com@nongnu.org> On Behalf Of Vivian
>> Wang
>> Sent: Sunday, July 21, 2024 5:08 PM
>> To: qemu-devel@nongnu.org
>> Cc: Vivian Wang <uwu@dram.page>; Richard Henderson <rth@twiddle.net>;
>> Laurent Vivier <laurent@vivier.eu>
>> Subject: [PATCH 1/2] util/getauxval: Ensure setting errno if not found
>>
>> Sometimes zero is a valid value for getauxval (e.g. AT_EXECFD). Make
>> sure that we can distinguish between a valid zero value and a not found
>> entry by setting errno.
>>
>> Ignore getauxval from sys/auxv.h on glibc < 2.19 because it does not set
>> errno.
>>
>> Signed-off-by: Vivian Wang <uwu@dram.page>
>> ---
>>  util/getauxval.c | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/util/getauxval.c b/util/getauxval.c
>> index b124107d61..f1008bdc59 100644
>> --- a/util/getauxval.c
>> +++ b/util/getauxval.c
>> @@ -24,7 +24,13 @@
>>
>>  #include "qemu/osdep.h"
>>
>> -#ifdef CONFIG_GETAUXVAL
>> +/* If glibc < 2.19, getauxval can't be used because it does not set errno if
>> +   entry is not found. */
>> +#if defined(CONFIG_GETAUXVAL) && \
>> +    (!defined(__GLIBC__) \
>> +        || __GLIBC__ > 2 \
>> +        || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 19))
> you can use GLIB_CHECK_VERSION(2, 19, 0) instead
That wouldn't work. I'm testing for glibc, not glib.
>> +
>>  /* Don't inline this in qemu/osdep.h, because pulling in <sys/auxv.h> for
>>     the system declaration of getauxval pulls in the system <elf.h>, which
>>     conflicts with qemu's version.  */
>> @@ -95,6 +101,7 @@ unsigned long qemu_getauxval(unsigned long type)
>>          }
>>      }
>>
>> +    errno = ENOENT;
>>      return 0;
>>  }
>>
>> @@ -104,7 +111,9 @@ unsigned long qemu_getauxval(unsigned long type)
>>  unsigned long qemu_getauxval(unsigned long type)
>>  {
>>      unsigned long aux = 0;
>> -    elf_aux_info(type, &aux, sizeof(aux));
>> +    int ret = elf_aux_info(type, &aux, sizeof(aux));
>> +    if (ret != 0)
>> +        errno = ret;
>>      return aux;
>>  }
>>
>> @@ -112,6 +121,7 @@ unsigned long qemu_getauxval(unsigned long type)
>>
>>  unsigned long qemu_getauxval(unsigned long type)
>>  {
>> +    errno = ENOSYS;
>>      return 0;
>>  }
>>
>> --
>> 2.45.1
>>


