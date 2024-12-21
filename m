Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9391E7718B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 19:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tP53v-0002VY-FJ; Sat, 21 Dec 2024 14:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53t-0002Ur-R5
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53s-0000Ny-BJ
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734808971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cPykELzZWYychb/XmGLesydXjeUkKpSsqMmT/tkVBhQ=;
 b=Z0ovhALwcVqS4p7dWxKSC48Z5l1Ho4do04lnNbuAstfzYRG05GrecGDQlWPB/NAnG4Fpww
 r5au7mIssbAK3esRb0HVpQ+X9owaml+vM0isgnGLZybU4jIgB36UKLQNWgBszrWHnLGvyS
 ze1XP8R4K43uHJvZV+u1yWclhXxxsDs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-mtpNn1LNMnCRHwNsdOZ54g-1; Sat, 21 Dec 2024 14:22:50 -0500
X-MC-Unique: mtpNn1LNMnCRHwNsdOZ54g-1
X-Mimecast-MFC-AGG-ID: mtpNn1LNMnCRHwNsdOZ54g
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43631d8d9c7so15640125e9.1
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2024 11:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734808969; x=1735413769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cPykELzZWYychb/XmGLesydXjeUkKpSsqMmT/tkVBhQ=;
 b=sFArEcb5U7D7XZq57NZ0nz9bzQ3mMm7k7ut6fDdrXFS3Usep3O0FD0Y+VN1qH6mSU7
 ZsOKR9wL6jarTfn9fI2bZmRnx1zznyX9RjDDQU2QGL9N7I89tnAoj21oAYXD1AeqkVt7
 W9KKAq/5UTK2GkbHJ9hfrR59ryRMhdLjTnDpzd4UdBIG5JrNYkiZIBrLtXqYeSXnKCfT
 Yyal27S2bEXteuCVn6sCIf92oBiS9B8HdAAeAPdrvXvYBL0vhT9t5dq7H4XYJKTFpJ5a
 w0fO4lWlnalj0atoGC5EDUW3G93RNFPdBWdH2S3d1hmD+jmwPndt8I6CJplatzOk/xlh
 bwuA==
X-Gm-Message-State: AOJu0YyxJSG3pEGndwSjbN+k7AvVWK5h9BPYsnhjby0rAjdY6iQeOEi2
 tiZSiGny6s3WTK8M/dNcMaFZqzhBo2dBodtbN2zbeAI4HmVsY3U8v97v8Pk7dVA+ZUU2pd5yqKo
 BHjL71HCtG3EVnTnbbR4nQcHPz02hXmOs7b9W7eNxOAYrBvNSTcIcMdEuCzQs9hRudAKLattqoR
 cu6LfV+IHO5+iSzool0DcWDc9+r7TQnCdl
X-Gm-Gg: ASbGncuuXaF0kCLcxoQRWuhlfAJRr2/2q6KWq07i96iEOZU97rIjCZs6apYTE+EptZF
 8ePCFCNR8hByuBx5lPSEQpBLrMv++xwY4r69FlHP/Qdzwqr4KsejY0nTsnIS6q1bzGW4Xd/ep0d
 yuk0H6MEOxBzw43fEamXalR5mtzU8PqmMPsx/xD2VsSeqDNplcieOyoBum7e6WJGLciMeabZVD0
 BSYyvBFmG5nwV/Y1zdDpaV1N/np3ChoC0qPaaypeMTXAuM0ZeQRKCclOj13NrqM2oAg6w7/ZBNT
 Kg0kNhaOVZNV2PzqFcwulqNOHR/ahrTvUckCQuI=
X-Received: by 2002:a05:600c:3b26:b0:434:fa73:a906 with SMTP id
 5b1f17b1804b1-436697f8e14mr50764315e9.4.1734808968979; 
 Sat, 21 Dec 2024 11:22:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUmYIDasQqLW83KjYjIwHmHo+TQe37j3c6gLScQ7YhFIY1d1M1qlAOF32NhTrAPBYK9eLaJA==
X-Received: by 2002:a05:600c:3b26:b0:434:fa73:a906 with SMTP id
 5b1f17b1804b1-436697f8e14mr50764155e9.4.1734808968605; 
 Sat, 21 Dec 2024 11:22:48 -0800 (PST)
Received: from localhost
 (p200300cbc7137800820d0e9f08ce52bd.dip0.t-ipconnect.de.
 [2003:cb:c713:7800:820d:e9f:8ce:52bd])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43661289995sm82665035e9.36.2024.12.21.11.22.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Dec 2024 11:22:47 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL v2 13/15] s390x: remember the maximum page size
Date: Sat, 21 Dec 2024 20:22:07 +0100
Message-ID: <20241221192209.3979595-14-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221192209.3979595-1-david@redhat.com>
References: <20241221192209.3979595-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.177,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Let's remember the value (successfully) set via s390_set_max_pagesize().
This will be helpful to reject hotplugged memory devices that would exceed
this initially set page size.

Handle it just like how we handle s390_get_memory_limit(), storing it in
the machine, and moving the handling to machine code.

Message-ID: <20241219144115.2820241-13-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c         | 12 +++++++++++-
 include/hw/s390x/s390-virtio-ccw.h |  1 +
 target/s390x/cpu-sysemu.c          |  7 -------
 target/s390x/cpu.h                 |  1 -
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 2ba66be018..9f8d830798 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -143,6 +143,16 @@ static void s390_set_memory_limit(S390CcwMachineState *s390ms,
     s390ms->memory_limit = new_limit;
 }
 
+static void s390_set_max_pagesize(S390CcwMachineState *s390ms,
+                                  uint64_t pagesize)
+{
+    assert(!s390ms->max_pagesize && pagesize);
+    if (kvm_enabled()) {
+        kvm_s390_set_max_pagesize(pagesize, &error_fatal);
+    }
+    s390ms->max_pagesize = pagesize;
+}
+
 static void s390_memory_init(MachineState *machine)
 {
     S390CcwMachineState *s390ms = S390_CCW_MACHINE(machine);
@@ -191,7 +201,7 @@ static void s390_memory_init(MachineState *machine)
      * Configure the maximum page size. As no memory devices were created
      * yet, this is the page size of initial memory only.
      */
-    s390_set_max_pagesize(qemu_maxrampagesize(), &error_fatal);
+    s390_set_max_pagesize(s390ms, qemu_maxrampagesize());
     /* Initialize storage key device */
     s390_skeys_init();
     /* Initialize storage attributes device */
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index de04336c5a..599740a998 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -30,6 +30,7 @@ struct S390CcwMachineState {
     bool pv;
     uint8_t loadparm[8];
     uint64_t memory_limit;
+    uint64_t max_pagesize;
 
     SCLPDevice *sclp;
 };
diff --git a/target/s390x/cpu-sysemu.c b/target/s390x/cpu-sysemu.c
index 3118a25fee..706a5c53e2 100644
--- a/target/s390x/cpu-sysemu.c
+++ b/target/s390x/cpu-sysemu.c
@@ -255,13 +255,6 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
     return s390_count_running_cpus();
 }
 
-void s390_set_max_pagesize(uint64_t pagesize, Error **errp)
-{
-    if (kvm_enabled()) {
-        kvm_s390_set_max_pagesize(pagesize, errp);
-    }
-}
-
 void s390_cmma_reset(void)
 {
     if (kvm_enabled()) {
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index b4506539f0..5b7992deda 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -881,7 +881,6 @@ static inline void s390_do_cpu_load_normal(CPUState *cs, run_on_cpu_data arg)
 
 /* cpu.c */
 void s390_crypto_reset(void);
-void s390_set_max_pagesize(uint64_t pagesize, Error **errp);
 void s390_cmma_reset(void);
 void s390_enable_css_support(S390CPU *cpu);
 void s390_do_cpu_set_diag318(CPUState *cs, run_on_cpu_data arg);
-- 
2.47.1


