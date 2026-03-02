Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78629D58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwytI-0001mR-4i; Mon, 02 Mar 2026 03:44:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytA-0001i2-HM
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyt5-0001Xl-Qj
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QmVK0bcekiL2x3ZWRO+xZBQLALeEszgKhFgyBuGGwZU=;
 b=Fp6Xs98WGvSJqhGem1hv0nTAV14SM3TzhO5ftXtqXfgQ/uuJ472teNNByAqgpOpdUS3i+9
 6Amz/hS9f0Z1SIH1+bOLaPe5X13QVGZ1SG3LmS6q6x7Yo7pm9WdKGIHqYEYgKzTPDlhKuw
 SGOlmQvIVcRJ6p5cn2dNvZpfcujvMFU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-HXtylQs9M9K3Z7dRLKpUyg-1; Mon, 02 Mar 2026 03:44:20 -0500
X-MC-Unique: HXtylQs9M9K3Z7dRLKpUyg-1
X-Mimecast-MFC-AGG-ID: HXtylQs9M9K3Z7dRLKpUyg_1772441060
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4837a718f41so23623265e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441059; x=1773045859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QmVK0bcekiL2x3ZWRO+xZBQLALeEszgKhFgyBuGGwZU=;
 b=bUAGR4GqO+l5iisnd5S7KEvyBOT7yc+ubKEjzuhzEgkVCI+nSHxnyBR9hO1vHlBnxq
 NtE7SZzUZWgrbMCjFErLQ3GgFG1GNg+4lFJVu/7efpKh5jcgDyrUjN7mGUFf6JXHujcy
 P6GlAS4yT9dfQU1o7mrJhUv5ONMCqhTDHzMc6VMwoqWPgZftDVolxF26I7ASBAHjGioU
 9KszrNMcevoLllylcDVMQRjJFoBnIRzvN7kElp4vLc9ZApM8xooIhewvjZjF//m0cp8P
 38BGg5JxYd036RUBbO+PkPJ2PWp0SDLRcpN4BIc9VcfLNwRPv37+EsZBu7QGmtOOZcR8
 4//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441059; x=1773045859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QmVK0bcekiL2x3ZWRO+xZBQLALeEszgKhFgyBuGGwZU=;
 b=Wu4Nv+VXlANNpeczM7f+GtmdX76Khb27Ugpxsmg7TSdx8AU+w8EcAvBgi71M9yz3Tp
 veI5RSdm+CTgrpoJxBhU0gCc4fLGRMkwiXTeLgituz3Y/K6auFcVB2gwJ35F1LmaT0XQ
 /nJvWa7H7piFvMdxQx6r2pf8foDeIUKsqM5CJrpW5ddOVjFvRbWlEbN0glIkQSdHZQPF
 BCk0i7TYuAOV5oCXVNZDrtztg6mverjp4a7JtkhB3eBZR/xG9Vih9n3XVLFmcPw955K1
 pJzOe+8i3+1CbWYg0vDAwDSRO5MCdQKPoOtwiJRR8EXu4HZfqUvkMmuP5vmApcFg28aU
 VoYw==
X-Gm-Message-State: AOJu0Yyye2peL7GCzg3lryzATh1irNoYPIZSUvlP2MTus27jtDvY6sUQ
 0ffdjlBfaPutYt+B2MbQUztxPDLs1MHcsCEadaWacEzZ6vwDeHNMZK5+9QzYLT8hY/umBfJeqcL
 DhWoboq8MPXyygvhV4v9iM2qxeKVwfun31cn1n/7SWiN3dW7W1CukPPEXidrMsUalS0kPlTCihG
 sQuc0TUJYhwrKJo5iMBlE4uwJ6HnYeagSDOejBo70P
X-Gm-Gg: ATEYQzw2FTzx4aE4Mx40i6a+6ynsp8LiXmCCWS/QaMOKir/jN9F3LBmOp7sL2sHFt8m
 uZvEiSAUw84ceqURhCIclmZsN6XhsimdI57VTAZVs2A387W6JgNkBdWrR0PsZvG40lpLsKLTk5U
 qeFH2+Xcb3wbEj8SD6yXFOA/uK0ejJe147YIU0IWeAwVmE4UXDPK99V8jJNlAaQFjoYLSGXDysJ
 eKW6O1NJBnvdaD+FZ9zldx4Q1He+8sfv4OqbDoSLEhmV0vPz2dPpcO1Tv5/9Sh76IzV9KkuzLoS
 cuZoHq+76dKZVAvBYYFUOJvscvNGwg4WUsfKX2ZhW5tRpRTWLmcMnruvvO9yigYgIMXAEcH5cxi
 3oc76K7TDWFELtANldyqxg2dT7gXiS7vmff2WH+BoZtpUnNauCD4uNqLLE0RfeH7H2i6DuhwDnk
 XXd5mD3a79/J7jsTKmXSXeS92K+to=
X-Received: by 2002:a05:600c:3e8e:b0:47a:8cce:2940 with SMTP id
 5b1f17b1804b1-483c9ba2922mr212596305e9.14.1772441058551; 
 Mon, 02 Mar 2026 00:44:18 -0800 (PST)
X-Received: by 2002:a05:600c:3e8e:b0:47a:8cce:2940 with SMTP id
 5b1f17b1804b1-483c9ba2922mr212595965e9.14.1772441058037; 
 Mon, 02 Mar 2026 00:44:18 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f2f88sm378175255e9.2.2026.03.02.00.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 014/102] whpx: i386: remove messages
Date: Mon,  2 Mar 2026 09:42:09 +0100
Message-ID: <20260302084338.473368-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Remove some messages printed by the WHPX backend that don't
have an equivalent elsewhere and don't convey an error.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20260223233950.96076-14-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 05248850530..2f2c613eda0 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2163,7 +2163,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         whp_dispatch.WHvSetVirtualProcessorInterruptControllerState2) {
         WHV_X64_LOCAL_APIC_EMULATION_MODE mode =
             WHvX64LocalApicEmulationModeXApic;
-        printf("WHPX: setting APIC emulation mode in the hypervisor\n");
         hr = whp_dispatch.WHvSetPartitionProperty(
             whpx->partition,
             WHvPartitionPropertyCodeLocalApicEmulationMode,
@@ -2237,7 +2236,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     whpx_memory_init();
     whpx_init_emu();
 
-    printf("Windows Hypervisor Platform accelerator is operational\n");
     return 0;
 
 error:
-- 
2.53.0


