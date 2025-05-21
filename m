Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDCDC54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 15:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHlNH-0003IQ-Db; Wed, 21 May 2025 11:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uHlNG-0003I9-IP
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:28:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uHlN9-0004J2-Tu
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747841326;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jydhHuE8DomPmh7IArXn0qql66F26TM2aarRyCm7t7Q=;
 b=JXu8pRBJ1tqj8TLsczXR78f6/xgmBshfvewM/fAb9ycRaDCUfMkJkhwKyR/Y60wgqtYyVo
 B4fwNifsFydvPq56XX7wyxmHQa50JBUz2j2XJ0QlhJ+2cvy7b+VTN4SLdwfivNSswsXC4E
 lMcYuHJqiJyMkxiijVHiomi+24sT+3I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-K5uuo2ZLOy2l2VtCJCzaYQ-1; Wed,
 21 May 2025 11:28:44 -0400
X-MC-Unique: K5uuo2ZLOy2l2VtCJCzaYQ-1
X-Mimecast-MFC-AGG-ID: K5uuo2ZLOy2l2VtCJCzaYQ_1747841323
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8161A194511B
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:28:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.129])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E738719560A7; Wed, 21 May 2025 15:28:41 +0000 (UTC)
Date: Wed, 21 May 2025 16:28:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, kraxel@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] ui/vnc: Update display update interval when VM state
 changes to RUNNING
Message-ID: <aC3xJghB7yMWZ7dr@redhat.com>
References: <20250521151616.3951178-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250521151616.3951178-1-jmarcin@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, May 21, 2025 at 05:16:13PM +0200, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> If a virtual machine is paused for an extended period time, for example,
> due to an incoming migration, there are also no changes on the screen.
> VNC in such case increases the display update interval by
> VNC_REFRESH_INTERVAL_INC (50 ms). The update interval can then grow up
> to VNC_REFRESH_INTERVAL_MAX (3000 ms).
> 
> When the machine resumes, it can then take up to 3 seconds for the first
> display update. Furthermore, the update interval is then halved with
> each display update with changes on the screen. If there are moving
> elements on the screen, such as a video, this can be perceived as
> freezing and stuttering for few seconds before the movement is smooth
> again.
> 
> This patch resolves this issue, by adding a listener to VM state changes
> and changing the update interval when the VM state changes to RUNNING.
> The update_displaychangelistener() function updates the internal timer,
> and the display is refreshed immediately if the timer is expired.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>  ui/vnc.c | 12 ++++++++++++
>  ui/vnc.h |  2 ++
>  2 files changed, 14 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


