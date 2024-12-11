Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6B1E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 20:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLT9f-0007KC-1A; Wed, 11 Dec 2024 15:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLT9a-0007JW-4s
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 15:17:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLT9Y-0004Ck-OS
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 15:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733948268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R7ZPor/d6qfaqpGPHzGBJG+I4KBraL5l1GdaMqLuqQs=;
 b=MqgufnUtAWjCpaTMwih+ahcrD+nQnUHfnwy7fx3tpbFMH0o8WWTDkJnpVXHoXL2U118XZh
 TVnNmd11RvwZxxizkRmj54FIHsj1WYqb7ga78pcRMtzfSrfZ8DIRMAiPKEn4dsF2KwespY
 M85s/OLOHIoprIJOmwlS7y8ixotW+us=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-upDYD7GhNFW9avnbS6KX8w-1; Wed, 11 Dec 2024 15:17:47 -0500
X-MC-Unique: upDYD7GhNFW9avnbS6KX8w-1
X-Mimecast-MFC-AGG-ID: upDYD7GhNFW9avnbS6KX8w
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6e1b0373bso235549985a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 12:17:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733948266; x=1734553066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R7ZPor/d6qfaqpGPHzGBJG+I4KBraL5l1GdaMqLuqQs=;
 b=o8PtPW1zj45shTCUHWskf1MhN34y2WO/PCCYgtJlDELBha/uo6YraJPIY2zwgpVkZJ
 wUTR1BeksSUsdSSB/NbpdXqwh55J5qZ4ZdDVZmUzqXdv/cgmnWv1na2XhK43067iiTo8
 RwOrMK1mCCkX+sEuC28ONHD1sUanVYEEPaGiHfBFRSjxhauYJMVRg9m2cz44uGSquWVe
 h1cSdCMNYJTDZ5ND7zR7o3vd/uL8QyXfm8RHKc3kkuJFkE77QNMiZAYvpJ9NYLsjRVy2
 3V7C2+A29he63yyUKobW3PAiWhQt9YPMpiudaPw6vALp0WbuOMIcBGr3XOK269pnkd8o
 MJwg==
X-Gm-Message-State: AOJu0YxhKyxDrMxTcDLMdWeF4Q/pWQq2imD8FF5Deiid7e6Fi1Rq6sle
 8l9ETiwXvEG4D72QFvzmsfGcYPN3VF0Gq1UYSLq/w7qplSlOxd0tdFimCI7qNEssobFjGwb+X6m
 AL02SvM+uAvolOKGusolVSjy2Eec6WYk+KaF9h/KMXbRKjnfnzyIkkIL4eOQ2HweOGYG98o9At+
 pn1PG/EoQ56ihKstGC6xoDBOKhC4InHx7koA==
X-Gm-Gg: ASbGncsLq6WautBJkeLjteZSCL3Se28JB9blkHsJ8FuQhT/pjz/rcrytb8MvrLX6I6E
 nXwZ8FVxOcdJWRwhrSx4DxaPS5eIdh01LF36Pgfpb9GM0Lw+MBsa4ktiGKRZCiyXq1PUFowKlyB
 TMw9zvH8wpC2JE21KT3iBYzH7+DwpCWMsNa6VY9QlfHrWs+cBJ/G+4vh+1TmNSl8G6Jr4YuGPiP
 QcnNAaxwLd1PNCVCpS8HxmYuDPq7GUDxmzBozzzdnz2fiK480DJ3BHw3zmbgZXNnIPcPsa/SmIs
 zNAPdtODS9LoEUplIsEtPA81Jhn+TQ==
X-Received: by 2002:a05:620a:1b84:b0:7b6:ecaa:9638 with SMTP id
 af79cd13be357-7b6f25cf9demr104343585a.55.1733948266010; 
 Wed, 11 Dec 2024 12:17:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzh2TIe0o90/z83/yVHm5+GnzmtKIOmFfdCGit5K7/tU4Vb8EDrp49iG1wN+r2DZOHja28wg==
X-Received: by 2002:a05:620a:1b84:b0:7b6:ecaa:9638 with SMTP id
 af79cd13be357-7b6f25cf9demr104340185a.55.1733948265641; 
 Wed, 11 Dec 2024 12:17:45 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6c8c6425csm438857485a.100.2024.12.11.12.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 12:17:44 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, peterx@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 2/3] scripts/qemu-gdb: Simplify fs_base fetching for coroutines
Date: Wed, 11 Dec 2024 15:17:38 -0500
Message-ID: <20241211201739.1380222-3-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241211201739.1380222-1-peterx@redhat.com>
References: <20241211201739.1380222-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


