Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC40D729F3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 18:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH5LE-00042M-Gc; Fri, 29 Nov 2024 13:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tH5LA-00041M-8m
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 13:03:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tH5L6-0006Nd-VP
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 13:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732903415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+U9ukd1FP1SXGWD1ZHLvvkFx0WIB0UvvucvkGaKpj0=;
 b=S+Lfgh7fefHW9j9e7XsHaZZSBNAwonbfUaqlWMXmQwUnwhSje1ZQd12x0H/ZyJ0fyU8ylA
 52cY4FsgJKV7aDpDcgH9ZSdq94M420RpejttGPmU6oMwUs2PtHv5YIBuy/o2weuNqrS6G4
 9sHecPjB3KlTGNwOgNQnlNmKNnU4P+s=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-20iGsUloMLeRMlvFMfVq8w-1; Fri, 29 Nov 2024 13:03:34 -0500
X-MC-Unique: 20iGsUloMLeRMlvFMfVq8w-1
X-Mimecast-MFC-AGG-ID: 20iGsUloMLeRMlvFMfVq8w
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa53efda0f2so115181466b.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 10:03:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732903412; x=1733508212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P+U9ukd1FP1SXGWD1ZHLvvkFx0WIB0UvvucvkGaKpj0=;
 b=ffEDuIm9q/soiSmP3KjX1avSs6/ShHmIiDkhvBpB/SyFGApSPRydpqbXOnwUlPrHGV
 7NEh/rbkFw+JiCBLwlxv9WiCYUS8fNaqIC3fkilu1Sbz2be/zs28hCqpnyGnz2knUQ+B
 t284qKKvAl/cwC/aHFc177r8hYheuGyyI0a/dLiQ4rKrrCEIgqIh1tAGeOzzK7iDi/3c
 lRp23QPv3WC5ZKigqRlfjtT0t80h6ZwIBw0dCS6vM/PAjBXjzE5ON9hBYjx/1T1jcfV1
 ft0OfiOSIUf3lWOzQKtHyA93Yk3PvSe3EKU0A2140HjMZyBxarzrlFCgo+YEsGd3QdOE
 JcHw==
X-Gm-Message-State: AOJu0Yz6wYP9ROJ7EtjDaeFCEVdhw4tS2AjzUr8KjWyGjKhDX3oIrBO0
 Ma909xPqNP86aEWb/V6aGHMIOZBfRjkJ4kX1bUVelxvQvUU41lZG9u6btnL1yYsSuqFCg+16EES
 YTSj4SzSmBMzDpHDKknzQWeTG6FhQRKw9QkBGruLdCh/Ag2QG4XOLoSpeO4Oi34BTyb+er963ai
 hbpbCUkObsm1WiRarPh5FaSRj9LTTFy1uKOuLy
X-Gm-Gg: ASbGncuqENZzPfLLQ+ytg7nm8wRTE6e32wy7ZXoi8RauWhSBeJK8YdYgLRanXD0KyF4
 eg1NExxNO59TVJ84OuzKmgszpUr9JvQgRUi2guh42hUgsFzAgpH9WsP1Yu1O27RdSkEan/8ynJx
 1OBSsmJFFkw6yNY6TIy0VQTqsRwMRZPQUDGgSA9Lt/We47sM7Wz8s4BGjcdQP5vwfmqBNDO0KhF
 F4H4FfejIDFtFgMUmLJjLLBJ9+fz2HNB0PwT/iBam2MTGztDWbK
X-Received: by 2002:a17:907:7713:b0:aa5:cec:d504 with SMTP id
 a640c23a62f3a-aa580f57d8dmr1074789666b.30.1732903412199; 
 Fri, 29 Nov 2024 10:03:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDGHw/8+ZtYjcDoc7KD3M8QCI+Bk8N3Ke7YEmXxzfX2CNS7RBXUM6Okh2GEibMBE0h+qdQUQ==
X-Received: by 2002:a17:907:7713:b0:aa5:cec:d504 with SMTP id
 a640c23a62f3a-aa580f57d8dmr1074780866b.30.1732903411535; 
 Fri, 29 Nov 2024 10:03:31 -0800 (PST)
Received: from [192.168.1.84] ([93.56.170.251])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa59991f11esm195102866b.167.2024.11.29.10.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2024 10:03:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 2/3] clock: treat outputs and inputs the same in NamedClockList
Date: Fri, 29 Nov 2024 19:03:25 +0100
Message-ID: <20241129180326.722436-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241129180326.722436-1-pbonzini@redhat.com>
References: <20241129180326.722436-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Leave around a reference not just for inputs but also for outputs.
This is a better choice because in principle the monitor could walk
the NamedClockList after the clocks have been unparented (which would
free them) and before qdev_finalize_clocklist().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev-clock.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index ca65685c04e..2f9d6cb7579 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -48,14 +48,6 @@ static NamedClockList *qdev_init_clocklist(DeviceState *dev, const char *name,
     if (clk == NULL) {
         clk = CLOCK(object_new(TYPE_CLOCK));
         object_property_add_child(OBJECT(dev), name, OBJECT(clk));
-        if (output) {
-            /*
-             * Remove object_new()'s initial reference.
-             * Note that for inputs, the reference created by object_new()
-             * will be deleted in qdev_finalize_clocklist().
-             */
-            object_unref(OBJECT(clk));
-        }
     } else {
         object_property_add_link(OBJECT(dev), name,
                                  object_get_typename(OBJECT(clk)),
@@ -84,7 +76,7 @@ void qdev_finalize_clocklist(DeviceState *dev)
 
     QLIST_FOREACH_SAFE(ncl, &dev->clocks, node, ncl_next) {
         QLIST_REMOVE(ncl, node);
-        if (!ncl->output && !ncl->alias) {
+        if (!ncl->alias) {
             /*
              * We kept a reference on the input clock to ensure it lives up to
              * this point; it is used by the monitor to show the frequency.
-- 
2.47.0


