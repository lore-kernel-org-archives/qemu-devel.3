Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59145D1267E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 10:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8H0t-00023F-7t; Tue, 05 Nov 2024 05:42:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1t8H0r-00022s-9G
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:42:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1t8H0o-0003NY-Ve
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730803333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cyw0wydgu5gL/WnMf31zM2VEcOTwIZoLzzSU9e47OFo=;
 b=LTApNOGmb/ps+3dC8n3C7vPsjXa47HwXuyU2UUsP/EychohCD/iUu+jsR8nyyB4Njto2zs
 NCBnq/vcSp3IfncCVZ80wweR4fEY7ZYkhAKItDm94V4hWgNhs+QQZIFfR53zB9oXGcRdDF
 HXwCVlkh9PvkP/A+nuagBiqTctoqKec=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-noP2Q5YwOOqhwm0OUr1wfw-1; Tue,
 05 Nov 2024 05:42:12 -0500
X-MC-Unique: noP2Q5YwOOqhwm0OUr1wfw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 543081955F57; Tue,  5 Nov 2024 10:42:11 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.39.195.58])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C20F19560A3; Tue,  5 Nov 2024 10:42:11 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
 id 628EA22AE15; Tue,  5 Nov 2024 11:42:07 +0100 (CET)
Date: Tue, 5 Nov 2024 11:42:07 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: How to pass the EFI_MEMORY_SP type to VM in QEMU
Message-ID: <i5bah6ct3uglkblgtlntscwg4o757kuvorbds6qabaubxtbeb3@jrghk3ecoabl>
References: <BL1PR12MB5317899723624202EDF03FC8F1562@BL1PR12MB5317.namprd12.prod.outlook.com>
 <ujqnswmursutk3l235jv7sn6xo32y2fh2cxdmcqttx4mgfoula@3setckow5or6>
 <BL1PR12MB531740B8CB83F8F345011B37F1512@BL1PR12MB5317.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB531740B8CB83F8F345011B37F1512@BL1PR12MB5317.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Mon, Nov 04, 2024 at 03:52:36PM +0000, Luo, Zhigang wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Gerd,
> 
> Thanks for your response. So, on X86, I need to add a new type in qemu and firmware. Is my understanding correct?

Yes, both firmware and qemu must be updated.

take care,
  Gerd


