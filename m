Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46450C3600D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 16:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6o6-0004Ti-KR; Tue, 25 Mar 2025 12:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6o2-0004SH-HT
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6o0-0007Lr-LO
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742918827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ImDkB0+F2AZZ6nVMjW8YwmsQbVMtET9p6F1zLsjNo7U=;
 b=PaP5TffHGIVJ6KW8KbAfzalAB3gpK5Lj3KSDxTmWYWRgT+vjEgiPpH2BnhsRXfbaUefa+7
 DBeOdQOftLzoX5miWJz9A1NhEFI9+W6e8u/TNCPEaw3z7kzXbYMtIG1uu6hKJCXLAPQzme
 hXEDYNN431j5DCQp98ySMxPw18mr9KE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-5DpyGNxtOZW8r-5WyVNuTg-1; Tue, 25 Mar 2025 12:07:04 -0400
X-MC-Unique: 5DpyGNxtOZW8r-5WyVNuTg-1
X-Mimecast-MFC-AGG-ID: 5DpyGNxtOZW8r-5WyVNuTg_1742918823
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d4d15058dso41030505e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 09:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742918823; x=1743523623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ImDkB0+F2AZZ6nVMjW8YwmsQbVMtET9p6F1zLsjNo7U=;
 b=oxtYwaTW3zo7M2Ki09lcwkhP6q++SRrbhxQWYERPFPBL7W9veJUlCyjBPVWMQssubt
 werYNu0O3z+h9afrv0vH0hc56M90Q8rJzqV9a80e9x9q5QOzBWYiOhhs314SrXf9OlPS
 2QYhK08CgUAw6miGryWXGUtfQsuv4XW3MAEWRxmc7qiHoScn3/4IYSbqrg5QNGLVXier
 1J0G312uCDNzxAus9qFJ/dHfG7wtX5xcSrbZgkKxTDxGo+iifnhE2opLbEQ+MGeOqFm0
 yGSE6efTV2UCrj6owjmClo94kyvA3XoUd6En7sLp1WNsMHiOFDTPecVsA5IQtOoZ9oGf
 oDEg==
X-Gm-Message-State: AOJu0YzzyM+XBnQhpWNJzXnBOVefmmfcFyk22hrNHTr+lOZs/tP7L8pj
 CyuLixcJJzVINbG6Qzqs8u8x+D9edVRJ0tqcNmU1Rd+EUNRigm6KS52E5qDR9PZ02HsuqjxZSjV
 +8QfF2PJfuabfkz9B63HFk7wNnocXsZaJNqb+NeZhakWYzUpWxP6h
X-Gm-Gg: ASbGnctendWqyvFv8y9PQubl/Zee4SAlXkU33PblbeluAgZyTefgMYNvCkz/SIrpKGZ
 HEDnQmfEHBAkh5JLzCs8S/McJj4y0XbTxXuL1EVpHtxNhKPYkHd3N8giKkdmnZWRYVvhCujujC1
 4j2eHZ4tBfYAGKgGgaVmmdugr28HMdh7+giOWk2vsnGV9/2TShqoP8PNQ2r3FIV+V+Ao90IY8s7
 HntAfIfQFSP3mu57IKPC4EV50h0IYl1u9mQ4UVMyrYhHxjNeV4gL5+s2VK4dBn2WO9C+JYVk7FI
 fgyNHO66d60Mw/AiDQre4IbvnWX36kV10ij/5EtEFZnYQI7srIGL5ld2PJOM9TB4G5VC7JcU3w=
 =
X-Received: by 2002:a05:600c:3c9a:b0:43c:ec28:d303 with SMTP id
 5b1f17b1804b1-43d5a36f0d4mr93134565e9.5.1742918821645; 
 Tue, 25 Mar 2025 09:07:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3DGszoH+yrDZ111N/7wi06iAhmWrV66Fa/FOz+AkC7suYLZQBJlrnfUysDiZPFb7hecHvfw==
X-Received: by 2002:a05:600c:3c9a:b0:43c:ec28:d303 with SMTP id
 5b1f17b1804b1-43d5a36f0d4mr93133995e9.5.1742918820945; 
 Tue, 25 Mar 2025 09:07:00 -0700 (PDT)
Received: from localhost
 (p200300cfd74f9db6ee8035b86ef736e5.dip0.t-ipconnect.de.
 [2003:cf:d74f:9db6:ee80:35b8:6ef7:36e5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9ef098sm13817927f8f.84.2025.03.25.09.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 09:06:58 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 03/15] fuse: Remove superfluous empty line
Date: Tue, 25 Mar 2025 17:06:43 +0100
Message-ID: <20250325160655.119407-2-hreitz@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325160529.117543-1-hreitz@redhat.com>
References: <20250325160529.117543-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 7c035dd6ca..17ad1d7b90 100644
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
2.48.1


