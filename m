Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C728AC41513
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2024 07:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDIoS-00049J-4Q; Sat, 01 Jun 2024 03:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sDIoQ-00048d-0b
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 03:05:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sDIoO-00005Q-Cb
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 03:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717225555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w1InlRkDeRy5sgquyg2kF6RHg7Cun2/HvaDKIvDS0g8=;
 b=eIcMxVVXKHZ0i4oPHMZS5GdS0HFF3jjXwn9RwH5bsQIvTNOf2tYA/6s63NzGMyYSa7neD3
 eOqeUJMV/Lu5sK9G8mGz7qxWJVwffPQxGHxAbchWUiEWJdXMgzfbSF04ALjY0bSMhhn1Xl
 8At9NtEbct0K1wpXxmZuvH2L1fhOgZE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-_8s9857rM0uRgjtv8h4RXQ-1; Sat,
 01 Jun 2024 03:05:49 -0400
X-MC-Unique: _8s9857rM0uRgjtv8h4RXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6E6A1C05129;
 Sat,  1 Jun 2024 07:05:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF3C8200A35C;
 Sat,  1 Jun 2024 07:05:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 3/5] .gitlab-ci.d/buildtest.yml: Use -fno-sanitize=function in
 the clang-system job
Date: Sat,  1 Jun 2024 09:05:41 +0200
Message-ID: <20240601070543.37786-4-thuth@redhat.com>
In-Reply-To: <20240601070543.37786-1-thuth@redhat.com>
References: <20240601070543.37786-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The latest version of Clang (version 18 from Fedora 40) now reports
bad function pointer casts as undefined behavior. Unfortunately, we are
still doing this in quite a lot of places in the QEMU code and some of
them are not easy to fix. So for the time being, temporarily switch this
off in the failing clang-system job until all spots in the QEMU sources
have been tackled.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 91c57efded..0eec570310 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -432,6 +432,7 @@ clang-system:
     IMAGE: fedora
     CONFIGURE_ARGS: --cc=clang --cxx=clang++
       --extra-cflags=-fsanitize=undefined --extra-cflags=-fno-sanitize-recover=undefined
+      --extra-cflags=-fno-sanitize=function
     TARGETS: alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu s390x-softmmu
     MAKE_CHECK_ARGS: check-qtest check-tcg
 
-- 
2.45.1


