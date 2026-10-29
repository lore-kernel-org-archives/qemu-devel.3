Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68216606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pdXFLl3j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRRe-0004ue-Of; Thu, 29 Oct 2026 10:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xMRRY-0004te-Gk
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:49:29 -0400
Received: from out-161.mta1.migadu.com ([95.215.58.161] helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xMRRW-0000D4-Fp
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:49:28 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=l/+SzlM9oIx6V0PxTouj2tvr+A2/WjLacdZy7Q9nE6Y=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793285364; v=1; x=1793890164;
 b=pdXFLl3jvADCJEuH9nGrY1cXkt3/YEFvhDu8ayAIaOvT8n5snKzPHq6j6x21glV8L7Co8j2M
 Hb7ErG/dXQB1PfG3XPrsnWwoXzTf0rZdQVlqDdCkWsxDa/f8iFqYigDJgId6yIpBQwYz6RC3SAR
 PsT66DxhFf+X8FwcU0TDz2z4=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 67d7866950629b5f;
 Thu, 29 Oct 2026 14:49:24 +0000
X-Mizu-Trace-ID: 67d7866950629b5f
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: kraxel@redhat.com
Cc: jamin_lin@aspeedtech.com, marcandre.lureau@redhat.com, clg@kaod.org,
 peter.maydell@linaro.org, kane_chen@aspeedtech.com,
 troy_lee@aspeedtech.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 junjie.cao@intel.com, junjie.cao@linux.dev
Subject: Re: [PATCH v7 1/8] hw/usb/bus: Let the controller ask for the
 automatic hub
Date: Thu, 29 Oct 2026 09:49:14 -0500
Message-ID: <20261029144914.916641-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <auMtC1vX9nRw1YIn@nucbdw.ghoffman.csb.home.kraxel.org>
References: <20261028034140.367393-1-jamin_lin@aspeedtech.com>
 <20261028034140.367393-2-jamin_lin@aspeedtech.com>
 <20261029100942.894066-1-junjie.cao@linux.dev>
 <auMtC1vX9nRw1YIn@nucbdw.ghoffman.csb.home.kraxel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.215.58.161; envelope-from=junjie.cao@linux.dev;
 helo=mta1.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

Hi Gerd,

On Thu, Oct 29, 2026 at 12:33:54PM +0100, Gerd Hoffmann wrote:
> Which is a bad idea to begin with.  Just configure xhci to have
> more ports if 4 is not enough.

Indeed, p2=/p3= covers that.

> So, if we need a property anyway, I guess it is better to have all
> usb host adapters behave the same and flip auto-hub to default off
> for new machines types.  It's easy enough to turn it back on via
> qemu command line if needed.

Agreed. One case to account for is raspi: it has no versioned
machine types, and dwc2 has a single root port.
"-device usb-kbd -device usb-mouse" relies on the automatic hub
today; with auto-hub off, the second device would fail with
"no free ports".

I suggest enabling auto-hub in bcm2835_peripherals to preserve
the current board behaviour while leaving the controller default
off.

I will rerun the migration check on v8.

Thanks,
Junjie

