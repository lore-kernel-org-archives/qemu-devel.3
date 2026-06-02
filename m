Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C841ACD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 16:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wURvU-0004rl-Uf; Tue, 02 Jun 2026 12:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wURvR-0004mq-QU
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 12:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wURvN-0001KG-AY
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 12:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780417502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=elSwCfL6gzVTjYSVrv6gbpOzclHahQNprow/O53onek=;
 b=Z7RqIRLqq78rYOVSqkLcHc5i55TvKKhE+Km0A/CJDJQ/r7hsAh3eJREAFBizbElKguGhsW
 tOafu55rQzzghEufgNPQQgFM4FZksu0dztKnDQ3n+o2dLhRaDeZOLSmiYSFalDrk9CYYhl
 PSe4QsALUDNvp/ohnhJQweYAuPbSURg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-Oyrb2bO7OFq1IxSvirQ9xQ-1; Tue,
 02 Jun 2026 12:25:01 -0400
X-MC-Unique: Oyrb2bO7OFq1IxSvirQ9xQ-1
X-Mimecast-MFC-AGG-ID: Oyrb2bO7OFq1IxSvirQ9xQ_1780417500
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 711BC1956089; Tue,  2 Jun 2026 16:24:59 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E31B1956095; Tue,  2 Jun 2026 16:24:58 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Warner Losh <imp@bsdimp.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 0/3] gitlab: remove x64-freebsd-14-build job and Cirrus CI
 integration
Date: Tue,  2 Jun 2026 12:24:53 -0400
Message-ID: <20260602162457.828969-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Cirrus CI shut down yesterday and the x64-freebsd-14-build CI job is now
failing. This patch series removes the job as well as the Cirrus CI integration
in lcitool.

Warner is setting up a gitlab-runner on a VM hosted by OSUOSL for QEMU. It will
be possible to test FreeBSD builds again when it comes online.

Stefan Hajnoczi (3):
  gitlab: remove x64-freebsd-14-build Cirrus job
  lcitool: remove Cirrus CI support
  MAINTAINERS: remove stale Cirrus macOS build job path

 MAINTAINERS                         |  3 --
 .gitlab-ci.d/cirrus/README.rst      | 54 -----------------------------
 docs/devel/testing/main.rst         |  4 +--
 .gitlab-ci.d/base.yml               |  4 ---
 .gitlab-ci.d/cirrus.yml             | 46 ------------------------
 .gitlab-ci.d/cirrus/build.yml       | 42 ----------------------
 .gitlab-ci.d/cirrus/freebsd-14.vars | 16 ---------
 .gitlab-ci.d/qemu-project.yml       |  1 -
 docs/devel/testing/ci-jobs.rst.inc  |  6 ----
 tests/lcitool/refresh               | 11 ------
 10 files changed, 2 insertions(+), 185 deletions(-)
 delete mode 100644 .gitlab-ci.d/cirrus/README.rst
 delete mode 100644 .gitlab-ci.d/cirrus.yml
 delete mode 100644 .gitlab-ci.d/cirrus/build.yml
 delete mode 100644 .gitlab-ci.d/cirrus/freebsd-14.vars

-- 
2.54.0


