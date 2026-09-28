Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D980AC9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB8nj-0000bG-KP; Mon, 28 Sep 2026 06:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xB8nh-0000Yk-QO
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xB8nf-0004mx-On
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790592094;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rjD4aS40N3CTPl7tUeTETNyRpLZmMDUwV+feyhBENKk=;
 b=RImuDzDITG1lVHxkWw37wg2G0rBAvENwSe1wyxB88Ftmq/RJcw0CL1quPcHL2ANJxbnDpM
 1Wwh7D822nRCrRsMTHNKGi9PNy5mhTfwmBL+aFxiij++m5GoUijXov5jtxpeAdC/jrINw9
 EX1tvGEQZ3a7W1lxfHyaCqKxXaZkBhY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-mDWK11MuOpSl66rUzktKWw-1; Mon,
 28 Sep 2026 06:41:31 -0400
X-MC-Unique: mDWK11MuOpSl66rUzktKWw-1
X-Mimecast-MFC-AGG-ID: mDWK11MuOpSl66rUzktKWw_1790592090
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09B251956078; Mon, 28 Sep 2026 10:41:30 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E955E30000E4; Mon, 28 Sep 2026 10:41:28 +0000 (UTC)
Date: Mon, 28 Sep 2026 11:41:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [RFC PATCH 07/14] qemu-options: Consolidate qemu_opts_parse*
 functions
Message-ID: <arpEVnVooIuFzKgr@redhat.com>
References: <20260918223002.1892021-1-farosas@suse.de>
 <20260918223002.1892021-8-farosas@suse.de>
 <arZLO5A3S5A_2yE3@redhat.com> <87qzih8qtb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87qzih8qtb.fsf@suse.de>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 25, 2026 at 09:21:20AM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Fri, Sep 18, 2026 at 07:29:54PM -0300, Fabiano Rosas wrote:
> >> The qemu_opts_parse, qemu_opts_parse_list and qemu_opts_parse_noisily
> >> functions all call opts_parse(), they can reuse code.
> >> 
> >> Consolidate them at qemu_opts_parse_list(). Use the presence of the
> >> Error pointer to determine whether the caller wants to be noisy: if
> >> there is an Error pointer, then use it, otherwise print the message.
> >> 
> >> This makes the code more opaque, so keep the qemu_opts_parse and
> >> qemu_opts_parse_noisily functions as wrappers to make sure the intent
> >> at the callers is still clear.
> >
> > It is also somewhat differnt from the normal semantics in QEMU.
> >
> > The behaviour of passing NULL for an "Error **errp" parameter
> > indicates that the errors are to be ignored/discarded.
> >
> > This patch introduces atypical semantics, that the errors must
> > be printed, so I'm not entirely convinced this patch is a win.
> >
> 
> I understand. This is the main reason why this series is RFC. I could
> exchange the implicit "pass NULL to mean noisily" with an explicit
> parameter 'bool noisily'.

I think is to better to have full separation between code that
propagates an Error **errp back to the caller, vs code that
reports the error to the user. A "bool noisily" would be mixing
the two. I'd stil go for some duplication of error reporting
logic in the callers, together with the main APIs always using
the errp parameter.



> 
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  tests/unit/test-opts-visitor.c |  2 +-
> >>  util/qemu-option.c             | 32 ++++++++++++++++++--------------
> >>  2 files changed, 19 insertions(+), 15 deletions(-)
> >
> >> diff --git a/util/qemu-option.c b/util/qemu-option.c
> >> index bb38d305c9..c8e552823b 100644
> >> --- a/util/qemu-option.c
> >> +++ b/util/qemu-option.c
> >> @@ -938,7 +938,23 @@ QemuOpts *qemu_opts_parse(const char *group, const char *params,
> >>  QemuOpts *qemu_opts_parse_list(QemuOptsList *list, const char *params,
> >>                                 bool permit_abbrev, Error **errp)
> >>  {
> >> -    return opts_parse(list, params, permit_abbrev, false, false, errp);
> >> +    bool noisily = !errp;
> >> +    QemuOpts *opts = NULL;
> >> +
> >> +    if (noisily) {
> >> +        Error *err = NULL;
> >> +        bool help_wanted = !opts_accepts_any(list);
> >> +
> >> +        opts = opts_parse(list, params, permit_abbrev, true, help_wanted, &err);
> >> +        if (!opts && err) {
> >> +            error_report_err(err);
> >> +        }
> >> +
> >> +    } else {
> >> +        opts = opts_parse(list, params, permit_abbrev, false, false, errp);
> >> +    }
> >> +
> >> +    return opts;
> >>  }
> >>  
> >>  /**
> >> @@ -952,19 +968,7 @@ QemuOpts *qemu_opts_parse_list(QemuOptsList *list, const char *params,
> >>  QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list, const char *params,
> >>                                    bool permit_abbrev)
> >>  {
> >> -    Error *err = NULL;
> >> -    QemuOpts *opts;
> >> -    bool help_wanted = !opts_accepts_any(list);
> >> -
> >> -    opts = opts_parse(list, params, permit_abbrev, true, help_wanted, &err);
> >> -    if (!opts) {
> >> -        if (help_wanted) {
> >> -            assert(!err);
> >> -        } else {
> >> -            error_report_err(err);
> >> -        }
> >> -    }
> >> -    return opts;
> >> +    return qemu_opts_parse_list(list, params, permit_abbrev, NULL);
> >>  }
> >>  
> >>  static bool qemu_opts_from_qdict_entry(QemuOpts *opts,
> >> -- 
> >> 2.53.0
> >> 
> >> 
> >
> > With regards,
> > Daniel
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


