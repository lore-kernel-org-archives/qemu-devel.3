Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00AFC27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0C0-0004KY-Ve; Wed, 05 Jun 2024 19:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0Bz-0004Ck-Ct
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0Bx-000608-OT
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717630637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NEpjbSqv96acXddAF0b5elzpuXpH+2dtKbhhCEe0wtQ=;
 b=dw6mLnElFjyzh2XFScvqDECHKhh0jp/2NSi0pxz6kjGMVYUaqebuh4LpWeUQfgcZDxc4dn
 N11zgTYdfpnaXk4O7Ishbhzmt/hliB3p7Z1roDgb799TUpMbw8t5G2P8bkztKT/xGox2le
 vKZctlUHg9OVmeLHEXahcdQBfNosa7E=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-APeOamKoOwmtussc24GMpw-1; Wed, 05 Jun 2024 19:37:16 -0400
X-MC-Unique: APeOamKoOwmtussc24GMpw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57a5af3e160so123053a12.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717630634; x=1718235434;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NEpjbSqv96acXddAF0b5elzpuXpH+2dtKbhhCEe0wtQ=;
 b=X8ELUM5X8JYC/4jHL3OhZNimEWwwGzdqE3OAL1vfKoWzfb+AavGF6P0axZHCJjVBqq
 w2Dv6ePIjvS1gbO7MGTAFTlMUqTmLhCnklP/mPBB0FYOLNPJKFqTn8MFR0H2jZaXYklO
 XPFd8qMcAT2dcLstg6IERG4Om4srvpcvYj5lU7/fM7O6vAEhMnTMcordfhSaAbzyY8zZ
 7OoGM2zWytKJcVQJDbaDcYR6R3dAz91X7E4XzLnOFQx5pAfGyEsO6O+TyrDDivBymp3h
 XcTVOUIz9tWAojEv5uOgBnjgELxPI/zp0CPfOXg8mekRcOlitSXumeuIV784JOf2JO3A
 bqSg==
X-Gm-Message-State: AOJu0YzMTocPyXbo4XzCIiaghPiQ0V0csQ/qXFaLoVrZBgx+5c4cnjSt
 yMhy9HOqTaZ2O/OFl1kbo2xPG1PKPnRls7WEmatHTQQarh8JlJSLmzTK3O10rtutqfiHFz+ADh/
 pJ1hXFYROdUUSDzuKbFp6lNqFX7A9OK6Sw2dBWH6vX+OyTQS9mFatNOhOSCnQYf513FgDXhQwXp
 F5CmLsNOH+Tak735EwaRDdz+iUTTI8cQ==
X-Received: by 2002:a50:d65c:0:b0:578:6242:d4b0 with SMTP id
 4fb4d7f45d1cf-57a8bcb4ca9mr2059814a12.40.1717630634418; 
 Wed, 05 Jun 2024 16:37:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhi2me5gPKMEG9l56JsDuYLeU4ReoKd1933zdsMlTCTE/dDagUJYZgm3KlVapvCJL3Qj72IQ==
X-Received: by 2002:a50:d65c:0:b0:578:6242:d4b0 with SMTP id
 4fb4d7f45d1cf-57a8bcb4ca9mr2059805a12.40.1717630633937; 
 Wed, 05 Jun 2024 16:37:13 -0700 (PDT)
Received: from redhat.com ([2.55.56.67]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae232981sm94523a12.83.2024.06.05.16.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 16:37:13 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:37:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL v3 41/41] hw/cxl: Fix read from bogus memory
Message-ID: <d23bc95d390a1800198c92a0177240d9e1a1eb66.1717630437.git.mst@redhat.com>
References: <cover.1717630437.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717630437.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ira Weiny <ira.weiny@intel.com>

Peter and coverity report:

	We've passed '&data' to address_space_write(), which means "read
	from the address on the stack where the function argument 'data'
	lives", so instead of writing 64 bytes of data to the guest ,
	we'll write 64 bytes which start with a host pointer value and
	then continue with whatever happens to be on the host stack
	after that.

Indeed the intention was to write 64 bytes of data at the address given.

Fix the parameter to address_space_write().

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/all/CAFEAcA-u4sytGwTKsb__Y+_+0O2-WwARntm3x8WNhvL1WfHOBg@mail.gmail.com/
Fixes: 6bda41a69bdc ("hw/cxl: Add clear poison mailbox command support.")
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Message-Id: <20240531-fix-poison-set-cacheline-v1-1-e3bc7e8f1158@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/mem/cxl_type3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5d4a1276be..3274e5dcbb 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1292,7 +1292,7 @@ static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
         dpa_offset -= (vmr_size + pmr_size);
     }
 
-    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data,
+    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, data,
                         CXL_CACHE_LINE_SIZE);
     return true;
 }
-- 
MST


