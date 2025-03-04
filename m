Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5841BC282D2
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 16:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpUvy-0005bD-Em; Tue, 04 Mar 2025 11:15:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpUvv-0005aE-5X
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 11:15:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpUvq-0001hY-KZ
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 11:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741104944;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=H8T7lm3QnLtGEg11VPjtVK2LAz1rKL4loOSVz1Td7sU=;
 b=JiDJAeJxsUVlbZrlQ5T67WVmvaNlUS3FfqPUthJpoNz82S8Et40kiMBlgc2Csj9R6MY/7l
 wTUQN0ZXdAjngKAs6iItXVFTT1D8R1r0QGSDNF5RzRcslzTgu3prSHW+lqb+5qyEu1bIa4
 mZE3dCS2A2QRXt6UAljBx+Yh+x2hJPs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-I4dxcVfDMPqVedJebaNfTA-1; Tue,
 04 Mar 2025 11:15:42 -0500
X-MC-Unique: I4dxcVfDMPqVedJebaNfTA-1
X-Mimecast-MFC-AGG-ID: I4dxcVfDMPqVedJebaNfTA_1741104938
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEA741801A18; Tue,  4 Mar 2025 16:15:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.210])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5B621800361; Tue,  4 Mar 2025 16:15:35 +0000 (UTC)
Date: Tue, 4 Mar 2025 16:15:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alberto Faria <afaria@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH 1/2] scsi-disk: Advertise FUA support by default
Message-ID: <Z8cnJB2KRxl9ULHC@redhat.com>
References: <20250304155232.1325581-1-afaria@redhat.com>
 <20250304155232.1325581-2-afaria@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304155232.1325581-2-afaria@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 04, 2025 at 03:52:31PM +0000, Alberto Faria wrote:
> FUA emulation code is already is place.
> 
> Signed-off-by: Alberto Faria <afaria@redhat.com>
> ---
>  hw/scsi/scsi-disk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index e7f738b484..8cf50845ab 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -3212,7 +3212,7 @@ static const Property scsi_hd_properties[] = {
>      DEFINE_PROP_BIT("removable", SCSIDiskState, features,
>                      SCSI_DISK_F_REMOVABLE, false),
>      DEFINE_PROP_BIT("dpofua", SCSIDiskState, features,
> -                    SCSI_DISK_F_DPOFUA, false),
> +                    SCSI_DISK_F_DPOFUA, true),

Should this come with machine type compat to prevent us advertizing FUA
to existing machine type versions ?

>      DEFINE_PROP_UINT64("wwn", SCSIDiskState, qdev.wwn, 0),
>      DEFINE_PROP_UINT64("port_wwn", SCSIDiskState, qdev.port_wwn, 0),
>      DEFINE_PROP_UINT16("port_index", SCSIDiskState, port_index, 0),

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


