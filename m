Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D891C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 03:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scGfi-00088W-MG; Thu, 08 Aug 2024 23:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1scGfh-00086f-1T
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 23:52:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1scGff-0008MP-Ew
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 23:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723175526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JWDt4I+81m8CBbmiUvK537yFMwopmOQ1ObO7UTLy0pI=;
 b=UbhzHzH6wrjZVYjXZDgtWlFXSzvyLHh5B/Pzgn3o9cYvOYuTMZ6N1hp/y1gd99NSzUSiuY
 HAUfIgC6GG57OjDxo7rb7FExJgbIzGeJEU5Cqwkd6vsD5MXPb65xQTNrm/D/ssbgqGG4Kb
 TPqVoYSujZTjlNW6UZjHeumrJ7HgDkw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-TC-aA-HrOreojHNtPsrXWQ-1; Thu,
 08 Aug 2024 23:52:01 -0400
X-MC-Unique: TC-aA-HrOreojHNtPsrXWQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71E811944DEE; Fri,  9 Aug 2024 03:51:59 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.133])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B9C6195917D; Fri,  9 Aug 2024 03:51:53 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 philmd@linaro.org, richard.henderson@linaro.org, shan.gavin@gmail.com
Subject: [PATCH 0/4] hw/arm/virt: Improve virt_kvm_type()
Date: Fri,  9 Aug 2024 13:51:29 +1000
Message-ID: <20240809035134.699830-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

hw/arm/virt.c::virt_kvm_type() can be improved due to the facts as
below, when I inspect the code to review Salil's (RFCv3) vCPU hotplug
series.

  * virt_kvm_type() and MachineClass::kvm_type() are needed only when
    CONFIG_KVM is enabled.

  * kvm_arm_get_max_vm_ipa_size() and kvm_arch_get_default_type() are
    generally interchangeable with the exception that type zero is
    corresponding to IPA size (bits) 40. So it's unecessary to keep
    both APIs.

Lets clean it up so that kvm_arm_get_max_vm_ipa_size() is eventually
removed. kvm_arch_get_default_type() is used to get the KVM type and
IPA size (bits).

Gavin Shan (4):
  hw/arm/virt: hide virt_kvm_type() on !CONFIG_KVM
  hw/arm/virt: Avoid multiple lines of comments in virt_kvm_type()
  hw/arm/virt: Use kvm_arch_get_default_type()
  target/arm/kvm: Remove kvm_arm_get_max_vm_ipa_size()

 hw/arm/virt.c        | 22 +++++++++++-----------
 target/arm/kvm.c     | 13 ++-----------
 target/arm/kvm_arm.h | 15 ---------------
 3 files changed, 13 insertions(+), 37 deletions(-)

-- 
2.45.2


