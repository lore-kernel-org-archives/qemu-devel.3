Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D268C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 17:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQRf-0008Qi-DX; Tue, 20 May 2025 13:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQRd-0008OI-MR
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHQRb-000153-ME
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747760878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oFv5D4hEy9mdg+wBMNu8OfO2ONidK/rNd3D0qeEm5jo=;
 b=YTBayRrAXFD8Z8p2L/t6AvDLaBOH5naTqxoastx6h7iQUgTVBcwYOBqdgd8O4hpCvOEUwE
 8HExdwp7veJXNmf+ecuvBMCaDbFPDx3MTVYdxU8g7DYr9A8oTqnEBjdBP6C4wBMzpaRKyC
 peQBzArp4rdYg/f36Z/Ob4aWpDfyl2M=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-B4lkGYMDMpi-hj2GyrwCNw-1; Tue, 20 May 2025 13:07:57 -0400
X-MC-Unique: B4lkGYMDMpi-hj2GyrwCNw-1
X-Mimecast-MFC-AGG-ID: B4lkGYMDMpi-hj2GyrwCNw_1747760877
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7caee990715so1612596685a.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 10:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747760876; x=1748365676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oFv5D4hEy9mdg+wBMNu8OfO2ONidK/rNd3D0qeEm5jo=;
 b=Ngkq4s7AaDYZ4bvdHFlPU+iGCODfKzdJkIgl7gQLrtrpTxXZugjKkp1YCdKRKxOz34
 sYNAIUJFOSUHh0Vqk/TgUFf0iJ8TYlgdtSJzoPo2+qGkYVgQrmmoATB7d20S5lBQ7T65
 peQDbSawOpxDqs5WIe4aMj81urWs9ImPV8BsHHBmuoE/HK240Lto+WwtWFLFs5JnKvzj
 g+OPI1ROJ//23sE7OZVUKVoxvOZExc9fChSL9xx+Pw59jdOPNCMGmZZYxVNxLu4gtctc
 KcKkDzqsk/QTG61T9+OGCgNAQ31kjBTpPzsXTpArGoBvV5F3UWWSxzqbXXWd6+pBdznr
 U8YA==
X-Gm-Message-State: AOJu0YwEvQLmta2esOUeyZosRC+GoZdgMW4iYFKZJWZUeKwGRK3ID9Y4
 TKVPrLgGSy7qT/HvOdDO4GyddFStASZE1qPZE3Q8jBRQMs1Mw8SwRN57z6TkrSvpEYWXLiAvgVm
 JfDFbB0BFpt3L32++9EfMtedsHI+/KTh0CQ9iGWhLlagESEuJpxP+bsCTb5q8SBc8QN2WxtJKkl
 +oSJAxHYfCDSv5MnWiR/aXiKYrgymbSLIUNhdCFQ==
X-Gm-Gg: ASbGnct8BuRA+gF3OETHmGyMsyhYR5TvpjFjpDlvTfNcE9QHCp2UlAEQ9TxN5Uwm83q
 ajIz8QmMIctLN6VbmgjXxBaDmqXAuwSgfEpmAhuvoRurhORxTfsrE/6z7hda6qy//5NO8sVTRP9
 h8+v1fWMWZnkmeloM0k8VTGHEFeR6HrcG8Fgyop24MQBdUSZxTUzHoV6KKnt7AZaL/Ar4TgI//V
 gZKvEFx2ni4fYZMOBW7Ge8Ej/vYyFMp2FEbXBB1SjIBhOZWd/E+NpupD2BvK+S2bBMpi2zuaP+6
X-Received: by 2002:a05:620a:2847:b0:7ca:f04b:3fa2 with SMTP id
 af79cd13be357-7cd4679cf74mr2588746985a.38.1747760875796; 
 Tue, 20 May 2025 10:07:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYQBdINaITNXB48B+U532tsejXcavQFUNo6veM7e/fx9HjYiddrbQOCrybaJ4QWMaEPgmYLg==
X-Received: by 2002:a05:620a:2847:b0:7ca:f04b:3fa2 with SMTP id
 af79cd13be357-7cd4679cf74mr2588742985a.38.1747760875446; 
 Tue, 20 May 2025 10:07:55 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467be47bsm763846585a.16.2025.05.20.10.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 10:07:54 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 01/12] scripts/vmstate-static-checker.py: Add new hpet entry
 for num_timers
Date: Tue, 20 May 2025 13:07:40 -0400
Message-ID: <20250520170751.786787-2-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520170751.786787-1-peterx@redhat.com>
References: <20250520170751.786787-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The old "num_timers" got a rename.  See commit 1433e38cc8 ("hpet: do not
overwrite properties on post_load") for more details.  Teach the script to
accept the new name.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/r/20250501151235.636709-1-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 scripts/vmstate-static-checker.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/vmstate-static-checker.py b/scripts/vmstate-static-checker.py
index 25aca839a0..2335e25f94 100755
--- a/scripts/vmstate-static-checker.py
+++ b/scripts/vmstate-static-checker.py
@@ -91,6 +91,7 @@ def check_fields_match(name, s_field, d_field):
                       'mem_win_size', 'mig_mem_win_size',
                       'io_win_addr', 'mig_io_win_addr',
                       'io_win_size', 'mig_io_win_size'],
+        'hpet': ['num_timers', 'num_timers_save'],
     }
 
     if not name in changed_names:
-- 
2.49.0


