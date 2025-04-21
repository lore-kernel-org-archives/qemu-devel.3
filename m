Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469E7C369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 14:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6sL1-0001l6-Oq; Mon, 21 Apr 2025 10:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u6sKz-0001iX-NV
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 10:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u6sKx-0007NY-Na
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 10:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745246489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+tTROjBPBy211St87/q1znq0HazY1bBX5C7ngApAGXY=;
 b=aS8yGwrU08p7ue+BkGnDoAfIg68fYi+wsK3rSqUsdx5fDq2oFaEbqO1kAkacjMbJSnKHFx
 ybqTgTV+9S/MEloPTWW60Y54wlBkmL8IdWlWHgaigaKBNf53Yt7ze62l8Yk6Tp69HcKth8
 N2Ny22IJRU7ElpLC6/OSAsLjgZ5Ru8A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-wTZ0ILIBPNessvbkJgtp7w-1; Mon,
 21 Apr 2025 10:41:27 -0400
X-MC-Unique: wTZ0ILIBPNessvbkJgtp7w-1
X-Mimecast-MFC-AGG-ID: wTZ0ILIBPNessvbkJgtp7w_1745246486
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 335121956088; Mon, 21 Apr 2025 14:41:25 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1F8F19560AB; Mon, 21 Apr 2025 14:41:22 +0000 (UTC)
Date: Mon, 21 Apr 2025 09:41:19 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "open list:Block Jobs" <qemu-block@nongnu.org>
Subject: Re: [PATCH 3/6] mirror: Skip writing zeroes when target is already
 zero
Message-ID: <mbwvegjh4hywvewvbxwnhrgnafeh4my3jrozuslyupikaznr6u@7n2k4tke35pp>
References: <20250411010732.358817-8-eblake@redhat.com>
 <20250411010732.358817-11-eblake@redhat.com>
 <c3044546-b921-4cbc-959d-4f23e0e3c49e@yandex-team.ru>
 <k2owyvfkfsj6kkbd2bkgk5jjepxf2gexllc7pfednxrzezlgc6@lh4ebgd7kl3a>
 <d6bbeeed-2733-4211-a3a8-3e467289b4f7@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6bbeeed-2733-4211-a3a8-3e467289b4f7@yandex-team.ru>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.692,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Apr 21, 2025 at 09:15:33AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 17.04.25 00:51, Eric Blake wrote:
> > (a write zeroes that fails AND causes the disk to no longer read as
> > zero should not happen)
> 
> I don't know, is there such a contract? write-zeroes may fallback to write(), which only state that:
> 
>        An error return value while performing write() using direct I/O
>        does not mean the entire write has failed.  Partial data may be
>        written and the data at the file offset on which the write() was
>        attempted should be considered inconsistent.
> 
> So, I used to think that on failed write nothing is guaranteed.
> 
> What do we lose if we just unset the bitmap before write-zeroes, and set it again in case of success?
>

I still don't see the point.  Either the cluster was already non-zero
before the failed write-zero (so there's no bit to pre-clear); or the
cluster was already zero before the failed write-zero, and any failure
that corrupts the disk by actually turning zeroes into non-zero is not
worth worrying about, so pre-clearing the bit is not going to make
things any better.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


