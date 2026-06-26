Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A9ACDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3ez-0003FC-09; Fri, 26 Jun 2026 06:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3ew-000365-Tq
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3ev-0005QI-2v
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jDJzWr4DPm70qXaqFLhNskSOs+Tj3s84msP9xo6bd4U=;
 b=Ye2SFDiK6atcZEoph9p3eejBcIH1ikXhieDD1M8Zw3HyM2iWUtoCO8/VRKc9+9IOfWQ4bx
 k2WIvnq5vJwenU7jctgSd1na6dYXvVUvGf/zaf0xe3tmxYUhcosjz2M0XzJ7ES7k1ot1c/
 2LOj8/I0Y0vwjvUXSinXMqaYWq5cWBQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-dstnw27lP7ON8iN9-i7rgA-1; Fri, 26 Jun 2026 06:19:39 -0400
X-MC-Unique: dstnw27lP7ON8iN9-i7rgA-1
X-Mimecast-MFC-AGG-ID: dstnw27lP7ON8iN9-i7rgA_1782469178
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4924d5231daso6080065e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469178; x=1783073978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jDJzWr4DPm70qXaqFLhNskSOs+Tj3s84msP9xo6bd4U=;
 b=r5Y6rxJkLplO3gmTgiCmrI6SlmLNhEMgOuyt/hunf9XlWB5de5DnlfzamRNeT3eg5y
 vHLd6bwr33Tviu41VQfsvValUDHmRyZ6qsrZR4lxsFNSFbm5xoIhFkUc+cP625VvcE7h
 Qi6jX/TGdW7Wr17mnhqFxKRzzwUO+jrfRkhSE6BI3tG0bL7f9AJbHFojNTzUXDKgG49A
 vCMNB9KLe2Gz7/LhO/pIl7bNRO7Q+cdk14nsB0tSv9TIeEXUlVzeViYFyeXF5YUy/9of
 4MXgryKeTNV2qUDHXrSJXS+p0C3HazdxjibnJRHvVnT/zBP5TY69rTHZV6AEm8AiuQJC
 Eekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469178; x=1783073978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jDJzWr4DPm70qXaqFLhNskSOs+Tj3s84msP9xo6bd4U=;
 b=o8yY+gK8swcC07KUXK7yO68rDDpcOYObaMAOS263nnMYGHf5LOiQNcBdPokOL7VKK6
 LrjlzZbAKVrnuWzvcLLkDHEdUQup5vB9Yu38LcI5fLAuVjEhZrsPCVvmes6c1gf/DIyW
 Jo981vYyxxUv/VhZ+/bM4vB3BnUtPYzyMOJ82TY+XS6G4qOGmj4eWG5qgTid+8ChuaHX
 5DloAhQaLlJjT/1Yo2vUNle+p5SAcR11LqNCaicsSTiqB0ihnisiNiRve1OVytYtLUEt
 L319rlJyzlgFHbCR4IX58H2uQKEw9MSZ8j6e21ebYb44004PYwwLaOuFFthrK3/0wYmV
 /KKQ==
X-Gm-Message-State: AOJu0YxtL2n49XShaAfcQ2aQ69wLcYgQ+gci1Ha9UG47bCDAF58FV7W6
 XOBbgcEyfDT0qQdMgYhjBjj71s1q7gA3otE1GgrQdBTsn+HlJ9cxshSOFvsDMvOaW9glS9X+pYo
 zvW55y51YDv1h1mhyohSxmXDffXKVm7MED8BM1tBV0/tPjlErFsirgTtyhtFMkTBI12ANCNHOGk
 dsW3DyDhKQWuRkg2XEV/3PxpKfoID7yCc59V59R2BB
X-Gm-Gg: AfdE7cnwYWUzYqTm8XBE93DVV67onVF/15xZlK+qo+qPGiNQpctPWCsO9XMs96DyhXd
 2oOZUtTOInxD8WPopNJmj+qwhZutMB7iB3/CNV+1XRlTGyiEvp4yWzctG+LuGqNV/Ak7VhJ+xT6
 HfRlk0UbHx2mY/1mi6aHwCwuYrt5zzU+g17FA2koLhTKZNB9ExosrGlYZ4LtqUA/Nn7DEm0Lz2y
 B7BTq3w1Tva1xNsYXODFBZJZoKedOOApYwo0Bbi1GFCnD48QZsZheISHIrFa+rAuVMEpUWLLsLV
 lZ8HloWmPCVJOlgT6IQvRt5OerhzDn9VC9OsEVpwJ3WNKk5u6XNGzJNJ/5N5bgl/gmvvPC2gIP6
 x9SkvmndX9EPdDNIu4B5/3ZXPu8CxacwvpkhIC7/Nc40Vnfz+SlvT0YUE8xsOmapcGq1HG86pML
 Eaeg1FFlaP6pMwiT79
X-Received: by 2002:a05:600c:3b17:b0:490:b7e6:bd1d with SMTP id
 5b1f17b1804b1-49266874055mr95173075e9.16.1782469177868; 
 Fri, 26 Jun 2026 03:19:37 -0700 (PDT)
X-Received: by 2002:a05:600c:3b17:b0:490:b7e6:bd1d with SMTP id
 5b1f17b1804b1-49266874055mr95172445e9.16.1782469177285; 
 Fri, 26 Jun 2026 03:19:37 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268fe949csm79379145e9.5.2026.06.26.03.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:19:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 40/45] qemu-options: Add confidential-guest-support to machine
 options
Date: Fri, 26 Jun 2026 12:17:43 +0200
Message-ID: <20260626101748.1728079-41-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

"confidential-guest-support" is the recommended property to configure
machine with confidential computing technology instead of
"memory-encryption".

Add "confidential-guest-support" to machine options and call out
explicitly "memory-encryption" is the alias of it and not recommended.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20260512084458.622465-4-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-options.hx | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 03456527910..a8ee5d14e14 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -36,7 +36,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                dea-key-wrap=on|off controls support for DEA key wrapping (default=on)\n"
     "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
     "                nvdimm=on|off controls NVDIMM support (default=off)\n"
-    "                memory-encryption=<id> memory encryption object to use (default=none)\n"
+    "                confidential-guest-support=<id> specifies confidential guest support object (default=none)\n"
+    "                memory-encryption=<id> (memory-encryption is the alias of confidential-guest-support, recommend to use confidential-guest-support)\n"
     "                hmat=on|off controls ACPI HMAT support (default=off)\n"
     "                spcr=on|off controls ACPI SPCR support (default=on)\n"
 #ifdef CONFIG_POSIX
@@ -100,8 +101,12 @@ SRST
     ``nvdimm=on|off``
         Enables or disables NVDIMM support. The default is off.
 
+    ``confidential-guest-support=<id>``
+        confidential guest support object to use. The default is none.
+
     ``memory-encryption=<id>``
-        Memory encryption object to use. The default is none.
+        The alias of ``confidential-guest-support``. Recommend to use
+        confidential-guest-support.
 
     ``hmat=on|off``
         Enables or disables ACPI Heterogeneous Memory Attribute Table
-- 
2.54.0


