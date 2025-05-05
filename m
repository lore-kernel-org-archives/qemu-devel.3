Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3CAC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsAP-0005nt-Sw; Mon, 05 May 2025 05:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uBsA9-0005gh-OV
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:31:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uBsA8-00020E-8k
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746437456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qqT5UEW/Zo2TZiBU5QZI4+FSdI2iVxjV31iA3hdC5XQ=;
 b=An6OBj340XFVpf4Vr4md4G21SoCLDIjMbCzETJcgsD3TUQt75fSF4AXJb1+mef6Lrd0Gpu
 9h1NYPkTsCQlgacLS5qXMSZzPqN0rJDpAMgQKOQh4leOhzXTG00D1AQKvp7URUY0yFpOdr
 mMkWwtnlrV9mPKjjA9GBRa/nxr8SB8U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-iIwhgFewPgmOVlN8eQW_nA-1; Mon,
 05 May 2025 05:30:55 -0400
X-MC-Unique: iIwhgFewPgmOVlN8eQW_nA-1
X-Mimecast-MFC-AGG-ID: iIwhgFewPgmOVlN8eQW_nA_1746437454
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA2BC18001D5; Mon,  5 May 2025 09:30:53 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.8])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADFC019560AB; Mon,  5 May 2025 09:30:49 +0000 (UTC)
Date: Mon, 5 May 2025 11:30:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 12/22] usb/msd: Ensure packet structure layout is
 correct
Message-ID: <aBiFR_XVTV_wj6Le@redhat.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
 <20250502033047.102465-13-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250502033047.102465-13-npiggin@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 02.05.2025 um 05:30 hat Nicholas Piggin geschrieben:
> These structures are hardware interfaces, ensure the layout is
> correct. Add defines for the data sizes throughout the code.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

> @@ -636,6 +643,10 @@ static const TypeInfo usb_storage_dev_type_info = {
>  
>  static void usb_msd_register_types(void)
>  {
> +    /* Ensure the header structures are the right size */
> +    qemu_build_assert(CBW_SIZE == 31);
> +    qemu_build_assert(CSW_SIZE == 13);
> +
>      type_register_static(&usb_storage_dev_type_info);
>  }

There is no real reason to have this assertion inside of a function at
the end of the file. I'd prefer QEMU_BUILD_BUG_ON() next to the struct
declarations, but obviously it's correct either way, so with or without
that changed:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


