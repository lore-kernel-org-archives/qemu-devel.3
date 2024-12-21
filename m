Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF99E7718B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 19:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tP53s-0002UX-KB; Sat, 21 Dec 2024 14:22:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53q-0002S8-IW
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53p-0000NR-93
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734808968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wtsh1Lk6xlukF3B5MU4Com6s9MZP8UnYV3hnvMy+hsA=;
 b=DtxnKXvkc8GivXtPOK0o0hlsOX2cBzf24GCwjOP5OIehvY0Mvj1hHtB2eaou5mcaXkTMRV
 2/pvRr+zjuPGZioO1z/jTq+jZmo5+uJ/CukIfCh6Z+aSLzuZFykMcux7mWpwx1DNcoT81N
 83V+IfsbPIE20DWIMqcmHOxobaM+OsM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-i48WpF3wMzqKxLbjz589Ew-1; Sat, 21 Dec 2024 14:22:47 -0500
X-MC-Unique: i48WpF3wMzqKxLbjz589Ew-1
X-Mimecast-MFC-AGG-ID: i48WpF3wMzqKxLbjz589Ew
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43631d8d9c7so15640075e9.1
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2024 11:22:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734808966; x=1735413766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wtsh1Lk6xlukF3B5MU4Com6s9MZP8UnYV3hnvMy+hsA=;
 b=dEfjCaMmXB69pEAxgv9OVQ311jotFvXJgRjBGaj4H28QrYnqeGAs4X2nRdevlRs5GW
 +BprGjgjEuJA1wF8DclY1xXWaELKZksk52KtfcVW/jcJdeuCpmIKX7u+EcvPQXNsBFJ4
 FZODDzSpDVIH8g3Yo/wAURumEE5BgZLNnB9Cg0Lxgbd24wG5SU1u8Newgk711JEMHAQL
 lS4DYBd8J/b6HHZ90FaieqwRNubc+Rdq5Wmtw+dcAjcjzTFE0IZ7xajnL4j83hhOB36m
 j1IOP+Osz5B+4dvg6Fi9KyR1dFQG1OBxVZzIDgWI8qr5VebOP/tx9HeXKP6RWnpljjId
 He+w==
X-Gm-Message-State: AOJu0YzO54WU21Esk8WyZpKwXVK8dnd2tXXx4A0iaVky1WGyrkIt15uU
 jANLL8gwhVlGojuGT66VcCN152JcVTwHf7bLr1yVciGFN6bVAE/BpTu3iwln3R/fYfh/XLl50qY
 UrU6hGdW1O8tJy9LiXXgRmbM5OC1Zs49+V2hKz7c3xBMMzmvqfVz9uhQMaT+ecAkOiX1x5KAa2C
 njunNU5K+AdX63nHYHwirVaioYaGqD2qRF
X-Gm-Gg: ASbGnctmTx7ga2FETQlQd26LhOFHGsaJxu+kJBom4Kmnuwk9TWM5RFQl6yCFF/beEuk
 yFk9jJuT20wZbTT/S0aMZLC7uzDACFAgb+9X7uHOwsx3Td97/MwFlqTmAsji8B2jpjKN8tPhsrA
 inpOWARJMAYZci2ncYt8lGuDphFpGV+aHKGWZdYFezg1R82SfxKWSaNSKb1t1wf5PYp+u5zYwle
 oSxtu1A/QFmGqxRif97eb33fj40JqH795ZB/Cuj0mLjCMZ4pqzXVCpkkXkYqPYO2v37hXek2Zl2
 zNHKCjtxIGv8pP3uFCek6W0HgmeanFPyDXvS8H0=
X-Received: by 2002:a05:600c:511d:b0:434:fddf:5c06 with SMTP id
 5b1f17b1804b1-436696fec16mr60719385e9.1.1734808966061; 
 Sat, 21 Dec 2024 11:22:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsXV0vVQZtpcEDflA6tQt3C+bMLIGzpWK2kwajZvSGvGtjAKxNP+I6szI3oWIzdbLU3iH3cA==
X-Received: by 2002:a05:600c:511d:b0:434:fddf:5c06 with SMTP id
 5b1f17b1804b1-436696fec16mr60719235e9.1.1734808965746; 
 Sat, 21 Dec 2024 11:22:45 -0800 (PST)
Received: from localhost
 (p200300cbc7137800820d0e9f08ce52bd.dip0.t-ipconnect.de.
 [2003:cb:c713:7800:820d:e9f:8ce:52bd])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4364b053e91sm151842665e9.1.2024.12.21.11.22.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Dec 2024 11:22:44 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL v2 12/15] s390x/pv: prepare for memory devices
Date: Sat, 21 Dec 2024 20:22:06 +0100
Message-ID: <20241221192209.3979595-13-david@redhat.com>
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

Let's avoid checking for the maxram_size, and instead rely on the memory
limit determined in s390_memory_init(), that might be larger than
maxram_size, for example due to alignment purposes.

This check now correctly mimics what the kernel will check in
kvm_s390_pv_set_aside(), whereby a VM <= 2 GiB VM would end up using
a segment type ASCE.

Message-ID: <20241219144115.2820241-12-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/kvm/pv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
index 424cce75ca..fa66607e7b 100644
--- a/target/s390x/kvm/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -133,7 +133,7 @@ bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms)
      * If the feature is not present or if the VM is not larger than 2 GiB,
      * KVM_PV_ASYNC_CLEANUP_PREPARE fill fail; no point in attempting it.
      */
-    if ((MACHINE(ms)->ram_size <= 2 * GiB) ||
+    if (s390_get_memory_limit(ms) <= 2 * GiB ||
         !kvm_check_extension(kvm_state, KVM_CAP_S390_PROTECTED_ASYNC_DISABLE)) {
         return false;
     }
-- 
2.47.1


