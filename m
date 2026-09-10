Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8A4C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nTX-0001jl-Jd; Thu, 10 Sep 2026 18:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lUF-00060T-60
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:35:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lTo-0002ZF-8M
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oztlL0t0JZ8ezWj98qmIsDqrr8kTq2UUhazLUKK+7WQ=;
 b=KP2lGWBtTx0yYLrLSWDwJbirMOBIoW+h+wGaTMKVLUH4+HmVYtS03HDQWVl+hJfLAZZPX7
 kbKsphB5Ks2GwDhcdrN+Gh145pQMUZwRMimx88eUm7JNdpkHILitXZkxL9Fw5rN9n+j2qA
 mPrpvC0KzNm8yFm+6ePCtptss5b5b2k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-a1KOShLLNgu81QFiGPJdlA-1; Thu, 10 Sep 2026 16:15:59 -0400
X-MC-Unique: a1KOShLLNgu81QFiGPJdlA-1
X-Mimecast-MFC-AGG-ID: a1KOShLLNgu81QFiGPJdlA_1789071358
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49cf5bd2f12so2224155e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071358; x=1789676158; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oztlL0t0JZ8ezWj98qmIsDqrr8kTq2UUhazLUKK+7WQ=;
 b=TMiYvFcbrprFVM1Hr4XG3aTfn9It0rUUPmcKlAF85HvW4ouxDoxYaBEVzJItj6WtLt
 rkXQYTBj/Py1LttN6qYmt3bRZEN+9v2oXOMKV3ScfM/qtEdR5yHmnpaUzKv0uguzdTs9
 jMtq/xwqUySA1hBXsIT9Xs0IjrwP34XzmGkmcJ96Qc4ZfaUIeg9yE6TTgo3Smb1/5Egb
 F5Ai9f0a/sQfbq/lZouB9AziD6IV8LTJwLPoZr1fvTZUvK8lBN+ou69CJsJNhFY1pfFC
 NsJnX6gkVP63i/FmTsf9axZNkY0vkO9d2I65AVTEr7m9+P/Buj04nwIqiIY8C9iA4y7W
 L3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071358; x=1789676158;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oztlL0t0JZ8ezWj98qmIsDqrr8kTq2UUhazLUKK+7WQ=;
 b=RYNzvQmCUbBk7tp/EPce9bDtM2Qjq/t92BnPpBVweqTgQeXykVaDfJY/BdkN0fH2jD
 lcBFfDUfKuu6WbiCAvpflNOjqJF4fjlUFbNe0Uyk+MwjuobDYO86fMFexFReLaawDxig
 LcX03GkVV+tV9lXQzYtX/gZDe7tf1ABOwvrZfBmCYb+fi2fn7UtAc6dS74n9QufdxElr
 bPvD1ptsrgQ/swMPujJvNJpv4tquSY98OdB0wJQuuTz7pc0Q82qY95T4y0uKTiw9xYWd
 V1s57ybba0fApq3I5tU+LNbbO7GVHC9HUmIbm/8aYs+Qfnpt9whcK78xJcPsbrifx0CL
 HvLA==
X-Gm-Message-State: AFuF++kYZWZZM4RV6kz8i+ZuiAOI7i1Hw7qr/VIT2NTNE/gXwdFin74R
 tMrssNJjGCRJ4knKb2qoFCJOTTc2O/VVvSQjs3d7exRMTcDAvRW7YB8/h+5lg9gmJ7t3/YrKL76
 jfy4wgX1U+l1aNBcDKE9qT7QVUDCVaoUoPmjUi5p2fZQoXVtjfLH7bEpCfR8uTP8aiOAOLWhKZP
 DPv+O4bLwxhr4OSuO5B0IeDtGEWfiAI6lf7g==
X-Gm-Gg: AYBFou3EMkeZJdTtFD35+g70rvfC8g4y5litqIGpSP2Zyta3B1jZ8TteMQEzoGGa0DQ
 jlOiHnwpKTThOUMZ3LjZyphW7ELZtDc8vz2rUV749e3asVn4sGAhHLQJDnbN+t1AhZltRmU0crW
 wXlzWVlq17azc/VatboDWg2lAeAHd820f4pHtTYHKbhOG+NfdiMbYt2jEAMfVMXKjIx/xmvyvXC
 ftIDWMGY9Tlo7A8c/P8qmBHuoIUVFERNSDrW8Rt92ZywZnchB79JAPsWh862a5yQ6ONEE+MfpTP
 cfuZIHvJmvU239UcVr3WbrkVIXLIHiTzrgPWF78WsCGrdqhURkCdcIEfAwMLxOFNYrPHx8QzQ1h
 y4MNbcVCq1xzFIraJVshtG7M=
X-Received: by 2002:a05:600c:630a:b0:49c:edfa:15a with SMTP id
 5b1f17b1804b1-49e61992b6amr8282705e9.13.1789071358009; 
 Thu, 10 Sep 2026 13:15:58 -0700 (PDT)
X-Received: by 2002:a05:600c:630a:b0:49c:edfa:15a with SMTP id
 5b1f17b1804b1-49e61992b6amr8282085e9.13.1789071357442; 
 Thu, 10 Sep 2026 13:15:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26be3e35sm94211115e9.2.2026.09.10.13.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:15:56 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:15:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Junjie Cao <junjie.cao@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 90/90] MAINTAINERS: add Junjie Cao as CXL reviewer
Message-ID: <99c75c61d61251d98e0b93dd199edbb10a990205.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Junjie Cao <junjie.cao@intel.com>

I have been reviewing, testing and contributing to hw/cxl for the past
few months, and would like to be Cc'd on incoming CXL changes to help
with review.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260908042310.493882-1-junjie.cao@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ec313c3259..d5eac4b42d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3334,6 +3334,7 @@ F: docs/devel/migration/CPR.rst
 
 Compute Express Link
 M: Jonathan Cameron <jic23@kernel.org>
+R: Junjie Cao <junjie.cao@intel.com>
 L: linux-cxl@vger.kernel.org
 S: Supported
 F: hw/cxl/
-- 
MST


