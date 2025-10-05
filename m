Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED90CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFD-0001KQ-SK; Sun, 05 Oct 2025 15:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEc-00085c-MZ
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEa-0006VX-ML
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3aFxoIeUx803jBt31fbg+H6tlPcEQbGoaOIOlfDZlQk=;
 b=fjIG2gi60r2L912QkI0PaDuzZDULQT97Y0MZyDj9SIjQ3OBzMZV6tukgyAyVrq9spxfFmP
 c0GKpKNbewkLNS39btKh0rIh6lsTIr5iG3N74XI57dcZPCUKYG46p6NnyicB4GjvKKr98m
 G3H+3AymS8TqiDEVMGhbst/n7C0svoQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-uq1zFbmuMPOy2kHo9jclLw-1; Sun, 05 Oct 2025 15:17:26 -0400
X-MC-Unique: uq1zFbmuMPOy2kHo9jclLw-1
X-Mimecast-MFC-AGG-ID: uq1zFbmuMPOy2kHo9jclLw_1759691845
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ece0fd841cso2209893f8f.0
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691845; x=1760296645;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3aFxoIeUx803jBt31fbg+H6tlPcEQbGoaOIOlfDZlQk=;
 b=bFvcGl4gKWQwytSAU576pKYgG0ZHFppiJHFg8B6KY139VP5UV//jy+8n6LqekUMZfI
 N7rGniOvk5rYMPysuMSfLBiF3w2fB7yG4Duh/AAQ9FdGYqZx5CJj9sFMotsvqzprVAqu
 xdLpIpJHitWjY9Ofj9XGKuib4YdJBIc4RS0NReidvg7R01G8eUBEGf9BovHGXfR2SmtU
 Xb4dHdtPLOYffYjodE29csaPz2DUiLqnKrh+KbNRu7EOUzRnacjC8drii0wZumMrpr73
 DMX+V5ipbXFsrRMU938SQAxr+2obOfOBBrwzRYvmTm6xZ75cpop4+fkhTgurdggQxN0r
 u2Gg==
X-Gm-Message-State: AOJu0Yx1RJ71PlXnHea/XDXD4h0N1+ssTNdAp50c0KctuI3WCO1JDaMw
 aMwFlG1F515F54a0NCIdeOKfqnPjRummhwckK83mKV0c/yVzS4VakM7GYRes5mRZG9JCnRgQ9Gn
 6oxVU72VdW1j3xuiTUzxuA0P3wDTj4zZAsCgruPJdBh/b2VUTTRT9eE67NBtpBlbagVeqbAKGNB
 /iClwPl13ThJdtx0pWZ5OdkhotsnwZYQJuWQ==
X-Gm-Gg: ASbGncvupvXngvhqb6sX97XOIsZudKfLAgqDwE7iUiwGA6W+SLjJafyQGdfKoLVixi7
 eIZbKieXROMl0d4tGa4JyS+HfQxhNKV9XLyvHrCQwzD3K/cDDD4pGZL4B5VITJgyYrBlktd+W/9
 3ePfl8gNEWY/8qUiUTp4SGMHHM+6NKVCDjT/Rl2qHrYX4MlGFS5HAut7997DzzsJ8bqrXG9OthW
 hOBLJ9/fkcVZ+gaXGp3T6dTHsOKsuIyp2WJ6vyXNtam5H6gCUwcLsuIY1eAztBUE1uJWPcPRVtq
 ira009Hky8cnKspwlzfeJ4xWpxoxfx6cwX13qNc=
X-Received: by 2002:a05:600c:8b45:b0:46e:3dc2:ebac with SMTP id
 5b1f17b1804b1-46e71168aa1mr67453965e9.27.1759691844971; 
 Sun, 05 Oct 2025 12:17:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtSfa6Jgje5/BQ9bLxLZ5mbImqTOeqLt2mPARjKRMASsh58YgMsenlfLpaeNGUrpDk1crB/g==
X-Received: by 2002:a05:600c:8b45:b0:46e:3dc2:ebac with SMTP id
 5b1f17b1804b1-46e71168aa1mr67453745e9.27.1759691844328; 
 Sun, 05 Oct 2025 12:17:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6b77sm17443982f8f.6.2025.10.05.12.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:23 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Subject: [PULL 36/75] smbios: cap DIMM size to 2Tb as workaround for broken
 Windows
Message-ID: <fa82ce2ddee8208c83a5a10bf3ab7348ad3d334a.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Igor Mammedov <imammedo@redhat.com>

With current limit set to match max spec size (2PTb),
Windows fails to parse type 17 records when DIMM size reaches 4Tb+.
Failure happens in GetPhysicallyInstalledSystemMemory() function,
and fails "Check SMBIOS System Memory Tables" SVVP test.
Though not fatal, it might cause issues for userspace apps,
something like [1].

Lets cap default DIMM size to 2Tb for now, until MS fixes it.

1) https://issues.redhat.com/browse/RHEL-81999?focusedId=27731200&page=com.atlassian.jira.plugin.system.issuetabpanels:comment-tabpanel#comment-27731200

PS: It's obvious 32 int overflow math somewhere in Windows,
    MS admitted that it's Windows bug and in a process of fixing it.
    However it's unclear if W10 and earlier would get the fix.
    So however I dislike changing defaults, we heed to work around
    the issue (it looks like QEMU regression while not being it).
    Hopefully 2Tb/DIMM split will last longer until VM memory size
    will become large enough to cause to many type 17 records issue
    again.
PPS:
    Alternatively, instead of messing with defaults, we can create
    a dedicated knob to ask for desired DIMM size cap explicitly
    on CLI. That will let users to enable workaround when they
    hit this corner case. Downside is that knob has to be propagated
    up all mgmt stack, which might be not desirable.
PPPS:
    Yet alternatively, users can configure initial RAM to be less
    than 4Tb and all additional RAM add as DIMMs on QEMU CLI.
    (however it's the job to be done by mgmt which could know
    Windows version and total amount of RAM)

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Fixes: 62f182c97b ("smbios: make memory device size configurable per Machine")
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250901084915.2607632-1-imammedo@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/arm/virt.c     | 1 +
 hw/core/machine.c | 5 ++++-
 hw/i386/pc_piix.c | 1 +
 hw/i386/pc_q35.c  | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index aad557be1a..175023897a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3537,6 +3537,7 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 2)
 static void virt_machine_10_1_options(MachineClass *mc)
 {
     virt_machine_10_2_options(mc);
+    mc->smbios_memory_device_size = 2047 * TiB;
     compat_props_add(mc->compat_props, hw_compat_10_1, hw_compat_10_1_len);
 }
 DEFINE_VIRT_MACHINE(10, 1)
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 7b7a381b0a..681adbb7ac 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1118,8 +1118,11 @@ static void machine_class_init(ObjectClass *oc, const void *data)
      * SMBIOS 3.1.0 7.18.5 Memory Device — Extended Size
      * use max possible value that could be encoded into
      * 'Extended Size' field (2047Tb).
+     *
+     * Unfortunately (current) Windows Server 2025 and earlier do not handle
+     * 4Tb+ DIMM size.
      */
-    mc->smbios_memory_device_size = 2047 * TiB;
+    mc->smbios_memory_device_size = 2 * TiB;
 
     /* numa node memory size aligned on 8MB by default.
      * On Linux, each node's border has to be 8MB aligned
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index caf8bab68e..7b3611e973 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -448,6 +448,7 @@ DEFINE_I440FX_MACHINE_AS_LATEST(10, 2);
 static void pc_i440fx_machine_10_1_options(MachineClass *m)
 {
     pc_i440fx_machine_10_2_options(m);
+    m->smbios_memory_device_size = 2047 * TiB;
     compat_props_add(m->compat_props, hw_compat_10_1, hw_compat_10_1_len);
     compat_props_add(m->compat_props, pc_compat_10_1, pc_compat_10_1_len);
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index e89951285e..6015e639d7 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -384,6 +384,7 @@ DEFINE_Q35_MACHINE_AS_LATEST(10, 2);
 static void pc_q35_machine_10_1_options(MachineClass *m)
 {
     pc_q35_machine_10_2_options(m);
+    m->smbios_memory_device_size = 2047 * TiB;
     compat_props_add(m->compat_props, hw_compat_10_1, hw_compat_10_1_len);
     compat_props_add(m->compat_props, pc_compat_10_1, pc_compat_10_1_len);
 }
-- 
MST


