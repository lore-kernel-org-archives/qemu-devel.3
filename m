Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C36D58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvj-0008Vc-9e; Mon, 02 Mar 2026 03:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyuq-0005OA-Vg
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyup-0001yT-3L
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f6cNwZnhJx1VcdrBJs0C0lpGvsSbYS0DjVCzqGMIKXM=;
 b=BHuaFBHvfArO2UJ/NmymXciN2tV7+ALU9P4Opimu0NZRwcEgab21ZNKT1rKKUFYQfUbhpu
 LjKXPFblZTFIAMpEpqNrZH8sYauzbsBYchld7waSRWOfazqNPTZHt5EfbLmjZHE11tgj59
 hYlB8ZjmmJzbmqIkFHVTudf1Ie0Mc24=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-AwfCWtgPMoSoiTnkn_U7iQ-1; Mon, 02 Mar 2026 03:46:09 -0500
X-MC-Unique: AwfCWtgPMoSoiTnkn_U7iQ-1
X-Mimecast-MFC-AGG-ID: AwfCWtgPMoSoiTnkn_U7iQ_1772441168
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-483786a09b1so41294305e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441167; x=1773045967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6cNwZnhJx1VcdrBJs0C0lpGvsSbYS0DjVCzqGMIKXM=;
 b=E6g3a8k2OLco6T1nzGLXzxEIexQNsnowAtSqLoZ7TwDWEg+VbymNiv5CM1sV6Y7Osy
 xUlLXBDrxuRFWpR4cO2nVwJusn83orczfoRefACgd1fNyYCkIcBmt5HfEfPx76Ne29O/
 VpG430Z5/5oNFSuQrAFZEREqRkq5LGJ+fwto+cCFUez0fNLhzDkWvvo3PEHEivQFTVR5
 h3ey93WK82YYjDc0Jhd/kyLbLuftLFmL0hMK5GRR3JWP0nNISBWJUK5b6/xsDMeSn+cU
 ojy8rK+NeYxagbcoxyKUH4RNv59bZnOaxCs/R784DmkTxbhsnxuDrfqTvZ9W0FGGBHiy
 UPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441167; x=1773045967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f6cNwZnhJx1VcdrBJs0C0lpGvsSbYS0DjVCzqGMIKXM=;
 b=GxozOZKUZjbPEbF0Ld5yr8SK//qVqd31Byo4TBS7GnccaIFXPPrz0O6oxWUp2sHO0k
 Uu8EiY5iGnZsJlc1nq8pGQOkq7lsCuxIQQmRI093z32C6Vt4XN20dtRg68nvwFmzkVez
 riazOGP2rsNKbNkK+GO9hlwbEA30MjPUk5kbCC2Z4tnTu3UWgBI0OvD66tPHBQ6fKjqM
 0xWi9pXGq/fK2CpDcXV1f+FuXXJx0INkkrSfcU6npW5XsRvJxA1uOPvnzJVKLBzZft9n
 OhDAA2XxJS4BCi56Ymd8FB3sTlkjPO4AYpNFImWOqdcGVKzy4taTfJa1Acb3NwUQIA45
 sU4w==
X-Gm-Message-State: AOJu0YymjzmdDdxqUaMdZ9d9safmSws1uwE7rtKz0wYFtfoJGvQaRrHg
 Bea1gZ+aMqbQHBe7QceyTltr4jssHFkFrk96mam3eupVXCf9tlNOeq5+c9wXNQuPgPkbU0GO7kx
 INydjXCJKKcHqYIrMZiIaCDXZdEz6F5BaUK8Qc04ply8IW95F1lc7Eo9dF28JFVkID8Htori8Sj
 WPhsC7Sa8wGa7hGuH9kX9mxW5i69IyHZCEdRxmdVyU
X-Gm-Gg: ATEYQzyrsvphLRzDZyqf1b/YfUzSvuOta1vhkbG1lwADlLnOpY6lAF5T8oa2dm6R18w
 93AYY3/zQnrcayH3rDuFvFCcCcvKmsp8k4sPtDRR8zMaRxZEjxHv2wFjnAMPvkiBk1LixeJbabB
 7q3kI+2ogccI8bHbs2XrCPd4wQEy/8QFdAnBS5pEtcBFi1Ug7oAJxGhFBKG42W+RXd0RrJkaNIY
 fTVJGVuHFZpLIKiOJqEQZDsKbRjLydOBwnjoKwjjQ2xUXOqpxB15uFSB50YXVBY8+jCL1fukdNX
 CI+JX7klpsVsjhD2dWGZzoJT6y7nJpEkwwrXeFtOj5PF2OGA4OKBxtHy28IJ/9mLH74/EwXyjZY
 zzgtnQBKcpRpHTlgV4xqOFqStJyb3EwYk10uX81YRXerl592Z5AK/wtHfEWKfLPEBhLby5naVZD
 1qMSNhhDjkxEY5NLmgMp8cM/E6XrY=
X-Received: by 2002:a05:600c:8108:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-483c9c0baf4mr189616025e9.28.1772441167264; 
 Mon, 02 Mar 2026 00:46:07 -0800 (PST)
X-Received: by 2002:a05:600c:8108:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-483c9c0baf4mr189615325e9.28.1772441166524; 
 Mon, 02 Mar 2026 00:46:06 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b4a121sm265288555e9.8.2026.03.02.00.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:46:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 055/102] kvm/i386: reload firmware for confidential guest reset
Date: Mon,  2 Mar 2026 09:42:50 +0100
Message-ID: <20260302084338.473368-56-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Ani Sinha <anisinha@redhat.com>

When IGVM is not being used by the confidential guest, the guest firmware has
to be reloaded explicitly again into memory. This is because, the memory into
which the firmware was loaded before reset was encrypted and is thus lost
upon reset. When IGVM is used, it is expected that the IGVM will contain the
guest firmware and the execution of the IGVM directives will set up the guest
firmware memory.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-15-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index cc98cc961b7..9d7a9ffceb8 100644
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
2.53.0


