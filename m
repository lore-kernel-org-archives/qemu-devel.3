Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE67C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhGW-0003T1-UT; Fri, 04 Jul 2025 10:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uXhGR-0003SA-SK
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:19:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uXhGP-0003HG-CB
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751638777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uiBSjbiTzUCruijVNyKBA8vl11HzBah7FxlKeWQPG8U=;
 b=IXLPlN9J32/vinkKNcggrySOCxVv/kxdeN8YvAqElziiIADwTshM+uPcCTd+k0d27Cwclo
 waGoqswfJWnmbXH6aS27SGj6V6GXTDJC+kYDbpwDqHpy73lTDt7IzznCMxJjP64f0eGxJs
 dipxpFpMyakQNQEqZcKWQM0VOjPAmns=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-6LOCEZLQM_CR_VCla-MyjQ-1; Fri,
 04 Jul 2025 10:19:35 -0400
X-MC-Unique: 6LOCEZLQM_CR_VCla-MyjQ-1
X-Mimecast-MFC-AGG-ID: 6LOCEZLQM_CR_VCla-MyjQ_1751638774
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD73719560AE; Fri,  4 Jul 2025 14:19:33 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.44.34.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 60FC1195608F; Fri,  4 Jul 2025 14:19:31 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 0/5] arm: followup on the ID register storage series
Date: Fri,  4 Jul 2025 16:19:22 +0200
Message-ID: <20250704141927.38963-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This series tries to address some low-hanging fruit on top of target-arm.next
(move some more registers, some cosmetics; see discussion following
<20250617153931.1330449-14-cohuck@redhat.com>)

Also available at https://gitlab.com/cohuck/qemu id-reg-fixup-v1

Cornelia Huck (5):
  arm/cpu: store id_afr0 into the idregs array
  arm/cpu: store id_aa64afr{0,1} into the idregs array
  arm/cpu: fix trailing ',' for SET_IDREG
  arm/cpu: store clidr into the idregs array
  arm/kvm: shorten one overly long line

 hw/intc/armv7m_nvic.c        |  4 +--
 target/arm/cpu-sysregs.h.inc |  4 +++
 target/arm/cpu.h             |  6 +---
 target/arm/cpu64.c           |  8 ++---
 target/arm/helper.c          |  8 ++---
 target/arm/kvm.c             |  3 +-
 target/arm/tcg/cpu-v7m.c     | 16 ++++-----
 target/arm/tcg/cpu32.c       | 34 +++++++++---------
 target/arm/tcg/cpu64.c       | 68 ++++++++++++++++++------------------
 9 files changed, 76 insertions(+), 75 deletions(-)


base-commit: 7bc86ccbb59f2022014e132327a33b94a7ed00fe
-- 
2.50.0


