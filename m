Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70616C4829E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 19:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZbik-0004Hu-50; Mon, 12 Feb 2024 14:12:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZbij-0004Hm-6S
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 14:12:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZbie-0002uy-8T
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 14:12:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707765114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=zHv69hjMwIvabqseIsstll7+GFcFpX7QEfy2zlsEPhc=;
 b=hJWZCMR5gd7h23s0edA95bW+aGsjRIt+OLqfDR4OL5q9wIgaOhb64l1N6+Qgvu+KnPGbUv
 d86HiBhzIIBSZ2Bmibu/BiXzFtfgRwQfyffffwlotZ5G6/HQAvEx2KbKEvmZyovwf0RFHe
 PadHFGmyCDvKYbnYtS+gTVZdoQrLJKI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-kwzazjjlMGevrVPb7dSfPw-1; Mon, 12 Feb 2024 14:11:51 -0500
X-MC-Unique: kwzazjjlMGevrVPb7dSfPw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28D0D185A782;
 Mon, 12 Feb 2024 19:11:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6EDFC2E1E6;
 Mon, 12 Feb 2024 19:11:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B80A721E66C8; Mon, 12 Feb 2024 20:11:49 +0100 (CET)
Resent-To: eduardo@habkost.net, yi.l.liu@intel.com,
 zhenzhong.duan@intel.com, qemu-devel@nongnu.org, avihaih@nvidia.com,
 jgg@nvidia.com, joao.m.martins@oracle.com
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 12 Feb 2024 20:11:49 +0100
Resent-Message-ID: <87sf1xa45m.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org,  Yi Liu <yi.l.liu@intel.com>,  Eric Auger
 <eric.auger@redhat.com>,  Zhenzhong Duan <zhenzhong.duan@intel.com>,  Alex
 Williamson <alex.williamson@redhat.com>,  Cedric Le Goater
 <clg@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Daniel P .
 Berrange" <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>,  Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PATCH RFCv2 6/8] backends/iommufd: Add ability to disable
 hugepages
In-Reply-To: <20240212135643.5858-7-joao.m.martins@oracle.com> (Joao Martins's
 message of "Mon, 12 Feb 2024 13:56:41 +0000")
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
 <20240212135643.5858-7-joao.m.martins@oracle.com>
Date: Mon, 12 Feb 2024 18:17:30 +0100
Message-ID: <87zfw5a9g5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Joao Martins <joao.m.martins@oracle.com> writes:

> Allow disabling hugepages to be dirty track at base page
> granularity in similar vein to vfio_type1_iommu.disable_hugepages
> but per IOAS.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index 84af23fe245d..9ad27e2b939b 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -809,7 +809,7 @@
>  # Since: 9.0
>  ##
>  { 'struct': 'IOMMUFDProperties',
> -  'data': { '*fd': 'str' } }
> +  'data': { '*fd': 'str', '*hugepages': 'bool' } }
>  
>  ##
>  # @RngProperties:

Missing documentation for the new member.

The latest QAPI PR is making this a hard error.


