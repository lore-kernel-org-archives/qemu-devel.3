Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6074CC3065A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFPs-0005iK-MK; Fri, 28 Jun 2024 13:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPq-0005hu-UX
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPp-0002FJ-JI
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719595781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EmKkTMq9nQNBDUfIC/QAa3KWBTUv02XP17TptxQk01s=;
 b=fHZ5/Pc5XArM3uniPvlj9RuuYB12OflvoIORMzVcDhjKMNezVsyHNdiAUzOrWrK4JwhYMU
 DYeCQc9gVFaGXxqoXHzB7Q1FgnV0dm70cFMhytn0KLot9vfaqJ2Cj8vb0e4mGJgyleZ0W0
 /WhxTGJ19o9r6FzoQfXpqyAw+PskxD8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-NcUpT1-fNDSr5ucwVIvZqg-1; Fri, 28 Jun 2024 13:29:38 -0400
X-MC-Unique: NcUpT1-fNDSr5ucwVIvZqg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a7293303843so67520866b.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595777; x=1720200577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EmKkTMq9nQNBDUfIC/QAa3KWBTUv02XP17TptxQk01s=;
 b=NX26+k2gOHfJHHo26rOKV0lvB4sxl4CnE1qSkP9AEzL5OCNEcx0CaDWOHVomsgo8uB
 qy6GSu745xD8dA8qC2BPzfNO1KH1+5COZprOenxMIhfDPeaPKHQOIeytgO5Qd1yOjqTn
 in60xArOAKP/P7T3Yt032nwPcR3ISRbAgQCt+ncTCx2JQa5+vnN+V7yTfETg0KiATbA9
 RWtDg6MvtR17ApqteHBbdnpjL48sRoD0yBf8xsOZ99HkXR4xHrjZEqB3b6Y+Z3eWy4oT
 owqj5phkH2hfKyhKhKJ+cwchFNMgIDBdRq9C0lYrEdtpC9wtBdDnDWCCHoDNyE5WnQ0S
 0YJw==
X-Gm-Message-State: AOJu0YzRDWwpxbNOBTjPB206rA+WW38S9e0rR6xD+2jS2+KEYgPtuQ4X
 UPvLQe2a+tX906IsBCFrynUKKJZ8eqhb3QtDXRHIjIkr/1+jIY4L00omtR0ewHMAOUkt8Nm48O1
 3Wu13A8AwWlvzsx1oa+4LRuvtBYKOJUU6FMIw+gxNeh8dleYG2dz/wKQ9PkOKdRdeTjKKMM1KB4
 g2VC/zqfRAog3KwxuzHX0fAPEbJAJNTFnV+CdF
X-Received: by 2002:a17:906:4903:b0:a6f:b428:30fa with SMTP id
 a640c23a62f3a-a7245dc9c41mr1055602366b.59.1719595776871; 
 Fri, 28 Jun 2024 10:29:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzQ0yqWieYHvSWqlpuM/QB9AzIKXUZfMhYU3928VVmNZi9X68demmKj1u6C1k4JAadmOURQA==
X-Received: by 2002:a17:906:4903:b0:a6f:b428:30fa with SMTP id
 a640c23a62f3a-a7245dc9c41mr1055601466b.59.1719595776541; 
 Fri, 28 Jun 2024 10:29:36 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf60458sm96205866b.63.2024.06.28.10.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:29:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 17/23] target/i386: remove unused enum
Date: Fri, 28 Jun 2024 19:28:49 +0200
Message-ID: <20240628172855.1147598-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628172855.1147598-1-pbonzini@redhat.com>
References: <20240628172855.1147598-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 934c514e64f..95bad55bf46 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -282,22 +282,6 @@ enum {
     JCC_LE,
 };
 
-enum {
-    /* I386 int registers */
-    OR_EAX,   /* MUST be even numbered */
-    OR_ECX,
-    OR_EDX,
-    OR_EBX,
-    OR_ESP,
-    OR_EBP,
-    OR_ESI,
-    OR_EDI,
-
-    OR_TMP0 = 16,    /* temporary operand register */
-    OR_TMP1,
-    OR_A0, /* temporary register used when doing address evaluation */
-};
-
 enum {
     USES_CC_DST  = 1,
     USES_CC_SRC  = 2,
-- 
2.45.2


