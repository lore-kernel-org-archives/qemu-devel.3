Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C847CCAC5B8
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 01:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3lGq-0005vk-5F; Tue, 30 Sep 2025 21:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lG0-0005UR-S8
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:03:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lFD-00089l-79
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:03:46 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so58167015e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 18:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759280571; x=1759885371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3d/1PkHX+6ySvY2cHkD8QFKwUFKHxum1HSH+EnGsK+0=;
 b=ie+Wpi+NqHkLSNBCJGSqLtlniguWh0bA7VYS5WUGwL9sZ69Ox6v3JyHR/a2FEpTdI+
 Pya+ZTDFbVE9BjH95cVdyhut95D3gcULHx0ARTvR2shfVNF3NNv2AJ9r5W3bTnrx20/V
 Xk7r1OOjYue/mMV7NaU1QSP5YokojK95pXwKNtAi8Is0wofx1hJ4Ue6pug94Jc5yOE5c
 I9gPdgTsZiXGiC6fCytE5gKeRURBsudPzWxM/qjvuCDQLPlHXl3EntcUqyzKxXXT7Msp
 5x6jVMpkzftL0Xg06PcCMNBbQeW1CRgQsxjQBlgvPtjxqBN3u+akF8i7QFlNmrHwPaiE
 F6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759280571; x=1759885371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3d/1PkHX+6ySvY2cHkD8QFKwUFKHxum1HSH+EnGsK+0=;
 b=dWY88QLFaR7EmySQ2SwxCgy48clKX8aQJ8ZyDYbX3Na7pDJvdudy3rRh6SpghkisqF
 icc6p5IEgSoivW3cNSVdUWb+pvn9pZ3l6Yh27QnNGlzII/A/8aFL3fMRfPdN7MoJegwa
 uEBnbIGEL2EfSPvS9mrGynX+/3jgvM/scTXOLMcoh96JRWdb5f7LQa0mHZevbmGH1WWp
 addgkaPfud/GFShJJ5vLsDorjgIulyAeibb2YVEyPUyVe8UfkpktqFiXQ8r0vKOJHtEb
 qNFaodDlcX6Z5hLCjfquMXP7dz5PFhkmTZVY48HP60Pz6+YVsMCe1T906A2pPLOeE+QP
 lIIA==
X-Gm-Message-State: AOJu0YyfMajOEa2W9euvjtsG8+RCkjx8bvU2ZNM+4VxpfjZbjasPZv7l
 6s6Q/YjBtMYF74duHxuU/i2D5pfZCYgKM4asHklpS9NMBoGw2ZpDgIpzICwYlv3KRctROLCEAz1
 rWE+65x0ssQ==
X-Gm-Gg: ASbGncvjHXDI53YJxNtwFAoIQKHGbIqmvWHf5Iolk99qpPrBfdyD6JIUkJgzdY8S7zJ
 NgiF8Kkp7iaudOzUn325oTCImBuvo2JOlNmfY1QG7ZklNOwFmmRMbLLXFohLVlnPWp4zMpbcr4S
 uDrqx+tveCMfOBMydnC3CNxEtIMEA8JvVckDmkwJ2jRXx4IblpXMyzJ5LWbnEIkmeUhCk8D95OX
 ij3q6uDodgBvWLgqCLnrfRLc6ERmhSB28+kJM1s3EKarErIpZ0ThWD9Vd36eNwIs3V0SLf7/7U+
 X2qJh2vM7jzOcXRkwRwyPVo286yhVNYLXsE+EUUJ+ldYxgg1ZBe4ftbLNoqiAQZ4+rAs+EeIrqm
 8zyxzsIM4HPW4qFklkHMjcaAiu3F9eMxg5ldYZEA14s+gX6cT5LMXFgeCB5LGbo7kouCmv55w0I
 h84VhRePMQZ0expnQptgvboEzOTe+X3wImCBb2p/asjsQ=
X-Google-Smtp-Source: AGHT+IHRdDsT1RAOSF3kAiKK2Tu3EectRNRiOrgC1ZbY7bH5hpBDTXxVCHt05ceFQOLhIYQooXwHcA==
X-Received: by 2002:a05:600c:468f:b0:46e:447d:858e with SMTP id
 5b1f17b1804b1-46e612dce3dmr13937645e9.28.1759280571088; 
 Tue, 30 Sep 2025 18:02:51 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm24587426f8f.24.2025.09.30.18.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 18:02:49 -0700 (PDT)
From: salil.mehta@opnsrc.net
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	mst@redhat.com
Cc: salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 imammedo@redhat.com, armbru@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 will@kernel.org, ardb@kernel.org, oliver.upton@linux.dev,
 pbonzini@redhat.com, gshan@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, wangzhou1@hisilicon.com,
 linuxarm@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com
Subject: [PATCH RFC V6 16/24] arm/virt/acpi: Update ACPI DSDT Tbl to include
 'Online-Capable' CPUs AML
Date: Wed,  1 Oct 2025 01:01:19 +0000
Message-Id: <20251001010127.3092631-17-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=unavailable autolearn_force=no
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

From: Salil Mehta <salil.mehta@huawei.com>

This change emits AML in DSDT to support vCPU deferred online-capability on
arm/virt. It wires the CPU OSPM coordination paths so that CPUs which are
administratively disabled at boot can be brought online later under policy,
providing hotplug-like functionality without claiming full hotplug support.

The AML connects the CPUS scan method to a GED handler so QEMU and the
guest OSPM can coordinate CPU add/remove while the VM is running (e.g.
device-check, eject-request, _EJ0, CPU scan, _OST status reporting).

It also fixes an ACPI namespace load error:
  AE_NOT_FOUND resolving \_SB.GED.PSCN
Error excerpt:
[    0.070518] ACPI BIOS Error (bug): Object does not exist: GED_
[    0.071457] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.GED.PSCN],
[    0.073084] ACPI Error: AE_NOT_FOUND, During name lookup/catalog

Root cause was build order and naming: the PSCN handler must be created
under \_SB.GED using a short ACPI 'NameSeg', and referenced elsewhere by its
fully qualified path. The GED device (and PSCN) are now defined before the CPUS
AML, preventing the early lookup failure.

Notes:
  * CPU enumeration remains from MADT (GICC). CPU0 is Enabled; other CPUs
    may be Disabled but Online-Capable.
  * Policy (which CPUs start disabled, later enabled) is administrative
    and not decided by OSPM.

Tested: boot with EDK2/ACPI; no AE_NOT_FOUND for \_SB.GED.PSCN; generic CPU
devices register; sysfs topology group warnings do not occur.

           DSDT.dsl (Not Working)                                                    DSDT.dsl (Working)
           ---------------------                                                     ------------------

DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)        DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
{                                                                        {
    Scope (\_SB)                                                             Scope (\_SB)
    {                                                                        {
        Scope (_SB)                                                              Device (\_SB.GED)
        {                                                                        {
            Device (\_SB.CPUR)                                                       Name (_HID, "ACPI0013"
            {                                                                        Name (_UID, "GED")
	    [...]                                                                    Name (_CRS, ResourceTemplate ()
            Device (\_SB.CPUS)                                                 	     [...]
            {                                                                        Method (_EVT, 1, Serialized)
                Name (_HID, "ACPI0010")                                              {
                Name (_CID, EisaId ("PNP0A05"))                                          Local0 = ESEL /* \_SB_.GED_.ESEL */
                Method (CTFY, 2, NotSerialized)                                          If (((Local0 & 0x02) == 0x02))
                {	                                                                 {
	    [...]                                                                             Notify (PWRB, 0x80)
                Method (CSTA, 1, Serialized)                                             }
                {
	    [...]                                                                        If (((Local0 & 0x08) == 0x08))
                Method (CEJ0, 1, Serialized)                                             {
                {                                                                            \_SB.GED.PSCN ()
	    [...]                                                                        }
                Method (CSCN, 0, Serialized)                                         }
                {                                                                }
	    [...]
                Method (COST, 4, Serialized)                                     Scope (_SB)
                {			                                         {
	    [...]                                                                    Device (\_SB.CPUR)
                Device (C000)                                                        {
                {		                                                    	  [...]
	    [...]                                                                    Device (\_SB.CPUS)
                Device (C001)                                                        {
                {                                                                         Name (_HID, "ACPI0010")
	    [...]                                                                         Name (_CID, EisaId ("PNP0A05"))
                Device (C002)                                                             Method (CTFY, 2, NotSerialized)
                {		                                                          {
	    [...]                                                                    [...]
                Device (C003)                                                             Method (CSTA, 1, Serialized)
                {                                                                         {
	    [...]                                                                    [...]
                Device (C004)                                                             Method (CEJ0, 1, Serialized)
                {		                                                          {
	    [...]                                                                    [...]
                Device (C005)                                                             Method (CSCN, 0, Serialized)
                {			                                                  {
            }                                                                        [...]
        }                                                                                 Method (COST, 4, Serialized)
                                                                                          {
        Method (\_SB.GED.PSCN, 0, NotSerialized)                                     [...]
        {                                                                                 Device (C000)
            \_SB.CPUS.CSCN ()                                                             {
        }                                                                            [...]
                                                                                          Device (C001)
        Device (COM0)                                                                     {
        {	                                                                     [...]
	    [...]                                                                         Device (C002)
                                                                                          {
        Device (\_SB.GED)                                                            [...]
        {                                                                                 Device (C003)
            Name (_HID, "ACPI0013")                                                       {
            Name (_UID, "GED")                                                       [...]
            Name (_CRS, ResourceTemplate ()                                               Device (C004)
            {	                                                                          {
	    [...]                                                                    [...]
            OperationRegion (EREG, SystemMemory, 0x09080000, 0x04)                        Device (C005)
            Field (EREG, DWordAcc, NoLock, WriteAsZeros)                                  {
            {	                                                                      }
	    [...]                                                                 }

            Method (_EVT, 1, Serialized)                                          Method (\_SB.GED.PSCN, 0, NotSerialized)
            {                                                                     {
                Local0 = ESEL                                                         \_SB.CPUS.CSCN ()
                If (((Local0 & 0x02) == 0x02))                                    }
                {
                    Notify (PWRB, 0x80)                                           Device (COM0)
                }                                                                 {
                                                                                      [...]
                If (((Local0 & 0x08) == 0x08))                               }
                {                                                        }
                    \_SB.GED.PSCN ()
                }
            }
        }

        Device (PWRB)
        {
	    [...]
    }
}

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt-acpi-build.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 7c24dd6369..5e5acb3026 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -931,6 +931,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     Aml *scope, *dsdt;
     MachineState *ms = MACHINE(vms);
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
     const MemMapEntry *memmap = vms->memmap;
     const int *irqmap = vms->irqmap;
     AcpiTable table = { .sig = "DSDT", .rev = 2, .oem_id = vms->oem_id,
@@ -946,7 +947,30 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
      * the RTC ACPI device at all when using UEFI.
      */
     scope = aml_scope("\\_SB");
-    acpi_dsdt_add_cpus(scope, vms);
+    if (vms->acpi_dev) {
+        build_ged_aml(scope, "\\_SB."GED_DEVICE,
+                      HOTPLUG_HANDLER(vms->acpi_dev),
+                      irqmap[VIRT_ACPI_GED] + ARM_SPI_BASE, AML_SYSTEM_MEMORY,
+                      memmap[VIRT_ACPI_GED].base);
+    } else {
+        acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
+                           (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
+    }
+
+    /*
+     * If the machine supports bringing administratively disabled vCPUs
+     * deferred-online under policy, build AML to coordinate the addition and
+     * removal of CPUs gracefully with the OSPM while the VM is running. This
+     * includes events such as device-check, eject-request, ejection (_EJ0),
+     * CPU scan, _OST status reporting, etc.
+     */
+    if (vms->acpi_dev && mc->has_online_capable_cpus) {
+        acpi_build_cpus_aml(scope, memmap[VIRT_ACPI_CPUPS].base, "\\_SB",
+                            AML_GED_EVT_CPUPS_SCAN_METHOD);
+    } else {
+        acpi_dsdt_add_cpus(scope, vms);
+    }
+
     acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0],
                        (irqmap[VIRT_UART0] + ARM_SPI_BASE), 0);
     if (vms->second_ns_uart_present) {
@@ -961,15 +985,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                          (irqmap[VIRT_MMIO] + ARM_SPI_BASE),
                          0, NUM_VIRTIO_TRANSPORTS);
     acpi_dsdt_add_pci(scope, memmap, irqmap[VIRT_PCIE] + ARM_SPI_BASE, vms);
-    if (vms->acpi_dev) {
-        build_ged_aml(scope, "\\_SB."GED_DEVICE,
-                      HOTPLUG_HANDLER(vms->acpi_dev),
-                      irqmap[VIRT_ACPI_GED] + ARM_SPI_BASE, AML_SYSTEM_MEMORY,
-                      memmap[VIRT_ACPI_GED].base);
-    } else {
-        acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
-                           (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
-    }
 
     if (vms->acpi_dev) {
         uint32_t event = object_property_get_uint(OBJECT(vms->acpi_dev),
-- 
2.34.1


