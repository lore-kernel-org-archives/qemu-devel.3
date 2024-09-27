Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6382ECEBF8E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 10:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su8W1-0002Kh-Jm; Fri, 27 Sep 2024 06:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1su8W0-0002KA-7a
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 06:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1su8Vy-00056P-7P
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 06:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727434076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=eDwNjzYvzNb05JfJ9Jj4EDMG+8f2fEE27qxBG5rcjrw=;
 b=NX2e8xy50F1x/Z/ho+HmgXT83BCoWq6FX2W2H0qSRD2rlutof8pa7V+/s3BYG+kkaYkxFJ
 9lyh2J3frgswUVN6usmcvEcDaR/kHhAirnXLRbdR9qY80/YozvYglE9MsNzg3zh28XUO7R
 DziNu4sKMkqZHaczaDdLbcwFszpvA8A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-pOxnD33rN5emDBVh9KDUcA-1; Fri,
 27 Sep 2024 06:47:53 -0400
X-MC-Unique: pOxnD33rN5emDBVh9KDUcA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D67A21975AE8; Fri, 27 Sep 2024 10:47:51 +0000 (UTC)
Received: from tpx1cg9.redhat.com (unknown [10.39.192.103])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 924821956086; Fri, 27 Sep 2024 10:47:46 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Julia Suvorova <jusual@redhat.com>
Subject: [PATCH v2 0/2] kvm: Improve register failure reports for migration
Date: Fri, 27 Sep 2024 12:47:39 +0200
Message-ID: <20240927104743.218468-1-jusual@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jusual@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

There were a few bugs with silent cpu failures during migrations [1].
The failures are no longer silent thanks to [2], but still
indistinguishable, making diagnostics difficult.

This patchset reworks kvm_arch_get/put_registers to handle Error** and
return a correct message, with x86_64 as a start.

[1] https://issues.redhat.com/browse/RHEL-7558
[2] 7191f24c7fcf "accel/kvm/kvm-all: Handle register access errors"

--
v2:
    * made all reports as error_reportf_err() and fixed prefixes [Peter]

Julia Suvorova (2):
  kvm: Allow kvm_arch_get/put_registers to accept Error**
  target/i386/kvm: Report which action failed in
    kvm_arch_put/get_registers

 accel/kvm/kvm-all.c        | 41 +++++++++++++++++++++++++++++---------
 include/sysemu/kvm.h       |  4 ++--
 target/arm/kvm.c           |  4 ++--
 target/i386/kvm/kvm.c      | 27 +++++++++++++++++++++++--
 target/loongarch/kvm/kvm.c |  4 ++--
 target/mips/kvm.c          |  4 ++--
 target/ppc/kvm.c           |  2 +-
 target/riscv/kvm/kvm-cpu.c |  4 ++--
 target/s390x/kvm/kvm.c     |  4 ++--
 9 files changed, 70 insertions(+), 24 deletions(-)

-- 
2.45.0


