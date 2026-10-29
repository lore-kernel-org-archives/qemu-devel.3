Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A5C606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pYQ7g/ez
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMN5E-0003OR-Bk; Thu, 29 Oct 2026 06:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xMN54-0003Lq-Jf
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 06:09:58 -0400
Received: from out-94.mta1.migadu.com ([95.215.58.94] helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xMN53-0001yH-0k
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 06:09:58 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=BD4Snov0oFLQ4bYF3h6yCuPvSGOV3UGd4b/zdzIx2g8=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793268595; v=1; x=1793873395;
 b=pYQ7g/ezwAy1aZflVY/6f7q/8cuCi6VYhecx3F6Mj2zxWWvWMmrIRRGvj7IJt2dXyO9GWDWl
 fGOo3qd1+zWhxPwgWanUppDMn/+SOwlfK1ABmpUrTmi8IDgRlNaKfe6JuG42uanUsZREFlTrAF8
 IejLVF7rUkw29mYHRiohnGGA=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 991dc1f8a0aa8159;
 Thu, 29 Oct 2026 10:09:55 +0000
X-Mizu-Trace-ID: 991dc1f8a0aa8159
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: jamin_lin@aspeedtech.com, kraxel@redhat.com, marcandre.lureau@redhat.com
Cc: clg@kaod.org, peter.maydell@linaro.org, kane_chen@aspeedtech.com,
 troy_lee@aspeedtech.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 junjie.cao@intel.com, junjie.cao@linux.dev
Subject: Re: [PATCH v7 6/8] hw/usb/redirect-server: Implement bulk and
 interrupt transfers
Date: Thu, 29 Oct 2026 05:09:42 -0500
Message-ID: <20261029100942.894066-3-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028034140.367393-7-jamin_lin@aspeedtech.com>
References: <20261028034140.367393-1-jamin_lin@aspeedtech.com>
 <20261028034140.367393-7-jamin_lin@aspeedtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.215.58.94; envelope-from=junjie.cao@linux.dev;
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

On Wed, Oct 28, 2026 at 03:41:48AM +0000, Jamin Lin wrote:
> +    int actual = rp->pkt.actual_length;
> +    /* Only an IN transfer carries data back. */
> +    int len = is_in ? actual : 0;

For OUT this also zeroes the length in the reply header, and redirect.c
copies that length into p->actual_length.

With usb-storage exported and qemu-xhci on the client side, the device
enumerates, but the Debian guest keeps resetting it and no sda shows
up. A usb-ehci client works, because EHCI ignores the OUT length.

Keeping actual in the header and sending no payload for OUT, as
usbredirhost does, fixes it here: sda appears on xHCI and a 1 MiB
write/read compares equal. The control and interrupt OUT replies drop
the length the same way.

The endpoint checks from v6 work now, including start_interrupt_receiving
on a bulk endpoint, thanks.

Junjie

