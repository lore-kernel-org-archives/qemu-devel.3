Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0ED710F2863
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 18:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6BdK-00044s-RU; Fri, 27 Mar 2026 14:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w6BcZ-0003wo-Pz
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 14:09:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w6BcS-0002Rq-Nq
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 14:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774634954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=y1INSb4y86IiLoHy+pWsFHdqcP2is4MOmrlpD4++eGQ=;
 b=jT/sUHYDlG7Y+4g+Lfl0IG0Nvw7CipwGCSjG5vUF/8RMP6oek0B9oXVwLv820cTDTCAJj5
 41siDCz05XGMiPVN9gvBrRblg0Uwhf/FaNj9oY9rBOsIVdSinoJER2JBUDmsMEFrmQoZKW
 hDWk3ouUuTb+7XdcE8FLAlhqsQdaBA0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-lN3yaUvFPRWlfkdeqmaexg-1; Fri,
 27 Mar 2026 14:09:10 -0400
X-MC-Unique: lN3yaUvFPRWlfkdeqmaexg-1
X-Mimecast-MFC-AGG-ID: lN3yaUvFPRWlfkdeqmaexg_1774634949
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B230A1800464; Fri, 27 Mar 2026 18:09:09 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.150])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 675EB1800107; Fri, 27 Mar 2026 18:09:08 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org
Subject: [PULL 0/3] QEMU Guest Agent: Fix fsfreeze-hook script
Date: Fri, 27 Mar 2026 20:09:02 +0200
Message-ID: <20260327180905.378560-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit 770f50c14f098717fd40ae6e826a495681152447:

  Merge tag 'pull-nvme-20260326' of https://gitlab.com/birkelund/qemu into staging (2026-03-26 10:26:39 +0000)

are available in the Git repository at:

  https://github.com/kostyanf14/qemu.git tags/qga-pull-2026-03-27

for you to fetch changes up to 08497afcb2a737794991f17a37f0a0971fca411e:

  scripts/qemu-guest-agent/fsfreeze-hook: Fix syslog-fallback logic (2026-03-27 19:55:01 +0200)

----------------------------------------------------------------
qga-pull-2026-03-27

----------------------------------------------------------------
Peter Maydell (3):
      scripts/qemu-guest-agent/fsfreeze-hook: Avoid bash-isms
      scripts/qemu-guest-agent/fsfreeze-hook: Avoid use of PIPESTATUS
      scripts/qemu-guest-agent/fsfreeze-hook: Fix syslog-fallback logic

 scripts/qemu-guest-agent/fsfreeze-hook | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)


