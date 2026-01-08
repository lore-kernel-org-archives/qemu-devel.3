Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDD8D232C3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 23:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdz3R-0007EM-Tl; Thu, 08 Jan 2026 18:04:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <csomani@redhat.com>)
 id 1vdz3Q-0007Cw-7U
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 18:04:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <csomani@redhat.com>)
 id 1vdz3O-0003VO-QR
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 18:04:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767913468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BwUB2cayiLwwDdtvJpiYXS203h3m3uyKKPss8d5TaJ4=;
 b=Qim4Z9EmplvBXdXtTvynrxyPZRs5cSw5UuuDU8+ei7MeXZlkHCaVrt+CzAg6hvqYEmgdlG
 +8JV9Bz6+qN+CTMgeMbSAbTFt2B/RgPg8z7hkiSFdUeNnxBDAKV2eNVVBWdTN9YioF5bhU
 UmalRUGSEOOaVQlUDMCd8VEZH9qgCYM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-C36cBPMkMAuIpj91zKRRHw-1; Thu, 08 Jan 2026 18:04:27 -0500
X-MC-Unique: C36cBPMkMAuIpj91zKRRHw-1
X-Mimecast-MFC-AGG-ID: C36cBPMkMAuIpj91zKRRHw_1767913467
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b259f0da04so918252585a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 15:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767913466; x=1768518266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BwUB2cayiLwwDdtvJpiYXS203h3m3uyKKPss8d5TaJ4=;
 b=LrXC3obrUMJ/L0MOimD3RMEeW2Q+w9j2G9bP580CBpvJUmg5ao1UPtJzTpeOuwnKRD
 e6f1ydl3+kjY88HCQkWfheFogNgQOdsy/O9BlGFHV0fm5AwvbuzhuVRecBw1em3ZLQVM
 RmorxBkr1+B3JMJZ1zfy89gX9QDcYURNtRJcpQN30ybyadRNcEgKLsJe61mlnzUKK0Ud
 HejldUdNckcXLV0i9BE+Sm+PxqkcQ8WfsAwBQjMhvSvwWhzw+DqZMtYoVKKoW0699bw3
 J1Wt3leKG6/uOkbKH1ya3dF6b4N/sjxXz6PGR9mhiQmOKf28AM6uc9GoDEriaQT8nFs+
 szqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767913466; x=1768518266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BwUB2cayiLwwDdtvJpiYXS203h3m3uyKKPss8d5TaJ4=;
 b=ZiL3E3BBAApj34WmlbTXdRi1HMjAV/vwN50JtJZAeEHttnmhKt5RXZHLVp9JIkSRF2
 E7VfMyDojqld26pcEmq2PXujB61pJIK41jvE7/HU97LXHo8E7zxw299fHnjnkdz1niqP
 w47SOXPfuAoBCpkA/t7i3kFe566HJw6OzOypRvsfZx/EayH0PF9LvNJoOTI+LmSCd1XD
 IDBn/gxE/ATTVICvnRPcaOd48OBCpRBnZAoTjUO96XxPf7jYdzHZucSDRiw2lGTWXQw8
 rsY4U5mR/MK5t+oVKvPV/AYlKm+7FwgWWrwfP4hXaAGDhz1cjD6fZc/9DMGYDYF9f7zD
 C9Uw==
X-Gm-Message-State: AOJu0Yz4amkCws6ZViaAPg00+WZe0L72srWXBUdy6WlftqRrCdIN4Pck
 X8um6y73+J0kHngK1qiBljowosqQONe8vQrrrWT4tqLiMjZqfgRDjNYncNKSI1+FMD52Qx0x8mz
 NST7p4Lk4UdIn09YYpOwmcjhFyCvkfRozd7zQ7qj0m2hcIvkwjC6vNn6cNVMm577B0M0dmbeUO6
 nZiKngAo4jZY+omSkptQnrHmTgg/AgqQ0BcPPKOd4=
X-Gm-Gg: AY/fxX57nHF+V6iHJUfnVJ61to87KU63/8eT/6frv51sv3ExwueJmO2vFQjcm4vXBp3
 s59u1kVgAwGMuWZSiFhivi3/q6ASGfanUj35Xb9tWzvCvVG5jiGpFzFt9/OnVXZQIa3R9D2VFda
 nejbRuiVnTOy5JpuJtQQoNDnBmuPom1S8pRMGtRe4xsruZrDbzuKv8kMOFWoKHuchBw3t/InqSX
 jjXFDAeUfAQ6qLhueSwAiBLpOp66eHJwsfXKXTUTCstFYG9+qJQYN9sAs03Rps3Ov5Ag7D5GtdO
 7kmbO6yamWcGgWgxZU6PWHZJgSex5rK396XjGSKX44QfiKWwKOBawbFDuMwB2geswtXIKLGEoSN
 XLXqvDxBiX51B3QxulmFVgFgMWxtVqi4aFVXXjHQ=
X-Received: by 2002:a05:620a:7101:b0:8b2:eea5:3324 with SMTP id
 af79cd13be357-8c389392555mr1101997185a.27.1767913465932; 
 Thu, 08 Jan 2026 15:04:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6UJRotin8O82fOJkNqeh1FWnEsKGodV2zRNiTWZ612SY94cR9JZuFhyVzgXXNlHHdf9lYNA==
X-Received: by 2002:a05:620a:7101:b0:8b2:eea5:3324 with SMTP id
 af79cd13be357-8c389392555mr1101992085a.27.1767913465426; 
 Thu, 08 Jan 2026 15:04:25 -0800 (PST)
Received: from csomani-thinkpadp1gen7.rmtusca.csb ([47.153.136.179])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f51b787sm680000685a.29.2026.01.08.15.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 15:04:25 -0800 (PST)
From: Chandan Somani <csomani@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 3/5] qdev: make release_drive() idempotent
Date: Thu,  8 Jan 2026 15:03:09 -0800
Message-ID: <20260108230311.584141-4-csomani@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260108230311.584141-1-csomani@redhat.com>
References: <20260108230311.584141-1-csomani@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=csomani@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

So it can eventually be called multiple times safely.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Message-Id: <20250429140306.190384-3-marcandre.lureau@redhat.com>
---
 hw/core/qdev-properties-system.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index fe5464c7da..a402321f42 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -232,6 +232,7 @@ static void release_drive(Object *obj, const char *name, void *opaque)
     if (*ptr) {
         blockdev_auto_del(*ptr);
         blk_detach_dev(*ptr, dev);
+        *ptr = NULL;
     }
 }
 
-- 
2.51.1


