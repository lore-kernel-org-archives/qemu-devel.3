Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54EA606A31D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=psyn2a6f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSbDI-00010z-1c; Sun, 15 Nov 2026 09:28:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xSbDG-00010c-Jd
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 09:28:10 -0500
Received: from out-5.mta0.migadu.com ([2001:41d0:1004:224b::5]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xSbDF-0002ty-4b
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 09:28:10 -0500
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=h7VkpriWtTZEEvDYpG6/XTRLg50XqPCfc2gMOJDF8mc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794752884; v=1; x=1795357684;
 b=psyn2a6f5QgmJOiKHB8XOg7KTodnnWYzp3FSm6sHimbMEf81H8V32WaXLCX/YimGnCv6IJMJ
 UHmqDblzI8+HdFkk9RwuV1m9LNp6Be8VfW7GlbFiK9pmZGjg63jIvjuJh/dmM2QpdQHJFpFx7FA
 x3Au1wabdKUIO33hfYcb3J+Y=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 2e2c63ab4aca9fc8;
 Sun, 15 Nov 2026 14:28:04 +0000
X-Mizu-Trace-ID: 2e2c63ab4aca9fc8
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: Tommaso Califano <tcalifano@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Junjie Cao <junjie.cao@linux.dev>
Subject: Re: [PATCH 6/9] hw/usb/dev-mtp: Detect end of SendObject data
 correctly
Date: Sun, 15 Nov 2026 08:28:00 -0600
Message-ID: <20261115142800.1299746-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112174907.158825-7-tcalifano@redhat.com>
References: <20261112174907.158825-1-tcalifano@redhat.com>
 <20261112174907.158825-7-tcalifano@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::5;
 envelope-from=junjie.cao@linux.dev; helo=mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 06:49:03PM +0100, Tommaso Califano wrote:
> +        if ((p->iov.size % p->ep->max_packet_size) || !p->iov.size ||

max_packet_size is 0 until the guest sets a configuration
(usb_ep_reset()), and dev-mtp handles bulk packets before that. From
qtest, OpenSession, SendObjectInfo and SendObject without
SET_CONFIGURATION write the file on master; with the series applied
QEMU dies with SIGFPE on this line.

> +         *  - A Zero Length Packet

usb_mtp_handle_data() stalls every OUT packet shorter than the
container header before it gets here, so the !p->iov.size arm is not
reached. With libmtp 1.1.20 in a Linux guest on xHCI or EHCI, a 500
byte file (512 with the header) now lands intact, but mtp-sendfile
still fails with "PTP I/O Error": the ZLP that ends the data phase
(MTP 1.1, Appendix H) gets the "packet too small" STALL.

Junjie

