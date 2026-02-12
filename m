Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A948EE3691
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvL-0005t2-5W; Thu, 12 Feb 2026 09:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXv1-0005OZ-VO
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXuz-0006AO-RI
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1pZJeSsRKhhmEscgZ7YYP5vcNGqC0Rr9KYF4FasGN1I=;
 b=Xuq94094af0JPZhYBvMhH2adRptKXfLYKcHdwo7WFXucf5BN+XDIVXWFP9hNl4tUhBtjmQ
 P8e03MpunMbzKi1EMn4WnoBPPKRMmgfS3RlGjU17QkZY71YDUz5blM7IepNjAS5/2ROd9J
 bbMgFZO706XYhtJjn5yV/+1TbLJW5Eo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-9avk3JidOjGhIinwgDtbcg-1; Thu, 12 Feb 2026 09:43:43 -0500
X-MC-Unique: 9avk3JidOjGhIinwgDtbcg-1
X-Mimecast-MFC-AGG-ID: 9avk3JidOjGhIinwgDtbcg_1770907423
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4802bb29400so72399665e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907422; x=1771512222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1pZJeSsRKhhmEscgZ7YYP5vcNGqC0Rr9KYF4FasGN1I=;
 b=fZM+RLnERBSXthjXD5vCXUshXj8sVb91b0IOFuYEy2BH0h41wVmfjxlZb8AmxaU6XC
 D/133xLkgHg/YqRj/9eVTU1P2+miwyvsHAkwzFmOq2q4fjeAfhv8K7om4WwwSiQSUpuy
 Cl12YrF/lzMP0LMqAIa1H20u7QZGsOibCf7yrCUTpIgRjVrD9aRCCWbkWhOU8k5Gg3EK
 BqvOts+ufLIBoLZJnYg7GG77cA7p0sd1yKmcBzdjOeOsb3FZjZl0xdvRl0ztNTcTBO7f
 ALTf3IUAy9NYTRcemEl66l3s78YKgFKd5Zbq7VW3LuesWfXuuiRwcQXGviUsM5z5Wik+
 pJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907422; x=1771512222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1pZJeSsRKhhmEscgZ7YYP5vcNGqC0Rr9KYF4FasGN1I=;
 b=gfhSs9jxtwwCFBToc2iTJoB3I2Oc2zO+3OEzB1WFLrkc8lcxV3n8sp1CzV9tiQiEy3
 ofXa4uxp5bwcM0od3jd7t5csfXs9fOxgFU5w5IvLDMaz9btzI6uRuDkpMMMBsg31MljP
 5dyV5jkI0MpBoPt6M6W1wFY7+/jUGbWEJeD5DcJZaXJQdRm/iIdi4bg0t6hoxQ6gaALD
 DP2kX/8qy+e6L8VB5G9intHEC42blWZisOaGr9Y6/hWDjSo18e6RHF48Zg6NRAy3l3an
 0ZxckVJUm/kTZ+CqRNE8m2O/Xu1BF4kCwK46lXwuj0tfPYu/A0onRmzE0Jmj8yinlpC3
 UCqw==
X-Gm-Message-State: AOJu0YywwIuYRYFBRF/q0DlDGf5jppit9N2ZOION/w4RCLWtbhfL4pld
 4f5N5VPGWfZLjlXdF2ibMS83xZsdxlyrZlub5d8wxdaiWEb1CK9wGrEKSkYxfHPK4P+vIQ0+qTV
 +CDUunye0+OdUsKoUkATKTHH41trFU/Wa6L0EjYVNOA5PIoOfvPYCcwbpbBIQ8yl3fqbK717XBt
 1hDBoynpdIt/YI1JLmgWBzGVu/WMU3SHbTTbCLhp3Z
X-Gm-Gg: AZuq6aK+Pxlh5urCSZ57N+vHzfp590hTeCtAAB7k5trUpQHaheHcI0+u79xsIGB9DOL
 852hpLOCYH5h0vUCPycVcHcMDteTs5oe6fj1S1AvxQ8cDs0A5g4L8E4Lor1K+sKpZ/GDIVmz1j2
 NDz3s/L2l2J4Xa1nREbfOSOtN0XGMFnKO8OkB3+Pd0gQ7PbwcUMAFMS2fh31bb3GPJOIwZFTXv0
 79ws7SlMar9+17X++3q1qumvotg0RmIa4SyCC7BnNEg1erbVBE5lk9coRfdy+YS8Q8ATrLzGZcX
 U27r40MKFRMaHa6NYARJcXZ+Vxc5rivKLbOhto5uFfv3pSIRHKfQoYea1dWuJouMT1n34RYGOJz
 1PMKv57V1c27gji6cQEyhWGU7weIegYuQTNPL/YFJJvTJbF+AwxuWRdYrzqc0vX3rqwcm9V2Wix
 WKfwmUZDplH4GZpBknZRW7Qhimg1NSxkBQOVQslLkwVEcpHXg6+sU=
X-Received: by 2002:a05:600c:35cc:b0:483:6fe1:c057 with SMTP id
 5b1f17b1804b1-4836fe1c12dmr2079885e9.21.1770907422152; 
 Thu, 12 Feb 2026 06:43:42 -0800 (PST)
X-Received: by 2002:a05:600c:35cc:b0:483:6fe1:c057 with SMTP id
 5b1f17b1804b1-4836fe1c12dmr2079335e9.21.1770907421673; 
 Thu, 12 Feb 2026 06:43:41 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4836131d48fsm33303475e9.24.2026.02.12.06.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:43:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 24/41] hw/audio/pcspk: Remove PCSpkState::migrate field
Date: Thu, 12 Feb 2026 15:42:26 +0100
Message-ID: <20260212144244.22579-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The PCSpkState::migrate boolean was only set in the
pc_compat_2_7[] array, via the 'migrate=off' property.
We removed all machines using that array, lets remove
that property, simplifying vmstate_spk[].

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260108033051.777361-24-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/audio/pcspk.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 916c56fa4c0..0b01544941c 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -57,7 +57,6 @@ struct PCSpkState {
     unsigned int play_pos;
     uint8_t data_on;
     uint8_t dummy_refresh_clock;
-    bool migrate;
 };
 
 static const char *s_spk = "pcspk";
@@ -202,18 +201,10 @@ static void pcspk_realizefn(DeviceState *dev, Error **errp)
     }
 }
 
-static bool migrate_needed(void *opaque)
-{
-    PCSpkState *s = opaque;
-
-    return s->migrate;
-}
-
 static const VMStateDescription vmstate_spk = {
     .name = "pcspk",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = migrate_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8(data_on, PCSpkState),
         VMSTATE_UINT8(dummy_refresh_clock, PCSpkState),
@@ -224,7 +215,6 @@ static const VMStateDescription vmstate_spk = {
 static const Property pcspk_properties[] = {
     DEFINE_AUDIO_PROPERTIES(PCSpkState, audio_be),
     DEFINE_PROP_UINT32("iobase", PCSpkState, iobase,  0x61),
-    DEFINE_PROP_BOOL("migrate", PCSpkState, migrate,  true),
     DEFINE_PROP_LINK("pit", PCSpkState, pit, TYPE_PIT_COMMON, PITCommonState *),
 };
 
-- 
2.52.0


