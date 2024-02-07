Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913C4C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 19:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXnPB-0003sE-10; Wed, 07 Feb 2024 14:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rXnP8-0003s0-OQ
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 14:16:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rXnP7-00022u-66
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 14:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707333374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CxAAYFCbDi6BWT7ByTYlJlEPzP9id4bi6dyg1vwQL3U=;
 b=bxrsa4PlS6QdocYsJZIrMjWbA2Jld79xew2NbD9CJs1lBBfTpXUYyKrGOYmPgMSPBHuypO
 9AcAKSLg1UhZ5+rzrguq9DR/jEJu64TY4EdVAKFjmqHao+05cl+u/9ger5U5K21DLf4hX9
 yXZQh67wT21e0YQfU/zA2EFT7UNqLhk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-qE-otwCNOCSufyoXbm3Z3A-1; Wed,
 07 Feb 2024 14:16:02 -0500
X-MC-Unique: qE-otwCNOCSufyoXbm3Z3A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8939F28BBF01;
 Wed,  7 Feb 2024 19:16:02 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4928BAC1E;
 Wed,  7 Feb 2024 19:16:01 +0000 (UTC)
Date: Wed, 7 Feb 2024 13:15:59 -0600
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, 
 pbonzini@redhat.com, devel@lists.libvirt.org
Subject: Re: [PATCH 1/4] chardev/parallel: Don't close stdin on inappropriate
 device
Message-ID: <rnzorvci7ca55cisgobnwfkz6yvjh74nnxyhnr4nnozeszw5no@rqnyu73dg7wf>
References: <20240203080228.2766159-1-armbru@redhat.com>
 <20240203080228.2766159-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203080228.2766159-2-armbru@redhat.com>
User-Agent: NeoMutt/20231221
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

On Sat, Feb 03, 2024 at 09:02:25AM +0100, Markus Armbruster wrote:
> The __linux__ version of qemu_chr_open_pp_fd() tries to claim the
> parport device with a PPCLAIM ioctl().  On success, it stores the file
> descriptor in the chardev object, and returns success.  On failure, it
> closes the file descriptor, and returns failure.
> 
> chardev_new() then passes the Chardev to object_unref().  This duly
> calls char_parallel_finalize(), which closes the file descriptor
> stored in the chardev object.  Since qemu_chr_open_pp_fd() didn't
> store it, it's still zero, so this closes standard input.  Ooopsie.
> 
> To demonstate, add a unit test.  With the bug above unfixed, running
> this test closes standard input.  char_hotswap_test() happens to run
> next.  It opens a socket, duly gets file descriptor 0, and since it
> tests for success with > 0 instead of >= 0, it fails.

Two bugs for the price of one!

> 
> The test needs to be conditional exactly like the chardev it tests.
> Since the condition is rather complicated, steal the solution from the
> serial chardev: define HAVE_CHARDEV_PARALLEL in qemu/osdep.h.  This
> also permits simplifying chardev/meson.build a bit.
> 
> The bug fix is easy enough: store the file descriptor, and leave
> closing it to char_parallel_finalize().
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/include/qemu/osdep.h
> @@ -508,11 +508,18 @@ void qemu_anon_ram_free(void *ptr, size_t size);
>  
>  #ifdef _WIN32
>  #define HAVE_CHARDEV_SERIAL 1
> -#elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)    \
> +#define HAVE_CHARDEV_PARALLEL 1
> +#else
> +#if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)   \
>      || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFly__) \
>      || defined(__GLIBC__) || defined(__APPLE__)
>  #define HAVE_CHARDEV_SERIAL 1
>  #endif
> +#if defined(__linux__) || defined(__FreeBSD__) \
> +    || defined(__FreeBSD_kernel__) || defined(__DragonFly__)
> +#define HAVE_CHARDEV_PARALLEL 1
> +#endif
> +#endif

Not for this patch, but I've grown to like a preprocessor style I've
seen in other projects to make it easier to read nested #if:

#ifdef _WIN32
# define HAVE_CHARDEV_SERIAL 1
# define HAVE_CHARDEV_PARALLEL 1
#else
# if defined(__linux__) ... defined(__APPLE__)
#  define HAVE_CHARDEV_SERIAL 1
# endif
# if defined(__linux__) ... defined(__DragonFly__)
#  define HAVE_CHARDEV_PARALLEL 1
# endif
#endif

> +++ b/chardev/meson.build
> @@ -21,11 +21,9 @@ if host_os == 'windows'
>  else
>    chardev_ss.add(files(
>        'char-fd.c',
> +        'char-parallel.c',
>        'char-pty.c',

Indentation looks off.  Otherwise,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


