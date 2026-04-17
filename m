Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B6AF436B2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDkth-0000oA-GU; Fri, 17 Apr 2026 11:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wDktf-0000nM-3p
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 11:14:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wDktd-0008Dn-0l
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 11:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776438855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bF1sUdajcbP9BdPXqjwCJ5oZy+hdSOHc4x6mwxuDKgU=;
 b=RDZjR6IsBL+KBTsvysMOhTtS0yIIzQnjIFXVtl+T1GKOcozeF256TNw+fy4gmS9yJ0+xmh
 dVLNxzjbe3k2oM63jphXKmI/WaQhwj4FciiO9mIa1NCKhZbVU2ML0heaPYlZPRRfk0DnZZ
 y5WCaNAi6HlZxhDT88sE/rJc6UoI06U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-M902SZHLPYK8uxGqCTsHlg-1; Fri,
 17 Apr 2026 11:14:10 -0400
X-MC-Unique: M902SZHLPYK8uxGqCTsHlg-1
X-Mimecast-MFC-AGG-ID: M902SZHLPYK8uxGqCTsHlg_1776438849
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BEB818005B1; Fri, 17 Apr 2026 15:14:09 +0000 (UTC)
Received: from localhost (unknown [10.44.48.66])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32FB019560B1; Fri, 17 Apr 2026 15:14:07 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: Re: [PATCH] target/s390x/kvm: Simplify the async pfault handling code
In-Reply-To: <20260317134531.460141-1-thuth@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260317134531.460141-1-thuth@redhat.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Fri, 17 Apr 2026 17:14:05 +0200
Message-ID: <87zf31ty9u.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Mar 17 2026, Thomas Huth <thuth@redhat.com> wrote:

> From: Thomas Huth <thuth@redhat.com>
>
> Since commit 126e7f78036 ("kvm: require KVM_CAP_IOEVENTFD and
> KVM_CAP_IOEVENTFD_ANY_LENGTH") we require at least kernel v4.4 to
> be able to use KVM. KVM_CAP_ASYNC_PF is available in the kernel
> since v3.15 and KVM_SYNC_PFAULT is available since kernel v3.18,
> so we can assume now that they are available in all supported
> kernels. Thus simplify the code a little bit by removing the
> checks for these features.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  I just found this old patch on one of my local branches ... seems like
>  I forgot to send it out after writing it last year...
>
>  target/s390x/kvm/kvm.c | 52 +++++++++---------------------------------
>  1 file changed, 11 insertions(+), 41 deletions(-)

Thanks, queued to s390-next.


