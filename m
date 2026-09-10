Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18C1C88E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4oqu-0000QT-BW; Thu, 10 Sep 2026 20:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lWL-0006Uw-Ka
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:37:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lW9-0003ga-5o
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mBiB/jOHXjADUICu4zFhNVY6emnuWrVA0Kv/cK2oUiY=;
 b=Wk2YTbEemqFfjj/txNXYH4nEb2GhFwJ6lkdF2Z/JRDpAwJyYQB7mqGfSzIbigItv3NlJ1f
 SBeFTz+kEp9LQfSDrMcPE11c+WsvT06+JATG+JYXbelfK2ja47K2XgkWKc399nizWlRAFo
 tdkrlGPO41r1IH17/KxgZGseUoR9B7w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-CkEdhRMZNACH-fgFurVxnA-1; Thu, 10 Sep 2026 16:14:02 -0400
X-MC-Unique: CkEdhRMZNACH-fgFurVxnA-1
X-Mimecast-MFC-AGG-ID: CkEdhRMZNACH-fgFurVxnA_1789071242
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-495569acf8dso878525e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071241; x=1789676041; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mBiB/jOHXjADUICu4zFhNVY6emnuWrVA0Kv/cK2oUiY=;
 b=rdjWUnKB9dzXEHuDOm9oOL/u2tHy6FqzJdIT1LUJRkPS07oN1S5fY918ydvO4c79jC
 ivgzGTTjKZEOginxMISesIH2fTRDIZh43OyUYYQw+QM64jEoS4F6aGSUJfXp1WP9q7k3
 /A+XyBj02wDEvW+UPylVKX9866GEzPQLY1QDP0CYWVvlQ6G8UjCGLluRGZrAfO1gCNFc
 h7i0mEfGIKEJkWulxfyZmG8xpf7/k8R4ZrWXjXnoaa6UhTZh0O7dhvGjD8d4y61Xmo7v
 grQhspksQgJuMYKk/YnyAnbM/4cA4gLZo0TmpR9TFRf8TvpD3UyKkDEZPatoJyk70mWE
 Hthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071241; x=1789676041;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mBiB/jOHXjADUICu4zFhNVY6emnuWrVA0Kv/cK2oUiY=;
 b=M4THvBJOALTwjSk4gYMpJMwMiMP4NlpvEZlpuVenlE+XEDrNFW+3amBHVHhZtHpdwA
 6J4a8NsaiToogUJAKjT2lKSY9MSTZ6UID3H8nkE8419z36lPfFuZUts4Is4Yf9G6Jx72
 c9Kncmc2oijFabzvX0edO3ZifaRevNiMJM0f/QpwBAqzBL97fcAhfKAxJNCt8hpWTLm6
 wyFJ28N3pT4wf1Fyb5FvJ9erZiCkYluktceve/vAb06UVqVxjwuHwt4lA3Rwmut7Tm/6
 H48qM22E7fJpkSzNFKyQZ+FKzRt/cUotlCegZyGJ95EIYwo49H56fHBnmSUilUKo8Dly
 l+4g==
X-Gm-Message-State: AFuF++mX9YbTHrHUn6jXLLg84KSebl5+Rl75sh+h29myuQ2qn5DImt8e
 vVp7ihnxHU8RdkFglPAKEAIoJxThfbcXEoybaf4DjSJ6L13oAy20ypYuct58nDNtwxUsT/4Qu0W
 4VHAIDYSE5FOi82txSnSMgj9IpX3bWhZBMDSoS4V038Ccxr9mYLtXAByt1eYZu2ozmmNZXoC8ux
 iqxDRLo80Tbk92fZI+Xm0MP5eNZyB1AA1pKg==
X-Gm-Gg: AYBFou1YFNWcIORSkPjfbiqqsZgaFqQoA6JkUg0dGVCeUh7v2SIumlNS5FguAv+5AsU
 zgPkYZ2kOu3nnfAO7vK25TPau5TUuhQhMhvxTNonQtKIKIIgESca09B9H9Q26hfdZawSIbX5ma5
 nvJyCq7fJ8pj199qWss8WOub1V8WVe6Es0WpjS8bH0qMv3EmYSV7ryzLFTDBlMpo+2l81pb4KMZ
 JthgcQv5HMzb+/+sbY+Pu8AW2qsBYCMgpatQGevY7LAMOnDmZ1bL904wMGbwILGlFH/h9QdGg+G
 2UdZM88q2kLEys0Qt/u9+sTeGFq+0hq0tfHugZLIOdJxYRfIFSageBfB6KsILiKRuEhDywYoO40
 ktK6qjswGk57OxudJKBefsIg=
X-Received: by 2002:a05:600c:8518:b0:49c:edfe:d525 with SMTP id
 5b1f17b1804b1-49e619acc89mr19498725e9.10.1789071241547; 
 Thu, 10 Sep 2026 13:14:01 -0700 (PDT)
X-Received: by 2002:a05:600c:8518:b0:49c:edfe:d525 with SMTP id
 5b1f17b1804b1-49e619acc89mr19497875e9.10.1789071241044; 
 Thu, 10 Sep 2026 13:14:01 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c1bfb5sm104235585e9.5.2026.09.10.13.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:13:59 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:13:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 60/90] tests/acpi: x86: Allow IVRS acpi table changes
Message-ID: <5c5d6a0fdf2527a64f5ae5997d9ae59aa6d5f0be.1789071043.git.mst@redhat.com>
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

From: Sairaj Kodilkar <sarunkod@amd.com>

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260807061250.27739-3-sarunkod@amd.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..33e9981655 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+tests/data/acpi/x86/q35/IVRS.ivrs
-- 
MST


