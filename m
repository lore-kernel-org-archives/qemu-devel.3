Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FECC282DE
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 01:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqjGc-0007Tr-OB; Fri, 07 Mar 2025 20:46:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqjGW-0007Sz-1H
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 20:46:12 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqjGT-0002E9-NU
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 20:46:11 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4766631a6a4so2915631cf.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 17:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741398368; x=1742003168; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=e3vTD8YzFvJBhpDKMrsdaqr3wbnRpnh9GOfPl/nn2hk=;
 b=FFAN7rELikfh/XLn2rjF+M+tocqt7TaaNBUNKqHTVP9UdaWKzz6tH4wSYguOqHpyxV
 MXb/PsN6wTl0plMymg1a3kHSvBLRjW3aVhHbKKRRwVozBFyp3d99dNriddklXpsmv6YX
 nvRSgrOXnafD28PNcbVznrCZuQtQ8mfncEOp3rs+vc8DqBEmhBoBeRi/yQMomEYTF84j
 orNQ2UGukO3jpaeNl6aBzG1zQu0MnaOTbQOo9QBrGZAsAA0gZ9ydMgvqQVihWa36Enga
 K9ciYMRcmYp9Mals3mC8jAr7j+PAIA2SNSjJezUz16ZIXOfn/C+A+k+8lgjiYawIxnSy
 NUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741398368; x=1742003168;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e3vTD8YzFvJBhpDKMrsdaqr3wbnRpnh9GOfPl/nn2hk=;
 b=cxae2vJ6DIxBuT69XV2K4zhtJVCF7ODPtviMS4aSzA8nEnmy+2qTYUQHVP5dyNQ/8I
 eL/RzOHi00NkSC48Dtg+rG4kJFL+dOsqIHT5iq3vNd1dmh0YapLeNTH8GRcIJXA10DW0
 5QlIGbqwMpg4OtKwxhQk66bcqWgwhC6yuRqOYjlEV6qV7c13TE8pv34k9Zns6cLAhCdD
 BaRO3jke1y+Y/HsAEnfBWM6ZiKGx7dElZcvjZ2/W7KiViM7yToyn5qFEGpa0ZzC0sTSY
 SdvVIu3XCqeXHdLGzxNsNA3iExG2rw7yhSbHYR+qt8ah+UuQJn7oeenZjPdD/Hzk/1W7
 RgDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/ySyI4CpKVsUb9RDkdJAaH69M6MaZPGsh1b9CH8M9pWCBj2v078XsJCuKQ4qE3Bs9UGo4QfGVhdlx@nongnu.org
X-Gm-Message-State: AOJu0YzVPyHyQcb3i0dBp+JumnLeoRfXc6JLeeYRKC6UaiPm/RWZotFV
 v5RX6qNQMQ4FgUmDdmbTp0QY9k4k2Id4oLSrxJvTtpXjOK2+z4FW
X-Gm-Gg: ASbGncvmS9YJhQXz3jq472GynOVtm6r6kuVZhF4vRIapPvGOEii9175vFl5XFdIAVyf
 GHCfra3MSgEEHjo8NqzYFDxttbCqZvpNilKlkURdtjYriHkXRLMFgWm1Ycngf667+w3CKTfKKZ2
 c4MqKl+mO7j4AF+fh7w2WosC/gWy0vi6FyWovSLBakwAcAHhpYu+s5fKak9Z0JK41zUice8ww9h
 68KdwPwl+B+AvZ0/dvjFsttgaDHYsEMJh2ZVaHf29QMwL5V+G6Kipf+mJJPu2Zx64sOGu2bHAm9
 AKNLAUZEte8Wxtvln4q1EX1FCR+NmdQbgiSzq4b76n2b4JVt/wWGtkbDIsQFcGA=
X-Google-Smtp-Source: AGHT+IGXxpR2ERBw/B9kEMpduEEw9Xz/Cu6Hhqx4U78bBu1tWk9coshgWGG0cvXXM7VpXJY9St4kxA==
X-Received: by 2002:ac8:5a48:0:b0:474:f4a4:2ca9 with SMTP id
 d75a77b69052e-476109af2c2mr70894421cf.25.1741398368535; 
 Fri, 07 Mar 2025 17:46:08 -0800 (PST)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:8188:4e08:c1e3:fcd4])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4751db2f9b6sm26649321cf.58.2025.03.07.17.46.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Mar 2025 17:46:07 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-25-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-25-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 24/38] target/hexagon: Add TCG overrides for int handler
 insts
Date: Fri, 7 Mar 2025 19:46:06 -0600
Message-ID: <030a01db8fcb$dc712fe0$95538fa0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgJwmFhetOlShEA=
X-Antivirus: Norton (VPS 250307-8, 3/7/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qt1-x832.google.com
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
> Subject: [PATCH 24/38] target/hexagon: Add TCG overrides for int handler
> insts
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Define TCG overrides for {c,}swi {c,s}iad, iassign{r,w}, {s,g}etimask
> instructions.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



