Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A2FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 16:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYTeo-0001qR-IH; Mon, 29 Jul 2024 12:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sYTen-0001oD-88
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 12:55:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sYTek-0001ub-RX
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 12:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722272130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vHwpLl1d1jlfYwmWKIpZ0cae476vVmeh2TuqpO8ouj4=;
 b=OGflZ/uL6z0a8maLcH9CqlVIasyPyxlsfPrKcgmrWXbJSbJr/8/FKHmAtMVdwF8RhZM0Sa
 bgl8f87yVEpN8Qs4//4m5nRx/WUf7adJ/SXhGCQKK5HxlCbdZO4NuZBOFEwfPcerWD2JSh
 Kt1tyCHprNW+sY9DLdLRXqTLTb4Gz0w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-F42Ft9-6M-Oyos2R7BNVIQ-1; Mon,
 29 Jul 2024 12:55:23 -0400
X-MC-Unique: F42Ft9-6M-Oyos2R7BNVIQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82D0E195608A; Mon, 29 Jul 2024 16:55:21 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.89])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 892961955D42; Mon, 29 Jul 2024 16:55:17 +0000 (UTC)
Date: Mon, 29 Jul 2024 18:55:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "open list:Block layer core" <qemu-block@nongnu.org>,
 Fam Zheng <fam@euphon.net>, "Hajnoczi, Stefan" <stefanha@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH 4/4] scsi-disk: Always report RESERVATION_CONFLICT to guest
Message-ID: <ZqfJcz6GTsWglrQ5@redhat.com>
References: <20240729094702.50282-1-kwolf@redhat.com>
 <20240729094702.50282-5-kwolf@redhat.com>
 <CABgObfYbpZ3JV5i_TKjobd6DrzYiy567YAfQbX+x5X7mj1=GKw@mail.gmail.com>
 <ZqeI8TiHg8caawXr@redhat.com>
 <CABgObfbecac_70Pt4DWKPRm96VCOOCjGOCSB3TkkK490FmvPsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfbecac_70Pt4DWKPRm96VCOOCjGOCSB3TkkK490FmvPsg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Am 29.07.2024 um 14:26 hat Paolo Bonzini geschrieben:
> Il lun 29 lug 2024, 14:20 Kevin Wolf <kwolf@redhat.com> ha scritto:
> 
> > Apparently both oVirt and Kubevirt unconditionally use the stop policy,
> > so I'm afraid in this case we must acknowledge that our expectations
> > don't match reality.
> >
> 
> Yeah, of course.
> 
> If I understand correctly, not having a pr-manager could mean that QEMU
> > itself is sufficiently privileged and then the same logic would apply.
> >
> > But even if it means that we can't change any persistent reservations
> > from the VM, what use would stopping the VM be? You would run into the
> > exact case I'm describing in the commit message: You try to resume the
> > VM and it immediately stops again because the request still doesn't get
> > through. Or do you expect the host admin to take some manual action
> > then?
> >
> 
> Yes, if the PR operation is not allowed then the host admin would probably
> get a notification and release the PR (or perhaps shutdown the VM with an
> error) itself.
> 
> And what would you do about the Windows cluster validation case that
> > intentionally sends a request which reservations don't and shouldn't
> > allow? There is nothing on the host side to fix there. The guest is only
> > happy when it gets an error back.
> >
> 
> Yes, in that case (which is the most common one) there is nothing you can
> do, so the patch is a good idea even if the case without a PR manager is a
> bit murky.

Ok, so modifying the commit message and removing the 'error'
initialisation it is. Maybe mention the cluster validation case in the
comment here to explain why we do this even for non-pr-manager cases,
but not as a FIXME or TODO because it's not a problem with the
implementation, but we don't have any other choice. Right?

Should I send a v2 for this or is it okay to do this only while applying
the patch?

Kevin


