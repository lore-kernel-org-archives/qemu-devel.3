Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4893C5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSmA-0005xF-A6; Thu, 13 Aug 2026 06:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wuSm9-0005wv-Aw
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:35:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wuSm7-0000AU-V1
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786617303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rpjpCejkLojUCVc87ev/0WjmuneloovioFsqiimDyY4=;
 b=XlUHTCB/8qh1iYtGloUl6+Vph3PUMHlFYo5YVbfDh9AGv3vE+vm1K6mh+WlDbEej1z5Fcd
 1IY5QXSA9TOyqLFiJKIDKrTQ/TWPRW6tsxElvaY8Y6eRo9FygPzpsNC7NiWdm3+N/cZdhS
 fWOlfz7wFL4q/f/vxyYCH4wr2AcB1Hg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-ZjYsrEx6PymzUvq7RNAdCg-1; Thu, 13 Aug 2026 06:35:01 -0400
X-MC-Unique: ZjYsrEx6PymzUvq7RNAdCg-1
X-Mimecast-MFC-AGG-ID: ZjYsrEx6PymzUvq7RNAdCg_1786617301
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cf7dd9fd91so21624355ad.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 03:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786617300; x=1787222100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rpjpCejkLojUCVc87ev/0WjmuneloovioFsqiimDyY4=;
 b=jm8THkhY7Un9hkSwNQB0RF9lO9XF9fYcrcc+Cre8H87Mi+fWHgSF1JGJF5osdlYP2h
 uAvFPB4RiaWb+dOTE4yR4nWA4Tw5jxSRUJl4pjqn46nWLF5rurbdbIyQ6hopojnfqrqX
 hPNf7vnyRjFobZpl45SwMKXYgEWYHSv7J4TlRQeXWGX99Uz3QaQpA71a6SOcUqKGp3Ta
 1cothxtg19VzRloeDCP5QuXp0DWenfPlLvsDwaVCQzm7YUBaNmHxxjzK1zmbGEYh1dQH
 cNqhlQzi91aecjHKK7YBouBVsX3YMSYblTGspFAFhTAGT0PhHTBlzKm3ZaEp8+7A87wt
 5b4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786617300; x=1787222100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rpjpCejkLojUCVc87ev/0WjmuneloovioFsqiimDyY4=;
 b=ax1IdYcCU3CsQBCNpRkQ6hkePaY9DRpZgwJiIr0o2mhH4MyLea/fDK9JmtzQLHkcnI
 32+a7gZhFfZQ8nQMLJ/rHCHiqmpl36rtfzFmKfrdq9rZvBkZVRtEuJ31gF+xYSmCudrm
 aRTm14yPSXS407y9SoKXqBP9X04QHO9KfsoKxk5ZlURbZcYeJi4yUdamfoyJWcpmhWy2
 BieUWWOc5Zg8s1EZUnD4jyFF4fkUAeEgIc/IDbEcTpfYsGjAkN9X2wBsZJbIsYSFFMm2
 3FUm0OlUQ+D0iihXdYXnVpM9/ecQ/p5VKqcdW8aFjrru9n5u+iS301U9I8Z0QVqE4BsC
 yTrw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqdNwLMwMFG/Nlj2qm8DcMueMOHVzzFx3bKIu84E0J66PsGU2OXarRrdaewgvaEG2wV2QIWZUpl8Nra@nongnu.org
X-Gm-Message-State: AOJu0YxIKYHj6pv8Qu0D71uMkWea+IVIgA9ixqHZM1xVBJt5rEJfL549
 PaRp2Y7WMUSRMOXcXFpb5MTLibjThz5bUMis3woYlJwimN51eUiUKxDOUJlXR2egQpHK23OqQlj
 twKIkuNyLFzCpdMlgdo3hDdmcWDYPv0wduqdvGNs1EHrbA3cP74tRl8qW
X-Gm-Gg: AR+sD139eJqjNSFoFkzPGjarNxv+di/DUpl+fgNpsHm2GEXFUcXTIOecHi3qvxXye5I
 /dl6e3bZN692hnpXUNspbPT1xqEeO9TXm5MUzqc1Ig6qxXjLaBt2p48c3IBjR2NbY7LWcZu1r9p
 VQCcelv1HDUCpjL4Xh9ERUHNo6XAKnocZf5LE3AoJVd/Xc3dVKxOnBaVTa2ZS/pY6JsJp8ZoZLu
 1CVbtPKKs6UWaNWvuoMO73XNKf2cqtf8tI0KyOsBAkyg4PBFnC9YNmfoL8QsC4YXvbiF0UwRdsO
 lvd5GXMcL+3KbctM6uC2xoxTqn2Xp3ht8lI6hzzUYf81iwCZMtmx4z3vFeRW4Kge4Sf2oU6ATWb
 scoh35PTpP+lpEg223LrTE+PMfBk0JQ+hiQ==
X-Received: by 2002:a17:90b:35cc:b0:38e:5ab7:ce9b with SMTP id
 98e67ed59e1d1-3931e2ba863mr6262589a91.21.1786617300499; 
 Thu, 13 Aug 2026 03:35:00 -0700 (PDT)
X-Received: by 2002:a17:90b:35cc:b0:38e:5ab7:ce9b with SMTP id
 98e67ed59e1d1-3931e2ba863mr6262541a91.21.1786617300006; 
 Thu, 13 Aug 2026 03:35:00 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3931ced0781sm2918093a91.11.2026.08.13.03.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 03:34:59 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Cc: Ani Sinha <anisinha@redhat.com>, ani@anisinha.ca, agraf@csgraf.de,
 graf@amazon.com, qemu-devel@nongnu.org, kraxel@redhat.com
Subject: [PATCH v5 04/11] system/memory: add a tracepoint for
 memory_region_finalize
Date: Thu, 13 Aug 2026 16:04:06 +0530
Message-ID: <20260813103425.24474-5-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260813103425.24474-1-anisinha@redhat.com>
References: <20260813103425.24474-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

cosmetic: add a tracepoint to track when memory regions are getting freed.
Useful for debugging and tracking all freed memory regions.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 system/memory.c     | 1 +
 system/trace-events | 1 +
 2 files changed, 2 insertions(+)

diff --git a/system/memory.c b/system/memory.c
index 5fc36708ec..9485ba316f 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1730,6 +1730,7 @@ static void memory_region_finalize(Object *obj)
 {
     MemoryRegion *mr = MEMORY_REGION(obj);
 
+    trace_memory_region_finalize(mr->name);
     /*
      * Each memory region (that can be freed) must have an owner, and it
      * always has the same lifecycle of its owner.  It means when reaching
diff --git a/system/trace-events b/system/trace-events
index 51b4a4679a..0e1a4c5865 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -27,6 +27,7 @@ flatview_new(void *view, void *root) "%p (root %p)"
 flatview_destroy(void *view, void *root) "%p (root %p)"
 flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
 global_dirty_changed(unsigned int bitmask) "bitmask 0x%"PRIx32
+memory_region_finalize(const char* name) "mr %s"
 
 # physmem.c
 address_space_map(void *as, uint64_t addr, uint64_t len, bool is_write, uint32_t attrs) "as:%p addr 0x%"PRIx64":%"PRIx64" write:%d attrs:0x%x"
-- 
2.42.0


