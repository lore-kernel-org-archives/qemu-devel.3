Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF425D25937
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbS8-0006zD-G2; Tue, 27 Jan 2026 00:17:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbS5-0006yK-Nr
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbS4-0008PA-3c
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dYjm+cwYmX//ogmaWGW851MLQ4JMvXhT/HU+YBIFrsE=;
 b=fpK1AqFpSLQ00g5gPihwql3fqLaMbqqUm4mW0cUfCctunNaHx1FTc2vlJbI1usDw/NOxlv
 DzGRitGBMauFRcFuoqBkyxhnVJLjATMixjO7zQrfqCY/t3xRl1p/A/zw7xZuzEOaAFWIll
 IBIm3LTZrSOeglnI8QPPB+XBrsqQINU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-vtyEWKVyN6yIB95ErzlUvQ-1; Tue, 27 Jan 2026 00:17:16 -0500
X-MC-Unique: vtyEWKVyN6yIB95ErzlUvQ-1
X-Mimecast-MFC-AGG-ID: vtyEWKVyN6yIB95ErzlUvQ_1769491036
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-352ec74a925so514395a91.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491036; x=1770095836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dYjm+cwYmX//ogmaWGW851MLQ4JMvXhT/HU+YBIFrsE=;
 b=YUKZw4Hml5Gm82ZngDiR2YQo/hkYDxydMG0gbPfqL5mSCJaFartv2BexhgN2+6NseE
 NflgPbN4NDz1oYQZqr83lyL1gYumAK4p+/T7y42IdpFW+uSY57Y6VlLQYx4M9MbQ1jWm
 8+tJmhj9UNX7jyUbBE/YzFZsn+M6Da6y4rdraarx4G1YmpRjJ1uPDZqikIhpLqnPY8SU
 p3XH50RNTUuOXU8qc1SN6t0NojSR50iGIpdAyhFVoq+UKxjjzXQWO1aFIyuTC7DcnCdZ
 lA9ggXThSdF/6EQOHrC7jxownJDRY+Rpw1hZ6gbYmevzw5vx39OnBsrW98Ym3AZ+NdVa
 aywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491036; x=1770095836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dYjm+cwYmX//ogmaWGW851MLQ4JMvXhT/HU+YBIFrsE=;
 b=jigTFaKQY0ElZAjauf4lpRDnyh1n9QSbm4hVrvxrH+O7F4tsMEEXSYbJxqtXftUx4D
 K36LRpU9iyuNZ8XCWYSKHlHewckRAO3NpQ8AxErxqNDevZUC2j7H2msl6ox+hhqDw6Wb
 Xpoa3f/fuaQKtPckoCvnI9vJhlW6xsX57WpCO/FfzyAKQ5tJTOIFqiFIr4DlJCHP2GxI
 +hOAuL1QiLs6ApkpIOziD/bYLHL/BfVqQQ3kz9ncUnW0H85DrcRO4YSOzMhtP7KMZNNo
 zRd/mNnn5v71TAU2DldgiWeWAhTQp7pF++C3jmTYdF/JPXq7Dv/KQBhRSoBFG0WJc1VV
 fBxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIPyvi9KNmU66IDuDh7PMcENpa04/ptHJcx1r11GBWpkHd8FoK33LTSTS+1ii27+HH6Gvl8y6rrVjK@nongnu.org
X-Gm-Message-State: AOJu0YxKSpfVxa+1SpNuDEN6Xby1ezIcd3E/1oRHgkLSQPrUvmGDY/uI
 IY404vZtsKTB4utGOl/SuteAUW00EbmxDVJq8tkLtwniF57fO6MN+9xDQ7h8k4y3i3cXs/kWllH
 62Q1ZzSmCVovKe03r4Cj+twf4hD5hQMFiq/WumkYkRwellAt8aEuDZwON9gQIC6+a
X-Gm-Gg: AZuq6aL1dIIMGKz8k/XQ4m+woYFWvSsEY2V39fNy5VYOOBonChRcsBJyltV6yvVWgoV
 L3s+DVK3ym8fzrQrshOdxm28SWoVn06ChjO6bdifg7YBRHU69im7v6m9UubrnklXMKZ5ueTcXZa
 T1VBKEt4iXYQtCEFQcfqYZ4UsAUnSm4kni3UQL/kZr4eq3tpRjs8RCui7GTJdTp7zIG8rDc6KwP
 CQb1URwQtJMudn+JrXxuzCutRbi19gHmzLCL8NaIbHv8AkpkZ2ROy1siqiMUFRLtHPX5Ss1Q4ws
 U2BRKrSPyyLgVPithcxSxmFfaLDfqmKctalGQc4HCQLgY7sNVR4auwDNdykIhnZTzTmEChzWgJq
 b71tJiwJcpUBhxz5/8SB0kT1qwPMrydxevdLjMuzsKQ==
X-Received: by 2002:a17:90a:d603:b0:34a:b4a2:f0c8 with SMTP id
 98e67ed59e1d1-353feda7c73mr651963a91.30.1769491035652; 
 Mon, 26 Jan 2026 21:17:15 -0800 (PST)
X-Received: by 2002:a17:90a:d603:b0:34a:b4a2:f0c8 with SMTP id
 98e67ed59e1d1-353feda7c73mr651949a91.30.1769491035342; 
 Mon, 26 Jan 2026 21:17:15 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:17:15 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 13/33] kvm/i386: reload firmware for confidential guest
 reset
Date: Tue, 27 Jan 2026 10:45:41 +0530
Message-ID: <20260127051612.219475-14-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

When IGVM is not being used by the confidential guest, the guest firmware has
to be reloaded explictly again into memory. This is because, the memory into
which the firmware was loaded before reset was encrypted and is thus lost
upon reset. When IGVM is used, it is expected that the IGVM will contain the
guest firmware and the execution of the IGVM directives will set up the guest
firmware memory.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e27ccff7a6..38193ea845 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3282,7 +3282,14 @@ int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s)
 
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


