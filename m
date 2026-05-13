Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC05CD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 17:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNDBQ-0002JL-Ny; Wed, 13 May 2026 13:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wNDBO-0002I7-UU
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:15:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wNDBM-0005Y0-PF
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778692538;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DEkYIQwuBFwMyyJvyGcLVBmEg4vEVNkY/9fZIdak3j0=;
 b=KpRoo/aT52uyGU6ydzXaM95QFvpu+q6cfFZEokMEpuDW6p4eIMVcVF9fvXyBcA56SxXxQy
 VLiuZMGLBi+Ke1hZSetLm5/YdIRYC/lZ7YApOf6VrFlhRIuvFrIugICx9muGn/Yaz/XZrd
 J2qs5VS33MADuK2BI5vtIi8K1CiTAr4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-KGb8qfMTOOKRG4B2dJSXNg-1; Wed,
 13 May 2026 13:15:34 -0400
X-MC-Unique: KGb8qfMTOOKRG4B2dJSXNg-1
X-Mimecast-MFC-AGG-ID: KGb8qfMTOOKRG4B2dJSXNg_1778692532
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52C1018005B3; Wed, 13 May 2026 17:15:32 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.213])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C2C018004A3; Wed, 13 May 2026 17:15:28 +0000 (UTC)
Date: Wed, 13 May 2026 18:15:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 07/16] scripts/mtest2make: support optional tests grouping
Message-ID: <agSxrJ8kW0xEYaQa@redhat.com>
References: <20260424154205.364268-1-berrange@redhat.com>
 <20260424154205.364268-8-berrange@redhat.com>
 <170b791e-ee66-4d7a-80d0-5c959c9ff359@oss.qualcomm.com>
 <agRNn9JP_THW6cgV@redhat.com>
 <a9cbb995-efff-4681-8936-ad91aa246617@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9cbb995-efff-4681-8936-ad91aa246617@oss.qualcomm.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, May 13, 2026 at 08:49:39AM -0700, Pierrick Bouvier wrote:
> On 5/13/2026 3:08 AM, Daniel P. Berrangé wrote:
> > On Tue, May 12, 2026 at 08:45:42AM -0700, Pierrick Bouvier wrote:
> >> On 4/24/2026 8:41 AM, Daniel P. Berrangé wrote:
> >>> Currently tests can be classified into three speed groups depending on
> >>> whether the meson suite name ends in '-slow' or '-thorough' or neither.
> >>>
> >>> This gets turned into make targets that match the name of the meson
> >>> suite, with the speed suffix stripped. e.g.
> >>>
> >>>  * suite=block ->  'make check-block'
> >>>  * suite=block-slow -> 'make check-block SPEED=slow'
> >>>  * suite=block-thorough -> 'make check-block SPEED=thorough'
> >>>
> >>> The set of tests under the "thorough" speed, however, can get rather
> >>> large and it would be useful to have a way to expose further make
> >>> targets for directly running a particular subset of tests.
> >>>
> >>> This needs a way to run a target without requiring the SPEED variable,
> >>> while also not having them enabled by default as if they were 'quick'
> >>> tests.
> >>>
> >>> This modifies mtest2make.py to support this idea by allowing for a new
> >>> suffix '-optional' on a suite. When this is present, a correspondingly
> >>> named make target will be created without the '-optional' suffix which
> >>> will never be run automatically.
> >>>
> >>> This is intended to be combined with use of other suites. For example,
> >>> a single NBD test might be added to two suites, 'block-thorough' and
> >>> 'block-nbd-optional'.
> >>>
> >>> This would allow running it as part of all the block tests with
> >>> 'make check-block SPEED=thorough', and as part of a standalone target
> >>> 'make check-block-nbd'.
> >>>
> >>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> >>> ---
> >>>  scripts/mtest2make.py | 22 +++++++++++++++-------
> >>>  1 file changed, 15 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
> >>> index 915f02d600..383ea68b16 100644
> >>> --- a/scripts/mtest2make.py
> >>> +++ b/scripts/mtest2make.py
> >>> @@ -22,7 +22,7 @@ def names(self, base):
> >>>  print(r'''
> >>>  SPEED = quick
> >>>  
> >>> -.speed.quick = $(sort $(filter-out %-slow %-thorough, $1))
> >>> +.speed.quick = $(sort $(filter-out %-slow %-thorough %-optional, $1))
> >>>  .speed.slow = $(sort $(filter-out %-thorough, $1))
> >>>  .speed.thorough = $(sort $1)
> >>>  
> >>> @@ -66,10 +66,15 @@ def process_tests(test, targets, suites):
> >>>              s = s[:-9]
> >>>              suites[s].speeds.add('thorough')
> >>>  
> >>> +def target_name(suite):
> >>> +    if suite.endswith('-optional'):
> >>> +        return suite[0:-9]
> >>> +    return suite
> >>> +
> >>>  def emit_prolog(suites, prefix):
> >>> -    all_targets = ' '.join((f'{prefix}-{k}'
> >>> +    all_targets = ' '.join((f'{prefix}-{target_name(k)}'
> >>>                              for k in sorted(suites.keys())))
> >>> -    all_xml = ' '.join((f'{prefix}-report-{k}.junit.xml'
> >>> +    all_xml = ' '.join((f'{prefix}-report-{target_name(k)}.junit.xml'
> >>>                          for k in sorted(suites.keys())))
> >>>      print()
> >>>      print(f'all-{prefix}-targets = {all_targets}')
> >>> @@ -83,14 +88,17 @@ def emit_prolog(suites, prefix):
> >>>      print(f'\t$(MAKE) {prefix}$* MTESTARGS="$(MTESTARGS) --logbase {prefix}-report$*" && ln -f meson-logs/$@ .')
> >>>  
> >>>  def emit_suite(name, suite, prefix):
> >>> +    tgtname = target_name(name)
> >>>      deps = ' '.join(sorted(suite.deps))
> >>>      print()
> >>> -    print(f'.{prefix}-{name}.deps = {deps}')
> >>> -    print(f'.ninja-goals.check-build += $(.{prefix}-{name}.deps)')
> >>> +    print(f'.{prefix}-{tgtname}.deps = {deps}')
> >>> +    print(f'.ninja-goals.check-build += $(.{prefix}-{tgtname}.deps)')
> >>>  
> >>>      names = ' '.join(sorted(suite.names(name)))
> >>> -    targets = f'{prefix}-{name} {prefix}-report-{name}.junit.xml'
> >>> -    if not name.endswith('-slow') and not name.endswith('-thorough'):
> >>> +    targets = f'{prefix}-{tgtname} {prefix}-report-{tgtname}.junit.xml'
> >>> +    if not name.endswith('-slow') and \
> >>> +       not name.endswith('-thorough') and \
> >>> +       not name.endswith('-optional'):
> >>>          targets += f' {prefix} {prefix}-report.junit.xml'
> >>>      print(f'ifneq ($(filter {targets}, $(MAKECMDGOALS)),)')
> >>>      # for the "base" suite possibly add FOO-slow and FOO-thorough
> >>
> >> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> >>
> >> Not blocking this patch, thus reviewed, but I think it would be a better
> >> abstraction to use meson suites for this (a test can be added in
> >> multiple suites), instead of adding more clunk to makefile layer.
> > 
> > This *is* using meson suites. The mtest2make script takes the list
> > of meson suites and generates makefile targets which can be used to
> > select execution of the meson suites. This change is exposing more
> > of the suites as makefile targets, since make is our primary entry
> > point.
> > 
> > 
> > With regards,
> > Daniel
> 
> Maybe I can't read this patch correctly, but from it, and the message
> description, I understand that -optional is a pure Makefile abstraction,
> and does not reflect any real meson suite.

Actually its the other way around. In the next patch in this series
we create meson suites like  "block-nbd-optional" and that gets turned
into a makefile target  "check-block-nbd". The "optional" part of the
meson suite name determines that "check-block-nbd" is NOT added as a
depedency of "check".  IOW, it doesn't get run by "make check", but
must be optionally run through "make check-block-nbd" when needed.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


