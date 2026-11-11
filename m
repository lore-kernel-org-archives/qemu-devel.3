Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FB9606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IiWmQg+9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR7Zc-0002jh-ST; Wed, 11 Nov 2026 07:37:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xR7ZV-0002ij-Mm
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:37:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xR7ZU-0001Kl-1x
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794400619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OxUKLTlYmEzOwmQfO43IrgoHk+Z2EFLxJjSyx5CqEwM=;
 b=IiWmQg+9wBHattoUisazhdYRfHL0UhQ+2Fcw6/Z2g07h9hfWRh+vGxxSj0gFL2NDyow465
 G78H2soJebkCdfMXiepftiPP8av7QbrRuRWTkEmZcOj6J0394APgWGL+3A22Rjx50OUooZ
 sEyCQ02gqc/ffo2lF0rpBV29cVr1wTo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-AG9aT-fWOqu7uXVHJD9QTw-1; Wed,
 11 Nov 2026 07:36:55 -0500
X-MC-Unique: AG9aT-fWOqu7uXVHJD9QTw-1
X-Mimecast-MFC-AGG-ID: AG9aT-fWOqu7uXVHJD9QTw_1794400614
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 024FD18011C9; Wed, 11 Nov 2026 12:36:54 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.96])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4817B195608B; Wed, 11 Nov 2026 12:36:51 +0000 (UTC)
Date: Wed, 11 Nov 2026 13:36:48 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] iotests: better heuristics to find I/O tests
 build/source dirs
Message-ID: <avRhYD5SR0T5N9_b@redhat.com>
References: <20261111091133.3527549-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261111091133.3527549-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 11.11.2026 um 10:11 hat Daniel P. Berrangé geschrieben:
> Currently the I/O tests cannot be run if executing directly
> from the source directory, even when wrapped by the 'run'
> script, due to inadequate heuristics to guess the directories.
> 
> If using the 'run' script, meson can tell us exactly where the
> top level build and source directories are, so we don't need
> to guess. Just read MESON_BUILD_ROOT and MESON_SOURCE_ROOT
> env variables if present.
> 
> If not using the 'run' script, we can do a bit better at
> guessing the path from the 'check' filename. Always resolve
> from sys.argv[0], even when it is not a symlink, instead of
> falling back to 'cwd()' which doesn't work since we stopped
> having in-tree builds. If invoked directly from the source
> tree, guess that the build root is the default 'build' name
> which often works.
> 
> With this change the following all work:
> 
> 1. From root of build dir, with run script
> 
>   cd build
>   ./run tests/qemu-iotests/check 5
> 
> 2. From root of build dir, without run script
> 
>   cd build
>   tests/qemu-iotests/check 5
> 
> 3. From I/O tests subdir of build dir, with run script
> 
>   cd build/tests/qemu-iotests
>   ../../run ./check 5
> 
> 4. From I/O tests subdir of build dir, without run script
> 
>   cd build/tests/qemu-iotests
>   ./check 5
> 
> 5. From root of source dir, with run script
> 
>   ./build/run tests/qemu-iotests/check 5
> 
> 6. From root of source dir, without run script
> 
>   tests/qemu-iotests/check 5
> 
> 7. From I/O tests subdir of source dir, with run script
> 
>   cd tests/qemu-iotests
>   ../../build/run ./check 5
> 
> 8. From I/O tests subdir of source dir, without run script
> 
>   cd tests/qemu-iotests
>   ./check 5
> 
> Before this commit, items 5-8 would always fail. Items 6 and
> 8 will not work if using a build directory with a name other
> than the default 'build'. For those scenarios use one of the
> other 6 possible variants.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Thanks, applied to the block branch.

Kevin


