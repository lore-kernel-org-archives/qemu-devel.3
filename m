Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B011DCAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RuN-0000H8-0M; Tue, 30 Sep 2025 00:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3RsO-00066O-8L
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:22:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3RsE-0003Fy-NY
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759206115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9gc7wzZUyIJXyoHgHGeLqeL6vT8K0cbzJspgkY8Cs98=;
 b=f1eSHCx11gLkhewCejHjRC3hoAejz76kLvWeGWluNuSZJCEjgdaVr7bweaFV+8I9DYN3vN
 VMlj3rqFYnxseZlmI11Z6E8v1kH1prZyZGv2zJjycJdq1IabMkI62kntd6gUdQ4oJ6BTjp
 fPhtiK5awK9E1wcYfb5NG/hUfNkNudI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-Pr8oAipLP-O6LcYsU8oadw-1; Tue, 30 Sep 2025 00:21:52 -0400
X-MC-Unique: Pr8oAipLP-O6LcYsU8oadw-1
X-Mimecast-MFC-AGG-ID: Pr8oAipLP-O6LcYsU8oadw_1759206112
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b5527f0d39bso7639956a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759206111; x=1759810911;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9gc7wzZUyIJXyoHgHGeLqeL6vT8K0cbzJspgkY8Cs98=;
 b=mywd/B657IjZ0xjxtL6FBDnznoVDgHvWiLu+WOhCkTcxAJ9JQSrHDOOxIkdQByezLK
 hKHjhWvTIkgzZc2O4K2DFW4kqW7GqirhaebT6vEiTEgcwpj9ztoJBtomctUPY607sjZ1
 waq/idmcnbwrqO2ccT/VDxN+ElxO4QzORRHIXBd8O6B9p8QdETOo/OtWHRzJKNS5yZCj
 Dx1w6KAFMbYx4Yf0wb42KzcfsHpoFnnjWj994PqWwkRmLeTJAE0PS8m7/i3HSWD1981n
 5WXf0tIMwdtGcHlgtLMMpG96sUXMGIDVc5GGPSxzHzOInvIdCYURZ1E5I9lPOx3I9Hsm
 LkUA==
X-Gm-Message-State: AOJu0YzUeBYxaxM7oCbN9gD8UKsUQ7xTYx3NwypxvTfsilImmFKP6SM3
 1d0rnYv91/RVaHTKdNblcf9whtUtDssACNHHI00/BQSkf+8vntKcuaafxexg6yr5eFEsEMVJ6yC
 vY/dWHtuNtX+UImjMPPnv4EcpoKz2J4zVj6VmxrN9OADpYr+BXl3d5GOV
X-Gm-Gg: ASbGncthXfrdH6SOzdmZODq0Ichs61bhFaGRYIpG8iImHqAf6ToXT9I7ApfoK0rwPEO
 EYyG4/r4Atft1BTW/y/gdQKrKr2LlYnFjpFWmkEZ1WG27a0JdR4YGr0sBpRdhH6zBpw7GyqKaU9
 JdpIkqfXCYp8gIcc43dhOPZQznHvdlbS2mf4btEz+j9nBVpduVv5Ko0vrOnq8lljS/z+bAawdqG
 1lhIIxsD3LcEYfUGx4I+Uwl/aq8RA8lB+G2KiU8Vx5OQbfY73duMEqhaV86fCsHDOuJd9Q8Y09Y
 GnOtvGnLtV1r+40tKKXqCEuocDc4kULMACUbaari90MsAEgH5Ia5bfbxfA==
X-Received: by 2002:a05:6a21:6daa:b0:245:fb85:ef69 with SMTP id
 adf61e73a8af0-2e7d82c3279mr23825791637.40.1759206111686; 
 Mon, 29 Sep 2025 21:21:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMk7W4Q6Ln+EuBwkSEVrVfqYwHwVT8JJ4QmdtCFrAm2/+TypgYuSlqlv3DgQ/YnVdYdr50Bw==
X-Received: by 2002:a05:6a21:6daa:b0:245:fb85:ef69 with SMTP id
 adf61e73a8af0-2e7d82c3279mr23825767637.40.1759206111331; 
 Mon, 29 Sep 2025 21:21:51 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c55a339dsm12534158a12.40.2025.09.29.21.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 21:21:51 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 30 Sep 2025 09:48:29 +0530
Subject: [PATCH v15 20/26] migration: Return -1 on memory allocation
 failure in ram.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-propagate_tpm_error-v15-20-84afd3af1e47@redhat.com>
References: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
In-Reply-To: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1743; i=armenon@redhat.com;
 h=from:subject:message-id; bh=5O+CXW2cDOnC8HtDO4/gLXusDTQkF/UkXMU+X+jO3fg=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8btKMEjr7ULBNVYZXN2Ps3+w9pvk7DAVmWKZ+7bY6yVq
 zsNOxd1lLIwiHExyIopsjR8DZBtCiiMiLR9eR1mDisTyBAGLk4BmMjNSob/Gd1VN1+5SBdOP2Uk
 UO65JdB2+6Ujyi7hswPtahiEW2yKGP6nmWh1MP94eXz2+pC4CtOSq4GrwioD+d/KHpxaplBiZ8c
 NAA==
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The function colo_init_ram_cache() currently returns -errno if
qemu_anon_ram_alloc() fails. However, the subsequent cleanup loop that
calls qemu_anon_ram_free() could potentially alter the value of errno.
This would cause the function to return a value that does not accurately
represent the original allocation failure.

This commit changes the return value to -1 on memory allocation failure.
This ensures that the return value is consistent and is not affected by
any errno changes that may occur during the free process.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/ram.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 6a0dcc04f436524a37672c41c38f201f06773374..163265a57f26fb1dc88d9797629d58c278e9afb7 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3575,6 +3575,8 @@ static void colo_init_ram_state(void)
  * colo cache: this is for secondary VM, we cache the whole
  * memory of the secondary VM, it is need to hold the global lock
  * to call this helper.
+ *
+ * Returns zero to indicate success or -1 on error.
  */
 int colo_init_ram_cache(void)
 {
@@ -3594,7 +3596,7 @@ int colo_init_ram_cache(void)
                         block->colo_cache = NULL;
                     }
                 }
-                return -errno;
+                return -1;
             }
             if (!machine_dump_guest_core(current_machine)) {
                 qemu_madvise(block->colo_cache, block->used_length,

-- 
2.51.0


