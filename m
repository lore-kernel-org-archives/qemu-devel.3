Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FD1C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 22:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7iFB-00052d-1o; Wed, 23 Apr 2025 18:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u7iF9-00051w-BE
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 18:07:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u7iF7-0004sM-Bg
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 18:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745446014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9s8hsTUAAoszKH0q2fwHJ0Ib5ojMKdaBmEb8j4/Avo=;
 b=NlrTPDYyIA12tPq8wTDq5d4iFJOKH+8h20AC1LC944Aip8ErUTipfdZ/cHqqdDX0US9nQ8
 ou58zLHqKuQ75fhlJUUNwc1SsglqoCI2vFC1NKD8FcpyGR/+aYDlNwiEiQZ8OHmIy9MoR0
 R1ct34c7rGHdmeU8Lj5YNESK6/uSqnk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-6VyLsAq6P8-T0TeM_7M8MQ-1; Wed, 23 Apr 2025 18:05:44 -0400
X-MC-Unique: 6VyLsAq6P8-T0TeM_7M8MQ-1
X-Mimecast-MFC-AGG-ID: 6VyLsAq6P8-T0TeM_7M8MQ_1745445944
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4769a1db721so7014721cf.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 15:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745445943; x=1746050743;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v9s8hsTUAAoszKH0q2fwHJ0Ib5ojMKdaBmEb8j4/Avo=;
 b=Tv8iBdd/v2GZ/homHTCc9FyavazFHG1W5b9NSZ5qmQiFd2kjttDCvESm0+eAILjeW4
 XSnGxTFrfFMLbmAFGeoPW+xekeyGYuez/j015ktjJzbDgV80yrITDeBoWhwomHzJ6+Ct
 s0e94RRqbT7dvadUVlpmK5McvN/6Mfl4O3MBog19ZNErauYJhNtWkrVHKThRC2Mxf11l
 zbQUJ5vxvwIw8GaN+QRjpcSlmmODPwY+5u1JNYZbXAItZgdbcuyfx6UTz/GNHQyRv4nw
 AwVlsmkvAA1SnBU+ZpIEa6cPdgWipa+Db1sXmHfz5QoYswM1mdN2G6n3jVtgUuEHP1ZI
 wLMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkFPxy+iEXoZQiU25ciyVnMJCwzTs1p+aLQ5YDxQuD/7GHs13+BYHdZNoBuX8SshOaQGqbpKJsFIUs@nongnu.org
X-Gm-Message-State: AOJu0YzbpDoky5C39QQZMdWSAIit8pFWIzydhXw1VYrx1P2cAgkIDCxq
 6QeNL7nMyjM1zi13YszLnRAwOOYRW0BnTwYhndYqbyE4C1wVLoszmCgHvkw3cfWw5ikJpP48/TD
 axPag771Ge1+NV+UQfaNK1GvgNCqQYbsURr0kmPEIyiJ90uatMxLk
X-Gm-Gg: ASbGncvyjjB13e8MJIc44pHpAnY6b6cWdbLKpSt6UPIE57z2TBEInwhyaz4JtP0YDhA
 wBKCaDjvognJFZsf6kxIoQ5SqhL0gpJ4PeFXpogDWemnhM7cTezspY9+7dcKl3+oiUQCbuJFdgb
 t6a9MavtlIfEh+H6tQhKhpg9QkhE+blbwqvB7tH55JuPVDlfnykJ07Hqtxm2FdDaFD9oRf0jKvB
 KlZg23p4RISX882iQZQEBvvSm0kNqMdCUNZZCRMYaEC49P+6nta3pDA7h+0whFgSzYul50q0mjU
 KOA=
X-Received: by 2002:ac8:5896:0:b0:477:4213:33ff with SMTP id
 d75a77b69052e-47eb34ab6fcmr2379211cf.24.1745445942655; 
 Wed, 23 Apr 2025 15:05:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeSQkc3zc7f+mzcgFMoWtmV6Yx5KYPgHP9LC8Ht6oCz+6w26Db2QXrASD4EqSCSllFT2AMgg==
X-Received: by 2002:ac8:5896:0:b0:477:4213:33ff with SMTP id
 d75a77b69052e-47eb34ab6fcmr2378641cf.24.1745445941942; 
 Wed, 23 Apr 2025 15:05:41 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47ea1ba1576sm1488991cf.68.2025.04.23.15.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 15:05:41 -0700 (PDT)
Date: Wed, 23 Apr 2025 18:05:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Subject: Re: Migration compatibility test broken on major version releases
Message-ID: <aAlkMi_Vb8WNGGxd@x1.local>
References: <20250422154131.GA308586@fedora>
 <87bjsmerqx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bjsmerqx.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Apr 23, 2025 at 02:01:58PM -0300, Fabiano Rosas wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
> 
> > Hi Fabiano,
> > The build-previous-qemu job does not work when a new major version is
> > released:
> > https://gitlab.com/qemu-project/qemu/-/jobs/9788294494
> >
> 
> You might be using a slightly different workflow from Peter and Richard,
> I don't think this ever happened before. But that's totally fine, I'll
> change the job to behave better in that case.
> 
> > The previous version computation produces "v10.0.0" when testing:
> >
> >   $ export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v␁.0/' VERSION)"
> >   $ git remote add upstream https://gitlab.com/qemu-project/qemu
> >   $ git fetch upstream refs/tags/$QEMU_PREV_VERSION:refs/tags/$QEMU_PREV_VERSION
> >   warning: redirecting to https://gitlab.com/qemu-project/qemu.git/
> >   fatal: couldn't find remote ref refs/tags/v10.0.0
> >
> > The CI job runs before the v10.0.0 tag is pushed to the repo. (The tag
> > is only pushed once tests have passed.)
> >
> > Even if the tag was there and git fetch succeeded, the test would test
> > migration between v10.0.0 and v10.0.0, which doesn't seem to be the
> > purpose of the test.
> >
> 
> Yes, but since that one commit does not have any code anyway, we've
> decided to just let it run on the same version. The very next commit
> will be aligned again. Still, the time-of-tag issue was indeed an
> oversight.
> 
> > Please adjust the test to handle this situation. For now I will re-run
> > the job after pushing the final tag (since it already passed for the
> > release candidate tag).
> 
> Will do, thanks!

Just a quick thought - maybe we can add a rule (before the default rules in
the dependent job, so as to not get the last "when: always" trap it..) to
skip this job as long as the ending is .0 in VERSION.

Thanks,

-- 
Peter Xu


