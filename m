Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88675CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kXg-0008Tu-RT; Fri, 17 Oct 2025 09:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kXT-0008Rc-PW
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:30:39 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kXE-0007vF-K6
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:30:33 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so8507095e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760707815; x=1761312615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q/UHGx6xpvisFhOS3RPFFYTa7tV8+Q6SbIOhNHRI88s=;
 b=Caf3dnm9QoU8XkftTu0goCRnwdRmnOzXGg5gKRa8ruv3QZi0Ra42XPkOKWsnwiQNyM
 lGnRdYGYpwcsbbedHkJo0PWCyu3YH+VF4AxEKPx/nOn/K7b669jGw6LT5D06niBfgAae
 z2eLJm3yiv5NNa7roGCAntVykIJcDEpti11aXrStysJoyAv3t/SCVYRGPnR6h6aiFRET
 E8CVQeOmQpe37mye1Z3QncQBp0/VGrzbAVHu+7/ahQn8H02eDThyFqF/J+fYefyiBeGI
 y39f9TBAij15+NWoZs8JPPjWqSlnjBGplQhfhFiu3WiGU+iGEmPHgT4DUxMxoiwFMMYQ
 gzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707815; x=1761312615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q/UHGx6xpvisFhOS3RPFFYTa7tV8+Q6SbIOhNHRI88s=;
 b=cmnoaAd/er40xTGB4ZbWkEUOa2BrXW3wqo6nLX5mgF9Gyb7Bf+N4O9Zd/7yvfV8rgN
 l7p9s21UsmFbuuQIkeJqQu2HXRX4IU27QV3VDikyQxjj+N/5tgjwkL9haa9KuFiTfwfR
 1sSDDlG5am3c0WltgRiHkvKOawkNowNUDkLMa5ieiFiM0fxHcM6Kvid2//LX1W6xlhED
 w9PZqOmCQuRM2fnZCPAKXFKeZRcJBfNwmca9NiCuyDDOU2Waqd3qd2PJoF1jh7OCv4Pp
 juxc0tjrUz6StGuVGqcDTUXSYu5A57TSX2ai41OKZUPNzKnOdsmnxAmvJcHnF7OV50o0
 4L+A==
X-Gm-Message-State: AOJu0YyCAdAAzhUrmm9d5mn9iiImEePWDR9FArWALnMsb1Vdtxt0O0r6
 TVjWNgACSUwdvqmaDdadJAQ0UHo4PtHw73c4zZMsLn+fYWb77neO+ST+VIFU4TujN+a9sDska5+
 2VoGHecU=
X-Gm-Gg: ASbGncsKfqYC25neXGT8webYwqCzqIIWg/L+SXGJRMPsy4qbymTwKCCh1etGmiLG5Va
 Af5R9rIktXpUZCy1QFTMYz+6SzM+oJxO2tY2rTFbF/oQZsQYNO4FiTJChWABt0WfiFLoi1h8FhN
 NQ37dbU8moOAwtP5y6Oz32Uv/7QDcYBh26RnDyq4qmq6X40ZfSCmy2oHF6GIUU+LLlWFC8k/049
 ctOqmKhHaqL6zIcOK/z8UCbx5Dnw03FNSyxLixRy8HmEdTMQhyp1NVWwTmLo+vQ+hYKtFjacodg
 lghqA5TYG57/U1P5T4FSmCJKSvh6XQADJROYcrLBfU8IYobEvJkF4m6xH7DfqQDmFeGKWyqgb0v
 QNfqM6vXx6tKlnqHtwVN3sdZ39IxFa9syV4Bf08dYtpHiZRQhrxNn5iGcRPEJkxb/zFcwNO+8Cj
 heEz7I9pFbSgOlW1vlHGpGnszF6grKjjaSdpgKiGltajIZMwalJ3bpxcRxPFsv
X-Google-Smtp-Source: AGHT+IHkxBSOxBAvZBFxn5iEhmD7eZcAshmuqYRYtNGdYVubOvaegrhLSBRjaVLUidBAKEkUhr3/tQ==
X-Received: by 2002:a05:600c:3f10:b0:46e:59f8:8546 with SMTP id
 5b1f17b1804b1-471178afb7amr27078605e9.17.1760707815423; 
 Fri, 17 Oct 2025 06:30:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710cb36e7csm50587645e9.2.2025.10.17.06.30.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:30:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/12] hw/s390x/ccw: Remove SCLPDevice::increment_size field
Date: Fri, 17 Oct 2025 15:29:51 +0200
Message-ID: <20251017133002.61410-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017133002.61410-1-philmd@linaro.org>
References: <20251017133002.61410-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The SCLPDevice::increment_size field was only used by the
s390-ccw-virtio-4.2 machine, which got removed. Remove it
as now unused, along with the sclp_memory_init() method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/s390x/sclp.h |  5 +----
 hw/s390x/sclp.c         | 34 +++-------------------------------
 2 files changed, 4 insertions(+), 35 deletions(-)

diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index d32f6180e0d..33f01f85bb1 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -197,12 +197,9 @@ OBJECT_DECLARE_TYPE(SCLPDevice, SCLPDeviceClass,
 struct SCLPEventFacility;
 
 struct SCLPDevice {
-    /* private */
     DeviceState parent_obj;
-    struct SCLPEventFacility *event_facility;
-    int increment_size;
 
-    /* public */
+    struct SCLPEventFacility *event_facility;
 };
 
 struct SCLPDeviceClass {
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 8602a566a49..c9a9c4bb375 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -110,7 +110,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     ReadInfo *read_info = (ReadInfo *) sccb;
     MachineState *machine = MACHINE(qdev_get_machine());
     int cpu_count;
-    int rnsize, rnmax;
+    int rnmax;
     int required_len = SCCB_REQ_LEN(ReadInfo, machine->possible_cpus->len);
     int offset_cpu = s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB) ?
                      offsetof(ReadInfo, entries) :
@@ -153,21 +153,14 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
 
     read_info->mha_pow = s390_get_mha_pow();
     read_info->hmfai = cpu_to_be32(s390_get_hmfai());
-
-    rnsize = 1 << (sclp->increment_size - 20);
-    if (rnsize <= 128) {
-        read_info->rnsize = rnsize;
-    } else {
-        read_info->rnsize = 0;
-        read_info->rnsize2 = cpu_to_be32(rnsize);
-    }
+    read_info->rnsize = 1;
 
     /*
      * We don't support standby memory. maxram_size is used for sizing the
      * memory device region, which is not exposed through SCLP but through
      * diag500.
      */
-    rnmax = machine->ram_size >> sclp->increment_size;
+    rnmax = machine->ram_size >> 20;
     if (rnmax < 0x10000) {
         read_info->rnmax = cpu_to_be16(rnmax);
     } else {
@@ -406,25 +399,6 @@ static void sclp_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void sclp_memory_init(SCLPDevice *sclp)
-{
-    MachineState *machine = MACHINE(qdev_get_machine());
-    MachineClass *machine_class = MACHINE_GET_CLASS(qdev_get_machine());
-    ram_addr_t initial_mem = machine->ram_size;
-    int increment_size = 20;
-
-    /* The storage increment size is a multiple of 1M and is a power of 2.
-     * For some machine types, the number of storage increments must be
-     * MAX_STORAGE_INCREMENTS or fewer.
-     * The variable 'increment_size' is an exponent of 2 that can be
-     * used to calculate the size (in bytes) of an increment. */
-    while (machine_class->fixup_ram_size != NULL &&
-           (initial_mem >> increment_size) > MAX_STORAGE_INCREMENTS) {
-        increment_size++;
-    }
-    sclp->increment_size = increment_size;
-}
-
 static void sclp_init(Object *obj)
 {
     SCLPDevice *sclp = SCLP(obj);
@@ -434,8 +408,6 @@ static void sclp_init(Object *obj)
     object_property_add_child(obj, TYPE_SCLP_EVENT_FACILITY, new);
     object_unref(new);
     sclp->event_facility = EVENT_FACILITY(new);
-
-    sclp_memory_init(sclp);
 }
 
 static void sclp_class_init(ObjectClass *oc, const void *data)
-- 
2.51.0


