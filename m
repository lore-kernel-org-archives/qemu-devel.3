Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A201062862
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 11:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Hps-000688-Cy; Wed, 11 Mar 2026 07:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1w0Hpp-00067x-Qq
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 07:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1w0Hpk-000603-S0
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 07:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773228874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NrMSwBVjjmtktwDUPDLdJxva5juZsXnOiM6NTEmEBPE=;
 b=D3tYyE1qfEU2KktNcvvpBjc7yF9r1tLUP6FAWqgxVQ2H3ffEn6tp3Mb+RYGTBjcM84xI5I
 MDJCYOSgyMYGKVSRNBb0cIby06odJEzzLx9c4mKgUcZdgM25n3LvvCYBNSdb4MIPp4cjsO
 sK4OXpUAZxlbSmelAZE/7XISyKQ5fpE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-OMwYl5HyMcm7cJfalRnGkQ-1; Wed,
 11 Mar 2026 07:34:33 -0400
X-MC-Unique: OMwYl5HyMcm7cJfalRnGkQ-1
X-Mimecast-MFC-AGG-ID: OMwYl5HyMcm7cJfalRnGkQ_1773228871
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8168B1956061; Wed, 11 Mar 2026 11:34:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.225.19])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F239D3000223; Wed, 11 Mar 2026 11:34:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AB61E1800790; Wed, 11 Mar 2026 12:34:28 +0100 (CET)
Date: Wed, 11 Mar 2026 12:34:28 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@linaro.org, 
 joe.jin@oracle.com
Subject: Re: [PATCH v2 0/2] hw/nvram/fw_cfg: update bootorder to fix SeaBIOS
 bootup failure
Message-ID: <abFSF_Mt6xbMEzXz@sirius.home.kraxel.org>
References: <20260310170712.46336-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310170712.46336-1-dongli.zhang@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> 1. Create a QEMU instance with a virtio-scsi HBA and keep it in the
> prelaunch state. Use SeaBIOS rather than UEFI.
> 
> -device virtio-scsi-pci,id=scsi0,num_queues=4 \
> -S \
> 
> 2. First, attach the boot disk, then attach the secondary disk.
> 
> (qemu) drive_add 0 file=boot.qcow2,if=none,id=drive0
> (qemu) device_add scsi-hd,drive=drive0,bus=scsi0.0,channel=0,scsi-id=0,lun=1,bootindex=1
> (qemu) drive_add 0 file=secondary.qcow2,if=none,id=drive1
> (qemu) device_add scsi-hd,drive=drive1,bus=scsi0.0,channel=0,scsi-id=0,lun=2,bootindex=-1
> 
> 3. Start the VM from the prelaunch state. Because the "bootorder" and
> "bios-geometry" data in fw_cfg is stale, SeaBIOS attempts to boot from the
> secondary disk only once and then stops. As a result, the VM fails to boot.
> 
> One possible workaround is to require QEMU users to explicitly issue a
> system_reset before starting a guest VM from the prelaunch state, if any
> disks have been attached or detached.

Requiring a system_reset looks sensible to me.  Neither seabios nor ovmf
have hotplug support.  So if you expect the firmware pick up any new
devices after hot-plugging them it is IMHO a very good idea to force a
full re-initialization via system_reset for robustness reasons.

take care,
  Gerd


