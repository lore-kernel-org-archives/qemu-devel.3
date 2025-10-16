Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047EDCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 14:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9P4J-0007CV-6J; Thu, 16 Oct 2025 10:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9P4H-00079t-71
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 10:35:01 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9P46-0004g7-PJ
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 10:34:59 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b48d8deaef9so158437166b.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 07:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760625285; x=1761230085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qen10iGnYw0Z2ESaIYLPhDAekiTl03kgAkiwZwhpmcs=;
 b=qL4gs0eMyIZLvKeqS2TlZEC/Nn9/QZmbpqFbtpXERS5+LxzYXmxL6Wtw40ZTrOkvmZ
 HRty0ayOSztGyTMmGv9g7UhoE976udBKXqADYD7mRudVcMhcvYDK/THA0G8dDpAFB0JG
 ALslGCXTGnieZlDPki8w/DYAMF71P6lLFo4+X+etrfAB+Zy7tiHIVAaUXC68GhqNBcLM
 hbcAHepCc2J1wjybmOBNFThckDXL+RxUT9RnAJOaPPnl4exWAETBqBQtqiU0LwQHVg+L
 zeF9hjFls6QG87qD68dot+LjjrH3BXELU1DAe6zGq3Ch7h2FxhxCo8WkFw+NPib2uEii
 RXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760625285; x=1761230085;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qen10iGnYw0Z2ESaIYLPhDAekiTl03kgAkiwZwhpmcs=;
 b=LQNBd/fdB+4Ouzor021YKhuvXwya2TeMXa+EIwyRe9aM9DS6DkX7bpUblmkHVna7yU
 Cxvl1uI7TlwbIDAYRzWyizBvlffw2eTRXkvsX0JLOUzi2P6/8mnzw1IcUzCpmobeEtTe
 9SCpwoCo7nfhaNG1I2K66whxBis1vifm6c3vLyBTGutuZfPcDDde79MwWJvcms0ZneoT
 p6offu1V/ZhuiF5REjIwsekrr+wSTqWehOrNhmdzThauKy5JkN9NGdVlSbuUMnU29JTI
 wGh97xxxaIW02VJrQXqtIzowYYxCn/UgS79cXBPBx7ngciUhMTcgRxU115ZmhlohhUza
 4V6g==
X-Gm-Message-State: AOJu0YxTJykfZ334AR51F7J6ZpWvwosMK4NtX1orFnHcbGa22lu1D/wa
 Ld8azK1zwEStCJTOzoREGbhKqxtSD1Lv4C4qNRoP/Gmsv9F+7RKEdc+83m8c4YjS6XQ=
X-Gm-Gg: ASbGncvgHqpuXEgWlVAtBqmc3W149UzP0M3ZJed0eMEE7vU4j/WaUFNXpWS1CIoDQgp
 jUnxg/TDIAR1wHXweuyas8+9xm7NJJVO4s/wKEVB/sa4qbAs+qeZeRz/Jel8QUav2MTJkj5yyKf
 WAZfInH9dMJ6ZcxIsQlARdJ1aga7mhYamh2nPpcvmGyTMKzPnVocUOUxZgG/fy+IcRG8FqEc7t7
 QA/cg1Hwh8nKfBcyvX2J54D1a7zfEMRGmGbGYrmL75avqJkBep4SkQFyYScoza7y2FB9MWai0lV
 bIIaOhO5o/COpuJ5UGZW5OE0K8thrmPtmC8NYpKYCmgc6/Vbnf/Ld3kofhSeWqOLRSdxrNJMPi3
 YuqpKtzL6pZNW2U6QESI37ZEQHVrguniw4Z/nzh0ixlYBRMbsDVc0/19tG2DSGdC5ntEYI0Dg4r
 STH7plCPf8wL2BZ34=
X-Google-Smtp-Source: AGHT+IGnVmMvBX9AFVJAaQqIQAkPGJxcOTTVblxktcGkVJwn5oIhl1i6UOxY/7372VTguIW+DIai1Q==
X-Received: by 2002:a17:907:971e:b0:b45:1063:fb62 with SMTP id
 a640c23a62f3a-b6471f3b921mr20348066b.24.1760625285487; 
 Thu, 16 Oct 2025 07:34:45 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b5cba45ad2fsm530218166b.35.2025.10.16.07.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 07:34:44 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1ABCC5F80C;
 Thu, 16 Oct 2025 15:34:44 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH] tests/tcg/multiarch/linux/linux-test: Don't try to test
 atime update
In-Reply-To: <20251010121435.3885228-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 10 Oct 2025 13:14:35 +0100")
References: <20251010121435.3885228-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Thu, 16 Oct 2025 15:34:44 +0100
Message-ID: <87tszyj4or.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> The linux-test test includes an attempt to check the utime and stat
> syscalls by setting the atime and mtime of a file to specific values,
> and then calling stat() to check that the values read back correctly.
>
> Unfortunately this is flaky, as it will fail if some other process
> (for instance a virus scanner, backup program, etc) gets in and reads
> the file between the utime() and stat() call, resulting in a host
> syscall sequence like this:

Queued to maintainer/oct-2025, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

