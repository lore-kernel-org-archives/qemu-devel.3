Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AFD10F9973
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYK9-0002Kl-H3; Wed, 08 Apr 2026 15:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wAYIw-0007Bi-8X
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wAOSm-0002S7-Fa
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 04:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775637638;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vNzURTCjft3pnt4tIwyfboVA0t93gFW+FEnBhvEAE3A=;
 b=LZ/NUcDH3AyyDmAc61F1Lz8hB5VBNPNBjmc7lcfBj3/JUMzLnf5uiNvBBNB4LxNkMj08Mr
 wX3l4OETOvvUjxjW1A/FL+MABtrU8d3QIqpFD6SfOIHE9033cJkZ4kT183CNXdPQtluPfT
 klHZJeNeea5e9hKeaxGSW0TMhSjn6/c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-nDRVTIecPha0KzhJ2AdGjQ-1; Wed,
 08 Apr 2026 04:40:35 -0400
X-MC-Unique: nDRVTIecPha0KzhJ2AdGjQ-1
X-Mimecast-MFC-AGG-ID: nDRVTIecPha0KzhJ2AdGjQ_1775637630
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC2A81955F41; Wed,  8 Apr 2026 08:40:29 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D84FC1955F2B; Wed,  8 Apr 2026 08:40:21 +0000 (UTC)
Date: Wed, 8 Apr 2026 09:40:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Matthew Penney <matt@matthewpenney.net>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Samuel Tardieu <sam@rfc1149.net>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Collin L. Walling" <walling@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 0/8] tree-wide: use g_clear_handle_id() for GSource cleanup
Message-ID: <adYUcqM4py9e_Q-B@redhat.com>
References: <20260408010026.4611-1-matt@matthewpenney.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408010026.4611-1-matt@matthewpenney.net>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Apr 08, 2026 at 01:01:42AM +0000, Matthew Penney wrote:
> This series replaces open-coded uses of g_source_remove() with
> g_clear_handle_id() across the tree.
> 
> This is a more modern (GLib >= 2.56) approach than directly calling
> g_source_remove().
> 
> g_clear_handle_id() simplifies cleanup of GSource IDs since it
> checks the ID is valid, calls the cleanup function and zeros the ID.
> 
> This reduces boilerplate and avoids open-coded calls to
> g_source_remove().
> 
> This series follows an earlier fix that removed a dangling GSource tag
> and replaced an explicit call to g_source_remove() with
> g_clear_handle_id().
> 
> No functional changes.
> 
> Link: https://gitlab.com/qemu-project/qemu/-/commit/34aad589019c8687fb3b19ba79d64d97071a7205

Looking at your git repo fork, while the commits are creditted under
your name, all the activity on the repo appears to have done by a bot
account:

  https://gitlab.com/mj-penney/qemu/activity

What's the situation here with authorship ? 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


