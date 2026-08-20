Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800E3C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5yx-0004kr-NR; Thu, 20 Aug 2026 12:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5ys-0004QF-RT
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yr-0005Zx-A9
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7ZOH4e5SxXfRZPj4efImhABWGIHj7z2g5n4rrqx8hk=;
 b=i6XL1i6jHxHc308lbwl1t1MXqJDTPlJwUoX2AvXY3mzLd+d4zCGmuxFdeHomu3AgS+2S6o
 mxuonR2XD1LUR9fH3PVA4W4W8jOSvFETvSPER12dsAuPjHjg03J/JOO7B0+7nMedO6dy3u
 u5QrH8ACMhy72cHVS2Nsa+6iTwcwItA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-WxoNXjk-PXaHvRcQ3ZN0AA-1; Thu, 20 Aug 2026 12:51:02 -0400
X-MC-Unique: WxoNXjk-PXaHvRcQ3ZN0AA-1
X-Mimecast-MFC-AGG-ID: WxoNXjk-PXaHvRcQ3ZN0AA_1787244662
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f2de3ba47so81410f8f.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244661; x=1787849461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q7ZOH4e5SxXfRZPj4efImhABWGIHj7z2g5n4rrqx8hk=;
 b=N49doS5P9jFbA8DcZ//6bNiLpLy6UmEUJACqWo1t2A1pn78m+2HL/NYDSANjcO3wYM
 R2GuFCfQ9zPRbVMbIhQYwRlgB/SZ79SH/oCbBDTpxxxoqr+nlf3fkaBu7Vz2H69Ll6uE
 bpgbxxZAu1hSmKcXi5uSUaC2yR4UzlfPwB59fVsFFlf/nGSbexqCykWT/MYV8n9uJYa5
 38QMsVIkhLn+T/ZZm4hF7qvpxsxBqOtvFFVDUyA/jGlqZuchfIw/vMC9eXRX0xWIilii
 4K6fUgn2VpkqMp/VjErBPgAt6mGsG18F3tkmTN643uthFYF6zbh7ccMk5ymdF/z1Mhcm
 hNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244661; x=1787849461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q7ZOH4e5SxXfRZPj4efImhABWGIHj7z2g5n4rrqx8hk=;
 b=GUis/UFWxu9NgZoKX0rmefTkl5PC56fFfotIAzK9aX0q6G0ji8SqMNkr0nDZYWWKbL
 83aKXENtRsyTfBm2Aq4IABfYJpATbFSAWPLBGTKUteDF3LAbuoS4zcZVU8oAh+A6z5/Z
 IY0GhFhQL2EkEAJSNJgBQzBs/C/1M1kG6FoyeoG06hplJnses7nHDuUFYNdBEul4yeST
 JFr8l0W1RXGC9sYpE5Gav11h6obFChZu4QsyIn6qnTvd6zsz1aS06UyTrxcueE0HrC2C
 eqq3GhBUE/I+FVqvWrPJd4aQX8klpaXC92J97l6ZCRJSFUIuEOBNW67DYqViayM9Anpd
 Z5Gg==
X-Gm-Message-State: AOJu0YxdCKbPYc4BYwd/iZNFawhLzw50V0cEoJZvEFaBK8jxQZep+iMQ
 1GLtP6eGId9y1W4HhjiHcMIkLFBuFnJr1Nc3MWjcBG8X8hVodppaMlkfByOTVhWKjhQzIXY1pOr
 j6EeKPlscne2cZCE2knhL7+qS6b3lRzAPwjXyiXbcXdUvJ8bu9rMa56S5uCLhZFFUdfGqoD9eXT
 hpJobH9IR1SFIU1uT6tRGUXcj+7rbySxU0L+wQaLjh
X-Gm-Gg: AR+sD12Gr1g5n88jteBQS+t+aVvFBQ/L7eHL6zhK3m3Uxm46D84k4EOvkFPDKcVizDM
 Oq4Ny7pkoGQ7WUX9KqecUUtORGcj+FIPsGoyC5SNOqlGkD8nF9YvIE/GlL5dChcZDNXfVULZ33O
 qHbIyb0ahDb+2CNesfEPn2o32hfbMAJrrCkivHKSScqDTXmraE4h6SD+F6GXwJ7fSX+pEmGAMJj
 VW3TqBIemOzkJf+eKpnFTDV6ytm+rVJfUW8AJlBpskXeXYVocZy6qTy0xnfDfurTBJzQPCt+iKc
 q2tQRPdxm437GLdVj4kSGxgdcAehd7tye0OgvItE9JjVsjJW3i6o93lLukx63Z2UF0ctAp5qvya
 Ro8ttQgbAdGlmA67qQ9tn+FnmvU/iNah55X1V+144bW620nDYLN5pH0k4UpmLbiEhidqfw5S33i
 BZpWA=
X-Received: by 2002:a05:600c:6211:b0:495:4d88:e630 with SMTP id
 5b1f17b1804b1-499b8465f7dmr3147695e9.10.1787244661411; 
 Thu, 20 Aug 2026 09:51:01 -0700 (PDT)
X-Received: by 2002:a05:600c:6211:b0:495:4d88:e630 with SMTP id
 5b1f17b1804b1-499b8465f7dmr3146545e9.10.1787244660893; 
 Thu, 20 Aug 2026 09:51:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b19dba34sm78779945e9.9.2026.08.20.09.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Naveen N Rao (AMD)" <naveen@kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PULL 21/53] target/i386: SEV: Ensure SEV features are only set
 through qemu cli or IGVM
Date: Thu, 20 Aug 2026 18:49:24 +0200
Message-ID: <20260820164957.1895963-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: "Naveen N Rao (AMD)" <naveen@kernel.org>

In preparation for qemu being able to set SEV features through the cli,
add a check to ensure that SEV features are not also set if using IGVM
files.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
Link: https://lore.kernel.org/r/6939de99f13d7170af68b74e711eb9f03f32f682.1779281646.git.naveen@kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 7b03f534b10..093d29e7613 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1904,6 +1904,16 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
          * as SEV_STATE_UNINIT.
          */
         if (x86machine->igvm) {
+            /*
+             * Test only the user-set SEV features by masking out
+             * SVM_SEV_FEAT_SNP_ACTIVE which is set by default.
+             */
+            if (sev_common->sev_features & ~SVM_SEV_FEAT_SNP_ACTIVE) {
+                error_setg(errp,
+                           "%s: SEV features can't be specified when using IGVM files",
+                           __func__);
+                return -1;
+            }
             if (IGVM_CFG_GET_CLASS(x86machine->igvm)
                     ->process(x86machine->igvm, machine, true, errp) == -1) {
                 return -1;
-- 
2.55.0


