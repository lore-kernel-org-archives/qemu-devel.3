Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F01C5DF89
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfdt-0008EP-Au; Wed, 19 Aug 2026 08:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <opensource@fvhovell.nl>)
 id 1wwfOG-0004cJ-8a; Wed, 19 Aug 2026 08:27:32 -0400
Received: from outbound.soverin.net ([185.233.34.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <opensource@fvhovell.nl>)
 id 1wwfOD-0003AN-Mg; Wed, 19 Aug 2026 08:27:32 -0400
Received: from smtp.freedom.nl (unknown [10.10.4.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by outbound.soverin.net (Postfix) with ESMTPS id 4hQ5Rw5tv7z1yQv;
 Wed, 19 Aug 2026 12:27:24 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [10.10.4.107]) by freedom.nl
 (Postfix) with ESMTPSA id 4hQ5Rw3Vdnz40; 
 Wed, 19 Aug 2026 12:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=fvhovell.nl;
 s=soverin; t=1787142444;
 bh=VUucC/g62kXb8j76BmRpZKbywzFMRxmh0moWCQvJtLg=;
 h=From:To:Cc:Subject:Date:From;
 b=0eZpJBCBT+3JXdZ1kjjGCb6RG6MUPuZZaTnxgP59RlxsLN8EOZwj00UY/QHijojq7
 lX48+rc0+ijitSge1q6zH0gqIz2kbWH4W/eWcSI0yG3OPSc68m19gpxzKnAFVrm/zU
 WrZ3L0y82EGt1PyhTRYY9ofl8CFwlg4U1tLR4c0lsIGRqN9TE/PBM0ljwT67/VNYd+
 y+jH08UDJWdU9xxDGFGvS2nHPZFD4ZUsdqFYiea5GugIUQeKwqRXPmVeKIzR6nKH8X
 kO2UA3z1Nn47KCLlEPPtbACZ/opAjfW86l6WA6VomHhnoQdQIKUsvC3STn1PG7FkSd
 nD0Sei43RlRgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fvhovell.nl; s=soverin1;
 t=1787142444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=c/FTrsWIZxwNxi/YwD95abZhrR/8e8ocbLx0Fsx7fJc=;
 b=N/nMRjVf/+9FnvYojvo6s2NiV0JLGIu+S02Sdcm8uLoxO5HsEA8TJ4minD5hhlBgRwE9RT
 A9eyL/UdlIfjV4fjQioh3EPMO52lxrQCQM/LBEI4XZzizG3KqNTbiRmTBEk8ULqsu0FGNC
 cnh93nR/mEfNCDxjbs37sWqNYGue4E5mTOWG9HLIwLSvIsJE0XX9RiRnzH3/ZIckkMK42o
 lAdwQzHkCpVvfTipdXLB4s3Lmada2Wh4BHYiILLNXIkCrPzSWJOfI0BsZd/zx8PK7L2YUQ
 Gs8ww79BJUhdsyfE0NM5Thy5IxhA+Fy6DXuNUNcPBEdQVSvVgnXaZaue+HZIhQ==
X-CM-Envelope: MS4xfJ2OMNX+ETStp6UjfAhZrH0YHy7d7WzyXyQyqD5sARy7Y0ljt72ZZ/XZ6Y71AEoFX73C+MIb6YqmpcvXtB4oc72enf8QEdIkourTV+B6RN+HzrdI8ZD2
 8hbba/XzkoXNAKJR/Tl8n8Nim7E/eXLJ6z5jjGHAHfg53Ht2wcbrBZO8kMQ7aLaUWDDpf0FkYvwjMvOpPLNv8YqWT0A7dzve6xTawShK1mlna1muD9ZvQtzq
 9X0KwKbH2Z/IfI7nJf9xx53RUh8LEa10Blz6ilZTPrbqk0dIDrlYZbxch4VPFlcVRkUku1yn0SytE4ZpSk9qmKftk+i6B3xfVWLCIk+6zB9Pp7n0/roSvAm2
 unAL7sUGbwK2cvNBHWEXZ53RXb6yEyoNSrK4jtQTihW+Ey5YdGw=
X-Soverin-Id: 01a019fd-93e0-7273-81bf-76f23a846e64
From: opensource@fvhovell.nl
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Peter Maydell" <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Frederik=20van=20H=C3=B6vell?= <frederik@fvhovell.nl>
Subject: [PATCH 0/4] Support booting modern EDK2 on raspi3b board
Date: Wed, 19 Aug 2026 14:26:58 +0200
Message-ID: <20260819122702.54173-1-opensource@fvhovell.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spampanel-Class: ham
Received-SPF: pass client-ip=185.233.34.146;
 envelope-from=opensource@fvhovell.nl; helo=outbound.soverin.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Aug 2026 08:43:31 -0400
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

From: Frederik van Hövell <frederik@fvhovell.nl>

This series fixes raspi3b board behaviour when using EDK2 firmware:
- fix framebuffer base response: firmware (and linux kernel) expects
  returned address as seen from VC4 GPU memory view.
- fix firmware revision response: EDK2 firmware expects a valid epoch
  timestamp after year 2000, where previous used value was far too old.

NB: Due to incomplete emulation it does not yet work for raspi4b
(missing RNG200 and GENETv5, amongst other issues).

As convenience it fixes starting raspi3ap, raspi3b and raspi4b boards
with firmware using '-bios RPI_EFI.fd' (as was already possible using
'-loader file=RPI_EFI.fd,force-raw=true').

Finally it adds an functional test for running EDK2 firmware using new
parameter -bios on raspi3b and bumps RPi3 EDK2 release to latest v1.52.

Frederik van Hövell (4):
  hw/misc/bcm2835_property: fix RPI_FWREQ_FRAMEBUFFER_ALLOCATE response
  hw/misc/bcm2835_property: fix RPI_FWREQ_GET_FIRMWARE_REVISION response
  hw/arm/raspi: implement booting firmware at 0x0 using -bios on boards
    3ap, 3b and 4b
  tests/functional/aarch64/test_raspi3: update firmware to v1.52

 docs/system/arm/raspi.rst               | 12 ++++++++++++
 hw/arm/raspi.c                          | 17 +++++++++++------
 hw/misc/bcm2835_property.c              |  6 ++++--
 include/hw/display/bcm2835_fb.h         |  3 ++-
 tests/functional/aarch64/test_raspi3.py | 18 +++++++++++++++---
 5 files changed, 44 insertions(+), 12 deletions(-)

-- 
2.55.0


