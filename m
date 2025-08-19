Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC3DCA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 11:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoKJu-00007Y-Lm; Tue, 19 Aug 2025 07:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoKJn-00006d-Kc
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:15:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoKJc-0005vD-KG
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755602141;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wuVVDgyrl2VYsst49CyaXjogM+O92C56TSRsG8ke494=;
 b=iKy87gjWkQaHUTTvPTiDliGrqXwqu4vYz+0GMjPB8LjdGs7BieMcxT8J32Sl+D+3TuLHbo
 S2oGa2RVD3GewMssN8pnT+MRST2fV0WTHIPdiuBsi7Pe5ImHKE3MBcP3QmvC5ubELamBkt
 uCDL+rLcqxZzfwNRVZ+pyiqIHvNJRPE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-g9C30lk6M12XewaAwTPfdw-1; Tue,
 19 Aug 2025 07:15:39 -0400
X-MC-Unique: g9C30lk6M12XewaAwTPfdw-1
X-Mimecast-MFC-AGG-ID: g9C30lk6M12XewaAwTPfdw_1755602138
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 095531955D69; Tue, 19 Aug 2025 11:15:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.237])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2327F19A4CA6; Tue, 19 Aug 2025 11:15:35 +0000 (UTC)
Date: Tue, 19 Aug 2025 12:15:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH 07/12] ui/spice-core: Clean up error reporting
Message-ID: <aKRc1B-4wf_n2s14@redhat.com>
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-8-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250808080823.2638861-8-armbru@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 08, 2025 at 10:08:18AM +0200, Markus Armbruster wrote:
> watch_add() reports _open_osfhandle() failure with
> error_setg(&error_warn, ...).
> 
> I'm not familiar with Spice, so I can't say whether it will work after
> such a failure.  If it doesn't, then this should be an error.  If it
> does, then why bother the user with a warning that isn't actionable,
> and likely confusing?

If watch_add fails, spice is dead. Eventually the NULL returned from
watch_add will bubble up to the spice_server_init function which will
return non-zero and QEMU will do

        error_report("failed to initialize spice server");
        exit(1);

The warning in watch_add gives a better chance of understanding
what failed than this generic error_report() does.

> 
> Regardless of that, error_setg_win32(&error_warn, ...) is undesirable
> just like error_setg(&error_fatal, ...) and error_setg(&error_abort,
> ...) are.  Replace by warn_report().
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  ui/spice-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index 5992f9daec..97bdd171cd 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -132,7 +132,8 @@ static SpiceWatch *watch_add(int fd, int event_mask, SpiceWatchFunc func, void *
>  #ifdef WIN32
>      fd = _open_osfhandle(fd, _O_BINARY);
>      if (fd < 0) {
> -        error_setg_win32(&error_warn, WSAGetLastError(), "Couldn't associate a FD with the SOCKET");
> +        warn_report("Couldn't associate a FD with the SOCKET: %s"
> +                    g_win32_error_message(WSAGetLastError()));
>          return NULL;
>      }
>  #endif


> -- 
> 2.49.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


