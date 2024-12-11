Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98853E77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZY-0005br-VE; Wed, 11 Dec 2024 11:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZV-0005Ah-Fw
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZT-0000Sh-DH
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4k8q+ScOWCPKZP/2g98Fpy1OHW4u8pQDrcm/3Bs4tcQ=;
 b=PD/QDMk0qhVa8d3WctZHkLVv21/S+iWGvCxgCafQmkZlu7zycgDAnplpaeT9Rf17K8+nBg
 dSp/5z5wxljFgXbQobzQj4fqiqNIpsA65Rj3axCW3+5zJsLLSQoF2yP3gr8u1vGqPmk75c
 rq+S3YUmYU9XNSOAm+WTjoxE7m0M82M=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-9JN8otzIPFeoM-tNRgF3Hg-1; Wed, 11 Dec 2024 11:28:16 -0500
X-MC-Unique: 9JN8otzIPFeoM-tNRgF3Hg-1
X-Mimecast-MFC-AGG-ID: 9JN8otzIPFeoM-tNRgF3Hg
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5d09962822bso7277505a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934494; x=1734539294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4k8q+ScOWCPKZP/2g98Fpy1OHW4u8pQDrcm/3Bs4tcQ=;
 b=rOqWbPML4yvwqAN5NpMn4FfAIXT7L5YjCz99fVS6jhrmYoEgPPXNyG/J8DKjhmWeaN
 QgW9C0XLUYHkgWHq3hJFDzfJxXtwcCRKe29FWk9/vwdKZlM4gjTFnZ48+emtYC3jT1tF
 DSBprxyYpSC/VhY9hUng6yEKFkfP9VTjUt0L8OCCc23F8xVb896gOBEXPLwwn638i/7u
 fjX/Mm+aODtSAUzvsDP2mpB+3jL4Hx8psYjhnANn4ZedcjZwR+hVhurQVN7Eyop4gWIS
 r0lYiU7OjV1Jvqdb4xL/ZdrAW66KfjOS4s34OQ//sZBoii0xRurJpsKaYBgcvzDge9Oc
 UXkg==
X-Gm-Message-State: AOJu0YyA5f+hae0KhXOrGRyQCPaI6N3tTGE0SOoqDnhvSKCU8GoRcOY0
 w3OihpNMVdIpGdzFoHNJjy8Zyzzizcrg7z8SQltin3b1RzQMYzRpO2/gMa3YFXJcXxI4zN8Dy0R
 vSX10WpbPkN8Nl6Vsrfwsc5laK62VnJnteJXQjJz+JkLTe3D9XPav9qHvx00UaVmcViK0zD9NSR
 FGIYOgHktItvvl+rZSBgLwdytzT9sZCXRLS81K
X-Gm-Gg: ASbGncuJPXw3fxksYIbfxMlGv89wFDLNzYgIgYhY3MJu6o5fmcz5cvExEEBzzIYeSpB
 OfBJ38q7fLrDrtspf8fJvZlWjWBYexawR55Dt9iuqGAHHiviK+i3SJbb9iwnegxW6plABCtElch
 MnHm2z9mpT3KSXQPGzmMnTycQFiaoWlYjBZT5apOVi/DvC7dtg6fdx9GOZNOiTDEI4s81n0c4j/
 Zjk5L3ztQPmcZgaiMoVMMovE1elQfw5BPR9NTv47Z5UeTj4vbiBnD5M
X-Received: by 2002:a17:906:31db:b0:aa6:23ba:d8c8 with SMTP id
 a640c23a62f3a-aa6b10f520dmr367229266b.11.1733934493840; 
 Wed, 11 Dec 2024 08:28:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBiKPyw3k827tMhBFojKOcGCTTXqERQaxefBcHPL6pToXBm/WafX8bkxE4KUpx8i5Tn00HNg==
X-Received: by 2002:a17:906:31db:b0:aa6:23ba:d8c8 with SMTP id
 a640c23a62f3a-aa6b10f520dmr367225966b.11.1733934493378; 
 Wed, 11 Dec 2024 08:28:13 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa68f70cc47sm442307066b.123.2024.12.11.08.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 21/49] hw/net: Replace type_register() with
 type_register_static()
Date: Wed, 11 Dec 2024 17:26:51 +0100
Message-ID: <20241211162720.320070-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Zhao Liu <zhao1.liu@intel.com>

Replace type_register() with type_register_static() because
type_register() will be deprecated.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241029085934.2799066-4-zhao1.liu@intel.com
---
 hw/net/e1000.c    | 2 +-
 hw/net/eepro100.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 5012b964640..ab72236d183 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1774,7 +1774,7 @@ static void e1000_register_types(void)
         type_info.class_data = (void *)info;
         type_info.class_init = e1000_class_init;
 
-        type_register(&type_info);
+        type_register_static(&type_info);
     }
 }
 
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index c8a88b9813f..20b22d8e49c 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -2102,7 +2102,7 @@ static void eepro100_register_types(void)
             { },
         };
 
-        type_register(&type_info);
+        type_register_static(&type_info);
     }
 }
 
-- 
2.47.1


