Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D69ECA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 08:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up0zE-0001oa-3s; Thu, 21 Aug 2025 04:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0y9-0007mo-JO
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0y1-0001e5-Gn
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755766091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A5JIUKo80MFui0gvLteXR+PBMMRhZOQC+TEUJWP+nUI=;
 b=F/jMYN2EUwVXQHYoSSWoy4jirVzsTK0OkmswzeMGwUZ7co1ZW2UXqzxijlfmeC0NaLbFV8
 xMdYNoLN4jtbSyc6QSPwOeELD5lnzlOToZihwsRPbH1NqaNHWCfQb08omJMKhIx7RPPNbE
 dSst7DlTbB9YFUBV57duLG2XYI48ZWw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-_rSBH7k4Pwev6yoejddWtw-1; Thu, 21 Aug 2025 04:48:09 -0400
X-MC-Unique: _rSBH7k4Pwev6yoejddWtw-1
X-Mimecast-MFC-AGG-ID: _rSBH7k4Pwev6yoejddWtw_1755766089
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b47173ae6easo1382408a12.1
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 01:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755766088; x=1756370888;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A5JIUKo80MFui0gvLteXR+PBMMRhZOQC+TEUJWP+nUI=;
 b=DtMFSyyRnayiADu+ycv8wPMHc43jYyaUSEvec6Btq8NZz2rBCDxipQkm703p2l0r6n
 eNI3aHrJPn70oy1EXB0Z7Dbk6lqS4U1MjgV2N+5A6s0LYYgQWRvfiKPegnqKhm6JW565
 2MiE2IbSarjfEJ3/tTowYQgQ3+1QKbN7jR4T5DfYYll1SwE5BBNTIzwUHXsc5jDdX1/9
 ZbxX8DHbIYGxPdmw2c5YD8Tuo4hS4I8EGG3ZpRgKEINyJfvZgJ4d3CeTp76DdjWQ9Mai
 eXKywTy6A/g/s6xYn3ik3zfbRH9UU+2vyC1CrEV+ragw6cgnRf5aXOX2H/sq+pdU2az8
 uugg==
X-Gm-Message-State: AOJu0YyGMCzoEHf3+UvtUAZTrFlntTvhNwr5qNz7wziChc7uR9gPs+7Q
 CkFwCNiMK98UV44cC+HywK1oUsEsWPgWQ9fpnwhsbYuXbrrt8R8QHPo6QRMrQXPyq26pEGqkDEg
 pqTVSnvDLiCfzE9AcZJpEzckOZoteWT5l7yTBOSo1lexrwEU0XGKazwkU
X-Gm-Gg: ASbGncucPwmOjBXChuqv+1gNpXxoHamv6iwSQMGF8vvanR7dDxyVFOM0euAQaFWPujt
 v1fO4dAM4Vu0QltSDFXLON+FStDuGOXq6ictfUs/jpFR+sJJ/gckAFSmVZ0LB7vCtOz4E9Js4gM
 Oj5RTCYtNmcYV9zgitA5kZBlG6luP0e3Z1WoumWIU+O0rIFt/Ct8H5BpxFLCTl36Gv7XbpXBhtH
 78JANxuVVpNCgZpDHuZX1SDw5HZJnRbtQp+H7m9K2vg1eLFvOUvPbfAEtOSQrRwGvdV3QtvL2Hx
 oL+GgbIRRbDZobc7328qQM6pMUJGmaxJqaahrRPnivtDwH4nM3R7
X-Received: by 2002:a17:903:2350:b0:242:d721:b019 with SMTP id
 d9443c01a7336-245fed82900mr23403535ad.38.1755766088490; 
 Thu, 21 Aug 2025 01:48:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ+EXmc2bVC2Jz1FJYA2qqU/z3Hh/iD3+k7eiA2uN7ytZHshilUn47nQBAUkP2BFcFnlki/g==
X-Received: by 2002:a17:903:2350:b0:242:d721:b019 with SMTP id
 d9443c01a7336-245fed82900mr23403065ad.38.1755766088127; 
 Thu, 21 Aug 2025 01:48:08 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33e05dsm48789985ad.3.2025.08.21.01.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 01:48:07 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 21 Aug 2025 14:14:14 +0530
Subject: [PATCH v12 20/27] migration: Return -1 on memory allocation
 failure in ram.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-propagate_tpm_error-v12-20-72b803e707dc@redhat.com>
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
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1640; i=armenon@redhat.com;
 h=from:subject:message-id; bh=cNaEYpqhoAUI92Nxyhd9WrnrjASz0Op8kUgR9WpfeRA=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8ayOymima5z62695VksW9NhvCGKrV/KrIzhVN/ETI1Ni
 e/n7eDqKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMJGuSQz/LCrYxG5f3B+2/Wj2
 csnpzyyb98xtFvlw9cO3C6csJl1o4GJk+MO/7fn2B3k5P3582OXdM73wScmS2pyK9iWb1Iz49VP
 UmAE=
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

The function colo_init_ram_cache() currently returns -errno if
qemu_anon_ram_alloc() fails. However, the subsequent cleanup loop that
calls qemu_anon_ram_free() could potentially alter the value of errno.
This would cause the function to return a value that does not accurately
represent the original allocation failure.

This commit changes the return value to -1 on memory allocation failure.
This ensures that the return value is consistent and is not affected by
any errno changes that may occur during the free process.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/ram.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 6a0dcc04f436524a37672c41c38f201f06773374..163265a57f26fb1dc88d9797629d58c278e9afb7 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3575,6 +3575,8 @@ static void colo_init_ram_state(void)
  * colo cache: this is for secondary VM, we cache the whole
  * memory of the secondary VM, it is need to hold the global lock
  * to call this helper.
+ *
+ * Returns zero to indicate success or -1 on error.
  */
 int colo_init_ram_cache(void)
 {
@@ -3594,7 +3596,7 @@ int colo_init_ram_cache(void)
                         block->colo_cache = NULL;
                     }
                 }
-                return -errno;
+                return -1;
             }
             if (!machine_dump_guest_core(current_machine)) {
                 qemu_madvise(block->colo_cache, block->used_length,

-- 
2.50.1


