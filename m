Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB510F54ABA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52Ci-0007zC-LD; Tue, 24 Mar 2026 09:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w52Cf-0007yp-LY
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 09:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w52Ce-0007HP-2A
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 09:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774360430;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aDxk8miyTW5MAO1aFSjwu0Nuljv2AMAinL9/vFUbO1A=;
 b=DJANVCfjm5eIHK/4Eh0xiaJk0CWjlAn3hm1R8sivUqs4NqjNS6p0+gXKkHZ6ge9Gz2A7vj
 MPZXkd7kwCX5vV9fv7wqltM7gAU1OpSKr5O+lUpM11j+G/V98d0ywRExYmrbz8iBB5XpnC
 hhdhaPwBxwLq5SQt8EMwfYl/K4733n4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-D9ITZM5TP8OBd4tiRNUxnQ-1; Tue,
 24 Mar 2026 09:53:47 -0400
X-MC-Unique: D9ITZM5TP8OBd4tiRNUxnQ-1
X-Mimecast-MFC-AGG-ID: D9ITZM5TP8OBd4tiRNUxnQ_1774360426
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEE3918002C7
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 13:53:46 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.93])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B15231954102; Tue, 24 Mar 2026 13:53:45 +0000 (UTC)
Date: Tue, 24 Mar 2026 13:53:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 08/60] ui/vnc-jobs: narrow taking the lock when pushing
 empty jobs
Message-ID: <acKXZhq17IH38Cfv@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-8-48eb1dcf7b76@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317-qemu-vnc-v1-8-48eb1dcf7b76@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Tue, Mar 17, 2026 at 12:50:22PM +0400, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/vnc-jobs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
> index 28a4738f1ec..ae925171fae 100644
> --- a/ui/vnc-jobs.c
> +++ b/ui/vnc-jobs.c
> @@ -122,14 +122,14 @@ static void vnc_job_free(VncJob *job)
>  
>  void vnc_job_push(VncJob *job)
>  {
> -    vnc_lock_queue(queue);
>      if (QLIST_EMPTY(&job->rectangles)) {

All the APIs which write to job->rectangles do that in a block
that is protected by vnc_lock_queue, so narrowing this to allow
lock-less access of job->rectangles feels dubious, without some
justification in the commit message to explain why it is safe
for job->rectangles to be unprotected, while 'queue->jobs' still
needs protection.

>          vnc_job_free(job);
>      } else {
> +        vnc_lock_queue(queue);
>          QTAILQ_INSERT_TAIL(&queue->jobs, job, next);
>          qemu_cond_broadcast(&queue->cond);
> +        vnc_unlock_queue(queue);
>      }
> -    vnc_unlock_queue(queue);
>  }
>  
>  static bool vnc_has_job_locked(VncState *vs)
> 
> -- 
> 2.53.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


