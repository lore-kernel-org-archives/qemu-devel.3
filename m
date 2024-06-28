Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC32EC30658
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFQ2-0005xp-At; Fri, 28 Jun 2024 13:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPz-0005pe-VL
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPy-0002GE-Df
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719595789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9uRfBk4pyxsS7EnJAcVfZWqmtL5OlKp+t3MsBw573tc=;
 b=KSnXdcqHmwu5zsv5Z7ZJpPhZPxtopyiS928MkMO/9oBGP3jmWB7b65bFGasEffWF5n18OW
 TOyDN9/h+LSmhO5A9rTbFzR2b9IdqZs2w4xAMQnB5TZCj7qRp8APVwbL9vGJXwacpG4e4v
 5t6sRcdK7FfGAiI2fwHofP3MyUi6K4M=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-rIxJEdwxNXGf1MerpejczA-1; Fri, 28 Jun 2024 13:29:48 -0400
X-MC-Unique: rIxJEdwxNXGf1MerpejczA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57d3672cf40so578706a12.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595787; x=1720200587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9uRfBk4pyxsS7EnJAcVfZWqmtL5OlKp+t3MsBw573tc=;
 b=Eul2yrDI7+COld1ODb/qItwLs3PEAveffJVJwZ+WnyACHu96w7fupWNAtqt4BxWEJw
 K/AKPIxafaPzAhGY3BOg8UB0Ml4R3RWrHMtzzYXpCcjq2K3rhGSCLaXqm2HW9tGdALt/
 Xk0fwSoXpmclyJnry/A+ZR4gUq3qa9Im+qmmDod1YC5nT4d25aD+jZORPluKKjnoZKwI
 s30pm/5IR4dQ/XYB9TCLAJu8tbH4OifdanwSka8DGASZ9K3vFGZ5K8c0EPQVobNL6oxy
 S2Wfx6G7lIJ8YNCoRDVJUjzVmoaE5WDLFmRZyW/b0g/rzgbNOJtDb7kC9kAezA7acYFp
 g8HQ==
X-Gm-Message-State: AOJu0YxjE9bdGU+h3MNM2a4D94gfu3v1XNUFevQW2JbVzC1g1mFTSasL
 wb8rzKwSa9iPy3FcLxm14qD/8HbIC3nZqxSOMNp+apf7eVdR1Y2E4lKSXjbmI2v3axIdrvpMxH7
 z0JcbP2JJJkHRzTf1uRIZV/n87H1TsMzmmbBQTQOIxmxgC8EIQBp24nZ5yy25ZYz/XKllDkoYkm
 IOQXUTtYOOSW1viWhMHnxYyslLi1unk4QpQa1q
X-Received: by 2002:a50:aa95:0:b0:57d:261d:f825 with SMTP id
 4fb4d7f45d1cf-57d4bd810eamr11807539a12.21.1719595786828; 
 Fri, 28 Jun 2024 10:29:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU+pO4WRf9yg1zMKBCF6oQKVJZCoHK2oAWSK/fdJutSGwTayxVEMLrUzc+zZYTNtdeu3u/Cw==
X-Received: by 2002:a50:aa95:0:b0:57d:261d:f825 with SMTP id
 4fb4d7f45d1cf-57d4bd810eamr11807530a12.21.1719595786427; 
 Fri, 28 Jun 2024 10:29:46 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5861324f069sm1305473a12.33.2024.06.28.10.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:29:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 21/23] target/i386: SEV: store pointer to decoded id_auth in
 SevSnpGuest
Date: Fri, 28 Jun 2024 19:28:53 +0200
Message-ID: <20240628172855.1147598-22-pbonzini@redhat.com>
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

Do not rely on finish->id_auth_uaddr, so that there are no casts from
pointer to uint64_t.  They break on 32-bit hosts.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index a6b063b762c..28d6bd3adfa 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -155,6 +155,7 @@ struct SevSnpGuestState {
     char *id_block_base64;
     uint8_t *id_block;
     char *id_auth_base64;
+    uint8_t *id_auth;
     char *host_data;
 
     struct kvm_sev_snp_launch_start kvm_start_conf;
@@ -2208,16 +2209,16 @@ sev_snp_guest_set_id_auth(Object *obj, const char *value, Error **errp)
     struct kvm_sev_snp_launch_finish *finish = &sev_snp_guest->kvm_finish_conf;
     gsize len;
 
+    finish->id_auth_uaddr = 0;
+    g_free(sev_snp_guest->id_auth);
     g_free(sev_snp_guest->id_auth_base64);
-    g_free((guchar *)finish->id_auth_uaddr);
 
     /* store the base64 str so we don't need to re-encode in getter */
     sev_snp_guest->id_auth_base64 = g_strdup(value);
+    sev_snp_guest->id_auth =
+        qbase64_decode(sev_snp_guest->id_auth_base64, -1, &len, errp);
 
-    finish->id_auth_uaddr =
-        (uint64_t)qbase64_decode(sev_snp_guest->id_auth_base64, -1, &len, errp);
-
-    if (!finish->id_auth_uaddr) {
+    if (!sev_snp_guest->id_auth) {
         return;
     }
 
@@ -2226,6 +2227,8 @@ sev_snp_guest_set_id_auth(Object *obj, const char *value, Error **errp)
                    len, KVM_SEV_SNP_ID_AUTH_SIZE);
         return;
     }
+
+    finish->id_auth_uaddr = (uintptr_t)sev_snp_guest->id_auth;
 }
 
 static bool
-- 
2.45.2


