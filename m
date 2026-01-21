Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38C4C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 16:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vibBp-0005Qv-Pn; Wed, 21 Jan 2026 11:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vibBe-0005KR-PC
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 11:36:08 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vibBc-0005ZZ-6R
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 11:36:06 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E188460135;
 Wed, 21 Jan 2026 16:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93512C4CEF1;
 Wed, 21 Jan 2026 16:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769013361;
 bh=gT9iaWg1pDgpPuXDDXehLXiITPDCN/gt1eQgSVRWHpc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p3xzy5jEuFPi9MUBm2eLbFeji/vy4hLZZ66Ntjucwnqf7mClQ0cfpvbWcAqTT/mi5
 WqVjyBDfuDcX+CXuXKfxNfm0da9Uio/3mImYy7TJVuWakUykJwUhfzMydgCVTgM+22
 O+7XwuMjE3ydR7EDQX0DZcK2Tiwelb1hZQKPWVqT1cjhGgksLJ31jq3h/TDCRPgsBp
 +S7+oV+/0ByHm+jWUnO3bdj0ntiU8l/VUQ73EM2mg5zAr7VmSZpF/ABpjLjUMizetK
 zsGJBnMQBceOkcd9fwt1aPMdDLn4IRLSXHoLGdVpmsZnW4W0COVDh5vFKCZFPndM33
 KzQeMxXBM+ngg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vibBX-00000003uS6-2nPz; Wed, 21 Jan 2026 17:35:59 +0100
Date: Wed, 21 Jan 2026 17:35:59 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Michael S Tsirkin <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-devel@nongnu.org, 
 Igor Mammedov <imammedo@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 10/13] scripts/ghes_inject: add support for fuzzy logic
 testing
Message-ID: <aXD-R2CjXz-bOk8D@foz.lan>
References: <cover.1768993993.git.mchehab+huawei@kernel.org>
 <5404a11d5fabe0757aaf24e0b355ba16c1f19a12.1768993993.git.mchehab+huawei@kernel.org>
 <20260121133710.00005780@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121133710.00005780@huawei.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jan 21, 2026 at 01:37:10PM +0000, Jonathan Cameron wrote:
> On Wed, 21 Jan 2026 12:25:18 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Add a command to inject random errors for fuzzy logic testing.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Seems reasonable, but maybe some more text in the description on
> what types of fuzzy records it generates?  I.e. what is constrained
> or at least starts as being standard values vs what is entirely random

I'll improve at the next version. By default, it just randomly picks
a valid GUID from the lis, and selects a default size that would be
a valid choice.

There is a parameter to force it to use an specific type:

    $ ghes_inject.py fuzzy -h

    Inject fuzzy test CPER packets

    options:
      -h, --help            show this help message and exit

    Fuzz testing error inject:
      -T, --type TYPE       Type of the error: proc-generic,proc-x86,proc-itanium,proc-arm,platform-mem,platform-mem2,pcie,pci-bus,pci-dev,firmware-error,dma-generic,dma-vt,dma-iommu,ccix-per,cxl-prot-err,cxl-evt-media,cxl-evt-dram,cxl-evt-mem-module,cxl-evt-mem-sparing,cxl-evt-phy-sw,cxl-evt-virt-sw,cxl-evt-mdl-port,cxl-evt-dyna-cap,fru-mem-poison
      --min-size MIN_SIZE   Minimal size of the CPER
      --max-size MAX_SIZE   Maximal size of the CPER
      -z, --zero            Zero all bytes of the CPER payload (default: False)
      -t, --timeout TIMEOUT
                            Specify timeout for CPER send retries (default: 30.0 seconds)
      -d, --delay DELAY     Specify a delay between multiple CPER (default: 0)
      -c, --count COUNT     Specify the number of CPER records to be sent (default: 1)

and parameters to allow it to mangle with the payload size.

When -T is not used, it randomly pics a valid GUID. When it is
used, all injected packages will have the same type.

Right now, the fuzzy-testing is mangling just with the CPER
payload, so GUIDs are valid. see:


  $ ghes_inject.py -d fuzzy
  Injecting cxl-evt-dyna-cap with 64 bytes
  GUID: ca95afa7-f183-4018-8c2f-95268e101a2a
  Generic Error Status Block (20 bytes):
      00000000  01 00 00 00 00 00 00 00 00 00 00 00 88 00 00 00   ................
      00000010  00 00 00 00                                       ....

  Generic Error Data Entry (72 bytes):
      00000000  a7 af 95 ca 83 f1 18 40 8c 2f 95 26 8e 10 1a 2a   .......@./.&...*
      00000010  00 00 00 00 00 03 00 00 40 00 00 00 00 00 00 00   ........@.......
      00000020  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
      00000030  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
      00000040  00 00 00 00 00 00 00 00                           ........

  Payload (64 bytes):
      00000000  32 ba ed 9c 1f ea ac cd 8c 8f 44 7b ab 4b c1 8f   2.........D{.K..
      00000010  68 32 8a c1 07 dd 0f 93 54 de 09 a8 42 79 80 1f   h2......T...By..
      00000020  f4 e8 0c 85 02 2d 0b 7d f5 64 32 8e 3b d6 f1 6b   .....-.}.d2.;..k
      00000030  73 39 97 00 54 30 aa e6 39 f0 5d 95 1c b1 cd 0f   s9..T0..9.].....

The first two tables (GESB and GEDE) aren't randomized, and the GUID is always
a valid one. Jus the payload contains either random numbers (default) or are 
always zero:

  $ ghes_inject.py -d fuzzy -z
  Injecting cxl-evt-media with 32 bytes
  GUID: fbcd0a77-c260-417f-85a9-088b1621eba6
  Generic Error Status Block (20 bytes):
      00000000  01 00 00 00 00 00 00 00 00 00 00 00 68 00 00 00   ............h...
      00000010  00 00 00 00                                       ....

  Generic Error Data Entry (72 bytes):
      00000000  77 0a cd fb 60 c2 7f 41 85 a9 08 8b 16 21 eb a6   w...`..A.....!..
      00000010  00 00 00 00 00 03 00 00 20 00 00 00 00 00 00 00   ........ .......
      00000020  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
      00000030  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
      00000040  00 00 00 00 00 00 00 00                           ........

  Payload (32 bytes):
      00000000  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
      00000010  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................

-- 
Thanks,
Mauro

