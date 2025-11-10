Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDCECCFA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 23:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIar5-0004h2-8A; Mon, 10 Nov 2025 17:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vIaqt-0004Qd-QD
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 17:59:14 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vIaqs-0004X9-3g
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 17:59:11 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b713c7096f9so520403766b.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 14:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762815548; x=1763420348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XJ/aCtEzIF0pB/zF0oJfUqwREKGpwVpCTU/gtPJxffU=;
 b=FZIu3MWFC2BQFSGmwd6Ev1C69GBnalfAvUFy6uKfIIfySv7vE72GBpFfV+Imk3q+Dd
 v24vOtHuBcIg2E2J+iAeR3yFxakHuEMNefkqICQW48KM6eu4Zo9hAasJuzwy8LGEqen/
 G7uVeYlgTHLDSHIaJzMmFW5rVkb0Z0dpLYUpWqstWz8SOryKp3vxfpg7aL0B68ZJ2rQc
 PLYi8zPjETzJJ31SPYHZ4sSpmZNSR0EM16ne9SrXeG5NaYhpxUePvyxNFi4heoA3RKbP
 cBN8hlmkOceonq7ndtSCjEFd299PBLq9tTu1PCz1TvvxAMPpbZqjsusC5nkEj0HYn8JD
 rqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762815548; x=1763420348;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XJ/aCtEzIF0pB/zF0oJfUqwREKGpwVpCTU/gtPJxffU=;
 b=QidfNL1sbGLgMNZIz+lXg+FHrFW8bp8a/pP4yeewS7y8sIZdKxnCsDX1a+d8jSKbhs
 eX7iROue5eoVEDbCVpsDqHs5OKJKdoCBh94y8BLY9k0vqzEyebDoKxMkeUrb44mMltcp
 Ed7WAiLjz00Qm2LnPKSRdluCqUmML+ZD4QJeTbaz2k/AlZXh7z6JBHG64fu1S72UbVGf
 5mkkhimYGzOdhtDDn0waT87Zj28vet4TtyVw8lzEpHig+yxOiAJM9cenz3qpUYjs/x9v
 1HGilcO5stVoFswZboDArkmHiQ0hVMfQwxq+OjaNU2APG+GRkqliFDQa8vuvRU7vZD6M
 dMhg==
X-Gm-Message-State: AOJu0Yztvtn7kd5CmgzDIUpbljBoou1s68l7DQKlgMKq6+3CRomXYB40
 gi5cwWuwMZIuKFqJOFMOOoq39BpwVqcJ9wJhggWYMtA5tf6m1BzA4FSrd32Pfg==
X-Gm-Gg: ASbGncsKWyKr7/ToxKKqenBWDbth0s9k3U8pgAIrtmPKzYJXCPkChFyCQe1MxIrAKii
 aEsIYLequmZ2s5H/sJyjZ3gUc63eFf1jtUfbnJs9o/WJPEVddDRjeSe/R/cCb3ZLkf/wC/MAxyy
 xL3klaWSRJ+BOsIyBdc902fJjY7st67FlESFuhx8f5JR8LKWlKuNAzOqrbeYN21ok1A+YL7EyZ9
 l7PsDteOYUsyKU2MfBwEJBPxLkHu0mmNy2NEob79g/TqYjLJxoVCfdDxQ6JP5tAxJNQdhHMJHo9
 g3jzyQzs7qmt52jIC14KvtBmlDFq6PICH4xSCkUc3KYqQUTcWTGEsJ1hIOcx6G7Ru/IAeAMuNp5
 Szde/H/3WHItsEXem9IgfMxug2+lmME3owSrlN3/bLpelGGxsPA4ykAQQNM1D7NgcTn4pcV9gtE
 5vxwq/KbqwESZQnvpSJwmWuIZn8U0lVxaqzPzcV2ojFB0MFzSIWEk7mStxvyyQE+54wBmroC2Te
 BohKsL/CWUsZhUVaPTFbW8aQffcOOucTLI=
X-Google-Smtp-Source: AGHT+IE8yPg06rj5njcFQDbyIehPCrWn7Sw/7AUjC4DyI4HP5tG60fI7QlSPLV+qYRBw/c8Zhb21HA==
X-Received: by 2002:a17:907:6ea5:b0:b5b:3ab0:a5b7 with SMTP id
 a640c23a62f3a-b72e0562593mr976435566b.42.1762815547315; 
 Mon, 10 Nov 2025 14:59:07 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-23dc-7300-bdbc-21c7-75fc-dd84.310.pool.telefonica.de.
 [2a02:3100:23dc:7300:bdbc:21c7:75fc:dd84])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bf9bd741sm1165777866b.57.2025.11.10.14.59.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 14:59:06 -0800 (PST)
Date: Mon, 10 Nov 2025 22:59:04 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 mohamed@unpredictable.fr
CC: Pedro Barbuda <pbarbuda@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v10 13/28] whpx: change memory management logic
In-Reply-To: <20251029165510.45824-14-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
 <20251029165510.45824-14-mohamed@unpredictable.fr>
Message-ID: <463DE817-A72E-4ACF-B6A4-C40E879B4107@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
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



Am 29=2E Oktober 2025 16:54:55 UTC schrieb Mohamed Mediouni <mohamed@unpre=
dictable=2Efr>:
>This allows edk2 to work on Arm, although u-boot is still not functional=
=2E

This seems to fix https://gitlab=2Ecom/qemu-project/qemu/-/issues/513, at =
least it works for me with x86 SeaBIOS via pflash=2E Also, https://gitlab=
=2Ecom/qemu-project/qemu/-/issues/934 looks like a duplicate=2E

I wonder if this patch could be 10=2E2 material such that OVMF can finally=
 work with WHPX=2E

Best regards,
Bernhard

>
>Signed-off-by: Mohamed Mediouni <mohamed@unpredictable=2Efr>
>---
> accel/whpx/whpx-common=2Ec | 101 +++++++++++++++------------------------
> 1 file changed, 38 insertions(+), 63 deletions(-)
>
>diff --git a/accel/whpx/whpx-common=2Ec b/accel/whpx/whpx-common=2Ec
>index c69792e638=2E=2Eaefec4bc8f 100644
>--- a/accel/whpx/whpx-common=2Ec
>+++ b/accel/whpx/whpx-common=2Ec
>@@ -258,89 +258,64 @@ void whpx_vcpu_kick(CPUState *cpu)
>  * Memory support=2E
>  */
>=20
>-static void whpx_update_mapping(hwaddr start_pa, ram_addr_t size,
>-                                void *host_va, int add, int rom,
>-                                const char *name)
>+static void whpx_set_phys_mem(MemoryRegionSection *section, bool add)
> {
>     struct whpx_state *whpx =3D &whpx_global;
>-    HRESULT hr;
>-
>-    /*
>-    if (add) {
>-        printf("WHPX: ADD PA:%p Size:%p, Host:%p, %s, '%s'\n",
>-               (void*)start_pa, (void*)size, host_va,
>-               (rom ? "ROM" : "RAM"), name);
>-    } else {
>-        printf("WHPX: DEL PA:%p Size:%p, Host:%p,      '%s'\n",
>-               (void*)start_pa, (void*)size, host_va, name);
>-    }
>-    */
>-
>-    if (add) {
>-        hr =3D whp_dispatch=2EWHvMapGpaRange(whpx->partition,
>-                                         host_va,
>-                                         start_pa,
>-                                         size,
>-                                         (WHvMapGpaRangeFlagRead |
>-                                          WHvMapGpaRangeFlagExecute |
>-                                          (rom ? 0 : WHvMapGpaRangeFlagW=
rite)));
>-    } else {
>-        hr =3D whp_dispatch=2EWHvUnmapGpaRange(whpx->partition,
>-                                           start_pa,
>-                                           size);
>-    }
>-
>-    if (FAILED(hr)) {
>-        error_report("WHPX: Failed to %s GPA range '%s' PA:%p, Size:%p b=
ytes,"
>-                     " Host:%p, hr=3D%08lx",
>-                     (add ? "MAP" : "UNMAP"), name,
>-                     (void *)(uintptr_t)start_pa, (void *)size, host_va,=
 hr);
>+    MemoryRegion *area =3D section->mr;
>+    bool writable =3D !area->readonly && !area->rom_device;
>+    WHV_MAP_GPA_RANGE_FLAGS flags;
>+    uint64_t page_size =3D qemu_real_host_page_size();
>+    uint64_t gva =3D section->offset_within_address_space;
>+    uint64_t size =3D int128_get64(section->size);
>+    HRESULT res;
>+    void *mem;
>+
>+    if (!memory_region_is_ram(area)) {
>+        if (writable) {
>+            return;
>+        } else if (!memory_region_is_romd(area)) {
>+             add =3D false;
>+        }
>     }
>-}
>-
>-static void whpx_process_section(MemoryRegionSection *section, int add)
>-{
>-    MemoryRegion *mr =3D section->mr;
>-    hwaddr start_pa =3D section->offset_within_address_space;
>-    ram_addr_t size =3D int128_get64(section->size);
>-    unsigned int delta;
>-    uint64_t host_va;
>=20
>-    if (!memory_region_is_ram(mr)) {
>-        return;
>+    if (!QEMU_IS_ALIGNED(size, page_size) ||
>+        !QEMU_IS_ALIGNED(gva, page_size)) {
>+        /* Not page aligned, so we can not map as RAM */
>+        add =3D false;
>     }
>=20
>-    delta =3D qemu_real_host_page_size() - (start_pa & ~qemu_real_host_p=
age_mask());
>-    delta &=3D ~qemu_real_host_page_mask();
>-    if (delta > size) {
>-        return;
>-    }
>-    start_pa +=3D delta;
>-    size -=3D delta;
>-    size &=3D qemu_real_host_page_mask();
>-    if (!size || (start_pa & ~qemu_real_host_page_mask())) {
>+    if (!add) {
>+        res =3D whp_dispatch=2EWHvUnmapGpaRange(whpx->partition,
>+                gva, size);
>+        if (!SUCCEEDED(res)) {
>+            error_report("WHPX: failed to unmap GPA range");
>+            abort();
>+        }
>         return;
>     }
>=20
>-    host_va =3D (uintptr_t)memory_region_get_ram_ptr(mr)
>-            + section->offset_within_region + delta;
>+    flags =3D WHvMapGpaRangeFlagRead | WHvMapGpaRangeFlagExecute
>+     | (writable ? WHvMapGpaRangeFlagWrite : 0);
>+    mem =3D memory_region_get_ram_ptr(area) + section->offset_within_reg=
ion;
>=20
>-    whpx_update_mapping(start_pa, size, (void *)(uintptr_t)host_va, add,
>-                        memory_region_is_rom(mr), mr->name);
>+    res =3D whp_dispatch=2EWHvMapGpaRange(whpx->partition,
>+         mem, gva, size, flags);
>+    if (!SUCCEEDED(res)) {
>+        error_report("WHPX: failed to map GPA range");
>+        abort();
>+    }
> }
>=20
> static void whpx_region_add(MemoryListener *listener,
>                            MemoryRegionSection *section)
> {
>-    memory_region_ref(section->mr);
>-    whpx_process_section(section, 1);
>+    whpx_set_phys_mem(section, true);
> }
>=20
> static void whpx_region_del(MemoryListener *listener,
>                            MemoryRegionSection *section)
> {
>-    whpx_process_section(section, 0);
>-    memory_region_unref(section->mr);
>+    whpx_set_phys_mem(section, false);
> }
>=20
> static void whpx_transaction_begin(MemoryListener *listener)

