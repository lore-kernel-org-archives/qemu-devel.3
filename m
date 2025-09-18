Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C83CAC5A0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 12:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzDh0-0002Ff-DG; Thu, 18 Sep 2025 08:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uzDgx-0002FP-VS
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 08:24:51 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uzDgv-000096-Tg
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 08:24:51 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58ICOlAR017224
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 18 Sep 2025 21:24:47 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=8vM+qPsPDY9EV6lekOoGT+SX1WMJ+LlOnHSpxVsF7fE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1758198287; v=1;
 b=FEk4SsKTGUBF9AfR5GCc1zu49Zvvk1QXqO4Oy2ByxfjJOIrKSsxKvEM1/Pfjxfay
 M/n3onHvkzm3TupnSJi3rqc+GU9hrj6ss4/PzFVc3JN6y7PnrXGNYJqo6C3BFCnn
 2QsrTMgLXtGLqMch/4wKy1ho1nzpfQhQiObvuY0MnuWqNkh3vHETfteFVuSiwEDf
 rdIBnyoOA5GeNtbbt2ZO/akUwFaJzD9T4sPBufKsFatSmUnxjF6wdXpCOCIeRYHf
 YYvXDsa6nYV4HmyfzYENWiuB6DLfchNlbQuZQTYShqOUOvEE8SCgV6sxgCcdQi6v
 sgk83U+jnGdUFrK/LXCCGw==
Message-ID: <f491b966-4702-4719-a4e3-4f12255eb75a@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 18 Sep 2025 21:24:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] net/slirp: Clean up error reporting
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, berrange@redhat.com
References: <20250917115207.1730186-1-armbru@redhat.com>
 <20250917115207.1730186-7-armbru@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250917115207.1730186-7-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/09/17 20:52, Markus Armbruster wrote:
> net_slirp_register_poll_sock() and net_slirp_unregister_poll_sock()
> report WSAEventSelect() failure with error_setg(&error_warn, ...).
> error_setg_win32(&error_warn, ...) is undesirable just like
> error_setg(&error_fatal, ...) and error_setg(&error_abort, ...)  are.
> Replace by warn_report().
> 
> The failures should probably be errors, but these functions implement
> callbacks that cannot fail, exit(1) would be too harsh, and silent
> failure we don't want.  Thus, warnings.
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   net/slirp.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/slirp.c b/net/slirp.c
> index 9657e86a84..62f2684609 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -262,7 +262,8 @@ static void net_slirp_register_poll_sock(slirp_os_socket fd, void *opaque)
>       if (WSAEventSelect(fd, event_notifier_get_handle(&ctxt->notifier),
>                          FD_READ | FD_ACCEPT | FD_CLOSE |
>                          FD_CONNECT | FD_WRITE | FD_OOB) != 0) {
> -        error_setg_win32(&error_warn, WSAGetLastError(), "failed to WSAEventSelect()");
> +        warn_report("failed to WSAEventSelect(): %s",
> +                    g_win32_error_message(WSAGetLastError()));

https://docs.gtk.org/glib-win32/func.error_message.html says:
 > The caller of the function takes ownership of the data, and is
 > responsible for freeing it.

>       }
>   #endif
>   }
> @@ -271,7 +272,8 @@ static void net_slirp_unregister_poll_sock(slirp_os_socket fd, void *opaque)
>   {
>   #ifdef WIN32
>       if (WSAEventSelect(fd, NULL, 0) != 0) {
> -        error_setg_win32(&error_warn, WSAGetLastError(), "failed to WSAEventSelect()");
> +        warn_report("failed to WSAEventSelect(): %s",
> +                    g_win32_error_message(WSAGetLastError()));
>       }
>   #endif
>   }


