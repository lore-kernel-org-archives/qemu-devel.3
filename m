Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D2FCAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Rt1-0006dx-AO; Tue, 30 Sep 2025 00:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3Rs4-0005ic-C8
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:21:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3Rrr-00034z-2j
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759206090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIIkEdhnleE/ncO4jCGDN+8xNFRhF6XCVj4kpuj7vMY=;
 b=XqC3on1RRb1SnZBulIsxz8q/+QNnFAveFsSSu7R97taA6YJn6Im1vmSMRpucGeBS5uzVro
 h2MZsAsEUGcTXn4B+xWXfuTGK7gE5CtkCksrN8FJWI2aREKWYTBiJdIqyzQSPV/yyp4BPW
 3U4e4botu10NMl7Evpvbf2P1VXeI19E=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-yILN29KSM2GvcPsD84RaXg-1; Tue, 30 Sep 2025 00:21:22 -0400
X-MC-Unique: yILN29KSM2GvcPsD84RaXg-1
X-Mimecast-MFC-AGG-ID: yILN29KSM2GvcPsD84RaXg_1759206081
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b4f93fe3831so7415522a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759206081; x=1759810881;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XIIkEdhnleE/ncO4jCGDN+8xNFRhF6XCVj4kpuj7vMY=;
 b=wUhydFO5z7/DARddQchdKry90ah/JKU7is6kfEKYrkprWCx46KlWOWP/P/kcFmHGjx
 mwrW2G4IB6E7AuJhjA7PwCAhhhOUCGc7mO9lInzR4I8bsczbeYzHuI6nWJxg5RDK8j/I
 XD0jaetrhPU+pmoDh8oKT6o/M1LyR7czbNrHax6aC67ex7giMl/CT0jIpXdncceVi90q
 +/vP3JhaUG2k1JOA8/WEf/mFtS/XZNEoyCTquR7oyVWHVFgj/wfsgjF3kqcL+oIZnzyU
 sT6R/KMgOThtcx7Do93TE6nJ+rDe0tYyI7wt+qDfCUCxEhP9InvkqaZLNpZo7QUFVg+7
 TIAw==
X-Gm-Message-State: AOJu0YwZTF55wvk66A0/qd1CUJtBHgp3AQmqOl2RPEvMky+2D/2hGPNO
 QwRQq4eqgrf6pG1QTd3k0r59IRbsH8PWiC9VX6+YgbnhzD30rB6s4DmTBOaiXxLjzjx9YtuAmZy
 EijPfUP0VN/KXVkGTDd94bLQcQXHm8ytl4HJzPzxmJOBhx7mbVZJXiJzB
X-Gm-Gg: ASbGncuzPe2IukrkphvhbG8AdOR0lGmR8lUeTkt6lmgKpDCbmaCe7Hmnai9KcidP8Yu
 51psUTB/HlkPaIxJAVy/UlxFEq7IdITPEup3zTj/ePSIhypywk8Et0mmzQRPC3hT2dSeTUCaW7D
 +hUTaLoBq1IpGz+UtQSPDnmk+Udg/PDnJE+bTKyD/0uc01Y+NOkHyef3Lwc6CAXRGYbusinEnN0
 vCcSj9wngckbV07Liraim5gpghKir6OPrBGS1PQYtcSnRXASE3PT3vew4VfqNWHm8NLijOMVk6N
 46EDwU5+6Zcq/RjcKDnqUMT24gIGGV4Xa0ye7Io3fCwABV4xls2Qce2Now==
X-Received: by 2002:a05:6a21:6d88:b0:262:8422:5774 with SMTP id
 adf61e73a8af0-2e7d10991e9mr24956151637.39.1759206081159; 
 Mon, 29 Sep 2025 21:21:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEvcgEQsoPBNC/Buh9OnGMsE/naVAMknGhFi74qzEUTxwc9CRuZOnT5WUlmvQ1T9q/ADlFAg==
X-Received: by 2002:a05:6a21:6d88:b0:262:8422:5774 with SMTP id
 adf61e73a8af0-2e7d10991e9mr24956121637.39.1759206080800; 
 Mon, 29 Sep 2025 21:21:20 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c55a339dsm12534158a12.40.2025.09.29.21.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 21:21:20 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 30 Sep 2025 09:48:26 +0530
Subject: [PATCH v15 17/26] migration: push Error **errp into
 loadvm_postcopy_handle_run()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-propagate_tpm_error-v15-17-84afd3af1e47@redhat.com>
References: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
In-Reply-To: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1991; i=armenon@redhat.com;
 h=from:subject:message-id; bh=gmtVzum7WhZI6TobCuUuyorZinEIl/+8OMg03Aypz7E=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8btKMGv19Lyo/ulv01pu9Ondn7eR/VfD2snmL65H3Bk+
 u1Z3cyrO0pZGMS4GGTFFFkavgbINgUURkTavrwOM4eVCWQIAxenAExk1TqGf+qLZrXcbFkzV6fD
 h/380+tF22N+BDzVO+Onfv3K37DO8GkMfwXO7uNlaeW8ql8+rfUqh67+DSN3ng0NCbzbRR+eNTT
 8xwQA
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
It is ensured that loadvm_postcopy_handle_run() must report an error
in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index ce88f56498cf88a30de4f0d50c2b5068e4e3939b..f7947160fd5af351a09c0ae75879e80710df4c7e 100644
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
2.51.0


