Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FA6F4180C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcES-0000fB-U7; Mon, 09 Mar 2026 11:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEQ-0000dN-TZ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEP-0008JJ-GB
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773068956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uVtrqVMsyosUaHcDZ5RGcCJIBeUjW9Ffsh9VA3rZWsw=;
 b=CfxJRv0S07MpXlxPIMOQrXXslksi7bTo4+q+OeI/uOx9KoxwO9gmyzwZKKrLHYP8xWGeVU
 ZVOrjWK0ljpzzMPyytgEB8CCq4x8pVc4jAV4TsZ/sUES74Oe7OHT8msn9Zled2WzGMj+uU
 gH6But1pc5hZNkB+/rTLAeWaBWVpwfU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-FYRWbj9CNYal02fwuGpI8g-1; Mon, 09 Mar 2026 11:09:15 -0400
X-MC-Unique: FYRWbj9CNYal02fwuGpI8g-1
X-Mimecast-MFC-AGG-ID: FYRWbj9CNYal02fwuGpI8g_1773068954
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-485355493aeso3412905e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773068954; x=1773673754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVtrqVMsyosUaHcDZ5RGcCJIBeUjW9Ffsh9VA3rZWsw=;
 b=ZdidUdhVoQAJaym85CC/G2ebAyGLogjAmxTTnTmyKvkGvc84gFbtJO0NomZ/9N+RTT
 ZzGQVC3LVux+lcfbjhq6oIn69CsRm0Y8olOqlsaXVcV7hgdGiGVxoxd2TTl0Ra+sNap2
 lKY47qYTaqCUwHX5uNVm7CFQql5n7RhUrIg2D+Yd0Uq2kUlxDvSHufjYELBy1mX4eMyn
 7P9oAt/x6W7GuZ4oIyAkBJCHe4f8JyRWxc+4bO8Vx5d46NlvNzZlV/w6F9v0uIi9omWi
 7kqt2k9egbmBTt0aFQ7J861l9COGbWHdAR8Za1NjGp8BePBjPrjoIM/xsJBv2dOoAbMd
 +5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773068954; x=1773673754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uVtrqVMsyosUaHcDZ5RGcCJIBeUjW9Ffsh9VA3rZWsw=;
 b=AdzvwTRZCSbgcnE1uXGE0v1LIMRr4xMVw+bVFFW3htZjp136RhhveDHO6iGvBmyCHn
 XgTVeJCWITUObGv0ue7ixebf/gfMmTpWRIAk87+pu8+c30Z8F3sDol2YNZxZwG1J4wam
 8ip04VGZgd7W6XxtWHvS3yFAR4Ab3APdtE6U1Es0y5dTYnjf2xjgTHqJFYLYDCxffbtO
 vo/TCLY/sSRVO167slGJvsMcLfNuFAlBLf9NvFWN4f25eOBIN4dAALBrhmpex05k79hP
 dmXuA8dA0IpMhvlYxuP+BRFWDwSaAegIFdI1b+Zi9gX9ZhFpd6r9NLjrqzbawVueB7bJ
 Z/bg==
X-Gm-Message-State: AOJu0Yxq6O2ST/hRX6ajwRzdGkomjVrazUGXS7DBdoco6862HH/Pzhek
 QyvdVSxiNyfwq/XYud6ajZ/UDjXF34dQuZMkTX6TcYZKy6/F4nQdfZCiP+QqCEY7QCWvBJLJhMA
 5SQcqaEReze2BNshQab/5oe0HN7y2vuGHuYPSS5mwDhNmkQ1XR7vfqain
X-Gm-Gg: ATEYQzyFj8C2AjiNMuPQklNEYXG5rGliyw3pXqctx+vg2KPHeh7bM0xY3BAr3x/Lr0n
 5qWpgKY4AjnlfNKuURJIZdXlj58xOStuegLCqCSLsqo6KYdv0RAALEcoinUI6boAbpl1778KICu
 pP1VhpYcHYgfysUZ2ApmU4NF5Er7ZuxTrBWVfkfNbe0swNPrmTv0iCnUesrVaNGDTPvU6tItaCF
 HFMuzaEyF8dpxkWHXoQ1s//99LlPAsw0ENRWoBsXW+1zv2Y+C6pCKhlW2C4GKFm5CLlIT3ez5gd
 JwoMKxsm+A/LcfIISv7qzGFmN4aumcMdZ52NAhKAmlSRR6AAN+nqdGKO+8Qb1hUsGvUrQOr6TFo
 P0yrklrdN5HR9GHA/TzLg61AFr90Mc/YeG+2H0oZ+NjxewCy4sok3QbOMgjicw1WepFd9q3WhzU
 kqFD/J
X-Received: by 2002:a05:6000:4205:b0:439:c9d0:5fd4 with SMTP id
 ffacd0b85a97d-439da656affmr20069351f8f.16.1773068954095; 
 Mon, 09 Mar 2026 08:09:14 -0700 (PDT)
X-Received: by 2002:a05:6000:4205:b0:439:c9d0:5fd4 with SMTP id
 ffacd0b85a97d-439da656affmr20069278f8f.16.1773068953595; 
 Mon, 09 Mar 2026 08:09:13 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0cf29d515fbd6051d53.dip0.t-ipconnect.de.
 [2003:cf:d737:d0cf:29d5:15fb:d605:1d53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dadb85b8sm27478391f8f.17.2026.03.09.08.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:09:12 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v5 03/25] fuse: Remove superfluous empty line
Date: Mon,  9 Mar 2026 16:08:34 +0100
Message-ID: <20260309150856.26800-4-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309150856.26800-1-hreitz@redhat.com>
References: <20260309150856.26800-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 2ed22c6b2f..4cdf527d69 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -464,7 +464,6 @@ static int fuse_do_truncate(const FuseExport *exp, int64_t size,
     }
 
     if (add_resize_perm) {
-
         if (!qemu_in_main_thread()) {
             /* Changing permissions like below only works in the main thread */
             return -EPERM;
-- 
2.53.0


