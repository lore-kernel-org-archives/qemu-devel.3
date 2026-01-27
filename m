Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC42D2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoCt-0006Pr-Ti; Tue, 27 Jan 2026 13:54:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBv-0003I2-RH
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBr-0000rT-TC
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769540006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zPqi75yaxnWxisnkh/f1rPum4gZEHJRQ3EW89l53vrI=;
 b=ArALm6NnNJOoP8NOlvJkIHVDAtPm4k4XqnUoTmxUmnXqmXul4cCPDhcTLXfnOmLYPwNaW4
 1BL4c4JluQAGmunqtg70Ru8tYpJlq3tNskgKpWwmFsxCYPGckU11gH7DN7/j24vFZz323c
 9JapekD706XNsS+UT//bi50Q272GPFI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-_DaSYltNP4Oep3hwGE9d7g-1; Tue, 27 Jan 2026 13:53:25 -0500
X-MC-Unique: _DaSYltNP4Oep3hwGE9d7g-1
X-Mimecast-MFC-AGG-ID: _DaSYltNP4Oep3hwGE9d7g_1769540005
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8946e21ad8cso71849386d6.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769540004; x=1770144804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zPqi75yaxnWxisnkh/f1rPum4gZEHJRQ3EW89l53vrI=;
 b=bpXVJfHezlhNlhGZmTknAHj6cXPg7dFwW3ZV984z4utcf8POFEYjFP9lmYfzVE0vJ6
 aoL0BeqXxHJBShPfvhThfFoIvvDI+EypuxqIcBPl2gveP9GZDJrMz/BM1YtjLZ1kdWcA
 hlX/nAKEXN8As/Mt2LyyLSL1kRbBOSo9mxQiVY28lXQ00XYzSp1JLosrHkN1UL9ut4Pf
 ExYxZvOkLUJs4jEVQEsUGgsDxdQNcLEQcm3uVdDTwixhAU5i3K79I1tOZ4MJaYZ4IjKa
 hf9o0169MJt3KPklS5zWW+uFmFmudbzQxqzh0TzyBE+9i3hwQoWLXAatpxHBcgxcJXQ5
 v4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769540004; x=1770144804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zPqi75yaxnWxisnkh/f1rPum4gZEHJRQ3EW89l53vrI=;
 b=vk2s7u2G+s0HhJdBjTW4RBVxa+G5oKac0fYVoE/zRMjQyHrP7n+QGOO6b+Q4+DOftN
 gHT3YWttr+O6WtwdncUn26f47nEPVtCNwBwWYBeCxUEQx3ZTnZGKZmCrGWnEbAW8mbxB
 NL3gIK3oyFVu42HlQxmb0OP4fED5+VDJFVJencwkie393qfi5tKojTo7ngfAoCLakY+0
 xgINPoIjK7QkgvtM502Xy+uCC6d3zLLBWE6vXhWaZTvmAM22GnOYTPxDZn4KW5A5xdDG
 HKArRvtb/RCbPrIOvBIsyb2g0ihmpsiR8o9VhRB7Q6ksBHpDJi9+hd0xuGx+jZLMeWV8
 WHnA==
X-Gm-Message-State: AOJu0YwMXSowaG9fBt+K3tO95Rq+iFbhg14ndxGd2wlK4kuv5x+qUTVB
 wTha1a9jVIr+5S3fxIZB8HPpUGRYtr7kB968av14ma714W7hx6Eb7cbbewmhkeOby4hKLolsPVd
 iMs+VZVnMNZlRV4Ul2g9Btik7EXUclVPVlWl9tNHsT3EyiBGaReXyPFwjOZIesWfnmk1qte61V0
 PgzNdi2yEx2go+dpMNBHH/y3xdfXGD1mEnC9UfLg==
X-Gm-Gg: AZuq6aLlNoiYJBhR4pVVgrRbRE9EHGaUXBDzvQOTFqW8PYBLBNLoX2H6huxXupzY+yl
 AR4QaOnbqwJR+9f8IqlwmPS7Frc+yJxjcI6hNUfCXQRb246r1DcanlTPL66NrslwHanltkpd0pq
 5jeJLb9T3FVzR1z6OOG2fpzoe3LGYHTDA9wW8em0poof4gzoU3d5pogZhI5VX8OTzRUUGV5F9+g
 Q9oRLnZHtZb9ZuC2get5fUemPyAR0Y+QRliJu2D/rpxWO6MmU2lDeYcqzgQ03gRhI3n/LyFR3H7
 DKQaoOwsT/60sYgaAcO9vG9lcIQkWrh0d6URz9I5A8vlFXxCcN/8yrCRhgJqnIqmCYBKbxEcHLe
 A
X-Received: by 2002:ad4:5aa3:0:b0:890:56e:d3ce with SMTP id
 6a1803df08f44-894cc81e442mr39933466d6.23.1769540004402; 
 Tue, 27 Jan 2026 10:53:24 -0800 (PST)
X-Received: by 2002:ad4:5aa3:0:b0:890:56e:d3ce with SMTP id
 6a1803df08f44-894cc81e442mr39932966d6.23.1769540003786; 
 Tue, 27 Jan 2026 10:53:23 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:53:23 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Paul Durrant <paul@xen.org>
Subject: [PATCH v2 23/24] migration: Simplify qemu_save_device_state()
Date: Tue, 27 Jan 2026 13:52:53 -0500
Message-ID: <20260127185254.3954634-24-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127185254.3954634-1-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This function is used by both COLO and Xen.  Simplify it with two changes:

- Remove checks on qemu_savevm_se_iterable(): this is not needed as
  vmstate_save() also checks for "save_state() || vmsd" instead.  Here,
  save_setup() (or say, iterable states) should be mutual exclusive to
  "save_state() || vmsd" [*].

- Remove migrate_error_propagate(): both of the users are not using live
  migration framework, but raw vmstate operations.  Error propagation is
  not needed for query-migrate persistence.

[*] One tricky user is VFIO, who provided _both_ save_state() and
save_setup().  However VFIO mustn't have been used in these paths or it
means both COLO and Xen have ignored VFIO data instead (that is,
qemu_savevm_se_iterable() will return true for VFIO). Hence, this change is
safe.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Paul Durrant <paul@xen.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 130b9764a7..b29272db3b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1897,13 +1897,8 @@ int qemu_save_device_state(QEMUFile *f)
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         int ret;
 
-        if (qemu_savevm_se_iterable(se)) {
-            continue;
-        }
         ret = vmstate_save(f, se, NULL, &local_err);
         if (ret) {
-            migrate_error_propagate(migrate_get_current(),
-                                    error_copy(local_err));
             error_report_err(local_err);
             return ret;
         }
-- 
2.50.1


