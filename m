Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44356C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 08:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPd2Q-0004eG-Rf; Thu, 12 Jun 2025 04:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <floss@arusekk.pl>) id 1uPd2O-0004e2-1P
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 04:11:52 -0400
Received: from out-181.mta1.migadu.com ([2001:41d0:203:375::b5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <floss@arusekk.pl>) id 1uPd2L-0002K8-P4
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 04:11:51 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arusekk.pl; s=key1;
 t=1749715888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ActwR5oOxeyDC2GETCetICsQMFBTfms80j4LG8/GEmI=;
 b=L5jhgkCboE+o4pxLgR6oMOUaswfVxqUsFrtF8pAlGyqsvh8cZn6lMSvr1qfP1Mu8Eld7Tk
 sW/LKC9zan8KKp6vkTdflTi14Jv9/OUxvRbNDSXiuIPffg9lXVOOpbTb70oF0H6JhJms79
 GGmRQXVJtor7/Tqg0QbNA2rrOfB/PsIS5xKjjnLVPGjjNxpewt9K0sWvG3m+0Q6Lbq5fTJ
 WvHnACOBanFyFyjzX4sCDULxue5U2BpeyitYDG3wTAPo7Y7TYToWJvj0mZlldtWjZ+tIJ+
 HWnB7NMY7e7Z+wNHNb4ULYp4JqlzT8HlWzc3P8jLkDpN0Nc6E58p1zyJv6hQlg==
From: Arusekk <floss@arusekk.pl>
To: Daniel =?UTF-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v2] linux-user: fix resource leaks in gen-vdso
Date: Thu, 12 Jun 2025 10:12:29 +0200
Message-ID: <10691455.nUPlyArG6x@swift>
In-Reply-To: <20250513150346.1328217-1-berrange@redhat.com>
References: <20250513150346.1328217-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::b5;
 envelope-from=floss@arusekk.pl; helo=out-181.mta1.migadu.com
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

Tested-by: Arusekk <floss@arusekk.pl>

Thanks for the patch. I am just a drive-by contributor, not someone
experienced in qemu development, so take my feedback with a grain of salt.

> There are a number of resource leaks in gen-vdso. In theory they are
> harmless because this is a short lived process, but when building QEMU
> with --extra-cflags="-fsanitize=address" problems ensure. The gen-vdso
> program is run as part of the build, and that aborts due to the
> sanitizer identifying memory leaks, leaving QEMU unbuildable.

I have not encountered it personally before.
However, I can confirm that qemu fails to build using

./configure --target-list=x86_64-linux-user --extra-cflags=-fsanitize=address && make

on current master, and that the patch fixes it.

I use gcc (Gentoo Hardened 15.1.0 p1) 15.1.0 libasan.so.8.
Curiously, the leak does not happen e.g. for arm-linux-user target.

> This complaint is about the 'buf' variable, however, the FILE objects
> are also leaked in some error scenarios, so this fix refactors the
> cleanup paths to fix all leaks. For completeness it also reports an
> error if fclose() fails on 'inf'.

How about other error cases?

> diff --git a/linux-user/gen-vdso.c b/linux-user/gen-vdso.c
> index 721f38d5a3..fce9d5cbc3 100644
> --- a/linux-user/gen-vdso.c
> +++ b/linux-user/gen-vdso.c
> @@ -129,7 +130,6 @@ int main(int argc, char **argv)
>          fprintf(stderr, "%s: incomplete read\n", inf_name);
>          return EXIT_FAILURE;

Like this one. Are other places like here possible candidates to also goto cleanup?

- Arusekk <https://arusekk.pl>



