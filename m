Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A20C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 14:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMqVu-0007uA-7f; Thu, 27 Jun 2024 10:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMqVr-0007th-TJ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMqVq-0007I3-1F
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719500053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wOVf84lwfgLrYogRC0LnY4gOavX8fM5mQLjh40mAI/o=;
 b=cDZcIwHH92svQWBFLxnW+WCmfaBkNbuHW+vE5xYICkkE38wlHFTeKJGc5PGM0gYZxcAhvx
 2QCArDaankLxaF3JmihOcy1cULYuP91bgdh5D6opkrvPC2yo3U/fu3jGJrsj14RqPmV/r0
 lfv39UfpjIOwL5sS0EeF2925R1ej984=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-qP0CTMArOnC_51Qfr6kl_A-1; Thu, 27 Jun 2024 10:54:10 -0400
X-MC-Unique: qP0CTMArOnC_51Qfr6kl_A-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52ce42bb0efso4174390e87.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 07:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719500048; x=1720104848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wOVf84lwfgLrYogRC0LnY4gOavX8fM5mQLjh40mAI/o=;
 b=spGUj+KNxDH9y5UCO6uWj1+ku32qobxGHbWjGZELfKqt9JNzMIrQUjBcgK57dm3MnF
 /cqKrWgx67P7PbLUxR2XMI3O3X9UgHD+HiEpBREhsZiwYlwEjhsrJXxBm0AXCG9sAal/
 QxwUXw2unq/hVGJZVNuL0e7l33MxabtgXjf8bEkkXmpTqkuVGrcsEeqeIdbLto/5p9q5
 aNkN3XJpIOFCyUIGUULPzzRQFeXrOYVNUe7QDMmzlImEiKDpg096lvtpa7AKEDZiS/A7
 n8ySnfN7ReurDUdouO3AtVrkaKOOQF3ssJRdNxEr4+oeGKrdJCI1lSS6/hC7CZEoAqj6
 BPMQ==
X-Gm-Message-State: AOJu0YxVBVzMS9ZU6Jt2pP737VIixUIhH9vJbH6klv66xaniPtTm4eBs
 cFALe1nrREgbzmcdsFQR5TSjkSPnaQM7HaZt1y/HdUIgWy6QSaEeelv0lNk1P2fha/vPAnGB3cJ
 auwuk7RyBdlc/iJkb8TsqqYf+oSaa75xtjARkmhmNNEZnQOidD2fL0DyDmFkBO2JjdtlbLjbELQ
 XUCoOOmFKPaTXErduUKWkoOV+0ArL/MjCGQsx/
X-Received: by 2002:a19:641c:0:b0:52c:dca7:c9bd with SMTP id
 2adb3069b0e04-52ce064e3e3mr9346250e87.30.1719500048758; 
 Thu, 27 Jun 2024 07:54:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu+quy5kOlRS3maCOD9ORsX83Tg3m+qBYsrmJnWvy1RC6X55dBngXKbu8/BMCN2vnmpOmvgw==
X-Received: by 2002:a19:641c:0:b0:52c:dca7:c9bd with SMTP id
 2adb3069b0e04-52ce064e3e3mr9346235e87.30.1719500048277; 
 Thu, 27 Jun 2024 07:54:08 -0700 (PDT)
Received: from avogadro.local ([151.48.235.205])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a729d6fdc8esm66440566b.22.2024.06.27.07.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 07:54:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	alex.bennee@linaro.org
Subject: [PATCH 3/5] target/i386: SEV: rename sev_snp_guest->id_auth
Date: Thu, 27 Jun 2024 16:53:55 +0200
Message-ID: <20240627145357.1038664-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627145357.1038664-1-pbonzini@redhat.com>
References: <20240627145357.1038664-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
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

Free the "id_auth" name for the binary version of the data.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 2d4cfd41e83..a6b063b762c 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -154,7 +154,7 @@ struct SevSnpGuestState {
     char *guest_visible_workarounds;
     char *id_block_base64;
     uint8_t *id_block;
-    char *id_auth;
+    char *id_auth_base64;
     char *host_data;
 
     struct kvm_sev_snp_launch_start kvm_start_conf;
@@ -1297,7 +1297,7 @@ sev_snp_launch_finish(SevCommonState *sev_common)
         }
     }
 
-    trace_kvm_sev_snp_launch_finish(sev_snp->id_block_base64, sev_snp->id_auth,
+    trace_kvm_sev_snp_launch_finish(sev_snp->id_block_base64, sev_snp->id_auth_base64,
                                     sev_snp->host_data);
     ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_SNP_LAUNCH_FINISH,
                     finish, &error);
@@ -2198,7 +2198,7 @@ sev_snp_guest_get_id_auth(Object *obj, Error **errp)
 {
     SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
 
-    return g_strdup(sev_snp_guest->id_auth);
+    return g_strdup(sev_snp_guest->id_auth_base64);
 }
 
 static void
@@ -2208,14 +2208,14 @@ sev_snp_guest_set_id_auth(Object *obj, const char *value, Error **errp)
     struct kvm_sev_snp_launch_finish *finish = &sev_snp_guest->kvm_finish_conf;
     gsize len;
 
-    g_free(sev_snp_guest->id_auth);
+    g_free(sev_snp_guest->id_auth_base64);
     g_free((guchar *)finish->id_auth_uaddr);
 
     /* store the base64 str so we don't need to re-encode in getter */
-    sev_snp_guest->id_auth = g_strdup(value);
+    sev_snp_guest->id_auth_base64 = g_strdup(value);
 
     finish->id_auth_uaddr =
-        (uint64_t)qbase64_decode(sev_snp_guest->id_auth, -1, &len, errp);
+        (uint64_t)qbase64_decode(sev_snp_guest->id_auth_base64, -1, &len, errp);
 
     if (!finish->id_auth_uaddr) {
         return;
-- 
2.45.2


