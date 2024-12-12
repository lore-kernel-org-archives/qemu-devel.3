Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1355E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 20:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLq6d-0003Zh-0f; Thu, 12 Dec 2024 15:48:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLq6b-0003ZB-9J
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:48:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLq6X-0000tv-Ux
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734036490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R7ZPor/d6qfaqpGPHzGBJG+I4KBraL5l1GdaMqLuqQs=;
 b=YPHvqR2NmO2xrwiqe0G0AUwiCBFVEEZk2f4R7UpkRBnAuXBx62tl0Mp+wrS6tb7cWK45v9
 6eHqFEBLSTDcqTJsEbRqhlLebuslqgcDw0u4a04qpToh888N/zwfIeZ0/H34EsRQfcE30h
 P8IZ7hDZjMT7DaGH1olnAybo5/MPMwY=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-TLz9ysefOq2KSPfCAM75Bg-1; Thu, 12 Dec 2024 15:48:08 -0500
X-MC-Unique: TLz9ysefOq2KSPfCAM75Bg-1
X-Mimecast-MFC-AGG-ID: TLz9ysefOq2KSPfCAM75Bg
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-844e5cf7b42so54398239f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 12:48:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734036488; x=1734641288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R7ZPor/d6qfaqpGPHzGBJG+I4KBraL5l1GdaMqLuqQs=;
 b=pAlY9G2/ICeRsGwhzJqNIjYgD/nVsG8nP8G157vMlOhF8EuBqOG6O+ecp5uQRElUVQ
 gXQ7i8HSdvtOR0e5iR3sDW4y6se/EaKsdhEYgMnBveKc0WRzxApSgG8azhW8IdKT4B1C
 9f1LWcqOIymJESVTpoGKqeF8Ne1Gad9L0C665Jy59/wBv9OBrQbtnUhGwwIRU3F9Bb1a
 WabDD8Ql/+0L3vW1YKyJnmBOxn2xHKggH68vU1fbHx20XRxsEwQ0vE9sjVkFPFnYWOly
 NISGkVChBtta9xyKx66GKSqV33SUWyULt8FmIFrjXOm/R2MpJRUztp3ZDC4sBu1phKug
 yAWQ==
X-Gm-Message-State: AOJu0YwOrnzV16UBJyxAs6NVth25M6ZjKVc71fRtnw/IqMR7X0c383iM
 /H31R14FOBuTzD03HH78cMnCQh/XNZz2/RQUYD1gdA8lWFKiRdUWgvkJTcGYv21Sr71U9rbyi+D
 etURCKdpCsb5XW2TzxVmZ08Vtq64M/hwfz5wgTIqtaDTYL2tmanT5JfmUhlAA8tNGd/JrseZW9l
 4cfqEMDhwRNB8eWh2/yHaIVfNuCEyMzixNsQ==
X-Gm-Gg: ASbGnct19B2qGKbv1weaSFCnT7tzE9gD2g/F4+JZNyNyWE1jARH3XOpICADWF5IRxr5
 BzogfxSZMS94FoV7Vw1dKTmvHExt10f3DVoSJ5QKl3XBV7rDSDG2f4R9xIq3M2aRnZd2oJrd1Bi
 1YYnDPMzJvXPqBPnCCBUQg8r73DEFqE1mg4Sc5XyBR6epvFty1MyNWapCQy1+xiXsplKDYbNS9f
 9c1JByeyCtbbvP9LlEey8RfIYTELS8EuoOxCSg052ox8oSiA1d9ruwK70hlTIzbib56o4eECU8D
 3Xy+SdD0Tzeoh4fIN/01HbeAwqyaaGl5
X-Received: by 2002:a05:6602:3408:b0:83b:5306:d24d with SMTP id
 ca18e2360f4ac-844e5cf3815mr175788739f.6.1734036487739; 
 Thu, 12 Dec 2024 12:48:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUNkLBmHa/e0+fZawLuanIQAwXuQvSLW5YjOx4fs9qb8Q5oG8jMp+4Fpgx4Dc0G00zYVB3/w==
X-Received: by 2002:a05:6602:3408:b0:83b:5306:d24d with SMTP id
 ca18e2360f4ac-844e5cf3815mr175786739f.6.1734036487394; 
 Thu, 12 Dec 2024 12:48:07 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-844e57b48fcsm20807839f.35.2024.12.12.12.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 12:48:06 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 peterx@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 s_sourceforge@nedprod.com, Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v2 2/3] scripts/qemu-gdb: Simplify fs_base fetching for
 coroutines
Date: Thu, 12 Dec 2024 15:48:00 -0500
Message-ID: <20241212204801.1420528-3-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241212204801.1420528-1-peterx@redhat.com>
References: <20241212204801.1420528-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

There're a bunch of code trying to fetch fs_base in different ways.  IIUC
the simplest way instead is "$fs_base".  It also has the benefit that it'll
work for both live gdb session or coredumps.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 scripts/qemugdb/coroutine.py | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 7db46d4b68..20f76ed37b 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -13,28 +13,9 @@
 
 VOID_PTR = gdb.lookup_type('void').pointer()
 
-def get_fs_base():
-    '''Fetch %fs base value using arch_prctl(ARCH_GET_FS).  This is
-       pthread_self().'''
-    # %rsp - 120 is scratch space according to the SystemV ABI
-    old = gdb.parse_and_eval('*(uint64_t*)($rsp - 120)')
-    gdb.execute('call (int)arch_prctl(0x1003, $rsp - 120)', False, True)
-    fs_base = gdb.parse_and_eval('*(uint64_t*)($rsp - 120)')
-    gdb.execute('set *(uint64_t*)($rsp - 120) = %s' % old, False, True)
-    return fs_base
-
 def pthread_self():
-    '''Fetch pthread_self() from the glibc start_thread function.'''
-    f = gdb.newest_frame()
-    while f.name() != 'start_thread':
-        f = f.older()
-        if f is None:
-            return get_fs_base()
-
-    try:
-        return f.read_var("arg")
-    except ValueError:
-        return get_fs_base()
+    '''Fetch the base address of TLS.'''
+    return gdb.parse_and_eval("$fs_base")
 
 def get_glibc_pointer_guard():
     '''Fetch glibc pointer guard value'''
-- 
2.47.0


