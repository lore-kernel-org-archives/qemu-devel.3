Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A0BD24456
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 17:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRDZx-0003Kf-Aw; Thu, 04 Dec 2025 12:57:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vRDZu-0003KL-BJ
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 12:57:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vRDZs-0002mo-EM
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 12:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764871032;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=M33hDVoEcqpJCtAJujtaLh7X29XF33KXb9MpIs+ekhE=;
 b=DrDNnIizU8XSqbqS/zWaEm+errMjFk19gkQOarIRKRERF7kMj1t+A57J5rUeQEUVDbs1Bo
 xB8+Y0t0HcuD6Fz6kbK5vt1fUjJSS+EnrnKhHPgAu668ujbUFkeg2wzAvkuTmhePpIOHrK
 ZIOn+v1GHQD1FtX3Y4lfFUfvvnBkr5o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-2f7-vl2QOBGQYrRuSXuk_A-1; Thu,
 04 Dec 2025 12:57:10 -0500
X-MC-Unique: 2f7-vl2QOBGQYrRuSXuk_A-1
X-Mimecast-MFC-AGG-ID: 2f7-vl2QOBGQYrRuSXuk_A_1764871028
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D486118002F5; Thu,  4 Dec 2025 17:57:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37BE019560B4; Thu,  4 Dec 2025 17:57:00 +0000 (UTC)
Date: Thu, 4 Dec 2025 17:56:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ben Chaney <bchaney@akamai.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan <hamza.khan@nutanix.com>,
 Mark Kanda <mark.kanda@oracle.com>, Joshua Hunt <johunt@akamai.com>,
 Max Tottenham <mtottenh@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH v3 6/8] tap: cpr support
Message-ID: <aTHLaT3HzoGsnwog@redhat.com>
References: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
 <20251203-cpr-tap-v3-6-3c12e0a61f8e@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251203-cpr-tap-v3-6-3c12e0a61f8e@akamai.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Dec 03, 2025 at 01:51:23PM -0500, Ben Chaney wrote:
> From: Steve Sistare <steven.sistare@oracle.com>
> 
> Provide the cpr=on option to preserve TAP and vhost descriptors during
> cpr-transfer, so the management layer does not need to create a new
> device for the target.
> 
> Save all tap fd's in canonical order, leveraging the index argument of
> cpr_save_fd.  For the i'th queue, the tap device fd is saved at index 2*i,
> and the vhostfd (if any) at index 2*i+1.

This interleaving feels risky from the POV of future extensibility.

Although its unlikely that we'll need a third type of FD per queue,
it would be easy to leave this possiblity open.

IOW, IMHO we should save all tap FDs, then all vhostfds with no
interleaving. If we ever get further FDs to save in future, then
they can be set to follow the vhostfds.

> 
> tap and vhost fd's are passed by name to the monitor when a NIC is hot
> plugged, but the name is not known to qemu after cpr.  Allow the manager
> to pass -1 for the fd "name" in the new qemu args to indicate that QEMU
> should search for a saved value.  Example:
> 
>   -netdev tap,id=hostnet2,fds=-1:-1,vhostfds=-1:-1,cpr=on

This syntax feels redundant.  If cpr==off then "fds" must
always be valid, or not specified at all. If cpr=on, then
"fds" will always be -1. I don't see any point in setting
the 'fds' or 'vhostfds' arg at all. It should simply be:

 -netdev tap,id=hostnet2,cpr=on

this in turn avoids introducing special syntax for allowing
-1 in 'fds' or 'vhostfds' which Markus was concerned with.


> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> index d585fadc5b..68424b4b03 100644
> --- a/include/migration/cpr.h
> +++ b/include/migration/cpr.h
> @@ -48,7 +48,7 @@ void cpr_state_close(void);
>  struct QIOChannel *cpr_state_ioc(void);
>  
>  bool cpr_incoming_needed(void *opaque);
> -int cpr_get_fd_param(const char *name, const char *fdname, int index,
> +int cpr_get_fd_param(const char *name, const char *fdname, int index, bool cpr,
>                       Error **errp);
>  
>  QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
> diff --git a/migration/cpr.c b/migration/cpr.c
> index c0bf93a7ba..19bd56339d 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -316,6 +316,7 @@ bool cpr_incoming_needed(void *opaque)
>   * @name: CPR name for the descriptor
>   * @fdname: An integer-valued string, or a name passed to a getfd command
>   * @index: CPR index of the descriptor
> + * @cpr: use cpr

This feels wierdly redundant too.   THe method name already implies
use of 'cpr', and yet we now have another parameter to ask whether
to use 'cpr'. At the very least these semantics deserve a much
better explanation than "@cpr: use cpr", as I don't know what the
intention is here.

>   * @errp: returned error message
>   *
>   * If CPR is not being performed, then use @fdname to find the fd.
> @@ -325,22 +326,22 @@ bool cpr_incoming_needed(void *opaque)
>   * On success returns the fd value, else returns -1.
>   */
>  int cpr_get_fd_param(const char *name, const char *fdname, int index,
> -                     Error **errp)
> +                     bool cpr, Error **errp)
>  {
>      ERRP_GUARD();
>      int fd;
>  
> -    if (cpr_is_incoming()) {
> +    if (cpr && cpr_is_incoming()) {
>          fd = cpr_find_fd(name, index);
>          if (fd < 0) {
>              error_setg(errp, "cannot find saved value for fd %s", fdname);
>          }
>      } else {
>          fd = monitor_fd_param(monitor_cur(), fdname, errp);
> -        if (fd >= 0) {
> -            cpr_save_fd(name, index, fd);
> -        } else {
> +        if (fd < 0) {
>              error_prepend(errp, "Could not parse object fd %s:", fdname);
> +        } else if (cpr) {
> +            cpr_save_fd(name, index, fd);
>          }
>      }
>      return fd;


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


