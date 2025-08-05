Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04D1C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 18:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMP5-0006KW-0t; Tue, 05 Aug 2025 14:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMP2-00066Q-GO
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMP1-00041q-1N
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754418526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3a4je7M4qEt7TPhu1/w+QQTrMd6+jDtLlHk+zIgplyA=;
 b=ObqilyvIslhqP0+vlm9qaJzE/YHUcBm3CqWfsEp/tgDaL4q2bssP/908HGsCGYOdL8QQB4
 75uKHxQEZ96eNjme6QBd8SR+Rr7Xq/9ahN7DfMpKo5a/Tyj9gRF33soNuMnc7qAU7G96JR
 5+pKQA94f0m074qBONEExp3/lR6GWEY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-FhZeMhBmNp6RwJVgsM1zIA-1; Tue, 05 Aug 2025 14:28:44 -0400
X-MC-Unique: FhZeMhBmNp6RwJVgsM1zIA-1
X-Mimecast-MFC-AGG-ID: FhZeMhBmNp6RwJVgsM1zIA_1754418524
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-240b9c0bddcso52300415ad.2
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 11:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754418524; x=1755023324;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3a4je7M4qEt7TPhu1/w+QQTrMd6+jDtLlHk+zIgplyA=;
 b=MIamvzJlDvrvGE37WtUmjwxPAX0BCdxp20pgH7pOAI1+NiWoQg7gPVy1449zrqmDSM
 Npfs7Nw0LwtXfaxFWsi9t4mnqe8NGpY4WgOMDQs+HjLbsPGijXsSKZDdNxlEM9nK6i/p
 uUaiBdBLH8cioLuxvnJvK4G/2IcnD7RzVs/qug+a9ZMZfUXHlk8dyBWSxTHSb75rli9w
 iIHFl8B2dHoqJ5HIvdUi+EIkAkyLePAja4llTNDhZtwRxoeB1WQD4WZDLlUjUwsa9CDZ
 UUJHL9OBgkb/EJZIpG6Y4fMFDPucToNbwQYNOSkbPXdLcm7CtaUHD6AOsEmr4q++uR0m
 eztQ==
X-Gm-Message-State: AOJu0YzDZ2F1EwV0Zrj+ii3074wiNGcOFTp4Ji/XZTaL/vqEprfQmJSL
 D3cjmVS6lOANmmROn9QFFZKoTHG1LxPRQOnzEcVVQiF5NNMd0eN6WQG33WCs+KTVkvDJcHyzIin
 fSYC08vOL+KuYx/pgvwf2T1MkyYl3A7yshTFlkvK9h1n4PPHbJsgcR/yA
X-Gm-Gg: ASbGncvr6tvcCzzOXAZ6+RA4B4f1M3f/GwM3twfec4rLtEDE4y7fDDZw7fCasTbuLQB
 TKWYtkmXz+Y05Eq9NlDRDNmHsjFrFu1BejJNTGZw/Tp+lanWL7C0Lj95YlGumM33gczENNhJRuJ
 teRVCOWERGobcZLpxrNk5Qe4uRA9vW86nsM6//1yG7kCEJb88/fLQvB1pXE0EfaFk1veO1cJsOI
 TtIBCR2pU4tQ/CcA90j9QC7loFl5L7KhKWPiNgXZLwFwucmiyKHJNYstwy0hpy6XIduR41D1c5i
 aCC7SShG5VHu5zaHD3HD66kVCvg0jM0ZzBX9dJuJAG4b4Z1Erg==
X-Received: by 2002:a17:902:f54a:b0:240:7725:18de with SMTP id
 d9443c01a7336-2429f6085e3mr664405ad.37.1754418523702; 
 Tue, 05 Aug 2025 11:28:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5D6NX+HV+6XEg6uuxBGyyKrb4ogJUP7u6elOkHOHa+bcKDFnKNNRpcfqzJerQSKkglJadUA==
X-Received: by 2002:a17:902:f54a:b0:240:7725:18de with SMTP id
 d9443c01a7336-2429f6085e3mr663935ad.37.1754418523286; 
 Tue, 05 Aug 2025 11:28:43 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e585sm139200115ad.40.2025.08.05.11.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 11:28:43 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 05 Aug 2025 23:55:13 +0530
Subject: [PATCH v9 06/27] migration: push Error **errp into
 loadvm_handle_cmd_packaged()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-propagate_tpm_error-v9-6-123450810db7@redhat.com>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2723; i=armenon@redhat.com;
 h=from:subject:message-id; bh=AphLiNO4zRgUUjm2dBoJUuEdQVh4MjWuQLXLYWtdpBE=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YkX+mP/XPXa8Se+cT+aN75A7+mhst6fNQQZspr9rL4z
 T69OKa8o5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwERMdjP8d3kYsWBHQKnSbeGX
 rZONX8+QXPvsnJug7TvePrEJS7f/n8/wP2+p2I+CaXJKBRu/aoa+7WBSzoxbKyOiu3GL9pl775M
 j2AA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that loadvm_handle_cmd_packaged() must report an error
in errp, in case of failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index cb673f43b174249ff1525dba41284de2e5a70735..1bd27efe437d4d911728d776e995490d0a45dcf5 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2405,7 +2405,7 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
  * Returns: Negative values on error
  *
  */
-static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
+static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
 {
     int ret;
     size_t length;
@@ -2415,7 +2415,7 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
     trace_loadvm_handle_cmd_packaged(length);
 
     if (length > MAX_VM_CMD_PACKAGED_SIZE) {
-        error_report("Unreasonably large packaged state: %zu", length);
+        error_setg(errp, "Unreasonably large packaged state: %zu", length);
         return -1;
     }
 
@@ -2426,8 +2426,8 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
                           length);
     if (ret != length) {
         object_unref(OBJECT(bioc));
-        error_report("CMD_PACKAGED: Buffer receive fail ret=%d length=%zu",
-                     ret, length);
+        error_setg(errp, "CMD_PACKAGED: Buffer receive fail ret=%d length=%zu",
+                   ret, length);
         return (ret < 0) ? ret : -EAGAIN;
     }
     bioc->usage += length;
@@ -2457,6 +2457,9 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
     } while (1);
 
     ret = qemu_loadvm_state_main(packf, mis);
+    if (ret < 0) {
+        error_setg(errp, "VM state load failed: %d", ret);
+    }
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
     object_unref(OBJECT(bioc));
@@ -2616,11 +2619,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         break;
 
     case MIG_CMD_PACKAGED:
-        ret = loadvm_handle_cmd_packaged(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_handle_cmd_packaged(mis, errp);
 
     case MIG_CMD_POSTCOPY_ADVISE:
         ret = loadvm_postcopy_handle_advise(mis, len);

-- 
2.50.1


