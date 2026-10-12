Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F0CCA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDeG-0004VY-3N; Mon, 12 Oct 2026 06:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xGDe3-0004SO-Ga
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xGDe1-0008NU-3w
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791802355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IsRn7PV3l+8mlXtFBO4xCa/w47VMFvOMUms3G9TD6Tc=;
 b=Jv920AcFq0FROegc+qsb392tsFYUE8GInIAPJuIHn1WT6M+S+3yBxHY03/ni7Gar8c4yZk
 6kG15GME3ClETmQ9V3ESy1zC1G9U58j7THy2rm3dIsuS6Zy4Ff0S3hPzk5y+1QlyLYtYSg
 3+ajTBDMCArbCfGYfwsyjZrOXDXHe58=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-cTkIDzJwMSyjVWklPM3Jnw-1; Mon,
 12 Oct 2026 10:52:32 +0000
X-MC-Unique: cTkIDzJwMSyjVWklPM3Jnw-1
X-Mimecast-MFC-AGG-ID: cTkIDzJwMSyjVWklPM3Jnw_1791802351
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 773FC1829E35; Mon, 12 Oct 2026 10:52:30 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF38E1955E97; Mon, 12 Oct 2026 10:52:27 +0000 (UTC)
Date: Mon, 12 Oct 2026 12:52:25 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Christian Quante <christian@quante.one>
Cc: John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/qtest/fdc-test: check block accounting of non-DMA
 reads
Message-ID: <asy76X2lm9Og9L8B@redhat.com>
References: <20261011081433.73397-1-christian@quante.one>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011081433.73397-1-christian@quante.one>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 11.10.2026 um 10:14 hat Christian Quante geschrieben:
> Since commit 9c4c09d2a663 ("hw/block/fdc: account for read and write
> requests"), the floppy reports its reads and writes in query-blockstats.
> Check this for the existing non-DMA reads: send_read_no_dma_command()
> now compares rd_operations and rd_bytes before and after the command,
> one 512-byte request for every sector the test reads through the FIFO.
> 
> Without the accounting, read_no_dma_1, read_no_dma_18 and
> read_no_dma_19 fail with rd_operations at 0 instead of 2, 36 and 38.
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Christian Quante <christian@quante.one>

Thanks, applied to the block branch.

Kevin


