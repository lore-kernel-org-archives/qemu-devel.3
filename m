Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3994EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCbV-0006SI-3F; Mon, 29 Jun 2026 10:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1weCbP-0006Pe-69
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:04:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1weCbN-0001wM-6u
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782741884;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JbsW93YYU3tw/Ze7G2E1IFppwyWu2kha8gQ/Nfnv4sw=;
 b=N73DSR8ilwYnF7GNjPjur6UUAMtdLM/nxA3kyBL3Y+JcBIVfBHev17+1ila7/Theoh6oHR
 P88UKo1Ew3fNl5+jr/uAdI3gjTOvfZJuJSC1pFkcIdGI07Lu23uaKMI6sz9p84KdYHpGMS
 6wSViW2qX7BSgrHfi5CyPueqov1Ka2Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-nYt-jPWcM-uUMF-0sKt7Yw-1; Mon,
 29 Jun 2026 10:04:41 -0400
X-MC-Unique: nYt-jPWcM-uUMF-0sKt7Yw-1
X-Mimecast-MFC-AGG-ID: nYt-jPWcM-uUMF-0sKt7Yw_1782741880
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E30D1800365; Mon, 29 Jun 2026 14:04:40 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.121])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 657CB3000B4D; Mon, 29 Jun 2026 14:04:38 +0000 (UTC)
Date: Mon, 29 Jun 2026 15:04:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] hw/dma/i8257: Return zeroes for read_memory in verify mode
Message-ID: <akJ7cwbYFRxGMA35@redhat.com>
References: <20260629140128.1900095-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260629140128.1900095-1-peter.maydell@linaro.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 29, 2026 at 03:01:28PM +0100, Peter Maydell wrote:
> The i8257 DMA controller has a "verify" mode, which the datasheet
> describes like this:
> 
> > DMA verify, which does not actually involve the transfer of data.
> > When an 8257 channel is in the DMA verify mode, it will respond the
> > same as described for transfer operations, except that no memory or
> > I/O read/write control signals will be generated.  When an 8257
> > channel is in the DMA verify mode, it will respond the same as
> > described for transfer operations, except that no memory or I/O read
> > /write control signals will be generated, thus preventing the
> > transfer of data.  The 8257, however, will gain control of the system
> > bus and will acknowledge the peripheral's DMA request for each DMA
> > cycle.  The perihperal can use these acknowledge signals to enable an
> > internal access of each byte of a data block in order to execute some
> > verification procedure, such as the accumulation of a CRC check word.
> 
> In practice, for QEMU's purposes the only real user of this is the
> floppy controller, which can be made to perform a "read data from
> floppy disk and check the checksum" by telling the fdc to do a read
> and the DMA controller to do a verify.  This causes the fdc to do all
> the usual read actions including the checksum, but the data is never
> written to memory.  However, it is possible for a guest doing
> something silly to program the DMA controller to do a verify
> operation for a device that wants to read from memory.  Currently we
> simply return early from i8257_dma_read_memory() without writing to
> the buffer.  None of the callers (the GUS, sb16 and cs4231a sound
> cards, plus the fdc) expect this, so they will take the uninitialized
> data as if it were from the guest.  This can cause us to leak host
> data off the stack into the guest.
> 
> Make i8257_dma_read_memory() fill the buffer with zeroes rather
> than leaving it untouched for a verify operation.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3487
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/dma/i8257.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


