Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FAFC87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHMo-0004Cx-9q; Fri, 08 Aug 2025 03:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHMf-0003Md-Um
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:18:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHMX-0007aI-N6
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754637480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KcsB3EUMJsqI9BIo2c/GAiLUjrJplvjvOwLkJgmi5Nk=;
 b=J3Tb5SmhcX24dcHLRf1U/kMIRXRMVKdI0wUR2SKnmZM0jbniBH+x8PT6t1CsrGPxnKpvfa
 5m3aqWXoni46oi2mYLVrINcA0De4ohs08uk3wtVlR89qUNO7T2Q1oFx3HrqDDZg1W6aei3
 1KlVB9GHv4x98vltPSyOC2aqXHX+L/Q=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-F3DtmRbJPrW5tMlhAVnx1Q-1; Fri, 08 Aug 2025 03:17:58 -0400
X-MC-Unique: F3DtmRbJPrW5tMlhAVnx1Q-1
X-Mimecast-MFC-AGG-ID: F3DtmRbJPrW5tMlhAVnx1Q_1754637477
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-240607653f4so16422945ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 00:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754637477; x=1755242277;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KcsB3EUMJsqI9BIo2c/GAiLUjrJplvjvOwLkJgmi5Nk=;
 b=ug5vpeJ2VVymX1/K7cX8Oa/ZbL5CgXGCPXbAF9PLVAH3DOQkk0VpvYMA2adiXke8qY
 8oF5fH/1p0XOnyQ/XXVtdWumazDSmETgHg1J/Mkr/wUP0rFaeH9YhgSK0dBCzKR4L3RJ
 KUF4zUJZJ5voqzEa2376EJnZgwRlAhLQrfnYcJT53LULeStjPGCRAXeg/tlcoMD4Vy9Z
 NZA3Xc23MDs2pjwCEququAtCUffuGEjoOiggtTETunjsE1nxGxciKX2qt0WFhc+mpMbs
 L38KRQCv0JtHR7/WKzwnsYsPlsvSgtKblzByXXajjOq+rAp9XfhZrsSB2LCWMHHEA3VF
 vRQQ==
X-Gm-Message-State: AOJu0Yyt9ojNa6kh6Rf3+duBSr8rFVZsgZ6g+KP1aCoBBuQ7qKfxv2AL
 dZo/JLfQL9OxDquC76yCJZREQkK2xVSYEzSfXc4b6GfRKxG0GWIeR9CU9/w8IguEKXhYqPNdPP7
 z5IfA/TZfrbstBhAXsvcf4PV/28rqyXw0fijGr9QnuwNvgXApfbWifeeo
X-Gm-Gg: ASbGnctNxyMqY/6B3n9YBZz+44XGrw5PoVzmmhLi5i0I9j/CVGXJedzOls9rmWgPCBc
 K2MJ8wt+RX5kuZfdZSXNYtCox4+ejmpnD9lR/Kz2zWCVAQmGpnHjU7omefQ3uCK+DedV2uAEEa8
 njAf0fC+kG22/l7rZiqWgboOBUuEYDSTU3gWNte1ISdWvvDsGQXXhHZhJWIy+g2lS7VH7aC1Hd5
 C8cQsghIwudi//M/K11n50q25NZjLOngRTu0hwda2u/0N9KgMAR8S/QzRVTxRFBGSgf1/OSeENd
 553sIt2xnqUbPnbBDhjPLYu8bj2q+DtF+6I8JLtkw9V+cZjIl5yvPA==
X-Received: by 2002:a17:902:d488:b0:240:2953:4b6b with SMTP id
 d9443c01a7336-242c1ecbcfcmr33146505ad.2.1754637477209; 
 Fri, 08 Aug 2025 00:17:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3hN7DujYoM9+TSxoyb7NDlUo8+hhp4rkWTuxmwSBc98GpZlC3ymThD8OTtI3wY5jdGrC5Lg==
X-Received: by 2002:a17:902:d488:b0:240:2953:4b6b with SMTP id
 d9443c01a7336-242c1ecbcfcmr33145995ad.2.1754637476777; 
 Fri, 08 Aug 2025 00:17:56 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d347sm199659385ad.140.2025.08.08.00.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 00:17:56 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 08 Aug 2025 12:43:48 +0530
Subject: [PATCH v10 22/27] migration: push Error **errp into
 loadvm_postcopy_handle_switchover_start()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-propagate_tpm_error-v10-22-3e81a1d419b2@redhat.com>
References: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
In-Reply-To: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701; i=armenon@redhat.com;
 h=from:subject:message-id; bh=Zu5RGittsHxfQZbv0Y5N+WqZG4at5pwqsOTAvATRu44=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8bUxdeijR8yGlWvDhXfo3ad3yPEa/LVxpP2J+rezTCrf
 9Qrs9+8o4SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwERyTjD8z3Rut7g7/bHfJbmX
 c+VfCjBe2/Ls1Amd6g3yslt35lqZ/mL40aQnfKG44cn7BX9P/mpcuOmj5lutvv8GB39Vb7u+8IE
 TMwA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index c5566199d00893c4e083ecd27a55da832e2df574..de2bce276faa863a0f25deedafb0b784f10559d7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2538,7 +2538,7 @@ static int loadvm_process_enable_colo(MigrationIncomingState *mis,
     return ret;
 }
 
-static int loadvm_postcopy_handle_switchover_start(void)
+static int loadvm_postcopy_handle_switchover_start(Error **errp)
 {
     SaveStateEntry *se;
 
@@ -2551,6 +2551,7 @@ static int loadvm_postcopy_handle_switchover_start(void)
 
         ret = se->ops->switchover_start(se->opaque);
         if (ret < 0) {
+            error_setg(errp, "Switchover start failed: %d", ret);
             return ret;
         }
     }
@@ -2657,11 +2658,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
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
2.50.1


