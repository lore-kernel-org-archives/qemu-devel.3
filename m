Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78B6C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 14:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZstr-0003gv-1p; Fri, 02 Aug 2024 10:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZstp-0003f2-6B
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:04:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZstn-0000Sq-5C
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722607489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wdifgzxbp5ac7lD3fy430ZGdFCLk2H/FlSucbDLsi2I=;
 b=PcgyyYmaHAANYO08g0LIvcJ3kGLov36Y+fj0aaLrCfr77azXMI3WHy9u5V55T1aOY6Xv9c
 Md0mrVQOPIQOUtvkSL4WO2LtPuEx6lsNqUuPYA2CtsAezYbZLZhHqkQOcVkYzTkzmAoF4I
 ys7TDDEwB46kGrKmTIUWTSV4osRNmJI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-AkG45xfnP1ClUjW5h7Khsg-1; Fri,
 02 Aug 2024 10:04:47 -0400
X-MC-Unique: AkG45xfnP1ClUjW5h7Khsg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A865E1955EA7; Fri,  2 Aug 2024 14:04:44 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.72])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1B0F19560AA; Fri,  2 Aug 2024 14:04:41 +0000 (UTC)
Date: Fri, 2 Aug 2024 09:04:38 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, 
 andrey.drobyshev@virtuozzo.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com, 
 berrange@redhat.com, Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: Re: [PATCH v2 1/3] nbd: CVE-XXX: Use cookie to track generation of
 nbd-server
Message-ID: <huhjgqsj7dzwdphz6maoz63q6wowqudyo6r6wh6y4t4txsgf4h@sacrygikvt36>
References: <20240802014824.1906798-5-eblake@redhat.com>
 <20240802014824.1906798-6-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802014824.1906798-6-eblake@redhat.com>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 01, 2024 at 08:32:06PM GMT, Eric Blake wrote:
> As part of the QMP command nbd-server-start, the blockdev code was
> creating a single global nbd_server object, and telling the qio code
> to accept one or more client connections to the exposed listener
> socket.  But even though we tear down the listener socket during a
> subsequent QMP nbd-server-stop, the qio code has handed off to a
> coroutine that may be executing asynchronously with the server
> shutdown, such that a client that connects to the socket before
> nbd-server-stop but delays disconnect or completion of the NBD
> handshake until after the followup QMP command can result in the
> nbd_blockdev_client_closed() callback running after nbd_server has
> already been torn down, causing a SEGV.  Worse, if a second nbd_server
> object is created (possibly on a different socket address), a late
> client resolution from the first server can subtly interfere with the
> second server.  This can be abused by a malicious client that does not
> know TLS secrets to cause qemu to SEGV after a legitimate client has
> concluded storage migration to a destination qemu, which can be turned
> into a denial of service attack even when qemu is set up to require
> only TLS clients.

Now assigned CVE-2024-7409; I'll make sure that is mentioned in the
commit message, whether a v2 is needed or whether this gets a positive
review as-is modulo the reference.

I have not (yet?) determined how long the bug has existed, but note
that the code in question appears unchanged since at least qemu 6.0
(from 2021), and probably predates that, so it is long-standing.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


