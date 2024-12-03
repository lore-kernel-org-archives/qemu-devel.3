Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF00E64A87
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 12:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIS3Z-0006Fw-WE; Tue, 03 Dec 2024 07:31:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIS3V-0006FH-H0
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 07:31:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIS3T-0000BJ-I4
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 07:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733229061;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6cpQFTA2BF9+klYfKL9FlmwQ6lgl6kKlJpFFDMlYwyY=;
 b=dYwJRLhmwBbpQpXvkjjG4yGT59DO+7rg6KixbKsECRXn5kJ+WbEjv+mVVIAyzFjMtG4hks
 dlqQsuwU2coR0a7p8yb245nipuaeOKtuV5+ttwTWoc58iCIhZvBglc/H/eExRhTyfF7rwr
 k9Xzsl/f6nuj9U9TfQRMDCwEGyulsoI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-whFSqmr3OMaNBf5lrJgrrA-1; Tue,
 03 Dec 2024 07:30:58 -0500
X-MC-Unique: whFSqmr3OMaNBf5lrJgrrA-1
X-Mimecast-MFC-AGG-ID: whFSqmr3OMaNBf5lrJgrrA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB4AB19560AB; Tue,  3 Dec 2024 12:30:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.37])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5E4819560A3; Tue,  3 Dec 2024 12:30:53 +0000 (UTC)
Date: Tue, 3 Dec 2024 12:30:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, Yong Huang <yong.huang@smartx.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/5] Guestperf: miscellaneous refinement and enrichment
Message-ID: <Z075-ZPW9dzzCKJn@redhat.com>
References: <cover.1729562974.git.yong.huang@smartx.com>
 <87sesmdfl4.fsf@suse.de>
 <CAK9dgmZvj4W2EBxp1_TcdYs3q2aqaRZGZCAk=FRJk-PaB9y_fw@mail.gmail.com>
 <87v7w6jkc9.fsf@suse.de> <87plmejgtb.fsf@suse.de>
 <CAK9dgmbHL+O34+E3ykDdAunap+Ruubm7ysisrMags6TN25BiNQ@mail.gmail.com>
 <Z04PTe4kCVWEQbPL@x1n> <Z06866qR0z9n2BgP@redhat.com>
 <875xo1j6ub.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875xo1j6ub.fsf@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Dec 03, 2024 at 09:20:44AM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Mon, Dec 02, 2024 at 02:49:33PM -0500, Peter Xu wrote:
> >> On Sat, Nov 30, 2024 at 10:01:43PM +0800, Yong Huang wrote:
> >> > On Fri, Nov 29, 2024 at 9:44 PM Fabiano Rosas <farosas@suse.de> wrote:
> >> For the stress.c warnings/error, I saw another one warning with gcc when
> >> built it locally, then I found Fabiano's CI run also has it:
> >> 
> >> https://gitlab.com/farosas/qemu/-/jobs/8504697347
> >> 
> >> Which has:
> >> 
> >> [3381/3611] Linking target tests/migration/stress
> >> /usr/bin/ld: /usr/lib64/libglib-2.0.a(gutils.c.o): in function `g_get_user_database_entry':
> >> (.text+0xeb): warning: Using 'getpwnam_r' in statically linked applications requires at runtime the shared libraries from the glibc version used for linkign
> >> /usr/bin/ld: (.text+0x2be): warning: Using 'getpwuid' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
> >> /usr/bin/ld: (.text+0x134): warning: Using 'getpwuid_r' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
> >> 
> >> Feel free to look at it too if you like. Nothing should be relevant to your
> >> changes, so I think it could be there for a while when compilers upgrade.
> >
> > Those messages are mostly harmless, especially in the stress scenario, and
> > can't practically be eliminated:
> >
> >   https://gitlab.gnome.org/GNOME/glib/-/issues/2019
> 
> Although harmless, we can't have them showing up during the
> build. Should we go back to not building stress.c by default? Another
> option (which I prefer) would be to stop using glib in stress.c, it
> doesn't look like it would be much work to do that. 

FYI they already show up in QEMU builds if you are building qemu-user as
static binaries, which is what you want for binfmt usage.  The main
diff is that in this case they'll show up by default for anyone who has
glib-static available.  Is that a big problem ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


