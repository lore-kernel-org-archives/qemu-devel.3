Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35E1E77173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 09:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKa3x-0007eq-PH; Mon, 09 Dec 2024 04:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tKa3l-0007dg-Fw; Mon, 09 Dec 2024 04:28:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tKa3j-00026P-FB; Mon, 09 Dec 2024 04:28:09 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id ABACE5C45AC;
 Mon,  9 Dec 2024 09:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0977FC4CED1;
 Mon,  9 Dec 2024 09:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733736476;
 bh=dzYUBItc4irdACdEPJd49K0RlN9o6WNX96pXvrHVGak=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=RR81/dmv+dBfwl8aSlkPenAiQgPdAO67pgFqilnYYneyuLTq3oJ8UbEuD6vUGtiKA
 ZwQa4einWUMG9dVddbKqKN3qwnaEO/Wn5OP24JfMV7+6kK0TCCXvJ6rJ1QCGEfu7Ul
 l2QBCZLJvuSDV2ifF4NAmm9eEcT3AqbV9Qi04A9FwhI7+dYQHG+zNLqXB+MlMOUSE9
 ynV8Q658MAEdzsqdat5gFx9v4QYaLJavhlaPcEDTR1flaSi5dr5s2skfUyng6841YV
 IisT2N+F/S3pwx3jF3lpBAsmNpGa7+P7G2xlhH1ILPXKWZ7mbXsB7eR1Ju10uits/+
 OMI2VAnCsKWpw==
Date: Mon, 9 Dec 2024 10:27:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 13/15] acpi/ghes: move offset calculus to a separate
 function
Message-ID: <20241209102750.03bc6ec5@foz.lan>
In-Reply-To: <20241204102413.31c8d76d@imammedo.users.ipa.redhat.com>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
 <e5661a6383449675b28e15c8479ebca42c939368.1732266152.git.mchehab+huawei@kernel.org>
 <20241203125143.7171892a@imammedo.users.ipa.redhat.com>
 <20241203144730.47b8ca86@foz.lan>
 <20241204085440.4640a476@imammedo.users.ipa.redhat.com>
 <20241204095635.512a44d5@foz.lan>
 <20241204102413.31c8d76d@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -75
X-Spam_score: -7.6
X-Spam_bar: -------
X-Spam_report: (-7.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Em Wed, 4 Dec 2024 10:24:13 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Wed, 4 Dec 2024 09:56:35 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Em Wed, 4 Dec 2024 08:54:40 +0100
> > Igor Mammedov <imammedo@redhat.com> escreveu:
> >   
> > > On Tue, 3 Dec 2024 14:47:30 +0100
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > >     
> > > > Em Tue, 3 Dec 2024 12:51:43 +0100
> > > > Igor Mammedov <imammedo@redhat.com> escreveu:
> > > >       
> > > > > On Fri, 22 Nov 2024 10:11:30 +0100
> > > > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > > > >         

...

> > > > > > +static void get_hw_error_offsets(uint64_t ghes_addr,
> > > > > > +                                 uint64_t *cper_addr,
> > > > > > +                                 uint64_t *read_ack_register_addr)
> > > > > > +{          
> > > > > 
> > > > >         
> > > > > > +    if (!ghes_addr) {
> > > > > > +        return;
> > > > > > +    }          
> > > > > 
> > > > > why do we need this check?        
> > > > 
> > > > It is a safeguard measure to avoid crashes and OOM access. If fw_cfg 
> > > > callback doesn't fill it properly, this will be zero.      
> > > 
> > > shouldn't happen, but yeah it firmware job to write back addr
> > > which might happen for whatever reason (a bug for example).
> > >    
> > 
> > The main reason I added it is that, after the second series, it could 
> > also happen if there's something wrong with the backward compat logic.
> > 
> > So, both here and after switching to HEST-based offsets, I opted
> > to explicitly test.
> >   
> > > Perhaps push this up to the stack, so we don't have to deal
> > > with scattered checks in ghes code.
> > > 
> > > kvm_arch_on_sigbus_vcpu() looks like a goo candidate for check
> > > and warn_once if that ever happens.
> > > It already calls acpi_ghes_present() which resolves GED device
> > > and then later we duplicate this job in ghes_record_cper_errors()
> > > 
> > > so maybe rename acpi_ghes_present to something like AcpiGhesState* acpi_ghes_get_state()
> > > and call it instead. And then move ghes_addr check/warn_once there.
> > > This way the rest of ghes code won't have to deal handling practically
> > > impossible error conditions that cause reader to wonder why it might happen.    
> > 
> > I'll look on it.

Wrote the cleanup patch. See enclosed. I'll place it at the end of the
second series.

> > Yet, if ok for you, I would prefer dealing with this
> > once we have a bigger picture, e.g. once we merge those tree series:
> > 
> > 	- cleanup series (this one);
> > 	- HEST offset (I'll be sending a new version today);  
> ok, lets revisit this point after this series.
> Since at this point we should have a clean picture of how new code
> works.

 
Thanks,
Mauro

[PATCH] acpi/ghes: Cleanup the code which gets ghes ged state

Move the check logic into a common function and simplify the
code which checks if GHES is enabled and was properly setup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
index 7cec1812dad9..fbabf955155a 100644
--- a/hw/acpi/ghes-stub.c
+++ b/hw/acpi/ghes-stub.c
@@ -16,7 +16,7 @@ int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
     return -1;
 }
 
-bool acpi_ghes_present(void)
+AcpiGhesState *acpi_ghes_get_state(void)
 {
-    return false;
+    return NULL;
 }
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index a9c5315c1936..17aada9ee352 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -420,10 +420,6 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
                                  uint64_t *cper_addr,
                                  uint64_t *read_ack_register_addr)
 {
-    if (!ghes_addr) {
-        return;
-    }
-
     /*
      * non-HEST version supports only one source, so no need to change
      * the start offset based on the source ID. Also, we can't validate
@@ -451,10 +447,6 @@ static void get_ghes_source_offsets(uint16_t source_id, uint64_t hest_addr,
     uint64_t err_source_struct, error_block_addr;
     uint32_t num_sources, i;
 
-    if (!hest_addr) {
-        return;
-    }
-
     cpu_physical_memory_read(hest_addr, &num_sources, sizeof(num_sources));
     num_sources = le32_to_cpu(num_sources);
 
@@ -513,7 +505,6 @@ void ghes_record_cper_errors(const void *cper, size_t len,
                              uint16_t source_id, Error **errp)
 {
     uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
-    AcpiGedState *acpi_ged_state;
     AcpiGhesState *ags;
 
     if (len > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
@@ -521,13 +512,10 @@ void ghes_record_cper_errors(const void *cper, size_t len,
         return;
     }
 
-    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
-                                                       NULL));
-    if (!acpi_ged_state) {
-        error_setg(errp, "Can't find ACPI_GED object");
+    ags = acpi_ghes_get_state();
+    if (!ags) {
         return;
     }
-    ags = &acpi_ged_state->ghes_state;
 
     if (!ags->hest_lookup) {
         get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
@@ -537,11 +525,6 @@ void ghes_record_cper_errors(const void *cper, size_t len,
                                 &cper_addr, &read_ack_register_addr, errp);
     }
 
-    if (!cper_addr) {
-        error_setg(errp, "can not find Generic Error Status Block");
-        return;
-    }
-
     cpu_physical_memory_read(read_ack_register_addr,
                              &read_ack_register, sizeof(read_ack_register));
 
@@ -606,7 +589,7 @@ int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
     return 0;
 }
 
-bool acpi_ghes_present(void)
+AcpiGhesState *acpi_ghes_get_state(void)
 {
     AcpiGedState *acpi_ged_state;
     AcpiGhesState *ags;
@@ -615,8 +598,14 @@ bool acpi_ghes_present(void)
                                                        NULL));
 
     if (!acpi_ged_state) {
-        return false;
+        return NULL;
     }
     ags = &acpi_ged_state->ghes_state;
-    return ags->present;
+    if (!ags->present) {
+        return NULL;
+    }
+    if (!ags->hw_error_le && !ags->hest_addr_le) {
+        return NULL;
+    }
+    return ags;
 }
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 2e8405edfe27..64fe2b5bea65 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -91,10 +91,11 @@ void ghes_record_cper_errors(const void *cper, size_t len,
                              uint16_t source_id, Error **errp);
 
 /**
- * acpi_ghes_present: Report whether ACPI GHES table is present
+ * acpi_ghes_get_state: Get a pointer for ACPI ghes state
  *
- * Returns: true if the system has an ACPI GHES table and it is
- * safe to call acpi_ghes_memory_errors() to record a memory error.
+ * Returns: a pointer to ghes state if the system has an ACPI GHES table,
+ * it is enabled and it is safe to call acpi_ghes_memory_errors() to record
+ * a memory error. Returns false, otherwise.
  */
-bool acpi_ghes_present(void);
+AcpiGhesState *acpi_ghes_get_state(void);
 #endif
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b4260467f8b9..7802c32fb7e0 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2369,7 +2369,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
 
     assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
 
-    if (acpi_ghes_present() && addr) {
+    if (acpi_ghes_get_state() && addr) {
         ram_addr = qemu_ram_addr_from_host(addr);
         if (ram_addr != RAM_ADDR_INVALID &&
             kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {

