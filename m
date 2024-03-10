Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12774C54E49
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 20:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjPjg-0006Qw-OQ; Sun, 10 Mar 2024 16:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor.prutyanov@phystech.edu>)
 id 1rjPjd-0006Qd-FZ
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 16:25:30 -0400
Received: from forward501c.mail.yandex.net ([2a02:6b8:c03:500:1:45:d181:d501])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor.prutyanov@phystech.edu>)
 id 1rjPja-0004tB-L2
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 16:25:29 -0400
Received: from mail-nwsmtp-mxback-production-main-412.sas.yp-c.yandex.net
 (mail-nwsmtp-mxback-production-main-412.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:3f8a:0:640:ecc1:0])
 by forward501c.mail.yandex.net (Yandex) with ESMTPS id DC42360B50;
 Sun, 10 Mar 2024 23:25:20 +0300 (MSK)
Received: from mail.yandex.ru (2a02:6b8:c08:b694:0:640:811:0
 [2a02:6b8:c08:b694:0:640:811:0])
 by mail-nwsmtp-mxback-production-main-412.sas.yp-c.yandex.net (mxback/Yandex)
 with HTTP id 9PrTUj3OuSw0-kPknSCVz; Sun, 10 Mar 2024 23:25:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phystech.edu;
 s=mail; t=1710102320;
 bh=LdFG0r+zvZ5+yz03RPyuR3PHz4I0I2LcOuUQ3Z5dtIk=;
 h=Message-Id:References:Date:Cc:Subject:In-Reply-To:To:From;
 b=nG1iblURlHox2eO+hDL24iqxewvYPr5Ako/TUJDACgPPuGWK8i8xewclNQ3ndwKok
 24oKtqUGjB2NF6bzg8ci5O6mzHpfy+eJbMiCOPtKb+WTNWVg1WtZzyQcvCs8m0C7zD
 fNo2eEKndYeIYvYVnIvuRmCIdVShVc9LZeHZrcHY=
Authentication-Results: mail-nwsmtp-mxback-production-main-412.sas.yp-c.yandex.net;
 dkim=pass header.i=@phystech.edu
Received: by 24jwihnks63ygbra.sas.yp-c.yandex.net with HTTP;
 Sun, 10 Mar 2024 23:25:19 +0300
From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
In-Reply-To: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
Subject: Re: [PATCH v4 00/19] contrib/elf2dmp: Improve robustness
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Sun, 10 Mar 2024 23:25:19 +0300
Message-Id: <3653711710102319@24jwihnks63ygbra.sas.yp-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:d501;
 envelope-from=viktor.prutyanov@phystech.edu; helo=forward501c.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> elf2dmp sometimes fails to work with partially corrupted dumps, and also
> emits warnings when sanitizers are in use. This series are collections
> of changes to improve the situation.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v4:
> - Remove unnecessary !! idiom (Peter Maydell)
> - Link to v3: https://lore.kernel.org/r/20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com
> 
> Changes in v3:
> - Split patch "contrib/elf2dmp: Conform to the error reporting pattern".
> (Peter Maydell)
> - Stated that the relevant value is little-endian in patch
> "contrib/elf2dmp: Use lduw_le_p() to read PDB".
> - Added a message saying "Build it only for little endian hosts until
> they are fixed." for patch "contrib/elf2dmp: Build only for little
> endian host".
> - Added patch "contrib/elf2dmp: Ensure phdrs fit in file" to fix
> https://gitlab.com/qemu-project/qemu/-/issues/2202 as patch
> "contrib/elf2dmp: Clamp QEMU note to file size" was not really fixing
> the crash.
> - Link to v2: https://lore.kernel.org/r/20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com
> 
> Changes in v2:
> - Added patch "contrib/elf2dmp: Remove unnecessary err flags".
> - Added patch "contrib/elf2dmp: Assume error by default".
> - Added patch "contrib/elf2dmp: Conform to the error reporting pattern".
> - Added patch "contrib/elf2dmp: Build only for little endian host".
> - Added patch "contrib/elf2dmp: Use GPtrArray".
> - Added patch "contrib/elf2dmp: Clamp QEMU note to file size".
> - Changed error handling in patch "contrib/elf2dmp: Ensure segment fits
> in file" (Peter Maydell)
> - Added a comment to fill_context() that it continues on failure.
> (Peter Maydell)
> - Link to v1: https://lore.kernel.org/r/20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com
> 
> ---
> Akihiko Odaki (19):
> contrib/elf2dmp: Remove unnecessary err flags
> contrib/elf2dmp: Assume error by default
> contrib/elf2dmp: Continue even contexts are lacking
> contrib/elf2dmp: Change pa_space_create() signature
> contrib/elf2dmp: Fix error reporting style in addrspace.c
> contrib/elf2dmp: Fix error reporting style in download.c
> contrib/elf2dmp: Fix error reporting style in pdb.c
> contrib/elf2dmp: Fix error reporting style in qemu_elf.c
> contrib/elf2dmp: Fix error reporting style in main.c
> contrib/elf2dmp: Always check for PA resolution failure
> contrib/elf2dmp: Always destroy PA space
> contrib/elf2dmp: Ensure segment fits in file
> contrib/elf2dmp: Use lduw_le_p() to read PDB
> contrib/elf2dmp: Use rol64() to decode
> MAINTAINERS: Add Akihiko Odaki as a elf2dmp reviewer
> contrib/elf2dmp: Build only for little endian host
> contrib/elf2dmp: Use GPtrArray
> contrib/elf2dmp: Clamp QEMU note to file size
> contrib/elf2dmp: Ensure phdrs fit in file
> 
> MAINTAINERS | 1 +
> contrib/elf2dmp/addrspace.h | 6 +-
> contrib/elf2dmp/download.h | 2 +-
> contrib/elf2dmp/pdb.h | 2 +-
> contrib/elf2dmp/qemu_elf.h | 2 +-
> contrib/elf2dmp/addrspace.c | 63 ++++++++++-------
> contrib/elf2dmp/download.c | 12 ++--
> contrib/elf2dmp/main.c | 168 ++++++++++++++++++++------------------------
> contrib/elf2dmp/pdb.c | 61 +++++++---------
> contrib/elf2dmp/qemu_elf.c | 150 ++++++++++++++++++++++-----------------
> contrib/elf2dmp/meson.build | 2 +-
> 11 files changed, 238 insertions(+), 231 deletions(-)
> ---
> base-commit: bfe8020c814a30479a4241aaa78b63960655962b
> change-id: 20240301-elf2dmp-1a6a551f8663
> 
> Best regards,
> 
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>

Hi,

I've tested the series with Windows Server 2022 Standard (Build 20348), 4GiB, 4 vCPUs.

Tested-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>


