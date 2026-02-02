Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8644EE73156
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 11:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vms4l-0007zk-Dy; Mon, 02 Feb 2026 06:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vms4j-0007z5-K7
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 06:26:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vms4i-0003uA-0q
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 06:26:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770031593;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7XeXP9xjtbyMRKA0oW8Swmk/z4g3pkesjAoW3FA2fOM=;
 b=N+otIa9N3W87W6k2aTexE1QcOU5of47Yrk2pHi/SU4zhQVKPaoYeiTmzQDqYUHuOqBVWza
 42SFMn30UEefifbTY/b/Rvfyg+NnB+D9ELH2f5umBf5+4pGBYJKLus/tQ3sufHEATTYS62
 /c5dnkFSlkh4e4h0Wz0G1lmAsVhhhNM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-y_MveZwtMG2edo1jUGPx5g-1; Mon,
 02 Feb 2026 06:26:30 -0500
X-MC-Unique: y_MveZwtMG2edo1jUGPx5g-1
X-Mimecast-MFC-AGG-ID: y_MveZwtMG2edo1jUGPx5g_1770031589
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFDAC180034A; Mon,  2 Feb 2026 11:26:28 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.68])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4ABE430001A7; Mon,  2 Feb 2026 11:26:24 +0000 (UTC)
Date: Mon, 2 Feb 2026 11:26:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, qemu-devel@nongnu.org, philmd@linaro.org
Subject: Re: [PATCH v3 1/3] char: qemu_chr_write_log() use qemu_write_full()
Message-ID: <aYCJ3Mu9XJYnl1-r@redhat.com>
References: <20260201173633.413934-1-vsementsov@yandex-team.ru>
 <20260201173633.413934-2-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260201173633.413934-2-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Feb 01, 2026 at 08:36:29PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> logfd is blocking, so we don't need to care about EAGAIN.
> Let's simply use qemu_write_full().

Are you sure logfd is always blocking ?  It can be an FD passed in
from outside QEMU, and off-hand, I'm not sure where we force that to
be blocking. Though we could argue it is the client't fault if they
passed a non-blocking FD to QEMU.

NB, we can *not* assume logfd is a plain file as libvirt will pass
in a pipe to send logging via virtlogd.


> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  chardev/char.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/chardev/char.c b/chardev/char.c
> index 3e432195a5..64006a3119 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -82,29 +82,17 @@ void qemu_chr_be_event(Chardev *s, QEMUChrEvent event)
>      CHARDEV_GET_CLASS(s)->chr_be_event(s, event);
>  }
>  
> -/* Not reporting errors from writing to logfile, as logs are
> - * defined to be "best effort" only */
>  static void qemu_chr_write_log(Chardev *s, const uint8_t *buf, size_t len)
>  {
> -    size_t done = 0;
> -    ssize_t ret;
> -
>      if (s->logfd < 0) {
>          return;
>      }
>  
> -    while (done < len) {
> -    retry:
> -        ret = write(s->logfd, buf + done, len - done);
> -        if (ret == -1 && errno == EAGAIN) {
> -            g_usleep(100);
> -            goto retry;
> -        }
> -
> -        if (ret <= 0) {
> -            return;
> -        }
> -        done += ret;
> +    if (qemu_write_full(s->logfd, buf, len) < len) {
> +        /*
> +         * qemu_write_full() is defined with G_GNUC_WARN_UNUSED_RESULT,
> +         * but logging is best‑effort, we do ignore errors.
> +         */
>      }
>  }
>  
> -- 
> 2.52.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


