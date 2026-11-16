Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6210606A329
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WZ61zq4z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3RQ-0002zd-Ta; Mon, 16 Nov 2026 15:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT3RD-0002kG-Bj
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:36:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT3R3-0003fv-NN
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794861374;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bIs0jS684ITcf8dmiHMeRJSiRYcyA8wpA7PoKdQmSl0=;
 b=WZ61zq4zanDxE2pSDwxGjkYidOOGJV1bq224bFlCebFxnFDfV+o4Fsgx7jGC63yipFVoQF
 /fQubciIUZp/rCn/7UqHAHIEEHGqPxCjS4cY12wewYwo3JSOKvcIisDP2YUR63rhluNn4J
 OviADwELc+FpzllUUZeBzLDMTykAvxs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-aCcjy9AvM4COabVXoy-XFQ-1; Mon,
 16 Nov 2026 15:36:13 -0500
X-MC-Unique: aCcjy9AvM4COabVXoy-XFQ-1
X-Mimecast-MFC-AGG-ID: aCcjy9AvM4COabVXoy-XFQ_1794861372
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2AD61955F07; Mon, 16 Nov 2026 20:36:11 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75CFD1801975; Mon, 16 Nov 2026 20:36:10 +0000 (UTC)
Date: Mon, 16 Nov 2026 20:36:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH 01/48] iotests: better heuristics to find I/O tests
 build/source dirs
Message-ID: <avtpN44dtInQy0_t@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-2-berrange@redhat.com>
 <629c6ab4-7ea6-4209-8404-39eb8274249c@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <629c6ab4-7ea6-4209-8404-39eb8274249c@oss.qualcomm.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 12:28:40PM -0800, Pierrick Bouvier wrote:
> On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> > Currently the I/O tests cannot be run if executing directly
> > from the source directory, even when wrapped by the 'run'
> > script, due to inadequate heuristics to guess the directories.
> > 
> > If using the 'run' script, meson can tell us exactly where the
> > top level build and source directories are, so we don't need
> > to guess. Just read MESON_BUILD_ROOT and MESON_SOURCE_ROOT
> > env variables if present.
> > 
> > If not using the 'run' script, we can do a bit better at
> > guessing the path from the 'check' filename. Always resolve
> > from sys.argv[0], even when it is not a symlink, instead of
> > falling back to 'cwd()' which doesn't work since we stopped
> > having in-tree builds. If invoked directly from the source
> > tree, guess that the build root is the default 'build' name
> > which often works.
> > 
> > With this change the following all work:
> > 
> > 1. From root of build dir, with run script
> > 
> >   cd build
> >   ./run tests/qemu-iotests/check 5
> > 
> > 2. From root of build dir, without run script
> > 
> >   cd build
> >   tests/qemu-iotests/check 5
> > 
> > 3. From I/O tests subdir of build dir, with run script
> > 
> >   cd build/tests/qemu-iotests
> >   ../../run ./check 5
> > 
> > 4. From I/O tests subdir of build dir, without run script
> > 
> >   cd build/tests/qemu-iotests
> >   ./check 5
> > 
> > 5. From root of source dir, with run script
> > 
> >   ./build/run tests/qemu-iotests/check 5
> > 
> > 6. From root of source dir, without run script
> > 
> >   tests/qemu-iotests/check 5
> > 
> > 7. From I/O tests subdir of source dir, with run script
> > 
> >   cd tests/qemu-iotests
> >   ../../build/run ./check 5
> > 
> > 8. From I/O tests subdir of source dir, without run script
> > 
> >   cd tests/qemu-iotests
> >   ./check 5
> > 
> > Before this commit, items 5-8 would always fail. Items 6 and
> > 8 will not work if using a build directory with a name other
> > than the default 'build'. For those scenarios use one of the
> > other 6 possible variants.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  meson.build              |  1 +
> >  tests/qemu-iotests/check | 52 +++++++++++++++++++++++++++++-----------
> >  2 files changed, 39 insertions(+), 14 deletions(-)
> > 
> 
> I'm not sure if this patch is a required change for current series, as
> it seems to be unrelated.

No, this was accidentally included - its already posted standalone.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


