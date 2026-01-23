Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0F6D74EC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 13:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjGrB-0004rV-Sk; Fri, 23 Jan 2026 08:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vjGpx-0003uw-OI
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:04:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vjGpv-0006lF-EP
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769173463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9u3M6dYghWfEy7bM+5on02J43rDk9Vy2B/0vabHuTUY=;
 b=Q32pJOClNpJ8rhfcaebLEqrdtQgPY72GwiOzmTUCr54Ez+euIQQXf83WG701FFJ61yeSx1
 E2GAhZL3kgaa/jipNH4hhiRdzwIpMzwCfmoFT8bcvQCcgsgbmAgpftUx/BpOGnLYpThNct
 xH217qCEtO4pE+ZXkh1+kM3a+3H86o8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-kv7pgWqcPO-VOjNn3XALfQ-1; Fri,
 23 Jan 2026 08:04:20 -0500
X-MC-Unique: kv7pgWqcPO-VOjNn3XALfQ-1
X-Mimecast-MFC-AGG-ID: kv7pgWqcPO-VOjNn3XALfQ_1769173459
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE8E1193E8C8; Fri, 23 Jan 2026 13:04:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53AEB1958DC1; Fri, 23 Jan 2026 13:04:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D1D5621E692D; Fri, 23 Jan 2026 14:04:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH V2 4/4] qemu-options: Introduce new flag for iothread
In-Reply-To: <20260121064110.28760-4-zhangckid@gmail.com> (Zhang Chen's
 message of "Wed, 21 Jan 2026 14:41:10 +0800")
References: <20260121064110.28760-1-zhangckid@gmail.com>
 <20260121064110.28760-4-zhangckid@gmail.com>
Date: Fri, 23 Jan 2026 14:04:15 +0100
Message-ID: <87ldhoa3ao.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Zhang Chen <zhangckid@gmail.com> writes:

> This demand comes from Cloud Native ecosystem.
> User want to manage resources more flexible like containers (Kata container).
> The real workload maybe changed(runc) in the VM without VM reboot,
> It may need hotplug/unplug different multi disks with multi iothreads to meet
> high level scheduler's needs(like K8s).
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  qemu-options.hx | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index ec92723f10..9afe9d4ebb 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -6352,7 +6352,7 @@ SRST
>  
>              CN=laptop.example.com,O=Example Home,L=London,ST=London,C=GB
>  
> -    ``-object iothread,id=id,poll-max-ns=poll-max-ns,poll-grow=poll-grow,poll-shrink=poll-shrink,aio-max-batch=aio-max-batch``
> +    ``-object iothread,id=id,attached=attached,poll-max-ns=poll-max-ns,poll-grow=poll-grow,poll-shrink=poll-shrink,aio-max-batch=aio-max-batch``
>          Creates a dedicated event loop thread that devices can be
>          assigned to. This is known as an IOThread. By default device
>          emulation happens in vCPU threads or the main event loop thread.
> @@ -6376,6 +6376,13 @@ SRST
>          for many cases but can be adjusted based on knowledge of the
>          workload and/or host device latency.
>  
> +        The ``attached`` parameter is a flag to show whether the iothread
> +        is attached to an actual device(for example virtio-blk). In hotplug
> +        scenario, user can add multiple "-object iothread" and multiple
> +        devices (like virtio-blk). When user hotunplug the devices can keep
> +        the iothreads as a thread pool, following the new hotplug devices can
> +        attach to the released iothread.
> +
>          The ``poll-max-ns`` parameter is the maximum number of
>          nanoseconds to busy wait for events. Polling can be disabled by
>          setting this value to 0.

You're documenting something that does not exist:

    $ qemu-system-aarch64 -object iothread,id=iot0,attached=off
    upstream-qemu: -object iothread,id=iot0,attached=off: Invalid parameter 'attached'

The properties of iothread objects are defined in type
IothreadProperties in qapi/qom.json.


