Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1A3C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 15:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuvFP-0001AM-6x; Wed, 19 Mar 2025 11:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tuvF0-00012j-EM
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:22:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tuvEo-0001Ot-Re
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742397702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c0Yjsbxi/w8KB3MdOmcRW0OmBToLvNJ/OnnTC6+wNhs=;
 b=haROm4R7clMgnLfq0QRoqnv4fto9maSxWp/qOgOxkUBbt8TPwK8hxwyD7FxXI/aicadNZ4
 M8o/llmA68xpzlYbGJePRIE1ZB4zL/xCzFSKVQvNxb2i9LaNwZiAy2DVSE3nHdOpzAip2b
 tznOeHUQk7zDk2L2Jfv7TYt3/I8PVsI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-N0LFcn0QOtGuvC1Rb1L3vQ-1; Wed,
 19 Mar 2025 11:21:38 -0400
X-MC-Unique: N0LFcn0QOtGuvC1Rb1L3vQ-1
X-Mimecast-MFC-AGG-ID: N0LFcn0QOtGuvC1Rb1L3vQ_1742397697
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66657180AF5E
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 15:21:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A2041800370
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 15:21:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2831B21E66C6; Wed, 19 Mar 2025 16:21:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] cleanup: Re-run return_directly.cocci
Date: Wed, 19 Mar 2025 16:21:24 +0100
Message-ID: <20250319152126.3472290-2-armbru@redhat.com>
In-Reply-To: <20250319152126.3472290-1-armbru@redhat.com>
References: <20250319152126.3472290-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Coccinelle's indentation of virt_create_plic() results in a long line.
Avoid that by mimicking the old indentation manually.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/gpio/pca9554.c                             |  5 +---
 hw/i386/kvm/xen_xenstore.c                    |  4 +--
 hw/riscv/virt.c                               | 25 ++++++++-----------
 hw/scsi/esp.c                                 |  5 +---
 hw/vfio/common.c                              |  7 ++----
 plugins/api.c                                 |  4 +--
 target/loongarch/tcg/tlb_helper.c             |  5 ++--
 tests/qtest/cmsdk-apb-watchdog-test.c         |  6 +----
 tests/qtest/pnv-host-i2c-test.c               |  4 +--
 tests/qtest/stm32l4x5_usart-test.c            |  6 +----
 .../user/ase/msa/bit-count/test_msa_nloc_b.c  |  9 +++----
 .../user/ase/msa/bit-count/test_msa_nloc_d.c  |  9 +++----
 .../user/ase/msa/bit-count/test_msa_nloc_h.c  |  9 +++----
 .../user/ase/msa/bit-count/test_msa_nloc_w.c  |  9 +++----
 .../user/ase/msa/bit-count/test_msa_nlzc_b.c  |  9 +++----
 .../user/ase/msa/bit-count/test_msa_nlzc_d.c  |  9 +++----
 .../user/ase/msa/bit-count/test_msa_nlzc_h.c  |  9 +++----
 .../user/ase/msa/bit-count/test_msa_nlzc_w.c  |  9 +++----
 .../user/ase/msa/bit-count/test_msa_pcnt_b.c  |  9 +++----
 .../user/ase/msa/bit-count/test_msa_pcnt_d.c  |  9 +++----
 .../user/ase/msa/bit-count/test_msa_pcnt_h.c  |  9 +++----
 .../user/ase/msa/bit-count/test_msa_pcnt_w.c  |  9 +++----
 .../user/ase/msa/bit-move/test_msa_binsl_b.c  |  9 +++----
 .../user/ase/msa/bit-move/test_msa_binsl_d.c  |  9 +++----
 .../user/ase/msa/bit-move/test_msa_binsl_h.c  |  9 +++----
 .../user/ase/msa/bit-move/test_msa_binsl_w.c  |  9 +++----
 .../user/ase/msa/bit-move/test_msa_binsr_b.c  |  9 +++----
 .../user/ase/msa/bit-move/test_msa_binsr_d.c  |  9 +++----
 .../user/ase/msa/bit-move/test_msa_binsr_h.c  |  9 +++----
 .../user/ase/msa/bit-move/test_msa_binsr_w.c  |  9 +++----
 .../user/ase/msa/bit-move/test_msa_bmnz_v.c   |  9 +++----
 .../user/ase/msa/bit-move/test_msa_bmz_v.c    |  9 +++----
 .../user/ase/msa/bit-move/test_msa_bsel_v.c   |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bclr_b.c    |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bclr_d.c    |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bclr_h.c    |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bclr_w.c    |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bneg_b.c    |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bneg_d.c    |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bneg_h.c    |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bneg_w.c    |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bset_b.c    |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bset_d.c    |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bset_h.c    |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bset_w.c    |  9 +++----
 .../msa/fixed-multiply/test_msa_madd_q_h.c    |  9 +++----
 .../msa/fixed-multiply/test_msa_madd_q_w.c    |  9 +++----
 .../msa/fixed-multiply/test_msa_maddr_q_h.c   |  9 +++----
 .../msa/fixed-multiply/test_msa_maddr_q_w.c   |  9 +++----
 .../msa/fixed-multiply/test_msa_msub_q_h.c    |  9 +++----
 .../msa/fixed-multiply/test_msa_msub_q_w.c    |  9 +++----
 .../msa/fixed-multiply/test_msa_msubr_q_h.c   |  9 +++----
 .../msa/fixed-multiply/test_msa_msubr_q_w.c   |  9 +++----
 .../ase/msa/fixed-multiply/test_msa_mul_q_h.c |  9 +++----
 .../ase/msa/fixed-multiply/test_msa_mul_q_w.c |  9 +++----
 .../msa/fixed-multiply/test_msa_mulr_q_h.c    |  9 +++----
 .../msa/fixed-multiply/test_msa_mulr_q_w.c    |  9 +++----
 .../ase/msa/float-max-min/test_msa_fmax_a_d.c |  9 +++----
 .../ase/msa/float-max-min/test_msa_fmax_a_w.c |  9 +++----
 .../ase/msa/float-max-min/test_msa_fmax_d.c   |  9 +++----
 .../ase/msa/float-max-min/test_msa_fmax_w.c   |  9 +++----
 .../ase/msa/float-max-min/test_msa_fmin_a_d.c |  9 +++----
 .../ase/msa/float-max-min/test_msa_fmin_a_w.c |  9 +++----
 .../ase/msa/float-max-min/test_msa_fmin_d.c   |  9 +++----
 .../ase/msa/float-max-min/test_msa_fmin_w.c   |  9 +++----
 .../user/ase/msa/int-add/test_msa_add_a_b.c   |  9 +++----
 .../user/ase/msa/int-add/test_msa_add_a_d.c   |  9 +++----
 .../user/ase/msa/int-add/test_msa_add_a_h.c   |  9 +++----
 .../user/ase/msa/int-add/test_msa_add_a_w.c   |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_a_b.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_a_d.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_a_h.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_a_w.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_s_b.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_s_d.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_s_h.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_s_w.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_u_b.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_u_d.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_u_h.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_u_w.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_addv_b.c    |  9 +++----
 .../user/ase/msa/int-add/test_msa_addv_d.c    |  9 +++----
 .../user/ase/msa/int-add/test_msa_addv_h.c    |  9 +++----
 .../user/ase/msa/int-add/test_msa_addv_w.c    |  9 +++----
 .../user/ase/msa/int-add/test_msa_hadd_s_d.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_hadd_s_h.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_hadd_s_w.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_hadd_u_d.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_hadd_u_h.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_hadd_u_w.c  |  9 +++----
 .../ase/msa/int-average/test_msa_ave_s_b.c    |  9 +++----
 .../ase/msa/int-average/test_msa_ave_s_d.c    |  9 +++----
 .../ase/msa/int-average/test_msa_ave_s_h.c    |  9 +++----
 .../ase/msa/int-average/test_msa_ave_s_w.c    |  9 +++----
 .../ase/msa/int-average/test_msa_ave_u_b.c    |  9 +++----
 .../ase/msa/int-average/test_msa_ave_u_d.c    |  9 +++----
 .../ase/msa/int-average/test_msa_ave_u_h.c    |  9 +++----
 .../ase/msa/int-average/test_msa_ave_u_w.c    |  9 +++----
 .../ase/msa/int-average/test_msa_aver_s_b.c   |  9 +++----
 .../ase/msa/int-average/test_msa_aver_s_d.c   |  9 +++----
 .../ase/msa/int-average/test_msa_aver_s_h.c   |  9 +++----
 .../ase/msa/int-average/test_msa_aver_s_w.c   |  9 +++----
 .../ase/msa/int-average/test_msa_aver_u_b.c   |  9 +++----
 .../ase/msa/int-average/test_msa_aver_u_d.c   |  9 +++----
 .../ase/msa/int-average/test_msa_aver_u_h.c   |  9 +++----
 .../ase/msa/int-average/test_msa_aver_u_w.c   |  9 +++----
 .../user/ase/msa/int-compare/test_msa_ceq_b.c |  9 +++----
 .../user/ase/msa/int-compare/test_msa_ceq_d.c |  9 +++----
 .../user/ase/msa/int-compare/test_msa_ceq_h.c |  9 +++----
 .../user/ase/msa/int-compare/test_msa_ceq_w.c |  9 +++----
 .../ase/msa/int-compare/test_msa_cle_s_b.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_cle_s_d.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_cle_s_h.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_cle_s_w.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_cle_u_b.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_cle_u_d.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_cle_u_h.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_cle_u_w.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_clt_s_b.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_clt_s_d.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_clt_s_h.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_clt_s_w.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_clt_u_b.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_clt_u_d.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_clt_u_h.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_clt_u_w.c    |  9 +++----
 .../ase/msa/int-divide/test_msa_div_s_b.c     |  9 +++----
 .../ase/msa/int-divide/test_msa_div_s_d.c     |  9 +++----
 .../ase/msa/int-divide/test_msa_div_s_h.c     |  9 +++----
 .../ase/msa/int-divide/test_msa_div_s_w.c     |  9 +++----
 .../ase/msa/int-divide/test_msa_div_u_b.c     |  9 +++----
 .../ase/msa/int-divide/test_msa_div_u_d.c     |  9 +++----
 .../ase/msa/int-divide/test_msa_div_u_h.c     |  9 +++----
 .../ase/msa/int-divide/test_msa_div_u_w.c     |  9 +++----
 .../msa/int-dot-product/test_msa_dotp_s_d.c   |  9 +++----
 .../msa/int-dot-product/test_msa_dotp_s_h.c   |  9 +++----
 .../msa/int-dot-product/test_msa_dotp_s_w.c   |  9 +++----
 .../msa/int-dot-product/test_msa_dotp_u_d.c   |  9 +++----
 .../msa/int-dot-product/test_msa_dotp_u_h.c   |  9 +++----
 .../msa/int-dot-product/test_msa_dotp_u_w.c   |  9 +++----
 .../msa/int-dot-product/test_msa_dpadd_s_d.c  |  9 +++----
 .../msa/int-dot-product/test_msa_dpadd_s_h.c  |  9 +++----
 .../msa/int-dot-product/test_msa_dpadd_s_w.c  |  9 +++----
 .../msa/int-dot-product/test_msa_dpadd_u_d.c  |  9 +++----
 .../msa/int-dot-product/test_msa_dpadd_u_h.c  |  9 +++----
 .../msa/int-dot-product/test_msa_dpadd_u_w.c  |  9 +++----
 .../msa/int-dot-product/test_msa_dpsub_s_d.c  |  9 +++----
 .../msa/int-dot-product/test_msa_dpsub_s_h.c  |  9 +++----
 .../msa/int-dot-product/test_msa_dpsub_s_w.c  |  9 +++----
 .../msa/int-dot-product/test_msa_dpsub_u_d.c  |  9 +++----
 .../msa/int-dot-product/test_msa_dpsub_u_h.c  |  9 +++----
 .../msa/int-dot-product/test_msa_dpsub_u_w.c  |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_a_b.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_a_d.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_a_h.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_a_w.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_s_b.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_s_d.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_s_h.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_s_w.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_u_b.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_u_d.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_u_h.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_u_w.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_a_b.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_a_d.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_a_h.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_a_w.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_s_b.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_s_d.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_s_h.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_s_w.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_u_b.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_u_d.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_u_h.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_u_w.c    |  9 +++----
 .../ase/msa/int-modulo/test_msa_mod_s_b.c     |  9 +++----
 .../ase/msa/int-modulo/test_msa_mod_s_d.c     |  9 +++----
 .../ase/msa/int-modulo/test_msa_mod_s_h.c     |  9 +++----
 .../ase/msa/int-modulo/test_msa_mod_s_w.c     |  9 +++----
 .../ase/msa/int-modulo/test_msa_mod_u_b.c     |  9 +++----
 .../ase/msa/int-modulo/test_msa_mod_u_d.c     |  9 +++----
 .../ase/msa/int-modulo/test_msa_mod_u_h.c     |  9 +++----
 .../ase/msa/int-modulo/test_msa_mod_u_w.c     |  9 +++----
 .../ase/msa/int-multiply/test_msa_maddv_b.c   |  9 +++----
 .../ase/msa/int-multiply/test_msa_maddv_d.c   |  9 +++----
 .../ase/msa/int-multiply/test_msa_maddv_h.c   |  9 +++----
 .../ase/msa/int-multiply/test_msa_maddv_w.c   |  9 +++----
 .../ase/msa/int-multiply/test_msa_msubv_b.c   |  9 +++----
 .../ase/msa/int-multiply/test_msa_msubv_d.c   |  9 +++----
 .../ase/msa/int-multiply/test_msa_msubv_h.c   |  9 +++----
 .../ase/msa/int-multiply/test_msa_msubv_w.c   |  9 +++----
 .../ase/msa/int-multiply/test_msa_mulv_b.c    |  9 +++----
 .../ase/msa/int-multiply/test_msa_mulv_d.c    |  9 +++----
 .../ase/msa/int-multiply/test_msa_mulv_h.c    |  9 +++----
 .../ase/msa/int-multiply/test_msa_mulv_w.c    |  9 +++----
 .../ase/msa/int-subtract/test_msa_asub_s_b.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_asub_s_d.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_asub_s_h.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_asub_s_w.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_asub_u_b.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_asub_u_d.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_asub_u_h.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_asub_u_w.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_hsub_s_d.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_hsub_s_h.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_hsub_s_w.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_hsub_u_d.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_hsub_u_h.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_hsub_u_w.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_subs_s_b.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_subs_s_d.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_subs_s_h.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_subs_s_w.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_subs_u_b.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_subs_u_d.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_subs_u_h.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_subs_u_w.c  |  9 +++----
 .../msa/int-subtract/test_msa_subsus_u_b.c    |  9 +++----
 .../msa/int-subtract/test_msa_subsus_u_d.c    |  9 +++----
 .../msa/int-subtract/test_msa_subsus_u_h.c    |  9 +++----
 .../msa/int-subtract/test_msa_subsus_u_w.c    |  9 +++----
 .../msa/int-subtract/test_msa_subsuu_s_b.c    |  9 +++----
 .../msa/int-subtract/test_msa_subsuu_s_d.c    |  9 +++----
 .../msa/int-subtract/test_msa_subsuu_s_h.c    |  9 +++----
 .../msa/int-subtract/test_msa_subsuu_s_w.c    |  9 +++----
 .../ase/msa/int-subtract/test_msa_subv_b.c    |  9 +++----
 .../ase/msa/int-subtract/test_msa_subv_d.c    |  9 +++----
 .../ase/msa/int-subtract/test_msa_subv_h.c    |  9 +++----
 .../ase/msa/int-subtract/test_msa_subv_w.c    |  9 +++----
 .../ase/msa/interleave/test_msa_ilvev_b.c     |  9 +++----
 .../ase/msa/interleave/test_msa_ilvev_d.c     |  9 +++----
 .../ase/msa/interleave/test_msa_ilvev_h.c     |  9 +++----
 .../ase/msa/interleave/test_msa_ilvev_w.c     |  9 +++----
 .../user/ase/msa/interleave/test_msa_ilvl_b.c |  9 +++----
 .../user/ase/msa/interleave/test_msa_ilvl_d.c |  9 +++----
 .../user/ase/msa/interleave/test_msa_ilvl_h.c |  9 +++----
 .../user/ase/msa/interleave/test_msa_ilvl_w.c |  9 +++----
 .../ase/msa/interleave/test_msa_ilvod_b.c     |  9 +++----
 .../ase/msa/interleave/test_msa_ilvod_d.c     |  9 +++----
 .../ase/msa/interleave/test_msa_ilvod_h.c     |  9 +++----
 .../ase/msa/interleave/test_msa_ilvod_w.c     |  9 +++----
 .../user/ase/msa/interleave/test_msa_ilvr_b.c |  9 +++----
 .../user/ase/msa/interleave/test_msa_ilvr_d.c |  9 +++----
 .../user/ase/msa/interleave/test_msa_ilvr_h.c |  9 +++----
 .../user/ase/msa/interleave/test_msa_ilvr_w.c |  9 +++----
 .../mips/user/ase/msa/logic/test_msa_and_v.c  |  9 +++----
 .../mips/user/ase/msa/logic/test_msa_nor_v.c  |  9 +++----
 .../mips/user/ase/msa/logic/test_msa_or_v.c   |  9 +++----
 .../mips/user/ase/msa/logic/test_msa_xor_v.c  |  9 +++----
 .../mips/user/ase/msa/move/test_msa_move_v.c  |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_pckev_b.c |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_pckev_d.c |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_pckev_h.c |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_pckev_w.c |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_pckod_b.c |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_pckod_d.c |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_pckod_h.c |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_pckod_w.c |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_vshf_b.c  |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_vshf_d.c  |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_vshf_h.c  |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_vshf_w.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_sll_b.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_sll_d.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_sll_h.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_sll_w.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_sra_b.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_sra_d.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_sra_h.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_sra_w.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srar_b.c |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srar_d.c |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srar_h.c |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srar_w.c |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srl_b.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srl_d.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srl_h.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srl_w.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srlr_b.c |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srlr_d.c |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srlr_h.c |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srlr_w.c |  9 +++----
 .../mips64r6/bit-count/test_mips64r6_clo.c    |  7 ++----
 .../mips64r6/bit-count/test_mips64r6_clz.c    |  7 ++----
 .../mips64r6/bit-count/test_mips64r6_dclo.c   |  7 ++----
 .../mips64r6/bit-count/test_mips64r6_dclz.c   |  7 ++----
 .../mips64r6/bit-swap/test_mips64r6_bitswap.c |  7 ++----
 .../bit-swap/test_mips64r6_dbitswap.c         |  7 ++----
 .../int-multiply/test_mips64r6_dmuh.c         |  7 ++----
 .../int-multiply/test_mips64r6_dmuhu.c        |  7 ++----
 .../int-multiply/test_mips64r6_dmul.c         |  7 ++----
 .../int-multiply/test_mips64r6_dmulu.c        |  7 ++----
 .../mips64r6/int-multiply/test_mips64r6_muh.c |  7 ++----
 .../int-multiply/test_mips64r6_muhu.c         |  7 ++----
 .../mips64r6/int-multiply/test_mips64r6_mul.c |  7 ++----
 .../int-multiply/test_mips64r6_mulu.c         |  7 ++----
 .../isa/mips64r6/logic/test_mips64r6_and.c    |  7 ++----
 .../isa/mips64r6/logic/test_mips64r6_nor.c    |  7 ++----
 .../isa/mips64r6/logic/test_mips64r6_or.c     |  7 ++----
 .../isa/mips64r6/logic/test_mips64r6_xor.c    |  7 ++----
 .../isa/mips64r6/shift/test_mips64r6_dsllv.c  |  7 ++----
 .../isa/mips64r6/shift/test_mips64r6_dsrav.c  |  7 ++----
 .../isa/mips64r6/shift/test_mips64r6_dsrlv.c  |  7 ++----
 .../isa/mips64r6/shift/test_mips64r6_sllv.c   |  7 ++----
 .../isa/mips64r6/shift/test_mips64r6_srav.c   |  7 ++----
 .../isa/mips64r6/shift/test_mips64r6_srlv.c   |  7 ++----
 tools/i386/qemu-vmsr-helper.c                 |  5 +---
 309 files changed, 892 insertions(+), 1818 deletions(-)

diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index fe03bb4b5e..7301fce934 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -118,11 +118,8 @@ static void pca9554_write(PCA9554State *s, uint8_t reg, uint8_t data)
 static uint8_t pca9554_recv(I2CSlave *i2c)
 {
     PCA9554State *s = PCA9554(i2c);
-    uint8_t ret;
 
-    ret = pca9554_read(s, s->pointer & 0x3);
-
-    return ret;
+    return pca9554_read(s, s->pointer & 0x3);
 }
 
 static int pca9554_send(I2CSlave *i2c, uint8_t data)
diff --git a/hw/i386/kvm/xen_xenstore.c b/hw/i386/kvm/xen_xenstore.c
index 17802aa33d..227ad7ace3 100644
--- a/hw/i386/kvm/xen_xenstore.c
+++ b/hw/i386/kvm/xen_xenstore.c
@@ -209,7 +209,6 @@ static int xen_xenstore_post_load(void *opaque, int ver)
 {
     XenXenstoreState *s = opaque;
     GByteArray *save;
-    int ret;
 
     /*
      * As qemu/dom0, rebind to the guest's port. The Windows drivers may
@@ -231,8 +230,7 @@ static int xen_xenstore_post_load(void *opaque, int ver)
     s->impl_state = NULL;
     s->impl_state_size = 0;
 
-    ret = xs_impl_deserialize(s->impl, save, xen_domid, fire_watch_cb, s);
-    return ret;
+    return xs_impl_deserialize(s->impl, save, xen_domid, fire_watch_cb, s);
 }
 
 static const VMStateDescription xen_xenstore_vmstate = {
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index dae46f4733..4281f3083e 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1275,27 +1275,22 @@ static FWCfgState *create_fw_cfg(const MachineState *ms)
 static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
                                      int base_hartid, int hart_count)
 {
-    DeviceState *ret;
     g_autofree char *plic_hart_config = NULL;
 
     /* Per-socket PLIC hart topology configuration string */
     plic_hart_config = riscv_plic_hart_config_string(hart_count);
 
     /* Per-socket PLIC */
-    ret = sifive_plic_create(
-            memmap[VIRT_PLIC].base + socket * memmap[VIRT_PLIC].size,
-            plic_hart_config, hart_count, base_hartid,
-            VIRT_IRQCHIP_NUM_SOURCES,
-            ((1U << VIRT_IRQCHIP_NUM_PRIO_BITS) - 1),
-            VIRT_PLIC_PRIORITY_BASE,
-            VIRT_PLIC_PENDING_BASE,
-            VIRT_PLIC_ENABLE_BASE,
-            VIRT_PLIC_ENABLE_STRIDE,
-            VIRT_PLIC_CONTEXT_BASE,
-            VIRT_PLIC_CONTEXT_STRIDE,
-            memmap[VIRT_PLIC].size);
-
-    return ret;
+    return sifive_plic_create(
+             memmap[VIRT_PLIC].base + socket * memmap[VIRT_PLIC].size,
+             plic_hart_config, hart_count, base_hartid,
+             VIRT_IRQCHIP_NUM_SOURCES,
+             ((1U << VIRT_IRQCHIP_NUM_PRIO_BITS) - 1),
+             VIRT_PLIC_PRIORITY_BASE, VIRT_PLIC_PENDING_BASE,
+             VIRT_PLIC_ENABLE_BASE, VIRT_PLIC_ENABLE_STRIDE,
+             VIRT_PLIC_CONTEXT_BASE,
+             VIRT_PLIC_CONTEXT_STRIDE,
+             memmap[VIRT_PLIC].size);
 }
 
 static DeviceState *virt_create_aia(RISCVVirtAIAType aia_type, int aia_guests,
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index ac841dc32e..01bdfe2701 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -242,10 +242,7 @@ static uint32_t esp_get_stc(ESPState *s)
 
 static uint8_t esp_pdma_read(ESPState *s)
 {
-    uint8_t val;
-
-    val = esp_fifo_pop(s);
-    return val;
+    return esp_fifo_pop(s);
 }
 
 static void esp_pdma_write(ESPState *s, uint8_t val)
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 1a0d9290f8..d8aad4e1ce 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -110,8 +110,6 @@ static bool vfio_multiple_devices_migration_is_supported(void)
 
 int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
 {
-    int ret;
-
     if (vfio_multiple_devices_migration_is_supported()) {
         return 0;
     }
@@ -129,9 +127,8 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
     error_setg(&multiple_devices_migration_blocker,
                "Multiple VFIO devices migration is supported only if all of "
                "them support P2P migration");
-    ret = migrate_add_blocker_normal(&multiple_devices_migration_blocker, errp);
-
-    return ret;
+    return migrate_add_blocker_normal(&multiple_devices_migration_blocker,
+                                      errp);
 }
 
 void vfio_unblock_multiple_devices_migration(void)
diff --git a/plugins/api.c b/plugins/api.c
index 604ce06802..3c9d4832e9 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -237,12 +237,10 @@ uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb)
 struct qemu_plugin_insn *
 qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx)
 {
-    struct qemu_plugin_insn *insn;
     if (unlikely(idx >= tb->n)) {
         return NULL;
     }
-    insn = g_ptr_array_index(tb->insns, idx);
-    return insn;
+    return g_ptr_array_index(tb->insns, idx);
 }
 
 /*
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 646dbf59de..182881a237 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -543,7 +543,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
                           target_ulong level, uint32_t mem_idx)
 {
     CPUState *cs = env_cpu(env);
-    target_ulong badvaddr, index, phys, ret;
+    target_ulong badvaddr, index, phys;
     uint64_t dir_base, dir_width;
 
     if (unlikely((level == 0) || (level > 4))) {
@@ -571,8 +571,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     get_dir_base_width(env, &dir_base, &dir_width, level);
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
     phys = base | index << 3;
-    ret = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
-    return ret;
+    return ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
 }
 
 void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
diff --git a/tests/qtest/cmsdk-apb-watchdog-test.c b/tests/qtest/cmsdk-apb-watchdog-test.c
index 53538f98c9..cd0c602361 100644
--- a/tests/qtest/cmsdk-apb-watchdog-test.c
+++ b/tests/qtest/cmsdk-apb-watchdog-test.c
@@ -364,8 +364,6 @@ static void test_watchdog_inten_luminary(const void *ptr)
 
 int main(int argc, char **argv)
 {
-    int r;
-
     g_test_init(&argc, &argv, NULL);
     g_test_set_nonfatal_assertions();
 
@@ -393,7 +391,5 @@ int main(int argc, char **argv)
                             test_watchdog_inten);
     }
 
-    r = g_test_run();
-
-    return r;
+    return g_test_run();
 }
diff --git a/tests/qtest/pnv-host-i2c-test.c b/tests/qtest/pnv-host-i2c-test.c
index 7f64d597ac..51e613ebdc 100644
--- a/tests/qtest/pnv-host-i2c-test.c
+++ b/tests/qtest/pnv-host-i2c-test.c
@@ -191,12 +191,10 @@ static uint8_t pnv_i2c_pca9554_read_pins(PnvI2cDev *dev)
 {
     uint8_t send_buf[1];
     uint8_t recv_buf[1];
-    uint8_t inputs;
     send_buf[0] = PCA9554_INPUT;
     pnv_i2c_send(dev, send_buf, 1);
     pnv_i2c_recv(dev, recv_buf, 1);
-    inputs = recv_buf[0];
-    return inputs;
+    return recv_buf[0];
 }
 
 static void pnv_i2c_pca9554_flip_polarity(PnvI2cDev *dev)
diff --git a/tests/qtest/stm32l4x5_usart-test.c b/tests/qtest/stm32l4x5_usart-test.c
index 927bab6361..98a7472307 100644
--- a/tests/qtest/stm32l4x5_usart-test.c
+++ b/tests/qtest/stm32l4x5_usart-test.c
@@ -360,8 +360,6 @@ static void test_clock_enable(void)
 
 int main(int argc, char **argv)
 {
-    int ret;
-
     g_test_init(&argc, &argv, NULL);
     g_test_set_nonfatal_assertions();
 
@@ -372,8 +370,6 @@ int main(int argc, char **argv)
     qtest_add_func("stm32l4x5/usart/send_str", test_send_str);
     qtest_add_func("stm32l4x5/usart/ack", test_ack);
     qtest_add_func("stm32l4x5/usart/clock_enable", test_clock_enable);
-    ret = g_test_run();
-
-    return ret;
+    return g_test_run();
 }
 
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c
index 6ceb5aab20..492df6069d 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Count";
     char *instruction_name =  "NLOC.B";
-    int32_t ret;
     uint32_t i;
     struct timeval start, end;
     double elapsed_time;
@@ -141,9 +140,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c
index 897e90fbbc..52ade86b52 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Count";
     char *instruction_name =  "NLOC.D";
-    int32_t ret;
     uint32_t i;
     struct timeval start, end;
     double elapsed_time;
@@ -141,9 +140,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c
index 85cf3e6f70..51a96e25a2 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Count";
     char *instruction_name =  "NLOC.H";
-    int32_t ret;
     uint32_t i;
     struct timeval start, end;
     double elapsed_time;
@@ -141,9 +140,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c
index 7ed97be2b4..c2729eb084 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Count";
     char *instruction_name =  "NLOC.W";
-    int32_t ret;
     uint32_t i;
     struct timeval start, end;
     double elapsed_time;
@@ -141,9 +140,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c
index 2103d5fbfe..09909912f0 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Count";
     char *instruction_name =  "NLZC.B";
-    int32_t ret;
     uint32_t i;
     struct timeval start, end;
     double elapsed_time;
@@ -141,9 +140,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c
index b1ca3d44aa..7bf8193066 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Count";
     char *instruction_name =  "NLZC.D";
-    int32_t ret;
     uint32_t i;
     struct timeval start, end;
     double elapsed_time;
@@ -141,9 +140,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c
index 6531c67a86..34a7e3a8ae 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Count";
     char *instruction_name =  "NLZC.H";
-    int32_t ret;
     uint32_t i;
     struct timeval start, end;
     double elapsed_time;
@@ -141,9 +140,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c
index 71db53c9fe..2a6b066009 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Count";
     char *instruction_name =  "NLZC.W";
-    int32_t ret;
     uint32_t i;
     struct timeval start, end;
     double elapsed_time;
@@ -141,9 +140,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c
index 184f7f4a49..cdd9b17dbb 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Count";
     char *instruction_name =  "PCNT.B";
-    int32_t ret;
     uint32_t i;
     struct timeval start, end;
     double elapsed_time;
@@ -141,9 +140,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c
index 3cc0d851b2..ebb982bf6a 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Count";
     char *instruction_name =  "PCNT.D";
-    int32_t ret;
     uint32_t i;
     struct timeval start, end;
     double elapsed_time;
@@ -141,9 +140,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c
index f1052b3c26..9d6007793d 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Count";
     char *instruction_name =  "PCNT.H";
-    int32_t ret;
     uint32_t i;
     struct timeval start, end;
     double elapsed_time;
@@ -141,9 +140,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c
index 625ef29406..417cffbe41 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Count";
     char *instruction_name =  "PCNT.W";
-    int32_t ret;
     uint32_t i;
     struct timeval start, end;
     double elapsed_time;
@@ -141,9 +140,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_b.c b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_b.c
index 4a34f69953..6c85b60241 100644
--- a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_b.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Move";
     char *instruction_name =  "BINSL.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_d.c b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_d.c
index 0fc44fa195..9a60711b6e 100644
--- a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Move";
     char *instruction_name =  "BINSL.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_h.c b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_h.c
index cc2db04a2d..a8521f5e34 100644
--- a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_h.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Move";
     char *instruction_name =  "BINSL.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_w.c b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_w.c
index 21d6eec4db..164a8d8ba3 100644
--- a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Move";
     char *instruction_name =  "BINSL.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_b.c b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_b.c
index b1927c5c34..da64a04470 100644
--- a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_b.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Move";
     char *instruction_name =  "BINSR.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_d.c b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_d.c
index 6499415daa..02b360c0ec 100644
--- a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Move";
     char *instruction_name =  "BINSR.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_h.c b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_h.c
index 2dc3dbe89b..c0fdc8225d 100644
--- a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_h.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Move";
     char *instruction_name =  "BINSR.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_w.c b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_w.c
index 5073187340..33f36cb8ec 100644
--- a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Move";
     char *instruction_name =  "BINSR.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_bmnz_v.c b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_bmnz_v.c
index ba1c635087..2704a563bc 100644
--- a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_bmnz_v.c
+++ b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_bmnz_v.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Move";
     char *instruction_name =  "BMNZ.V";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_bmz_v.c b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_bmz_v.c
index b38ddc2c12..91ba1a58ce 100644
--- a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_bmz_v.c
+++ b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_bmz_v.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Move";
     char *instruction_name =  "BMZ.V";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_bsel_v.c b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_bsel_v.c
index 062e5a2fa0..c1572dada4 100644
--- a/tests/tcg/mips/user/ase/msa/bit-move/test_msa_bsel_v.c
+++ b/tests/tcg/mips/user/ase/msa/bit-move/test_msa_bsel_v.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Move";
     char *instruction_name =  "BSEL.V";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_b.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_b.c
index 56fdee3f31..32135a49ad 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_b.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Set";
     char *instruction_name =  "BCLR.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_d.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_d.c
index 0accccf093..e33b8c0cb8 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Set";
     char *instruction_name =  "BCLR.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_h.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_h.c
index 474e5297b8..a4bec519f9 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_h.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Set";
     char *instruction_name =  "BCLR.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_w.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_w.c
index 818b12ff0a..0eccfb43b0 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Set";
     char *instruction_name =  "BCLR.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_b.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_b.c
index 78ba32f360..82acdaf934 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_b.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Set";
     char *instruction_name =  "BNEG.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_d.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_d.c
index 44cd608688..20f25d9ed4 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Set";
     char *instruction_name =  "BNEG.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_h.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_h.c
index 5d17ceeba3..9fa1589889 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_h.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Set";
     char *instruction_name =  "BNEG.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_w.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_w.c
index 90d21f453d..4a34674e1d 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Set";
     char *instruction_name =  "BNEG.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_b.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_b.c
index 8aabf4bb88..c00df3b27c 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_b.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Set";
     char *instruction_name =  "BSET.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_d.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_d.c
index e3f9a7e4ca..2e144a4f7f 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Set";
     char *instruction_name =  "BSET.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_h.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_h.c
index cf9f608180..9e65c920cc 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_h.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Set";
     char *instruction_name =  "BSET.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_w.c b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_w.c
index 77478116f2..0fc8c01975 100644
--- a/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Bit Set";
     char *instruction_name =  "BSET.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_madd_q_h.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_madd_q_h.c
index 29a2990011..1b7240bce6 100644
--- a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_madd_q_h.c
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_madd_q_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Fixed Multiply";
     char *instruction_name =  "MADD_Q.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -208,9 +207,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_madd_q_w.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_madd_q_w.c
index 529d60d1e9..098d17658e 100644
--- a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_madd_q_w.c
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_madd_q_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Fixed Multiply";
     char *instruction_name =  "MADD_Q.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -208,9 +207,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_h.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_h.c
index a4713f2321..9bee226fe6 100644
--- a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_h.c
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Fixed Multiply";
     char *instruction_name =  "MADDR_Q.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -208,9 +207,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_w.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_w.c
index 19eccbf5ba..6d34e88056 100644
--- a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_w.c
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_maddr_q_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Fixed Multiply";
     char *instruction_name =  "MADDR_Q.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -208,9 +207,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msub_q_h.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msub_q_h.c
index b584736ed1..2ae0f52b5a 100644
--- a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msub_q_h.c
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msub_q_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Fixed Multiply";
     char *instruction_name =  "MSUB_Q.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -208,9 +207,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msub_q_w.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msub_q_w.c
index 56191924a1..a5af34f407 100644
--- a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msub_q_w.c
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msub_q_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Fixed Multiply";
     char *instruction_name =  "MSUB_Q.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -208,9 +207,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_h.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_h.c
index 0be6d51418..385d4492cd 100644
--- a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_h.c
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Fixed Multiply";
     char *instruction_name =  "MSUBR_Q.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -208,9 +207,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_w.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_w.c
index 7d57cb500a..e879df5ade 100644
--- a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_w.c
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_msubr_q_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Fixed Multiply";
     char *instruction_name =  "MSUBR_Q.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -208,9 +207,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_h.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_h.c
index cce7e9e8ac..31533f138d 100644
--- a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_h.c
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Fixed Multiply";
     char *instruction_name =  "MUL_Q.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_w.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_w.c
index 81d2635d7d..9e34d4d912 100644
--- a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_w.c
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mul_q_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Fixed Multiply";
     char *instruction_name =  "MUL_Q.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_h.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_h.c
index d5b00f1eb0..34a456673c 100644
--- a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_h.c
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Fixed Multiply";
     char *instruction_name =  "MULR_Q.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_w.c b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_w.c
index 78c9e22394..3d2f0ec8bd 100644
--- a/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_w.c
+++ b/tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_mulr_q_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Fixed Multiply";
     char *instruction_name =  "MULR_Q.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_d.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_d.c
index d9b49cea8c..f24092c1bb 100644
--- a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Float Max Min";
     char *instruction_name =  "FMAX_A.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_w.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_w.c
index f64276f2f1..7fa5fbc565 100644
--- a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_a_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Float Max Min";
     char *instruction_name =  "FMAX_A.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_d.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_d.c
index ba548e4882..b356cff346 100644
--- a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_d.c
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Float Max Min";
     char *instruction_name =  "FMAX.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_w.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_w.c
index f9aa24d62b..4efc663dda 100644
--- a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_w.c
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmax_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Float Max Min";
     char *instruction_name =  "FMAX.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_d.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_d.c
index 555aa133ae..b58c18a394 100644
--- a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Float Max Min";
     char *instruction_name =  "FMIN_A.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_w.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_w.c
index 9a81f1c6c5..e1071a9b9b 100644
--- a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_a_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Float Max Min";
     char *instruction_name =  "FMIN_A.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_d.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_d.c
index 97123c8c0b..30de267f46 100644
--- a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_d.c
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Float Max Min";
     char *instruction_name =  "FMIN.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_w.c b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_w.c
index 1e91136441..e28994a32f 100644
--- a/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_w.c
+++ b/tests/tcg/mips/user/ase/msa/float-max-min/test_msa_fmin_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Float Max Min";
     char *instruction_name =  "FMIN.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c
index c0a07b5552..fe5f21ec9d 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "ADD_A.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c
index 0771cdbdfe..9ad0d6ad10 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "ADD_A.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c
index 7956960d0f..4ccb7c150e 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "ADD_A.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c
index 590f440406..c97b1a157f 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "ADD_A.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c
index 42dd260726..d33e88d528 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "ADDS_A.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c
index 3e4e6f7f99..3817ba5013 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "ADDS_A.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c
index 2901a8174b..3cabc9695b 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "ADDS_A.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c
index 9e483e0754..41a88abaa0 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "ADDS_A.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c
index 955815bf45..b8d92f263d 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "ADDS_S.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c
index 0795f7e2c5..5738c255be 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "ADDS_S.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c
index 793c5afb8c..8237be9712 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "ADDS_S.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c
index 1c72c84669..aef671f171 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "ADDS_S.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c
index f20340799e..7714a3d755 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "ADDS_U.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c
index 30249edca0..b033651560 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "ADDS_U.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c
index 1bd8aa9d20..f1c43d8382 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "ADDS_U.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c
index a91c69f624..d8a9a54af3 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "ADDS_U.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c
index 2f11c76aa3..366174aa26 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "ADDV.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c
index 4ed0b97876..c0697e1864 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "ADDV.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c
index ca6ddd4b54..62c407032b 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "ADDV.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c
index dff0f70a07..7d8e9a1d4c 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "ADDV.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c
index c50a9dde87..2c9ec9a18f 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "HADD_S.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c
index 586ef923cc..2da7cca0bb 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "HADD_S.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c
index 3589c33940..0b87815964 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "HADD_S.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c
index 35b2021347..2431eb0e46 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "HADD_U.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c
index 3b38f9bb33..7cca3e32f0 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "HADD_U.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c
index fd420cb8de..de29d8d4d9 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Add";
     char *instruction_name =  "HADD_U.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_b.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_b.c
index 14ee4ab4db..34a9fc88c3 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Average";
     char *instruction_name =  "AVE_S.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_d.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_d.c
index ae7b3c8b89..6fb7c8d084 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Average";
     char *instruction_name =  "AVE_S.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_h.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_h.c
index d0d327e80f..e36b8a7d18 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Average";
     char *instruction_name =  "AVE_S.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_w.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_w.c
index 77010209fb..e0a0a845df 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Average";
     char *instruction_name =  "AVE_S.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_b.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_b.c
index c9e834e74d..379a362335 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Average";
     char *instruction_name =  "AVE_U.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_d.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_d.c
index 5462ffac0f..78607536df 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Average";
     char *instruction_name =  "AVE_U.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_h.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_h.c
index 10d57e5741..34e205d209 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Average";
     char *instruction_name =  "AVE_U.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_w.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_w.c
index 53106dee74..764b316976 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Average";
     char *instruction_name =  "AVE_U.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_b.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_b.c
index 465f54fc13..94c32c6039 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Average";
     char *instruction_name =  "AVER_S.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_d.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_d.c
index 391cb85ff0..5ca476e607 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Average";
     char *instruction_name =  "AVER_S.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_h.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_h.c
index 352b57d786..302b2dc4ca 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Average";
     char *instruction_name =  "AVER_S.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_w.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_w.c
index cfba37b0ae..eeabddf1f9 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Average";
     char *instruction_name =  "AVER_S.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_b.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_b.c
index 91f227b830..3dcdcd9c29 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Average";
     char *instruction_name =  "AVER_U.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_d.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_d.c
index fde57a2a5c..3874b61e45 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Average";
     char *instruction_name =  "AVER_U.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_h.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_h.c
index b9ec39a3de..54b0b0bd11 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Average";
     char *instruction_name =  "AVER_U.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_w.c b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_w.c
index dc3c2e432e..b8c39cad6a 100644
--- a/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Average";
     char *instruction_name =  "AVER_U.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c
index c9a9ee227d..24ee133e09 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Compare";
     char *instruction_name =  "CEQ.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c
index 542c460f2f..90e8ebba27 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Compare";
     char *instruction_name =  "CEQ.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c
index 3ebe59550c..5f578092be 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Compare";
     char *instruction_name =  "CEQ.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c
index 003acf1544..18ce27752b 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Compare";
     char *instruction_name =  "CEQ.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c
index ff20f0ea0e..c2705bf374 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Compare";
     char *instruction_name =  "CLE_S.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c
index 3dc18bd661..6f4b6842cf 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Compare";
     char *instruction_name =  "CLE_S.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c
index 00c48d657b..7d51c2617f 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Compare";
     char *instruction_name =  "CLE_S.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c
index 16f84a13e7..0c90e79113 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Compare";
     char *instruction_name =  "CLE_S.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c
index 24574dc30d..a434b5382e 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Compare";
     char *instruction_name =  "CLE_U.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c
index e3f571545d..f355352093 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Compare";
     char *instruction_name =  "CLE_U.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c
index 8938d31c59..d443e41f3c 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Compare";
     char *instruction_name =  "CLE_U.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c
index 078a0c1815..bbc96d3ee6 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Compare";
     char *instruction_name =  "CLE_U.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c
index 02c3dfa09e..2066c25e94 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Compare";
     char *instruction_name =  "CLT_S.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c
index 40637e2761..7a49f490b3 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Compare";
     char *instruction_name =  "CLT_S.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c
index ee3cd628fc..287d5d122a 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Compare";
     char *instruction_name =  "CLT_S.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c
index bde4d95350..dad15b19fa 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Compare";
     char *instruction_name =  "CLT_S.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c
index 147bf484b7..28f1d20d7e 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Compare";
     char *instruction_name =  "CLT_U.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c
index 5daf716726..55f6295cfa 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Compare";
     char *instruction_name =  "CLT_U.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c
index 8d51c2cc3c..425004a010 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Compare";
     char *instruction_name =  "CLT_U.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c
index 5403af8688..9da360a493 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Compare";
     char *instruction_name =  "CLT_U.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c
index f263201e72..b21b527609 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Divide";
     char *instruction_name =  "DIV_S.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c
index 0458f933f6..04d61827c7 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Divide";
     char *instruction_name =  "DIV_S.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c
index fffe7be072..e26fd8651b 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Divide";
     char *instruction_name =  "DIV_S.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c
index 22fa184d80..e2188aabf1 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Divide";
     char *instruction_name =  "DIV_S.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c
index 8097d6c864..fbb1465804 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Divide";
     char *instruction_name =  "DIV_U.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c
index 54d6fda1f2..26dfa27937 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Divide";
     char *instruction_name =  "DIV_U.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c
index 5a729906ac..f018e37f7c 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Divide";
     char *instruction_name =  "DIV_U.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c
index e9e2da4718..73928c83e3 100644
--- a/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Divide";
     char *instruction_name =  "DIV_U.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c
index cb13ff3e75..d6df83c3c8 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Dot Product";
     char *instruction_name =  "DOTP_S.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c
index 19451ee57d..094ff32f55 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Dot Product";
     char *instruction_name =  "DOTP_S.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c
index e635888e6c..fcaead98e6 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Dot Product";
     char *instruction_name =  "DOTP_S.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c
index af4337d02c..c7771ac9a9 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Dot Product";
     char *instruction_name =  "DOTP_U.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c
index a87b72b121..09598a3b56 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Dot Product";
     char *instruction_name =  "DOTP_U.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c
index 05df4cb583..6dec27f839 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Dot Product";
     char *instruction_name =  "DOTP_U.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_d.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_d.c
index d039e1a785..eb234cea13 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Dot Product";
     char *instruction_name =  "DPADD_S.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_h.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_h.c
index bcaafe3b71..d0441d0fa9 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_h.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Dot Product";
     char *instruction_name =  "DPADD_S.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_w.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_w.c
index 90562ab8a5..90c629802b 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_s_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Dot Product";
     char *instruction_name =  "DPADD_S.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_d.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_d.c
index 106dc73d1f..a4662d9b19 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Dot Product";
     char *instruction_name =  "DPADD_U.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_h.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_h.c
index 5fae97e907..4227b45d53 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_h.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Dot Product";
     char *instruction_name =  "DPADD_U.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_w.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_w.c
index 2bea9f669b..89760c500c 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpadd_u_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Dot Product";
     char *instruction_name =  "DPADD_U.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_d.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_d.c
index 560e29a248..0e300688a3 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Dot Product";
     char *instruction_name =  "DPSUB_S.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_h.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_h.c
index 3fb88ab5c2..e1592a8dd3 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_h.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Dot Product";
     char *instruction_name =  "DPSUB_S.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_w.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_w.c
index b95878b67b..06fbd05866 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_s_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Dot Product";
     char *instruction_name =  "DPSUB_S.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_d.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_d.c
index fc6c4e61dc..ea541f986d 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Dot Product";
     char *instruction_name =  "DPSUB_U.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_h.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_h.c
index 741c887bbd..3213d2d6a6 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_h.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Dot Product";
     char *instruction_name =  "DPSUB_U.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_w.c b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_w.c
index 3e1b711b61..9239d6bea1 100644
--- a/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dpsub_u_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Dot Product";
     char *instruction_name =  "DPSUB_U.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c
index 7e984a786e..a6b0344da5 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MAX_A.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c
index 3dfdb482f4..289fb857cf 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MAX_A.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c
index e1d65f98dc..cace99353f 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MAX_A.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c
index 600f60af56..4d06125989 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MAX_A.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c
index ab4161f20c..5edd33d0b7 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MAX_S.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c
index 54a78ae56a..bf0d4d91be 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MAX_S.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c
index 79b1e0adfd..727776bc79 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MAX_S.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c
index 32e32456eb..61ded97163 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MAX_S.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c
index a63d226279..eeccb68469 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MAX_U.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c
index 815a9ef497..acedbec408 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MAX_U.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c
index b668b39507..41e319f98b 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MAX_U.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c
index 3329455f92..82858d9f13 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MAX_U.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c
index 8fdbfc3bd3..a9b7c59866 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MIN_A.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c
index 6a9f6bf10e..faaed4b822 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MIN_A.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c
index 67a40b96f3..4c05f96ce7 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MIN_A.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c
index d08cb9cea8..05d869e05f 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MIN_A.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c
index 048233bbab..d060b576ab 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MIN_S.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c
index 04e18ebdbf..40daff1839 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MIN_S.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c
index 3bf32d487a..ec852b2521 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MIN_S.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c
index eeb2ec9359..99034cb1e0 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MIN_S.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c
index bdebf68a49..9c7c6e0ba3 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MIN_U.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c
index fcd90167ed..4d21696208 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MIN_U.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c
index 16f54b79e1..80d09eb3c5 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MIN_U.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c
index 574c169d03..13169c7f28 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Max Min";
     char *instruction_name =  "MIN_U.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c
index 1533790cae..d1ae9dbd5e 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Modulo";
     char *instruction_name =  "MOD_S.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c
index a8237f4244..c693f9bea3 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Modulo";
     char *instruction_name =  "MOD_S.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c
index 5d6e4d63f8..85fc2546c5 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Modulo";
     char *instruction_name =  "MOD_S.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c
index 1b068f28f5..fd8b276b16 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Modulo";
     char *instruction_name =  "MOD_S.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c
index 0d9ddf5907..d6c5a69d70 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Modulo";
     char *instruction_name =  "MOD_U.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c
index 1c3aa2bb36..b1efdd4d0a 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Modulo";
     char *instruction_name =  "MOD_U.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c
index a17a69f1f3..a8a1fd8341 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Modulo";
     char *instruction_name =  "MOD_U.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c
index ac0f704b18..60bce8dba8 100644
--- a/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Modulo";
     char *instruction_name =  "MOD_U.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_b.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_b.c
index d543e1af28..6dcadca833 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_b.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Multiply";
     char *instruction_name =  "MADDV.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_d.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_d.c
index fda35f757b..81aae83587 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Multiply";
     char *instruction_name =  "MADDV.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_h.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_h.c
index a9ee9b328a..4012d3d20e 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_h.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Multiply";
     char *instruction_name =  "MADDV.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_w.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_w.c
index bc3f5d246e..7b898fea7a 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_maddv_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Multiply";
     char *instruction_name =  "MADDV.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_b.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_b.c
index 808c49d050..4ae7113079 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_b.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Multiply";
     char *instruction_name =  "MSUBV.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_d.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_d.c
index 9722dbd99f..372ef096bd 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Multiply";
     char *instruction_name =  "MSUBV.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_h.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_h.c
index 6c059c779c..1bef77d351 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_h.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Multiply";
     char *instruction_name =  "MSUBV.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_w.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_w.c
index 0a83db4787..87d3be6969 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msubv_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Multiply";
     char *instruction_name =  "MSUBV.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_b.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_b.c
index de1046820c..936f1caf78 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Multiply";
     char *instruction_name =  "MULV.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_d.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_d.c
index ae2ebef559..225a974b71 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Multiply";
     char *instruction_name =  "MULV.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_h.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_h.c
index 27479a82c5..40a3e8d27a 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Multiply";
     char *instruction_name =  "MULV.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_w.c b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_w.c
index adeb1bfa98..3f811481fb 100644
--- a/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Multiply";
     char *instruction_name =  "MULV.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c
index a3ab83b76c..e749711b0c 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "ASUB_S.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c
index ee46ffadf1..c87e94fc61 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "ASUB_S.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c
index 3262365907..f91b190289 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "ASUB_S.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c
index 51f9a69413..1957573f33 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "ASUB_S.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c
index e086214ef8..9078ad87c4 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "ASUB_U.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c
index 5640b65007..04197a9dc9 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "ASUB_U.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c
index a5bf2d2054..8aa2dd967b 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "ASUB_U.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c
index 772e90eedb..f1284cbda4 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "ASUB_U.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c
index 66137f5856..eb299784aa 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "HSUB_S.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c
index e66261b821..cf3e08102f 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "HSUB_S.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c
index 6d97abfe3c..5196a7194c 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "HSUB_S.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c
index 8f39a4525b..834f2326ff 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "HSUB_U.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c
index 6cc82fce29..5eca52dcfc 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "HSUB_U.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c
index b427e87a3a..a6bb5ccb36 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "HSUB_U.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c
index 5c1f810d66..3c103d8466 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "SUBS_S.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c
index 546c24c5c2..bd252173a6 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "SUBS_S.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c
index 24ddc826c3..bd11db11f2 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "SUBS_S.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c
index f6109a5331..7565933288 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "SUBS_S.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c
index f170912348..7d5539c31d 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "SUBS_U.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c
index bf647db221..36d90810e8 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "SUBS_U.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c
index c4616be3e9..97be4e046a 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "SUBS_U.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c
index 61052672ca..74affbcc1c 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "SUBS_U.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c
index 71ea14fa2d..694878288d 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "SUBSUS_U.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c
index 070c457c44..7ae1bb1120 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "SUBSUS_U.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c
index f98d010436..80f7ceb0a9 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "SUBSUS_U.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c
index d325c19217..0172cf2a06 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "SUBSUS_U.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c
index 66012b5894..741681f9d2 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "SUBSUU_S.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c
index 344a373055..d5b1dc7072 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "SUBSUU_S.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c
index 1cacb26395..4a488974cf 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "SUBSUU_S.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c
index 42f3ee56f6..3b62ef65af 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "SUBSUU_S.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_b.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_b.c
index b8bd085516..3095c78132 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_b.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "SUBV.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_d.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_d.c
index f532e4a69d..1d1b50d2ae 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_d.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "SUBV.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_h.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_h.c
index ac7f8ee6b5..b147a7ed7c 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_h.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "SUBV.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_w.c b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_w.c
index 93eeaecc7c..44b10d1145 100644
--- a/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_w.c
@@ -38,7 +38,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Int Subtract";
     char *instruction_name =  "SUBV.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -152,9 +151,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c
index 3506202cd9..ebbc530a45 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Interleave";
     char *instruction_name =  "ILVEV.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c
index 896b11dce0..94eb1d20c0 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Interleave";
     char *instruction_name =  "ILVEV.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c
index a68fea643f..2f8cc7ec5a 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Interleave";
     char *instruction_name =  "ILVEV.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c
index 6e168c701e..dd47b84b2b 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Interleave";
     char *instruction_name =  "ILVEV.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c
index 11cfbf398a..e6ae48ebbf 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Interleave";
     char *instruction_name =  "ILVL.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c
index 35581ee7ea..1a0b56af2e 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Interleave";
     char *instruction_name =  "ILVL.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c
index 0d89d95edd..13dbfbd3e7 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Interleave";
     char *instruction_name =  "ILVL.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c
index ce044889c3..84c13af6d2 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Interleave";
     char *instruction_name =  "ILVL.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c
index f7dd1d22b0..eb34133dfd 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Interleave";
     char *instruction_name =  "ILVOD.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c
index bef28d8ded..38bd1c2ed1 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Interleave";
     char *instruction_name =  "ILVOD.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c
index d2355c6676..36f0bc8574 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Interleave";
     char *instruction_name =  "ILVOD.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c
index 636a62d056..728a0b626c 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Interleave";
     char *instruction_name =  "ILVOD.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c
index 75bc9de9f9..4a6c78e9de 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Interleave";
     char *instruction_name =  "ILVR.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c
index a80aa446f8..1fc2877957 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Interleave";
     char *instruction_name =  "ILVR.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c
index caa00224fd..b828558cd9 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Interleave";
     char *instruction_name =  "ILVR.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c
index 65c89a3712..558546f4aa 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Interleave";
     char *instruction_name =  "ILVR.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c
index 22d1f9cc0f..79f56cc6f5 100644
--- a/tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Logic";
     char *instruction_name =  "AND.V";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c
index 3b9e481582..7fc327e3df 100644
--- a/tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Logic";
     char *instruction_name =  "NOR.V";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c
index e6e5da4efb..683bcb0962 100644
--- a/tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Logic";
     char *instruction_name =  "OR.V";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c
index 1b699b5ca4..a2b9e8e2f8 100644
--- a/tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Logic";
     char *instruction_name =  "XOR.V";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/move/test_msa_move_v.c b/tests/tcg/mips/user/ase/msa/move/test_msa_move_v.c
index ef2aa6dbdd..30b8ce10d5 100644
--- a/tests/tcg/mips/user/ase/msa/move/test_msa_move_v.c
+++ b/tests/tcg/mips/user/ase/msa/move/test_msa_move_v.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Move";
     char *instruction_name =  "MOVE.V";
-    int32_t ret;
     uint32_t i;
     struct timeval start, end;
     double elapsed_time;
@@ -141,9 +140,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
index 2f4ffd9195..7527240888 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Pack";
     char *instruction_name =  "PCKEV.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
index 3f0bd47ffd..b390c17a8f 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Pack";
     char *instruction_name =  "PCKEV.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
index 2eae01fa75..e351f62275 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Pack";
     char *instruction_name =  "PCKEV.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
index f7215d0e43..07c52042fa 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Pack";
     char *instruction_name =  "PCKEV.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
index 6355338332..23da0644c7 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Pack";
     char *instruction_name =  "PCKOD.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
index ac75526fda..55809f5ebe 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Pack";
     char *instruction_name =  "PCKOD.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
index 12c1fa1ea5..935d6127b3 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Pack";
     char *instruction_name =  "PCKOD.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
index b8979c3f43..8073d518e1 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Pack";
     char *instruction_name =  "PCKOD.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
index 1839a26ca7..f97f0ef142 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Pack";
     char *instruction_name =  "VSHF.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
index ebc198feb8..cdfcac31e0 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Pack";
     char *instruction_name =  "VSHF.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
index a7240134d7..a83f19439b 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Pack";
     char *instruction_name =  "VSHF.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
index 607ac4fb53..b5df87c4fb 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Pack";
     char *instruction_name =  "VSHF.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -206,9 +205,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c
index 649e67b6a1..99c5ab5573 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_b.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Shift";
     char *instruction_name =  "SLL.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c
index 1d6fe54207..089f6d3499 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Shift";
     char *instruction_name =  "SLL.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c
index 1e6c27bfe7..39186a3e76 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_h.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Shift";
     char *instruction_name =  "SLL.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c
index 8bfbaca6fc..2c85fd8131 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sll_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Shift";
     char *instruction_name =  "SLL.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c
index a5dcee3a72..90dc2830d6 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_b.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Shift";
     char *instruction_name =  "SRA.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c
index 95a13620b9..69b63b3cb6 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Shift";
     char *instruction_name =  "SRA.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c
index f00003d51c..0b7f5bc1b6 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_h.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Shift";
     char *instruction_name =  "SRA.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c
index f00da6d3d9..f4d8bb6747 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_sra_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Shift";
     char *instruction_name =  "SRA.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_b.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_b.c
index dcda9c2c95..6927e3359d 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_b.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_b.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Shift";
     char *instruction_name =  "SRAR.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_d.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_d.c
index 478098acd9..1f04aa93e7 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_d.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Shift";
     char *instruction_name =  "SRAR.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_h.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_h.c
index a30025548c..ec039c2127 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_h.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_h.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Shift";
     char *instruction_name =  "SRAR.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_w.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_w.c
index 027d4ce565..2483750f50 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_w.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srar_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Shift";
     char *instruction_name =  "SRAR.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c
index 0e7c453cec..b134e8b5ad 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_b.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Shift";
     char *instruction_name =  "SRL.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c
index f6351f875a..eff665db63 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Shift";
     char *instruction_name =  "SRL.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c
index 93394ef47a..5bed8f79c0 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_h.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Shift";
     char *instruction_name =  "SRL.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c
index c18cd9892a..d36d56a58f 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srl_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Shift";
     char *instruction_name =  "SRL.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c
index d173d8fa9c..9c6c1665c4 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_b.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Shift";
     char *instruction_name =  "SRLR.B";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c
index ecd7bd0c22..d5bae01f2d 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_d.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Shift";
     char *instruction_name =  "SRLR.D";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c
index ca7fd75342..f8352ed75d 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_h.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Shift";
     char *instruction_name =  "SRLR.H";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c
index ccbe6c0c84..af85949a48 100644
--- a/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c
+++ b/tests/tcg/mips/user/ase/msa/shift/test_msa_srlr_w.c
@@ -36,7 +36,6 @@ int32_t main(void)
     char *isa_ase_name = "MSA";
     char *group_name = "Shift";
     char *instruction_name =  "SRLR.W";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -150,9 +149,7 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_128(isa_ase_name, group_name, instruction_name,
-                            TEST_COUNT_TOTAL, elapsed_time,
-                            &b128_result[0][0], &b128_expect[0][0]);
-
-    return ret;
+    return check_results_128(isa_ase_name, group_name, instruction_name,
+                             TEST_COUNT_TOTAL, elapsed_time,
+                             &b128_result[0][0], &b128_expect[0][0]);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clo.c b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clo.c
index e7ecdc5910..02c4582f07 100644
--- a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clo.c
+++ b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clo.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Bit Count";
     char *instruction_name =   "CLO";
-    int32_t ret;
     uint32_t i;
     struct timeval start, end;
     double elapsed_time;
@@ -139,8 +138,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clz.c b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clz.c
index a77a8e4eb5..0575feae23 100644
--- a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clz.c
+++ b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clz.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Bit Count";
     char *instruction_name =   "CLZ";
-    int32_t ret;
     uint32_t i;
     struct timeval start, end;
     double elapsed_time;
@@ -139,8 +138,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclo.c b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclo.c
index eb41fbdfdf..562c21ac3b 100644
--- a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclo.c
+++ b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclo.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Bit Count";
     char *instruction_name =   "DCLO";
-    int32_t ret;
     uint32_t i;
     struct timeval start, end;
     double elapsed_time;
@@ -139,8 +138,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclz.c b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclz.c
index be393ac199..c987b1f899 100644
--- a/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclz.c
+++ b/tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclz.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Bit Count";
     char *instruction_name =   "DCLZ";
-    int32_t ret;
     uint32_t i;
     struct timeval start, end;
     double elapsed_time;
@@ -139,8 +138,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_bitswap.c b/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_bitswap.c
index df3d1b11f6..78484b2d1f 100644
--- a/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_bitswap.c
+++ b/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_bitswap.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Bit Swap";
     char *instruction_name =   "BITSWAP";
-    int32_t ret;
     uint32_t i;
     struct timeval start, end;
     double elapsed_time;
@@ -139,8 +138,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c b/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c
index 377835940d..d15950bb40 100644
--- a/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c
+++ b/tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Bit Swap";
     char *instruction_name =   "DBITSWAP";
-    int32_t ret;
     uint32_t i;
     struct timeval start, end;
     double elapsed_time;
@@ -139,8 +138,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuh.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuh.c
index eb21615f95..425f33486a 100644
--- a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuh.c
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuh.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Int Multiply";
     char *instruction_name =   "DMUH";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -146,8 +145,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuhu.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuhu.c
index 7316d79e2a..565fd39cab 100644
--- a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuhu.c
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuhu.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Int Multiply";
     char *instruction_name =   "DMUHU";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -146,8 +145,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmul.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmul.c
index 3ac1965cca..212bb92f21 100644
--- a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmul.c
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmul.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Int Multiply";
     char *instruction_name =   "DMUL";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -146,8 +145,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmulu.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmulu.c
index 0862780e3d..6482d0b94e 100644
--- a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmulu.c
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmulu.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Int Multiply";
     char *instruction_name =   "DMULU";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -146,8 +145,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muh.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muh.c
index ff1ae6fd9c..dcfccfa2ce 100644
--- a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muh.c
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muh.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Int Multiply";
     char *instruction_name =   "MUH";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -146,8 +145,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muhu.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muhu.c
index cb2752767a..ccb960b931 100644
--- a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muhu.c
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muhu.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Int Multiply";
     char *instruction_name =   "MUHU";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -146,8 +145,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mul.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mul.c
index 5cdc4d5632..8c8903400b 100644
--- a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mul.c
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mul.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Int Multiply";
     char *instruction_name =   "MUL";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -146,8 +145,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mulu.c b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mulu.c
index ccb3bdc1ac..f75b05046f 100644
--- a/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mulu.c
+++ b/tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mulu.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Int Multiply";
     char *instruction_name =   "MULU";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -146,8 +145,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_and.c b/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_and.c
index 4d6cf2e1f1..9bdba589f6 100644
--- a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_and.c
+++ b/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_and.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Logic";
     char *instruction_name =   "AND";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -146,8 +145,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_nor.c b/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_nor.c
index 21005ddc53..007310679d 100644
--- a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_nor.c
+++ b/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_nor.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Logic";
     char *instruction_name =   "NOR";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -146,8 +145,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_or.c b/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_or.c
index 345b4544fe..500446a422 100644
--- a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_or.c
+++ b/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_or.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Logic";
     char *instruction_name =   "OR";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -146,8 +145,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_xor.c b/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_xor.c
index 7e36fee517..f906d9a9ae 100644
--- a/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_xor.c
+++ b/tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_xor.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Logic";
     char *instruction_name =   "XOR";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -146,8 +145,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsllv.c b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsllv.c
index 4f719efda1..c853afada1 100644
--- a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsllv.c
+++ b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsllv.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Shift";
     char *instruction_name =   "DSLLV";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -146,8 +145,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrav.c b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrav.c
index 024d508ca8..459e2c2e4f 100644
--- a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrav.c
+++ b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrav.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Shift";
     char *instruction_name =   "DSRAV";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -146,8 +145,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrlv.c b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrlv.c
index fd1c398ffd..aee5cfae52 100644
--- a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrlv.c
+++ b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrlv.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Shift";
     char *instruction_name =   "DSRLV";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -146,8 +145,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_sllv.c b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_sllv.c
index a5fa72b727..6c7d2fcdee 100644
--- a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_sllv.c
+++ b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_sllv.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Shift";
     char *instruction_name =   "SLLV";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -146,8 +145,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srav.c b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srav.c
index 79e1a047eb..fccb200942 100644
--- a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srav.c
+++ b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srav.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Shift";
     char *instruction_name =   "SRAV";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -146,8 +145,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srlv.c b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srlv.c
index 1f8c45d8cc..77b92d4810 100644
--- a/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srlv.c
+++ b/tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srlv.c
@@ -34,7 +34,6 @@ int32_t main(void)
     char *isa_ase_name = "mips64r6";
     char *group_name = "Shift";
     char *instruction_name =   "SRLV";
-    int32_t ret;
     uint32_t i, j;
     struct timeval start, end;
     double elapsed_time;
@@ -146,8 +145,6 @@ int32_t main(void)
     elapsed_time = (end.tv_sec - start.tv_sec) * 1000.0;
     elapsed_time += (end.tv_usec - start.tv_usec) / 1000.0;
 
-    ret = check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
-                           b64_result, b64_expect);
-
-    return ret;
+    return check_results_64(instruction_name, TEST_COUNT_TOTAL, elapsed_time,
+                            b64_result, b64_expect);
 }
diff --git a/tools/i386/qemu-vmsr-helper.c b/tools/i386/qemu-vmsr-helper.c
index a35dcb88a3..5f19a48cbd 100644
--- a/tools/i386/qemu-vmsr-helper.c
+++ b/tools/i386/qemu-vmsr-helper.c
@@ -71,7 +71,6 @@ static void compute_default_paths(void)
 
 static int is_intel_processor(void)
 {
-    int result;
     int ebx, ecx, edx;
 
     /* Execute CPUID instruction with eax=0 (basic identification) */
@@ -87,9 +86,7 @@ static int is_intel_processor(void)
      *  0x49656e69 = "ineI"
      *  0x6c65746e = "ntel"
      */
-    result = (ebx == 0x756e6547) && (edx == 0x49656e69) && (ecx == 0x6c65746e);
-
-    return result;
+    return (ebx == 0x756e6547) && (edx == 0x49656e69) && (ecx == 0x6c65746e);
 }
 
 static int is_rapl_enabled(void)
-- 
2.48.1


