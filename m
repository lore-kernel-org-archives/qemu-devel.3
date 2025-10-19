Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EB5CCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 21:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAaZN-0007Y8-CE; Sun, 19 Oct 2025 17:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAaZH-0007XQ-MT
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 17:03:55 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAaZ8-00023C-85
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 17:03:54 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-63c3d7e2217so3760295a12.3
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 14:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760907824; x=1761512624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ROqS5b9mjR1Hcdo/MNxQW9zo/TvwGOsH5rFLzCQXjhw=;
 b=Xi6wop5ZBLtEvQ7okDhUca5A8UKK2iFeejWZmbfNmgtgPG3GJpGEh/asEIiLsJpojg
 YDPosdY1jqq9P0XEiRjoY//JHWSUIynF9v2jJt9oIU/aGwf2w8IlWSyCge5Z1dfP0OXX
 ypcdtexxV3TZ7BOQ9BFUjyDH0XEtVgGjCJFixe1jFwckSxd+nO6Mowc9gRLTvwdPKtFO
 HUxoj0CjyPJK8ResVw7gHTUP11DY2tLOtvb/xenrQ+poOiYt4qKQPWqGbm3FQtUipcFC
 yz0/DghId5boNP8t7Jiwu8CcFGPYt+w6iUe8TTZMMPkQ8CWx8RJgkL0mxDwrw6j10lIF
 Tt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760907824; x=1761512624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ROqS5b9mjR1Hcdo/MNxQW9zo/TvwGOsH5rFLzCQXjhw=;
 b=LQzDy6dEVgoramNR76DCY9VG0x/JxKpL+JbOPSdOjaoPM1/pTLiWovsILLzvSTSIoB
 Gwe1YHNUtsE3UVm/ZfdLg4HcZIryuRlQw4qZe45fAY1MacGBtF2yw1Z97Vtns80tFUr5
 unO21G2kktFsixCz0dyK0n/EtW2ei9u7tTgvIZGW0zTc6mXUbDyfzE1LKWzDNOz3BhlH
 VPB/8DrQSNxdjUJz4aq7XnDxPsfYAGA7uuKlpLR7B2hplWpJkRn+k6o91FQM3bHBW55g
 STsR4foU2oGehaFnB9IkRycNPMSl9XQjIhcIQ0z2lXUQJ7tKO7qVA5yFoV2R1tzvel1d
 KhNg==
X-Gm-Message-State: AOJu0YxFRN0ASCz0TuRYjSsUh/VGvFzMz2TRy0BzrJXY3ri4H2MzCrba
 Ikt+bQoAPRVToyDxfk+en23nge3Pk8oqSDbGlx5losvjVpeu/CMngHVRCf5EElJS
X-Gm-Gg: ASbGncuIwxqxfpqkbMIMLmZk26jiuDjnyGAKnTJCb/jPlf15a2DFZthGxcabt40kpEI
 +4HI4xV4RQOfj8LFoOsmhnbtaEisMasRaug1MHHTe9EjTbsU0liQD3FrEE9pjsf4CfZ3QMhy+h6
 +jEgWK047fA43rdBbqJm3ypQhEp42hl80lxAoe/XCZCxYK/dt/dXWSXlOi2DMY5gtmDDTc1uWoy
 XeckF/S36f0ZPHhXKc7qx7pKjUmFB7kFxtP5HXrfZY1sogbxXD8+wdXCaD8WJjlLa0GrSl04Ebv
 srxuSvwxxFWrM6jLvF+79Mby4fRk0eFvl5F/KcC2mwdUCcJfGEhLrTz6sXE05BTeXznBDDUfPC7
 huTF47I8k++I2mZu/4FXYIvBvR4p/3yxrxFkKmHIpzbls/1dxSGre3MKOTwjgbgRdI0zJQ8V139
 JcdUFX+fPBWXEu0hq20R7GuKQhJpv1hSabvVnU/Mj0D4u1tMvcl6DctdArvPyx+vT1khXf
X-Google-Smtp-Source: AGHT+IHqxQHSLWGjl/1o+caM7v59/pl99Hw05CaKkU9VxpB1BkUo2CSz0N/TNd5uoNKIH8Cs1RcreQ==
X-Received: by 2002:a05:6402:461a:b0:634:ab80:d84b with SMTP id
 4fb4d7f45d1cf-63c1f6c42c3mr10193464a12.32.1760907824053; 
 Sun, 19 Oct 2025 14:03:44 -0700 (PDT)
Received: from archlinux (dynamic-002-245-026-170.2.245.pool.telefonica.de.
 [2.245.26.170]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63c4945f003sm5107655a12.27.2025.10.19.14.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 14:03:43 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>,
 Cameron Esfahani <dirty@apple.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 09/10] hw/intc/apic: Pass APICCommonState to
 apic_register_{read, write}
Date: Sun, 19 Oct 2025 23:03:02 +0200
Message-ID: <20251019210303.104718-10-shentey@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251019210303.104718-1-shentey@gmail.com>
References: <20251019210303.104718-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

As per the previous patch, the APIC instance is already available in
apic_msr_{read,write}, so it can be passed along. It turns out that
the call to cpu_get_current_apic() is only required in
apic_mem_{read,write}, so it has been moved there. Longer term,
cpu_get_current_apic() could be removed entirely if
apic_mem_{read,write} is tied to a CPU's local address space.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/intc/apic.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index ba0eda3921..077ef18686 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -769,17 +769,11 @@ static void apic_timer(void *opaque)
     apic_timer_update(s, s->next_time);
 }
 
-static int apic_register_read(int index, uint64_t *value)
+static int apic_register_read(APICCommonState *s, int index, uint64_t *value)
 {
-    APICCommonState *s;
     uint32_t val;
     int ret = 0;
 
-    s = cpu_get_current_apic();
-    if (!s) {
-        return -1;
-    }
-
     switch(index) {
     case 0x02: /* id */
         if (is_x2apic_mode(s)) {
@@ -868,6 +862,7 @@ static int apic_register_read(int index, uint64_t *value)
 
 static uint64_t apic_mem_read(void *opaque, hwaddr addr, unsigned size)
 {
+    APICCommonState *s = cpu_get_current_apic();
     uint64_t val;
     int index;
 
@@ -875,8 +870,12 @@ static uint64_t apic_mem_read(void *opaque, hwaddr addr, unsigned size)
         return 0;
     }
 
+    if (!s) {
+        return -1;
+    }
+
     index = (addr >> 4) & 0xff;
-    apic_register_read(index, &val);
+    apic_register_read(s, index, &val);
 
     return val;
 }
@@ -891,7 +890,7 @@ int apic_msr_read(APICCommonState *s, int index, uint64_t *val)
         return -1;
     }
 
-    return apic_register_read(index, val);
+    return apic_register_read(s, index, val);
 }
 
 static void apic_send_msi(MSIMessage *msi)
@@ -919,15 +918,8 @@ static void apic_send_msi(MSIMessage *msi)
     apic_deliver_irq(dest, dest_mode, delivery, vector, trigger_mode);
 }
 
-static int apic_register_write(int index, uint64_t val)
+static int apic_register_write(APICCommonState *s, int index, uint64_t val)
 {
-    APICCommonState *s;
-
-    s = cpu_get_current_apic();
-    if (!s) {
-        return -1;
-    }
-
     trace_apic_register_write(index, val);
 
     switch(index) {
@@ -1054,12 +1046,17 @@ static int apic_register_write(int index, uint64_t val)
 static void apic_mem_write(void *opaque, hwaddr addr, uint64_t val,
                            unsigned size)
 {
+    APICCommonState *s = cpu_get_current_apic();
     int index = (addr >> 4) & 0xff;
 
     if (size < 4) {
         return;
     }
 
+    if (!s) {
+        return;
+    }
+
     if (addr > 0xfff || !index) {
         /*
          * MSI and MMIO APIC are at the same memory location,
@@ -1073,7 +1070,7 @@ static void apic_mem_write(void *opaque, hwaddr addr, uint64_t val,
         return;
     }
 
-    apic_register_write(index, val);
+    apic_register_write(s, index, val);
 }
 
 int apic_msr_write(APICCommonState *s, int index, uint64_t val)
@@ -1086,7 +1083,7 @@ int apic_msr_write(APICCommonState *s, int index, uint64_t val)
         return -1;
     }
 
-    return apic_register_write(index, val);
+    return apic_register_write(s, index, val);
 }
 
 static void apic_pre_save(APICCommonState *s)
-- 
2.51.1.dirty


