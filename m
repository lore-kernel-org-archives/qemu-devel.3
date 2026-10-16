Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C084CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHcss-0001Iu-8B; Fri, 16 Oct 2026 04:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xHcsn-0001Ht-Ni
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 04:01:42 -0400
Received: from out-7.mta1.migadu.com ([95.215.58.7] helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xHcsk-0005Lq-T6
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 04:01:41 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=69aTHhIYHsOoZl/V19r+fpdM6yp3IXUoZ6jee1rzEjU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792137694; v=1; x=1792742494;
 b=jVnTAdMZEWz2CMfDxKGs7enaG8TYzSUnzDetZ6U9L0zbWw3EBU+KbqKLx8sAwdA9glJ/FYF4
 Srv9sF+XGMJ6xUrkla7YYhJWkrkA50TykDKO4TOYmYGtVWle7nl1xzUASpJ8H3N4L5NcDq27mSD
 94gVXnPc3DKxzGfnBPlG4MJQ=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 0e9cc5ca80046c94;
 Fri, 16 Oct 2026 08:01:34 +0000
X-Mizu-Trace-ID: 0e9cc5ca80046c94
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: jamin_lin@aspeedtech.com
Cc: marcandre.lureau@redhat.com, clg@kaod.org, peter.maydell@linaro.org,
 steven_lee@aspeedtech.com, leetroy@gmail.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, troy_lee@aspeedtech.com, junjie.cao@intel.com
Subject: Re: [PATCH v5 5/8] hw/usb/redirect-server: Implement control transfers
Date: Fri, 16 Oct 2026 08:01:24 +0000
Message-ID: <20261016080125.418342-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015093417.573063-6-jamin_lin@aspeedtech.com>
References: <20261015093417.573063-1-jamin_lin@aspeedtech.com>
 <20261015093417.573063-6-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.215.58.7; envelope-from=junjie.cao@linux.dev;
 helo=mta1.migadu.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Junjie Cao <junjie.cao@intel.com>

Hi Jamin,

The tests below were run on v4; patches 5 and 6 are unchanged in v5.

> +    usbredir_server_do_control(priv, id, hdr, data, data_len,
> +                               USBREDIR_SERVER_REPLY_CONTROL);

The callback owns data, but do_control() copies it without freeing the
original buffer. In a test with usb-storage, 100 vendor control OUT
requests carrying 64 bytes each complete with STALL, but LSan reports
6,400 bytes leaked in 100 parser allocations.

Could we call usbredirparser_free_packet_data() after do_control()
returns, and free data on every exit from the bulk and interrupt
callbacks in patch 6?

> +    QTAILQ_REMOVE(&s->inflight, rp, next);
> +    usb_packet_cleanup(&rp->pkt);

A test device returning async IOERROR for the first of two bulk OUT
requests reproduces an assertion here. The core calls back for the
second packet with USB_RET_REMOVE_FROM_QUEUE, but leaves it QUEUED on
ep->queue. usb_packet_cleanup() then hits its
!usb_packet_is_inflight() assertion.

Could we call usb_cancel_packet() for that status before cleanup?
For a QUEUED packet it removes the core queue entry without calling
the device's cancel callback.

In the not-found case of usbredir_server_cancel_data_packet():

> +    usbredirparser_send_control_packet(s->parser, id, &resp, NULL, 0);

If the original reply is already queued when the cancel arrives, the
QEMU client consumes its cancelled-ID entry when it receives that
reply. The extra control packet then sends a second reply for the
same ID.

Could we omit this reply when the transfer is not found?
usbredirhost_cancel_data_packet() also sends no additional reply
in that case.

