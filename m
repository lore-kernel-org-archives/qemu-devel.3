Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E88C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 12:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwheI-0001yO-SM; Tue, 16 Apr 2024 08:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwheB-0001y8-U7
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 08:10:49 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwhe8-0006Mh-1Z
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 08:10:47 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-570423c4f80so815745a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 05:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713269442; x=1713874242; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lOROAja9hxDAWwV7rC0n21JxhwA/2YfQ78tplhFcV1s=;
 b=xOW5jLGEj/P9DbTZSG/ZFNdIbkZ17Jq+zEV4xEPD8MVmJdRhwbEkd+6X0erAvLj5bv
 Df927z/ZXKOMTUJIKZHgDsLGLoFqjQmn1+5j2tU4RFYxbLjeUawKCRbcuq5pESz+3RHa
 qpl+tjWqgu+L499oN9msv1APzpqS5VeBSiA9WLQnF6WTpn/CdSb71pcLEvpiEcBWeEyE
 6FkK6zXB3zqU91OvXMXZYOyFt64McQzXENK+lR6hBhOCEYL49puvRrsXnodS+tmTCL5Y
 aP82VVYt27Ld2xzaT3fVqhsF+Li3xaulotMJ1RcM0O5MwnA5/qFI/efVD8QjtZpEleql
 5rAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713269442; x=1713874242;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lOROAja9hxDAWwV7rC0n21JxhwA/2YfQ78tplhFcV1s=;
 b=SxVSJI3JP6VRh7gjW4ZuzujN830ljXUqxvHKV9lYhaGkVRxWdpYHkhU9Q9spC5RNgy
 T5RtHLfSG/tlGzYciUnQOt3rdJr0tVvB4FCfATMldDvEWHDLt6R5iEPBjws3ZHQ3pJLJ
 Q2XqxW/f1LFQXcjp0aaOaxZMkQir2pUuYbnWQwS5ZmV8aHwYWxvuR2/8At6wXaj+8D/D
 rAKtk//NqZdPHi1JBoPLbDhCPH+K9H87YhkNXiX2Q0j8sR2ou9935lrcME4YeaM4ByY/
 pT9JXTeWAEmklqlUC/QxFbOIvBTasd+RYiTOvIVcDzMNrZKn6PTlcSIiM3c370i33tjp
 PhUA==
X-Gm-Message-State: AOJu0YxJ7VElDDfQDQF7LxoNGIrgXtsqPTRhAQ7QNfd8I0Pk+N4zQNgi
 P+1H7R0R0GFMFAguKLLOx7spaio6G0pGLGjDygqDL74E8LC9M1WjeCbSeyh2sEIEmuJlEWtTSYo
 D19h+NQdCmqxDcSlXBMt7rB/e9QmVuCKtX20cC59ID3p4TELG
X-Google-Smtp-Source: AGHT+IHGUvX3D62VjbdrwgtuGZuJQnC2LzRT+Wca07S+CdiOmm4gL/xdrU6zUJVQQbSs4sk4Ik5YrGm3QFiGBFYrjqY=
X-Received: by 2002:a50:8d59:0:b0:570:34c:91cb with SMTP id
 t25-20020a508d59000000b00570034c91cbmr7468174edt.32.1713269441719; Tue, 16
 Apr 2024 05:10:41 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2024 13:10:30 +0100
Message-ID: <CAFEAcA92aivDF-LjSrtZH6o4UtgrtcWnM2wuPZA5VOiN6j7KMA@mail.gmail.com>
Subject: cross-i686-tci CI job is flaky again (timeouts): can somebody who
 cares about TCI investigate?
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Stefan Weil <sw@weilnetz.de>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

The cross-i686-tci job is flaky again, with persistent intermittent
failures due to jobs timing out.
https://gitlab.com/qemu-project/qemu/-/issues/2285 has the details
with links to 8 CI jobs in the last week or so with timeouts, typically
something like:

 16/258 qemu:qtest+qtest-aarch64 / qtest-aarch64/test-hmp
    TIMEOUT        240.17s   killed by signal 15 SIGTERM
 73/258 qemu:qtest+qtest-ppc / qtest-ppc/boot-serial-test
    TIMEOUT        360.14s   killed by signal 15 SIGTERM
 78/258 qemu:qtest+qtest-i386 / qtest-i386/ide-test
    TIMEOUT         60.09s   killed by signal 15 SIGTERM
253/258 qemu:softfloat+softfloat-ops / fp-test-mul
    TIMEOUT         30.11s   killed by signal 15 SIGTERM
254/258 qemu:softfloat+softfloat-ops / fp-test-div
    TIMEOUT         30.25s   killed by signal 15 SIGTERM
255/258 qemu:qtest+qtest-aarch64 / qtest-aarch64/migration-test
    TIMEOUT        480.23s   killed by signal 15 SIGTERM
257/258 qemu:qtest+qtest-aarch64 / qtest-aarch64/bios-tables-test
    TIMEOUT        610.10s   killed by signal 15 SIGTERM

but not always those exact tests. This isn't the first time
this CI job for TCI has been flaky either.

Some of these timeouts are very high -- no test should be taking
10 minutes, even given TCI and a slowish CI runner -- which suggests
to me that there's some kind of intermittent deadlock going on.

Can somebody who cares about TCI investigate, please, and track
down whatever this is?

(My alternate suggestion is that we mark TCI as deprecated in 9.1
and drop it entirely, if nobody cares enough about it...)

thanks
-- PMM

