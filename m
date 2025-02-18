Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D55C021AD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 20:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkU90-0002Dr-52; Tue, 18 Feb 2025 15:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tkU8w-0002Da-U1
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 15:24:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tkU8u-00043g-5C
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 15:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739910270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=ZZ/t/8/FZmKqnWA3kAbRbMXw7cqMzx1tsylUiw4pJLs=;
 b=NdxadgQN35UZ2EiaGtrLmwm8ClW4mbPrdg3St16+hBKM/ZLPEVrLOIAf7uk5YVKnWvrwlc
 pCUdS8+ywJNCKYno8yMSybdPRaPOcwKEmTIyOf3fzfCOsgTjg+ABZwvUPKrCi4Y99Y3pi2
 jiHxs0Uf81gkr14X+rwKj1tjECxkvvg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-OmL61PJqOn-p5YmNzuoUiA-1; Tue,
 18 Feb 2025 15:24:28 -0500
X-MC-Unique: OmL61PJqOn-p5YmNzuoUiA-1
X-Mimecast-MFC-AGG-ID: OmL61PJqOn-p5YmNzuoUiA_1739910267
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9F111801A10; Tue, 18 Feb 2025 20:24:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71BE4300019F; Tue, 18 Feb 2025 20:24:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2240821E6A28; Tue, 18 Feb 2025 21:24:23 +0100 (CET)
Resent-To: qemu-devel@nongnu.org, yong.huang@smartx.com, farosas@suse.de
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Tue, 18 Feb 2025 21:24:23 +0100
Resent-Message-ID: <878qq39f2g.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: yong.huang@smartx.com,  qemu-devel@nongnu.org,  Fabiano Rosas
 <farosas@suse.de>,  Eric Blake <eblake@redhat.com>
Subject: Re: [RFC] migration: Introduce migration throttle event
In-Reply-To: <Z7TOXfn6BQBhS5uG@x1.local> (Peter Xu's message of "Tue, 18 Feb
 2025 13:15:57 -0500")
References: <4df13a8005170ad42cbbc883a0a8fdbb1ab94ac1.1739846274.git.yong.huang@smartx.com>
 <Z7TOXfn6BQBhS5uG@x1.local>
Date: Tue, 18 Feb 2025 20:21:59 +0100
Message-ID: <87jz9n9hyg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Xu <peterx@redhat.com> writes:

> On Tue, Feb 18, 2025 at 10:39:55AM +0800, yong.huang@smartx.com wrote:
>> From: Hyman Huang <yong.huang@smartx.com>
>> 
>> When the developer is examining the time distribution of
>> the migration, it is useful to record the migration throttle
>> timestamp. Consequently, include the migration throttle event.
>
> Would trace_cpu_throttle_set() work too?  That can provide a timestamp and
> also the new percentage of throttle.
>
> I don't feel strongly that we must not introduce qmp events for debugging,
> but allowing that to happen means we can get tons of events at last.. as
> people can start requesting many more events, and we'll need one way to
> justify them at last.
>
> One way to justify events can be that it could be consumed by mgmt.  On
> that, this one I'm not yet sure.. so ideally tracepoints could work already.

Good point.


