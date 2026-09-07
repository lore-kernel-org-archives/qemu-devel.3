Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4453C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3aoM-0004AT-CO; Mon, 07 Sep 2026 10:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x3aoK-0004A8-V9
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:59:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x3aoI-0001uw-Vw
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788793142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ewsjl4P9HV5PxyCZvnEo1+OO62AJeLfBNjeOm3CVmXs=;
 b=IWTQ2JEVZqQIvms3cSUH6oHfvrjTT4KKAX/+yPbAqUw3aLVg95XDBjv4YyUsqbot02hCpH
 6hcAoK4oSPWjb4IB+Aa4ZrdJDrK7K88v1cv7QxOGkR5ev17svdjZ0ALdeUfcv06St3wAwI
 XeGJMBWlBYBZELE6KfrrJpZfQZl6Fbs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-RVqjUO7tMrepD3GJvwaLAQ-1; Mon, 07 Sep 2026 10:59:00 -0400
X-MC-Unique: RVqjUO7tMrepD3GJvwaLAQ-1
X-Mimecast-MFC-AGG-ID: RVqjUO7tMrepD3GJvwaLAQ_1788793139
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49cf5bd2f12so51088815e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 07:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788793139; x=1789397939; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ewsjl4P9HV5PxyCZvnEo1+OO62AJeLfBNjeOm3CVmXs=;
 b=hn421fKVF5Y6fowXFpzpqw6HRxTbqXAUmcLcloK8KRGirqTfWqbDoo3jKowTupoeCO
 Y9v4lZX37gkHTkiRtcZcAVfyyFLwRa9L+NpsqfLQ5ZiKZMaZHxm6AlxsCRuWF5XXAEpa
 H55D04WPNtpdaPbbVBWjD0KNAoOASvCLbkyTdeq1GYyxdO7EmXOwuyvJieno5DOhTXxf
 4egTNqoX+d0cxq3Y2dV6bFTgmAdIY/LQe9R5BVJSnFWCIIMAPfsMgM4Uc7gMPkZ64zoQ
 JHXFumGrHjATu6XJKeW2KsSXGRI41ajLZPexUGhN28GKuvYQL6c6V2/hHjUy1iV4Zbin
 oS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788793139; x=1789397939;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ewsjl4P9HV5PxyCZvnEo1+OO62AJeLfBNjeOm3CVmXs=;
 b=Fg/FhmCF62LCPR9nmTOIwdNiNNEZdrBjvFu4RO+Cu2d0tkcPgfaDdRE1/6OGgUQkEo
 i/l87EOaFwDCFAz8iGf5Z4VI7Xs3BAyUVkocyUPbDSSQgpnyP4PhRk+XxguI3qquX6+a
 FocqjwqTvKLwGwPFTUVfxF8TV0IPz+BDUMz0uxVRbkuDo86geIu7RWZ6WtNvaJZijB4z
 vuxENUOupmcuuKxbtjCSU5ylOBfke5hU9dYtpX+hqu+1Hz9+nSBNMIBIsSwCbceuXtMO
 O2uGKMAhCT+lXsYr9A9vZ4CSuI2LK5RxrbKW6jhmHAGWGFuOBdlVIaE3oG9Zm8JPL+N8
 qGIQ==
X-Gm-Message-State: AFuF++lnfGUFXhgmztwdNFW8L635ttVS00uA9V3wOSCUHRxhyrExIyEQ
 YAOEu8vWTI+YvPOH1BxWjzE9qaQJMbOjWQpEl3+XfdtqIzks89ThQhrOe/clnmzULWLuOjwXzA6
 1+Y09rOjLD0XIUalt2J77wcDNxlJo3oz+/RzuwW0qTEPTCxXBWg4PlA6J
X-Gm-Gg: AYBFou3uGQHtYe+IQwzAp7VCE2m6+dcTb0ckD1vM0Um3asDBlAUkX1VUD8c7Eur695G
 yi0Cja7R2HVcRBbgiV+LZhit9MAh9a8vpbYmK/h/BOpYBHd2/VK3BjUN4jXtcMBfFs2oH0TRQc5
 wgktXpKo8oZgTH48W9HpKvolANdDIX790S29kBscTkU3limW6kz3MUBRlPoY9ElR9HCg+A6xyMM
 n+2loQd9g5c3eonA7cuWW62tFFuiN6yiN09suIlJdWC1K4e1y8Zi6eBh2tdxykkU2h7TPRq+T8B
 pjAPHo+d0t8vSC8gNBUR7p9LM4/t4ic/JPAMw32WLD4mFCed5XaeDfUgQ5du76hXnuydcMrNqGC
 iVtm656X+uNz/xfIQqKEukBJJpa/INuvyzvVonATbvb10DIINwNcb/QGVxeF3JZ855RuI
X-Received: by 2002:a05:600c:5303:b0:49c:fa21:1c87 with SMTP id
 5b1f17b1804b1-49cfa211dadmr196064865e9.28.1788793139379; 
 Mon, 07 Sep 2026 07:58:59 -0700 (PDT)
X-Received: by 2002:a05:600c:5303:b0:49c:fa21:1c87 with SMTP id
 5b1f17b1804b1-49cfa211dadmr196064455e9.28.1788793139006; 
 Mon, 07 Sep 2026 07:58:59 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883927a3sm22547547f8f.11.2026.09.07.07.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 07:58:58 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH v3 0/2] igvm: fix byte_offset handling in parameter directives
Date: Mon, 07 Sep 2026 16:58:54 +0200
Message-Id: <20260907-fix_offset-v3-0-bcffcefc0985@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22MQQ6CMBBFr2JmbU07FgRX3sMY05YZ6UJqWtJoC
 He3sJLE5fs/702QKHpKcN5NECn75MNQ4LjfgevN8CDhu8KAEmvZShTs3/fAnGgUBuvGWYXGsIM
 ivCKVd41db4V7n8YQP2s7q2X9m8lKSCG1VQ2fqrayeInU9WY8uPCEpZPx19UbF4vLlbXacd1pK
 zfuPM9feXTcRuEAAAA=
X-Change-ID: 20260902-fix_offset-a268cb12aafc
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 qemu-stable@nongnu.org, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Several IGVM directives (memory map, vp-count, environment info, MADT,
device tree) _can_ place their data at a byte_offset within a shared
parameter area, letting multiple parameters be packed into one area.

Patch 1 introduces qigvm_get_param_data(), which looks up a
parameter area and validates that byte_offset falls within it in one
step, and uses it in the vp-count and environment-info handlers, which
already relied on byte_offset.

Patch 2 fixes the memory map, MADT and device tree handlers, which
ignored byte_offset entirely and always wrote at the start of the
buffer, potentially corrupting earlier data when several parameters
share an area.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v3:
- Renamed the function to `qigvm_get_param_data`. [Stefano]
- `qigvm_get_param_data` now returns the data pointer directly [Stefano]
- Added fixes tags. [Stefano]
- Renamed variables to param_data and param_size [Stefano]
- Link to v2: https://lore.kernel.org/qemu-devel/20260904-fix_offset-v2-0-f5bb4cf6d4b0@redhat.com

Changes in v2:
- Inverted commit order: first I introduce the helper and use it where
  necessary, then in commit 2 I handle the `offset`. [Stefano]
- The helper now returns data and size, that already consider the byte
  offset [Stefano]
- Link to v1: https://lore.kernel.org/qemu-devel/20260902-fix_offset-v1-0-04b18f7595b2@redhat.com

---
Luigi Leonardi (2):
      igvm: validate byte_offset before using it in parameter directives
      igvm: honor byte_offset when writing memory map, MADT and device tree

 backends/igvm.c                | 96 ++++++++++++++++++++++++++++++++----------
 include/system/igvm-internal.h |  6 +++
 target/i386/igvm.c             | 13 +++---
 3 files changed, 86 insertions(+), 29 deletions(-)
---
base-commit: d2e570cc0f97b936902a5b1b86b73c0f5998b475
change-id: 20260902-fix_offset-a268cb12aafc

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


