Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACEDCCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHcst-0001J0-8F; Fri, 16 Oct 2026 04:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xHcsq-0001ID-3v
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 04:01:44 -0400
Received: from out-65.mta0.migadu.com ([2001:41d0:1004:224b::41]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xHcso-0005MA-MZ
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 04:01:43 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=ueKnv8hoHPcw1K0DB571Ws+G4/hIzk1gp9S8LF7tg1o=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792137701; v=1; x=1792742501;
 b=tnZ2M8tP8vuw03LqBsS6EY+LEF5nqQgIVU9hI4cySiDVzKKeX22Q4duQZhjsV6Au9ixj1HC2
 DPYc7G5wugG6/GBCouauJFXGsO6CzhXaCQPr1NXxu3FToD1sH1zrjQf/ll1xSn33nyOpWbDckxc
 KL+bAeigIKOyL2/PAAx0RieQ=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id f3cc72a861881f50;
 Fri, 16 Oct 2026 08:01:40 +0000
X-Mizu-Trace-ID: f3cc72a861881f50
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: jamin_lin@aspeedtech.com
Cc: marcandre.lureau@redhat.com, clg@kaod.org, peter.maydell@linaro.org,
 steven_lee@aspeedtech.com, leetroy@gmail.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, troy_lee@aspeedtech.com, junjie.cao@intel.com
Subject: Re: [PATCH v5 7/8] hw/usb/redirect-server: Stream interrupt IN
 endpoints
Date: Fri, 16 Oct 2026 08:01:25 +0000
Message-ID: <20261016080125.418342-2-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015093417.573063-8-jamin_lin@aspeedtech.com>
References: <20261015093417.573063-1-jamin_lin@aspeedtech.com>
 <20261015093417.573063-8-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::41;
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

> +        st.status = usbredir_server_status(p->status);
> +        usbredirparser_send_interrupt_receiving_status(s->parser, 0, &st);
> +        usbredirparser_do_write(s->parser);
> +        s->intr_stream[ep_nr].started = false;

Could we report usb_redir_stall when stopping the stream here? The
usb_redir_interrupt_receiving_status section of the protocol requires
that status when a stream stops without an explicit stop request.

In the QEMU client's status callback, only STALL clears
interrupt_started. Other errors leave it set, so restarting the stream
then depends on another path, such as endpoint stop or reconfiguration.

