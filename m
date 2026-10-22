Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0517606A31B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 06:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pwZdbIMg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJlzG-0001GH-Ah; Thu, 22 Oct 2026 02:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xJlzC-0001FU-SO
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 02:09:10 -0400
Received: from out-217.mta0.migadu.com ([2001:41d0:1004:224b::d9]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xJlzA-0000HL-LR
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 02:09:10 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=z0lyGcNhDgD/gApzSZZSTpLGayjuLxdP7CCl8gtbzxM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792649344; v=1; x=1793254144;
 b=pwZdbIMgjg7KGglb/aoOgcC9MEWZfp50tQTQ0XJh3lscfXsEcYvOERS61dOHIAdFqXXDYDfS
 V8mki15oR2TrkXd/3HXwZ6LtSz8W4fdl/kkWxA7isA2cqiaGAxxr9qCmo2GkNDNRibz8hlCbNvG
 ljS+rGEMIJX/PCbrLqsUdL6w=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 6a597d224b1d1149;
 Thu, 22 Oct 2026 06:09:04 +0000
X-Mizu-Trace-ID: 6a597d224b1d1149
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: jamin_lin@aspeedtech.com
Cc: marcandre.lureau@redhat.com, clg@kaod.org, peter.maydell@linaro.org,
 kane_chen@aspeedtech.com, troy_lee@aspeedtech.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, junjie.cao@intel.com
Subject: Re: [PATCH v6 7/8] hw/usb/redirect-server: Stream interrupt IN
 endpoints
Date: Thu, 22 Oct 2026 06:08:55 +0000
Message-ID: <20261022060855.941871-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019092448.278079-8-jamin_lin@aspeedtech.com>
References: <20261019092448.278079-1-jamin_lin@aspeedtech.com>
 <20261019092448.278079-8-jamin_lin@aspeedtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::d9;
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

From: Junjie Cao <junjie.cao@intel.com>

Hi Jamin,

On v6, the local test device delivers data after an IOERROR without
another start request. STALL stops the stream.

With a bulk IN endpoint at 0x83, v6 accepts the start request and sends
the data as an interrupt_packet after the device wakes.

Could we also reject non-interrupt endpoints in
start_interrupt_receiving()?

Thanks,
Junjie

