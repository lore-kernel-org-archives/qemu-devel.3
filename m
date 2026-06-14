Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6803BCD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDO-0008MQ-1J; Sun, 14 Jun 2026 15:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqD8-0007ZP-AZ
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqD7-0002f2-0F
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rpal2W86mAE9e6bf+ImoOSz7GYFAC1OuHewPuBp7b9c=;
 b=StDnWNXToVY2eJNFmbRNkQnifTHB3qe0SDaHVOwlyYv1cwdkrFQgfAuHniTIHMPOZehfUQ
 BYA7WvfTWpAzhxJJS6AU6O35ronHsg9UoPox8yt41tMMvhZEEV0OMSJYQaQohRyEujZ0gI
 dgswNy1MxWAP2ahp7vcvaaD9e1grEzs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-My1Pl6sNMQGxWNH1smbSkA-1; Sun, 14 Jun 2026 15:09:30 -0400
X-MC-Unique: My1Pl6sNMQGxWNH1smbSkA-1
X-Mimecast-MFC-AGG-ID: My1Pl6sNMQGxWNH1smbSkA_1781464170
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490aadb1386so18042355e9.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464170; x=1782068970; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Rpal2W86mAE9e6bf+ImoOSz7GYFAC1OuHewPuBp7b9c=;
 b=Zp5ptGCEp2SnpESo4S3JQ0/hlXECZ1QoNdeUs7hu54fl8OI/alma9x+Hhdav7+QOIu
 kuSRm93gqHbx1D2BMevfuH7DJGU4vF5Y9VpRWxirzltZ9qP+gnuo77Y4GpGjn+801g49
 ADgF6isjLuvlJs5q7nhzqsg8RFz9DsKvcCvP0EY5XBcjYC8p2Lmku4uzYHRKEZAuB0Jf
 r9a0F8dnmmXzHYIfcfEfU21ZlV0raWBhjLY2BWhcX9pqVp7DRHGQ+RmBcnJf3J8wO+2L
 j/myhzNV5pSdGj3/PC5qmAahutrM/+Tf8mvsmk8h/MqQI5EtkxG+l1q3vPV6BkTYir4U
 l+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464170; x=1782068970;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rpal2W86mAE9e6bf+ImoOSz7GYFAC1OuHewPuBp7b9c=;
 b=JhMX9+iD4iyyUTmYKXgAu47TWZZT2V1BlHCCry10UK46184RLfONE3steaiYoGfmwr
 3i+lTzMLlkArfzz66torJ4yaLAmvaoPuRmsOvNKZSFFpIzfSCm5B7YONi6rvkI1OuZi9
 Zi7trcRKNNoWppAbjt1Ag9B0FL/S0TGoas3hZ1JCRpgfO+0m0rYrk0/osvjvLzwbGN41
 ZmeksGp3SNWNwCi6ul4h62u7XDHz1VH56ydU39qpZnRbOiKDgasyOxDL8xo/jjukAnjF
 zKwG5hbkUYGha9DnzdX9mUn4n5II/UvrLVh+3H/7bdfR2lUP6M8P8SnNTJfJBAhS9RR7
 oc0w==
X-Gm-Message-State: AOJu0Yzaf156y22ieFUZ3B8crFAbuW2FSTsWgtrRu/45FXePc+hMTkfU
 uhDpCwIG2rzDA55S/skxTOxcqz+9GphxEBLRONg/j8jQ9YTMLGndy12VV0vfVeNma8BzD2I1oRG
 5NTyJtztzg/ypjlCaWUO5YJzqDaCVZBiKNsBpjcc4Se4HdORk7ufVuUZICFqUGyYCvv7Iu8fqYS
 UFrnLF6DFXKPWFOYtqUWkgHJPtJLrfFH/yew==
X-Gm-Gg: Acq92OE9TvUP2Yvdv943dXs95/0Yrs7Blgdrv7ICQcU73sskD+cfHEOz+xS799UMX5a
 lxP3rtvfkpZ+/3M447DZnVzNdjRE83xasisw+3I4S+rprUP+6qYLjTDIEV7yUiMtFRW9uIU8jzD
 cs2Jb6h3AfIIJ87OyxgiRYOKITMdcCc/I7lZVoRxjOlfcVn37YyD4gLD/FENM6rPxDDexOcqEnx
 8bEHgS+s2JUEToWRBluqiUpVohBue7pEumyLJFLixD79qeSDpedMKtktKin2+sj2pEDKmlUdm+G
 qkOngXNK9DTGLdhVL+nT3pV7/NeMMhLCSNIqQ0e68QKi/6YLRSM0HWG8PPmvhBhNW3Uw0nd5TO8
 NbCOWeZrb4vJnWrDkkX6rF3Av/2SLiyRMTsxqE9kDdVY=
X-Received: by 2002:a05:600c:c171:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-490ec4dfb03mr109813265e9.14.1781464169573; 
 Sun, 14 Jun 2026 12:09:29 -0700 (PDT)
X-Received: by 2002:a05:600c:c171:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-490ec4dfb03mr109813025e9.14.1781464169031; 
 Sun, 14 Jun 2026 12:09:29 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49220372ed0sm164096875e9.14.2026.06.14.12.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:28 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 089/106] tests: acpi: x86/q35: add WDAT table test case
Message-ID: <d7d7c6902362f4f9b1d597abb75e54d27677f08b.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260303092532.2410177-6-imammedo@redhat.com>
---
 tests/qtest/bios-tables-test.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 510751799e..af6d9b5136 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2534,6 +2534,18 @@ static void test_acpi_isapc_smbios_legacy(void)
     free_test_data(&data);
 }
 
+static void test_acpi_q35_wdat(void)
+{
+    test_data data = {
+        .machine = MACHINE_Q35,
+        .arch    = "x86",
+        .variant = ".wdat",
+    };
+
+    test_acpi_one("-machine wdat=on", &data);
+    free_test_data(&data);
+}
+
 static void test_oem_fields(test_data *data)
 {
     int i;
@@ -2828,6 +2840,7 @@ int main(int argc, char *argv[])
             qtest_add_func("acpi/q35/cxl", test_acpi_q35_cxl);
 #endif
             qtest_add_func("acpi/q35/slic", test_acpi_q35_slic);
+            qtest_add_func("acpi/q35/wdat", test_acpi_q35_wdat);
         }
         if (qtest_has_machine("microvm")) {
             qtest_add_func("acpi/microvm", test_acpi_microvm_tcg);
-- 
MST


