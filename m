Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F06C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 11:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWvnE-0002gt-Tn; Wed, 02 Jul 2025 07:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uWvnC-0002fG-0Y
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 07:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uWvn8-0006FO-1H
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 07:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751456295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwAO+bIaO6hgKcP8h5fbbFCxgdkj/xUOW7ysKJBoajk=;
 b=FZbiUt70pmQKQ7/BKt7BJhGQNlEN142ZHyatDzlBybVllF1adPfs8J8fkOeQgJ+b0WBlvF
 7SaVfiVtAxe/dkkf1G/h0NxcYQjXy5i/s4xdDiPI2qisWBF7L5IU9zomJAayCuAzihnO9o
 uWJt5yka7A9xyURTQx4YPUaRExoGBTg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-ypM9eLKUMKWBDTSSHRrdpg-1; Wed, 02 Jul 2025 07:38:14 -0400
X-MC-Unique: ypM9eLKUMKWBDTSSHRrdpg-1
X-Mimecast-MFC-AGG-ID: ypM9eLKUMKWBDTSSHRrdpg_1751456293
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-235e7550f7bso61932655ad.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 04:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751456293; x=1752061093;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mwAO+bIaO6hgKcP8h5fbbFCxgdkj/xUOW7ysKJBoajk=;
 b=QbJoPPsEzZwsjMVu5jvJRqs8F+LdZPi4CezpD5ZbnQ0vAUfb7IeVghHMICYCMqXT22
 JbrEnry4T1TwHcMO1le40Um50VtlRQFZ18y+aRA43QmHTjGYG0E0W1jB1l+QyleAdtsV
 OREkqLUkccEj6lZNPjkGop5wTGfJ98IgSU0n+Xe7Ik3/kzFH9N6FYK93W3OzrjINKSFD
 jLSTVdbORxVJVAHk79ZdBzDJRtxcv12c+/nRXnFOEcG6F12w13MODmWQ7pnCtdwYBV2G
 Du+/hRyAlxA3qsu56Q6j1sYVVdoQNeVaoLUzEDXNmf0cpvOc4PA9c8wgPRKcQ3dYQ+uN
 JQJQ==
X-Gm-Message-State: AOJu0YydcJnQWlLj3EPfSl6/VSHLHfKAS0ZwlGNIYPXKNg7LEFnE5qt+
 BioKR8mtBvAmU3PUcDNdLrIxa5Srnn/2NipkpJznDiY39ruSjbXW7VQP9/mTc4IIluf27Vw68se
 15iyUFz+4tSyOi+QdChjW9PyBMxkvshS1Flbm0/Hb0h3Dkd3s8sC2QRQ3
X-Gm-Gg: ASbGnctW4TXeRGSDsfCqv4K2WvM7/IUsxAHUoEscuX2qj6Grgulr8Q5gcTgXqCaZuNO
 gzFCBUbgcXHlp+/NHsWQIAjdtc6kdc8zRxid+bqvUK52d2Q7aPSakUahA5OiPkCJn58jmXIVubg
 9/Vh/6kyelaguMiGgjo0sdqsuu1537UrNpkR4Q34aToHCY07K42jVsiRUuiH9j32pvSKxB0CBP5
 u36OBfkGkUTjNRV4g5kmuXqFvFAreH7V02Gs7uf20RitOulzvPf79wPpDC6WOvYB/Be8P+X4iih
 q9MR72ITsYsJqf5hhfkoZjmmiYGfSr6J+48=
X-Received: by 2002:a17:902:fc8f:b0:235:2799:61d with SMTP id
 d9443c01a7336-23c6e5f4b58mr35942285ad.33.1751456293420; 
 Wed, 02 Jul 2025 04:38:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH23Zjy8tCXEnqYIFgRFC7KZw1cama7DYqKQcy7HhLVqq5yLFIgdU8g8QoNWzQQkX5w2V4FaQ==
X-Received: by 2002:a17:902:fc8f:b0:235:2799:61d with SMTP id
 d9443c01a7336-23c6e5f4b58mr35941725ad.33.1751456293018; 
 Wed, 02 Jul 2025 04:38:13 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23b0b3bc0f1sm84265205ad.171.2025.07.02.04.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 04:38:12 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Wed, 02 Jul 2025 17:06:51 +0530
Subject: [PATCH v3 2/3] migration: Introduce a post_load_with_error hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-propagate_tpm_error-v3-2-986d94540528@redhat.com>
References: <20250702-propagate_tpm_error-v3-0-986d94540528@redhat.com>
In-Reply-To: <20250702-propagate_tpm_error-v3-0-986d94540528@redhat.com>
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
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793; i=armenon@redhat.com;
 h=from:subject:message-id; bh=PAEVsxJ3s2psmY71RWgoPGNDUYopYZE12CD6g0qNgMw=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aqFP+x1OVzY+dPyGp/WbH9//1LTRfSPzescVE64zpVZ
 n1P4nq7jlIWBjEuBlkxRZaGrwGyTQGFEZG2L6/DzGFlAhnCwMUpABPZJszwz1z1IuenRQtj7Dne
 eBTvX3tmbaF801Ee57mWoQarOp9O42D4K7Kyu3FL0GP9K3MjDa51XRRcYFk0UTBpw4QlzXdr/+6
 oZwMA
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

- Introduces a temporary `post_load_with_error()` hook.
  This enables a gradual transition of error reporting,
  eventually replacing `post_load` throughout the codebase.
- Deliberately called in mutual exclusion from post_load() hook
  to prevent conflicts during the transition.
- Briefly discussed here : https://issues.redhat.com/browse/RHEL-82826

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 include/migration/vmstate.h | 1 +
 migration/vmstate.c         | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 056781b1c21e737583f081594d9f88b32adfd674..1c6e89c3b08a3914cde6dce3be5955978b6b7d0b 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -207,6 +207,7 @@ struct VMStateDescription {
     MigrationPriority priority;
     int (*pre_load)(void *opaque);
     int (*post_load)(void *opaque, int version_id);
+    int (*post_load_with_error)(void *opaque, int version_id, Error **errp);
     int (*pre_save)(void *opaque);
     int (*post_save)(void *opaque);
     bool (*needed)(void *opaque);
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 158dcc3fcddfe70ab268dc5ace6e4573fa1ccbab..0048c4e1e7ee1d6ff3a3349abb0dc1578985a56e 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -236,7 +236,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         }
         return ret;
     }
-    if (vmsd->post_load) {
+    if (vmsd->post_load_with_error) {
+        ret = vmsd->post_load_with_error(opaque, version_id, errp);
+    } else if (vmsd->post_load) {
         ret = vmsd->post_load(opaque, version_id);
     }
     trace_vmstate_load_state_end(vmsd->name, "end", ret);

-- 
2.49.0


