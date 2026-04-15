Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93630FA0C3C
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 07:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCuSU-0005wJ-BA; Wed, 15 Apr 2026 03:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wCuSS-0005vZ-0j
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 03:14:44 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wCuSQ-0007qP-4i
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 03:14:43 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7986e538decso68557457b3.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 00:14:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776237281; cv=none;
 d=google.com; s=arc-20240605;
 b=bkHMBxc8dBsJ9zdwb0Wzbwh2Kqr4OSv91IonDVx1dcn9mukB1H01IKK9z52KbEAkii
 q9H2kIOfXYnMKyqoSyiMZaQGu7y4X0dO+5aMdBWbmyADDL7NWVoCdYff80/SSod/MIzW
 +Fk84/CxcOx3WprneT79NcHfoI8nflIW3jp73gqLQ9SZOXNtR+f5ITZV6k0/DWtJEpPU
 9VCXdtVuGKSfA5FCZ4rUDZnvGmpUahR4lS5Zswie1Qcf21/f94027e7e+gwpTubJQEa4
 j/0jiWnvw9eZZVJNiQX7Zqdds/oXSDZhL6NNsU3znaIdjJPRpAWL6tVXw4LSWLUWUSzV
 t0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GRxzTo80Ggp/cYkmiex2UNLSWDsZ/pbNA/eXOwp38XI=;
 fh=n8o7Wo5hKrzUvEiXKfmJRFxGfXOgUeBul2X8QhYIRuo=;
 b=MFFpsKwFvnlaDyjyxp6Hyf6u1YxFOKiowpzE8Zz/h3xFyFVJfaZwzjNK6r9j60KZkq
 jSlfQzAdt30lM0LDkHqZZhVDuRodR85c0MwdG6d6kCp822BupHrrzCJuc7hz3+vYrerH
 GfilcJzrFvQcrzsOeay+1hYMPwVDuM3LEPGjOQNRDqmj7z1rhCKeYm4duRIn+0flD9pH
 fNIquB1qqDDhp8CSadQVrw+hLpCH/8ZEsw8XvPl4q+L7EzRedy+FAeMM/OfukluCW5eD
 yvkggk/qwU0R1Mo5XVpdvygX7CQ5PGtKqnbuisjtXe6BxZ5OQ6OWObovwzY8ld7riWO2
 UctQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1776237281; x=1776842081; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GRxzTo80Ggp/cYkmiex2UNLSWDsZ/pbNA/eXOwp38XI=;
 b=M4g3SZWXJqutgzdZcgG3L1KfmJuEPVvn1QzooZ9fhSlifN6RMnZqg2/z/kDSDshDZx
 NxtPgWTyZ3iHnoqvMcbnkns3grCFeaFe/LHgADpwuDQm9gYUw2CVy0S1GKX0KL1a1t/O
 J7UsSYJv7bwHbgu/+WNwlKgCs7vtudjvibDaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776237281; x=1776842081;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRxzTo80Ggp/cYkmiex2UNLSWDsZ/pbNA/eXOwp38XI=;
 b=EBKtk0ccm1ssmzLj8wLis+tRoI9O3NeZUPlrIEsTdq2SYpKIJDGhQYDQw28wkWpL/k
 dUTqRjoZskXqruWIYnYvBULZ//kuN0ow7F+QOEKOkFE05QhCOMtpTL7PfL2ULHDuHNX5
 3NorH1KOjIXWWJxOv1kWyM5bFeUGDNMx+iK1dXnYiB9OREGsjDDs8p4HP9lXGQ8n9iU6
 mILTkqhzCUUDcYbmG2PqkrqaZOq15G5O/0mrR23aJB4r8tVX+iKPJQwOnzqGrfybcrB5
 To2ElFP2t+RAuPzfLgFjJvQ8yF7cHyMSUNSUxL/V3h67IJTtoVzlLdE0z/VBb6uHUB0+
 GAIQ==
X-Gm-Message-State: AOJu0Yz+LMpotYAnK0xVUYz7yTk9P3FfeQHffoN3Uu9uLwKvM9h3wtmB
 w4jkFRZWTJAgESqveBBJO5i9F/29octfV3FUPWUH24WPBL/ozUPRw6PZyYxZ3A53Cib3I7zcW0Z
 rAt5L8KLL1jJcEzAwt2ByUIuMGZatFQw=
X-Gm-Gg: AeBDieucRiVpaNjlVaKXcUzVK+ty/O4oYK9KSfv/xFbrBZA8mox3DAgkeBtfvezNhss
 LSbvJXuSvRAkJF1mZXmQVVECgHEtCLArrjchAyMYYi+ie+Te4XQgWsm+Et0LfysVIBsbvzrDkjr
 VjtGC+6loKZYak+IOHRIvHT+oDvzyYfFDfGlqO0YnRAu9YdhGupXYEHQqUCPC/elGSooBjzC+0l
 08vKnLRGauCCoUOwKi4E6kbb+JQvLJQ010QkJLoIQI11lKQOUkEEXVytG2qd9BquoD5hRwPggzt
 +XqaV66mjLdXAGfPRSnpVlnwBulS7Q331Ivlfy4w5gcYr2Pin5y08IycHwmatdi3vFySBb8S/Yu
 i2o8=
X-Received: by 2002:a05:690c:12:b0:7ae:904c:11ed with SMTP id
 00721157ae682-7af719597demr244237557b3.36.1776237281018; Wed, 15 Apr 2026
 00:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260109123211.368869-1-joel@jms.id.au>
 <500b32a8.1646.19d14db9723.Coremail.alanosong@163.com>
In-Reply-To: <500b32a8.1646.19d14db9723.Coremail.alanosong@163.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 15 Apr 2026 16:44:28 +0930
X-Gm-Features: AQROBzBf5dYQTnNijeNZSC9liCLTrqvA8yf6Sb0TUINVeqNRyulihNSY9ivDW44
Message-ID: <CACPK8XckX_BM7xn0eUveQG2Wso7U5fN7N34y=KB1jHjAOnmbsw@mail.gmail.com>
Subject: Re: [PATCH] hw/i2c: Add designware i2c controller
To: Alano Song <alanosong@163.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Chris Rauer <crauer@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=joel.stan@gmail.com; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sun, 22 Mar 2026 at 19:54, Alano Song <alanosong@163.com> wrote:
> >--- a/MAINTAINERS
> >+++ b/MAINTAINERS
> >@@ -2668,6 +2668,12 @@ S: Orphaned
> > F: hw/gpio/pcf8574.c
> > F: include/gpio/pcf8574.h
> >
> >+DesignWare I2C
> >+M: Chris Rauer <crauer@google.com>
> >+S: Maintained
> >+F: hw/i2c/designware_i2c.c
> >+F: include/hw/i2c/designware_i2c.h
>
> >+
>
>
> Maybe here can also add Joel and me as reviewer,
> cause we are all familiar with this model.

Sure, I'll add us in.

> >diff --git a/hw/i2c/designware_i2c.c b/hw/i2c/designware_i2c.c
> >new file mode 100644
> >index 000000000000..2e808f61f050
> >--- /dev/null
> >+++ b/hw/i2c/designware_i2c.c
> >@@ -0,0 +1,813 @@
> >+/*
> >+ * DesignWare I2C Module.
> >+ *
> >+ * Copyright 2021 Google LLC
> >+ *
> >+ * SPDX-License-Identifier: GPL-2.0-or-later
> >+ */
> >+
> >+#include "qemu/osdep.h"
> >+
> >+#include "hw/i2c/designware_i2c.h"
> >+#include "migration/vmstate.h"
> >+#include "qemu/bitops.h"
> >+#include "qemu/guest-random.h"
> >+#include "qemu/log.h"
> >+#include "qemu/module.h"
> >+#include "qemu/units.h"
> >+
> >+enum DesignWareI2CRegister {
>
> >+ DW_IC_CON = 0x00,
>
>
> Perhaps this writing style is a bit more uniform in qemu:
> REG32(DW_IC_CON, 0x00)
>     FIELD(DW_IC_CON, MASTER_MODE, 0, 1)

I have a personal preference for the defines without using macros, as
the symbols are all grepable. This in turn makes it easier for people
less familiar with qemu's codebase.

> >+    /* This register is invalid at this point. */
> >+    default:
> >+        qemu_log_mask(LOG_GUEST_ERROR,
> >+                      "%s: read from invalid offset 0x%" HWADDR_PRIx "\n",
> >+                      DEVICE(s)->canonical_path, offset);
> >+        break;
> >+    }
>
> >+
>
>
> Here may add a trace function?
> Just like other i2c model do in trace-events.
> This is convenient for debugging.

Good idea, I added a simple trace function that prints out the device
path, offset and value for both read and write.

I'll send a v2 with these changes. Thanks for taking a look.

Cheers,

Joel

