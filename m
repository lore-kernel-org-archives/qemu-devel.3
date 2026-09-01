Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953F9C624CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 10:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LQw-0002UP-Hl; Tue, 01 Sep 2026 06:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x1LQv-0002UA-JP
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:09:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x1LQr-0000uX-SP
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788257372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0Dzi1bBTzXXjpEm5tVaw17VipUCXdh9YJHGDHV+JNAg=;
 b=OmQhLAoQn9m8fT2fiG4y4Y4PIrWBESlpoq3F2OKP0kjAtCJmRt40/1P+7DVowL0hI+07UY
 Q0w50AXG0XPFFNw/esgHR3r/opGLgXOPGCH6s14Ym+OixDQzYj21V1K7AGXEzewfkK6wJT
 D898mEWT2ZTo8cg2+m/nchiafjS1m9w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-OpTciXhmM220K73tMOYDkA-1; Tue, 01 Sept 2026 06:09:30 -0400
X-MC-Unique: OpTciXhmM220K73tMOYDkA-1
X-Mimecast-MFC-AGG-ID: OpTciXhmM220K73tMOYDkA_1788257369
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4957287363bso30685465e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 03:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788257369; x=1788862169; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0Dzi1bBTzXXjpEm5tVaw17VipUCXdh9YJHGDHV+JNAg=;
 b=DLaF7BBkfZGHS1ZWLNxia34v7hjQq1OPgrQ9Up6XO1vXrXR5SaEbWOkw6ILZnXmMZQ
 Ei2htGYuw2zHDwtLW9hIq9rLoABg1FRsaAgdm+XJdS0cPpLEamt9iBsEZ4u+nm7U12cE
 5cGiq9l08Tc6nyfdBMEHljsZzUG/sDwzB9Z3VpGcX9Lw6Gf1e7h+Zl+Ots8s6leh0xep
 OkhEUG4MnjUn4aT4ue5PFU0FbJiPPArFMGCuk/BVwKrEanTiWr3uxqNKdfvSZjW+pllU
 NYIomScR3lCZ4i0sJ5G5S4jVzIa/rz9hXNxWBmzU3U2Ksevmqz1Xy1Xj7vRiD3saP5Iz
 MXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788257369; x=1788862169;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0Dzi1bBTzXXjpEm5tVaw17VipUCXdh9YJHGDHV+JNAg=;
 b=ixmOf7JAXTDM4YCzSRqqDcsJsVixVUi5eDdw9hhecwPhfG+2KrlYMd626Rdf/Q2Rtt
 e6zsTssz3l6QRwG1r+wIxEr0d7r1sQK8CeU339ZHIHs4gid819k8WCAgqGbIWOIPlHAU
 os34TVWEUxvb/h7WWJGpEXnpK1hR3mRUHKAwjUKVz9/Yy6jfxEeMQYCo4itPlBbCffME
 +ayOHfYs37MPOYPYj+D7gNc+EtKKDOYu344l4jWnBsCN0MO4bvMGypk94ZpgJ1ftmLaz
 ZpOEXDmLJ4Z2t53K81USw7W2ygzau4QKQzFRtf396qFdWmeFJgrfKKc5cJ24eNj8ElXW
 V1eQ==
X-Gm-Message-State: AFuF++lGOsWRZSFoXJaqVesee7C+WAKhQ3lMCSci8BpG/GA5JJGJ3Wm6
 WWWI4sxKkRttC0BGpC2pT9sAGjfvM7RU70uhYW856+mkRkfplPjomNzcS0cxNH8I706AYwCYkvJ
 zXyjqQmu3/KEfyVWsxfLq7+Sz4SmK+7t/blaPlWsD6qTMDw0x6HId83PU
X-Gm-Gg: AYBFou1Sr8zdVI4RODrp7144lxnjWplVm2eqgfe+MLZLm9tiolFcVZupfGvIzUtQIxz
 0Uy/c58H8tKM/aN6MhUNiCHBryngP7yaA99+wOLLGJrqfTQWtau5SV0qwhLuiBSK7cQp49COChM
 FlLJYBrnKgIo3fBfX0vaWo+QYp2AYmV8aUyrWjj1fXN//WDv+y1tautFDjKKD55LILHTXr7XWCS
 x7BTzJTf+HuEEaOCNzXl5fDIdv8m6l7BJBw42N/HH+Zkt9tMdbyjozkrUmJnNOcw/jiWlgrbw3a
 o8FIkOXYHg6qwi5aGT2QUZvaIr4WF/DN7T3NHNexV+3s9YFgWV0XG+CgtRbB0b9EwDTOKUjkSun
 YWriNDiu5fHnrN7Cpom9b2aUwG3JLg3eb9j9bA28NtIgh3CBI4RpHGi+pbZvz9UgozS45
X-Received: by 2002:a5d:5e01:0:b0:480:c5:d635 with SMTP id
 ffacd0b85a97d-482f782a4a2mr47922506f8f.0.1788257369552; 
 Tue, 01 Sep 2026 03:09:29 -0700 (PDT)
X-Received: by 2002:a5d:5e01:0:b0:480:c5:d635 with SMTP id
 ffacd0b85a97d-482f782a4a2mr47922420f8f.0.1788257369163; 
 Tue, 01 Sep 2026 03:09:29 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d7c1c0sm3941620f8f.32.2026.09.01.03.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 03:09:28 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH 0/4] igvm/sev: apply the IGVM guest policy before launch
Date: Tue, 01 Sep 2026 12:09:17 +0200
Message-Id: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MWwqAIBAAryL7naBGUV0lQky3WughClJId0/6H
 JiZDBEDYYSBZQiYKNJ1FpAVA7uZc0VOrjAooVrR1ZIvdGta06H9tZN9uJh75bBRzrUGSuUDFuU
 /jtP7fiupNzFhAAAA
X-Change-ID: 20260831-fix_igvm_policy-0b92de52dd6a
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The guest policy from an IGVM file never actually made it to the platform
before launch. The callback that was supposed to forward it ran after
LAUNCH_START, so it did nothing and the guest was launched with the
default policy instead of the one requested by the file.

The policy is part of the attestation report, so this quietly breaks
attestation: the resulting measurement does not match what the IGVM file
was built for.

Patches 1 to 3 are cleanups needed to get there: dropping an overloaded
callback, moving the SNP ID block handling and giving the policy
properties proper accessors. Patch 4 is the actual fix.

One thing worth calling out: if a policy is also passed on the command
line and it differs from the IGVM one, we now return an error instead of
silently picking one over the other.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Luigi Leonardi (4):
      sev: rename set_guest_policy to set_id_block and remove dead policy code
      igvm: move set_id_block call into the SNP ID block directive handler
      i386/sev: convert the guest policy properties to custom accessors
      igvm/sev: forward the IGVM guest policy to the platform before launch

 backends/confidential-guest-support.c       |  17 ++-
 backends/igvm.c                             |  85 +++++++------
 include/system/confidential-guest-support.h |  28 +++--
 target/i386/sev.c                           | 181 ++++++++++++++++------------
 4 files changed, 174 insertions(+), 137 deletions(-)
---
base-commit: d2e570cc0f97b936902a5b1b86b73c0f5998b475
change-id: 20260831-fix_igvm_policy-0b92de52dd6a

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


