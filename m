Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C91FF513C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABS6-0003Nm-74; Tue, 07 Apr 2026 14:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wABRb-0002em-Rx
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wA9ZY-0007HK-NC
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 12:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775580398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GwyshnftlC61g1NU8RzrscCT+hDwRO+5dSqwShWa/uI=;
 b=Ulck8sWyd01qtDZPKgezZCGocbuDNNX2HfCIiZLbiVaQqBy2767gcGvJrQ9RY8M9dJELFs
 zGL5LqR4vfd3HJplX6pAoRNe0qf9DHv2IIpHzyU3bNQ3jTVFOqn2mWLMHJGmiHWwkYcOHp
 r8dvOnCWhaWpdW8RAcuaDl/+eJ40/mc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-hwfb4XtqNU2pR18hlvmvoA-1; Tue,
 07 Apr 2026 12:46:37 -0400
X-MC-Unique: hwfb4XtqNU2pR18hlvmvoA-1
X-Mimecast-MFC-AGG-ID: hwfb4XtqNU2pR18hlvmvoA_1775580396
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66C8518005B3; Tue,  7 Apr 2026 16:46:35 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.87])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 994B31800767; Tue,  7 Apr 2026 16:46:32 +0000 (UTC)
Date: Tue, 7 Apr 2026 18:46:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 pbonzini@redhat.com
Subject: Re: [PULL 4/6] monitor: Fix deadlock in monitor_cleanup
Message-ID: <adU05hwKDW16sYu4@redhat.com>
References: <20260331150352.256332-1-kwolf@redhat.com>
 <20260331150352.256332-5-kwolf@redhat.com>
 <d0187495-f196-43a3-b77c-463a098b5f60@tls.msk.ru>
 <2f8a1144-f002-44ae-b9ff-8cbb4f13742f@tls.msk.ru>
 <adTy5PTUjTu_Swj8@redhat.com>
 <0e72c7ba-9a7a-4762-8085-bf99ac266f59@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e72c7ba-9a7a-4762-8085-bf99ac266f59@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Am 07.04.2026 um 15:30 hat Michael Tokarev geschrieben:
> On 07.04.2026 15:04, Kevin Wolf wrote:
> 
> > utils_ss in the meson files is messy. Enabling something that needs the
> > block layer enables additional files for qga, too. It should probably be
> > split in two and qga should always only be built with what is present
> > when you build only qga and nothing else.
> > 
> > But for now, the patch below should fix it.
> 
> > diff --git a/util/meson.build b/util/meson.build>   if have_block or have_ga
> > -  util_ss.add(files('aiocb.c', 'async.c'))
> > +  util_ss.add(files('aiocb.c', 'aio-wait.c', 'async.c'))>   endif
> >   if have_block
> > -  util_ss.add(files('aio-wait.c'))
> 
> Yes this seems to fix the link failure.  However, the whole thing is
> messy indeed.
> 
> I *guess* qapi/qmp-dispatch.c should not be used by qga.  That to say, -
> instead of adding more stuff to qga link line, it looks like we should
> remove stuff from it :)

I don't think you can have QMP without qapi/qmp-dispatch.c, so this does
look like the right fix to me. There is no real reason why aio-wait.c
should be considered specific to the block layer.

The part that I don't like about the situation is just that the build
didn't fail without disabling everything else in configure. It should
have failed. But yes, that's for 11.1.

Kevin


