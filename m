Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC6FCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Ght-0007rv-Iu; Mon, 13 Oct 2025 07:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8Ghr-0007rl-UU
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8Ghj-0006EI-Iz
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760354818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LepuwBhAkX4dBl/Qwx8zxDytaulQLhzP+F8yzQjq1Ag=;
 b=fRSSCtBX4PF200pMJtASryjkiwTqvWTcwr1djyBxUbtrjo9eFBofmzNXhmxv/qRCCndcxD
 jdt3nBRfAXWKcgkvUVonYvw5ecejbO+OaBBcfqvakzMoa4gopkWxyaE8Mey9z71juZv1qQ
 Q4eOVDH0QGtE/wP5scEAPzOtDHA+qjo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-RJQZnj0aOBuIm1TUWzLq4g-1; Mon, 13 Oct 2025 07:26:57 -0400
X-MC-Unique: RJQZnj0aOBuIm1TUWzLq4g-1
X-Mimecast-MFC-AGG-ID: RJQZnj0aOBuIm1TUWzLq4g_1760354816
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b3cd833e7b5so519667566b.3
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 04:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760354815; x=1760959615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LepuwBhAkX4dBl/Qwx8zxDytaulQLhzP+F8yzQjq1Ag=;
 b=NrcjSf0qQruNYc+kkU7qSO+TE6vE7Vjw5/ZnUGjxfmdYpBgvqEor7TiIxTlKQR9DhF
 avfIFujsrO4lx9Tr4Kt24uVBL+7VBgIi/E2eYLBry/Cnb56VHeOByvYDXK/7exMBDD7z
 b3bEkzwFRYRJmQr0Jip6ZrmjBOAtRe5riY8Y/YOqq9DW4zM3njuwaoZdPsUBNGgxnIu+
 XEoAnWg190xCccqQHu+Y19VPwVhJa/V1tpBcGc5Iv+1ziHxYYDa/AsNVoneiSgI3fWVZ
 bWaD8tnJAxrYtTUCDIdNh3JfOJkRBE4U2z2fklUNdBwWo9T7TkbXwy91hNdHCUnyP0xK
 NzXg==
X-Gm-Message-State: AOJu0Yy2es6v2sWZPT6Z9AYRIzzNuhtx2VbdCrJeyqpKwH1BODF1n7dc
 8MCktfXGL78/7pCTR4ONrVOvYNDD4SWagm9YaI5VW4pwPwzQ2aAzEKVK7s8TAXO1RjJcdO4HxQW
 T0d7u083Fwxsl3VpVJYgitL5opU8V1EY6LpDzfyI4JxdPYluMvSRkANkp75H0G4dMKL8OUBUzJ1
 qdIezGRL3mDepwBoNqzLZ0XOosd8Saqhm3Ly4/JbN2
X-Gm-Gg: ASbGncuOgjSQUgbb6+QLH135GnFKKGdzOD+ogzYHVPnvwSEpOZNDWTnYoeAxR7uQt14
 xyVMSLzdgX2yUr9nBOjQwD6sT9Eu7KvFoE60YoVGr+KFSGpSowaSWf577UWrCSXjWnIpX8VWfAX
 slX6kAH9tdeHrnUG2COpvTY2MXpLA1GwEzWU95nKHPIpfRaLkxg4fIGJfX5EV3ms0U4wwssnZjS
 LvNygvTV9m57HKEKEX3IkwUYxwHCczZsq7GOXKKvFaWWIWd66LmIRIKBPAcTYV0d3NSOLesdu8H
 FOaHlUST9Zgf+vsswejBl/F+aqpyg3fI0wEyBn1U1KiTlBbjdpkGqEbpHLNFje+1WOQ/K4PeUtB
 HPwfRbwhi13u7lNf8iE/GoXirmhak+2fgDfrWAYXnxjU=
X-Received: by 2002:a17:906:cb85:b0:b54:8670:7c2d with SMTP id
 a640c23a62f3a-b5486707c37mr1442817066b.55.1760354814853; 
 Mon, 13 Oct 2025 04:26:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkVjm3y2bRwCKwPxui8m0M/ZFHeyS2iqW9F19UZaqjvBvZ6PpM4oZ44ayQ7w7wTthIk7HJxw==
X-Received: by 2002:a17:906:cb85:b0:b54:8670:7c2d with SMTP id
 a640c23a62f3a-b5486707c37mr1442814966b.55.1760354814466; 
 Mon, 13 Oct 2025 04:26:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d931d806sm939689766b.71.2025.10.13.04.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 04:26:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Praveen K Paladugu <prapal@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/2] monitor: clarify "info accel" help message
Date: Mon, 13 Oct 2025 13:26:49 +0200
Message-ID: <20251013112650.935921-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013112650.935921-1-pbonzini@redhat.com>
References: <20251013112650.935921-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In preparation for adding "info accelerators", explain that this command
is about runtime statistics.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hmp-commands-info.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index eaaa880c1b3..c2aa40056bb 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -271,12 +271,12 @@ ERST
         .name       = "accel",
         .args_type  = "",
         .params     = "",
-        .help       = "show accelerator info",
+        .help       = "show accelerator statistics",
     },
 
 SRST
   ``info accel``
-    Show accelerator info.
+    Show accelerator statistics.
 ERST
 
 SRST
-- 
2.51.0


