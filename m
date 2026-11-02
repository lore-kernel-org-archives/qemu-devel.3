Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EB9606A32D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BlmZLIve
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNozW-0006Gy-2u; Mon, 02 Nov 2026 05:10:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNozB-00066t-1G
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:09:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNoz9-00052W-6l
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793614190;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7b4zoVhhd+PbOlXill++R8Kio9FKMW32vNXdzzuLb2A=;
 b=BlmZLIve8Xduswp6JTg5xTRu2hVPpLIpNM2Qzod/hTUHgWj40Nc1La47BxVxoFuPiJin5n
 hdfAh2zIIjPotNvSc+bCNdFIlpLyunh3lcm5imq/SoYkgGjL1P4No88o45/abUfSgy2p9V
 2CJIau4PHTnxPuhPaZelIYCR6dqubrI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-mTUx0tQpMAaMzEqEziHUEw-1; Mon,
 02 Nov 2026 05:09:45 -0500
X-MC-Unique: mTUx0tQpMAaMzEqEziHUEw-1
X-Mimecast-MFC-AGG-ID: mTUx0tQpMAaMzEqEziHUEw_1793614185
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5D12195DE34
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2026 10:09:44 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF59E1800345; Mon,  2 Nov 2026 10:09:43 +0000 (UTC)
Date: Mon, 2 Nov 2026 10:09:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] RFC: chardev: disconnect backend when frontend closes
Message-ID: <auhhZP8151vP_wSt@redhat.com>
References: <20261001103412.2162829-1-marcandre.lureau@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261001103412.2162829-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 01, 2026 at 02:34:12PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> When the guest closes a virtio-serial channel, QEMU notifies some
> backends (spice, dbus) via their chr_set_fe_open handlers. Backends
> without such a handler, like socket, keep the connection open even
> though the frontend is no longer active. This is problematic for
> stateful protocols, as the peer has no way to know the channel was
> reset and must handle re-synchronization on its own. Disconnecting
> gives the peer a clean signal to reset its state.

Do you have a real world example of where this was causing a
problem ?

> Add a base-class chr_set_fe_open handler that calls chr_disconnect
> when the frontend signals close. Subclasses that already override
> chr_set_fe_open are unaffected. For the socket backend, this tears
> down the connection and allows reconnection when combined with the
> reconnect option.
> 
> Note: this is a behavior change that may break existing setups that
> rely on the connection staying up across frontend close/reopen cycles.

IIUC, libvirt expects the agent TCP socket to remain open for
the lifetime of the QEMU process & any premature closure of that
socket would be considered a bug.

> It may be preferable to make this opt-in via a chardev property rather
> than changing the default.

If we want this feature, making it opt-in looks unavoidable.

> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/chardev/char.c b/chardev/char.c
> index 7daf87f0363e..58c69db7340e 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -331,12 +331,22 @@ static int null_chr_write(Chardev *chr, const uint8_t *buf, int len)
>      return len;
>  }
>  
> +static void chr_set_fe_open(Chardev *chr, int fe_open)
> +{
> +    ChardevClass *cc = CHARDEV_GET_CLASS(chr);
> +
> +    if (!fe_open && cc->chr_disconnect) {
> +        cc->chr_disconnect(chr);
> +    }
> +}
> +
>  static void char_class_init(ObjectClass *oc, const void *data)
>  {
>      ChardevClass *cc = CHARDEV_CLASS(oc);
>  
>      cc->chr_write = null_chr_write;
>      cc->chr_be_event = chr_be_event;
> +    cc->chr_set_fe_open = chr_set_fe_open;
>  }
>  
>  static void char_finalize(Object *obj)
> -- 
> 2.56.0.rc0.29.g47ce80527c56
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


