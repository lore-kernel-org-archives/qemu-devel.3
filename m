Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D47C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 06:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXyH2-0008PK-K3; Thu, 08 Feb 2024 01:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rXyH0-0008PA-Ub
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 01:52:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rXyGz-0007Q1-G0
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 01:52:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707375156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U4j0Yo/S+UGnR49HPn26njfZnakO8o37bfYrF03ptiI=;
 b=ikGWFZy0J1kcOo0sW+3Iq1lcBzWkhUWM9lvgJIH/ebIa0rqcVFezK9k7UScNp4DBJyOAJ2
 JSgx7e75GK2mpn+q+r/fXME/IEKMRM6iVJxy7jI/0LnajtK1u8IpKA3GXUG5J/iq2mtrnr
 vW0ZotJiRPVLhKVM608QJYOPgPJ0pXY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-PRmB0F_xMJGJRbSHOdK-3Q-1; Thu,
 08 Feb 2024 01:52:35 -0500
X-MC-Unique: PRmB0F_xMJGJRbSHOdK-3Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 089931C07F37;
 Thu,  8 Feb 2024 06:52:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC59740D1B61;
 Thu,  8 Feb 2024 06:52:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D9CF121E6767; Thu,  8 Feb 2024 07:52:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com,  pbonzini@redhat.com, devel@lists.libvirt.org
Subject: Re: [PATCH 1/4] chardev/parallel: Don't close stdin on
 inappropriate device
In-Reply-To: <rnzorvci7ca55cisgobnwfkz6yvjh74nnxyhnr4nnozeszw5no@rqnyu73dg7wf>
 (Eric Blake's message of "Wed, 7 Feb 2024 13:15:59 -0600")
References: <20240203080228.2766159-1-armbru@redhat.com>
 <20240203080228.2766159-2-armbru@redhat.com>
 <rnzorvci7ca55cisgobnwfkz6yvjh74nnxyhnr4nnozeszw5no@rqnyu73dg7wf>
Date: Thu, 08 Feb 2024 07:52:33 +0100
Message-ID: <875xyzjvm6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Eric Blake <eblake@redhat.com> writes:

> On Sat, Feb 03, 2024 at 09:02:25AM +0100, Markus Armbruster wrote:
>> The __linux__ version of qemu_chr_open_pp_fd() tries to claim the
>> parport device with a PPCLAIM ioctl().  On success, it stores the file
>> descriptor in the chardev object, and returns success.  On failure, it
>> closes the file descriptor, and returns failure.
>> 
>> chardev_new() then passes the Chardev to object_unref().  This duly
>> calls char_parallel_finalize(), which closes the file descriptor
>> stored in the chardev object.  Since qemu_chr_open_pp_fd() didn't
>> store it, it's still zero, so this closes standard input.  Ooopsie.
>> 
>> To demonstate, add a unit test.  With the bug above unfixed, running
>> this test closes standard input.  char_hotswap_test() happens to run
>> next.  It opens a socket, duly gets file descriptor 0, and since it
>> tests for success with > 0 instead of >= 0, it fails.
>
> Two bugs for the price of one!
>
>> 
>> The test needs to be conditional exactly like the chardev it tests.
>> Since the condition is rather complicated, steal the solution from the
>> serial chardev: define HAVE_CHARDEV_PARALLEL in qemu/osdep.h.  This
>> also permits simplifying chardev/meson.build a bit.
>> 
>> The bug fix is easy enough: store the file descriptor, and leave
>> closing it to char_parallel_finalize().
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +++ b/include/qemu/osdep.h
>> @@ -508,11 +508,18 @@ void qemu_anon_ram_free(void *ptr, size_t size);
>>  
>>  #ifdef _WIN32
>>  #define HAVE_CHARDEV_SERIAL 1
>> -#elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)    \
>> +#define HAVE_CHARDEV_PARALLEL 1
>> +#else
>> +#if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)   \
>>      || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFly__) \
>>      || defined(__GLIBC__) || defined(__APPLE__)
>>  #define HAVE_CHARDEV_SERIAL 1
>>  #endif
>> +#if defined(__linux__) || defined(__FreeBSD__) \
>> +    || defined(__FreeBSD_kernel__) || defined(__DragonFly__)
>> +#define HAVE_CHARDEV_PARALLEL 1
>> +#endif
>> +#endif
>
> Not for this patch, but I've grown to like a preprocessor style I've
> seen in other projects to make it easier to read nested #if:
>
> #ifdef _WIN32
> # define HAVE_CHARDEV_SERIAL 1
> # define HAVE_CHARDEV_PARALLEL 1
> #else
> # if defined(__linux__) ... defined(__APPLE__)
> #  define HAVE_CHARDEV_SERIAL 1
> # endif
> # if defined(__linux__) ... defined(__DragonFly__)
> #  define HAVE_CHARDEV_PARALLEL 1
> # endif
> #endif

I like this style, too.

>> +++ b/chardev/meson.build
>> @@ -21,11 +21,9 @@ if host_os == 'windows'
>>  else
>>    chardev_ss.add(files(
>>        'char-fd.c',
>> +        'char-parallel.c',
>>        'char-pty.c',
>
> Indentation looks off.  Otherwise,

Will fix.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


