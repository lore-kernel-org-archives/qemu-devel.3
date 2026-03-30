Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E9B10D14A7
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7B8k-0003Sf-Tf; Mon, 30 Mar 2026 07:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8e-0003Gn-E5
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:50:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8c-0005vj-8V
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774871433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1KN1Ez0UFJRKSmYhQtmJ35yN2E12QY55k45i80KRaE8=;
 b=IJM0UuB3+1nzI6bGZgjm5Wx+3hktqTFtiZ6RKe3rghAMiV1NGYd0tygYT700imZkuerW0t
 0rkD+Mh8HMzdxHiGB5GpukMH2AlnF593RR4ijZmFBkMEQKtXHs16aXtWNLlVa8iOtzQMk7
 gIdAy32nh9z4VR9wcivedg07QyA4AvU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-76U1j0eDPNqdFpbiEz442A-1; Mon, 30 Mar 2026 07:50:31 -0400
X-MC-Unique: 76U1j0eDPNqdFpbiEz442A-1
X-Mimecast-MFC-AGG-ID: 76U1j0eDPNqdFpbiEz442A_1774871431
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43cfbe041b2so796136f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 04:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774871430; x=1775476230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1KN1Ez0UFJRKSmYhQtmJ35yN2E12QY55k45i80KRaE8=;
 b=S/9oG5AAEc22ajOaWi399FCJFSWAz2droNsrv5QhcnzJXlpxTjRr1FRUyEUcco+GoQ
 6FgyrhHElYiQw2B2/IK0uWPdIjxkBaXlDIstBulnZ5gFPtJkZAK8tnHxATnfOHhCZ8Z+
 kIq0KcGQ/VvdMErEPRY6gOdZ6Zi0xZMMn5brxLcqqiiRKqAxE9NaT/+GACdEMM7JNzvu
 LiJ/xTfXcW8nAtlXuliMISci8c7gK6hnxTCDkXsWkHaVjVeYbeVSqfFjfHRRpFaF2o7q
 trSKGNTfWUR95RYWlbBoYc4AKJq0DSB/P721Iep7arHf8QN7hygbw+rJAkIEeZyQV+dI
 Ur9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774871430; x=1775476230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1KN1Ez0UFJRKSmYhQtmJ35yN2E12QY55k45i80KRaE8=;
 b=OmgP7bd4xYvVEgto4rKhoWVuqHh1qAP4RqD/6jWZ2vQfL+QduYcNeS67IawFKPaavY
 jxTnvgleaVNCUH7KWY/pojRXuShPlmx6QaJjy4vKtFij1niGhysP/JTxk1uU3CoA45v3
 BnhmNeM/KZ4IqpkyFH7m1TWJvrT58XzCyvUwfTcpOEWgH1onlxuuS5C3OgYUiJN2vhIX
 O403Z0ytxZxnb4S8SQ2WSlkvMtT7qlUsFkmbH0dLjdesOcdZeOPw6O/VPY/Uf59LTiuZ
 ai3UhZmCnJW8NEB9XuJe3j77YiRvP10AMb6ucJEi8C8FeY2MhoJd+eYqlAtYKO1v+R77
 aolw==
X-Gm-Message-State: AOJu0YxLjaHhWrwYO7hDOsqbDXXNgmo4rTbGFwT78I5pYQaUFafoBf2Z
 W0xHhKBeEApw/gpfh5LDnjtwutJ3LGRGJzAWUb0YyYdAn6eeHvxDpDbxp8ziFpSh+e0JnBI8Qim
 zcLiTMzoh7eJ6WyX/fOOZVEcdXDnNdcBcB9kOmHBKWPzVuhPB5cAfYmQKTyXNDPmH4O3guykMgz
 3HtHkUvrpPANLfS+YcmqLjdMHBcnuHO9daVVIrxNzo
X-Gm-Gg: ATEYQzyMVHXU6VPDq42PccE+1bSbqZhVl3IWkIed2yB11Fb3GJRQMECVS+4CMAdggYg
 iKmWeA/0uZxUKDxftq99yBocL1LAmW2mV6oTEPXASy4Q5M9pPXcjJSpsC76myQG5j88rFOPJ3Op
 /BDox6ycBg4O3qX/X/+++EE8/G4ukHCwX3LXKHYASSh9+Vxx0OVwq5ivsgMh+BWXDUkYFq3yV7R
 VxVwWLhxbODAlMg/I756VwFL1Jn0hkp6do2/onVItQNYkeETm0JXN1MEn8ckesIdIZC0CeulpxM
 W+YF/26hlL/g9DxJnoJQMDbSnixisyd/UlyEpqroBFq/jqRxTvAOtTmUpDbird7VKaScKERYdAv
 LjQALAWhSFXGV0go2r+Qx3XbcFfGWoym66VUIITybO6PYPSESxVZuKH0nT4/BTqeE6cFh5t3sHG
 9XdoFxsokfaSvynNkR3DxXItBY
X-Received: by 2002:a05:600d:8402:b0:485:3428:774c with SMTP id
 5b1f17b1804b1-487290b36b5mr125570745e9.4.1774871430066; 
 Mon, 30 Mar 2026 04:50:30 -0700 (PDT)
X-Received: by 2002:a05:600d:8402:b0:485:3428:774c with SMTP id
 5b1f17b1804b1-487290b36b5mr125570385e9.4.1774871429550; 
 Mon, 30 Mar 2026 04:50:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4873069961esm179811265e9.12.2026.03.30.04.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 04:50:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 04/12] target/i386: emulate: remove redundant logging for
 unmapped MMIO access
Date: Mon, 30 Mar 2026 13:50:08 +0200
Message-ID: <20260330115017.256211-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330115017.256211-1-pbonzini@redhat.com>
References: <20260330115017.256211-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

ReactOS's install ISO does a bunch of 4-byte accesses
to 0xffdff124. This doesn't happen for the boot ISO.

It looks to be an access relative to the Windows KPCR
which is at 0xffdff000 but mistakenly done prior to
paging being on...

As this logging is redundant with -d invalid_mem,
remove it.

https://geoffchappell.com/studies/windows/km/ntoskrnl/inc/ntos/i386_x/kpcr.htm

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260327011152.4126-5-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_mmu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index c69ae96acb7..007de582de9 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -21,7 +21,6 @@
 #include "cpu.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
-#include "qemu/error-report.h"
 #include "emulate/x86.h"
 #include "emulate/x86_emu.h"
 #include "emulate/x86_mmu.h"
@@ -287,7 +286,6 @@ static MMUTranslateResult x86_write_mem_ex(CPUState *cpu, void *data, target_ulo
                             MEMTXATTRS_UNSPECIFIED, data, copy);
 
         if (mem_tx_res == MEMTX_DECODE_ERROR) {
-            warn_report("write to unmapped mmio region gpa=0x%" PRIx64 " size=%i", gpa, bytes);
             return MMU_TRANSLATE_GPA_UNMAPPED;
         } else if (mem_tx_res == MEMTX_ACCESS_ERROR) {
             return MMU_TRANSLATE_GPA_NO_WRITE_ACCESS;
@@ -339,7 +337,6 @@ static MMUTranslateResult x86_read_mem_ex(CPUState *cpu, void *data, target_ulon
                            data, copy);
 
         if (mem_tx_res == MEMTX_DECODE_ERROR) {
-            warn_report("read from unmapped mmio region gpa=0x%" PRIx64 " size=%i", gpa, bytes);
             return MMU_TRANSLATE_GPA_UNMAPPED;
         } else if (mem_tx_res == MEMTX_ACCESS_ERROR) {
             return MMU_TRANSLATE_GPA_NO_READ_ACCESS;
-- 
2.53.0


