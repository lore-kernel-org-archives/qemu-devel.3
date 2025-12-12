Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5269FD4922D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4i3-0002WD-W2; Fri, 12 Dec 2025 10:05:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4hl-0002Dv-KE
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4hj-00062R-Vd
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=moaOxubZcgOMwtmXzfQMaVBqmlmt2o6MG1/+E7uthig=;
 b=YK9zvfmYY5E4hb7YXrZjAzfMYEHrr0y83PngWecn4vid2/il9gBiF6r1nsGdQk9WWgaYOz
 MX5u1WJa0z1WHtdHqqbKt/IYsT3wQI/m7b9bFYkZ6PRPEo4Eb+K5gNvuOX05PI9o6MEAHN
 hlCou588c2m5dWeNxxYaakdYG67yWk8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-DvnSD0alMV6PyOhhL2we3A-1; Fri, 12 Dec 2025 10:05:10 -0500
X-MC-Unique: DvnSD0alMV6PyOhhL2we3A-1
X-Mimecast-MFC-AGG-ID: DvnSD0alMV6PyOhhL2we3A_1765551909
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-29f177f4d02so18928025ad.2
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551909; x=1766156709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=moaOxubZcgOMwtmXzfQMaVBqmlmt2o6MG1/+E7uthig=;
 b=kO4W66qrng7pEfQFhvKaHOElzx99befEcejpFoDbAAu6dRBdIb6K99op27GQ0CJiVv
 EiBzXB588vdILMV15/S2OgkiWFlD8SUddRq3jv2w95N56AUH1uypO7QpywC3TcySZu0D
 H2e0KQuMyLeoqsRq1M8QkeBr/yv3AAQpP7DkSkrOp3kS28AbFzmP4ATLzAwlXKx+Qmq5
 6TMiulQaPye3TJUSnMdUZG7hTM61O0Qo4mcv8mfgFBurQIt+OS8/NJNMOXs/CSiZUaaG
 lzflgF+zyUm/KqiPdonD+ZA8+3jyxr7fuh9ijOpffr3PKh6oM5DdTITP9SkS0svdt5wG
 IyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551909; x=1766156709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=moaOxubZcgOMwtmXzfQMaVBqmlmt2o6MG1/+E7uthig=;
 b=GEEoMvNN8iZseyqbkqZEVh2+i3fzCfKBWZXW1A/SRCi6IWjhSx5EJJiPlPTPK3gXDJ
 jUX+edtrwqpenqMJUUFtV5fc2qI8/txl9dVXnwuhGR1xNDxqMyBbjp+PfBKe1NbpZBZK
 27a7ery/OH6piTnLhF/5WKlmItwr1B4FKUJqLXDtDB1aaTKzbX5wYQjDeZrEUMMfcbSB
 zu3rWp2Fdd+1cQrVMeNkqn9ytmxwfF2IS7ygexGS69+DRiXGUn9eDH/+1qdHwkblqhtu
 cH3hG4q8SrhjvuEGB63oPxMEPLPT9zkH2GjPqbdq8174YTzhs2ZILbpMYWg6JSeAJ0/p
 sPgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUax9emD+beih8cK2dhJAhxCjtHcPYPY7PE2pI51Rpz5SXT2wfYwVkei1XYoMs9u98rbHNQLwxAs4es@nongnu.org
X-Gm-Message-State: AOJu0YzbTf54HwLRLvziNvnLHS3zcUinx+ftMh1mo2LqcSIIMVuS7N4w
 jnrNs0AyfD0uPJgrmi4roWd72dB1rO+eVBI72DU2FDmQqIHcoazMgWEp5X9Pj8xwGEH0ivZArI4
 kpfrZF4dxfPwoWOpJt71nBf4OIsP+Jg3A1Sb5XMNELKc/VhMCJ5/uVxPo
X-Gm-Gg: AY/fxX43qNtwnyEpsg7TTLSkb96l5AubGO8csJXhn7dfgG5Fx1C85Fi116Ixh3ecBJI
 ev+FRHrDKVCkVNG1jGWr65tdxKCuwwcByAZaD3yZTnp5A39OF6F2kVp7GomNzgeHxmpJgG6XsKh
 tmwBWjLiSKYmFkCkzg4g1lrq2u71QoP4cajhcrKO5sYPRVLjoLrVFqDpMR7442mBbLYHbhg09Hh
 PMJAYfoJPChhvObanczS/7kH5/nx1sj2PD1ktQIujGzRZrOCWtG77do9AcnbGbmgXJtyghmntSL
 92YL5Y9S4JeGzV+qysNwmpmIxJ3YHlZQ1MfOrhhv4qTnhVUqq7xWGD4UPf+IBhLvwbA08iUdVPR
 hQ8E9/9nqZ4nRSFGMaEW1vmXivhg79Hbm4DDcGh5Bm78=
X-Received: by 2002:a17:902:ef46:b0:294:f711:baa with SMTP id
 d9443c01a7336-29f23b13d60mr27391345ad.2.1765551909052; 
 Fri, 12 Dec 2025 07:05:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHC3l5KfoTIzBOvCIgz4vOJbuTkx8ffSsBoioMNy7dyeW+kG8f/r8DTTvFFJOZadKbmgFTs8Q==
X-Received: by 2002:a17:902:ef46:b0:294:f711:baa with SMTP id
 d9443c01a7336-29f23b13d60mr27390725ad.2.1765551908487; 
 Fri, 12 Dec 2025 07:05:08 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:05:08 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v1 14/28] i386/tdx: add a pre-vmfd change notifier to reset
 tdx state
Date: Fri, 12 Dec 2025 20:33:42 +0530
Message-ID: <20251212150359.548787-15-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251212150359.548787-1-anisinha@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

During reset, when the VM file descriptor is changed, the TDX state needs to be
re-initialized. A pre-VMFD notifier callback is implemented to reset the old
state and free memory before the new state is initialized post VM-fd change.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/tdx.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 1903cc2132..b6fac162bd 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -403,6 +403,32 @@ static void tdx_handle_reset(Object *obj, ResetType type)
     tdx_finalize_vm(NULL, NULL);
 }
 
+/* TDX guest reset will require us to reinitialize some of tdx guest state. */
+static int set_tdx_vm_uninitialized(NotifierWithReturn *notifier,
+                                    void *data, Error** errp)
+{
+    TdxFirmware *fw = &tdx_guest->tdvf;
+
+    if (tdx_guest->initialized) {
+        tdx_guest->initialized = false;
+    }
+
+    g_free(tdx_guest->ram_entries);
+
+    /*
+     * the firmware entries will be parsed again, see
+     * x86_firmware_configure() -> tdx_parse_tdvf()
+     */
+    fw->entries = 0;
+    g_free(fw->entries);
+
+    return 0;
+}
+
+static NotifierWithReturn tdx_vmfd_pre_change_notifier = {
+    .notify = set_tdx_vm_uninitialized,
+};
+
 static Notifier tdx_machine_done_notify = {
     .notify = tdx_finalize_vm,
 };
@@ -753,6 +779,7 @@ static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 
     if (!notifier_added) {
         qemu_add_machine_init_done_notifier(&tdx_machine_done_notify);
+        kvm_vmfd_add_pre_change_notifier(&tdx_vmfd_pre_change_notifier);
         notifier_added = true;
     }
     tdx_guest = tdx;
-- 
2.42.0


