Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5F2C9EC90
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHv2-0004yT-3S; Mon, 12 Jan 2026 08:25:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHuI-0003X3-70
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHuE-0003qS-Ir
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=77thvasEz7mbFfddpidtc2aDEfBsUM8wmBICVXOiwbI=;
 b=e+ZtvixyvLisuZKFx4rKWPPm2ybZEHRg+YTIq1RDvrsrVp7VjHKFqER78o93GB3VhYBZLF
 6ztcush8F4xTd9lJn7zNZqQAUwt70nKkx1sYI8stkGtzCnEBhAuifS1+40sOGV+PyTqBoy
 e15ompXDv9rSHeNl3TbEnTdZ6IhNsPk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-Ihg7aT4WOW6CeqZ7DhnyQA-1; Mon, 12 Jan 2026 08:24:24 -0500
X-MC-Unique: Ihg7aT4WOW6CeqZ7DhnyQA-1
X-Mimecast-MFC-AGG-ID: Ihg7aT4WOW6CeqZ7DhnyQA_1768224264
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34a9bb41009so8970901a91.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224263; x=1768829063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=77thvasEz7mbFfddpidtc2aDEfBsUM8wmBICVXOiwbI=;
 b=nj2nvd3lzQCSPyk9bcinzAEY14U8gR5Rw+vrywR+eX9oT9haEGa2X7Vh2JTJtWV/pK
 CIsU5XrCalkHB3Nb/s6boqCt8v6N+Xgyz+1jctkEeAvPdbOnQTauFyo4hkz70I4uZxLN
 xlQLoemgDe1v/9zneTMQBqn3pxZZekowlZytiXsi/qNSei0uGp7rAMYxcddljZyH7zFa
 AxUlEMECoBZjVQlFZXf9gmpGYoPHS5CcLv7Q2dHxkuiCM/xffKYDNZWmAhHCnC8JwxP0
 wRftwiYxWZ8nhYHl4wvkn0pycrfBmMOw7yaNWXu5VvMZxq4cY8+JmZtXkthAYoX2xQ/2
 XjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224263; x=1768829063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=77thvasEz7mbFfddpidtc2aDEfBsUM8wmBICVXOiwbI=;
 b=PgBajKH44xCuVQIpp13d/JyugF/DHC5xZkPvPN2CYgGwSaFGRP09nSDyevk/Le3Vw8
 hOMYs6xSf16E7t2Swo7HISJB2EXXtsH5ceoiH8SNGbQLwRaryAkFZWkvZYUfGiVhHqEG
 HAMm4QknaHHgJaCGiqol1vbkp5LMoSeAxfUpfsv1sg7xg1LXjgRC72ZrEoKC0cKUshko
 RQIYw3gVqhXsC+2nnWh1Za7WkOwy5O94wBP6FLLXI3Jc4G7WyHGrLLGQYluxVMrShsge
 kzK34+wer9WWjENnfSnbUf0bQBBjNHoUU5pRZ/ZQ1fh8wV7eSR6QVKjAbFEdsws2/Z6U
 nB+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrI2HInuYR2c0kITvZgEl0mex3dv79uQYE2crC9cN62ZfKtGo1cSP6I+7HSirGerzv1Hi/6G0ZUGjg@nongnu.org
X-Gm-Message-State: AOJu0Yxkq3h07WW6ciIu894A4xYfkXGanKiTY+aqrV3016tLX/XN6Y4s
 zONy+FxOeVmcVWTdymAED2rbi+4oC1vFpFFlObRWr0DpmIStCasNfNQYpUV5zo6BKZLSuyc+R0m
 xFP1ExjBeUNJYIFH5p+cs7DWSkjvljIehgP5hWlK8HacwickfC8iF/e0O
X-Gm-Gg: AY/fxX5OIA3tlgAL8nzu9LlbBtv/q/jcPbMRPcrKx7ym2wdt4KfdJ3oxuc5S6wJbwOl
 nPtM+1ZpjkySHX/WzdV1+r4gWB3HUWMmd3v9XEstXDDhIFY+xyktIg26C9qvcRmpPZr4FT3QWmu
 3lMaBZYwYIpOP2yT9aOh5AkHrFHN+NHP8xQu/nmoNlUiux/9e/7/3jJtQBQw5v2V38j8ini0GDX
 2FgAYcGA4uXzJgu6guz43DgS95jFXUEhlORjLQqlzyHzyR75XPcg4oLy20ASNRahw+3+GFGus47
 jj+XPx7ev/TDiNeOZn73FU6xipPPGhXC5fm/Vk0NyiJ5IpRGi18r3flsuPzA0teKjXD5mFUownR
 r0s/Y1py5q4NUD2Oi1NnpRC3FxYo+ZFmzFoLIpO1yrg8=
X-Received: by 2002:a17:90a:e7cd:b0:340:d569:d295 with SMTP id
 98e67ed59e1d1-34f68d0bbf9mr18826399a91.24.1768224263609; 
 Mon, 12 Jan 2026 05:24:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqNzs5T4Y/nuvXOBzpoX20Jpvk0mau7pb5OixY7RQGKlDk6YD1j8R2CuGb7j6qKGZqxXYANw==
X-Received: by 2002:a17:90a:e7cd:b0:340:d569:d295 with SMTP id
 98e67ed59e1d1-34f68d0bbf9mr18826369a91.24.1768224263249; 
 Mon, 12 Jan 2026 05:24:23 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:24:22 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 22/32] kvm/i8254: add support for confidential guest reset
Date: Mon, 12 Jan 2026 18:52:35 +0530
Message-ID: <20260112132259.76855-23-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

A confidential guest reset involves closing the old virtual machine KVM file
descriptor and opening a new one. Since its a new KVM fd, PIT needs to be
reinitialized again. This is done with the help of a notifier which is invoked
upon KVM vm file desciptor change during confidential guest reset process.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/kvm/i8254.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 255047458a..4d212fad1b 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -52,6 +52,8 @@ struct KVMPITState {
     LostTickPolicy lost_tick_policy;
     bool vm_stopped;
     int64_t kernel_clock_offset;
+
+    NotifierWithReturn kvmpit_vmfd_change_notifier;
 };
 
 struct KVMPITClass {
@@ -203,6 +205,16 @@ static void kvm_pit_put(PITCommonState *pit)
     }
 }
 
+static int kvmpit_post_vmfd_change(NotifierWithReturn *notifier,
+                                   void *data, Error** errp)
+{
+    KVMPITState *s = container_of(notifier, KVMPITState,
+                                  kvmpit_vmfd_change_notifier);
+
+    do_pit_initialize(s, errp);
+    return 0;
+}
+
 static void kvm_pit_set_gate(PITCommonState *s, PITChannelState *sc, int val)
 {
     kvm_pit_get(s);
@@ -292,6 +304,9 @@ static void kvm_pit_realizefn(DeviceState *dev, Error **errp)
 
     qemu_add_vm_change_state_handler(kvm_pit_vm_state_change, s);
 
+    s->kvmpit_vmfd_change_notifier.notify = kvmpit_post_vmfd_change;
+    kvm_vmfd_add_change_notifier(&s->kvmpit_vmfd_change_notifier);
+
     kpc->parent_realize(dev, errp);
 }
 
-- 
2.42.0


