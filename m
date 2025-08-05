Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F43C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 18:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMW4-00079H-9X; Tue, 05 Aug 2025 14:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMUm-0002SN-SA
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMRf-0004fm-Ru
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754418691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lyEMNo8LTCH4oBBTDw8r5bocoE5jCam3ilxNpfs9W/A=;
 b=MgxQt9EVayd9LJFeD9VpanpZqXdABDUdrJFd+ANk2SanYxml2SHuCkc+ti5Kzd9ggC5ZMe
 ggwbS/jaZ7lpTSbYKcZpr8GjDqzCB9Sdr8zqJrgqV3jFb5FncM80A5rPf/zDLV/LIiVEzk
 hvyzGhxwKbqUSiwZErR0I8QgUGDe+VY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-_vlmJ4KrN6KUKkaXz388BQ-1; Tue, 05 Aug 2025 14:31:30 -0400
X-MC-Unique: _vlmJ4KrN6KUKkaXz388BQ-1
X-Mimecast-MFC-AGG-ID: _vlmJ4KrN6KUKkaXz388BQ_1754418689
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-23824a9bc29so82770505ad.3
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 11:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754418689; x=1755023489;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lyEMNo8LTCH4oBBTDw8r5bocoE5jCam3ilxNpfs9W/A=;
 b=iZcW6ncOhwsCFVxUuqLEbk5/YUxtYXpjLuvbunhre6EC6U2rnGQou/kuvcbAmv/vZQ
 9rgShfzXfzDW+QpxCnT7gJGypxlQXMCI/c5V4qU5fSagXYydCrZpR0cuRLWevhC01742
 KFH9mbb848wMgIaYFFPpmhKmwaJaj+G6+yDuZuR729QqCFLGdnW4bMuO7KCn6aSl4p1f
 onEyDnjibLaXomYg9CsR6BIQPkBhqr0rDB+zfdx1RdWU6nr8QR79X5NRG2pUogzHGu6F
 oICNcDyIowN0C+nhkCtgROOtwJDcoNLSZEBQY/SmkvdWaa6YIOhWLkzXRg9toG2BOhWm
 w71A==
X-Gm-Message-State: AOJu0YxtQC3A1qO+vOi1NLyrQH26ykJW15GgGMatrgnVuZh7ejIGJ02A
 Jo1V3x/JuNogQLACKNYdTXSOqwYCEeGofDIGUDhmAAM+s7LBj1wgr0sdYKYt6xnES/RdwpLOtyh
 aTTGU3AIGpSt/bGlAnbSe4K7sEGLCDgtbABjOUH6DFge+iZP4vMwcnWUa
X-Gm-Gg: ASbGncuYy3h2Ias+SJ6z5bxd+aXix6T7rQlaXfm3IOCWzRs57H7sCGYRPGXNjW6V4z8
 Ta9sxn6gLiI8rEaH5E5ihyfEPz412XG1I7PVaSATPGIUgW/z/2GsIpi66jOGmTfKfwP7WII2iUP
 j5jbIgZy534Fydb2vQyNPpjNwaTqWmtxWh1qJVgqrkfH9l4sl4PZg8N1M71PJcUz8Zyvl+yjk/a
 4l5kRe7u/EZdWmp/lTDqkxeWnP8dxqCVHDDBbh5AMaPiIX4Fuop6J1wYQ7bkjyXIvXb9NY9NHsb
 vjH22IOMzPlHhXqt+bThewKNhLPrjMqoRZTotpkZuI2YInXHUQ==
X-Received: by 2002:a17:902:cf4a:b0:240:35c4:cde0 with SMTP id
 d9443c01a7336-2429f52c6fcmr1175405ad.36.1754418689186; 
 Tue, 05 Aug 2025 11:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgGtE7mAchzZB9wDEy2zDY5eWBH75SyCCqxgNcEKN3og9YSWofiyiYXX+Me0/j9YXvbBxa1w==
X-Received: by 2002:a17:902:cf4a:b0:240:35c4:cde0 with SMTP id
 d9443c01a7336-2429f52c6fcmr1174825ad.36.1754418688829; 
 Tue, 05 Aug 2025 11:31:28 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e585sm139200115ad.40.2025.08.05.11.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 11:31:28 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 05 Aug 2025 23:55:31 +0530
Subject: [PATCH v9 24/27] migration: Propagate last encountered error in
 vmstate_save_state_v() function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-propagate_tpm_error-v9-24-123450810db7@redhat.com>
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
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3191; i=armenon@redhat.com;
 h=from:subject:message-id; bh=ErhzaVYJNAGZq3AWCqx0ACK1k2Z72sTWy4eZfUuNU3E=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YkX9nbT+pk1fT1Fk9gKGasFjzCX2ka4dSUx3zfYb1RR
 Ki9mGZHKQuDGBeDrJgiS8PXANmmgMKISNuX12HmsDKBDGHg4hSAiczlZ2RofR42V3P7faeg/p1T
 syJjk3Yd5XVdezDmpN0xsQjG2FlXGBludDKtNv+y2Tt7/hKNp+u0L7M8uSdUNjvhxuk8f27vrD5
 uAA==
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

We consider,
  - the saving of the device state (save or subsection save) and
  - running the cleanup after (post_save)
as an atomic operation. And that is why, post_save() is called regardless
of whether there is a preceeding error. This means that, it is possible
that we have 2 distict errors, one from the preceeding function and the
other from the post_save() function.

This commit changes the error handling behavior when two errors occur during
a save operation.

1) Preceding errors were propagated before, but they are now dismissed, if there
   is a new post_save() error.
    - A failure during the main save operation, means the system failed to
      reach a new desired state. A failure during the post-save cleanup,
      however, is a more critical issue as it can leave the system in an
      inconsistent or corrupted state. At present, all post_save() calls
      succeed. However, the introduction of error handling variants of these
      functions (post_save_errp) in the following commit, imply that we need
      to handle and propagate these errors. Therefore, we prioritize reporting
      the more severe error.

2) post_save() errors were dismissed before, but they are now propagated.
    - The original design implicitly assumed post-save hooks were infallible
      cleanup routines.
      This will not be the case after introducing the post/pre save/load errp
      variant functions. Dismissing these errors prevents users from
      identifying the specific operation that failed.
      The entire save-and-cleanup process is treated as a single
      logical operation, and all potential failures are communicated.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/vmstate.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index fbc59caadbbcc75fe6de27b459aa9aa25e76aa0a..ef78a1e62ad92e9608de72d125da80ea496c8dd1 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -554,6 +554,12 @@ static int vmstate_save_dispatch(QEMUFile *f,
                     error_setg(errp, "Save of field %s/%s failed",
                                 vmsd->name, field->name);
                     ps_ret = post_save_dispatch(vmsd, opaque, &local_err);
+                    if (ps_ret) {
+                        ret = ps_ret;
+                        error_free_or_abort(errp);
+                        error_setg(errp, "post-save for %s failed, ret: %d",
+                                   vmsd->name, ret);
+                    }
                     return ret;
                 }
 
@@ -603,10 +609,14 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
     }
 
     ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
+
     ps_ret = post_save_dispatch(vmsd, opaque, &local_err);
-    if (!ret && ps_ret) {
+    if (ps_ret) {
+        if (ret) {
+            error_free_or_abort(errp);
+        }
         ret = ps_ret;
-        error_setg(errp, "post-save failed: %s", vmsd->name);
+        error_propagate(errp, local_err);
     }
 
     return ret;

-- 
2.50.1


