Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9978CCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRo2u-0007JT-Qp; Tue, 26 May 2026 05:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRo2t-0007Iv-06
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:25:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRo2r-0006wE-E9
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779787552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cAYxsNAglrMaiNid1rXS9baybLvBVW9RpVrfRuZBMdA=;
 b=NAksJYpfd6KPbK7FrdefoUCEO9wJUSEhJ9+1omrTIpbayNt6UUqfHmPtW48RpYSI77lmJk
 lAN01zh9Hfn0DoNrMJibzl5IHtCmR6Ly0k8nHNyj2Krn/I+C8P2Vl2KccDI2J1ioH610o9
 iQ/pg7IYD1F0KD5wVUKzB/K3KQa4G88=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-qOJzXxJfPhCvI927QYrgZw-1; Tue, 26 May 2026 05:25:50 -0400
X-MC-Unique: qOJzXxJfPhCvI927QYrgZw-1
X-Mimecast-MFC-AGG-ID: qOJzXxJfPhCvI927QYrgZw_1779787549
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49051422d55so29551295e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779787549; x=1780392349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cAYxsNAglrMaiNid1rXS9baybLvBVW9RpVrfRuZBMdA=;
 b=BJTSKXHu0xtH0y5irRBghh+8QuydArEKTM9GYKy5IWVIB/zgVZ+GW+oJU+jjVByDHR
 /9cBZPYhxYoY37EknTxmye4PgjqRMZSd3oWbxzL23AJX3sLAhaPhPK3BLU4ShK+wBXMl
 XTH2iaK86ny/7YRNQnIc6Rh5WSQQn49BE+RwTpo9hIq29cctXbWRd3HFbBcEk+qyPOjB
 QpY9U7EAw4Lf73C95t5B5bLHa5SPVfsC//C6LJYqLP+gQNtv6o0bWzklGXC1pQAfqcUa
 cQuALFt1cNiPU6PknYV41Fc0EoIuuS/agETja1yrqLnmdQlDuSvuejxAJApXBlhPhW0/
 Mysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779787549; x=1780392349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cAYxsNAglrMaiNid1rXS9baybLvBVW9RpVrfRuZBMdA=;
 b=lNi3zTURMI+5LsehGH3W+phexxrpM8X2GjgnMZE+2pQUPsxjtxT8CknOxJrnEKTFrb
 Tq4Lczxj+9davjw8roafbXzor0XAHlSIPep9aaINw/hv6Z3UT6Lxi48ivdDnDBLNoLMF
 JGyWtueDGdShmuEI7mwF+lBBCL7F4ofh1XEATMCpxw8nj4D1z2CtskIQs6WgMuaeK5Fw
 9XCuR9WFKfKZaysmbZBoW6t0vrj9TebGx2hhYv/GOjAzG81yoynUeuiWatd4CvjgmkOY
 AihLzfpjhf/IeXpvwgWq+bDi6RRKVKcicqDru5vZJRif7CWUqP1gQcc1PyiqBuzXLhQY
 GtAw==
X-Gm-Message-State: AOJu0YxY/ukgK8OSZrpqrGsxyuCSFRYEQ6BQEFcxMIUqLsxZmoDyyBgP
 w4jo+5IXZpWJebWyxc1K8iTB8T0EX5LeNDcD55dn83TyFrssBgPeokQCrJ0ZHI5iS6zrFcsiJx3
 iw6Ygu7gAoyoy1yEX5uqT6nxvaTWBIQPZh0UDAOgJLjTSBPrxEJmZDeXPozBezrGgAcmZTepPPv
 MdR9ucTogIlkVJh5/6gZhRtd3HsFPUTC2aUR51Z5ft
X-Gm-Gg: Acq92OHQrftIgZQYu1b4X3Wy12iFgChXncc887cBAaPdmemCabTyAcMPnoreOrABSAS
 683JqgJpcrHG08XpW/JQY3ep9vgzgPA2rmFU39+7cJ3WWpwEX1T0rWTNBnAwwCNhuXrjuAKFmcO
 ehOLtQ/cT1COd22KNlDqgmnINkNen7iJCjoQe32I/4ZxiOODaKDtEEqiLXLUCQep7CoSCPN8t5k
 ZRqd1EAGSGgK4WkH0JoAmb2xH0fY8sa5WNpHDXv2VMFORU574x/X+y97qglk5RdDNm+E1yb6URM
 4SZ6jSN3+vXiSQ7HisZctfya01Pa1Nu+QfEvBp0+PSqIOOoQSfs/mmStEhUh43ueZULT78jU6D9
 TEwnbE9EaSZiKYqJ8mOmOpppMWpXpm4KXtxjDx/2FXA3uNay3jiBccFz5uOLfKT29fQBrn8srQ8
 2uET1dg5oEvC55oRh76ztkEiyBianB7MPDo9sgkA==
X-Received: by 2002:a05:600c:4594:b0:490:601f:d784 with SMTP id
 5b1f17b1804b1-490601fd8d6mr145884435e9.2.1779787549192; 
 Tue, 26 May 2026 02:25:49 -0700 (PDT)
X-Received: by 2002:a05:600c:4594:b0:490:601f:d784 with SMTP id
 5b1f17b1804b1-490601fd8d6mr145883885e9.2.1779787548794; 
 Tue, 26 May 2026 02:25:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6cd151asm33282203f8f.13.2026.05.26.02.25.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 02:25:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] meson: use compiler_target() to get rustc target
Date: Tue, 26 May 2026 11:25:40 +0200
Message-ID: <20260526092546.149241-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526092546.149241-1-pbonzini@redhat.com>
References: <20260526092546.149241-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The new method in Meson 1.11.x removes the need to pass the triple
via config-host.mak.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   | 3 ---
 meson.build | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/configure b/configure
index e138d83bc9f..fdd2294db68 100755
--- a/configure
+++ b/configure
@@ -1747,9 +1747,6 @@ if test "$runc" != no; then
     echo "CONTAINER_ENGINE=$container_engine" >> $config_host_mak
 fi
 echo "SUBDIRS=$subdirs" >> $config_host_mak
-if test "$rust" != disabled; then
-  echo "RUST_TARGET_TRIPLE=$rust_target_triple" >> $config_host_mak
-fi
 echo "PYTHON=$python" >> $config_host_mak
 echo "MKVENV_ENSUREGROUP=$mkvenv ensuregroup $mkvenv_online_flag" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
diff --git a/meson.build b/meson.build
index bda5180c436..c265a00aed6 100644
--- a/meson.build
+++ b/meson.build
@@ -4727,7 +4727,7 @@ else
 endif
 summary_info += {'Rust support':      have_rust}
 if have_rust
-  summary_info += {'Rust target':     config_host['RUST_TARGET_TRIPLE']}
+  summary_info += {'Rust target':     rust.compiler_target(native: false)}
   summary_info += {'rustc':           ' '.join(rustc.cmd_array())}
   summary_info += {'rustc version':   rustc.version()}
   summary_info += {'rustdoc':         rustdoc}
-- 
2.54.0


