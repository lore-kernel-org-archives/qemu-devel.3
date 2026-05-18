Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DD3CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 09:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOuHr-0000KN-To; Mon, 18 May 2026 05:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wOuHl-0000Jm-6X; Mon, 18 May 2026 05:29:17 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wOuHj-0006JC-Go; Mon, 18 May 2026 05:29:16 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8FCBF44B48;
 Mon, 18 May 2026 11:29:04 +0200 (CEST)
Message-ID: <d915efb6-f9a9-491e-b17f-23334d943c02@proxmox.com>
Date: Mon, 18 May 2026 11:29:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/vl: Free allocate memory for pid file name in case
 realpath() failed
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20260515143854.2010741-1-thuth@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20260515143854.2010741-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1779096532019
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Am 15.05.26 um 4:39 PM schrieb Thomas Huth:
> From: Thomas Huth <thuth@redhat.com>
> 
> In case realpath() fails, the code returns early in the function
> qemu_maybe_daemonize(), without freeing the allocated memory. Add
> a g_free() here to fix it.
> 
> Fixes: dee2a4d4d2f ("vl: defuse PID file path resolve error")
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>

Thanks!

> ---
>  system/vl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/system/vl.c b/system/vl.c
> index d2f4044e5d8..7e2ed898240 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2670,6 +2670,7 @@ static void qemu_maybe_daemonize(const char *pid_file)
>                  warn_report("not removing PID file on exit: cannot resolve PID "
>                              "file path: %s: %s", pid_file, strerror(errno));
>              }
> +            g_free(pid_file_realpath);
>              return;
>          }
>  



