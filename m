Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F18C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 10:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBtPQ-0002Qe-Ij; Mon, 05 May 2025 06:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uBtPJ-0002Pr-Kj
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:50:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uBtPG-0004e3-3N
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746442239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QI8Fcj2OLtdYqeOnGrDpVvaBpR8shh472/u1EtqnPWY=;
 b=d8MjYgMzOhocZKJx10vcJ5eRMkri23Xn+pyZAbPNEieEZe96Myr3q3fVSu8Vk7S18CYfbI
 VGTJCzTy8hXLDcZCT5rmc1orV40x088dtcc964ptN57Snh1puOvsCxmHhA5sw8ZxhQQfFg
 vIojUvjfskE15T2LNNv32isSdvwozxY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-iK4r7DngNBC_8udsOyTQwA-1; Mon,
 05 May 2025 06:50:38 -0400
X-MC-Unique: iK4r7DngNBC_8udsOyTQwA-1
X-Mimecast-MFC-AGG-ID: iK4r7DngNBC_8udsOyTQwA_1746442237
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEC491800877; Mon,  5 May 2025 10:50:36 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.8])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA9911956094; Mon,  5 May 2025 10:50:32 +0000 (UTC)
Date: Mon, 5 May 2025 12:50:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 15/22] usb/msd: Allow CBW packet size greater than 31
Message-ID: <aBiX9sg56lcNIjDn@redhat.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
 <20250502033047.102465-16-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502033047.102465-16-npiggin@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> The CBW structure is 31 bytes, so CBW DATAOUT packets must be at least
> 31 bytes. QEMU enforces exactly 31 bytes, but this is inconsistent with
> how it handles CSW packets (where it allows greater than or equal to 13
> bytes) despite wording in the spec[*] being similar for both packet
> types: "shall end as a short packet with exactly 31 bytes transferred".
> 
>   [*] USB MSD Bulk-Only Transport 1.0
> 
> For consistency, and on the principle of being tolerant in accepting
> input, relax the CBW size check.
> 
> Alternatively, both checks could be tightened to exact. Or a message
> could be printed warning of possible guest error if size is not exact,
> but still accept the packets.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

This doesn't look right to me.

CBW is a message from the host to the device. The device must fully
validate the data in it (see "6.2 Valid and Meaningful CBW"). My
understanding is that a wrong CBW size is an error.

CSW is a message from the device to the host, i.e. the iovec doesn't
really have any content when we get it. It's essentially just a buffer
in which usb-storage has to construct a valid CSW (of the exact size
13). If the buffer is larger than it has to be, that's a different case
than receiving a CBW of the wrong size. I'm not entirely sure what the
mechanism is to send exactly 13 bytes, but I assume it's related to
p->actual_length, which is updated in usb_packet_copy().

Actually, if we reject too small buffers, why do we even need the MIN()
in usb_msd_send_status()? Shouldn't len be an unconditional CSW_SIZE?

Kevin


