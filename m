Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D5ECCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmyD-0003U4-20; Fri, 31 Oct 2025 07:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEmxQ-0002pq-GD
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:06:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEmxM-0004zo-7u
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761908763;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2PxoOqB5URhz/iSd8OVCvwR0AcZKcxtGvaDomV0WBTE=;
 b=dC6zDzDEw/D4L1TPvXCnp4v8F5SF7nE5ABMPd+O8veGWTURzuQM25IPdx6OnCMLcd1S3PW
 I7GgjbYFdOlf0IETmAIQPe4rcTi2w7oT1IsmQnCnwk5uldSMUh3fJG9J+Fqdnf8ZRCyQeB
 b0yvWwL+xOaBjr+X7LwTi3v9CQPNNps=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-HL3sve6ZNrS24l2JU9ZIiQ-1; Fri,
 31 Oct 2025 07:05:59 -0400
X-MC-Unique: HL3sve6ZNrS24l2JU9ZIiQ-1
X-Mimecast-MFC-AGG-ID: HL3sve6ZNrS24l2JU9ZIiQ_1761908758
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 042DE1805C32; Fri, 31 Oct 2025 11:05:58 +0000 (UTC)
Received: from redhat.com (dhcp-17-192.lcy.redhat.com [10.42.17.192])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DB0519560A2; Fri, 31 Oct 2025 11:05:55 +0000 (UTC)
Date: Fri, 31 Oct 2025 11:05:52 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PULL 03/18] block: fix luks 'amend' when run in coroutine
Message-ID: <aQSYEBhnOiEieAGD@redhat.com>
References: <20251029120634.288467-1-kwolf@redhat.com>
 <20251029120634.288467-4-kwolf@redhat.com>
 <15aae406-bb9c-4938-8ea4-10a794065990@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15aae406-bb9c-4938-8ea4-10a794065990@tls.msk.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 31, 2025 at 01:18:54PM +0300, Michael Tokarev wrote:
> On 10/29/25 15:06, Kevin Wolf wrote:
> > From: Daniel P. Berrangé <berrange@redhat.com>
> > 
> > Launch QEMU with
> > 
> >    $ qemu-img create \
> >        --object secret,id=sec0,data=123456 \
> >        -f luks -o key-secret=sec0 demo.luks 1g
> > 
> >    $ qemu-system-x86_64 \
> >        --object secret,id=sec0,data=123456 \
> >        -blockdev  driver=luks,key-secret=sec0,file.filename=demo.luks,file.driver=file,node-name=luks
> > 
> > Then in QMP shell attempt
> > 
> >    x-blockdev-amend job-id=fish node-name=luks options={'state':'active','new-secret':'sec0','driver':'luks'}
> > 
> > It will result in an assertion
> 
> Is this a qemu-stable material (for 10.0 & 10.1),
> or is it not because it's an x-command? :)
> 
> I picked it up for now, please let me know if I shouldn't.

Yes that's good.

Also please pick up the previous patch 02 which fixes another
luks bug.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


