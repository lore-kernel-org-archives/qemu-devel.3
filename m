Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F275C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Kcd-00035k-5N; Fri, 25 Apr 2025 11:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8KcY-00034x-D3
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8KcW-0000ut-DT
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745593539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rJnamcaxmxKBxJry78iA/v8iMa3VUZIFnZA23xfiQgM=;
 b=HIasl9oHiWSso74vYPczkSaPN4ZhnAO7hrQmF1xnYRDvBYUmxquj9A800tKwo4wqihTlNU
 SFWpnD0KkVJ1gQ5JITWNqJe4kVH77ZEqM6TVAf+LYQWL0yTn1ENT9dGJNgIlfx/inSMtUZ
 NrnSLStosynQYLnk9Dmlf0h1P1cteVc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-BiIByge1P-mWplyxkSRTfw-1; Fri,
 25 Apr 2025 11:05:33 -0400
X-MC-Unique: BiIByge1P-mWplyxkSRTfw-1
X-Mimecast-MFC-AGG-ID: BiIByge1P-mWplyxkSRTfw_1745593532
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EFE819560BC; Fri, 25 Apr 2025 15:05:32 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.183])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 350B71800378; Fri, 25 Apr 2025 15:05:26 +0000 (UTC)
Date: Fri, 25 Apr 2025 17:05:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Faria <afaria@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 2/2] scsi-disk: Advertise FUA support by default
Message-ID: <aAuktDpM_FIZhXOH@redhat.com>
References: <20250411113036.786841-1-afaria@redhat.com>
 <20250411113036.786841-3-afaria@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411113036.786841-3-afaria@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 11.04.2025 um 13:30 hat Alberto Faria geschrieben:
> Allow the guest to submit FUA requests directly, instead of forcing it
> to emulate them using a regular flush.
> 
> Signed-off-by: Alberto Faria <afaria@redhat.com>
> ---
>  hw/core/machine.c   | 1 +
>  hw/scsi/scsi-disk.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 63c6ef93d2..e4e6474a4e 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -46,6 +46,7 @@ GlobalProperty hw_compat_9_2[] = {
>      { "migration", "multifd-clean-tls-termination", "false" },
>      { "migration", "send-switchover-start", "off"},
>      { "vfio-pci", "x-migration-multifd-transfer", "off" },
> +    { "scsi-disk", "dpofua", "off" },
>  };
>  const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);

This needs to go to hw_compat_10_0 now.

And shouldn't it be "scsi-hd" rather than "scsi-disk"? Did you test that
the property is disabled when you use an older machine type?

Kevin


