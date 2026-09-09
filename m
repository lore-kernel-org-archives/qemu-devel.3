Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2C1C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4KfN-0001gt-QQ; Wed, 09 Sep 2026 11:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4KfM-0001ge-B3
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:56:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x4KfK-0002rd-IP
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788969409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3YZv5ZaxcwfZ/jpde8egosMxWFBGvlefIsLX4ldjGc=;
 b=iH7TJ2sNuFmZlyfhSrBkcqp/glYnPlviXrIgix3w59cLRU5qEUK2Tp3cZaostOdbDdBU0k
 7hTUhzt6v8MBwkTjX7xXZwEJwxrIvxIcVzz8rOLxF4qNG+n9Q18Y/N3a2GHERvfdNjLyIj
 qDNNBu0/Mrtl0jRubd7IS2kY7q6xt8o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-mQYRJa-0MJeNBzDwUABulA-1; Wed, 09 Sep 2026 11:56:48 -0400
X-MC-Unique: mQYRJa-0MJeNBzDwUABulA-1
X-Mimecast-MFC-AGG-ID: mQYRJa-0MJeNBzDwUABulA_1788969407
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48597bbd963so4121856f8f.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 08:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788969407; x=1789574207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H3YZv5ZaxcwfZ/jpde8egosMxWFBGvlefIsLX4ldjGc=;
 b=bsl4FEi3QOL3TYnmMqeMkfO8zVEg/A5Aho25j9cfCvoPIVB/I15oxpP1MFn1CJiWhf
 HnppI/uvh3aRFGFW1eLtCzPI5LtT35xSosAFvXQQiizUYwRslxtPP0Sjjzk7bhbUuZc9
 vGQCADPN4PdJjtxyDTOc/5BDjof2jLjJtX/oMlsC2H08rWedfQ5l7euH0zQdpxV3X3Nc
 Rk7p+JdYg4QqqmFlEkDU+89hELgE6LD8G+Z+8NVUg2m0wVf/IJV1uaYOw5K/DBomn6I7
 WGDVO7jD6HPhnq1A7Nj/CUiuasKPb3K/RTEIcC3y6XiWaZym577neC2sv5IFeLYULEky
 h8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788969407; x=1789574207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H3YZv5ZaxcwfZ/jpde8egosMxWFBGvlefIsLX4ldjGc=;
 b=CiwT0wY6VIxdvwIPaSojD7B7e+P6xh0/ZKTWPMPOUkTuDT8Hw9pXa+L36WV687WsWq
 4yJxPU/l9uSWbonong/yqiU4I/6iI5KcHWWhm9rf8bXEIVLumFJf99JK2PiE4Pxatt8p
 30F+5EEittx6DSNYUzf7IiLekQ/MehEBIOPeaoCrJfGY2GbwJ2HuLkGQVleKFbPFmH0q
 iARHyhGECjlgt5tYU4VfSvYxyyqCCoLN45PUWJmnNyR5xHVh6dxjvoWptqCFQn/1vhsv
 Au61iSCzfI8Nmkh/K1BWPI6QdND65H+pIHQnIx7KGu8HqNtULvgesAUszInfj3x552nG
 PNPA==
X-Gm-Message-State: AFuF++nGm+VHW8uYq40/RLd7NyzXHwzeBdxTbbr9eB+8/VPq/SBvzS+M
 1UVAT29uTAOZwAm52ug9QntoAF1nCgA7zjctx5pQqORVlccIPJHAmMgsXDGDidfp4ZngHvCk8sR
 mPj27DUTGtZ0GuvAR7Z529XYQKNwXvrhcbruw8jU2VepUp7BMrfKx5dE7btRPTdLtjm+WbXBRBw
 gChHmUiguuQyilYCKbc/5fHkcHeQuGfPVUb6N3zKws
X-Gm-Gg: AYBFou15dB8RmSErWu1oLppeU6lPJcAexggs6iImLlvGzUW/cMLHOR9FqzqxZkLGS24
 NO87i/LLN1sVLKoWiLIUkSKZx3s+pnUTCIPkzMAdYEIur9jwMqBnwN8kOZkOoLO9xgmEsdAeia6
 f8OrYCWKg8x3Mrhp8QMDb6Yobkz3PSinVm5ejvh/GDy2g7QaKkCADr2xpiBzIS8DhfpeUCPV/B1
 iWsUAUd+PPUaIPIWsjaZvTOspQ513ijhCUBjuMwLB4dwyX8puPN1oOWd6TX5WJs8aMGTAVLEWMN
 Y/VvyaZy9jiAwF+79yuWg45zvTupwcqAgw1RgMWI0ekBJX7MjhUCfOlzlfUjox7/2xJ2TncgnZq
 UJzIC6mqfqfBMRePxjGvBP0pJhpBffyyQic+AfF3Tv52JSd7+CwbwSix0jYNomvuUWCV5mID2Ix
 9kX6sO
X-Received: by 2002:a05:6000:25c8:b0:485:b096:d2d3 with SMTP id
 ffacd0b85a97d-485ba5b98c9mr5461095f8f.7.1788969406965; 
 Wed, 09 Sep 2026 08:56:46 -0700 (PDT)
X-Received: by 2002:a05:6000:25c8:b0:485:b096:d2d3 with SMTP id
 ffacd0b85a97d-485ba5b98c9mr5460988f8f.7.1788969406411; 
 Wed, 09 Sep 2026 08:56:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858e239862sm39312833f8f.9.2026.09.09.08.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 08:56:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Subject: [PULL 07/12] docs: link to website for IRC and mailing list
Date: Wed,  9 Sep 2026 17:56:19 +0200
Message-ID: <20260909155624.1082893-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909155624.1082893-1-pbonzini@redhat.com>
References: <20260909155624.1082893-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Provide an easy and always up-to-date way to get more information on
how to contact maintainers and other developers.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/conflict-resolution.rst | 7 ++++---
 docs/devel/index.rst               | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/docs/devel/conflict-resolution.rst b/docs/devel/conflict-resolution.rst
index bb25f61865f..b6122323978 100644
--- a/docs/devel/conflict-resolution.rst
+++ b/docs/devel/conflict-resolution.rst
@@ -18,9 +18,10 @@ How we resolve conflicts
 
 If you are experiencing conflict, please consider first addressing the
 perceived conflict directly with other involved parties, preferably through
-a real-time medium such as IRC. You could also try to get a third-party (e.g.
-a mutual friend, and/or someone with background on the issue, but not
-involved in the conflict) to intercede or mediate.
+a real-time medium such as `IRC <https://www.qemu.org/contribute/>`__. You could
+also try to get a third-party (e.g. a mutual friend, and/or someone with
+background on the issue, but not involved in the conflict) to intercede or
+mediate.
 
 If this fails or if you do not feel comfortable proceeding this way, or
 if the problem requires immediate escalation, report the issue to the QEMU
diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 29f032d6a82..6f9ff4a0b91 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -10,8 +10,8 @@ QEMU is a large and mature project with a number of complex subsystems
 that can be overwhelming to understand. The development documentation
 is not comprehensive but hopefully presents enough to get you started.
 If there are areas that are unclear please reach out either via the
-IRC channel or mailing list and hopefully we can improve the
-documentation for future developers.
+`IRC channel or mailing list <https://www.qemu.org/contribute/>`__ and
+hopefully we can improve the documentation for future developers.
 
 All developers will want to familiarise themselves with
 :ref:`development_process` and how the community interacts. Please pay
-- 
2.55.0


