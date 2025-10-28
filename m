Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0D6CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 17:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDnaz-0005y0-U7; Tue, 28 Oct 2025 13:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnaz-0005wq-0I
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnaw-0004Qk-8q
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761672891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sw91OJuYj1JrwFfKm7ne2KgP4Ysk3Lo0/gaXKLESQRo=;
 b=h5pVtTk9kPqENEWZ1oXTLp6VYEj0P+0m4inrWChGEsAlbJuYsOMs0+Fpm0BE1pyOMWBpIs
 N9oF1L25VFgRPpI2XX4O0LD3o8ZPNd/1Ty01YZv/JZt/8WmvqusOkW3dylWKK4SCjjOgep
 WcnS2W4NmaEo2spE6zj5fwDisxK7jx8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-eG4zLAfTPoyWdmn_evKn-Q-1; Tue, 28 Oct 2025 13:34:49 -0400
X-MC-Unique: eG4zLAfTPoyWdmn_evKn-Q-1
X-Mimecast-MFC-AGG-ID: eG4zLAfTPoyWdmn_evKn-Q_1761672888
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4298da9effcso4126048f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 10:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761672887; x=1762277687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sw91OJuYj1JrwFfKm7ne2KgP4Ysk3Lo0/gaXKLESQRo=;
 b=mkr+wzZMUgwxVEpz8YBTlrJ3yH6qvUG3zCRWYoe3UKVbGnYEWc0z5edK8ufeP0ISqW
 1AIamvC7zlkiGLJjGI/+4EYbrZzm+KP1DlVC+93/CvZrzpWlfvsZcmT7s3A5oS7GRzrM
 isRJUmHPudRZAuWaalpFQIAsrBjr3laku0raCeB6cLIL9HTv2POgnNdNjp5Lhca8kK8L
 gM7q25V5gINdxbkqCLE/GbRHqZe3mk5MKTJE1xaa3mrqB1GsZ99P8sR8pSQfHIyQgSn1
 fwnHxree17ItfHMP0rqj79Y4JHN006gD4y9UDk48mY8jvNPIzBeI5rGB2hW+HjgFgQFr
 PJeQ==
X-Gm-Message-State: AOJu0YzUfVrYAGo5IWSogjVL+tU4eb4FM8Dx+l0cfB7eZvpGhlac78+i
 ++y2vNjQmafd3BJW9Dav7pB8CumjEPB7+np0l1D06VwYdogIsowSVHB+oagefiDKDGQfCCC2nAR
 Z3o0hmMDa85kPGykpGm4m7ENsAYD7q+5xMg773ug5TGddXj5WKXLhWZqhwsv3rrc3XNAX+L2Ii4
 b6XzKvXLOEh59ugYlDtcfyxSSrCPRC9I6Tdnp+lCaq
X-Gm-Gg: ASbGncsKDve1F40CE0hVYS7Otdb8K5idZfps/76Qz6yI0nfWNXZNwP70N0OUdSo+gpu
 us3TWnKSMHlTz5QvtPD6pQysIVFcWPtHzPVUPRmIsIV9Z0aXfH6zkopuK+oEjtybWOTEoxCulTR
 ADyZT/+q2L5Kmzvxcnh62wg3TP1uS4+QefECSKox9edFLNyyc+l05Gdhqu0Eo8ZlS4grjvCQRjg
 5RE/bO8d7aZtUh6Iv4kV0utMs9YWIOeaM9sPH5ar0AmBfjFVW56aBQlUIHpzT3WsoImNvDRg6vD
 F74hLmDLga6SQzQ/0W+bdI0P6N9y3M08Q6KOioubd2UnPAZivYGpIu7WuzRYtEnLktVrhCKdMxq
 pa6eecpItTuQ5NLB+r9fMLb44VVrhwPToZT+AqcDXHuI2mnIx9XxV9oF3pVtYwdYedanLopCsrV
 r5f0I=
X-Received: by 2002:a05:600c:64c7:b0:471:672:3486 with SMTP id
 5b1f17b1804b1-4771e18157dmr2954195e9.15.1761672887381; 
 Tue, 28 Oct 2025 10:34:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDcdKtLkNrl+YX/vvzTstmhdnZaPxZ2RDYdZwg98VYaaHXSh6uvh4cYUw1EM4hqFDEc3aiag==
X-Received: by 2002:a05:600c:64c7:b0:471:672:3486 with SMTP id
 5b1f17b1804b1-4771e18157dmr2953955e9.15.1761672886918; 
 Tue, 28 Oct 2025 10:34:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d5985sm21497448f8f.25.2025.10.28.10.34.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:34:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/18] rust: only leave leaf crates as workspace members
Date: Tue, 28 Oct 2025 18:34:17 +0100
Message-ID: <20251028173430.2180057-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028173430.2180057-1-pbonzini@redhat.com>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Everything else can be obtained as a dependency.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.toml | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 783e626802c..ace0baf9bd7 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -1,18 +1,8 @@
 [workspace]
 resolver = "2"
 members = [
-    "bits",
-    "bql",
-    "common",
-    "migration",
-    "qemu-macros",
-    "qom",
-    "system",
-    "hw/core",
     "hw/char/pl011",
     "hw/timer/hpet",
-    "trace",
-    "util",
     "tests",
 ]
 
-- 
2.51.1


