Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C118F55452
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5vS-00081U-T7; Tue, 24 Feb 2026 22:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vQ-0007uR-Si
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vP-00088t-AK
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtPGtZmrmBLpOcF7mZMrBE1yp80mmA78e975dk/A+AM=;
 b=FCAtVwHsK2W3iT7SISc93hDvJ5bkDlBllwYsXcTc4DCrHcXhuuRvg7KvTmVpBkj0tW1PG+
 RaZBgvv19VmW+BGFu9xG0ewi0po6RTwbX/JbawMN6eGm19zD66IiBY+kfl3lMdT2WOUJX4
 7PcI07XtVF7+PSbM3gjSuD5FQYYGn1w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-UcW05EwuOnqFk2FOwhQPvg-1; Tue, 24 Feb 2026 22:50:56 -0500
X-MC-Unique: UcW05EwuOnqFk2FOwhQPvg-1
X-Mimecast-MFC-AGG-ID: UcW05EwuOnqFk2FOwhQPvg_1771991456
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3545b891dd1so36172779a91.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991456; x=1772596256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xtPGtZmrmBLpOcF7mZMrBE1yp80mmA78e975dk/A+AM=;
 b=AlGbmizHuhmAQ3nQ7ijNmNz9dce/jO2Nf4hAcNQUxi+x/3YVqwH1hnQ8dQkNVYeGpZ
 w2WhDcq9U2I4vamF9+2lSv6ujKTtmDnF44KHv4rZInc5Cm/Bpq8ifShS4lgdMTYtVUHV
 qD7jKI+Dz7caJ5jABngH2UapXauHj9a2ssb98keoHK+f+IO1sVh0UAt3eSOghnryGWdj
 s51pdmym0G5DN0e1wsldcALZrM36QtTPt+HCG08DJwy6F4e77UndTAKVZeoH/6F6aOo8
 5HViDQ09EH6fdseor8WjaXAtIowsulT0X/JuLDZ3ovEwj4TUZLe2ugXZCtHcfbzX8P63
 NBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991456; x=1772596256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xtPGtZmrmBLpOcF7mZMrBE1yp80mmA78e975dk/A+AM=;
 b=PVnjmlDiVdXBHCu3Owg59Lu22VgcsC9gooa6Sqe70sPLzp0BAFYllfrE57+faZ8klk
 LJEGUaKzOa5+yIZMltqGHQ9f3liOqzBbWeHESZS1TbDRVIuRj075B5q/WKRt4jOba+IK
 eLI5JxHXRLFzawSmArW2ZmWmoMhKtrhh/ipTyOyt2PfB0UYXRJ6myrgh/tpQg9R7ZFTg
 cQstOSB83nPZHhWpT+ysU1+y6ZX/USJIZwJ+B5yT8YvSQrO0Y10Z8LDuned9AUxskpYW
 Hr08NoRexb94euVsf93ox8rH2E55ziTrO/7rAyUtIfG4KOxN8/l6oGbSIcWaYkrv1gkh
 8cLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvglm7bHeIwBxMvc5yUN2ZPuJKNMGlpynya1lnB7bOluUumU0EFVldAAE1pRxzebtnL9bdj2F/hwC1@nongnu.org
X-Gm-Message-State: AOJu0Yxm7tYJyi37J/M6B0GsVIMhSJ5DcFtcYasqDBylH65D+ljkp91s
 soeitY1novBqNaec9uv8jobNsw9Olio1TIVGGl8L/bCU0vm1bdbCFTIacRr7lBPV98Sl2OkK9uF
 zYsrtge5coOR0erjQ2cjByEtbthP6sGu45ur6kZN757UDYbALsheLhqJK
X-Gm-Gg: ATEYQzzxjqO5JtcIm9NGnAuSXJP5bDtfineZPCu9OD+ZmbkBXmRkdp2r7oRu4xxjtCT
 knBe0c/sZ6f9l6qCQCb8wiyBBM0yZH3Jfh7EQBTtOh0Sd32ogE9Bb640a0K5XPf7Zy8kAN4st+W
 LH2/MIMvU7JTsWhS+A+Nzps68ym4P5oL4euDQEpo++Jvn6eF7luSl43rIYCddtukw15ECv5lw3O
 BWXYl8tRbPw5jSqZsQDFImWp2xcaAitojT2YnxpzfeeG7veeoQvdZYVtJSbmu+J2tfyZEB3xxhG
 RPKCM7cnVS/5M3X9niR1y95rNG33ysKh11jdD1EdFSnw/KT7msZQx1LL0X9Ug/noohIzNe+siCT
 3O6QRHCwBtkyi8y3YpCfM0dnVnIK9yGoQoT88ujkAezoOakjpytLfZ6M=
X-Received: by 2002:a17:90b:1dc8:b0:354:a608:30a2 with SMTP id
 98e67ed59e1d1-358aea0818bmr12144525a91.35.1771991455854; 
 Tue, 24 Feb 2026 19:50:55 -0800 (PST)
X-Received: by 2002:a17:90b:1dc8:b0:354:a608:30a2 with SMTP id
 98e67ed59e1d1-358aea0818bmr12144513a91.35.1771991455495; 
 Tue, 24 Feb 2026 19:50:55 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:50:55 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v6 14/35] kvm/i386: reload firmware for confidential guest
 reset
Date: Wed, 25 Feb 2026 09:19:19 +0530
Message-ID: <20260225035000.385950-15-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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

When IGVM is not being used by the confidential guest, the guest firmware has
to be reloaded explicitly again into memory. This is because, the memory into
which the firmware was loaded before reset was encrypted and is thus lost
upon reset. When IGVM is used, it is expected that the IGVM will contain the
guest firmware and the execution of the IGVM directives will set up the guest
firmware memory.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index feb3f3cf3c..5c8ec77212 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3416,7 +3416,14 @@ int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s)
 
     if (object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
         X86MachineState *x86ms = X86_MACHINE(ms);
-
+        /*
+         * For confidential guests, reload bios ROM if IGVM is not specified.
+         * If an IGVM file is specified then the firmware must be provided
+         * in the IGVM file.
+         */
+        if (ms->cgs && !x86ms->igvm) {
+                x86_bios_rom_reload(x86ms);
+        }
         if (x86_machine_is_smm_enabled(x86ms)) {
             memory_listener_register(&smram_listener.listener,
                                      &smram_address_space);
-- 
2.42.0


