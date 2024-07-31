Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A479C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 11:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ7Lq-0005vk-Ty; Wed, 31 Jul 2024 07:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ7Lo-0005qU-Q8
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:18:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ7Lm-0006n0-Jd
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722424714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=18y0TLtURaACI8V2aaTdx66LDye0ViTKACpdUCycGOc=;
 b=MWZoVF8MdPGpmVoW8Wn9/uDMXVOF1K/IAjxEw6A7SHzWGRZhbHe9uwT18yBASJcExJpxpN
 IekJvWH0yPpN6A1cabhEvvJWpq2MuLq5CJhAbDSnek/lEOCFtqhQGpOIjH0kCsZyKFilsM
 bH8j1TofYkxQCv5SSIMgeUR8Sj2/8Mc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-mZP7SxbPNEe1Dib0YLDEdA-1; Wed, 31 Jul 2024 07:18:32 -0400
X-MC-Unique: mZP7SxbPNEe1Dib0YLDEdA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a7d2f42df2dso112414866b.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 04:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722424711; x=1723029511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=18y0TLtURaACI8V2aaTdx66LDye0ViTKACpdUCycGOc=;
 b=b5Jr5BQUvuKhIi22yqDengmRDEgJ/nc67LXhACCXOWyCfrVvReLOeIKBUn5teyG5aW
 D4Ubk4J1AKyLSImTyCTtgkWH4im8tvbcEqcMGUgtGY/rNFqHSQdl95c1wIlZuNbGQOQ3
 /n/nKBdsKza6elEzSWvPxEQyx9BzYL21C2ec5qqBSStZspBxp8soUnFYeKfVnuioo1at
 GQ+xSTS+83qFSNCjb2RsbF8FBanL8hoks74yPPuVH6eb0XMyiu4IcWkbxE4DxmzkOIPO
 phclIP1RuHMnDL4vrbgilJJc+ULeYCAtDkWdNgYQ5hf0d7881t7Y9X0coDrCRpbOoSo9
 a+gA==
X-Gm-Message-State: AOJu0Yx+WOXXAxKxZJiYZ2MXADuhJYPJ0hITYpoEvl61Eo2oeHi6nIRA
 Zv9dgIWcISc4QuFulqra8Al+dMBVvnkuou3PpvvvldM/akth/bejOKMpbDRHQX0NimcFanvwIRJ
 P2tCzSvnI8uCNYZf41NduKgiflXd9azS+vVtVgPt8UffrSs3q8Je2NGIk22DxralEuFIPfinqT0
 Gc/kiNkjpESXpbzBai5ZLJgurP8CtC8dWN0bTX
X-Received: by 2002:a17:906:ee88:b0:a72:7b17:5d68 with SMTP id
 a640c23a62f3a-a7d858bb113mr453611066b.3.1722424710969; 
 Wed, 31 Jul 2024 04:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFrpNWcr2QiySQj46ryyYBfW4GM0BDhjlW41oxX5veSGug3PpZi9xTYcCb6m1pC3vXggA/FA==
X-Received: by 2002:a17:906:ee88:b0:a72:7b17:5d68 with SMTP id
 a640c23a62f3a-a7d858bb113mr453609066b.3.1722424710518; 
 Wed, 31 Jul 2024 04:18:30 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acadb9a12sm753487266b.213.2024.07.31.04.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 04:18:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Anthony Harivel <aharivel@redhat.com>
Subject: [PULL 08/10] target/i386: Clean up error cases for
 vmsr_read_thread_stat()
Date: Wed, 31 Jul 2024 13:18:04 +0200
Message-ID: <20240731111806.167225-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731111806.167225-1-pbonzini@redhat.com>
References: <20240731111806.167225-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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

From: Anthony Harivel <aharivel@redhat.com>

Fix leaking memory of file handle in case of error
Erase unused "pid = -1"
Add clearer error_report

Should fix Coverity CID 1558557.

Signed-off-by: Anthony Harivel <aharivel@redhat.com>
Link: https://lore.kernel.org/r/20240726102632.1324432-3-aharivel@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/vmsr_energy.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/vmsr_energy.c b/target/i386/kvm/vmsr_energy.c
index a1d78f2f2ae..7e064c5aef3 100644
--- a/target/i386/kvm/vmsr_energy.c
+++ b/target/i386/kvm/vmsr_energy.c
@@ -270,7 +270,7 @@ void vmsr_read_thread_stat(pid_t pid,
 
     FILE *file = fopen(path, "r");
     if (file == NULL) {
-        pid = -1;
+        error_report("Error opening %s", path_name);
         return;
     }
 
@@ -279,7 +279,8 @@ void vmsr_read_thread_stat(pid_t pid,
         " %*u %*u %*u %*u %*u %*u %*u %*u %*u %*d %*u %*u %u",
            utime, stime, cpu_id) != 3)
     {
-        pid = -1;
+        fclose(file);
+        error_report("Error fscanf did not report the right amount of items");
         return;
     }
 
-- 
2.45.2


