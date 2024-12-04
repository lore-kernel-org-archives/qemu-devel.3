Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3240EE77170
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 19:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvMB-0004ie-KA; Wed, 04 Dec 2024 14:48:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIvM8-0004iN-Ur
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:48:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIvM7-0000im-0M
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733341692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UmuEnCz9kxrDoeD5BplvRXcKP8WWjikF/YUi0s4TFLQ=;
 b=TuLfP6BUGcuD7Kuidfi9ERMDgabXSbaVTK9K+mESRcwulxxyH4+B7kS5kcq/CoONHYgL5q
 Lzv0EVX8DqCIh8kmH0TBP0ETmrMqURo3xxlwdVqZOw7m1AoCSMjNj56MA9a37R8cXTZQjT
 IphVPQbzWInBzhytbtFFV0JG8aOAha4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-IF0Xte6xMWSgwfomzfYTvQ-1; Wed,
 04 Dec 2024 14:48:11 -0500
X-MC-Unique: IF0Xte6xMWSgwfomzfYTvQ-1
X-Mimecast-MFC-AGG-ID: IF0Xte6xMWSgwfomzfYTvQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6C4D1955D93; Wed,  4 Dec 2024 19:48:10 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.92])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EEC9919560A2; Wed,  4 Dec 2024 19:48:08 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/7] RFC: gitlab: enable use of ccache in FreeBSD / macOS
 Cirrus CI jobs
Date: Wed,  4 Dec 2024 19:48:00 +0000
Message-ID: <20241204194807.1472261-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 LOTS_OF_MONEY=0.001, MONEY_NOHTML=0.949, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We've seen that we exhaust the Cirrus CI free credits for the QEMU
account, especially during the end of a release cycle.

It is hard to cut down the CI credits burn beyond its current level
without dropping features from the build configuration, which harms
CI coverage.

This proposes two things

 * First, when CI credits are exhausted we stop treating Cirrus CI
   failures as fatal. Instead the FreeBSD/macOS jobs get marked as
   "warning" meaning they won't break the whole pipeline.

 * Enable the use of ccache in the build process which would reduce
   the wallclock time in jobs, when there is a good cache hit rate.

...alot of heavy lifting is done by the last part of that sentence
above, meaning this isn't a guaranteed win. When ccache takes a
cache miss, compile time is worse than without ccache. Also we have
a time penalty of uploading/downloading the cache at start/end of
the job.

Observed timings over a number of runs:

 * No ccache (ie today)

    *   macOS: 6m00 build,  8m00 total
    *   macOS: 6m30 build,  8m20 total
    * FreeBSD: 8m45 build, 14m50 total
    * FreeBSD: 9m00 build, 15m30 total

   In macOS we see approx 2m for brew install tasks
   In FreeBSD we see approx 5m30-6m for pkg install tasks

 * ccache: cold cache (ie 0% hit rate)

    *   macOS: 8m15 build, 12m00 total
    *   macOS: 7m55 build, 10m03 total
    * FreeBSD: 9m35 build, 16m00 total
    * FreeBSD: 9m23 build, 15m15 total

   In macOS we see the compile time increase by 1m30-2m
   In FreeBSD we see the compile time increase 0m30-1m

 * ccache: hot cache (ie 99% hit rate)

    *   macOS: 5m25 build, 8m37 total
    *   macOS: 3m28 build, 5m35 total
    *   macOS: 3m40 build, 6m00 total
    * FreeBSD: 5m31 build, 12m00 total
    * FreeBSD: 5m25 build, 11m50 total
    * FreeBSD: 5m20 build, 11m00 total

   In macOS we see compile time decrease 0m30-3m
   In FreeBSD we see compile time decrease 3m

   Most of the "build" time remaining here is actually
   running of unit tests & qtests.

   There is some non-deterministic upload/download overhead
   between 0m05-0m30.

What this tells us:

  * ccache with cold cache is always slower than today
  * ccache with hot cache is usually better than today

The $1 million question is what our cache hit rate will look like
across real world pull requests ?

Also any slowness in homebrew / ports can impact our pkg install
times non-deterministically.

It is very hard to say for sure if this is a win, without actually
trying it over a release cycle and seeing how our CI credits usage
varies over 4 months. Even that will be hard, as we QEMU is a
moving target adding features. eg I wonder what Rust would do to
build times, if anything measurable ?

So our options

 * Trial ccache with Cirrus CI
 * Cull more features from macOS/FreeBSD build config
 * Reduce 'make check' coverage for macOS/FreeBSD
 * Get our own CI private runners for FreeBSD and use Cirrus
   only for macOS
 * <Your idea here>

Daniel P. Berrangé (7):
  gitlab: don't fail cirrus CI jobs when credits are exhausted
  gitlab: use new(ish) cirrus-vars command for creating config
  gitlab: clean packages in cirrus tasks
  gitlab: purge build files from cirrus CI jobs
  gitlab: enable ccache with Cirrus CI
  tests: update libvirt-ci submodule for newer ccache
  gitlab: force ccache to validate compiler version

 .gitlab-ci.d/cirrus.yml             | 30 +++++++++--------------------
 .gitlab-ci.d/cirrus/build.yml       | 14 +++++++++++++-
 .gitlab-ci.d/cirrus/freebsd-14.vars |  2 +-
 tests/lcitool/libvirt-ci            |  2 +-
 tests/vm/generated/freebsd.json     |  2 +-
 5 files changed, 25 insertions(+), 25 deletions(-)

-- 
2.46.0


