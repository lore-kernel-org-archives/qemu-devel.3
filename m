Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54597CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 08:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up0z2-00012k-Jv; Thu, 21 Aug 2025 04:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0xa-0006FV-WD
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:47:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0xT-0001X1-MF
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755766059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5MpTvm5RaxQiDa+wZwc621Kz6WxGcmOvInmt1mQAj3Q=;
 b=UGWr1UyR5FTfCP8dwMdV9FFf6Ihh5hzqlcR9zFoic1SiXeOXECNjYDZk5yvw5bMgd8v3Cq
 8rHTqzu/76kGKF4zvU+oNakDTkzCqip9uJfRDXQ24Dy9xBJ0E5YftLhLq/C7Gn0D5gmu4/
 jpnnptjaPTrbCHX/Mw54dB1O8atD4r4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-5hmHKuBzP1i2SIwzAWXaPw-1; Thu, 21 Aug 2025 04:47:36 -0400
X-MC-Unique: 5hmHKuBzP1i2SIwzAWXaPw-1
X-Mimecast-MFC-AGG-ID: 5hmHKuBzP1i2SIwzAWXaPw_1755766055
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2445820337cso8882185ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 01:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755766055; x=1756370855;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5MpTvm5RaxQiDa+wZwc621Kz6WxGcmOvInmt1mQAj3Q=;
 b=w6YAGd73HNf7xqre2ExvNT4qFtP4E16UPQefWbZfHZVS3FKp8TTkINCyEaI9fluBSK
 JZ1l1CUgFjk3iei+dzTlYPFjOWovNYfXw+/YglCaazJgdB4AnLTrkjdN0zEFI2+y4fhE
 w/ucp2FoZo8SN8QNOWaks5v4b2z5sYaf3rhebWCNIXOoZO4udRVvpAWNgxhxJeEv9n0J
 hRNQApoDDReiGREyZSAKQGjAIEqsUwCaBdbeeJCIsMGb/2Tzo8VjS/n/YbDN9ugLXa8e
 PJJLEbbI4uXFyxGIfbvHGS7abx5aoPd9VlNpfxvbaIawERhoIY5bz+qG+s6pSzFIDRRz
 KH0A==
X-Gm-Message-State: AOJu0Yyto6Jidnwz4RQ9hM0NGuphwpQRB/DMz0zda+cxwGsg2HGTcI21
 dx6jnxLlwnYkaPaM8NOE/NV/4OeCsB5RklJQpMwmP+VxVHAOuxCwMMruQiTYQt6f5raZSd25Fxv
 QchDWNi5DHyvDuGpvGYQNMXbsDKkWtP/0a+Wbv/AgZq0yUXPFiu9pwt7X
X-Gm-Gg: ASbGncvjqHr3jsIN3OIQu5DTJsWYhR5xD05AT8ZgiBBaFUe+JwKZwhpW0duwlWFi8R+
 v/KoIs2xECiwIjAcA3tVQT++kCjKtMxcbTMXbPwjmknKz121ZBuXef+2U936KLrWDZpXeOd1R5L
 bsb3KeBCjh+aTwIi9RkEKhEpnnWnp15RmeJyQNG9UxI1/LjC0hoyKciktegZtVD12UqzeWNNcLE
 bDThqiDGSUyi5YtlzV/vNonxCHiY33c4eOP7ZKGe46CYv/S5qyO1iubljO7+Q8MIsewH/u6EKue
 nUXBl3a+g79zzzhmv8Apze9zlLIwTUCVbELg5QxCMe+0KKX12FsP
X-Received: by 2002:a17:903:b0e:b0:240:3915:99d8 with SMTP id
 d9443c01a7336-245fedbbe74mr21816115ad.47.1755766055020; 
 Thu, 21 Aug 2025 01:47:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFzLg2q3w9TIYnk14mg+E8Rf4gKj87xJ8vIu2+1v+kppUc/I3qDWR7oWP5K8yq0h9LgDrk3A==
X-Received: by 2002:a17:903:b0e:b0:240:3915:99d8 with SMTP id
 d9443c01a7336-245fedbbe74mr21815895ad.47.1755766054639; 
 Thu, 21 Aug 2025 01:47:34 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33e05dsm48789985ad.3.2025.08.21.01.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 01:47:34 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 21 Aug 2025 14:14:11 +0530
Subject: [PATCH v12 17/27] migration: push Error **errp into
 loadvm_postcopy_handle_run()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-propagate_tpm_error-v12-17-72b803e707dc@redhat.com>
References: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
In-Reply-To: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
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
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888; i=armenon@redhat.com;
 h=from:subject:message-id; bh=ANnJVFbZEDL4HCdNfafMLBvHi/TIEmuU6PMel/6BCzc=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8ayOyln0vrUG88+Dz+/vPRioNNEA868G5nVYqf1b95we
 3+ByWluRykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgIk8kWD471a2Y2q1UfAiNwOu
 t1aZ5/6458811C5Pk4opEav/v299K8M/hb1cvFu1L84V97qwdPpmH4EJX/f/tmt/4NTY5PzF6+d
 lfgA=
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
It is ensured that loadvm_postcopy_handle_run() must report an error
in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 6408257ef2148bdc4b753500194eaea8384cd120..348ea9d7e57927c57131e8e747b446c232a9cdf3 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2273,13 +2273,13 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 }
 
 /* After all discards we can start running and asking for pages */
-static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
+static int loadvm_postcopy_handle_run(MigrationIncomingState *mis, Error **errp)
 {
     PostcopyState ps = postcopy_state_get();
 
     trace_loadvm_postcopy_handle_run();
     if (ps != POSTCOPY_INCOMING_LISTENING) {
-        error_report("CMD_POSTCOPY_RUN in wrong postcopy state (%d)", ps);
+        error_setg(errp, "CMD_POSTCOPY_RUN in wrong postcopy state (%d)", ps);
         return -1;
     }
 
@@ -2626,11 +2626,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_postcopy_handle_listen(mis, errp);
 
     case MIG_CMD_POSTCOPY_RUN:
-        ret = loadvm_postcopy_handle_run(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_postcopy_handle_run(mis, errp);
 
     case MIG_CMD_POSTCOPY_RAM_DISCARD:
         ret = loadvm_postcopy_ram_handle_discard(mis, len);

-- 
2.50.1


