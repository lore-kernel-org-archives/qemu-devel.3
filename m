Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B41CCAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 11:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v11Ig-0003rf-TR; Tue, 23 Sep 2025 07:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v11Id-0003oM-Q2
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 07:35:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v11IN-0007RQ-Ms
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 07:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758627275;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=N/gLDjQSe6wqcVnFbS717piCiLzlRsdLrRRvJfChbVo=;
 b=gP+nh2bwmF8Ha6igNB9HgBHucvyrv9K4yQ7ZmyEIAZUmBdRzcchyBC5i122t7kWdhhNCP2
 mPh1QTQ9SfDtlmxN1/dNI5psQy/1YbiegJEI/SnI3rS3SFRtD+dXvW/CCxCfEG0q346daC
 WU+s/WH17O7S8oMXUx9sXsePVovhnwU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-1S7x7IgnNTmzM709tNciKA-1; Tue,
 23 Sep 2025 07:34:30 -0400
X-MC-Unique: 1S7x7IgnNTmzM709tNciKA-1
X-Mimecast-MFC-AGG-ID: 1S7x7IgnNTmzM709tNciKA_1758627269
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96EA119560A7; Tue, 23 Sep 2025 11:34:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DA891800452; Tue, 23 Sep 2025 11:34:27 +0000 (UTC)
Date: Tue, 23 Sep 2025 12:34:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gal Horowitz <galush.horowitz@gmail.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Subject: Re: [PATCH] tap-win32: fix multiple tap support
Message-ID: <aNKFwDuH6jNglWUO@redhat.com>
References: <20250920-fix-win32-multiple-taps-v1-1-bee41dcc213d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250920-fix-win32-multiple-taps-v1-1-bee41dcc213d@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Sep 20, 2025 at 03:01:39PM +0300, Gal Horowitz wrote:
> Currently when more than one tap is created on Windows, QEMU immediately
> crashes with a null-deref since the code incorrectly uses a static global
> for the tap state.
> 
> Instead, this patch allocates a structure for each tap at startup.
> 
> Signed-off-by: Gal Horowitz <galush.horowitz@gmail.com>
> ---
>  net/tap-win32.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/net/tap-win32.c b/net/tap-win32.c
> index 38baf90e0b3f121f74eb32f1bff779c84ce03114..217a43cc2f5effdd92e1bf49466fe8d2cd0490e6 100644
> --- a/net/tap-win32.c
> +++ b/net/tap-win32.c
> @@ -114,8 +114,6 @@ typedef struct tap_win32_overlapped {
>      tun_buffer_t* output_queue_back;
>  } tap_win32_overlapped_t;
>  
> -static tap_win32_overlapped_t tap_overlapped;
> -
>  static tun_buffer_t* get_buffer_from_free_list(tap_win32_overlapped_t* const overlapped)
>  {
>      tun_buffer_t* buffer = NULL;
> @@ -605,6 +603,7 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
>      } version;
>      DWORD version_len;
>      DWORD idThread;
> +    tap_win32_overlapped_t *tap_overlapped = NULL;
>  
>      if (preferred_name != NULL) {
>          snprintf(name_buffer, sizeof(name_buffer), "%s", preferred_name);
> @@ -645,12 +644,14 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
>          return -1;
>      }
>  
> -    tap_win32_overlapped_init(&tap_overlapped, handle);
> +    tap_overlapped = g_new0(tap_win32_overlapped_t, 1);
> +
> +    tap_win32_overlapped_init(tap_overlapped, handle);

I'd suggest chaing tap_win32_overlapped_init to be
tap_win32_overlapped_new. Have it be responsible
for the g_new0 call and returning the allocate struct
instead of passing it in as a param. 

>  
> -    *phandle = &tap_overlapped;
> +    *phandle = tap_overlapped;

eg so this becomes

  *phandle = tap_win32_overlapped_new(handle);

>  
>      CreateThread(NULL, 0, tap_win32_thread_entry,
> -                 (LPVOID)&tap_overlapped, 0, &idThread);
> +                 (LPVOID)tap_overlapped, 0, &idThread);
>      return 0;
>  }
>  
> @@ -670,6 +671,9 @@ static void tap_cleanup(NetClientState *nc)
>      /* FIXME: need to kill thread and close file handle:
>         tap_win32_close(s);
>      */
> +
> +   g_free(s->handle);
> +   s->handle = NULL;

The tap_overlapped_t struct contains many HANDLE fields. If we just
free the struct, then those handles are all leaked. There are also
some allocated pointers. We'd hope they would all be released already
but who knows ?

This is a pre-existing problem as the current code did not attempt
to free anything, but with your changes the leak stands out more.

At the same time though, the FIXME comment points out a risk here.

The thread is still running and yet we're freeing the 's->handle'
that the thread has access to. So if we don't stop the thread, we
are at risk of a use-after-free.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


