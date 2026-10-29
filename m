Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FAD606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZUkZLgpU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMN5D-0003No-UE; Thu, 29 Oct 2026 06:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xMN53-0003Lp-WD
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 06:09:58 -0400
Received: from out-71.mta1.migadu.com ([95.215.58.71] helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xMN50-0001xe-Ui
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 06:09:57 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=M1aZcTi6BkIcjUUAmagwVmRLrdw45WDcyYpmmIcCga0=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793268590; v=1; x=1793873390;
 b=ZUkZLgpUB83ZrGG3KNq9bo4Y09DHxQIqSPU7ghBfiNOTeZkpkAnRoQz3JmwHX7KOQ8e1rGwy
 Ti1OPpFlQSI03bMKASJIFlxq9MXGKvHqTeAfKmBKyUdMyy1hAg1JEP5WP8FpdlM5vFz7DFNBqST
 Tna7Omv7kyHAx/Mq3ucW5oWE=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id e91d0dfb8fdd1b50;
 Thu, 29 Oct 2026 10:09:50 +0000
X-Mizu-Trace-ID: e91d0dfb8fdd1b50
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: jamin_lin@aspeedtech.com, kraxel@redhat.com, marcandre.lureau@redhat.com
Cc: clg@kaod.org, peter.maydell@linaro.org, kane_chen@aspeedtech.com,
 troy_lee@aspeedtech.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 junjie.cao@intel.com, junjie.cao@linux.dev
Subject: Re: [PATCH v7 1/8] hw/usb/bus: Let the controller ask for the
 automatic hub
Date: Thu, 29 Oct 2026 05:09:40 -0500
Message-ID: <20261029100942.894066-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028034140.367393-2-jamin_lin@aspeedtech.com>
References: <20261028034140.367393-1-jamin_lin@aspeedtech.com>
 <20261028034140.367393-2-jamin_lin@aspeedtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.215.58.71; envelope-from=junjie.cao@linux.dev;
 helo=mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Jamin,

On Wed, Oct 28, 2026 at 03:41:42AM +0000, Jamin Lin wrote:
> xHCI has up to 15 root ports, so it no longer grows a hub on its own. A
> user who wants more ports there adds "-device usb-hub".

qemu-xhci still defaults to 4 ports. With -M pc-q35-11.1, qemu-xhci and
five HID devices, a build without the series puts a hub on port 4 with
the last two behind it. On v7 the fifth device fails with "no free
ports".

Migration from an older QEMU breaks too. Four devices on qemu-xhci, saved
by a build without the series and loaded by v7 with the same command line:

  Unknown section or instance '0000:00:01.0/4/usb-hub' 0

So for the xhci and ehci patches in v8 the flag needs to be a
property that hw_compat_11_1 keeps on for older machine types. For EHCI
that only matters with companions: q35 -usb (ich9 EHCI plus UHCI) puts
the hub on port 6 today.

Thanks,
Junjie

