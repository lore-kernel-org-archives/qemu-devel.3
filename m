Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3769CD49209
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 10:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCzSF-0003Bo-By; Mon, 18 Nov 2024 05:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tCzS9-0003Bc-Vb
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:57:58 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tCzS7-0004uB-Pi
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:57:57 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-53da07b78dfso3300434e87.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 02:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731927467; x=1732532267; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SX2C9BYjJRD4I1GC8MQzbRgOuagmYMpjR0bMyfICG6M=;
 b=bkrInQAcFF/IqAJE1oWPF62w6BuKp3EsuFLkBshezwkRaYL7ltrSZeEbT6mhNSysd9
 saokUyIL/x21Iu2SFDJzP8DHLBFwFEh0Y2Ww34oLqi8oN2XkNOQIsE8tiHyAYsBZxpzZ
 0+5xZcMbV98VhMfeplom9QGUbAJ5eX3pmyDA6tkimquMpTE7wYTxBwC9vFc/Q0Ukb1oI
 B0+3IyziBuJR+JXuN0lTALPu3caE6pto1yJqWmLTe5sj3WlLp51N+cH+YNcUv81CjzdK
 cxlW4cBOkUbipVK2GRUJKGZKVjVhmWUDFY+IY24aEtqPAuoAD45qYSz/JJdVRddBuT4P
 0PkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731927467; x=1732532267;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SX2C9BYjJRD4I1GC8MQzbRgOuagmYMpjR0bMyfICG6M=;
 b=BiA2IdX1FU23hVI6SrE8tuFU+0/ojPcEb1Q4A7ZN/NsLgI+ZdX2qgQP3XdwCOjn2jb
 b0AtR1zHMRZQpMyDBPHSI0JChKlIVAMmXr0XeF5rqpEXdDqiZMXwAKEV5fVq4VsEinQK
 ensAUu5V0ZC0j1C6ZJGAMp5Loqv5CxrUoRp51ofBSQRHqAJneMMeCzcoy27INxIh/02A
 rSrnrQ0LZofg8ZACIpkiiNXbgG2Knb42JRbct+SOEDIo6ytv7eZ2jYbyh35/r+ST+6l5
 EJY6ZjRM3mlecV3XQ8rlt60ebQPCRNi91HIDcHUY/JuCideiX212tUXzNrGgxiNsjlu0
 gy+A==
X-Gm-Message-State: AOJu0YwAc97GdNBMfFIR+vqOaQxpwqFzhMQ7yIdYEd5g3dH/4456f9LM
 wHmdiWV9BItKV4sidvfSv/IyJxYMrLE7WRF7naCGpEMpMbZR1DbgY06Q5Bu3EoScPS7zzYQJ+w2
 73nMhHhRut9emyB6H2ztNMIP2nfLZqN+5WXMzTCK/HEWlT2CA
X-Google-Smtp-Source: AGHT+IGn7vj0EQb6Bp/rAf0Iw0jcQHU6xVLOZvRxU9Xiqm9tMgdhpmT22CAKlLh2OwaBLSPR5G/8KeAR69+tB/vWQaM=
X-Received: by 2002:a05:651c:1b05:b0:2ff:4ce0:d268 with SMTP id
 38308e7fff4ca-2ff6064e25fmr50654901fa.2.1731927467103; Mon, 18 Nov 2024
 02:57:47 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2024 10:57:36 +0000
Message-ID: <CAFEAcA8hHMj0718haB_uZhE-LQF4W9PYrL-na0iznp4ueDsq7g@mail.gmail.com>
Subject: tests/functional is eating disk space
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I just ran out of disk space on my dev machine, because:

$ du -h build/clang/tests/functional/
[...]
11G     build/clang/tests/functional/

The new functional tests seem to be eating disk space.

Even the build tree I have that's just arm targets is 7.1GB.

Could you have a look at what's happening here? I seem to recall
we had a period where the old avocado tests also just ate disk
space over time as you ran them on the same build tree, until
we fixed them...

thanks
-- PMM

