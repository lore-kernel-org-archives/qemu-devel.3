Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423BCFE51FB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGDT6-0008By-CT; Fri, 24 Apr 2026 06:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wGDT5-0008BQ-1S
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:09:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wGDT3-0006v7-4W
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777025339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sGYRTBNGaO6SP0mLQDmm/GmN8NX1ahl6pRyXwK8Iies=;
 b=Gp9JBzEao5dXvvsZcQLWYinggJiUC8spFIs1CGGeJWuJxORMCK3JWsiszE3t9Gnexs8BaB
 +QKObWtXS7mawFN8aEDHtvJKgMm+2q69JU6qP0RymCyRb9xUmM/cOe81yTn9nVlR41IdPK
 x3if9ILfQ5N2Y+hc2XOsBivOKZrdZUE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-N1mKPLUtNdmRqASV3xdtBg-1; Fri, 24 Apr 2026 06:08:57 -0400
X-MC-Unique: N1mKPLUtNdmRqASV3xdtBg-1
X-Mimecast-MFC-AGG-ID: N1mKPLUtNdmRqASV3xdtBg_1777025337
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-488d56f87e8so62067555e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 03:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777025336; x=1777630136; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sGYRTBNGaO6SP0mLQDmm/GmN8NX1ahl6pRyXwK8Iies=;
 b=YQkodPIn+kbHE20oQl0UpL8luuTPpb76iGAnPR3pzeyeopZcR3FgrieFEjFAY7kyDz
 IGA8X4swAIXHlHHt4qKJfBmPdB1nyNuaf+7JtK3tXw2v0AMRwZpSHWOV1T0BKpWhG9zY
 AkrVSPyCwGBuH9VVFSPjxmdld8BC+GK0FjISrf6bYhoRg8PD6DzoMvk60qZz1w6aHDtT
 1R72PVuo0Dx29H419x9BWs05xQ/Km49vQzad3z8YTGYbgdY7ZBh8SFRmDOGjakfHtj7D
 hf7FDpLAXh2CiJ9xdDm/YI6J5EfbBxy96FHKHwHnY5VDxlpBH3UgijrMrEumeFGlkrPf
 vzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777025336; x=1777630136;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sGYRTBNGaO6SP0mLQDmm/GmN8NX1ahl6pRyXwK8Iies=;
 b=POmiRvKEEBhk4r/RygDto3pFiOVhz/wjBgrJvLVv/AxRN9FYwsjQVXyQvSlDNUBlg3
 3QX659jEYtsmYeLFyEX3wi0C3s23WD6HVhvzxliipoBQEz7gLmmr+CfF2ZVtfm3G3sGg
 O2TejET1qs1bNHhBRdUnVGGgIpXKg6ARWWJKw6+zuNqp6iQhztHR56NcaABl5CHpcSuZ
 n4dRTn5bE8I1GuA1Xg6bBjIFM8pm71AuqDf9rhai62E1j8J6c3KIHM1p1Q39cYP1NSst
 bL5e0CKfvL5rBjZCYMPfi9gXp3VrOAD7LKJUMX2ZrtsWNdSY1rAlSkuDoa684Lbq+2GG
 qu2A==
X-Gm-Message-State: AOJu0YxlTMEVyOpZQCCyKq5+CSAbksF4Fsqio2MpDZQPz4JQx/yy+g2R
 mkiN0SRR07tsw3tdAK+leXxfQf4/GaIhoFJ7YOnv2Ztz1CQ+yTzaqkaGRgDKputbRamaVby2g5l
 ou2GcXUSNmXwCpQVQacv75dwuG2tV7lT3JZ+iOrraBGWw5lmP1M/+LLkG
X-Gm-Gg: AeBDiesR7KFk7VDz2iE3IEDXLk2Tzh3fj+6Rrl8oA4vzIwqId7Xz98rDrDPd86nzUyk
 68MhcV8l+M7Sd8OeMK5Mf4Wz58n+/egdQRCORQn0ny00vmEr1SBjsmwbxbketXPZpz++lZTzEXG
 abGnYiYluERQb/+IRCkmVeMmJrxHouIGG9S0rdBj73oFBPmGt5FMluTDVRc0/4ejUGcgRd/xz52
 f0fpP23TAcrfl2wR9iFwbywZ3ImocdqAVaoakATROGSC1e+dcWxIZi6EKIJ3qLmY/Sz2rbg6jOt
 j46oRub1pJbEwkaFaz63KjqDAFMmf6RMv7lRc4+kD2pfIsjmkmIFkCrG+lFn96WUn8GliZkF1rS
 OTNKjg3Vul4y8UHrb2fzNLDxsln/CXG6CiMtyqA==
X-Received: by 2002:a05:600c:4714:b0:48a:5574:3a5b with SMTP id
 5b1f17b1804b1-48a55743d05mr221582075e9.27.1777025336422; 
 Fri, 24 Apr 2026 03:08:56 -0700 (PDT)
X-Received: by 2002:a05:600c:4714:b0:48a:5574:3a5b with SMTP id
 5b1f17b1804b1-48a55743d05mr221581595e9.27.1777025335930; 
 Fri, 24 Apr 2026 03:08:55 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4899dc95920sm103793105e9.6.2026.04.24.03.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 03:08:55 -0700 (PDT)
Date: Fri, 24 Apr 2026 12:08:53 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Katherine Leaver <katherine.j.leaver@gmail.com>
Subject: Re: [PATCH 6/6] hw/uefi: avoid possibly unaligned variable_auth_2
 struct field access
Message-ID: <aetATeu-Nbs1pjcP@leonardi-redhat>
References: <20260422092910.444997-1-kraxel@redhat.com>
 <20260422092910.444997-7-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260422092910.444997-7-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Gerd,

On Wed, Apr 22, 2026 at 11:29:09AM +0200, Gerd Hoffmann wrote:
>Copy data to stack-allocated struct before accessing it
>to make sure it is properly aligned.
>
>Fixes: CVE-2026-41440
>Fixes: f1488fac0584 ("hw/uefi: add var-service-auth.c")
>Reported-by: Katherine Leaver <katherine.j.leaver@gmail.com>
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> hw/uefi/var-service-auth.c | 16 +++++++++-------
> 1 file changed, 9 insertions(+), 7 deletions(-)
>
>diff --git a/hw/uefi/var-service-auth.c b/hw/uefi/var-service-auth.c
>index fba5a0956a57..0d17691804df 100644
>--- a/hw/uefi/var-service-auth.c
>+++ b/hw/uefi/var-service-auth.c
>@@ -218,23 +218,25 @@ static efi_status uefi_vars_check_auth_2_sb(uefi_vars_state *uv,
> efi_status uefi_vars_check_auth_2(uefi_vars_state *uv, uefi_variable *var,
>                                   mm_variable_access *va, void *data)
> {
>-    variable_auth_2 *auth = data;
>+    variable_auth_2 auth;
>     uint64_t data_offset;
>     efi_status status;
>
>-    if (va->data_size < sizeof(*auth)) {
>+    if (va->data_size < sizeof(auth)) {
>         return EFI_SECURITY_VIOLATION;
>     }
>-    if (uadd64_overflow(sizeof(efi_time), auth->hdr_length, &data_offset)) {
>+    memcpy(&auth, data, sizeof(auth));
>+
>+    if (uadd64_overflow(sizeof(efi_time), auth.hdr_length, &data_offset)) {
>         return EFI_SECURITY_VIOLATION;
>     }
>     if (va->data_size < data_offset) {
>         return EFI_SECURITY_VIOLATION;
>     }
>
>-    if (auth->hdr_revision != 0x0200 ||
>-        auth->hdr_cert_type != WIN_CERT_TYPE_EFI_GUID ||
>-        !qemu_uuid_is_equal(&auth->guid_cert_type, &EfiCertTypePkcs7Guid)) {
>+    if (auth.hdr_revision != 0x0200 ||
>+        auth.hdr_cert_type != WIN_CERT_TYPE_EFI_GUID ||
>+        !qemu_uuid_is_equal(&auth.guid_cert_type, &EfiCertTypePkcs7Guid)) {
>         return EFI_UNSUPPORTED;
>     }
>
>@@ -255,7 +257,7 @@ efi_status uefi_vars_check_auth_2(uefi_vars_state *uv, uefi_variable *var,
>     }
>
>     /* checks passed, set variable data */
>-    var->time = auth->timestamp;
>+    var->time = auth.timestamp;
>     if (va->data_size - data_offset > 0) {
>         var->data = g_malloc(va->data_size - data_offset);
>         memcpy(var->data, data + data_offset, va->data_size - data_offset);
>-- 
>2.53.0
>
>

 From a quick `git grep` I can see the same pattern in
`uefi_vars_check_auth_2_sb` and in file `hw/uefi/var-service-pkcs7.c`
in functions `build_signed_data` and `build_pkcs7`.

Should these fixed as well?

Thanks,
Luigi


