Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE2ACDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcN0p-0004k5-6b; Wed, 24 Jun 2026 08:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcN0V-0004SP-Ow
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:47:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcN0U-0006Wu-5u
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782305225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bLprA5fB+vBfZ/cdwz04rKqGYpPPsOFqyQSSc2WK9rY=;
 b=RCYbTb1mB5DX8nDFFgor/J78QFUi86d5uYBNXsq6mwDEn7GKOdRo3oKi5Vd4QtIMSkG8pn
 x5M8Vz0CQF9AF3TLgfq/2t6/1h4MTr/S5D97VpdR6ykkcmTT1S4HFwThFcBtJ66BFGUgN6
 s1Z3JdceWrt7CLKDznzjM8D9js7ckkQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-xQ-sKAmmO8epmKzqpWGCpQ-1; Wed,
 24 Jun 2026 08:47:02 -0400
X-MC-Unique: xQ-sKAmmO8epmKzqpWGCpQ-1
X-Mimecast-MFC-AGG-ID: xQ-sKAmmO8epmKzqpWGCpQ_1782305221
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17C161801F09; Wed, 24 Jun 2026 12:47:01 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.57])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 923351956049; Wed, 24 Jun 2026 12:46:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 0/6] gitlab: expose more info about CI runner environment
 as artifacts
Date: Wed, 24 Jun 2026 13:46:51 +0100
Message-ID: <20260624124657.2725376-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

To repeat the commit message from patch 6..

This captures the mount list, CPU model, memory information,
device node lists, kernel info, user identity and all environment
variables. For more details see patch 6.

The first 5 patches are all refactoring of the job templates to
reduce redundancy, so we have more consistency across jobs with
less code.

Sample pipeline showing the new 'ci-runner-env' artifacts in jobs:

  https://gitlab.com/berrange/qemu/-/pipelines/2626072516

Daniel P. Berrangé (6):
  gitlab: remove unused .cross_test_artifacts template
  gitlab: move .meson_job_template into base.yaml
  gitlab: use .base_meson_job_template from crossbuild jobs
  gitlab: pull ccache setup into .base_meson_ccache_job_template
  gitlab: pull before_script logic into .base_meson_job_template
  gitlab: greatly expand captured info about CI runner environment

 .gitlab-ci.d/base.yml                | 48 ++++++++++++++++++++++
 .gitlab-ci.d/buildtest-template.yml  | 58 ++++-----------------------
 .gitlab-ci.d/crossbuild-template.yml | 59 +++-------------------------
 3 files changed, 62 insertions(+), 103 deletions(-)

-- 
2.54.0


