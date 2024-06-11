Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF6EC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2SE-00084d-3d; Tue, 11 Jun 2024 10:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2SA-00081b-0D
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2S8-0006CP-90
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r6hBXhNFSn6XnN10peBZQcMiiSC3ONu5LVhdZGr0HFw=;
 b=VjTiuD1nFcgsCjBLsYt/V2pjTY7ikIE0bA6+TJlkDAS8ovbum3zxLtQ6UvV/Ok3FuCiAvL
 pidQf2MgqAG5DhJbf817Q4VlP28wftBqHe80c3dm4Ia37hrnBgydShds4PvgTos64CQcgx
 xu81c0XMIkfT5nW+3YU8ldjKEBSAlEA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-1NLbYhj3M6a-VI4u_VttqA-1; Tue, 11 Jun 2024 10:26:21 -0400
X-MC-Unique: 1NLbYhj3M6a-VI4u_VttqA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6f1e3da75aso112703566b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115979; x=1718720779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r6hBXhNFSn6XnN10peBZQcMiiSC3ONu5LVhdZGr0HFw=;
 b=mL8DcDaoKJ5zOAAdBsyTFVfjWs7qXU60aMNlcZ3imVH/aOWwqUSWpGd4ppzrLokXoo
 u2xpiG8RF4Wht8swwQEKcim20Iq879MJWDbpCURWIShJnsMQjhQsrpfmV2I2ZQO5kv+S
 RZdP00WAw+dRpvRai5M/4Mm5nL2HB97VfO7PfgEubtB75utVXcBQFMeUobMSHmu6dMin
 Q4qgo96aC5/4X0tRyy4dBOES/hI0MPpIXRhNojUh/vw4Q9bGWJjs6xWkwLboUN/t4QP9
 sEdX/4WvLpvHo79U7BAWy/QdCTqLEB1jw0Bz1a7vQINfRFWMKlqCP+Q1eHGrT+3ElBys
 oMrw==
X-Gm-Message-State: AOJu0YzRH3TObib3++8BuDPuuEJF9soC4L1/UPHwTRgIiCEXlhgNJhzk
 ms9y2EGENPmblUq5fgWLyWNQfylHHftpQkjmvwPM53A594sjjHcpmB0rww6tXx6mTM8QXASeRuP
 9l9+1huduzAJPu1JoH1Vmzr2YIWEZdGeZWvbbtwxpGRAgWclN0/ONUU4aBUjCu/BrxlqVLAlIjt
 ooAJO1VChxZ/OSUjZd613MZxafbpIimiUFe7ck
X-Received: by 2002:a17:906:528f:b0:a6f:1f66:833e with SMTP id
 a640c23a62f3a-a6f1f668436mr348361766b.10.1718115979495; 
 Tue, 11 Jun 2024 07:26:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYlP9NrOrSbddtu/glGJYsCVIsg2RrR2yseTSoGBI5u00eOM8Z/hdhabcXBZUaT5Yvzqw+AQ==
X-Received: by 2002:a17:906:528f:b0:a6f:1f66:833e with SMTP id
 a640c23a62f3a-a6f1f668436mr348360266b.10.1718115979080; 
 Tue, 11 Jun 2024 07:26:19 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f0deda4e4sm433241466b.177.2024.06.11.07.26.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:26:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/25] target/i386: SEV: do not assume machine->cgs is SEV
Date: Tue, 11 Jun 2024 16:25:23 +0200
Message-ID: <20240611142524.83762-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611142524.83762-1-pbonzini@redhat.com>
References: <20240611142524.83762-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

There can be other confidential computing classes that are not derived
from sev-common.  Avoid aborting when encountering them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index c40562dce31..30b83f1d77d 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1712,7 +1712,9 @@ void sev_es_set_reset_vector(CPUState *cpu)
 {
     X86CPU *x86;
     CPUX86State *env;
-    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+    ConfidentialGuestSupport *cgs = MACHINE(qdev_get_machine())->cgs;
+    SevCommonState *sev_common = SEV_COMMON(
+        object_dynamic_cast(OBJECT(cgs), TYPE_SEV_COMMON));
 
     /* Only update if we have valid reset information */
     if (!sev_common || !sev_common->reset_data_valid) {
-- 
2.45.1


