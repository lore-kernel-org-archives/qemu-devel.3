Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D92FC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 16:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXkwK-0002sA-Ba; Wed, 07 Feb 2024 11:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwJ-0002q4-0B
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:23 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwG-00067i-7x
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:22 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40fc6578423so7467315e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 08:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707323898; x=1707928698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7r6TD7yChzqzHwHFrhbxu1OMWzC/pBSk9CaZVccyvoc=;
 b=D0d76ixfydzCvymGynM4XSeC/0Wr35r779jBaRwDgQuzgPaugYpmhsOwAM1ajh0Qm7
 YzgwGdAabvggaKK4uXEutdysALzzt29sUlg21F6pwohiA1ohmuvmOtodQM9/iQi88d+2
 q/aB9R1dvBkka6410p/DaEFi+7xi38Lqi3IIfhUk6RMHSLFrXLqlLNDx05tBfdbyeyZX
 NpY/dVI3W6we2/O4RxnglDSn+pTYGVsHKYUjgENItTm8vZ62WMXEP+WwGsKp0fFPPfpO
 ECkIvZt74vY6PKBToTb6I1JQ/k7K8KehOl8KVSHk80B0938gW6ZqvsrpFyY7mSmb04eY
 2Y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707323898; x=1707928698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7r6TD7yChzqzHwHFrhbxu1OMWzC/pBSk9CaZVccyvoc=;
 b=wlTcgluXIkoHiQTHTASLiO0NiYw5JytGCRh0cZ04sQM48sii6g/r1ywVGWA0uS0FNG
 EPb+LwA8dw5WEiSIySzxtf9rZoQGUKWT/EOzi9xb3BMquewCD1E85DzlAdk4Lgg8xOk8
 PmQzUONolYIBkewRdDYxhZaxVvb1bQh4uLB5BowfaiTRuPg1rkQSZkzqdMV8+8wcYpIC
 A9S49CCK3PGrKBaN+M4zifJbWK+NGnqVrnHU5XBPe0qallPXS+Fiil9hgXyybIzZ49y1
 Bmmzu1tzcwBVnX3dX1KjzPIiXFQGrwA8ovhMiI2Mrtzg8+DfM00tsgTUcZ2GSKxkmp2c
 KyAQ==
X-Gm-Message-State: AOJu0YwYZbpx31XORdTgJ8dTf0ofir4RtHwCcO+P2aVq3skbakz6JSi/
 HCV1oUhhY0WVphNRCmTPZlgpmejnW+SdrkBpPrF+4vBfYwUUV/4FAUjeCC7FzRU=
X-Google-Smtp-Source: AGHT+IGHwl3tW2nUX2wfBLHUrlSOM6cjxqlwmBBgVdwDbJmr/R/vGDi2c3wnvq3QzxKL6BY7CYBQug==
X-Received: by 2002:a05:600c:4509:b0:40e:61d4:5d3b with SMTP id
 t9-20020a05600c450900b0040e61d45d3bmr5501081wmo.20.1707323898707; 
 Wed, 07 Feb 2024 08:38:18 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU85CmzezWXYjs7d04q56iflk3XNrfO92Z/yFqfgWD8aHJHO0wKepHAKyLrXeM78NoyCem0hOqWjs//+iigpEwll3DGDCdotjlWHO9Vlii+1KZoYVv4UpRFTx4A9R1nWwBtPU6gkjW11JZpfg5QBcgJe/6k/KSCeNC/iTnLyYKckSeBQ4HBPXTiueMLYb9mXjJhcR08zAVu9VQxQp4UkWD/Xmmx0pjD+hoCVsRyIkIcFpuuK7pZVh3pUSkzB7MeuCtIQPARuUOrv4Krsd7lbteVU5RKdCfZF1q2ZAB0/lUlAQM68BJ6yfqiKfguHEjv5H6v1K5vzuLBzuwVT7Fk8iQQGYB8d7RMIFQ42UGsF3eUJCGD0Fz7MqH/+nhApqx4R6q2CMxmsOY/Lln/3x46LUWky2QZYHduRTqcBgkrUnLALtczONlSCTSdAYDy43qlUacDkffDWuflJ/HDF8LzeGvOqlArR9A13QYSQRuVgNGRgmBmIU2et8X6Q1qrKoJyJ1xZ27+fdqzaRMHwb85Pc2Z/g5KF6w15ZAzvFGzkzkMaDqFdPISrK5NpaGsHUC2YvZzzrJ/P6hHgYj+NzcGVT0mGSpUlzBPPP5kOpByjGwBfDGAzacgRz00mH+/E5QZrAIin44MdlWRsuBR0NGXi2EhjfLgRpfXNK6g1Ju5cyXCbfdmi3dmu8ldCMNNuL0P2c1uwLAthHHpcXA6uDiewoiFDufeM/G6Gnea/RyV9lXjjx7Xw8TxSKgQsbLrQHw4TBTVG4gOVTpoXlrE8ZiXUKZLj5FEnzYe5m4JHpWdhXJ7MPZgECXZFVgEP9aImd0lCwLjtf2hMMjLQW71uDBcRTCMdlG2MjzdGj8XHOg3c
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m14-20020a05600c3b0e00b004100826da82sm2653264wms.21.2024.02.07.08.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 08:38:17 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8F7AA5F8DA;
 Wed,  7 Feb 2024 16:38:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Chris Wulff <crwulff@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Marek Vasut <marex@denx.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Kyle Evans <kevans@freebsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 05/14] tests/vm: Set UseDNS=no in the sshd configuration
Date: Wed,  7 Feb 2024 16:38:03 +0000
Message-Id: <20240207163812.3231697-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207163812.3231697-1-alex.bennee@linaro.org>
References: <20240207163812.3231697-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

make vm-build-freebsd sometimes fails with "Connection timed out during
banner exchange". The client strace shows:

    13:59:30 write(3, "SSH-2.0-OpenSSH_9.3\r\n", 21) = 21
    13:59:30 getpid()                       = 252655
    13:59:30 poll([{fd=3, events=POLLIN}], 1, 5000) = 1 ([{fd=3, revents=POLLIN}])
    13:59:32 read(3, "S", 1)                = 1
    13:59:32 poll([{fd=3, events=POLLIN}], 1, 3625) = 1 ([{fd=3, revents=POLLIN}])
    13:59:32 read(3, "S", 1)                = 1
    13:59:32 poll([{fd=3, events=POLLIN}], 1, 3625) = 1 ([{fd=3, revents=POLLIN}])
    13:59:32 read(3, "H", 1)                = 1

There is a 2s delay during connection, and ConnectTimeout is set to 1.
Raising it makes the issue go away, but we can do better. The server
truss shows:

    888: 27.811414714 socket(PF_INET,SOCK_DGRAM|SOCK_CLOEXEC,0) = 5 (0x5)
    888: 27.811765030 connect(5,{ AF_INET 10.0.2.3:53 },16) = 0 (0x0)
    888: 27.812166941 sendto(5,"\^Z/\^A\0\0\^A\0\0\0\0\0\0\^A2"...,39,0,NULL,0) = 39 (0x27)
    888: 29.363970743 poll({ 5/POLLRDNORM },1,5000) = 1 (0x1)

So the delay is due to a DNS query. Disable DNS queries in the server
config.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240206002344.12372-2-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/basevm.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 61725b83254..c0d62c08031 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -423,6 +423,8 @@ def console_ssh_init(self, prompt, user, pw):
     def console_sshd_config(self, prompt):
         self.console_wait(prompt)
         self.console_send("echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config\n")
+        self.console_wait(prompt)
+        self.console_send("echo 'UseDNS no' >> /etc/ssh/sshd_config\n")
         for var in self.envvars:
             self.console_wait(prompt)
             self.console_send("echo 'AcceptEnv %s' >> /etc/ssh/sshd_config\n" % var)
-- 
2.39.2


