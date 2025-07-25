Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC40C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHRU-0002dz-OK; Fri, 25 Jul 2025 08:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHQq-0000wc-Vz
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:21:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHQn-0000Ym-FF
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753446103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FCpDb94X0hjrktrzX/OdLdryyHZXUa/eMr0qkKPb7Q0=;
 b=YGMdIzKnmKMsyXY7Oig95LfJFGDn3XQiqhn83f+7rHzkWa3qNUlZUtfdhktiKJm0Fynuw/
 C/brpZEPYg2XNP0f4dYyduMutsGjFGr0fytco0To24aEfcEd71ECa8a3FI+1pW/MXxWwyr
 yxLMiSoa7k3/S3iHs+MjyLNiVRY+XtU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-iCaj2miVMPO-IFL1_Ymozg-1; Fri, 25 Jul 2025 08:21:42 -0400
X-MC-Unique: iCaj2miVMPO-IFL1_Ymozg-1
X-Mimecast-MFC-AGG-ID: iCaj2miVMPO-IFL1_Ymozg_1753446101
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-31215090074so3286827a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753446101; x=1754050901;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FCpDb94X0hjrktrzX/OdLdryyHZXUa/eMr0qkKPb7Q0=;
 b=BmcTJNTrk3jzRiEslWxSdcvtRjP64bXMW70y1orqhdyVk5fRIUONgqVvaUu/L3hRx7
 Fw3dcN5N7RT8l+4XsGThEvwmttc00qQTC5oWRnhZCDDa9q3v5/v95mrtzR0qv1ZqdSgQ
 tpLzjbTVISjQkXh8OHGxZKakFav+MwspOHoC2vhxN+q6JcJ5fvhLTUi0xdDeD2efPN89
 VjufDC2/NkfwkAUuohbUOI898MKMOiyGn2VgnCFmN2RF+MucbxOR/GgNaNIu5e/thIfh
 ynp08mxxlIB7PwbXxFKXXTeSVLcZd11O87q2MnfaG/qmoSBDm6FryOqxEg4AsF8+Pmq6
 WhHw==
X-Gm-Message-State: AOJu0YzpSaTIgBfRkszP1X3rAuyUs/cEf2Y6x5D6T8UsgrVXNWyD3dOO
 4jDvOesUdfD5qh0dXCF5YfNt7gaPKbH2+rLnZjkcZPzSiO9/yRy1Dy0BZBgBG1ntCaUJKw2CfEf
 X4K196esD/qo4YVeYTbemczhL/KveT/6brrqo4MrRXjndGOFR4CX25hSm
X-Gm-Gg: ASbGnct+OAS9mhp06HG1bbquUXgNPDd12VNGHYMIyNiThzArtcyL4n76wKjpNMHDwLl
 qOucEx4690UPDOpJuiadm4k8zRqULXl6rhzB+VrLMvv4LUENPEnIGENadvTVMIOpnGJaHyEFvNq
 qcW1oNxA5rb2QhexKcZ1cWpPEoEWWsGUDPkPnLyGtaDLP0yq22bRHjBGTwXIGobeDoUyEBVv6tp
 /cyz90ssOmNFAGpoy53ByeFIynxRLzfa5jF+/NDy3kU0W8EtaEp0kZdZodjTnVryyN+qbFIrK2v
 Wns2w7/GfO+ZpL/CIRoYMjZtlbIKj7d522tEvKm1o9NJkqhL/v2z5A==
X-Received: by 2002:a17:90b:5310:b0:311:c939:c859 with SMTP id
 98e67ed59e1d1-31e77b19ea9mr2376989a91.30.1753446101251; 
 Fri, 25 Jul 2025 05:21:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVBZxunhwG8DjmtFxiFwEyrDKld5gF2ATjN6sy91pKByrfbRfzqqyxjVG3331mauqTaJ1H8g==
X-Received: by 2002:a17:90b:5310:b0:311:c939:c859 with SMTP id
 98e67ed59e1d1-31e77b19ea9mr2376960a91.30.1753446100845; 
 Fri, 25 Jul 2025 05:21:40 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662df8dcsm3419352a91.25.2025.07.25.05.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:21:40 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 25 Jul 2025 17:48:57 +0530
Subject: [PATCH v7 18/24] migration: push Error **errp into
 loadvm_postcopy_handle_switchover_start()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250725-propagate_tpm_error-v7-18-d52704443975@redhat.com>
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
In-Reply-To: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701; i=armenon@redhat.com;
 h=from:subject:message-id; bh=87S4RBhe9tSJE86BXXC7GsmFR9CfourwSQYRXhBf0Xc=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Zzmc4jvdCTf3ibDnnu2PZep3Nlx67Ndt2B6VcbN86uj
 RRfvdelo5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwEQeKzIybPhc+VVizbKTelwG
 ftNeuMw2MFsew/NL3uBi95TufcemdTP8s2TuXubyY8e6z9Gtlz5eTzmZlnW+SrStp0St+tHrNnl
 WbgA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
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

This is an incremental step in converting vmstate loading code to report
error via Error objects instead of directly printing it to console/monitor.
It is ensured that loadvm_postcopy_handle_switchover_start() must report
an error in errp, in case of failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index e14e2156a4befec44eaaa992c8621a03e499ea76..6ac121a956f30ee2b1295a1e822395a99a3f6d36 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2536,7 +2536,7 @@ static int loadvm_process_enable_colo(MigrationIncomingState *mis,
     return ret;
 }
 
-static int loadvm_postcopy_handle_switchover_start(void)
+static int loadvm_postcopy_handle_switchover_start(Error **errp)
 {
     SaveStateEntry *se;
 
@@ -2549,6 +2549,7 @@ static int loadvm_postcopy_handle_switchover_start(void)
 
         ret = se->ops->switchover_start(se->opaque);
         if (ret < 0) {
+            error_setg(errp, "Switchover start failed: %d", ret);
             return ret;
         }
     }
@@ -2654,11 +2655,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_process_enable_colo(mis, errp);
 
     case MIG_CMD_SWITCHOVER_START:
-        ret = loadvm_postcopy_handle_switchover_start();
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_postcopy_handle_switchover_start(errp);
     }
 
     return 0;

-- 
2.50.0


