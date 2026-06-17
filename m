Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E63CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrIL-0006en-IG; Wed, 17 Jun 2026 10:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIJ-0006eA-9P
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIF-0007es-KR
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781706662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mvif4jWQltHBgV/w5wEFWTNvwJBqfVpF+YaK0ldKm4s=;
 b=BghS77JIDx+x2ZWWkJyreF1CMVBhCo048P4/KMi7BPCplPYFmgorcJezwT1vDhDb9Xr6Fx
 dQxRQzfVg+yfBqL3DO2m8IEOSEM2HWh1Vho/jF0XrKT6lHrl517OnUyagiyFmE+bIHqGB7
 EE0QQpWWYEnOwwPuiNtGDUcll6ex+aI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-4A8AM-CcMHeNYeEALhjOrg-1; Wed, 17 Jun 2026 10:31:01 -0400
X-MC-Unique: 4A8AM-CcMHeNYeEALhjOrg-1
X-Mimecast-MFC-AGG-ID: 4A8AM-CcMHeNYeEALhjOrg_1781706660
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b79e6b94so56228455e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781706660; x=1782311460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mvif4jWQltHBgV/w5wEFWTNvwJBqfVpF+YaK0ldKm4s=;
 b=QNE0JGZKrxSFlEN5a074cYJOf1hHkkdVkqy1cVcWWHJzNjWpOM1m+lNU8V/4Kkr1i9
 zohLqL1S4ohrKQ0tzoYJBahMMMh84CUa2dFJMhqewyrYRsBJoQP5J1du78QpoNYePYD2
 PpszADaMV8LfZPWOItuptXnkndHWaZ7srQ10653UavqIMSjroPfklhffZAqYrq8mh3DC
 g/C5AtPkM2uYkYlAShpGU5DSmnDmSUh/gVVaGZZ3Qn78Wu1ctU+81ply4GV2LICz2K8/
 kehZVSEjOgXR/xmL4rQVjc4YT+jsWrAxzfJ5KBak3CqkEM7YAmTSHIHwlfOjm2+5Uwz4
 b4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781706660; x=1782311460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mvif4jWQltHBgV/w5wEFWTNvwJBqfVpF+YaK0ldKm4s=;
 b=MZ3weg1s4pc7f1yFBTrWSeWqAaAsOWmXwQLKHePIht6SRYCFqGXkqUh7F0N6bF3iU7
 FKGuPzjWASbPdeASehebvP2P6V8W6Y0+Zq/gTG9Vgwgy2nONADOoLshQS7WAfSf+lJOL
 8AJOxCCPSqzBzY6WjZY2SQmwcir95+MuaPTOo1pNOply4IFMyJDB8acwtvIAKbCj4ilh
 0MnJC8UvEukiY853UtLxDDNuKcswqzviBncGNIn4es1n8zuF44JiD5ThNo36aISpcXBt
 n7C7rlb1q4n7mz4yD2R/KtURrtCuV9xP4GbhuDTGTPwLbRER8D3jkQdmL1iE7Hy/d9Li
 Du1Q==
X-Gm-Message-State: AOJu0YwgUUBVY34Sw4M5qqulG2yGyMk5Ha0QSfg80Sn89xjGb1Iz4RDX
 XcuA7x66L/1z1peV6dl7h1PJqBXKeYeWJgY4ZCj6AoYwVhx+n7kMq0cQVK9jaBAXgEtsfl+Ndpx
 ipowZCRBE8HjrOWKhbv6UBtADKdPrLOMn15MPiEIWHcqljkPfLcsjLAVGF8cQV0W6MQLTT/lCt/
 e6UU8tXg/unymN0/brmHZbD1DVJVvUEGRAp6La3+h3
X-Gm-Gg: Acq92OEGe2UwZK8nZH7CCCHoTQ4gB6FD4H8nGp7B7rjcsG2SstbXDoRl9YMdVFflzZg
 dQamQSLel7yMpVP3rzMKO49dchkfG19VugmTumBYQKBURFcmIRCfzDLsLW5goIGtWami28Xm8EK
 ptQqm1rs4xXpGb3D35tMn1X645S6gUb1zK9KyuSdXIM6OLVEI+QY14YKeppPkld5YTFvvRcSAxU
 FFFAazD1noxKiBjRMbe5Nh5WYEZZuoMsyxoQMO3OS4voSrx+6gaFbXS/xEd6+189WVnncLxrneo
 5C+nGmJEYwhqTZpUlkIzSuzrU5SgQQK1SloU04aI4FNLflEuldFEmj9QJyMC9ceQI9zsgyToOAQ
 RdYfgyrnXKTJVmTUcQkaOziwaLWxZGT703xokaZUm0Vq6rXfwkIbauMEeEIiYzsZaZ2YtfF7ClD
 QjrQfXuZHQzbS8fmGf
X-Received: by 2002:a05:600c:a305:b0:492:2c87:3d4b with SMTP id
 5b1f17b1804b1-492333af19dmr55251555e9.12.1781706659670; 
 Wed, 17 Jun 2026 07:30:59 -0700 (PDT)
X-Received: by 2002:a05:600c:a305:b0:492:2c87:3d4b with SMTP id
 5b1f17b1804b1-492333af19dmr55250795e9.12.1781706658963; 
 Wed, 17 Jun 2026 07:30:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a58fddsm153567495e9.8.2026.06.17.07.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 07:30:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mathias Krause <minipli@grsecurity.net>
Subject: [PULL 04/16] gdbstub: Update x86 control register bits
Date: Wed, 17 Jun 2026 16:30:34 +0200
Message-ID: <20260617143046.445322-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617143046.445322-1-pbonzini@redhat.com>
References: <20260617143046.445322-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mathias Krause <minipli@grsecurity.net>

The control register bits haven't been updated in a few years, making
them lack behind features QEMU ganied in these years.

Update them to the current version of the SDM and sort the 32bit version
to be in line with all the other definitions (descending order).

This should remove confusion when debugging, for example, CET-enabled
guests:

- before the change:
  (gdb) info registers cr4
  cr4            0x8000f0            [ PGE MCE PAE PSE ]

- after the change:
  (gdb) info registers cr4
  cr4            0x8000f0            [ CET PGE MCE PAE PSE ]

Signed-off-by: Mathias Krause <minipli@grsecurity.net>
Link: https://lore.kernel.org/r/20260327143413.254227-1-minipli@grsecurity.net
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 gdbstub/gdb-xml/i386-32bit.xml | 47 +++++++++++++++++++---------------
 gdbstub/gdb-xml/i386-64bit.xml |  7 +++++
 2 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/gdbstub/gdb-xml/i386-32bit.xml b/gdbstub/gdb-xml/i386-32bit.xml
index 7a66a02b67e..1dec40e1d2c 100644
--- a/gdbstub/gdb-xml/i386-32bit.xml
+++ b/gdbstub/gdb-xml/i386-32bit.xml
@@ -87,27 +87,34 @@
   </flags>
 
   <flags id="i386_cr4" size="4">
-	<field name="VME" start="0" end="0"/>
-	<field name="PVI" start="1" end="1"/>
-	<field name="TSD" start="2" end="2"/>
-	<field name="DE" start="3" end="3"/>
-	<field name="PSE" start="4" end="4"/>
-	<field name="PAE" start="5" end="5"/>
-	<field name="MCE" start="6" end="6"/>
-	<field name="PGE" start="7" end="7"/>
-	<field name="PCE" start="8" end="8"/>
-	<field name="OSFXSR" start="9" end="9"/>
-	<field name="OSXMMEXCPT" start="10" end="10"/>
-	<field name="UMIP" start="11" end="11"/>
-	<field name="LA57" start="12" end="12"/>
-	<field name="VMXE" start="13" end="13"/>
-	<field name="SMXE" start="14" end="14"/>
-	<field name="FSGSBASE" start="16" end="16"/>
-	<field name="PCIDE" start="17" end="17"/>
-	<field name="OSXSAVE" start="18" end="18"/>
-	<field name="SMEP" start="20" end="20"/>
-	<field name="SMAP" start="21" end="21"/>
+	<field name="LAM_SUP" start="28" end="28"/>
+	<field name="LASS" start="27" end="27"/>
+	<field name="UINTR" start="25" end="25"/>
+	<field name="PKS" start="24" end="24"/>
+	<field name="CET" start="23" end="23"/>
 	<field name="PKE" start="22" end="22"/>
+	<field name="PKE" start="22" end="22"/>
+	<field name="SMAP" start="21" end="21"/>
+	<field name="SMEP" start="20" end="20"/>
+	<field name="KL" start="19" end="19"/>
+	<field name="OSXSAVE" start="18" end="18"/>
+	<field name="PCIDE" start="17" end="17"/>
+	<field name="FSGSBASE" start="16" end="16"/>
+	<field name="SMXE" start="14" end="14"/>
+	<field name="VMXE" start="13" end="13"/>
+	<field name="LA57" start="12" end="12"/>
+	<field name="UMIP" start="11" end="11"/>
+	<field name="OSXMMEXCPT" start="10" end="10"/>
+	<field name="OSFXSR" start="9" end="9"/>
+	<field name="PCE" start="8" end="8"/>
+	<field name="PGE" start="7" end="7"/>
+	<field name="MCE" start="6" end="6"/>
+	<field name="PAE" start="5" end="5"/>
+	<field name="PSE" start="4" end="4"/>
+	<field name="DE" start="3" end="3"/>
+	<field name="TSD" start="2" end="2"/>
+	<field name="PVI" start="1" end="1"/>
+	<field name="VME" start="0" end="0"/>
   </flags>
 
   <flags id="i386_efer" size="4">
diff --git a/gdbstub/gdb-xml/i386-64bit.xml b/gdbstub/gdb-xml/i386-64bit.xml
index 6d889692114..9ac9164e6a9 100644
--- a/gdbstub/gdb-xml/i386-64bit.xml
+++ b/gdbstub/gdb-xml/i386-64bit.xml
@@ -102,9 +102,16 @@
   </flags>
 
   <flags id="x64_cr4" size="8">
+	<field name="FRED" start="32" end="32"/>
+	<field name="LAM_SUP" start="28" end="28"/>
+	<field name="LASS" start="27" end="27"/>
+	<field name="UINTR" start="25" end="25"/>
+	<field name="PKS" start="24" end="24"/>
+	<field name="CET" start="23" end="23"/>
 	<field name="PKE" start="22" end="22"/>
 	<field name="SMAP" start="21" end="21"/>
 	<field name="SMEP" start="20" end="20"/>
+	<field name="KL" start="19" end="19"/>
 	<field name="OSXSAVE" start="18" end="18"/>
 	<field name="PCIDE" start="17" end="17"/>
 	<field name="FSGSBASE" start="16" end="16"/>
-- 
2.54.0


