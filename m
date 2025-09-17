Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30ECCA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 09:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyocp-0004gA-K9; Wed, 17 Sep 2025 05:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyocn-0004fU-VX
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 05:38:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyocl-00061r-V4
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 05:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758101929;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=c47gHRQGkJPfC1+WlfMOzsU2eEklRP7MkKPjLfz2//Q=;
 b=U/gSgIxEzwuaiHY2PVByuolVde0J4DverGWVKcyQ2HY23m5HYvGZtsrRJ4Rd7XdVn5w+Le
 RZoiQ2kAywR1KQodgBBQcbD5gOVJDM9AcZL/GdSMP8RNw+HgHkuCf795ZmKg1QUcYnDrX2
 LvwKyR51j8tFB9rkYIMeGJNzpNr9nMo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-yauIE06nNv2rlEJqWnxLig-1; Wed,
 17 Sep 2025 05:38:46 -0400
X-MC-Unique: yauIE06nNv2rlEJqWnxLig-1
X-Mimecast-MFC-AGG-ID: yauIE06nNv2rlEJqWnxLig_1758101924
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 909681955F2A; Wed, 17 Sep 2025 09:38:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECA6318004D8; Wed, 17 Sep 2025 09:38:33 +0000 (UTC)
Date: Wed, 17 Sep 2025 10:38:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: zoudongjie <zoudongjie@huawei.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 alex.chen@huawei.com, chenjianfei3@huawei.com,
 eric.fangyi@huawei.com, luolongmin@huawei.com,
 mujinsheng@huawei.com, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, renxuming@huawei.com,
 suxiaodong1@huawei.com, wangjian161@huawei.com,
 wangyan122@huawei.com, yebiaoxiang@huawei.com,
 yangming73@huawei.com, zhuyangyang14@huawei.com
Subject: Re: [PATCH] vnc: Fix memory leak during VNC tls authentication
Message-ID: <aMqBlebG_tVzubhe@redhat.com>
References: <20250916134153.974692-1-zoudongjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250916134153.974692-1-zoudongjie@huawei.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Sep 16, 2025 at 09:41:53PM +0800, zoudongjie via wrote:
> When qemu is performing a TLS handshake for VNC, it will monitor vs->sioc
> in the qio_channel_tls_handshake_task. If the number of concurrent VNC
> connections exceeds the maximum number allowed by qemu, vnc_connect will
> traverse all connection requests in share mode VNC_SHARE_MODE_CONNECTING
> and disconnect the first one.
> 
> If the disconnected request has not yet entered qio_channel_tls_handshake_io,
> it will cause the data pointer allocated in qio_channel_tls_handshake_task
> to leak directly, leading to an indirect leak of the task and its associated
> pointers.

The qio_channel_tls_close method will cancel the pending handshake by
calling g_clear_handle_id. The problem is that when we do that, we fail
to release the QIOTask object because that is only freed when
qio_channel_tls_handshake is called on completion triggering use of
qio_task_complete.

The problem here is that we broadly mis-used the APIs for sources...

> @@ -201,13 +219,23 @@ static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
>          }
>  
>          trace_qio_channel_tls_handshake_pending(ioc, status);
> -        ioc->hs_ioc_tag =
> -            qio_channel_add_watch_full(ioc->master,
> -                                       condition,
> -                                       qio_channel_tls_handshake_io,
> -                                       data,
> -                                       NULL,
> -                                       context);

...instead of NULL we should have passed a method that can free
the 'data' object there, as well as the QIOTask that 'data'
contains a reference to.

The qio_task_complete method should not then free the task.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


