Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E51BE9539E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnd05-0001tH-W2; Wed, 04 Feb 2026 08:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vnd04-0001sS-2i
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:32:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vnd02-0005fT-4l
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770211972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fgiA3Z3I6KprQLx7Kyuv4KTVqZsq/O5u6yJXE+yDwY8=;
 b=POt0ImaBWpjsERwzFLDSbqaEzYQIi6z13F4Mn2J2DafCukT965ugRrTCpqNCv2mHPuEcr2
 QJdSzVn83U19CSWRupe3y+yUc/rfwo9wdwV7ZgCSAPwnQSbBiVaQHFVFHAHnpqckOK4B/R
 NvRmdcThOuUJuUkTRVxmarYSntC11MM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-r6aiPmgIMPK_dxMJDXQARA-1; Wed,
 04 Feb 2026 08:32:49 -0500
X-MC-Unique: r6aiPmgIMPK_dxMJDXQARA-1
X-Mimecast-MFC-AGG-ID: r6aiPmgIMPK_dxMJDXQARA_1770211968
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD7371800454; Wed,  4 Feb 2026 13:32:47 +0000 (UTC)
Received: from gondolin.str.redhat.com (dhcp-192-192.str.redhat.com
 [10.33.192.192])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 042221955D85; Wed,  4 Feb 2026 13:32:44 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 0/3] arm: demuxed ID registers (CCSIDR_EL1)
Date: Wed,  4 Feb 2026 14:32:26 +0100
Message-ID: <20260204133229.297061-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

[previously posted as RFC, but given that I got T-b and R-b, I promoted
it to full v2 :)]

Changes RFC->v2:
- use a proper #define so that it is clearer why we end up with that
  specific array size
- rebased on top of master
- collected T-bs and R-bs (thanks!)

Original cover letter follows. I'm not sure whether the questions contain
any actual blockers, or whether it is easier to just go ahead and deal
with it later.

--------8<---------8<--------

While trying to move to an autogenerated cpu-sysregs.h.inc (so that we
may keep a common view on registers), we should first address the ID
registers that are still kept outside of ARMISARegisters. Other than
DCZID_EL0 (addressed by the series this one goes on top of), that's
the CCSIDR_EL1 values kept in cpu->cssidr[] (indexed via CSSELR_EL1.)

My idea was to provide {GET,SET}_IDREG_DEMUX helper that work similar
to {GET,SET}_IDREG and operate on a two-dimensional array. As a side
effect, this also allows to get the values KVM provides for CCSIDR_EL1
(which are virtualized as well.)

RFC because there are still some open questions:
- The demux array cannot easily be autogenerated. We can get rid of the
  ccsidr[] array, but we now have an autogenerated entry in the non-demux
  array that does nothing. Both are not that nice.
- I'm not sure if we need any compat handling for KVM (on TCG, everything
  should stay the same.) In theory, the KVM interface allows setting
  values from userspace (I didn't try.)
- There's a slight disagreement between the current code (providing 16
  entries for CCSIDR_EL1) and the KVM code (providing (7 cache levels) *
  (data/unified, instruction) = 14 entries.) With FEAT_MTE2, we might be
  needing 7 more entries.

Feedback appreciated.

--------8<---------8<--------

Cornelia Huck (3):
  arm: handle demuxed ID registers
  arm: handle CCSIDR_EL1 as a demuxed register
  arm/kvm: get demuxed ID registers from kvm

 hw/intc/armv7m_nvic.c        |  2 +-
 target/arm/cpu-sysregs.h     | 14 +++++++++
 target/arm/cpu-sysregs.h.inc |  1 +
 target/arm/cpu.h             | 26 ++++++++++++----
 target/arm/cpu64.c           | 12 ++++----
 target/arm/helper.c          |  2 +-
 target/arm/kvm.c             | 33 ++++++++++++++++++++
 target/arm/tcg/cpu32.c       | 32 +++++++++----------
 target/arm/tcg/cpu64.c       | 60 ++++++++++++++++++------------------
 9 files changed, 122 insertions(+), 60 deletions(-)

-- 
2.52.0


