Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9F8D1039A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 15:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Me8-0005sI-NW; Fri, 25 Oct 2024 11:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t4Me7-0005ru-Hn
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:54:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t4Me5-0003k2-Rq
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729871677;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/lFV9fR2HLgDFz1YhJ6SVXR3we9EMselYTvMofuJhsM=;
 b=ODneIMWurAZndz8Hrzws+fL68+cEshbGvEfBDTWkOVvDPSzF64MBgV3aMEZ47RcKUHPULZ
 hRXeaP27xrdz3d+0ONO7vwYK0zRM+AJYrbRRvlMulK2DB1QUNKbQDkgqlX+FTe7fzaI2aC
 crlsyK8g+3A+YjnapTUl/KJT+RllAUk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-KTUrCqv0Op6zkQvDfwu2nw-1; Fri,
 25 Oct 2024 11:54:32 -0400
X-MC-Unique: KTUrCqv0Op6zkQvDfwu2nw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 231F8195608F; Fri, 25 Oct 2024 15:54:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.164])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E1431955F43; Fri, 25 Oct 2024 15:54:29 +0000 (UTC)
Date: Fri, 25 Oct 2024 16:54:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Subject: Re: cpr-transfer with caveats
Message-ID: <Zxu_MqXqm78v3zJE@redhat.com>
References: <87b1beba-4e03-45c7-b6ce-2772dcb117d1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87b1beba-4e03-45c7-b6ce-2772dcb117d1@oracle.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 25, 2024 at 11:01:27AM -0400, Steven Sistare wrote:
> Hi Peter, are you OK if we proceed with cpr-transfer as is, without the
> precreate phase?  Here are the problems that motivated it:
> 
> * migration test wants to enable migration events on the dest.
>   fix: enable on dest qemu using -global.  only for the test.
> 
> * migration test needs to fetch the dynamically assigned migration
>     listen port number
>   Fix: require unix domain socket for cpr-transfer, or a fixed port
>   number. Document it.
> 
> * migration test hangs connecting to the qtest socket.
>   fix: in the qtest code, defer connection.
> 
> Document that one cannot set migration caps or params on the dest
> for cpr-transfer.
> 
> Document that for -incoming defer, mgmt must send the migrate command
> to the src first (so dest reads cpr state and progresses to start the
> monitor), then send the hotplug monitor commands to the dest.
> 
> Daniel, are you OK with that last bit?

I guess it depends on what happens inside QEMU between reading the
cpr state and libvirt being able to access the monitor. Libvirt does
various things with the monitor during QEMU startup, before guest
vCPUs start. Mostly this is around host resource placement/mgmt
that needs to be done before the guest CPUs start.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


