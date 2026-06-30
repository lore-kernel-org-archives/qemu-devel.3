Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22BEC43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weTrx-0001Hn-Qn; Tue, 30 Jun 2026 04:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1weTrv-0001Gn-JU
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1weTrs-0007Lm-U9
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782808256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DJNfvXW26DIqwtZy2+NDSdNUUChYB4z9RdEn8ikpbAI=;
 b=TH7F+MXBMwGJlz5U7QVUXpkv9qovZU+xU/j/Mbh1YRMUqClWn1usgJsWW28y37XGRKJQWM
 5MEyyCTKvMkSz3UqHcj+0nJoga5UoP8dBykrywQV1BXc8UpU61gKgSNLKUsx+pBGmBiQiN
 9W57e2QgqGe7dMTA/nzrJRCWAHC69gg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-DBwKztGaOvS211aeT78U2w-1; Tue,
 30 Jun 2026 04:30:51 -0400
X-MC-Unique: DBwKztGaOvS211aeT78U2w-1
X-Mimecast-MFC-AGG-ID: DBwKztGaOvS211aeT78U2w_1782808249
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EF4B18009E7; Tue, 30 Jun 2026 08:30:49 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.33.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 442C21955F6F; Tue, 30 Jun 2026 08:30:46 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, berrange@redhat.com,
 skolothumtho@nvidia.com, nicolinc@nvidia.com, nathanc@nvidia.com
Subject: [PATCH 0/2] Sanitize SMMU_S_STRTAB_BASE_CFG LOG2SIZE and SPLIT
Date: Tue, 30 Jun 2026 10:30:18 +0200
Message-ID: <20260630083042.2692392-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The current code fails to sanitize SMMU_S_STRTAB_BASE_CFG
LOG2SIZE and SPLIT which are used in the STE lookup. This
could potentially lead to wrong shifts/masks in
smmu_find_ste() and does not fully comply with the spec.

Best Regards

Eric

Eric Auger (2):
  hw/arm/smmuv3: Sanitize SMMU_S_STRTAB_BASE_CFG.SPLIT
  hw/arm/smmuv3: Sanitize SMMU_S_STRTAB_BASE_CFG.LOG2SIZE

 hw/arm/smmuv3.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.53.0


