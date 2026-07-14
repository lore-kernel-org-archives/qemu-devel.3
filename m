Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17299C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjaQE-0000AX-1S; Tue, 14 Jul 2026 06:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wjaQC-0000A1-3Q
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wjaQA-0000Nn-Cr
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784025084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V56KDeHPvSnP+RbpyDQRLpcZSniVoMZLvEDFxm2UFHU=;
 b=bPO2Dwwf/exGsfN0rxZMF+6V0JqGgjZwvqAkxt0mN1BpbgWHfBrGMmdLM4UkyF6YLD6CZQ
 5zmvbk3b1miYqFzYnfYoKtaopZFHmGkXTvcCXm0xrnrTuDEQ9Voe14b9GLSIv8r2pYAkMa
 RikqraR8Mxpgp5kBD+gOhLMm1IBaraA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-qp3sk66iO-iAscefXPuUcQ-1; Tue,
 14 Jul 2026 06:31:20 -0400
X-MC-Unique: qp3sk66iO-iAscefXPuUcQ-1
X-Mimecast-MFC-AGG-ID: qp3sk66iO-iAscefXPuUcQ_1784025079
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA3071800370; Tue, 14 Jul 2026 10:31:18 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.162])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDF9CD6E; Tue, 14 Jul 2026 10:31:16 +0000 (UTC)
Date: Tue, 14 Jul 2026 12:31:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: malike <malike@kylinos.cn>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, hreitz@redhat.com,
 qemu-block@nongnu.org
Subject: Re: [PATCH] block/cloop: fix integer overflow in total_sectors
 calculation
Message-ID: <alYP8ikcV9KHA7wB@redhat.com>
References: <20260713031750.58448-1-malike@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713031750.58448-1-malike@kylinos.cn>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=kwolf@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

Am 13.07.2026 um 05:17 hat malike geschrieben:
> The total_sectors is computed as n_blocks * sectors_per_block where
> both operands are uint32_t. The multiplication is performed in 32-bit
> arithmetic and can overflow when the product exceeds UINT32_MAX,
> producing a value much smaller than the true image size. The result
> is assigned to int64_t total_sectors but the 32-bit multiplication
> has already wrapped around, and the zero-extension to 64-bit does
> not recover the correct value.
> 
> This causes the block layer to reject valid I/O requests (DoS) when
> the reported total_sectors is smaller than the actual image.
> 
> Use 64-bit arithmetic by casting one operand to uint64_t so the
> multiplication is performed in 64-bit precision.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3972
> Signed-off-by: Ma Like <malike@kylinos.cn>

Thanks, applied to the block branch.

Kevin


