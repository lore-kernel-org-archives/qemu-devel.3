Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD0AC3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 10:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBt2J-00081B-1F; Mon, 05 May 2025 06:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uBt2G-0007zD-Fo
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:26:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uBt2E-0001On-OD
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746440811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pUI4DXNPRocOddOKtyyUwQEYEeuoenxCVCBELJGqj1I=;
 b=Gv/SQnu+47jXrSDTgNiXoAgrTwhYkT4U4zNDM0C7Z7mEEGKEP1qMgdRFkwbazCrX+sU2IC
 QPdL1P3ThAsl8aMQzN4+y7O02yfqjhePXrhws+nknGaHy6Dp7H4scwTEqOSWGGgiaatZ3X
 spezXfR1SseM+JMMzCWf3RLbqRwfBOc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-m5dL2RI4Oc2ZuVIY-rcx2A-1; Mon,
 05 May 2025 06:26:47 -0400
X-MC-Unique: m5dL2RI4Oc2ZuVIY-rcx2A-1
X-Mimecast-MFC-AGG-ID: m5dL2RI4Oc2ZuVIY-rcx2A_1746440806
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E85E180036D; Mon,  5 May 2025 10:26:46 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.8])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 197CD18001D7; Mon,  5 May 2025 10:26:41 +0000 (UTC)
Date: Mon, 5 May 2025 12:26:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 14/22] usb/msd: Improve packet validation error logging
Message-ID: <aBiSX0MRdxBDHDSM@redhat.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
 <20250502033047.102465-15-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502033047.102465-15-npiggin@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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
> Errors in incoming USB MSD packet format or context would typically
> be guest software errors. Log these under guest errors.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

> +static bool check_valid_csw(USBPacket *p)
> +{
> +    if (p->iov.size < CSW_SIZE) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "usb-msd: Bad CSW size %zu\n",
> +                      p->iov.size);
> +        return false;
> +    }
> +    return true;
> +}

I feel this name might be a bit misleading. The spec says a CSW is valid
if its size is exactly 13 bytes, the signature is correct and the tag
matches the CBW tag. Of course, this is something that the host would
check after the device completes the request, not the device when it
receives the CSW.

Maybe just validate_csw_size() or something?

The logic looks good to me, though.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


