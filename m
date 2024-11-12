Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45272D41D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 09:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAmzh-0002zK-UP; Tue, 12 Nov 2024 04:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1tAmze-0002yY-Gq
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 04:15:26 -0500
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1tAmzY-0008MF-Ra
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 04:15:24 -0500
Message-ID: <224ceb0c-7219-45de-88e2-1e51b47cfc58@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1731402914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rSyhYrTgcHl/rlFymfDVPw4GgjcUsRXUxuxoXJpizPw=;
 b=WHDKIDF1QMOuI2HGkxavetz7Kup/TYlRZpn8kiUun/TXJQ45la+YUBFMHHoWLDs0UZmOeC
 ZJEGxV6N9mDVyuTxlxgbmD4ZGGB8wEESFM7v3BcVHffhCOOI/58/lyarCUXycaz8c5DnzW
 UjUpyK/5vaDh6dDtoeF/X4lzv6pn/Hs=
Date: Tue, 12 Nov 2024 12:15:14 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] tests/qtest: fix non portable env varibles access
Content-Language: en-US
To: Prasad Pandit <ppandit@redhat.com>
Cc: farosas@suse.de, lvivier@redhat.com, sdl.qemu@linuxtesting.org,
 qemu-devel@nongnu.org
References: <20241112063703.116386-2-frolov@swemel.ru>
 <CAE8KmOwDuv7AR4pEGbq=ubEkrHbkQBn7cz2hJsSYx6YgH5Ubpg@mail.gmail.com>
From: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
In-Reply-To: <CAE8KmOwDuv7AR4pEGbq=ubEkrHbkQBn7cz2hJsSYx6YgH5Ubpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi, Prasad!

It looks like this is a clang optimization issue.
I`ve made a simple experiment:

When environ is mentioned somewhere in the source code -
everything is fine - test passed.
The value of envp is equal to environ and is always
0x514000000040 (reproducible).

When environ is absent (not mentioned in the source code)
The value of envp is also 0x514000000040 (reproducible),
but the behavior may be each time different.
Mostly test fails with error, with or without ASAN report.

Thus, it seems, that when environ variable is not used -
it`s being optimized, the corresponding memory is being
freed, but envp pointer still points to the freed memory.

Thanks a lot!

With best regards,
Dmitry.

On 12.11.2024 10:11, Prasad Pandit wrote:
> On Tue, 12 Nov 2024 at 12:08, Dmitry Frolov <frolov@swemel.ru> wrote:
>> "int main(int argc, char **argv, char** envp)" is non-standart
> standart -> standard
>
>> Microsoft`s extention of the C language and it`s not portable.
> * But it looks widely supported.
>
>> In my particular case (Debian 13, clang-16) this raises wild-pointer
>> dereference with ASAN message "heap-use-after-free".
>>
>> v2: changed confusing commit header
> * We need to include a pointer to the earlier version/discussion:
>    v1: -> https://lore.kernel.org/qemu-devel/23ef463e-744d-472c-bd25-30f68a97a8cf@swemel.ru/T/#t
>
> Thank you.
> ---
>    - Prasad
>


