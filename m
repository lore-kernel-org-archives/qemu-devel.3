Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF48C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxKnB-0005fS-P2; Fri, 21 Aug 2026 04:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wxKn9-0005XD-6j
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:39:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wxKn7-0008OG-Mo
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787301596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MWxQH9gL9sLdexucta7qH+Siu5S42ahcdZRs44zuXqY=;
 b=UzU6T4zExyjA2AdJ0Uau4cpVIGoqhKY+nkRRLPWQbgz/ANnx2OjVNgNwN7nxTGN8Ka/FLt
 pr/gib2EMgqNHMt44mFC+OZ6MiLvfet4iVAL4lup7fdqZqd5+fw3FJv+ZPfRZdbk1Bg0IV
 /FD2Q37znCDEBRyc3rg+TNhXhAGSaRo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-dDK5RTX7OC6Fq-Qh9NqfPQ-1; Fri, 21 Aug 2026 04:39:49 -0400
X-MC-Unique: dDK5RTX7OC6Fq-Qh9NqfPQ-1
X-Mimecast-MFC-AGG-ID: dDK5RTX7OC6Fq-Qh9NqfPQ_1787301588
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c15e555a164so59654566b.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 01:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787301588; x=1787906388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MWxQH9gL9sLdexucta7qH+Siu5S42ahcdZRs44zuXqY=;
 b=cH5Cy+RSC0tYt9XsA8LVgr50rpkOLJgunXdMF4HMQoO12rlSzv1F5WBA5zlEs+mxwS
 A7L2GwrA8bQqVlks7qzWAMq2vtl2VkrmmMDehpujedawtgoduTzTK5U2DuB6j/4qP1QJ
 7GNX4uINC0hjWDflNpifiqofGiyKI9i+YLxpBiSauqPBYNS7azHJ8qT3qadkdn/i+mxL
 yJPCp/OcYLvV1ek6wUnHHt6oq2CfN947p8T55uAA/acAk6Uk25xsxovU9Tl9dsF5O8W5
 /xoz9dAA2GxVCvz2S4yMvORKYUYFyXzkPXtd481ne4p070Bm7cUDapXOTUU6DbsDPLlb
 rrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787301588; x=1787906388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MWxQH9gL9sLdexucta7qH+Siu5S42ahcdZRs44zuXqY=;
 b=Cfavwo+SfKXQVvjFIgJAorP+L160ODR/Gwcv/w8+VHGQWJ7cZ0LXf3n+RgxQrLYhgO
 FRi9C7GAFOCQZSfmv59stUk01k42nY52BQTbgikM/8K8mJLzbxcaSGTigZ5Rd7YmtKzA
 b6LRMG5IEdCbzzPTThl+O3ZPXuNv+nS/fM7nMbQtDyywyvN2jrxi4hZ0Jl6c3xuvZ7Cg
 Ci3KhE3kKd7hQwvbLmfucmMOuUoenB+hChtiBVJWBTta3IH5bRLRCm9cey/k8Q+9b2Gy
 WP4oI+ldpIXV3PyHQPN9sWCHyCdS0cXLEMwFhExzFZYsAiWnZB+Ky4FENUYP3VXjXq2C
 FzPQ==
X-Gm-Message-State: AFuF++nBZH/f4RfuqT9P2UYVeBKv+p1tWJzWcVasU2k3um1VaFPMoi1C
 x8Si6+F5L4UxVhW4qmxsURUsp1Ri7ujFZfbY88HNKEzj3kIcqvS5upHyap6aM6WCZEF18C2Dzk1
 dwWh7jp1ClpZDeY7beo/at30RdxowYNofkdhb788P0zrh90Wh1wkNTN6ZqOWYSk/xEcxl+7dIO0
 VXr3eEP0O2VfHch/TuFMjXlwHM3vrsR5DdrA+3bp9k
X-Gm-Gg: AR+sD10vDmPFuafhMckOy1EvCwtuVo40PByROfEQAU+vU4jFUBfSdD8R2nWOvplXb4S
 +IMrWp9pDWKDwxI0tETvFWUb4SMcjRRXQt5a/jiE+YMb23zYKTrgFlDIfB1Yt7lvsQWQJw9rClU
 0+UH6VukWAnDdCWKeHLr14RxanFkboAF2PG4KXNfNQ4uvhTOxxWI3RjPJAZRdM1SMOyxXCEbc7W
 1DVuzD9NF+6vmwvTrJtPejF4XDfRMj89mYHSr8r1GbkgH9nxbC4KRBcfNWCw++PfRX1oRwFbiEX
 egsLUQZHnbRUCyYbpZj6mKBjOTlJ/v9UjV9wq9PUGov7SJruJas/STT/fMsSBcTs6RpiEJu8vlh
 MgpCg6rj3RQvFj6YSxPozzC3cqk9+PdY8+Vs1CUMWQL/HBnW7m1NTWVjUDP2unnSz3wVFzx5UCp
 coEaI=
X-Received: by 2002:a17:907:9345:b0:c24:6382:2648 with SMTP id
 a640c23a62f3a-c246d633d8amr363681866b.5.1787301587891; 
 Fri, 21 Aug 2026 01:39:47 -0700 (PDT)
X-Received: by 2002:a17:907:9345:b0:c24:6382:2648 with SMTP id
 a640c23a62f3a-c246d633d8amr363676766b.5.1787301587385; 
 Fri, 21 Aug 2026 01:39:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2458b05dcfsm320054266b.14.2026.08.21.01.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:39:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 8/9] scripts: rename get-wraps-from-cargo-registry.py
Date: Fri, 21 Aug 2026 10:39:23 +0200
Message-ID: <20260821083925.2008135-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821083925.2008135-1-pbonzini@redhat.com>
References: <20260821083925.2008135-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

It does more than that now.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../{get-wraps-from-cargo-registry.py => update-cargo-wraps.py}   | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename scripts/{get-wraps-from-cargo-registry.py => update-cargo-wraps.py} (100%)

diff --git a/scripts/get-wraps-from-cargo-registry.py b/scripts/update-cargo-wraps.py
similarity index 100%
rename from scripts/get-wraps-from-cargo-registry.py
rename to scripts/update-cargo-wraps.py
-- 
2.55.0


