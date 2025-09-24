Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829B7CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 06:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1JBe-0002f1-PJ; Wed, 24 Sep 2025 02:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v1JB6-0002Wp-NV
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:40:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v1JAx-0006lM-FH
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 02:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758696025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BsKu+Wcud8wrEkXoVL4LUsLkjAKPThLezpUFrMINx8c=;
 b=R655V3Lk4oVio6PFVRpIrwPU4Y0MGTq6d6BGhVRpIKFTBYN7jsXvxRKkvqYhxi8VP9Ch1B
 5Npr0tpijGOLmXNaVd8kDieoFLrn/nsaTA1A0p2RzS/Ny/S5grhec+gRPzmqDeARXc3aSq
 rvXe7C25L5ZYNlz4uftH+fcRTgvz83I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-obhZoyxWMtWLvD0Cp5rLHA-1; Wed,
 24 Sep 2025 02:40:21 -0400
X-MC-Unique: obhZoyxWMtWLvD0Cp5rLHA-1
X-Mimecast-MFC-AGG-ID: obhZoyxWMtWLvD0Cp5rLHA_1758696020
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5946718002C2; Wed, 24 Sep 2025 06:40:20 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 41DD81955F19; Wed, 24 Sep 2025 06:40:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 12/12] tests/functional: treat unknown exceptions as transient
 faults
Date: Wed, 24 Sep 2025 08:39:56 +0200
Message-ID: <20250924063956.519792-13-thuth@redhat.com>
In-Reply-To: <20250924063956.519792-1-thuth@redhat.com>
References: <20250924063956.519792-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

To maximise the robustness of the functional tests we want to treat most
asset download failures as non-fatal to the test suite. Instead it
should just skip the tests which need that particular asset. The only
time aim to make it fatal is for 404 errors which are highly likely to
reflect genuine problems to be fixed.

We catch certain exception classes and handle them as transient errors,
but unfortunately it is proving difficult to predict what exception
classes urlopen() is capable of raising, with new possibilities being
discovered.

To provide a fail-safe, treat the generic Exception class as being a
transient error too. This may well mask certain genuine bugs, but it is
preferrable to prioritize running the test suite to the greatest extent
practical.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250918125746.1165658-3-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/asset.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index f8b87d21538..2971a989d1e 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -188,7 +188,8 @@ def fetch(self):
                 continue
             except Exception as e:
                 tmp_cache_file.unlink()
-                raise AssetError(self, "Unable to download: %s" % e)
+                raise AssetError(self, "Unable to download: %s" % e,
+                                 transient=True)
 
         if not os.path.exists(tmp_cache_file):
             raise AssetError(self, "Download retries exceeded", transient=True)
-- 
2.51.0


