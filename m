Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B68DCC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGZeZ-0005j6-R5; Tue, 13 Oct 2026 06:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGZeV-0005ho-Oc
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGZeT-0002Ct-CI
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791886951;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k+2gg7V8ZCLPWTIrRkvZPIfUgHqFet0vcLTzFdC5pxQ=;
 b=KjlL/byhBOJG6ZFb1Uy9msU8xWqDGU8GPfVKTn7MBVW2wXJLPi8m9cGpR4XKB8CrtczK7t
 /uxdGeLiWdL/S28cKKn5E9PxIAATZdqMpEjqRcumsI97vvOyD6S03jd2W+WHqZ39b61aGR
 NYBHGYFIOP5F1XGoDDm1Nfd0/b43Edk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-Bev0v3BvN3W36Ngp4xpuTQ-1; Tue,
 13 Oct 2026 10:22:22 +0000
X-MC-Unique: Bev0v3BvN3W36Ngp4xpuTQ-1
X-Mimecast-MFC-AGG-ID: Bev0v3BvN3W36Ngp4xpuTQ_1791886940
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D93918301B8; Tue, 13 Oct 2026 10:22:19 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BED46180034C; Tue, 13 Oct 2026 10:22:11 +0000 (UTC)
Date: Tue, 13 Oct 2026 11:22:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Kyle Evans <kevans@freebsd.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, Ani Sinha <anisinha@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Warner Losh <imp@bsdimp.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Peter Xu <peterx@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Song Gao <gaosong@loongson.cn>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v2 06/16] tests/functional: update x86_64 tuxrun images
Message-ID: <as4GUPxcBErUbxvJ@redhat.com>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
 <20261012170330.1144446-7-alex.bennee@linaro.org>
 <as3mM9XesjzPA0o4@redhat.com> <87cxtegcy6.fsf@draig.linaro.org>
 <as3_pJ-KTtbVMilK@redhat.com> <871p9thpvg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871p9thpvg.fsf@draig.linaro.org>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 13, 2026 at 11:11:15AM +0100, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Oct 13, 2026 at 10:35:45AM +0100, Alex Bennée wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> 
> >> > On Mon, Oct 12, 2026 at 06:03:20PM +0100, Alex Bennée wrote:
> >> >> We now split the fetching of the buildroot image from the kernel
> >> >> itself. This is because we will want to access additional metadata in
> >> >> future tests.
> >> >
> >> > This commit message appears unrelated to the patch content or subject
> >> > line.
> >> 
> >> The kernel is now coming from: https://storage.tuxboot.com/kernels/6.18.54/
> >> instead of part of the buildroot build in https://storage.tuxboot.com/buildroot/20260924/x86_64/
> >
> > Ah ok, I misunderstood what the commit message was trying to say,
> > though I'm still underclear how the before/after  bzImage differ
> > from each other ?
> >
> > Is the  https://storage.tuxboot.com/kernels/6.18.54/ the
> > authoritative input for the process that produces
> >  https://storage.tuxboot.com/buildroot/20260924/x86_64/  ?
> 
> No - they are different builds, but the kernel builds have had the
> symbol generation turned on and the buildroot images are generic anyway
> which is why they still work together.

Ok, anyway, no objection to the patch. Just expand on the
commit message little in any way you feel is useful. No
need for me to re-review it.

> 
> >
> > I see the later patch is pulling in vmlinuz.xz from the
> > former location, so I guess you're trying to just use
> > the common location for both kernel images ? 
> >
> >> 
> >> >
> >> >> 
> >> >> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> >> >> Message-ID: <20260930164649.433573-10-alex.bennee@linaro.org>
> >> >> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> >> >> ---
> >> >>  tests/functional/x86_64/test_tuxrun.py | 8 ++++----
> >> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >> >> 
> >> >> diff --git a/tests/functional/x86_64/test_tuxrun.py b/tests/functional/x86_64/test_tuxrun.py
> >> >> index 729f6447d05..026b373accb 100755
> >> >> --- a/tests/functional/x86_64/test_tuxrun.py
> >> >> +++ b/tests/functional/x86_64/test_tuxrun.py
> >> >> @@ -17,11 +17,11 @@
> >> >>  class TuxRunX86Test(TuxRunBaselineTest):
> >> >>  
> >> >>      ASSET_X86_64_KERNEL = Asset(
> >> >> -        'https://storage.tuxboot.com/buildroot/20241119/x86_64/bzImage',
> >> >> -        'f57bfc6553bcd6e0a54aab86095bf642b33b5571d14e3af1731b18c87ed5aef8')
> >> >> +        'https://storage.tuxboot.com/kernels/6.18.54/x86_64/bzImage',
> >> >> +        '24a3ade610c2cc426ff821050de8a35930b0371357d94cc2c334abac6658552b')
> >> >>      ASSET_X86_64_ROOTFS = Asset(
> >> >> -        'https://storage.tuxboot.com/buildroot/20241119/x86_64/rootfs.ext4.zst',
> >> >> -        '4b8b2a99117519c5290e1202cb36eb6c7aaba92b357b5160f5970cf5fb78a751')
> >> >> +        'https://storage.tuxboot.com/buildroot/20260924/x86_64/rootfs.ext4.zst',
> >> >> +        '8e310455b0244414ccff29c507f7ccfd4032e3587cc405e49ab0322738e3e27c')
> >> >>  
> >> >>      def test_x86_64(self):
> >> >>          self.require_accelerator("tcg")
> >> >> -- 
> >> >> 2.47.3
> >> >> 
> >> >
> >> > With regards,
> >> > Daniel
> >> 
> >> -- 
> >> Alex Bennée
> >> Virtualisation Tech Lead @ Linaro
> >> 
> >
> > With regards,
> > Daniel
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


