Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47DAC55822
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 16:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrIPJ-0007GO-PA; Tue, 04 Aug 2026 12:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wrIPJ-0007GG-5G
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 12:54:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wrIPH-00083I-Fx
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 12:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785862461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CtzzvXkyrYWBS7h1wUGsGeGcIxg7SwuqbUot9EQyZ5I=;
 b=cciEfUHysyL13P33Fw6NXfpNBm4/GCUowDYg0m7y0P2Hs9HU9620TIqzEI/hT7yyD6h2UD
 hWGiC1GRLrqDvPcii11RSg+lhqvwAQ+7gJrgwWaVZ2ctCLfGj/a3wChEbM7rF5mI8VrOh6
 vNVnXxH6gyKy79K6rxqHX4XYN/dXsx8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-CH3ONSewNNecL9yXq5YiIw-1; Tue,
 04 Aug 2026 12:54:17 -0400
X-MC-Unique: CH3ONSewNNecL9yXq5YiIw-1
X-Mimecast-MFC-AGG-ID: CH3ONSewNNecL9yXq5YiIw_1785862456
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8445F1956056; Tue,  4 Aug 2026 16:54:16 +0000 (UTC)
Received: from localhost (unknown [10.2.16.106])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 04DEC195608E; Tue,  4 Aug 2026 16:54:15 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH for-11.1] gitlab: disable provenance attestations to work
 around CI bug
Date: Tue,  4 Aug 2026 12:54:14 -0400
Message-ID: <20260804165414.480435-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.795,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

QEMU's CI pipeline involves building container images that will be used
to run builds and tests. A recent Docker change triggered the following
error:

  $ docker push "$TAG"
  ...
  error from registry: blob unknown to registry - sha256:4401f6f779caf8841cafd5f483e642fcac56a23a4e4a59523231e101c890dad9

https://gitlab.com/qemu-project/qemu/-/jobs/15701875927#L2372

This happens because Docker now pushes out-of-order and the GitLab
Container Registry rejects due to an unknown reference:
https://forum.gitlab.com/t/started-yesterday-docker-push-error-from-registry-blob-unknown-to-registry/134733/5

It is unclear at this point whether GitLab will modify the behavior of
Container Registry or whether Docker will ship a fix.

The current workaround is to disable the provenance attestation that is
involved in this issue. QEMU's CI pipeline container images are used
internally for testing and are not widely distributed. Provenance
attestation can be disabled as there are no external consumers of these
images. Expect to revert this commit in the future when GitLab or Docker
have released their own fixes.

Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
Note that this is an urgent patch so that the CI will pass again and I
can tag v11.1.0-rc3 later today. Currently it is failing due to this
issue!

 .gitlab-ci.d/container-template.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/container-template.yml b/.gitlab-ci.d/container-template.yml
index 8c7311cca57..88317d650e2 100644
--- a/.gitlab-ci.d/container-template.yml
+++ b/.gitlab-ci.d/container-template.yml
@@ -14,7 +14,7 @@
     - echo "TAG:$TAG"
     - echo "COMMON_TAG:$COMMON_TAG"
     - docker build --tag "$TAG" --cache-from "$TAG" --cache-from "$COMMON_TAG"
-      --build-arg BUILDKIT_INLINE_CACHE=1
+      --build-arg BUILDKIT_INLINE_CACHE=1 --provenance=false
       -f "tests/docker/dockerfiles/$NAME.docker" "."
     - docker push "$TAG"
   after_script:
-- 
2.55.0


