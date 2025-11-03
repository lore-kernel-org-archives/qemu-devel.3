Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECD7CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1la-000102-Ll; Mon, 03 Nov 2025 16:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lX-0000yn-1Z
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lL-0005I1-Sx
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cddgOWi5vxb2ekzhK5snv98M/SU5nsUUCc7+MBdGfjw=;
 b=I4wBOe+vHNJpQWLRpWWNQ46Pw3H4yOWlIfEqAMC9CKaHCoM5gFuUwS5zl7Nsu7J+X3hzPv
 /+AyVwstpFb3Bc5aUXyqQ7GPL/1Ha6yImwfhrN5MajwSEYlyhTXkvBiAOcfM6FTyioGay4
 TJelCz8zRevxgL3paA8YCkCgMfI7FLo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-wulIexYgMy-CNQ7xU1cLRw-1; Mon, 03 Nov 2025 16:06:47 -0500
X-MC-Unique: wulIexYgMy-CNQ7xU1cLRw-1
X-Mimecast-MFC-AGG-ID: wulIexYgMy-CNQ7xU1cLRw_1762204007
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8908a248048so1185632485a.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204006; x=1762808806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cddgOWi5vxb2ekzhK5snv98M/SU5nsUUCc7+MBdGfjw=;
 b=gQIWb6DLg/qN/n5UIsTOwRZL+EXoi089Of6OyPkWSe6svXpwJ7mk7RLlUwNFWnHFA7
 tnI4njxYg5z2HP1We1+9eiizSn1zicTJTjZctBUk8YCSOUp/sKaN6dNv1lPPWmeDxSAo
 yU9OTmXfDHx+lZ9b9jPFj2cVR+rJqmlGrfCjpRS8+ppaO5PXRp18+cz5WPF7JZwQZ1zo
 japgWoUOY/PiMCnsc9/FUa5YtvtBHpRA0RBN5S5hHiW5m/W2KtVhz1ZHe4aFkhiKQogR
 d8QlYKo63wFhXFFEapUSd8BJu9mkfAfjxh8Lq9IGQUNijgNfYccsy8/ym0OQGA8MINXL
 Ofyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204006; x=1762808806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cddgOWi5vxb2ekzhK5snv98M/SU5nsUUCc7+MBdGfjw=;
 b=groS7w9qPQpSmOAAAPbDTMZqExGMsGfH3EL75QZb3CdI/dkTrR9jb+vsDKe3Waz1Ky
 7rKPH93BDet1D+yUZtfyOO6VJjBEnuAeAD2ZtgXR411gSr/BIYRRA76s7Us1uedhSgSU
 WAytWVfhazFWBWCWsEbxPZzyWCMkplHF0h4etclyp9nOj6zO70it4rmiywJ938JD51uT
 I7VuaG0OcBbO0qkTDLVcewZ4zE7x0f8DrEEfVAjZb5GG5dCpPUjHfxFSOXY4aBq0ARaz
 xmqHF2JTjUr4P4CJpKUOBam/XjfNbxUE+lnLy3kRIcmSYXbOy03YkTPIQOSmnqhas+q2
 PONg==
X-Gm-Message-State: AOJu0YzbsUNr1QSUYN84DTMzXX9gZWjJ7srxufYpTdRZ2fyDUm2UGv4F
 9lDM/RCPTf8God9Yv4h4bjIsPHSgkZcJlwAioo8tDMvIDOygavBFdcGDX1sHTY041wfjzA6Fxzb
 dRsrmmLH7RHXk9yzIMeJceuqLqEq3uOMJfKCL83xwNBcgNR3wo6+fFLLswQRvco8DqeefO0KEkp
 PEZoW7U9g+L6/wiwcbZZnMpf5+QrzhSOA9sECGRA==
X-Gm-Gg: ASbGncu+z1alXmwEBS5/nK1YfQnqb7ORxR/+ogCxwVkZA4vBYgJXKOW4yqxDjcJ/Xwb
 5//8wZAM0hSAt4TKg58q4qgzP+WAJmblJ0tv7kLZDSMBTCLQwk6FSTgzrDePIhQZIawr1iVeDL3
 oCe7grCfV6vc5X0rFywMvbVnlnOs3mqNZqwkubPnfUzztfs32uFMwj8OU/eLeDuevGA2SpVRv1L
 DkGIpD0NBUHe951Rvb4mhbGUO4jc2EYfb1mgP1TfYNTKh9LT9Ppzh4wYZE7hZe+6AJ+S9uhxeCD
 KQ1Kx8KUjbIDnqxGsX+SVXqycpXMs3gFMXEgubIdSQoS0gU133r9N6HkukERv9HV
X-Received: by 2002:a05:620a:4483:b0:8a9:b0cf:fba2 with SMTP id
 af79cd13be357-8ab9b883fbdmr1636097485a.86.1762204006044; 
 Mon, 03 Nov 2025 13:06:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLOfS1/7ozpb1CvUxcB1UwHLxPKgN4bsDiFLAUk8P9gMe5RjsXZLcimFfrXIiZ2aUE7gV3xg==
X-Received: by 2002:a05:620a:4483:b0:8a9:b0cf:fba2 with SMTP id
 af79cd13be357-8ab9b883fbdmr1636091385a.86.1762204005454; 
 Mon, 03 Nov 2025 13:06:45 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:06:44 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
Subject: [PULL 12/36] ram-block-attributes: Unify the retrieval of the block
 size
Date: Mon,  3 Nov 2025 16:06:01 -0500
Message-ID: <20251103210625.3689448-13-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Chenyi Qiang <chenyi.qiang@intel.com>

There's an existing helper function designed to obtain the block size.
Modify ram_block_attribute_create() to use this function for
consistency.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
Link: https://lore.kernel.org/r/20251023095526.48365-3-chenyi.qiang@intel.com
[peterx: fix double spaces, per david]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/ram-block-attributes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
index a7579de5b4..fb7c5c2746 100644
--- a/system/ram-block-attributes.c
+++ b/system/ram-block-attributes.c
@@ -390,7 +390,7 @@ int ram_block_attributes_state_change(RamBlockAttributes *attr,
 
 RamBlockAttributes *ram_block_attributes_create(RAMBlock *ram_block)
 {
-    const int block_size  = qemu_real_host_page_size();
+    const int block_size = ram_block_attributes_get_block_size();
     RamBlockAttributes *attr;
     MemoryRegion *mr = ram_block->mr;
 
-- 
2.50.1


