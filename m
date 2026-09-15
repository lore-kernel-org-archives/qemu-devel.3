Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA2AC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WGn-0006Pq-V4; Tue, 15 Sep 2026 12:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x6WGk-0006Ph-Vn
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:44:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x6WGj-0006rS-MX
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789490668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=upSQMnaakZV9TITmKXS8o+Da50RX3hGMbGi+Wg7LRrY=;
 b=BtnjetzB5beKIKADaawXFHf1HpQpWWBKdZwnlzkNf4agKi70OmN6cd7N+YJInD9XiPFJ63
 eixGVv2+LNovbRWNFIswC/SEIENPa4HCq/nDFOjunrNlADsW75fq9e+Oe7bf4fYjlzvkJx
 rJGuZ8QZkdijhgr66tGVEetdOz0biW8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-h9psZWiINUm6h--xswH9bg-1; Tue,
 15 Sep 2026 12:44:20 -0400
X-MC-Unique: h9psZWiINUm6h--xswH9bg-1
X-Mimecast-MFC-AGG-ID: h9psZWiINUm6h--xswH9bg_1789490659
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B81511954232; Tue, 15 Sep 2026 16:44:18 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.144])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F12119560AB; Tue, 15 Sep 2026 16:44:16 +0000 (UTC)
Date: Tue, 15 Sep 2026 18:44:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Christian Quante <christian@quante.one>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, "Denis V. Lunev" <den@virtuozzo.com>
Subject: Re: [PATCH] hw/block/fdc: account for read and write requests
Message-ID: <aql13aEGZkBCkiJZ@redhat.com>
References: <20260824114216.231916-1-christian@quante.one>
 <20260911145309.47164-1-christian@quante.one>
 <CAFn=p-Z-b6a5Z7V01pfWAR8gKpdt-v3DzzpkY4et6fpVHUmUHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFn=p-Z-b6a5Z7V01pfWAR8gKpdt-v3DzzpkY4et6fpVHUmUHw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

Am 15.09.2026 um 16:30 hat John Snow geschrieben:
> Is anyone looking at this, or should I be investigating it?

I just returned from vacation, so a few things have piled up. Feel free
to have a look, but if you won't, I'll get to it in a while.

Kevin

> --js
> 
> On Fri, Sep 11, 2026 at 10:54 AM Christian Quante <christian@quante.one> wrote:
> >
> > Gentle ping.
> >
> > The patch still applies cleanly on master (209b2afaface) and fdc-test
> > passes with it: 16 ok, 1 skipped without --enable-asan.
> >
> > Thanks,
> > Christian
> >
> 


