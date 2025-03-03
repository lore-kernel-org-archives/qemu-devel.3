Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA7AC282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 08:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp1M7-0007nb-C3; Mon, 03 Mar 2025 03:40:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tp1La-0007ha-AR
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 03:40:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tp1LX-000117-U8
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 03:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740991217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cl0ashaSmVKflqS9TBfsiHs33PZH0vGgCau55umAcf0=;
 b=Gt1313vb9tFy+aJqhWhwbjWbqFl45oebDLPI8H1dDsMoXzII0aF765WbL18HY97Gd6dWZO
 YeoQko8/vonDHhxBhi8tUK54EtbWZuWNBqin5NvyLBn/eDaTeZ4l2Va6K5MRFyh+OnHa21
 nunhsaFn6tubrS+hahYFwTllhVje/98=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-I02of5MjNHOGvm76IR3cYw-1; Mon,
 03 Mar 2025 03:40:08 -0500
X-MC-Unique: I02of5MjNHOGvm76IR3cYw-1
X-Mimecast-MFC-AGG-ID: I02of5MjNHOGvm76IR3cYw_1740991206
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8054D1800993; Mon,  3 Mar 2025 08:40:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.122])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B61801956094; Mon,  3 Mar 2025 08:40:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 39C0C180038E; Mon, 03 Mar 2025 09:40:03 +0100 (CET)
Date: Mon, 3 Mar 2025 09:40:03 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/i386/ovmf: check if ovmf is supported before calling
 ovmf parsing code
Message-ID: <iyye7xqxg2nc22vcwoxoljopduyma5vishah2xnty467kfwilm@azhtomnofkqm>
References: <20250228170434.317306-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228170434.317306-1-anisinha@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On Fri, Feb 28, 2025 at 10:34:34PM +0530, Ani Sinha wrote:
> Currently call to x86_firmware_configure() -> pc_system_parse_ovmf_flash()
> happens only when SEV is enabled. Fortunately, X86_FW_OVMF is turned on
> automatically when SEV is enabled and therefore,  we never end up calling
> pc_system_parse_ovmf_flash() when X86_FW_OVMF is turned off. In future,
> it is possible that users call x86_firmware_configure() or
> x86_firmware_reconfigure() without checking if SEV is enabled. Therefore,
> x86_firmware_configure() or x86_firmware_reconfigure() need to check if
> ovmf is supported before calling ovmf parsing code. Hence, this change
> introduces an api ovmf_supported() that returns true wnen ovmf is enabled
> and false otherwise. Ovmf parsing code is only called after checking if ovmf
> is supported.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd


