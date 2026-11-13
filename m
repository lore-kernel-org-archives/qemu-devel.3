Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD78606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 02:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=comstyle.com header.i=@comstyle.com header.a=rsa-sha256 header.s=default header.b=gPrGbnzL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRgxR-0005f9-6V; Thu, 12 Nov 2026 21:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1xRgxL-0005bu-RM
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 21:24:03 -0500
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1xRgxJ-0007uN-Ge
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 21:23:58 -0500
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4jQgzn0MCmz8PbP;
 Thu, 12 Nov 2026 21:23:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
 message-id:date:mime-version:subject:from:to:cc:references
 :in-reply-to:content-type:content-transfer-encoding; s=default;
 bh=vT1NCoWxmTOnVcqEydR1kUPIPCzBblxPJOyxJu73YOo=; b=gPrGbnzLtFSk
 +m8nNipCKPo3CAbPpLyUtr2QEgOq9siv/C5/SM8RQ7P0a3MlhDXnYNCAQoYLyzH5
 Na8dCaunAN+mAmOnfJaOobF60x99yKgMX6vvyR8/xoVWefZgF5ssUtIoeUY57M05
 HzPc0hBF5rXHekBQbjfm0AtpKSsQWuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
 :date:mime-version:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding; q=dns; s=default; b=qAg
 SubraSUfxFX7vfpd+ne442JhspAEEdlZwXLnbGU3nYFqf29lAskBTf39k3md8M47
 sScsjtozKoqV3oSCmbwjbGsbCQQWd2vx0ZPNDeb7hgTExY0GmcnnXVB6Zb8C/9Wl
 jJOtbPp+7RMTnnedfaCCHdDzaMaT4Z9zLublmavE=
Received: from [192.168.6.99] (66-49-215-17.cpe.distributel.net [66.49.215.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4jQgzm6qmpz8PbN;
 Thu, 12 Nov 2026 21:23:48 -0500 (EST)
Message-ID: <9fc861c3-aa4f-45ea-a795-308667c43ce1@comstyle.com>
Date: Thu, 12 Nov 2026 21:23:47 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qga: fix uname() return value check in guest-get-osinfo
From: Brad Smith <brad@comstyle.com>
To: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org
References: <auUjFweAHtj1YSFt@humpty.home.comstyle.com>
Content-Language: en-US
In-Reply-To: <auUjFweAHtj1YSFt@humpty.home.comstyle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-30 7:07 p.m., Brad Smith wrote:
> qga: fix uname() return value check in guest-get-osinfo
>
> POSIX only specifies that uname() returns a non-negative value on
> success. Solaris returns 1, so guest-get-osinfo treated every
> successful call as a failure and reported a stale errno.
>
> Check for a negative return value instead, as linux-user/uname.c
> already does.

ping. It would be good to get this into 11.2.

> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>   qga/commands-posix.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index dcc683f6c9..23abaf1956 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1322,7 +1322,7 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
>   
>       info = g_new0(GuestOSInfo, 1);
>   
> -    if (uname(&kinfo) != 0) {
> +    if (uname(&kinfo) < 0) {
>           error_setg_errno(errp, errno, "uname failed");
>       } else {
>           info->kernel_version = g_strdup(kinfo.version);

