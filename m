Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3092C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ajz-00017Y-3b; Mon, 07 Sep 2026 10:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x3ajx-00017P-5o
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x3ajv-0001Mw-Ei
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788792870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QC69+LUAKvXGzSVJs541Xx0cVLGZ5AzpwgIKbsTzbsA=;
 b=HWhBR+sJTxKrz8W3BkYXi4urtqfIH8A7nhkg295hhzvm4qIKeaZePIvho31gWRUim61MuH
 N1JQSO9801tqtkSo9/4aYBjJf8xtcrrdz1uGah+PVDnxtzrR78864azpWd7y0lQ0DL7+mT
 jWcDMUsZ5hbpb4McO6nVrYX0ltiwTwQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-opdMXWB5OgKE7UgymynIxQ-1; Mon, 07 Sep 2026 10:54:29 -0400
X-MC-Unique: opdMXWB5OgKE7UgymynIxQ-1
X-Mimecast-MFC-AGG-ID: opdMXWB5OgKE7UgymynIxQ_1788792868
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-482db84a6eeso3389086f8f.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 07:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788792868; x=1789397668; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QC69+LUAKvXGzSVJs541Xx0cVLGZ5AzpwgIKbsTzbsA=;
 b=iLGArrXrfOGmmRKUeqdil249zJQHHIP8cWgDHXmcgSHKipDTagxQHEPRso4ABksJ35
 fkb0VH+WKdybnGZK06YILwNLrD+OI1G6Ek2RpsMeu+xCLrKbgwsF8+XfAGhwMt56JCGs
 r+TUs+v3hTkQC+TNZg8kbQhU8VwiovN32OK9lq5NOwGtkq3IRKcrVuH2fq/1Qgtwa4kJ
 OZz97CAGsTBfa6qVKQJ4gop3zltqLSntmFtrb0rYQUv47GFpz70TRbsTlnj/FnPpzdUK
 ZRR57ltBpQSk1le6W4l3pMbpjJQjWZWlx1OH04IzLSb4/lhXbHNN4ex6M9nARUUksP66
 F0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788792868; x=1789397668;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QC69+LUAKvXGzSVJs541Xx0cVLGZ5AzpwgIKbsTzbsA=;
 b=l/OonknBKZ7nuWffu5DjDyJwLNpTZeZk3ZBbQZtVafK/pGacH19UxRDGHtjsIpyJbG
 XRfpsWx+3bdVXkoOGzbFfQd2imFLmVyfcxanh9G6yawW86m0rDkUfja/qH7qpmrPoqnl
 CyyvpOtCJz2WGJkkoxoPbvB5PRs9GUcyujByrDf9wsdochcH4QKlZR00fjill4XlG/X7
 o6BZlbMTxPP46imzc+dV3liOEYtCGgWh/43JGFqCzMHq1gE6MMYZFtqYLsI1Nb3Ijjba
 V8NXWZuGLl2jXpQPdnDgyZu912ImugJ2bFzB6UzwJcVtq8CFaHl8Ev5pTW22IUIhkhhm
 bfrg==
X-Gm-Message-State: AFuF++mnExRyu8cJ2PTUd2aXMCLSjJS7ClrjTeBgFXLE83FikEeR93jn
 bcwha2O22ZX2OD9DHwGwqPGLw8TayqRCg9aAQS+RLEDYzpvgnEx8dnkBkKeJ2EMufPcEBmyniJG
 fFznsd/doeOcxdt/YeR7OBrJVckdjjjV+5u789C8x+uQxBaX3m/TmoX9l
X-Gm-Gg: AYBFou2w/yPT4XWb9QUlMT8+TT5wJEvfHbTU04YCJ/BiMuIPiXSAe/9Xed6BEZG+nWb
 /PolYniDFMYz04FTfpiAmE2/su0YHD/TXKVcovNUsL3WIBi1n/q7qDLag9ULJGrYAEGayuJvQSR
 R7W1KCJ7kIIKsASQYRd8ZyAcbzL5WBa9ocG0aFR9hAryooRYgq26ckejxobSNabDF6qb5OAntpe
 dp//wbMPxLqRzlAk583Y4O72xtYPYC8MPYXkRc+OafxnNCOoExOr9Ua5MDvXwr4fEIOoGKcnzGW
 1YyH+ZLx4WfygrmR2ncQoQFjNy9SrxdCQvh9hFiuhRII/DcOVl3kv9/aLoAPetle3VcRNNLHgpX
 +Qx6TOgN/T6JoRDL0oQTRwpmC3dLnJsXyiOAsAXWDuWUwnQ==
X-Received: by 2002:a05:6000:460b:b0:484:46f9:7adb with SMTP id
 ffacd0b85a97d-4858709b1e7mr49264483f8f.26.1788792868468; 
 Mon, 07 Sep 2026 07:54:28 -0700 (PDT)
X-Received: by 2002:a05:6000:460b:b0:484:46f9:7adb with SMTP id
 ffacd0b85a97d-4858709b1e7mr49264135f8f.26.1788792866025; 
 Mon, 07 Sep 2026 07:54:26 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4859162f354sm21451106f8f.20.2026.09.07.07.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 07:54:25 -0700 (PDT)
Date: Mon, 7 Sep 2026 16:54:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de, 
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
Subject: Re: [PATCH v4 01/10] vhost-vsock: block CPR migration modes
Message-ID: <ap7DIFtWVbhCJwby@sgarzare-redhat>
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
 <20260820113955.509478-2-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260820113955.509478-2-andrey.drobyshev@virtuozzo.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Aug 20, 2026 at 02:39:46PM +0300, Andrey Drobyshev wrote:
>CPR migration with a vhost-vsock device currently crashes the target
>QEMU.  The device ownership is not handed over, so while the source
>QEMU still holds the guest CID hashed in the kernel, the target's freshly
>opened vhost-vsock device fails to set the same CID in realize():
>
>  qemu-system-x86_64: -device vhost-vsock-pci,id=vsock0,guest-cid=3:
>  vhost-vsock: unable to set guest cid: Address already in use
>
>Add an unconditional migration blocker for the CPR modes, so that such
>a migration fails early and gracefully instead.  The following patches
>implement the actual vhost-vsock CPR support, and the blocker is lifted
>once it's fully working.
>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost-vsock.c         | 27 +++++++++++++++++++++++----
> include/hw/virtio/vhost-vsock.h |  1 +
> 2 files changed, 24 insertions(+), 4 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>


