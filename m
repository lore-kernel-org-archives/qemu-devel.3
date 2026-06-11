Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8CECD98CF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 16:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXiAS-0001i1-OK; Thu, 11 Jun 2026 12:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wXiAR-0001hs-Bi
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 12:22:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wXiAP-0006WQ-Ko
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 12:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781194923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ldkCrgwh3yGpQp8T55KrgPd/6vnsGDVpj7qCK6x+D0k=;
 b=aBKXDWIQ+WG49Fp2ItevTYOy/FPljuJgIpAWc1moWpwmKmS020ZVTQG6gZ5puhtbFZNe/7
 7M2jvim8NptePWJLvSDpT+wguww9Qdj9mIsI7V2QJlkPBHZbhobd5sws+mhWV/Hgmo4y/R
 QfsxRo7k85s3FRcofuTfuCfYCeqt7xA=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-Mp4kLehVNuOeLhY7P0bHpA-1; Thu, 11 Jun 2026 12:22:02 -0400
X-MC-Unique: Mp4kLehVNuOeLhY7P0bHpA-1
X-Mimecast-MFC-AGG-ID: Mp4kLehVNuOeLhY7P0bHpA_1781194922
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-963d7e5ac77so3487045241.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 09:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781194921; x=1781799721; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ldkCrgwh3yGpQp8T55KrgPd/6vnsGDVpj7qCK6x+D0k=;
 b=OPwpaRBuWEgKbt0RNP+/9z/IqKBaqJKZAiNEKE0mHdSkP52ZufwIVVUk9TVD2tW1dZ
 qmO2B6+Ru+xyMSt6Y9pStxiYmvcbUSg1JA9IfF7dBaoKZlTj5cBKJAZtX2J/3OPJkcAw
 38NJeRCxE5Z6qc9jFT/51O2omFuJ6Bz8+nwVno4Ofzeo65vpdt4n4RJZBwabldORvzhy
 13k+pYCRW6xNNX3jY1DczMdAFsFXOiQDsUB3/SCW68gmYUk+BjLRRlH6Rx5zOWZ3HvhY
 LJW1QHbTvdntEh3cr2PEliK9RZ8VrXim1dZczXPRhno9+kVAA32pxLJfc0qqu2L+gJqJ
 PzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781194921; x=1781799721;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ldkCrgwh3yGpQp8T55KrgPd/6vnsGDVpj7qCK6x+D0k=;
 b=NbkTyNOg7wSxdAjFQDrptm6mTvJFnmoKkwZ5emF4yUAJ/1t6DXREL8n0bWAA7+jzfR
 kHukvZsoDy83p23Gp2L2w0zkkvPQadzFm0VslP7iuwNLYjtPtYSKla73iwlJznU1gOOM
 3MBnX4nETbsMyCm7vLyD6C1sZ0tgSkVIrqSfh4KWsDiDpfi1I4oBaMGqW2Y2zY4zyqe+
 LJk6oRdsdg7ferJQb1FrUCKpMYuCU5XNg+GWZj/0tOkQOwlS8VovEwZtTf15vdApESc4
 yJZRZsmzzg7gLY0HdM4vJ+nFKbYYalC4Yu33kaVI2QzP+zDUUdNodQq6HfhouMbUra16
 fPGg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GP2ynCgd4MHC5uO/v2ZoJ+g9+6GJKJPEQlcx9NoKidIZ5dLUsd9Ezdc/6wXMoBw1U93QrPZBDFo3x@nongnu.org
X-Gm-Message-State: AOJu0YyH4EdBURmjybMX97H/NTmc5gmoqn6JDEVIQUjzyoFAJzMOqkrQ
 w0KgOJ1r8XfvXGbnhb+iH4SeLRXofaIMg+8BtzarGR7Nl8hNrkgh7jBaRIQXXA8MQ2rTnztSjac
 YRTCX9QXj5RoSkmoPtz2GxY9mPtLVkmKnX3iDd69QAL5PJJ+NOU3siaMv
X-Gm-Gg: Acq92OFnJ1DxeHiol/SG5+WSWliQcQDl+cgpBwNt5x/Nw1QlLLYr9CvhSo12v/Rkhrc
 JyYhNYVJEjj14zpipmwsRZoDXdbU9GHu1ITKJVx22cN4Yjq71pkMJvJCD5LyscCDEaNpecDvYxw
 R3fzc+Jcz7u82U/DO/Fbvr/2EGh0DM4VSCppOyL9zve07PXOiXt3oeT+ceyFIB6OxOwUf8vFBFr
 h0P2ZfjErFw7w4UEO0ruQbaWh9Ic7LtWi21Huy7EX1lfZjYjf5GsI7nfIYd7qdcj6BJ6yuFDZJf
 I0T589Lo6GtZM4WVsH8589yn3TNLacdYoQ4TJFqApvQZfx/mXAXkLgiDFu7GOXYftccUclIwTbi
 tGWUlc6AHpNCcepU=
X-Received: by 2002:a05:6102:4bc5:b0:631:af51:7d8e with SMTP id
 ada2fe7eead31-71d5b83eaa9mr2004922137.17.1781194921500; 
 Thu, 11 Jun 2026 09:22:01 -0700 (PDT)
X-Received: by 2002:a05:6102:4bc5:b0:631:af51:7d8e with SMTP id
 ada2fe7eead31-71d5b83eaa9mr2004813137.17.1781194920599; 
 Thu, 11 Jun 2026 09:22:00 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d1e7bc2707sm21911176d6.8.2026.06.11.09.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 09:21:59 -0700 (PDT)
Date: Thu, 11 Jun 2026 12:21:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: infra.ai.cloud@bitdeer.com, qemu-devel@nongnu.org,
 Hyman Huang <yong.huang@bitdeer.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 0/1] dirtylimit improvement
Message-ID: <airgpjWeo4bHHve-@x1.local>
References: <cover.1781095539.git.yong.huang@bitdeer.com>
 <CAJSP0QU_tx+ygBJZG-vWdTK0ec+NVtiSaVnt-6FMdV1nsw9tpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QU_tx+ygBJZG-vWdTK0ec+NVtiSaVnt-6FMdV1nsw9tpQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 11, 2026 at 11:18:53AM -0400, Stefan Hajnoczi wrote:
> On Wed, Jun 10, 2026 at 9:15 PM <infra.ai.cloud@bitdeer.com> wrote:
> >
> > From: Hyman Huang <yong.huang@bitdeer.com>
> 
> Hi Hyman Huang,
> Is this pull request intended for qemu.git/master?
> 
> I did not see any previous pull requests from you in QEMU's git log.
> It looks like your previous dirtylimit work went through the migration
> tree. Do you intend to start sending pull requests now and are the
> migration maintainers aware?

We're not..

Since dirtylimit is almost only used with migration, Hyman, do you want us
to keep sending pulls for you?  I think it's better we're copied on all
these changes at the very minimum.

The other thing about the pull I want to say is, that patch changed most on
KVM not dirtylimit: v2 sent on June 4th and planned to be merged today
without maintainer's ACK (in this case Paolo, I added into the loop), I
think that's a bit too rush.  Shall we still at least give Paolo some time
in case he wants to say something?

Paolo might be busy and may respond slow, normally what I do is keep
pinging if the patch is important; if not, I leave a patch there until it
becomes more important..  I suggest we do the same for this patch rather
than merging it without Paolo even noticing.

Logically the bare minimum is that patch gets an A-b from Paolo to merge
it.

Thanks,

> 
> Please follow the pull request process and sign your pull request with
> your GPG key:
> https://www.qemu.org/docs/master/devel/submitting-a-pull-request.html
> 
> Thanks,
> Stefan
> 
> >
> > The following changes since commit de5d8bfd6105d3dd3ae668df9762df244a6d1506:
> >
> >   Merge tag 'pull-loongarch-20260609' of https://github.com/gaosong715/qemu into staging (2026-06-09 14:00:28 -0400)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/newfriday/qemu.git tags/dirtylimit-dirtyrate-pull-request-20260611
> >
> > for you to fetch changes up to 3b224b1c7df1ddefd6bca34f201264d72846c397:
> >
> >   accel/kvm: event-driven wakeup for dirty ring reaper thread (2026-06-11 08:22:50 +0800)
> >
> > ----------------------------------------------------------------
> > dirtylimit: refactor dirty ring reaper thread with event-driven wakeup
> >
> > ----------------------------------------------------------------
> > Bin Guo (1):
> >       accel/kvm: event-driven wakeup for dirty ring reaper thread
> >
> >  accel/kvm/kvm-all.c      | 42 ++++++++++++++++++++++++++++++++++------
> >  accel/stubs/kvm-stub.c   |  4 ++++
> >  include/system/kvm.h     |  7 +++++++
> >  include/system/kvm_int.h |  3 +++
> >  system/dirtylimit.c      |  2 ++
> >  5 files changed, 52 insertions(+), 6 deletions(-)
> >
> > --
> > 2.43.0
> >
> >
> 

-- 
Peter Xu


