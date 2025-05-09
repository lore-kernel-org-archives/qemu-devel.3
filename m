Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5275C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 15:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDPsp-0007y5-JO; Fri, 09 May 2025 11:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uDPsl-0007xx-2Q
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:43:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uDPsh-0001uq-TF
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746805398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w5Ixi2ACZb/FXFit0pq1JvRLIaJIZB2AtVzusZ/qyYk=;
 b=Z33Hp+cRjqnrdiEG0p39A7dgFf2FwlZB0xp0ADu5Rlyuqt3PwaaVchxjXMciP3nLutPOFT
 RTq1yJ7ciF4sJtsF2Lbk/0VNAjyFgEvQ4xIRBup2SPm2aLxhAVdv27MLIPLsuf+kbiTNMx
 dFqAG8qDBWJTsF+yEV3uhqnsxT4vxlY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-4ZT4jVPdPxe3ftGe5FlGqw-1; Fri, 09 May 2025 11:43:17 -0400
X-MC-Unique: 4ZT4jVPdPxe3ftGe5FlGqw-1
X-Mimecast-MFC-AGG-ID: 4ZT4jVPdPxe3ftGe5FlGqw_1746805396
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7cabd21579eso44114985a.3
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 08:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746805396; x=1747410196;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w5Ixi2ACZb/FXFit0pq1JvRLIaJIZB2AtVzusZ/qyYk=;
 b=XaCBeXen0HGe5uufplvBSFyk5QyQlHimVu5++Fdse9AkZJmoXyhUJklSJSB4nLZtiA
 1g4YYKnfwxbLb2CVk0yVjHC4cCUZR3HELRSG//0431zRxoERMuctNH2evX+XxXwDBVHz
 4PYXwK4bpdoEwl8fGPLV3wrvTw3pSqJUr/Xq3e0FrjOAzOfnnyXIEg3l5OWVcPTOpQ3B
 2UMM8aUFDK2X3H6QtKnd6PBdL7y8kvf+9VBpnw/EfhVodlQxzRbmD2Pu4D5crXzbpwY7
 t9veffXLxQi9uUIDVDtZGBRfic8BVFiekR9+bNS6l/62aNUhkKwOjQ634QFQIURB6b2c
 qriA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+8ZYhnoC2h3d466xH/PMgdGwCgJSvrUD1p16aMjlZNWqpGodrvmGcvEhce3LR6lq0FU2EFDvKtgls@nongnu.org
X-Gm-Message-State: AOJu0YyLYIQn/n/FLfnYSjqYydTxxNg7JL7G9WJm5Lvu7RnUMQPtfhnZ
 XHT3EYQTuM1k8wviKQzwAfSNbSX+Oz9QBIRpCquVPk4SDjk7Ip4kc7PyavyuU+/RfsYPnjV64wP
 zBM6WpTElFUKb7yyxcKmhGm4vqXm9VINqwA7LZPZyYEJGa33vJ1s4
X-Gm-Gg: ASbGncvRNmtvej/FNP5hB9bcJ/rkpkwcv/CdzDpXUUzKmJHeUHx7i7Tn3s4o+hTrPaU
 DFjeabneVd/IDNFrgtIz/tLliUVJ7cJJTHlK8KOXS0syEQPAdELgFzJCUUQOcIz7dh9vI+v3X/S
 ZV7ePDiXkG9aeTnaFv5QOh2Igadfggc0zxaTHi39922AHGOeh1lz45Di76D8CVcuAJTeVk0sS/A
 jId4zfpGLZGeH/p9F3REOq8ETah+Jr8MD+15/pmospNrrthud+w1E665UOaHu8Q+cBw0MOAuKs9
 1LY=
X-Received: by 2002:a05:620a:4106:b0:7c7:a538:490 with SMTP id
 af79cd13be357-7cd010f3f58mr560320585a.2.1746805396310; 
 Fri, 09 May 2025 08:43:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTBLKevDykIMNHw+D+yBTu0HZLiYaODUtCXgDcGA7mUNcRlnt/O43IxpwXImnOgli5xle9Gw==
X-Received: by 2002:a05:620a:4106:b0:7c7:a538:490 with SMTP id
 af79cd13be357-7cd010f3f58mr560316285a.2.1746805395832; 
 Fri, 09 May 2025 08:43:15 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd06cd53a7sm40715785a.55.2025.05.09.08.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 08:43:15 -0700 (PDT)
Date: Fri, 9 May 2025 11:43:12 -0400
From: Peter Xu <peterx@redhat.com>
To: liu.xuemei1@zte.com.cn
Cc: farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: Fix migration failure when aia is configured
 as 'aplic-imsic'
Message-ID: <aB4ikJgKEb8Gnvob@x1.local>
References: <20250509100826883Qfb-U1cCkGDsr7nr9_Bbt@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250509100826883Qfb-U1cCkGDsr7nr9_Bbt@zte.com.cn>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, May 09, 2025 at 10:08:26AM +0800, liu.xuemei1@zte.com.cn wrote:
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
> 
> Address an error in migration by discarding 'riscv_aplic' and 'riscv_imsic'
> in vmstate_register_with_alias_id() when aia is configured as
> 'aplic-imsic' in riscv kvm vm.
> 
> Previously, the fields in the vmsds of 'riscv_aplic' and 'riscv_imsic' can
> only be initialized under certain special conditions in commit 95a97b3fd2.
> However, the corresponding ses of these vmsds are inserted into the
> savevm_state.handlers unconditionally. This led to migration failure
> characterized by uninitialized fields when save vm state:
> qemu-system-riscv64: ../migration/vmstate.c:433: vmstate_save_state_v:
> Assertion 'first_elem || !n_elems || !size' failed.
> 
> Fixes: 95a97b3fd2 ("target/riscv: update APLIC and IMSIC to support KVM AIA")
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> ---
> migration/savevm.c | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 0c12e373b4..db53ce6d55 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -71,6 +71,8 @@
> #include "yank_functions.h"
> #include "system/qtest.h"
> #include "options.h"
> +#include "hw/intc/riscv_aplic.h"
> +#include "system/kvm.h"
> 
> const unsigned int postcopy_ram_discard_version;
> 
> @@ -902,6 +904,21 @@ int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
> {
> SaveStateEntry *se;
> 
> +    /* Drop "riscv_aplic" if emulated aplic is used*/
> +    if (!g_strcmp0(vmsd->name, "riscv_aplic")) {
> +        RISCVAPLICState *aplic = opaque;
> +        if (!riscv_use_emulated_aplic(aplic->msimode)) {
> +            return 0;
> +        }
> +    }
> +
> +    /* Drop "riscv_imsic" if kvm_kernel_irqchip is true */
> +    if (!g_strcmp0(vmsd->name, "riscv_imsic")) {
> +        if (kvm_irqchip_in_kernel()) {
> +            return 0;
> +        }
> +    }

I'm not yet sure what's the best for the issue you're working on, but this
doesn't look right to change migration core for a RISCV fixes..

Maybe you want one VMStateDescription.needed()?

> +
> /* If this triggers, alias support can be dropped for the vmsd. */
> assert(alias_id == -1 || required_for_version >= vmsd->minimum_version_id);
> 
> --
> 2.27.0
> 

-- 
Peter Xu


