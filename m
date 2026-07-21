Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460CBC4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 09:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7F6-0000qh-GU; Tue, 21 Jul 2026 05:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wm7F4-0000pJ-Lx
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 05:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wm7F2-0005lx-3D
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 05:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784627902;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mMi2+m+BXISsqNhqI/nZQXyE60UYA6Y5IVIEbSUTMrc=;
 b=TQQgI4xKNOTD2yS+jiWLCe4EejXU9glR8TAApJQKLRo/Oh6QCkeOXwmM9+GC1ypyTPOZrb
 0g76uzX1pTUq9yIwEmC9I0nGn+8syNoxuxnAFGtrMxTOD7tsBdmUk9mjhT0US7n6MOUJ/4
 aDaABXGLec5fmIYbn5dycE6rPfd3UwE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-xiCSWs_ONR-QVXzRiIWKVw-1; Tue,
 21 Jul 2026 05:58:18 -0400
X-MC-Unique: xiCSWs_ONR-QVXzRiIWKVw-1
X-Mimecast-MFC-AGG-ID: xiCSWs_ONR-QVXzRiIWKVw_1784627897
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FEEB195F15F; Tue, 21 Jul 2026 09:58:17 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.229])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A10821954235; Tue, 21 Jul 2026 09:58:15 +0000 (UTC)
Date: Tue, 21 Jul 2026 10:58:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] docs: Add security considerations for migration
Message-ID: <al9CtDmpv7lXJKe6@redhat.com>
References: <20260720182750.3029289-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720182750.3029289-1-farosas@suse.de>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

On Mon, Jul 20, 2026 at 03:27:50PM -0300, Fabiano Rosas wrote:
> Add the security considerations that are unique to migration and that
> do not already fall into one of the other categories. Some aspects are
> better framed as security architecture considerations, so extend that
> section to mention TLS and clarify that disk images and guest network
> also need to be isolated from other processes, not just other guests.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  docs/system/security.rst | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/system/security.rst b/docs/system/security.rst
> index 52bbf0cc7a2..26c686718cf 100644
> --- a/docs/system/security.rst
> +++ b/docs/system/security.rst
> @@ -133,6 +133,16 @@ an issue as a normal bug.
>    that affect the level 0 QEMU process. While these bugs should be
>    fixed, they will not be triaged as security flaws at this time.
>  
> +* **migration/snapshots**. Migration failures and snapshot load
> +  failures are considered part of normal operation as long as the
> +  source virtual machine and savevm file, respectively, are still
> +  functional. Aborting the QEMU process at the migration/snapshot
> +  destination is similarly not considered a security issue. The
> +  migration stream is assumed to be secure as long as the design
> +  principles described in the Architecture section are held, in
> +  which case plain manipulation of the stream is not considered as
> +  an attack vector.
> +
>  * **low severity impact**. As a catch all rule, issues which
>    are judged to have a "low" severity impact on the system will
>    usually not justify handling as security bugs, nor assignment
> @@ -159,10 +169,11 @@ could allow malicious guests to gain code execution in QEMU.  At this point the
>  guest has escaped the virtual machine and is able to act in the context of the
>  QEMU process on the host.
>  
> -Guests often interact with other guests and share resources with them.  A
> -malicious guest must not gain control of other guests or access their data.
> -Disk image files and network traffic must be protected from other guests unless
> -explicitly shared between them by the user.
> +Guests often interact with other guests and share resources with them.
> +A malicious guest must not gain control of other guests or access
> +their data.  Disk image files and network traffic must be protected
> +from other guests, users and processes unless explicitly shared with
> +them by the user.
>  
>  Principle of Least Privilege
>  ''''''''''''''''''''''''''''
> @@ -223,6 +234,9 @@ Some Linux distros already ship with UNIX groups for these devices by default.
>    system calls that are not needed by QEMU, thereby reducing the host kernel
>    attack surface.
>  
> +- Transport Layer Security (TLS) protocol can be used to ensure hypervisor
> +  authenticity and encryption of the live migration connection.

I'd be a bit stronger

 - Transport Layer Security (TLS) protocol should be used to ensure
   hypervisor authenticity and encryption of the live migration
   connection where the network is untrusted.

None the less, 

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>



With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


