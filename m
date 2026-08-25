Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B13C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypLn-0004cA-DA; Tue, 25 Aug 2026 07:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypLk-0004OL-Pt
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:29:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypLj-000654-1U
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787657390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=trSTfDehlJwFh5PvwUsL1efwjqahFszjfyfdVz4j3uA=;
 b=dPUUPCcsDhKMxb5oqEsrwdolLywgga4gA8if4swbv3Ismn08V1lTk+c+dNLmT1AabrjCi7
 emMwTlzSfnASDTr98TgpcgNAVufedG132mssQ/H+VDsN2LbU42fC0sHpFywi5xqr7FNBed
 6gQbwlbMTpU4RK+fdcI2Q4OjL5TFJPQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-l9saqlDtNwS8SXVtm2VECw-1; Tue,
 25 Aug 2026 07:29:45 -0400
X-MC-Unique: l9saqlDtNwS8SXVtm2VECw-1
X-Mimecast-MFC-AGG-ID: l9saqlDtNwS8SXVtm2VECw_1787657384
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74510185BE92; Tue, 25 Aug 2026 11:29:43 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A54EC195422E; Tue, 25 Aug 2026 11:29:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 15:21:00 +0400
Subject: [GIT PULL 10/19] tests/functional: fix pylint false positives for
 cv2 module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-fixes-v1-10-c59e8a620836@redhat.com>
References: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
In-Reply-To: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1324;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ON8EwH+NM+YLICD9zMOhz/cNDHF0r3PX5tj/HxFjIb4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjXrUeHm/1HQ/W3F7rTb/5gUG7er7BBsL+HybV
 q8Ys136CqGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao161AAKCRDa6OEJdZac
 5WByD/4hazbWF+/F7IyzUjRKjP8sy4e/ZdLToxfnpyujuo2EPHcw8XXqKrOuDb9XeC3ot0y3uSk
 yQWeV8hJmpyogov9Gl5g4iZLeqaqAlMeglMn1pmiP89J96qHNC9476IatLGrgfi6+eWD8nlyAeR
 EkCzbxGwVEVcCGuioCC8wOAWp8aRLbR3/3vH00DbbB/dyn2FfTFBgCifqgd4ez2Ehj7ffeE1CBx
 j3VDDRQQMbxxJ+EU7z6da/X/lJdv8voj+2QDgJxV1queUGmbf4RL9+U0f2c9+F5cQ1epICefM1V
 xpbxs3ZDauyJkfpSQHKYUfZ9Iypv2my3WiNxOwA0rKs0m0Rh8W+42p3JeEvoZeOY7seZgWl/oCZ
 NQuWEjvbdKLmfb+SQmGK3Pc/gbRHlWCFzpze9XKzyu4JIBROJ5igz3GU+dWwiDjNr4vkhf/e4nP
 A/TBqZ+4oeiYPeiLLUQra2tEoxp8+OdjeJCQxuLq/x5xl3VzzWHreTMjGrxBw7kymVAeIJdWLAu
 0Re6zesbt3ycScVjCtcxOuqn5FfnS/I7bN0pZr0PvP4kjHRG/re8tLJhJHjft8Z8gs73NO7mifU
 7h8BJp5ipPIhY6iyYHr02Yfc4ke3qJdP2OtWF8DbTdsbQjpn875wvp/ZDrpLksWNBIEiVKzQFQd
 /qAOMv6oah8tjtA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add generated-members=cv2.* to pylintrc so pylint skips member
checking on the cv2 C extension module, whose members are not
visible to static analysis.

Silence:
2026-08-15 10:42:08,710 - INFO: qemu-test.test_pylint Checking files in /home/elmarco/src/qemu.qom-qapi/tests/functional/arm with pylint
2026-08-15 10:42:10,941 - ERROR: qemu-test.test_pylint "/home/elmarco/src/qemu.qom-qapi/tests/functional/arm/test_integratorcp.py:83: E1101: Module 'cv2' has no 'imread' member (no-member)"

Note: I also tried with extension-pkg-allow-list, but that didn't work
for some reason.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260815072421.4117291-1-marcandre.lureau@redhat.com>
---
 tests/functional/pylintrc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/functional/pylintrc b/tests/functional/pylintrc
index 949bea611fe4..373aabd6ca3f 100644
--- a/tests/functional/pylintrc
+++ b/tests/functional/pylintrc
@@ -79,6 +79,12 @@ disable=bad-inline-option,
         useless-suppression,
 
 
+[TYPECHECK]
+
+# cv2 is a C extension module whose members are not visible to pylint
+generated-members=cv2.*
+
+
 [SIMILARITIES]
 
 # Minimum lines number of a similarity.

-- 
2.55.0.543.g5ebe2ebe4ea8


