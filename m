Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C852ED29DFE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 10:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfbG8-0001GL-9w; Tue, 13 Jan 2026 05:04:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vfbFw-0001A4-GL
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:04:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vfbFq-0006vg-FF
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768298635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/TYOQZ+sW9A9pK1BbGpJJiCSp+iw4/edrNSXl/0rj/g=;
 b=CX9T1ssdp7maVzPAaBRxLsWZr7rnU1GpT6NGY0E4affX6jTllYCv+tQQx3pLaOTMraD6S1
 K9dCQh9HEkxr7RwKtdiDPmDoSejopGJn6aXE15V31/JB8f6q9EWaARY0x7+mvDtkFzi1D0
 rsMm7dZxzOlUPh4RaltnUTPrttSmpHs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-GgTxawCaOmuNm28Xr4nkTw-1; Tue,
 13 Jan 2026 05:03:50 -0500
X-MC-Unique: GgTxawCaOmuNm28Xr4nkTw-1
X-Mimecast-MFC-AGG-ID: GgTxawCaOmuNm28Xr4nkTw_1768298629
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C8561956095; Tue, 13 Jan 2026 10:03:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.56])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 338811956053; Tue, 13 Jan 2026 10:03:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E1E4C1800081; Tue, 13 Jan 2026 11:03:45 +0100 (CET)
Date: Tue, 13 Jan 2026 11:03:45 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Oliver Steffen <osteffen@redhat.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joerg.roedel@amd.com>,
 kvm@vger.kernel.org, 
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Luigi Leonardi <leonardi@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 0/3] igvm: Supply MADT via IGVM parameter
Message-ID: <aWYS7RYg8E4V_g6b@sirius.home.kraxel.org>
References: <20251211103136.1578463-1-osteffen@redhat.com>
 <20251219140933.7b102fc5@imammedo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219140933.7b102fc5@imammedo>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

  Hi,

> Also seeing that regenerating tables every time helps,
> it hints that PCI subsystem is not configured when tables read 1st time.

This is the case.

> Main conditions to get acpi blob representing is that they should be read
> after guest firmware enumerated/configured PCI subsystem and
> firmware should use BIOSlinker workflow to load/postprocess
> tables otherwise all bets are off (even if this series works for now,
> it's subject to break without notice since user doesn't follow proper
> procedures for reading/processing ACPI blob).
> Hence I dislike this approach.

Well, the use case which needs this is a confidential VM with SVSM.  So
the SVSM firmware is the first thing which boots, sets up SVSM and the
services it provides (vTPM, in the future UEFI variable store), then
goes boot OVMF firmware which handles PCI initialization etc.

SVSM needs to know the SMP configuration, but it does not even look at
the PCI bus.

The MADT is static:  Nothing in there changes if the guest changes
hardware registers (such as pci bridge windows), nothing requires the
bios linker for cross-table references.  Given that I fail to see how
this can possibly break in the future.

> Alternatively, instead of ACPI tables one can use FW_CFG_MAX_CPUS
> like old SeaBIOS used to do if all you need is APIC IDs.
> Limitation of this approach is that one can't use sparse APIC ID
> configs.

Thats why the idea is to just use the MADT table for SMP discovery.
The APIC IDs are in there, and it also removes qemu-specific code from
SVSM.

take care,
  Gerd


