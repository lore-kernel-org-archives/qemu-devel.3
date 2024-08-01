Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26337C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZSkn-0001at-MO; Thu, 01 Aug 2024 06:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZSkl-0001T7-K7
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:09:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZSkj-0007QU-IV
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722506985;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0VMI7Or2ebFT8na4YBzWTfxv52cy1HsikMjHoVlw5I=;
 b=RwqMeAJdZx08imjf/RBCpRsFfnsGtajV2A+1qqlfIb+TBb4RCAu2vXrnXwu/WUuga9n3yl
 2ynrSlP3wgQHlRV2CAfX75Mkahr8UzDakZS8zqVVeSASGjfNmTx4rZV+uGEButRZIrok7F
 Lj+dji61ACwT3uoqpWm0KsGY7PtdGgA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-M7EP8uTaOGuwQqRql5XTvA-1; Thu,
 01 Aug 2024 06:09:42 -0400
X-MC-Unique: M7EP8uTaOGuwQqRql5XTvA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 918021955D52; Thu,  1 Aug 2024 10:09:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.109])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37B541955F23; Thu,  1 Aug 2024 10:09:34 +0000 (UTC)
Date: Thu, 1 Aug 2024 11:09:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3 16/24] tests/functional: Convert the riscv_opensbi
 avocado test into a standalone test
Message-ID: <Zqte2ySm_scvu17t@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-17-berrange@redhat.com>
 <9fbf2f80-c7df-4819-8f74-c7ce75dc70a5@linaro.org>
 <42fb9582-9215-4ccc-bede-0c4f03fffd4c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42fb9582-9215-4ccc-bede-0c4f03fffd4c@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Aug 01, 2024 at 09:00:36AM +1000, Richard Henderson wrote:
> On 7/31/24 22:56, Philippe Mathieu-Daudé wrote:
> > On 30/7/24 19:03, Daniel P. Berrangé wrote:
> > > From: Thomas Huth <thuth@redhat.com>
> > > 
> > > The avocado test defined test functions for both, riscv32 and riscv64.
> > > Since we can run the whole file with multiple targets in the new
> > > framework, we can now consolidate the functions so we have to only
> > > define one function per machine now.
> > > 
> > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   tests/avocado/riscv_opensbi.py         | 63 --------------------------
> > >   tests/functional/meson.build           |  8 ++++
> > >   tests/functional/test_riscv_opensbi.py | 36 +++++++++++++++
> > >   3 files changed, 44 insertions(+), 63 deletions(-)
> > >   delete mode 100644 tests/avocado/riscv_opensbi.py
> > >   create mode 100755 tests/functional/test_riscv_opensbi.py
> > 
> > Please squash:
> > 
> > -- >8 --
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 98eddf7ae1..a906218f9d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -336,6 +337,7 @@ F: include/hw/riscv/
> >   F: linux-user/host/riscv32/
> >   F: linux-user/host/riscv64/
> >   F: tests/tcg/riscv64/
> > +F: tests/functional/test_riscv_opensbi.py
> 
> It seems worth taking this opportunity to add per-target subdirs of
> tests/functional/, so that we don't have to list every individual test in
> MAINTAINERS.
> 
> Surely one
> 
> F: tests/functional/riscv/
> 
> etc, is actually maintainable...

Either that or wildcard the filenames

 F: tests/functional/test_riscv_*


but subdirs matching the target is probably a little nicer to really
encourage people to follow conventions more strictly. We would also
need a "tests/functional/common/" for tests which aren't target specific

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


