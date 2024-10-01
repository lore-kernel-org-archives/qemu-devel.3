Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C97CEACD5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveAZ-0003bU-3g; Tue, 01 Oct 2024 10:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sveAJ-0003AM-Hd
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:47:54 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sveAG-0004a2-Ib
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:47:51 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c87c7d6ad4so5751713a12.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727794066; x=1728398866; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6XkU7I0K0uZBG6OSGJgu0iuzUvI5igoc/AC8//Kv2dI=;
 b=ZPb/Gn5rzsstl2BixYE3s7DsgILojVOtZLAPkT/iTEeFSL9YM0f79rMg8AWCB/IEvl
 uVb+oWs/TXyFyf2VrO27vfNyNFbKq+oCyxqCYXpPkciyimVB8ZncN/sThi8iBC6jQzPY
 u0qndu4SsEMexy16QiCli4ANQ5hSkGMQLzUEYM+8ZzI/p09elujnH1O8xfjrbgorEVDJ
 2ZeXaDBwiChAD9RWSlMXbSC9LvBYGFFW8hU7gFlZCxy184WCQbq6UD21TcuBgY/WZsDn
 UnxMElOPdvT84j147ZkX4iT3oOR8L5lxt1ajO39pdilkPi84nfRuEgCCWJ1hCO7H99Bd
 rFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727794066; x=1728398866;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6XkU7I0K0uZBG6OSGJgu0iuzUvI5igoc/AC8//Kv2dI=;
 b=xCo40/b3oYlNPokXKN1RR35ClT+eefgqper+QMAX8DaXjp2Tkf/5+CWL9f34hOo8Vd
 QKKGaAbjvRxD0tcE3FWYyrgH+HiB2RMGHjRcxTmr5ZVfhOSwCuf70gKPaPaH9CejYyj2
 UInhePpC7idY/cVyET0ZaaOx2IjNRtO1ZzKTdLjxfPK56sLJjOIuOx2ZtiJad3RqrNeG
 JAfk5ULyNOhzjV+2VJ4+FrQd+smAznlgvvz++CahqgGj4RQgvyWuNiFbo0NGXyNZrCoj
 fMegl5GREEcnVbh3aCKvNxj+21uRAUNR5ZykM8Yc/H0MPwUmJbKxFRpFs0liipHVf7Hz
 LqPA==
X-Gm-Message-State: AOJu0YzcdYbe+TtiPlHzNFtj+TsM0LseEqf88FAHhedgdanB2k07ubLm
 kLJL83hUCdLnRXyeNMFD8nkm9oDlMqMoEUEvmfIBSyfpM/K0RWmpeUzkOxGIUi4WzUlZNUycLPR
 ymR5EFC8UIikNdctLhV6JfPgcnvuTmkItdgU4POhy1lSv02qa
X-Google-Smtp-Source: AGHT+IE5PL3fg6W7DFYMQ5xvdPYZpCACooBukklQuAFPILLlX35gHZVVdlUytTBggwjRg74aazMux3RMkdct+HIN5Xw=
X-Received: by 2002:a05:6402:1947:b0:5bf:50:266b with SMTP id
 4fb4d7f45d1cf-5c8824e7f04mr14184317a12.19.1727786638510; Tue, 01 Oct 2024
 05:43:58 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Oct 2024 13:43:47 +0100
Message-ID: <CAFEAcA8N8NoaPMKQN=_Ph1mmgE1DEn=7kDOuOVMUX4zBEaBmug@mail.gmail.com>
Subject: what is the right way for an avocado test to do "wait for text that
 doesn't end in newline" ?
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

One common thing to want to do in an avocado test is log into
the guest. The obvious way to do that would seem to be:

         self.wait_for_console_pattern('login:')
         exec_command(self, 'root')
         self.wait_for_console_pattern('Password:')
         exec_command(self, "passw0rd")

This doesn't work; Thomas tells me that's because the
wait_for_console_pattern function requires that the guest outputs
a newline, but the 'login:' and 'Password:' prompt lines don't
have a newline after them.

What is the right way to do this common thing?

In tests/avocado at the moment we have:

tests/avocado/machine_aspeed.py:
        self.wait_for_console_pattern("the last line before login:")
        time.sleep(0.1)
        exec_command(self, 'root')
        time.sleep(0.1)
        exec_command(self, "passw0rd")

This is flaky -- on my machine the test times out once in every
two or three iterations.
run_tuxtest_tests also tries the same sleep trick.

tests/functional/test_ppc64_hv.py:
        wait_for_console_pattern(self, 'Welcome to Alpine Linux 3.18')
        exec_command(self, 'root')
        wait_for_console_pattern(self, 'localhost login:')
which sends the login username and *then* waits for the login prompt.

tests/avocado/boot_linux_console.py:
doesn't try to log in, just ends the test at login:
        self.wait_for_console_pattern('gsj login:')
This test has been marked as "might timeout", which suggests this
isn't actually effective...

thanks
-- PMM

