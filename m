Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34E4D3C921
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2024 16:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2CUx-000208-QR; Sat, 19 Oct 2024 12:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1t2CUs-0001vY-UH
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 12:40:10 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1t2CUp-0003gU-H2
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 12:40:10 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 4078117F753
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2024 18:39:57 +0200 (CEST)
Received: (qmail 9700 invoked by uid 990); 19 Oct 2024 16:39:57 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sat, 19 Oct 2024 18:39:56 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>
Subject: [RFC PATCH v2 0/7] tcg-plugins: add hooks for interrupts,
 exceptions and traps
Date: Sat, 19 Oct 2024 18:39:33 +0200
Message-ID: <cover.1729355735.git.neither@nut.email>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20231021122502.26746-1-neither@nut.email>
References: <20231021122502.26746-1-neither@nut.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-0.000013) MIME_GOOD(-0.1)
X-Rspamd-Score: 0.899986
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=evIaEZnuYYugfnefbvuAAsBQdMwoHWbcJqmDYP+uTkw=;
 b=HvuH0CYm9MxPKp5Nx1rSjvBBu66c0UDuNCLiRkzB59BW7aVirP4MTW1QGW+DzmO1l/qEKgp5g0
 xhmSeoTz4AJ3QesoAjoQ98G5PAAsJbwWNewn0fM7/roq4iFWt2zT2Ykpa7JqN1mHxu0u3Gjj3k10
 L7rUh2lMkwfcS4VVwrvsAyZqIMwujYqhlHjdocuoXJTNGFDUF+LQsWnAnJob9sMeHKPq7BVgW2Co
 E8dRyoHMw1Wbh8rM9WDCpL1AEWKRmhhZH9Q32m/TbZWnruwjUvTCN24IO40BpjPd36aY1pAQSg1c
 TK967X9Xj1eBOyEpqKquCuXMgGDN1C9FZvl5oEKNuSeYqd5T8zyn4zMaasUjX503nqs/iqvX+1CA
 w5eygLEQFVW5sfTYGdDoXjL5azdL8LO6BVwUeKgEnnhDBxLpL8Z4kKDbZL2EVnWBTenhqbTjsYv6
 Ey0Vmob4ALvQgQsq+Cq9befMpvbc5ieOo1KQqHfDjBlg0ZmddEzharqEHv1cV3eq8vYMBRFfSxU3
 XNhMncANrKOP4L05AiGh7JBBy7ZHDa/sc/HUh6C7F+tAtyGGwKIRQfGbWCyd3kIdXweB5fESSl1p
 apAxt+spR1B4sMq4i6eFHHvmQbmosEjZVP2atFftE2ZBEWEvd2Qr/UpBAw4gGjUpM8OY75zCzb0/
 k=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some analysis greatly benefits, or depends on, information about
interrupts. For example, we may need to handle the execution of a new
translation block differently if it is not the result of normal program
flow but of an interrupt.

Even with the existing interfaces, it is more or less possible to
discern these situations, e.g. as done by the cflow plugin. However,
this process poses a considerable overhead to the core analysis one may
intend to perform.

These changes introduce a generic and easy-to-use interface for plugin
authors in the form of callbacks for different types of traps. Patch 1
defines the callback registration functions and supplies a somewhat
narrow definition of the event the callbacks are called. Patch 2 adds
some hooks for triggering the callbacks. Patch 3 adds an example plugin
showcasing the new API. The remaining patches call the hooks for a
selection of architectures, mapping architecture specific events to the
three categories defined in patch 1. Future non-RFC patchsets will call
these hooks for all architectures (that have some concept of trap or
interrupt).

Sidenote: I'm likely doing something wrong for one architecture or
the other. For example, with the old version Alex Bennée suggested
registering a helper function with arm_register_el_change_hook() for
arm, which is not what I ended up doing. And for AVR my approach to just
assume only (asynchroneous) interrupts exist is also likely too naïve.

Since v1:
  - Split the one callback into multiple callbacks
  - Added a target-agnostic definition of the relevant event(s)
  - Call hooks from architecture-code rather than accel/tcg/cpu-exec.c
  - Added a plugin showcasing API usage

Julian Ganz (7):
  plugins: add API for registering trap related callbacks
  plugins: add hooks for new trap related callbacks
  contrib/plugins: add plugin showcasing new trap related API
  target/arm: call plugin trap callbacks
  target/avr: call plugin trap callbacks
  target/riscv: call plugin trap callbacks
  target/sparc: call plugin trap callbacks

 contrib/plugins/Makefile     |  1 +
 contrib/plugins/traps.c      | 89 ++++++++++++++++++++++++++++++++++++
 include/qemu/plugin-event.h  |  3 ++
 include/qemu/plugin.h        | 12 +++++
 include/qemu/qemu-plugin.h   | 45 ++++++++++++++++++
 plugins/core.c               | 42 +++++++++++++++++
 plugins/qemu-plugins.symbols |  3 ++
 target/arm/helper.c          | 23 ++++++++++
 target/avr/helper.c          |  3 ++
 target/riscv/cpu_helper.c    |  8 ++++
 target/sparc/int32_helper.c  |  7 +++
 target/sparc/int64_helper.c  | 10 ++++
 12 files changed, 246 insertions(+)
 create mode 100644 contrib/plugins/traps.c

-- 
2.45.2


