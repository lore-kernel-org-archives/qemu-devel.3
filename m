Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31685C282DE
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 01:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqjHk-00086J-0i; Fri, 07 Mar 2025 20:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqjHY-000850-T6
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 20:47:17 -0500
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqjHX-0002I4-FE
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 20:47:16 -0500
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7c07cd527e4so233732285a.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 17:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741398434; x=1742003234; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=0MzdVIofFBPVZMA4le4r0dHyv/IW34RJMIso+km5z/M=;
 b=ao7M1eZ8ysjrPzNYHCeozGo8m7lgGZ/TLxXwpZAgppKNO3NYQxSjtctBw5wEmsJPdR
 nDeLO/cplMpClIOSkW60o/3la/DCpgDCF1CfbBOhnpDEst9gxBu8BjdActTDYwrs5L0/
 dfZcUrOjs0ROQTJq5tetzYZZ679uZ4AASoaflZbsIPOYn+rga2HL2d9jNYPF4aArF0BL
 U7WY5UHaMANbp2ZiCKWML1ocYlsh2jRRstuAl6NncY41f1eBVHb/V6kbkZKPcFQsTiGD
 MbpfDRhOdo7VY0jc1exnBiSC0QvuXqDlKHxm5ga1z9GvBXKPBeobDfAvosru9fi4ICCH
 K2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741398434; x=1742003234;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0MzdVIofFBPVZMA4le4r0dHyv/IW34RJMIso+km5z/M=;
 b=AjTz6rJdrC76puYnZnDQcjxHT2ko7YpaZnk4WIXKjopk3x07wU6pV8z/eHl+W1qBmE
 if5i51WxZAX6zcSUnnJfv9GDkUUfSx7EuD2JPhYWrGzQ5a4vit8je0d7NNgMrquIs8vu
 XjA/itm3Esnpz/Qt1Nv4v4AFVu2g9rd1AyAErpOpTL0GCkb6tJQ5znFhNDFXbI30c/zg
 1fY16tnbpk58UyjxFzDozpUXsEeF/3/X+FIn7SYkHtBZvNwksi5y0HyfRbWzKnktwZDr
 ZH7Di5/ScZgu3/oWgcAoSsIe5Ug+wdHNTKq0rNedVahz0/4qifFn4kUu7iJCc9Crs6Bs
 Hgeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxLAokeBZRCKL6Sv1Bd98CA2fuKJ5DKBd/50GT0+DGhK1yV7NVSx4tYVfLyN7A3LRaI48LMNs4ELaE@nongnu.org
X-Gm-Message-State: AOJu0YztpTq5TSGkC3er1WFlf+5XNrYPP+znJ0V+sEzjiSX0UUP06cWi
 NoiaHo9CLvIxmX249YgXxIplAWL7wRrHTR3A+B8+pXFJ1iW8eC3v
X-Gm-Gg: ASbGnctgRUAPWXRuXgAmi8sEYP/QuY05q2+0tlISlbXOG/7rc02ENKYnIUERDq0MsrF
 Y/hd1jDSl+eqX0TlI8U68XlN0uKoA3UP0P13OkRw7V80PYqJYyGIlF77jVmYbaE4I88jHj/nN/N
 JUJ0yIj1qzKB461NinLarIDo1jcwscbNar31RJEy5TQJtGaKnjU68V5c7a4LIU7gSSg2Z/oYTvn
 GFCQRVR5kZpf3wQ5ZdOFJSM/CykD4KemnMHS+GGxjmDcEC1n7Qmh0B95wfDPwK+wBBFHB3LXr6f
 RI06opUAvbwggIJIIvPNKxB1fLIUE42+Nyfx9iDJM7hJ50YGSWewH5NdXzII+lg=
X-Google-Smtp-Source: AGHT+IE8HzXA7FAZmSSKwKCUHKmQp3vwGfaYrhk9elq3cckC82USbH8/KaM0BbwC8MvhZD780qPQjg==
X-Received: by 2002:a05:620a:63c5:b0:7c5:3b3b:c9da with SMTP id
 af79cd13be357-7c53b3bcbc3mr428525585a.40.1741398433776; 
 Fri, 07 Mar 2025 17:47:13 -0800 (PST)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:8188:4e08:c1e3:fcd4])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c3e534ba85sm320359485a.28.2025.03.07.17.47.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Mar 2025 17:47:13 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-26-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-26-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 25/38] target/hexagon: Add TCG overrides for thread ctl
Date: Fri, 7 Mar 2025 19:47:12 -0600
Message-ID: <030b01db8fcc$03d2ab40$0b7801c0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgI2Xg8dtOsk+wA=
X-Antivirus: Norton (VPS 250307-8, 3/7/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x731.google.com
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 25/38] target/hexagon: Add TCG overrides for thread ctl
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Define TCG overrides for start, stop, wait, resume instructions.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



