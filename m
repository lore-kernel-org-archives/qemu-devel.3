Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90277D58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyu1-0004El-OV; Mon, 02 Mar 2026 03:45:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyte-0002Fo-C3
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytc-0001dF-KJ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LPDCKeB4WGvMUnywQ5mFOhN5RUcO9TC0SxTRUaIhbWY=;
 b=XPqDbKo7llJlJ2x6KeOzHcwDSi16h3t7Sa/2fyWbrxQ9q4qbsBaBI/DBsXkdRPELeQiNCa
 I65NLqQPBzy9qjwL1bY+iNK3r3WLJdTKdCsCZ2FfgX1GtxIOJi0BbLBBj3s9pU4W/soKgG
 E+t1Q3Wzbff3xYJFHc2To5WYnZsD8Ao=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-HLXtWt9NOmiP44oczB1tOg-1; Mon, 02 Mar 2026 03:44:55 -0500
X-MC-Unique: HLXtWt9NOmiP44oczB1tOg-1
X-Mimecast-MFC-AGG-ID: HLXtWt9NOmiP44oczB1tOg_1772441094
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439af95a718so1175230f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441092; x=1773045892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPDCKeB4WGvMUnywQ5mFOhN5RUcO9TC0SxTRUaIhbWY=;
 b=LaH4bXrQYRi1VIpBMV9aXozKRxJboo4ta6Xbrb6zOzJK5N50JJU5U2pQCHEp8gMylu
 Z3ONjqJtDG2H84uykZs6iKFGkkVYD2ONHzxRyD0rl4nJyjxe0729QEKXWJw5OFK8qzEJ
 Z0lt9QVobZQnMZ1AcqhqF8LKK8EDPq+5asvfV3nQqg9l5rwtmg8sXlLfsztCts6le0p3
 cCwmqMUO5zefkRrRWcIoOXahC4R6qJmk5vPd9rR13S2nDiXCK3KnO/do+LpPIKbsFkaC
 txdYtXxDptduC91QKldGn9k9i44VlmEXxwXgMSzSvD7aZCvTlJQMjiXtA/k7jmqVuHMu
 ixQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441092; x=1773045892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LPDCKeB4WGvMUnywQ5mFOhN5RUcO9TC0SxTRUaIhbWY=;
 b=PuS6sIdyF+AvORKDGRnkGYSKcAeLw/59KmhOYmaYQy8EKnt5W3/ZPMsyWRp6rpLWN0
 yVC6xk5ICe2SI1hKMJtFafQ+CRszwHNAATmAvI3KcDX/i4lO/zrlLUU/sew4t5UKomzC
 NRpMkV5QIDn5xOz550+leM+FTbhKSczTaq8xa5U1VEKGW9TndJvpN9IBJLMeHbxjC0Kq
 ssI7N6rZvHytWQD22K8AFULHDECiha8NOpi2WJ9AtGsJ9Ni3oT5JtQXH6WPnr3hQ5cS0
 M9GNN/lfkvW2lFkcrCAxzB86SbHUw/ZZpxcdZ03tbxnSz422eJ8A74kDhp1tlp5yu3HZ
 Xfmw==
X-Gm-Message-State: AOJu0Yy8HLt5B4mZH2EYmGN0jNu7TSK2L60ngCBzMOTwbPwz2wdqAgmM
 FXlAwPeUzX08asTbXSA/Hmsh8zOvS0GyI8hjGIJ1GVoO12B1QxaRsUpbY1rttveYFmznqr1mvAh
 q1hLWD4z9H8xSkdd9s9sDkD43kcEwyBzt8gpqR90UPu8pV79zg0lYq2tlnfZtDCtxjxiDnS7Inv
 FPrseWFXgkihsdTWKCKybgk/MJ9DMSOaL46cR46LMT
X-Gm-Gg: ATEYQzyi+w9e82v0z8ECt8E9x07WV9vNG1AdnXCr+d81MF2dVYIe4L/EzWYwpAWtceM
 dazIDqqNa2kVcagOy+k2I0tXdZvkaW2KDbFTbRrZNwqjsppSrhPg53e7sSG1e3q4e75MtzBUkdi
 TZazot0r6SJqsbvgr3Ab80JR830scmyCWos7MF8Rd72jqUlkgtwBsGGHGxdWCIaqaP5KgaltV3W
 BeI6sNk6A6YLl6/+04tZSUY01JW44SgBsTbXwydWGI/L9H+876i/H1iiduVNTsbDzS7a4M1GZTG
 RHkanp44gG2IyNS30z4x8R6cqHeNRny7BuGUCp0KUn2btDHDfMvVkUZXZdk+NxLAKX1xiTaJeZ/
 AFZ/MFmVUzvgbPkRWWcfvObWhYFuUzU8lazerkjTFRY5p5/ymkeht3b9Umlj14VinnmKtoq967k
 Yb++4RBAKfw5v3gzZsMlDMrEVxKiY=
X-Received: by 2002:a05:6000:2285:b0:439:b6bd:558d with SMTP id
 ffacd0b85a97d-439b6bd561fmr5439150f8f.30.1772441092188; 
 Mon, 02 Mar 2026 00:44:52 -0800 (PST)
X-Received: by 2002:a05:6000:2285:b0:439:b6bd:558d with SMTP id
 ffacd0b85a97d-439b6bd561fmr5439105f8f.30.1772441091691; 
 Mon, 02 Mar 2026 00:44:51 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b55df68dsm7264919f8f.26.2026.03.02.00.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 027/102] whpx: i386: bump to x2apic
Date: Mon,  2 Mar 2026 09:42:22 +0100
Message-ID: <20260302084338.473368-28-pbonzini@redhat.com>
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260223233950.96076-27-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 0259782a822..d98619facee 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2088,7 +2088,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     if (whpx->kernel_irqchip_allowed && features.LocalApicEmulation &&
         whp_dispatch.WHvSetVirtualProcessorInterruptControllerState2) {
         WHV_X64_LOCAL_APIC_EMULATION_MODE mode =
-            WHvX64LocalApicEmulationModeXApic;
+            WHvX64LocalApicEmulationModeX2Apic;
         hr = whp_dispatch.WHvSetPartitionProperty(
             whpx->partition,
             WHvPartitionPropertyCodeLocalApicEmulationMode,
-- 
2.53.0


