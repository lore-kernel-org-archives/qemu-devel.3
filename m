Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7066D43375
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 16:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t955A-0001r2-MI; Thu, 07 Nov 2024 11:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9553-0001oq-Dz
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:10:01 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9550-0008OL-Lt
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:09:56 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5ceccffadfdso1499249a12.2
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 08:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730995793; x=1731600593; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=0ILLYoICI/TqoNfWyfB8wFx8bohmO829DsHUBCQFrYM=;
 b=CuIQtUsG4CF7r1lI9CQITkBXEBwd4D5X86UKNFNiRcwRMgHdaiMpHMNg+VnoeSwBEL
 Tz4lVcHhoVRWYqDwRAjqEAmM1ylO0MwduKbuT+uFwPEq+o6EFCvyhtArUfAMx0OOeqH9
 kzhIraEQMY+dghnGe+cek+AOWwTZewcwjLutQYED30hJk7dnwHBNyjDmcVoUPaBXoDep
 JWiOIy0RVynOcqi9gt0RvqVS+ffUo0hUKTpDrdWMJX2cC+OW2+QCE33OR7MowwOqmmTW
 PyNXfiHsPJWpBp7Oh/Yxo8M9ZYKv/rUqeajnZ56w6AP1Hm1aoOnWnJ3SLWaxYu+I3W+e
 T+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730995793; x=1731600593;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0ILLYoICI/TqoNfWyfB8wFx8bohmO829DsHUBCQFrYM=;
 b=SvMBdtMGEJBADCYF1ffUuNLxZNihmNERdGa/shr29P3YygwjhPN/zWtvYIXmWr3LYy
 gfID0RAi2mxZb/sejMckvn/b+An3maaV9mGAXpBzog0tsJxoorT2Oc3Ppkouq7QsHbnw
 b+r/9InZs4jjTVPRgqsGG60seDcqUwD8ZIfGBEMnzsSSQ0tCj4driOZ0Esv1tuI53vrZ
 bw/nCGmcygsdw4RZGOKnQ8ogT+8NDysz4R1CxUHycxrUSBV2n2Fgm+4EudM12uUYp+Pk
 HNqdaA+8AjfcFD0fMeCKSlchIqGfQNbd5mVmnmOIB+mTMV5HgImtNNF189vKxSAP9fOu
 Hq6w==
X-Gm-Message-State: AOJu0Ywc4bA0BIrZ5eko+4Hu+0CDEiDe6fFMwoLhcHlELWdGVC+urzF5
 CMqeYuoERsogNrujRifj37H9vkxiT3Nyi1bXDPel+CAzyL9MhWiw9I7gPByxOzH5AyEdf00Gx0d
 nA6uu0Bk81nZL+LP1k8Cq7qE7Xm3Sb2wqHhBwqlpKERLEvnG6
X-Google-Smtp-Source: AGHT+IHak/OsJ7PgVOcqqSb26U8saRO6W5LcliZ+k3VUrieJ8CF/ME3HozH9LktHUr7FMrTyZNWH6kIOEsH1Zw5vQXw=
X-Received: by 2002:a05:6402:4309:b0:5ce:fb3e:c3f2 with SMTP id
 4fb4d7f45d1cf-5cf08be0555mr554829a12.4.1730995792786; Thu, 07 Nov 2024
 08:09:52 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2024 16:09:42 +0000
Message-ID: <CAFEAcA-4cf+yub8bsgtsdFOJD_9HziY3tekCN5s=+JcWEpw3Nw@mail.gmail.com>
Subject: test harness hang running functional test
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

I was trying to track down why one of the functional tests was
hanging, so I tried running it directly:

UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1
QEMU_TEST_QEMU_BINARY=build/clang/qemu-system-loongarch64
PYTHONPATH=./build/clang/pyvenv:./python time
./build/clang/pyvenv/bin/python3
./tests/functional/test_loongarch64_virt.py

(This is with a QEMU built with the undefined-behaviour
sanitizer.)

Mostly this seems to succeed, but this time it's hung. Looking
at the process tree:

petmay01 3616444  0.0  0.0   4768  1124 pts/2    S+   15:53   0:00
 \_ time ./build/clang/pyvenv/bin/python3
./tests/functional/test_loongarch64_virt.py
petmay01 3616445 99.8  0.0  38480 23620 pts/2    R+   15:53  13:20
     \_ ./build/clang/pyvenv/bin/python3
./tests/functional/test_loongarch64_virt.py
petmay01 3616448  0.0  0.0      0     0 pts/2    Z+   15:53   0:00
         \_ [qemu-system-loo] <defunct>

The QEMU process itself has exited, but the test harness has
not yet noticed or reaped the zombie process. Instead it's sitting
there eating CPU. Presumably this is a bug in the test harness?

thanks
-- PMM

