Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E345FF8864
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 00:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHVxf-0006Gr-E1; Mon, 27 Apr 2026 20:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenwei.pi@linux.dev>)
 id 1wHVxd-0006GU-Hm
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 20:05:57 -0400
Received: from out-181.mta0.migadu.com ([2001:41d0:1004:224b::b5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenwei.pi@linux.dev>)
 id 1wHVxb-0001BX-7m
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 20:05:57 -0400
Message-ID: <b02ca6f0-619f-47c6-8578-21f8b6070a6f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1777334739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P7WQhkzQJOrWeev/cPEXm7+vLufk9ScMPC18T7PlSjg=;
 b=N8TuQwanG8KZntvBbetua5h1MMcJvdotJsMQvmI8jHFA5PMgjS2fyD20Rs6fJ3C9VQqmTk
 FPHTzNnHd45X2k/nc8RGyDBrklxGiHWX2oz8tBbxw+H1zOrdSJcGsQye0AMiNhEZ5u77W4
 Pc29TJlWHCUtLA4s5eS8OXp6deddm8A=
Date: Tue, 28 Apr 2026 08:05:32 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 10/41] backends/cryptodev-lkcf: skip cleanup when not
 initialized
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com, "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-10-c413f3605311@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: zhenwei pi <zhenwei.pi@linux.dev>
In-Reply-To: <20260427-qom-tests-v1-10-c413f3605311@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::b5;
 envelope-from=zhenwei.pi@linux.dev; helo=out-181.mta0.migadu.com
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



On 4/28/26 03:42, Marc-André Lureau wrote:
> cryptodev_lkcf_cleanup() locks a mutex that is only initialized
> during the init vfunc (called at realize time). When the backend
> is destroyed without ever being realized, the mutex is uninitialized
> and the lock aborts.
> 
> Return early from cleanup when the backend was never started.
> 
> Note: it looks like cryptodev init/cleanup callbacks should rather be
> regular complete/finalize overrides (calling the parent method).
> 
> Fixes: 39fff6f3e8b3 ("cryptodev: Add a lkcf-backend for cryptodev")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   backends/cryptodev-lkcf.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
> index 40c7bd3c5a0..74db03fe96b 100644
> --- a/backends/cryptodev-lkcf.c
> +++ b/backends/cryptodev-lkcf.c
> @@ -255,6 +255,10 @@ static void cryptodev_lkcf_cleanup(CryptoDevBackend *backend, Error **errp)
>       CryptoDevBackendClient *cc;
>       CryptoDevLKCFTask *task, *next;
>   
> +    if (!lkcf->running) {
> +        return;
> +    }
> +
>       qemu_mutex_lock(&lkcf->mutex);
>       lkcf->running = false;
>       qemu_mutex_unlock(&lkcf->mutex);
> 

'lkcf->running' is used for synchronization between main thread and LKCF 
works, 'backend->ready' indicates the status of cryptodev, so I prefer 
the following code instead:

if (!cryptodev_backend_is_ready(backend)) {
     return;
}

