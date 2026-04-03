Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EB8E85372
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 14:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8fgb-0004aD-0F; Fri, 03 Apr 2026 10:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8fgY-0004Zc-Ns
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 10:39:46 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8fgX-0003ID-Aa
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 10:39:46 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d7653db148so1202232a34.2
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 07:39:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775227184; cv=none;
 d=google.com; s=arc-20240605;
 b=Ph5TQtYW2m8WcWPIh35Z5AJeN2ZXyeAv3n2AgubIwP6lf+8gCyI8D4cE23lEitTADQ
 bYlmymhoVZc/Kwt+Pts7YoZbSzEMUjuQjmRqN+aa7iP5om8QXkWUYrWFYYdi43BLpq4P
 XqTINBg13chU+rCmHbJQae1j9aDdXAycq2SUpyoEAYZXK3a6Homr3zvhSNCc/zpG9Q9G
 IQXyCZF7sxY/XFQmy5emk2ARyoirg64j/VByNg2+0+vwTegGHrDaQuWxtByOhV51ZYOW
 ZboeJ6WZKF7adYBRuqgdJiINGyH+Oa41nAOBZjnzFfOruQIyhk/U/Wt0+Qgpn0EE9Hb1
 Xl4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=XWmjx6emSszF2gy2KB6vkQNFV+q4J6L4U/yZYz1jUl4=;
 fh=OkE7nZQaPg1/LM7AbOFFQJwQL3pULXPBVKSX8tVhie0=;
 b=A3wqL3Tcajb9HQ/1e5ogxjBlTxcOwSJpBCEuZ9fZFbEEgZjaDAzQ1HT+A+K/QS8Uic
 MrzrHqlxEwfdbEvQXVyxIJE62rjfXdWXeF5QQS0wWyegV5pCSx4PvnirEd/CFI0hwO6C
 laqdgvcsqoKAsgF/qAMonRc4vlcHL6wmci9pBEWl9GaLImMaH4jD+NzHU4n86HpCDfre
 s99XbHkpDcy0VEU6CM3RmlDwAaCTKQ1+d9GW4zf0TOR1hnVz6hi+yj8yqxtYCDIXJRr8
 CDKRaRqQnQyJIl98peGeSXnGItJufEI+yBGwb2wXv4a3/iaJYIN3qH7s0n4HllFQJCOx
 TdRQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775227184; x=1775831984; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XWmjx6emSszF2gy2KB6vkQNFV+q4J6L4U/yZYz1jUl4=;
 b=j5SgeF/pH25myFwNXZBY2gx84eGerxAdDCypau2/X8Gcx4XKM9Khqspx94nwpRQXcY
 ZVN5NdhxH6tH0fdj84IR2jnWU1WDIoYXhf7KigTQdUZwQQ+ylqhoa5/WpKmloCqvh3Nd
 ZUwCcg8xLbn7qFbA7b/TH4SAcsAtbetYJuyUGw7qXZXqILKQ4+k0qcQMba3HZcqtRwZn
 c/0d1f+lF1K7IABP98xMlZOKY7K22D4B0Zcf13lDLS2p/3aJxulQ8EwKcyfQD2Jv5b8Z
 w1p+1xZOUI9ccIB5a7DKYWi73gq+qjWgcJZkPKUOy2D6D4wWE1Umd+hXUwarjDf/SrFr
 KMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775227184; x=1775831984;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XWmjx6emSszF2gy2KB6vkQNFV+q4J6L4U/yZYz1jUl4=;
 b=cYTauf0Rb0za8RNGvUM0u3BzWrwzOkm4bPMDwj2RMbksA/XXL34FzOnuFFJ6NxNEQi
 1BZ1IBzka/L+0Le9Jonl1ESmTAeBd/mlFWvA/2K+Y0X7jFBbrdNA8WQlds/yhpyqoCKR
 pkbv4Cyr48KJLxqV9DPMgxQHeoFGbpX1CHXV13v8rnIZQ34KLsvRoovxFfJUVazOVxCD
 g2W2WE3mLpi17RPEq8Y9vLSR6/hh842qLzTVQT07GmqJ+wDhdVGYYJ1mRnoRsWXmv0SK
 iBPh2oR5OBj1BI4Vq7PUrEBxhAleqBMSommWyGu5Tm8f4Kz/jYOeIFmem5BWoRFJNdJa
 ynzg==
X-Gm-Message-State: AOJu0YxJ9/TmExGAkoT/X4BA1q1yDUYt5Db8ZGRtW1TCeqLc5O8iqwo5
 qDzM1aO62jHYS0gZju2jOaTXwiHlKJFP3ME/KkkrbN/r8Fc+D85HyzT01B1OrrvrBvGhKZDX8Zl
 Y2w/u7uU6PXK8pzidLiUUid+ViO9BXCMQ6z6tSJs=
X-Gm-Gg: ATEYQzy7LMyA+v4gxYZN/VGXS6sCbTbz4AZUvoQ9KDlFgN7qZG367ylnsckJNt1KKaR
 zoUQBpJwo8Gkx8OjCE30YVTWiq7pftKZlWLsfqd6gQ8hnuHUMlkaA6mPWzbH1RDPmrl5cz4teIE
 yRY8+cTI6K4EOaZKkyK+QBsSFYZaFmBtdJaIxOJyR7+3sOL8cQVidAAIBZvO2kvZYzgWglah+3g
 alF1yunpAeP4ij32aRJi3rh8ZU2fbkwligWt3GzhRMupoWmBFQODSOdEIZdKh/qL5ymRzYzCyU5
 xH/P14w=
X-Received: by 2002:a05:6830:91f:b0:7d7:4a7d:fd40 with SMTP id
 46e09a7af769-7dbb754e5bemr1893025a34.22.1775227183858; Fri, 03 Apr 2026
 07:39:43 -0700 (PDT)
MIME-Version: 1.0
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Date: Fri, 3 Apr 2026 16:39:32 +0200
X-Gm-Features: AQROBzDDVi9VbKIpdDtRiPO-QKoRVQOb3yYWoD7q4EE8aLaP5o-M_L4UOWB7-mg
Message-ID: <CAN-aV1EiKRh-Zpb9=77rXYPD2uT7HZmeNfvVW-wAToT+gaVC=A@mail.gmail.com>
Subject: Question on preferred location for QEMU sample projects
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: artem_mygaiev@epam.com, takahiro.nakata.wr@renesas.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ot1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi everyone,

We are currently preparing the v2 patch series for the Remote-Port
Co-simulation protocol for interfacing with SystemC modules. The first
revision was here:
https://lists.nongnu.org/archive/html/qemu-devel/2026-02/msg01760.html.

As part of this submission, we would like to publish a sample project
serving as a demonstration of how to connect a QEMU Remote-Port
frontend to a SystemC backend.

The sample project implements a standard SystemC IP core and uses
several external components such as:
- libsystemctlm-soc: https://github.com/Xilinx/libsystemctlm-soc
- VCML Library: https://github.com/machineware-gmbh/vcml
- SystemC Library: https://github.com/accellera-official/systemc

We have a question regarding the location for this kind of project.
Could you please suggest if there is a preferred location or some
standard practice for hosting such a sample project?

--
BR,
Ruslan

