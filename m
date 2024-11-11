Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE837D2E9E2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 12:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tATGG-0003YL-VF; Mon, 11 Nov 2024 07:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1tATGE-0003Y7-8m
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 07:11:14 -0500
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1tATGB-0008WB-2H
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 07:11:13 -0500
Message-ID: <60535722-1a11-42f9-a678-d103e227942f@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1731327066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9cZD92O4krtxr5doClp88+85wf3bLQAVJgfIdfUyHZM=;
 b=lYSiz6E0HZHo/WRooRrPBcBwvAzGftJLP7xrSSPRFaJ+g4xy6kkl8TRKYNqsmXSsix6R+b
 iYeAx6jqRP0M/bR2ovZbwzn2hiORW0NcSNGNuZmR0rtddos6kEbsw/ercqCKFKOY6TO5Db
 hhdZ5thT3TVhmGQV7KC5f5t7/CkSSag=
Date: Mon, 11 Nov 2024 15:11:06 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] tests/qtest: fix heap-use-after-free
Content-Language: en-US
To: Prasad Pandit <ppandit@redhat.com>
Cc: farosas@suse.de, lvivier@redhat.com, sdl.qemu@linuxtesting.org,
 qemu-devel@nongnu.org
References: <20241111090534.66439-2-frolov@swemel.ru>
 <CAE8KmOw75c9Vja5dnGy50b2Dqp9wgfMfxRWjHDdqEUkLBUcP+A@mail.gmail.com>
From: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
In-Reply-To: <CAE8KmOw75c9Vja5dnGy50b2Dqp9wgfMfxRWjHDdqEUkLBUcP+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
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



On 11.11.2024 14:47, Prasad Pandit wrote:
> On Mon, 11 Nov 2024 at 14:37, Dmitry Frolov <frolov@swemel.ru> wrote:
>> "int main(int argc, char **argv, char** envp)" is non-standart
>> Microsoft`s extention of the C language and it`s not portable.
>> In my particular case (Debian 13, clang-16) this raises wild-pointer
>> dereference with ASAN message "heap-use-after-free".
> ...
>>           qos_printf("ENVIRONMENT VARIABLES: {\n");
>> -        for (char **env = envp; *env != 0; env++) {
>> +        for (char **env = environ; *env != 0; env++) {
>>               qos_printf("\t%s\n", *env);
>>           }
> * For heap-use-after-free, there needs to be a free(*env) call
> somewhere. In the 'tests/qtest/qos-test.c' file, I couldn't see
> environment variables being free'd anywhere. Above loop is only
> printing them.
Above loop dereferences the pointer env, which is pointing to
the memory area, which is not allowed to read.

>   Following small test.c did not reproduce the
> 'heap-use-after-free' error.
> ===
> #include <stdio.h>
> int
> main(int argc, char *argv[], char **envp)
> {
>      int n = 0;
>      for (char **p = envp; *p != 0; p++) {
>          printf("environ[%d]: %s\n", n++, *p);
>      }
>      return 0;
> }
> $ cc -xc -o test test.c -lasan
> ===
>
> * While the patch is okay, it is not clear why it fixes the
> wild-pointer dereference and "heap-use-after-free" errors.
>
> Thank you.
> ---
>    - Prasad
>
This example will work everywhere, where env pointer is
supported by OS/compiler/etc... Nevertheless, I am pointing on 2 facts:
1. "env" is Microsoft`s extension, not a standard
2. There is exact example, where standards violation raises
undefined behavior: debian13/clang16

