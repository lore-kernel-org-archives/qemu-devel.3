Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55022C4829C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 14:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY5cY-0007j1-7v; Thu, 08 Feb 2024 09:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY5cU-0007i5-4M
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 09:43:19 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY5cS-0001sC-Fd
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 09:43:17 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5605c7b0ca2so2113413a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 06:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707403394; x=1708008194; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DDEzf0VLlSmb+7qiyrgB4qv8T95Iv7kpgIkLoN8gBwQ=;
 b=t7wQ+F/g0Kt6OCXClzfEktvNGfrhYSJn/9bSb/Z8cEynQVcFAPUXii4cQ1ZLQ1bWD3
 YuqccDz+5vQ2Btj9HK2EJQjpTcjB3LaJLkurao9BZorb/uAuRIr+WwVhwzs8dyFjfyyq
 MQPcUC7agwDlZfHvlopvR0Iot6OWW1COsBGXNmpWWqrTkLLjGqenXXEDzEjC88EyCw8l
 2Vz3HKfIwS7jXt5n1qaGYLDE8Yzm3lj++0hxSn6hQnpC5lFOPkaKtFnCbzJtbXoEwrTD
 LeORXGeVVD2OQnfm+U63OENTeGz94PmqNKIn5xMeU/iiZwu4B0VZGK1NTLJRDwocrF99
 WMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707403394; x=1708008194;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DDEzf0VLlSmb+7qiyrgB4qv8T95Iv7kpgIkLoN8gBwQ=;
 b=wWfaK9gkyYzPN0wxylf5lc6d0wSY7c/dMXI/qBqs1dLQITWnwPXGorcOGWv+eUJQkH
 Cm+uvoZnHUgrGCbJ2j7kmgACQJBYClGTFWjWYWCOw23P3YoYXW35+6eF/oEK2jFeYlLT
 bkpOI6RUvAPfZ33D43V9VfY3fGMrwgcTLTaQUZYFYZIPM9mWCAc0xggt0c8vtfKlcZru
 JT9YJYn1q1vzvvzBsafDmKq2n/1UPwSLQQmVOFYaeI+BzNYR5JrMDCpTSDTMkMM+zOJm
 K8KvgTQeirmOV5oR+G+fb0RrICCysimijROpF/G0/iU5/uZXw1KpesF5dcIkfQpS7oac
 v6pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvnzwcM/ehLjD8APw0Q37WTErPv1iuQX3lie1XuNQ8napSI61qkKnucQOMwMmFtB1obY5qe9udPDvveJ0laQIadi0H3R8=
X-Gm-Message-State: AOJu0Yxh82SMhjzXFVpT43UWOWHrGpwZKiitXDHdlO/Az/xkluCZ75eQ
 I3xCv5j0K8/COrkjIpqsBU7Dsasu4nx0U+KqfgFeQWELXMvrU+gNE+0+fIyfahPVeShpqH8fMTq
 OWDwneOJ2AqeyE9XNTshnhnGpk8Sbgw1btXXsbQ==
X-Google-Smtp-Source: AGHT+IHetivHlDdAG4dhvOqn+s3kfjjplRerVEUAiXTMPsIC0BUNEWyK+DcA5rm4eYlzCmEgobZoGQRpCdbrRTvuUNs=
X-Received: by 2002:aa7:de04:0:b0:55e:f9c4:3525 with SMTP id
 h4-20020aa7de04000000b0055ef9c43525mr6686403edv.30.1707403394624; Thu, 08 Feb
 2024 06:43:14 -0800 (PST)
MIME-Version: 1.0
References: <20240206232337.1043760-1-nabihestefan@google.com>
In-Reply-To: <20240206232337.1043760-1-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2024 14:43:03 +0000
Message-ID: <CAFEAcA_mpxnXWX=9mYTUPnrqPrwK+VWgJxb4p07Q9y-xuZY5ng@mail.gmail.com>
Subject: Re: [PATCH 0/1] Sending small fix for NPCM GMAC test to properly test
 on Nuvoton 7xx
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 6 Feb 2024 at 23:23, Nabih Estefan <nabihestefan@google.com> wrote:
>
>
> Nabih Estefan (1):
>   tests/qtest: Fixing GMAC test to run in 7xx

This fails "make check". Perhaps you forgot to configure QEMU with
the arm-softmmu target enabled when doing your build and test?


=================================== 34/357 ===================================
test:         qemu:qtest+qtest-arm / qtest-arm/npcm_gmac-test
start time:   14:32:48
duration:     0.34s
result:       killed by signal 6 SIGABRT
command:      MALLOC_PERTURB_=46 QTEST_QEMU_BINARY=./qemu-system-arm
PYTHON=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/pyvenv/bin/python3
QTEST_QEMU_IMG=./qemu-img
QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon
G_TEST_DBUS_DAEMON=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/dbus-vmstate-daemon.sh
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/tests/qtest/npcm_gmac-test
--tap -k
----------------------------------- stdout -----------------------------------
# random seed: R02S12ecd459925511b522511dd789dfb6d8
1..2
# Start of arm tests
# Start of npcm7xx_gmac tests
# Start of gmac[0] tests
# starting QEMU: exec ./qemu-system-arm -qtest
unix:/tmp/qtest-797739.sock -qtest-log /dev/null -chardev
socket,path=/tmp/qtest-797739.qmp,id=char0 -mon
chardev=char0,mode=control -display none -audio none -machine
npcm750-evb -accel qtest
Bail out! ERROR:../../tests/qtest/npcm_gmac-test.c:254:test_init:
assertion failed (pcs_read(qts, mod, (NPCM_PCS_SR_CTL_ID1)) ==
(0x699e)): (0x00000000 == 0x0000699e)
----------------------------------- stderr -----------------------------------
**
ERROR:../../tests/qtest/npcm_gmac-test.c:254:test_init: assertion
failed (pcs_read(qts, mod, (NPCM_PCS_SR_CTL_ID1)) == (0x699e)):
(0x00000000 == 0x0000699e)

(test program exited with status code -6)
==============================================================================

-- PMM

