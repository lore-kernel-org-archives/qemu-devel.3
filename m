Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB966CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 19:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v42Ho-0003Ao-5p; Wed, 01 Oct 2025 15:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v42Hg-00037I-2F
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 15:14:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v42HZ-0003Wo-I5
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 15:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759346065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tliI/poVUILym1QugREKa4eREoYFw7FcQKphKtcP9eE=;
 b=ckHAkWtBONLSjOWook24/yjTD1stanNXoLj0h2UGBKKt/l2rMw36MIVR1mEWffn3q0+tcQ
 gOIVdBfJKbzBgh7Tl5s7a0iTd/iXIOoMtN+kONGJFaxFuptO2H29jyjkJWRdstc3jzW2tO
 +gDOxEZoQtlSmyl05h1tTv04GaZYsZk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-ir3RDjLhPW2m-5c3FyziIQ-1; Wed,
 01 Oct 2025 15:14:19 -0400
X-MC-Unique: ir3RDjLhPW2m-5c3FyziIQ-1
X-Mimecast-MFC-AGG-ID: ir3RDjLhPW2m-5c3FyziIQ_1759346059
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCC081944F05
 for <qemu-devel@nongnu.org>; Wed,  1 Oct 2025 19:14:18 +0000 (UTC)
Received: from localhost (unknown [10.45.224.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4638A195608E; Wed,  1 Oct 2025 19:14:18 +0000 (UTC)
Date: Wed, 1 Oct 2025 20:14:16 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH WIP] Implement -run-with exit-with-parent=on
Message-ID: <20251001191416.GP1460@redhat.com>
References: <20251001174118.2756134-1-rjones@redhat.com>
 <aN1z2C__6M8E7I8L@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN1z2C__6M8E7I8L@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> > +int
> > +set_exit_with_parent(void)
> > +{
> > +    int r;
> > +    pthread_attr_t attrs;
> > +    pthread_t exit_with_parent_thread;
> > +
> > +    /*
> > +     * We have to block waiting for kevent, so that requires that we
> > +     * start a background thread.
> > +     */
> > +    pthread_attr_init(&attrs);
> > +    pthread_attr_setdetachstate(&attrs, PTHREAD_CREATE_DETACHED);
> > +    r = pthread_create(&exit_with_parent_thread, NULL,
> > +                       exit_with_parent_loop, NULL);
> 
> 
>   QemuThread exit_with_parent_thread;
>   qemu_thread_create(&exit_with_parent_thread,
>                      "exit-parent",
>                      exit_with_parent_loop,
>                      QEMU_THREAD_DETACHED);
> 
> mostly just so we get the thread name set.

Right, this (macOS) is the part I didn't even compile test yet, hence
why the patch is WIP.  We do compile the same code in nbdkit, but I
could be sure it'll work in macOS.  I'll make sure to fix this to make
it qemu-native, and test it before posting the real patch :-)

> Broadly looks good to me.

Thanks, I'll incorporate all those suggestions into the real version.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v


