Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91619CCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 09:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAmW6-00078a-KD; Mon, 20 Oct 2025 05:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAmW2-000772-RL
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:49:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAmVx-0001dr-T8
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:49:21 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47112edf9f7so16812395e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 02:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760953755; x=1761558555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q/UHGx6xpvisFhOS3RPFFYTa7tV8+Q6SbIOhNHRI88s=;
 b=O5+7kYSoIYIIy3GeLlSoB28c23Gwmew6gQ2qUjSJ3DJD5xwdO35dftCoUasp7g/mXk
 8iAGSd6VnbDPc0FPcJMd7C278ji6KyDAbrhAcsexlo2fKjKGydxky6RIWv5nlV469N6q
 QhDJpjP6A/tAnVS6CAKygiRgo0bR/Liz6LqupE1VYoiUuttFcTuDtLp4LBHgtVSr2iM2
 x4KcpNKN1qTndsqA1V7HmoGXk6uzAnm0aRKrpMqCIR9/yBvYAY5W0mewmn/+v7cZCFbn
 9tTKI89Zx8UobgPhO2fwmi9JEt13mupP0TqRmiKQKAvvFV3KN7YyXlJpSszrw7MOR9Rn
 Vmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760953755; x=1761558555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q/UHGx6xpvisFhOS3RPFFYTa7tV8+Q6SbIOhNHRI88s=;
 b=Wa13B1acR2lA9vPcBSKCnhCmwWZ+/eceHSTtPWnPXsQKMsJdA2AOaMtUb9mc92G2SB
 OQhhbBuBASR29d49yF1sTreZUYGGoR4EIrHjONRKrhXBq2Jdlii1iPg/rtKw0Cou+nnQ
 Z64Rg6rdHBF0DosEedOrulX8GceQ7IN3HLlTMoVI/t1tRCdysMPTUwWjuVnjMacyXQTt
 d7C2iTD/HY3iZiXew+leOuJ6XuNFf/EGkG3BTXWKeoJ8l5Kg9NgFKnWn7w7ocApMH0zW
 FDhRyBRn4RPdjFM3xeYWiUDjzRq0kNXEL03qdsBIqgkd/Sy+msHEpnBU6ZAgHy+M4UTb
 Zj8g==
X-Gm-Message-State: AOJu0YxLU11Uqq6uGg92Jk0njFfiMebltoRnZk1F7LqcKBAaxzRA/vez
 p0aWR2Grgfs9Lsj0TI8/Trn1GoB5LS23pxnvYlS75QCqEwYOp/mWCvz0pbBzzt/DljNQCVanb6y
 l3YpfSv8=
X-Gm-Gg: ASbGncsA4iQIqlvhmiI1D20YUISxvyrdzB+UYYEfhYiqCqqOlWfe+46YzUBhHh0FYVD
 CaSCh1UMxFtGi4TFOa6SLVnpgZxgv0CHTeA0uMSFhMjkIPAq5gV3d1+484ruIaPmMERJEHml9Yu
 4npsANmUa/FJAJpeU5ypGLSUvCfU9Kftx7uRLJQNDv5Q1UN0nR2/uwDDWHYKT/3K7D9SJBo+Yv9
 TOU6HLxVHvEj3qLBOaG2QnriVbqLYiVSdwzUFS7p3zzs6v/fpH5oFIMEVBh0c1j0YhII196h77v
 HuTLBras380dvFFhCPe8JE9JYxvs6YQj8jvJcPuk4dWt44j2Lzyi/WM/N6EADz5VcOKzkQ89JQ3
 NvSjJibL2m5IdAAKHs3teYcdT3CqKkWAYG1P5NaMeX435DkYsHSsyxA0WTwfeMxdRt91iVdjLuo
 Gh+RHbXeWbnsvaYbWeZiN2MNjoAz7O3bmBFW7JfizkAtGpUfa0a853sipFYiCH
X-Google-Smtp-Source: AGHT+IHoU0lwInV+nIsW9xOICxYr7yI10flL6e6ZG7UgHVipR9KOFyPoSEyIo0KdN+xxeCeMjSCNHg==
X-Received: by 2002:a05:600c:310e:b0:471:786:94d3 with SMTP id
 5b1f17b1804b1-4711791185emr91600415e9.22.1760953755238; 
 Mon, 20 Oct 2025 02:49:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711442d9e8sm224032105e9.7.2025.10.20.02.49.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 02:49:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v2 2/3] hw/s390x/ccw: Remove SCLPDevice::increment_size field
Date: Mon, 20 Oct 2025 11:49:01 +0200
Message-ID: <20251020094903.72182-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020094903.72182-1-philmd@linaro.org>
References: <20251020094903.72182-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


