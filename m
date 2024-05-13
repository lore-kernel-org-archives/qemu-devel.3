Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD29C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 11:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Tf6-0001A6-5t; Mon, 13 May 2024 07:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s6Tf3-00015n-V0
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:16:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s6Tf1-0004ei-Ts
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715598963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7bZazT5Ua200BcOGU+UywNJkAPu2BTRAcImE8icBWgA=;
 b=bvyn6c6ynDevXfaqqTaZo2EfNZ6nM9jEj5IFWEwA1d94XqjjT0xZqDa90NBZ8zkd9nL+YH
 hT/dwsNuIu0Ag1+y1LXn1iy2sjqjbBN+ztv39R+5WpNfZ99mzBBSB2tHvY1sNP1f/CJhKi
 mRWL3GiwI9Clr7gk2kyc1wSPfoSWF3o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-tjFm9c-iNGupKkybJN9gUA-1; Mon, 13 May 2024 07:15:54 -0400
X-MC-Unique: tjFm9c-iNGupKkybJN9gUA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BDBC8008AD;
 Mon, 13 May 2024 11:15:54 +0000 (UTC)
Received: from toolbox.default.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 505DD200A08E;
 Mon, 13 May 2024 11:15:52 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/3] gitlab: fix failing TSAN job in CI
Date: Mon, 13 May 2024 12:15:48 +0100
Message-ID: <20240513111551.488088-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

See patch 3 commit message for the key details about the problem.

Daniel P. Berrangé (3):
  dockerfiles: add 'MAKE' env variable to remaining containers
  gitlab: use $MAKE instead of 'make'
  gitlab: use 'setarch -R' to workaround tsan bug

 .gitlab-ci.d/buildtest-template.yml                      | 6 +++---
 .gitlab-ci.d/buildtest.yml                               | 3 +++
 tests/docker/dockerfiles/debian-all-test-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-hexagon-cross.docker     | 1 +
 tests/docker/dockerfiles/debian-legacy-test-cross.docker | 1 +
 tests/docker/dockerfiles/debian-loongarch-cross.docker   | 1 +
 tests/docker/dockerfiles/debian-tricore-cross.docker     | 1 +
 tests/docker/dockerfiles/debian-xtensa-cross.docker      | 1 +
 tests/docker/dockerfiles/fedora-cris-cross.docker        | 1 +
 9 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.43.0


