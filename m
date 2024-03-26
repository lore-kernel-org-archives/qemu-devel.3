Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D32DC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 14:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp7sf-0001pF-V0; Tue, 26 Mar 2024 10:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rp7sb-0001oh-Ou
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 10:34:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rp7sa-00020k-D2
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 10:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711463659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F/s+fhABIK5o9YU8orgSDLPKUADZ16JiHLtsdg+3UGQ=;
 b=Lqpe7PPDvOXYUWcTp6GCfJOrzzmw/GUjbbouhWe649+EAoaXp/XiInN97KhMyRSZIPm8zw
 OWryQVLK6uhh2+dVx5zIEzhDZFzx9ZQd0Oc9iqO5Nro7dlvYBTNTuG3ZLxwX9SM7XIBeYU
 b+M/Gb9JtZF4DGhVF35/0MfZ9goJndg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-4uVnvcKQN3-OppV3aeJ1Jw-1; Tue, 26 Mar 2024 10:34:15 -0400
X-MC-Unique: 4uVnvcKQN3-OppV3aeJ1Jw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25C26185A78E;
 Tue, 26 Mar 2024 14:34:15 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD5D3492BD0;
 Tue, 26 Mar 2024 14:34:10 +0000 (UTC)
Date: Tue, 26 Mar 2024 09:34:05 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 gmaglione@redhat.com, Eduardo Habkost <eduardo@habkost.net>, 
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com,
 Coiby Xu <Coiby.Xu@gmail.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 slp@redhat.com, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Brad Smith <brad@comstyle.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH for-9.1 v2 02/11] libvhost-user: fail vu_message_write()
 if sendmsg() is failing
Message-ID: <ubrm3znnvrpwoiwoekvztbcga2r37folr6cjjcasfaarc2pwek@pz66newnog3a>
References: <20240326133936.125332-1-sgarzare@redhat.com>
 <20240326133936.125332-3-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326133936.125332-3-sgarzare@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Mar 26, 2024 at 02:39:27PM +0100, Stefano Garzarella wrote:
> In vu_message_write() we use sendmsg() to send the message header,
> then a write() to send the payload.
> 
> If sendmsg() fails we should avoid sending the payload, since we
> were unable to send the header.
> 
> Discovered before fixing the issue with the previous patch, where
> sendmsg() failed on macOS due to wrong parameters, but the frontend
> still sent the payload which the backend incorrectly interpreted
> as a wrong header.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  subprojects/libvhost-user/libvhost-user.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
> index 22bea0c775..a11afd1960 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -639,6 +639,11 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
>          rc = sendmsg(conn_fd, &msg, 0);
>      } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
>  
> +    if (rc <= 0) {

Is rejecting a 0 return value correct?  Technically, a 0 return means
a successful write of 0 bytes - but then again, it is unwise to
attempt to send an fd or other auxilliary ddata without at least one
regular byte, so we should not be attempting a write of 0 bytes.  So I
guess this one is okay, although I might have used < instead of <=.

> +        vu_panic(dev, "Error while writing: %s", strerror(errno));
> +        return false;
> +    }

At any rate, noticing the error is the correct thing to do.

> +
>      if (vmsg->size) {
>          do {
>              if (vmsg->data) {
> -- 
> 2.44.0
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


