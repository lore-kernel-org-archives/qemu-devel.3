Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7402CECE567
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 20:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sn1uO-0003YM-06; Sat, 07 Sep 2024 16:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paskripkin@gmail.com>)
 id 1smzpP-00020r-Dn; Sat, 07 Sep 2024 14:06:31 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paskripkin@gmail.com>)
 id 1smzpN-00027b-RL; Sat, 07 Sep 2024 14:06:31 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5356aa9a0afso5221980e87.2; 
 Sat, 07 Sep 2024 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725732386; x=1726337186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ugbFvJA++7Bx06/tZMZ7lkyfp8yZY0lO1Jeemd7S9jM=;
 b=VvNUyePCPhO8svJV64w4KNXGeOUrKR/I+FC8YkrkOJuRKD9pEVcucxauKgojdIGAaM
 dbqDcbXBrV0c6Wm1BxcDQ+NnHrHNnFWAVSF+piOpUjFyR4Oia0PGU2Fu/PJlSMTaw4T8
 3XabCZCFmSlFQ4lP/ZKIsGDqauZPtMrwGk2EUk5n8sS4EvOGoEts1rls8mpkpbI2EbxY
 N7Gsl4eRM/5L300RfZMRTKLbUtBGUplZHPpR34n8HTsKJvrcpEtHLbL7eOHxvOFwQRWd
 D5L9Q+xdGFe5Yyo6J6Mlyr2bqgdFuwEsGams7eMdyHUmj3LgTLAOAqcZVyvrYufBzoTk
 0VyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725732386; x=1726337186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ugbFvJA++7Bx06/tZMZ7lkyfp8yZY0lO1Jeemd7S9jM=;
 b=bMmU3FLVoFXGGLSgSXhj1LwBEVUjz5cluKG/uYm7zQwSF1Jz+NvCkbinzAEM3Pj3Be
 Br9IiTGV2/aKzb+zmqfJQnys55SFHiww7Mj77JLYhhABUyHsqZsgWDASHyq5lq0yLii1
 JIuIyi4mVZYQ3AnZ86TgepaNdFj39MX472VcN8LZV4ojLL4xeId+qO5ThdrJAvDlh+CL
 fih0H2oQ46Xjo5l/qcYT1oGbOPd252KSV1qzGhdNcltgXWy5gkIli7Zj4n5Ng7z8jlqZ
 27HQgJfaSYeILtFJyJg+4f5AF4iZsEMr3S9AiH7RDKtbUXWJMyTRhEa4ke2OL2MjOrr+
 tBDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWtzD5of9f63/Zo+1P2p4in9y3aK+DUYCZTE8B+60pc69AHj9gK0bWjV+IrG8bCRYzENsBCKYsJc16Tw==@nongnu.org,
 AJvYcCV58KHWxju10EJPIoWPyeyo+iv/3lhfH7AN++rW/we9jOLe3RRHcTIF0zKE1w2qwH3F5EV189btN8g=@nongnu.org,
 AJvYcCVFS942KLmWk3v1C4xi5+GHcSEEoMnasec4lGM9T0XXxYiGDH2OD0iopiDzRvWF/HbZkry+0g0PDEwmQA==@nongnu.org,
 AJvYcCVg3veLxNOnNoxzseiJgds3NVTN+pfpvoY13xUiN9tJCDp9M5dY8btoZQq3+PTFbJnYwnZz80Iyki0mzQ==@nongnu.org,
 AJvYcCWQX9Q91TKtqGeUuxO2jGghnuHf5cSCmSzoer3cArHIzV2b5goRmbhqbiOKGtOL44CLY9BNA7h2ZQ==@nongnu.org
X-Gm-Message-State: AOJu0YyaGfTxWK+XgJTXben9hhsKB3nrqS1ylVskiJxcBrz8ujnf1mf7
 156fZIIFuPS1wxCyfCeepT49KrTs1S8EIAjOdy/KT0BQsXU1o+oA
X-Google-Smtp-Source: AGHT+IENRzn09ucguqLMc6dL80xBfoLYGy8O3EN7BpOnPrLSmXBJh6LxSlfhNnaovLnZQ2WMrLFomg==
X-Received: by 2002:a05:6512:2314:b0:52c:e119:7f1 with SMTP id
 2adb3069b0e04-5365880c4a5mr4115105e87.51.1725732385495; 
 Sat, 07 Sep 2024 11:06:25 -0700 (PDT)
Received: from fedora.. ([2a00:1370:8180:9f8c:f275:da53:b6a5:dda1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5365f8cac55sm206369e87.166.2024.09.07.11.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2024 11:06:24 -0700 (PDT)
From: Pavel Skripkin <paskripkin@gmail.com>
To: jim.shu@sifive.com
Cc: alistair.francis@wdc.com, arikalo@gmail.com, atar4qemu@gmail.com,
 aurelien@aurel32.net, bmeng.cn@gmail.com, david@redhat.com,
 dbarboza@ventanamicro.com, edgar.iglesias@gmail.com, eduardo@habkost.net,
 gaosong@loongson.cn, iii@linux.ibm.com, jcmvbkbc@gmail.com,
 jiaxun.yang@flygoat.com, kbastian@mail.uni-paderborn.de, laurent@vivier.eu,
 liwei1518@gmail.com, marcel.apfelbaum@gmail.com,
 mark.cave-ayland@ilande.co.uk, mrolnik@gmail.com, npiggin@gmail.com,
 palmer@dabbelt.com, pbonzini@redhat.com, peter.maydell@linaro.org,
 peterx@redhat.com, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, richard.henderson@linaro.org, shorne@gmail.com,
 thuth@redhat.com, wangyanan55@huawei.com, ysato@users.sourceforge.jp,
 zhiwei_liu@linux.alibaba.com
Subject: Re: [RFC PATCH 00/16] Implements RISC-V WorldGuard extension v0.4
Date: Sat,  7 Sep 2024 21:06:21 +0300
Message-ID: <20240907180621.60916-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240612081416.29704-1-jim.shu@sifive.com>
References: <20240612081416.29704-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=paskripkin@gmail.com; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 07 Sep 2024 16:19:46 -0400
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

Dear, Jim Shu

Thank you for your work!

Do you plan to work futher on this series? Seems like current version is no longer applicable to
current master.

Also, I really wonder how did you test these changes? Like is there a way I could build some binary
and run it in trusted mode? Should there be an SBI support for that?


With regards,
Pavel Skripkin

