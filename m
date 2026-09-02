Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39ED4C624D7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1lqv-0002LU-Q9; Wed, 02 Sep 2026 10:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x1lqt-0002Ku-Ux
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:22:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x1lqr-0007sB-UY
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788358928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rximeLR1NjdHhltM8jaCjIJIhAf6EuyStPD5J3KYstc=;
 b=P9nSm5Wy1ige5aSQ4bRzYZHAunYSzWW7VtRh5eqPM+RQ0Sea5oVCS4X4yk9oMaj80FnsZH
 Agh/yO5uGzwZMogL5vIiLwCCLp8Cil7WVCwCzFI1AgVph8SKkpXNiCyOnQicAAGS7P8BM0
 8rR2by10ljk+8R/q8L2v0kIWDikNAt8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-0AOoF1_pOyWp5XlLOrvQCg-1; Wed, 02 Sep 2026 10:22:07 -0400
X-MC-Unique: 0AOoF1_pOyWp5XlLOrvQCg-1
X-Mimecast-MFC-AGG-ID: 0AOoF1_pOyWp5XlLOrvQCg_1788358926
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-495474a5fbcso9806005e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 07:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788358926; x=1788963726; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rximeLR1NjdHhltM8jaCjIJIhAf6EuyStPD5J3KYstc=;
 b=UNygpWzcZ+xavFBwsmJUZ2zUy73MKHnbNH6a0VxvDDIq6RbmBJZ2W1Rb2IwDi5oM7w
 hku5OfewLqkBvMXgReKYG+Qm8MTc0TL0WGnNcnTUXinfLPhfvY2OkTaE6HlXH4ObT3W/
 tTOSCb9+9FU6sKXHtYJTPOtYPr8Ip42l53M33M0GkKGDu/oM2ietWdH6+aXG2vprSXuC
 /H0TEEq2VPxvCzR9dLd36nigZ1fU+yHjpOZIiC0twuO5KDQu/CmHCxxKR9BMfON1+Sf7
 jK0m0wwqNhEynut2MOEbegIidLQVmcUhN8+riFfP5x7AKpaaBgNl1RAhwGWVZwcnsJ2w
 /v4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788358926; x=1788963726;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rximeLR1NjdHhltM8jaCjIJIhAf6EuyStPD5J3KYstc=;
 b=H4sKQFJOgh8+Lkjo4d6fMIHwKecJziDNROYcwgn9cnZRFft/XcqOlX3RobS+bZ96yb
 FoeQkp7rPo0+VdjclMbeD8n/claiNUvGDxVXZLatTgb3TqXrUWwQ8Qa57vsQjCgiv/1u
 8MWCXcbGAF4pp+e5kEPpWeDrI9q9DaDmQm3QBlsxEPUu0iF4YiIeZ5X7g0u6yaiD6Fo0
 /wb31WnX9JW8sQkg+zw1LeFvgp28t8LtLUSg3Ykn29TWXhXSdTn33G425oux/DB8HWWa
 kOo1WnyIXUEEwv22YcGPP+r0fH9A+n5eC5Zb2Glh0SeXnE4KYiT2PopDuMAuBhjA+SwK
 eI7Q==
X-Gm-Message-State: AFuF++k4VHjDZHpb7dYomUi2hh2tCq6yqYWBYFRqoafIVP5Cu5rout/y
 KTW3BPAa0602JE/CdNrq+KZWG7eSHJJTVZ+wT20e/9LFxZKigm9fbM4eMSYXm0TevQKjsh8flq0
 IXTzDjJlLcMQJGlyym3qJHxLHzr1vOuzJDGGvrdxppGUaO4EFymhiGFyG
X-Gm-Gg: AR+sD11W8OOGO47KKu9f0VMSvOKbvIMqSADcvGpOnb15FeRFPb5X5Qs6zxIYtXp8qfy
 lmFvM+FBH4PqivKG4B72g9b2+Juj3XauB45fMMzp7HMV+/l+bOESous8PXub6Z/M+KkxAxO2ViP
 vsChiiJOVDU4ASTh10Q3MgZ7pLnnO8l7V9Ed/eTcXb5OkmHrERN19c+Y6ovWhIQsQMj2PsvVRR4
 ewth30XYUOXyK4ZPdvZmsglH//U6jWhWHgGGchnx6HJHzBJH+O9vGn5P9kymfPNAsu2QDY967WG
 3EdpryScYW6f3qd88v7sOHLKIfBaKouyrnbVHnecBEl5U+u5oMwRiNdsjfl8MOZMPbcd1SDJbdg
 IqcoXiuV7xjQPA2kDjhrSC9w5DUrvrvDg4p53QyeWGpKCE/EQtVJNtFYrRbM65qUw0AAq
X-Received: by 2002:a05:600c:3b1b:b0:499:db27:7b1 with SMTP id
 5b1f17b1804b1-49ce5823d39mr89063485e9.15.1788358925802; 
 Wed, 02 Sep 2026 07:22:05 -0700 (PDT)
X-Received: by 2002:a05:600c:3b1b:b0:499:db27:7b1 with SMTP id
 5b1f17b1804b1-49ce5823d39mr89062405e9.15.1788358925168; 
 Wed, 02 Sep 2026 07:22:05 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce4776131sm80871685e9.11.2026.09.02.07.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:22:04 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH 0/2] igvm: fix byte_offset handling in parameter directives
Date: Wed, 02 Sep 2026 16:21:57 +0200
Message-Id: <20260902-fix_offset-v1-0-04b18f7595b2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvyJ7TtA9SPWViNhsrb1oaEQg/T3pO
 AwzFQpn4QKjqpD5liIpNrCdAn9Q3FnL1hjQoDODQR3kWVIIhS9N6Hq/WiQKHlpwZm72n03z+37
 55yLiXAAAAA==
X-Change-ID: 20260902-fix_offset-a268cb12aafc
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Patch 1 fixes three handlers that ignored byte_offset and always wrote
at the start of the buffer, corrupting earlier data when several
parameters share an area. Found while testing an IGVM file where a
device tree overflew into memory map.

Patch 2 adds validation of byte_offset in all five handlers, since a
malformed file with byte_offset > size would underflow the "remaining
space" computation and cause an out-of-bounds write.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Luigi Leonardi (2):
      igvm: honor byte_offset when writing memory map, MADT and device tree
      igvm: validate byte_offset before using it in parameter directives

 backends/igvm.c                | 56 +++++++++++++++++++++++++++++++++++++++---
 include/system/igvm-internal.h |  4 +++
 target/i386/igvm.c             |  8 ++++--
 3 files changed, 62 insertions(+), 6 deletions(-)
---
base-commit: d2e570cc0f97b936902a5b1b86b73c0f5998b475
change-id: 20260902-fix_offset-a268cb12aafc

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


