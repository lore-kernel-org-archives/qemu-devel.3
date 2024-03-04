Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93ED3C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 22:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhGSO-0003zd-Cx; Mon, 04 Mar 2024 17:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhGSE-0003z8-Nr
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 17:06:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rhGSC-00018Z-80
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 17:06:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709589994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pHPebLUVOcYsH/RIaXMH+KqSH3QVqhUzMurtdJY9bEk=;
 b=KXkTCFBNuQo2ZJQG68/llvP61VDsJx6dIkmxwyXiqBRoW0SR6gaFar3PcxlTCfRMJVJFRT
 p0P1+FbqohK1g7P/rCaINwNR+F/Cx9SNdrHAU9biz2cjA/zmfGoqgwokmRYUsWgMcq7R7M
 r3PomwN2N3fadbhnQrDo4yFxDdkuXuY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-4Qfz6ZK_OfOefHqpH-Egfw-1; Mon,
 04 Mar 2024 17:06:32 -0500
X-MC-Unique: 4Qfz6ZK_OfOefHqpH-Egfw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F5D43C00088;
 Mon,  4 Mar 2024 22:06:32 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55588492BCB;
 Mon,  4 Mar 2024 22:06:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	berrange@redhat.com
Subject: [RFC PATCH 0/2] ci: allow running Coverity Scan uploads via GitLab
Date: Mon,  4 Mar 2024 17:06:29 -0500
Message-Id: <20240304220631.943130-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
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

The machine that is used to upload QEMU builds to Coverity is used daily
as a development machine by Emanuele and myself, and as a result sometimes
its podman/docker setup gets messed up.  When this happens, Coverity
uploads might stop for extended periods of time.

In the interest of tightening this and of depending less on infrastructure
maintained by specific people, replace the manually-managed crontab
entry with a new job in GitLab's CI; this is also what Libvirt does.
The rules to trigger it are a bit different compared to other jobs:

* on mainline, it only runs for the default (master) branch and only
  as part of scheduled pipeline runs.  A rule is added to remove all
  other jobs when running from a scheduled pipeline.

* on forks, it is always manual (and only appears if QEMU_CI=1 or 2,
  like other build jobs)

For now I implemented these rules directly in the buildtest.yml file,
but it is also possible to add a QEMU_JOB_SCHEDULE variable.

Example of a working run: https://gitlab.com/bonzini/qemu/-/jobs/6312777493

Example of a run that is over quota: https://gitlab.com/bonzini/qemu/-/jobs/6315895373
This run shows an attempt to cancel the job if the quota is exceeded, but
it does not work (it worked on GitLab <17.0) so I removed it from the patch.

Paolo

Paolo Bonzini (2):
  run-coverity-scan: add --check-upload-only option
  gitlab-ci: add manual job to run Coverity

 .gitlab-ci.d/base.yml                   |  4 ++
 .gitlab-ci.d/buildtest.yml              | 36 +++++++++++++++++
 scripts/coverity-scan/run-coverity-scan | 51 ++++++++++++++++++-------
 3 files changed, 78 insertions(+), 13 deletions(-)

-- 
2.39.1


