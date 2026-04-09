Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030D2EA3C59
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 13:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wApSS-00064W-Er; Thu, 09 Apr 2026 09:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wApSQ-00063l-G6
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 09:30:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wApSO-0000PC-Gw
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 09:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775741400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZwyYlHDfWcHHfVnpfjd80OtBuGb9WtbKjhgQs8s2SMg=;
 b=dtr5DhAggcmuV6upMCMBk6gk1aVgeVuEu+PU/RZNQXKUYFbOiK96Y00Azo21hKKeDQKWI7
 Vylq1FRu80rHvWtw5jSojmEGu9+xTg/ZxMmM4mnqzjR2dmkUxZBt0KmFLvZn1BntKHFswz
 1CmuC9frCmIcZz6uFqYd7ojetAVbyqQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-s0aEJI0GOPqCovVpVy8tLw-1; Thu,
 09 Apr 2026 09:29:56 -0400
X-MC-Unique: s0aEJI0GOPqCovVpVy8tLw-1
X-Mimecast-MFC-AGG-ID: s0aEJI0GOPqCovVpVy8tLw_1775741395
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E95F1800741; Thu,  9 Apr 2026 13:29:55 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.188])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60BFA19560AB; Thu,  9 Apr 2026 13:29:53 +0000 (UTC)
Date: Thu, 9 Apr 2026 15:29:51 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Peter Lieven <pl@dlhnet.de>
Subject: Re: [PULL 26/28] block/nfs: add support for libnfs v6
Message-ID: <adepzzSu4w5BJP8i@redhat.com>
References: <20260310162622.333137-1-kwolf@redhat.com>
 <20260310162622.333137-27-kwolf@redhat.com>
 <CAFEAcA_c_LOZmeMc7PvcUK4PgyAbzvrcVt3VyALRLtY6ECbpEg@mail.gmail.com>
 <abLmCCB-Wjn-mqh1@redhat.com>
 <CAFEAcA9caqp+JP_cq7Q0P3EPgWywd8BJCrngAKEBh6i2G7uJ1w@mail.gmail.com>
 <abLuKyQp20ZO1Rm-@redhat.com>
 <CAFEAcA_hYSFZGvB5sYQj_WkWx2ma0qm3z1ABzKCVr3Nv_HAC4g@mail.gmail.com>
 <CAFEAcA_o5x1yFDo9tsf+Kr_Hw5NJumtZLSYXzNiNU0D5aGiRxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_o5x1yFDo9tsf+Kr_Hw5NJumtZLSYXzNiNU0D5aGiRxw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 09.04.2026 um 11:48 hat Peter Maydell geschrieben:
> On Fri, 20 Mar 2026 at 09:50, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > I just noticed I forgot to cc Peter Lieven on this email -- sorry
> > about that.
> >
> > On Thu, 12 Mar 2026 at 16:47, Kevin Wolf <kwolf@redhat.com> wrote:
> > >
> > > Am 12.03.2026 um 17:19 hat Peter Maydell geschrieben:
> > > > On Thu, 12 Mar 2026 at 16:13, Kevin Wolf <kwolf@redhat.com> wrote:
> > > > >
> > > > > Am 12.03.2026 um 10:41 hat Peter Maydell geschrieben:
> > > > > > Maybe we can't get here, but maybe it would be simpler to handle
> > > > > > the "asked to read 0 bytes" case directly without calling into the
> > > > > > nfs library or allocating a 0 byte buffer?
> >
> > > > > We could have an 'if (!bytes) { return 0; }' at the start of the
> > > > > function if we want to.
> >
> > > > Mmm. Let me know if you'd prefer me to mark this issue in
> > > > Coverity as a false positive rather than changing the code.
> > >
> > > I don't really mind either way. If someone posts a patch, I'll apply it
> > > (though not sure if that would be only for 11.1 at this point).
> >
> > So what is the conclusion here -- do we want to change the code,
> > or are we happy with it as it is and want to tell Coverity this
> > is a false positive?
> 
> Ping. I would like to know whether we want to make a change here,
> or if I should mark this as a false-positive in Coverity.

Seems nobody cared enough to send a patch, so yes, let's mark it as a
false positive.

Kevin


