Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99759C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 23:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlFrY-0001sf-J5; Thu, 20 Feb 2025 18:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlFrW-0001sU-7G
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 18:21:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlFrU-0002is-AJ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 18:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740093702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4B/WLW2AMDAeGCpOyzfMe45tHHdMUqfjzmkK3gum88Y=;
 b=XzjTJHKnt9aEYBjpbXYajibFkmmb044TFYqx3D/p9zmZw4Owi4J3rQZbNpIpYaGkruJebW
 hhfG+Q6/pelmM1yzUWzBQhXZSCQdfYcnR4Q8/ElbQQQBmXnT2Qxas8m1DjaM1/eEIuhc3U
 fFkecsWZMD4hOeuyQzrgluRmMCA3flY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-AWPF-yctOGW4n6kGuhWQ6w-1; Thu, 20 Feb 2025 18:21:39 -0500
X-MC-Unique: AWPF-yctOGW4n6kGuhWQ6w-1
X-Mimecast-MFC-AGG-ID: AWPF-yctOGW4n6kGuhWQ6w_1740093699
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-abbaac605c3so161369166b.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 15:21:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740093698; x=1740698498;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4B/WLW2AMDAeGCpOyzfMe45tHHdMUqfjzmkK3gum88Y=;
 b=tGGYz32k4T7ZDF0HQZL/1x8ZtIhiIaPQeEaoy0w+RvfvAo1NDog7FfjYxkq/HpfACQ
 oTfhAXIWsRPm9Dysubcbkj9kIHCjHQ/hVdG84jI/jboZRWGMjp8jZpXbFmcz7vnJQN0c
 OiKan8wlhb08sN8bl9ghVtvWYrIrLtTytSUBwStuJcHmMrRNBiH9kxv+cN2ye8botEaL
 G60ozo5jTEQaYkZz7pTJ1FX+iEjEGsf+nloU+hrCcfi/1OACYJhHl0Yz2QU1LFlkZ7c8
 lWIxCxWajZE9RLbJEVo3/rHm6xnD3YyJcX9sY4aOG3JjypUBMKCh/AozT35wZMeGinQ2
 O80Q==
X-Gm-Message-State: AOJu0Yy9n1uGddpyd4bwTXT2x56rWlY735/hWrMsNgTTuKS5/tDT/tSE
 CLoXTRT9yHiI2fXVy01bDB5n98ya1t0tDmhDw9EUKZo35tIJHVgv+5W2Wk6w/cfIQR++Cx18v3/
 lXzTtZf9vgU4qcD2xvcxgXCNiUTx9jDJYibdSFbOl/Mg2KYKwrgy5
X-Gm-Gg: ASbGncvn+1vNdO/m5w8qYdmj77Ejo/wCBO2RFlATtTkT9nzIyzNTz/5vIxMZEm9KVbZ
 m8XH0A5keINGIVSWhuJGXQiUGNW0VcCVCSypnpkkhP69E1BLVwYJnLj+6ifovJDz7pK74e1VlL8
 s+fiT1C7wwwDZ3c0uRdU6KZNJmrY+OnknJ8aD+m+sHcAK904lwxFEOyHpM7t+MYjqXYNTc3J8H6
 Qexx3O0IKyst2ymG+rptyYCMtsREBNbDCxUhFj47FribbtxFs5rhZqqHuxeOvkNuBtBbw==
X-Received: by 2002:a17:906:314d:b0:ab7:9df1:e562 with SMTP id
 a640c23a62f3a-abc0de55dbcmr52911866b.48.1740093697776; 
 Thu, 20 Feb 2025 15:21:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGp7cynrE2NnUHd9tb0GXNnjCr5k6eYSu+6YPgw8RP1tXr1VeabTYc4lryiaLz54ov2+qG1HQ==
X-Received: by 2002:a17:906:314d:b0:ab7:9df1:e562 with SMTP id
 a640c23a62f3a-abc0de55dbcmr52909366b.48.1740093697448; 
 Thu, 20 Feb 2025 15:21:37 -0800 (PST)
Received: from redhat.com ([2.55.163.174]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba532322f1sm1559736266b.19.2025.02.20.15.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 15:21:36 -0800 (PST)
Date: Thu, 20 Feb 2025 18:21:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 marcel.apfelbaum@gmail.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, vasant.hegde@amd.com, Wei.Huang2@amd.com,
 bsd@redhat.com, berrange@redhat.com, joao.m.martins@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v3 0/2] hw/i386/amd_iommu: Add migration support
Message-ID: <20250220182112-mutt-send-email-mst@kernel.org>
References: <20250212054450.578449-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250212054450.578449-1-suravee.suthikulpanit@amd.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Feb 12, 2025 at 05:44:48AM +0000, Suravee Suthikulpanit wrote:
> Currently, amd-iommu device does not support migration. This series addresses
> an issue due hidden AMDVI-PCI device enumeration. Then introduces migratable
> VMStateDescription, which saves necessary parameters for the device.
> 
> Changes from v2:
> (https://lore.kernel.org/all/20250206051856.323651-1-suravee.suthikulpanit@amd.com)
>   * Add patch 1/2


Fails build on 32 bit:

https://gitlab.com/mstredhat/qemu/-/jobs/9202574769


In file included from ../include/qemu/osdep.h:53,
                 from ../hw/i386/amd_iommu.c:23:
../include/qemu/compiler.h:70:35: error: invalid operands to binary - (have ‘uint64_t *’ {aka ‘long long unsigned int *’} and ‘size_t *’ {aka ‘unsigned int *’})
   70 | #define type_check(t1,t2) ((t1*)0 - (t2*)0)
      |                                   ^
../include/migration/vmstate.h:269:6: note: in expansion of macro ‘type_check’
  269 |      type_check(_type, typeof_field(_state, _field)))
      |      ^~~~~~~~~~
../include/migration/vmstate.h:320:21: note: in expansion of macro ‘vmstate_offset_value’
  320 |     .offset       = vmstate_offset_value(_state, _field, _type),     \
      |                     ^~~~~~~~~~~~~~~~~~~~
../include/migration/vmstate.h:853:5: note: in expansion of macro ‘VMSTATE_SINGLE_TEST’
  853 |     VMSTATE_SINGLE_TEST(_field, _state, NULL, _version, _info, _type)
      |     ^~~~~~~~~~~~~~~~~~~
../include/migration/vmstate.h:903:5: note: in expansion of macro ‘VMSTATE_SINGLE’
  903 |     VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint64, uint64_t)
      |     ^~~~~~~~~~~~~~
../include/migration/vmstate.h:937:5: note: in expansion of macro ‘VMSTATE_UINT64_V’
  937 |     VMSTATE_UINT64_V(_f, _s, 0)
      |     ^~~~~~~~~~~~~~~~
../hw/i386/amd_iommu.c:1635:7: note: in expansion of macro ‘VMSTATE_UINT64’
 1635 |       VMSTATE_UINT64(devtab_len, AMDVIState),
      |       ^~~~~~~~~~~~~~


> Suravee Suthikulpanit (2):
>   hw/i386/amd_iommu: Isolate AMDVI-PCI from amd-iommu device to allow
>     full control over the PCI device creation
>   hw/i386/amd_iommu: Allow migration when explicitly create the
>     AMDVI-PCI device
> 
>  hw/i386/acpi-build.c |   8 ++--
>  hw/i386/amd_iommu.c  | 111 +++++++++++++++++++++++++++++++++----------
>  hw/i386/amd_iommu.h  |   3 +-
>  3 files changed, 91 insertions(+), 31 deletions(-)
> 
> -- 
> 2.34.1


