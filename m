Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240A0606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FzMxHY+x
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTQ8t-00036A-1j; Tue, 17 Nov 2026 15:51:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xTQ8p-00035u-5b
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 15:50:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xTQ8n-0003VP-Iv
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 15:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794948656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VBpnx5DZX2wxRF0LwPjcyzkdln1I0Z8GXL3dwE3aNh0=;
 b=FzMxHY+xOHjqdUe97W95EDOyJObTTQmMxZ02lNKqkbkkG55URkqLOpUpMsoyjrubv5KW+o
 KZi5mHHdbKS8DFFfnM1Xw4dyWbIWOHO3928efsHrO+37IRQv/w2hKPLAmHr/tVLuAIxhsJ
 jX9MUcNp1pPvHRfsVxZAvqFRz8FwMeQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-ufir4woiN2ezXeiFc46T1w-1; Tue,
 17 Nov 2026 15:50:55 -0500
X-MC-Unique: ufir4woiN2ezXeiFc46T1w-1
X-Mimecast-MFC-AGG-ID: ufir4woiN2ezXeiFc46T1w_1794948654
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C826D19560A7; Tue, 17 Nov 2026 20:50:53 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.7])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 703B3421; Tue, 17 Nov 2026 20:50:52 +0000 (UTC)
Date: Tue, 17 Nov 2026 21:50:50 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, berrange@redhat.com
Subject: Re: [PULL 2/8] iotests: better heuristics to find I/O tests
 build/source dirs
Message-ID: <avy-KqXX-dDPwois@redhat.com>
References: <20261117171758.237462-1-kwolf@redhat.com>
 <20261117171758.237462-3-kwolf@redhat.com>
 <389c8700-e10f-4435-a815-2965136bf5a7@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <389c8700-e10f-4435-a815-2965136bf5a7@linaro.org>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 17.11.2026 um 21:06 hat Richard Henderson geschrieben:
> On 11/17/26 09:17, Kevin Wolf wrote:
> > From: Daniel P. Berrangé<berrange@redhat.com>
> > 
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
> >    cd build
> >    ./run tests/qemu-iotests/check 5
> > 
> > 2. From root of build dir, without run script
> > 
> >    cd build
> >    tests/qemu-iotests/check 5
> > 
> > 3. From I/O tests subdir of build dir, with run script
> > 
> >    cd build/tests/qemu-iotests
> >    ../../run ./check 5
> > 
> > 4. From I/O tests subdir of build dir, without run script
> > 
> >    cd build/tests/qemu-iotests
> >    ./check 5
> > 
> > 5. From root of source dir, with run script
> > 
> >    ./build/run tests/qemu-iotests/check 5
> > 
> > 6. From root of source dir, without run script
> > 
> >    tests/qemu-iotests/check 5
> > 
> > 7. From I/O tests subdir of source dir, with run script
> > 
> >    cd tests/qemu-iotests
> >    ../../build/run ./check 5
> > 
> > 8. From I/O tests subdir of source dir, without run script
> > 
> >    cd tests/qemu-iotests
> >    ./check 5
> > 
> > Before this commit, items 5-8 would always fail. Items 6 and
> > 8 will not work if using a build directory with a name other
> > than the default 'build'. For those scenarios use one of the
> > other 6 possible variants.
> > 
> > Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> > Message-ID:<20261111091133.3527549-1-berrange@redhat.com>
> > Reviewed-by: Kevin Wolf<kwolf@redhat.com>
> > Signed-off-by: Kevin Wolf<kwolf@redhat.com>
> > ---
> >   meson.build              |  1 +
> >   tests/qemu-iotests/check | 52 +++++++++++++++++++++++++++++-----------
> >   2 files changed, 39 insertions(+), 14 deletions(-)
> 
> Fails all of the block tests.  E.g.
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/18118947590#L135
> 
> >  === pylint ===
> > +************* Module check
> > +check:44:12: W0719: Raising too general exception: Exception (broad-exception-raised)
> > +check:44:28: W1309: Using an f-string that does not have any interpolated variables (f-string-without-interpolation)
> > +check:61:12: W0719: Raising too general exception: Exception (broad-exception-raised)
> > +check:61:28: W1309: Using an f-string that does not have any interpolated variables (f-string-without-interpolation)

I dropped the patch from the pull request for now and sent a v2.

Kevin


