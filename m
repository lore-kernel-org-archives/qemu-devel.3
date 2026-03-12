Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDEE105A584
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 11:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0drO-00040N-7O; Thu, 12 Mar 2026 07:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dqs-0003hg-8G
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dqp-0000QH-GO
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773313510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I0yiciT/sDQKhyXfng52EmYnhI3XMmJ/6/QTM5MiAGo=;
 b=LF76mfsQMRGFJ+p3anUTcTji7M5bHL42d1BATceV8BqikAi5/Wcr4uEu4aa7uQumvRbwQn
 We92yyArMnwCvrY26UN6Dkul7+fUvGgWRQ8x9z5guQ6Zm8KnVsPAyLSlEnFyGKDG3yc2aC
 qnNdfIMkNj3wfENh2IiQIggF4KCbdMY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-3UsUo4hoOZG5uBv3gGi6IQ-1; Thu, 12 Mar 2026 07:05:09 -0400
X-MC-Unique: 3UsUo4hoOZG5uBv3gGi6IQ-1
X-Mimecast-MFC-AGG-ID: 3UsUo4hoOZG5uBv3gGi6IQ_1773313508
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439b50dfca1so616728f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 04:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773313508; x=1773918308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0yiciT/sDQKhyXfng52EmYnhI3XMmJ/6/QTM5MiAGo=;
 b=Jt2GYSShH7ZvGKitKeKgTmela0B+Jd6zDwWV3ag8GTb0wBV4Z7Eg5W6M6tbh47wkdT
 Mpb9dmHMxjNZIG3n9Bb+iljbO2PDlAO5xyYh5C0PmUDp7zRZVZJ0OVgVuoWVcPzqVtde
 zW9FE3+s8OOWGAPuCbAp1b67V1X4vuuHCoetdmOxiHvcFSM8c9qP6eVDvoU9r3HNuelP
 qVqQN6d9onM3z8jFYOTIuXLPIsNXfgYB4e3XeMB0dkq7464ooQJdf66lp0xTB7HkyDZd
 v+IqLWQxT0+RxBK1g4K0XHL34TSKt31pWQn31ld8tk1Xdk4FuKzNcPnhhaRL6BMlIufo
 ajAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773313508; x=1773918308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I0yiciT/sDQKhyXfng52EmYnhI3XMmJ/6/QTM5MiAGo=;
 b=wN9+5YZi3PeUuDfJcipAljjk5uvK/CuYakDKshciZUTvqYfThq53tgBBBjzuZKDSQD
 SCwHVbv8rvab9oeppnECXebDYhd2vsm5MW93GOZUEbsx3jXsn8XolCpkP1kEjyTh2gQy
 gc/82I8+Pg3nEj0ytoPRyUn3eitd6zbW67/bBMMnk/jyOABNrbOiQZ3k7Hwrw3A5fZ5f
 VWGiq6I6VYL4mprWxfx7elYsCFXkUiwIXlUeMkv17iYLCU4O8ceQk+hsozHyDXTw7+GD
 O1vnDUrI1FloWEjthQTU92kc+psdMtWxEsC4oPn/bqtQ7OtiyO3PtWo/yJI+UzCtXlxj
 JWuA==
X-Gm-Message-State: AOJu0Yy2SPIh6TgenRo4+Nx+2P+ZxZaxXZ4g8TAcQd6Tgcg8RYBt1q1H
 NDBupti2myWk16OcpjTGP9/NYxm5knJ+bFfQ8RLvXQBh899G+Rnr+vstQvCIruz4vDmGS4jesME
 /diOEX3TdK0Y8Ypc0kybGKdPGvPqUr/tSJhWPqoq8iq5BtodlavyfZpAKQ7xUXnRhqdRuUHt79e
 2IHxD6fBqnA/wSh61zoPCTrUXJD6NrPn360dnPyn8w
X-Gm-Gg: ATEYQzzwr9lZi2w0Z89sQIJcif5NbDkqulywED83Fyr91/VOlckk0qM6PN5s+znvFQp
 OksQnBSiQuQsyR99w4c81H4uVs7tRTN/dAngew7v2ZPeXIhnye2f4m6DKLPeynZ6DNMrmWnYgEt
 YAziTwfWNn+gxscb4LInPGXVKG4WxjQXrbmq/t6rUzztwyFvEWvIkdBGwUj+jaqvh7qzHqSM6Bl
 9zfgrsk/hHPt/wH9CGXoOpWc1zVGFjY/XHEcYTFI+qzhM9AWi9Cx8fFO/Vck7F8Irg9Uwtdb9Sn
 O6YcAVj7oGe9eLSonX6bMyQL8IEYuzBqR7N2qphPfRwIIac0IRsm+lmQM6EYbrtcfG7xnQoJe7r
 SpobTfoKg3fLGODho99RqGCDXqXi85xwVmL94lq7/GISf6OU7pu2GH0vir0NTf5OrqgnUfT/igw
 8NY1eYU2IbB5xDIwzpZ08ZZ9L/xx4=
X-Received: by 2002:a05:600c:1f10:b0:483:8062:b2f with SMTP id
 5b1f17b1804b1-4854b0ae55amr109186295e9.6.1773313507730; 
 Thu, 12 Mar 2026 04:05:07 -0700 (PDT)
X-Received: by 2002:a05:600c:1f10:b0:483:8062:b2f with SMTP id
 5b1f17b1804b1-4854b0ae55amr109185465e9.6.1773313507181; 
 Thu, 12 Mar 2026 04:05:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b0c2961sm38693885e9.15.2026.03.12.04.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 04:05:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 05/14] i386/cpu: Adjust the note for CPU models with its-no
Date: Thu, 12 Mar 2026 12:04:37 +0100
Message-ID: <20260312110451.685161-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312110451.685161-1-pbonzini@redhat.com>
References: <20260312110451.685161-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

For new versioned CPU models with its-no enabled, since CET was already
enabled in previous versions, remove the related description from the
notes of its-no related CPU models.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260310140819.1563084-5-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 05121c5b324..cd44a624201 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5263,7 +5263,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 6,
-                .note = "with cet-ss, cet-ibt, its-no",
+                .note = "with its-no",
                 .props = (PropValue[]) {
                     { "its-no", "on" },
                     { /* end of list */ },
@@ -5444,7 +5444,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 5,
-                .note = "with cet-ss, cet-ibt, its-no",
+                .note = "with its-no",
                 .props = (PropValue[]) {
                     { "its-no", "on" },
                     { /* end of list */ },
@@ -5809,7 +5809,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 5,
-                .note = "with ITS_NO",
+                .note = "with its-no",
                 .props = (PropValue[]) {
                     { "its-no", "on" },
                     { /* end of list */ },
@@ -5963,7 +5963,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 3,
-                .note = "with cet-ss, cet-ibt, ITS_NO",
+                .note = "with its-no",
                 .props = (PropValue[]) {
                     { "its-no", "on" },
                     { /* end of list */ },
-- 
2.53.0


