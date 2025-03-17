Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884C8C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 20:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGme-00042n-A7; Mon, 17 Mar 2025 16:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGmS-0003yB-76
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 16:09:52 -0400
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGmQ-0000Wi-Lh
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 16:09:47 -0400
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6e8efefec89so43011456d6.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 13:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742242185; x=1742846985; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=75jIoJ/CGWsgn6LIvBjiiHc8kVh94jDqJOfCPj+nERk=;
 b=U0UQOCiEPhQ+Iyg7i9fSdEantwEW4QbNR4lvsxd3kRx3sBHC/tC3p5ul1chu24UjQA
 XyYZ+ug0p/sRByjb1cpe6oQyPR8oDFPfl044sIu6RCBZww+7FiZoUSHtIqp8NfqGWbQo
 kgn6ZES069pJ1Mr1hQ8pGJyB9kyvDUeqOeig2ZCa9Zfnv8e+RUBxaTK2w9BoxC6bcnJh
 OtDDHPog/Y8qocWl4//s1ofOKxybNTu61Rgq69/YGBlz/mkBajOngqiEqf8urVGTbi7O
 Esax9+EL4IWXY31JrEk7p6O4ieqDRqRj7a7dpGAbWRv/vO4qCgwDrm/7+d4UTsaPd73q
 f16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742242185; x=1742846985;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=75jIoJ/CGWsgn6LIvBjiiHc8kVh94jDqJOfCPj+nERk=;
 b=DvAd+vLZKAiQM0dBvvjZWia6S25Dn/cXPinmzB5LZI3s9tMgDyQqtb6ZFFVEJ0XxzH
 7Crq7bcoANdJni25Wr37IjJCWqtSydfOps55qVQ1zugrKl0VwyEXyDfnbfp/bF4AHiZQ
 KX0SL7QkwfvxchBv241KhZ+fYoORntiD+Ds4c4cqEQijoTXaDcG17BEjNuOoLcf6zrar
 /nlRP32yo6sgKb/sCoCz20OV+NENfXLhrCeAyHXDHi/m/Orsc1HiWLYvrUB9qVCpSMMU
 wU0V+ly+aIJomub+3olyUrI5jA+HpHCdutIWbsfVj4mBsRGncItk3sUZluPMJYSD9X6I
 ZjNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6smSFt6A/Bat5Hdx+Al7twMiOroBl66Ptz+Ut6e4O+z1fvFmFDddw95JIl5eshZZXByhwKavRB8aY@nongnu.org
X-Gm-Message-State: AOJu0YyU0zTbynKu59VMe8DnQ6P1MrqTpRhug7+RtA/untIva2/U6+cw
 XMqApon5YjV0DHPI8EAW0vtV0jz1XYs+HwOQleHtmt0SMveKTdMD
X-Gm-Gg: ASbGncvHLBCBOpN4PykYOT72Gvvn2J/+O+EtstuE27a1hdR35AAD12KNUCfTyMHop9p
 3lDzZaZL1HGttITOnuGyhz+EG3KRRfrCjwnjBKwdxy4oJ4Yn86j+JgoYO2Yvp93Ak9rOiJtGgmr
 Am5N7103FSU36DSH3pGfANi5Y8qQjM2RUXPrIyD019OgVvAl3tqWjy4E4AJ5Xf3GIAUSahoZK7P
 qm9r1d+B1Y7DumV4LnY7fX8lgT75fD/kPOiMzpuBEQWyYFbCTlFu6FYF7aqsl3Vj/Fcr12rRbDV
 /lgArS3XgPtcEoV6+e64Hk0aEvAAyKvn9I5V6WVJJ++dJq5RX858vn52ncpNR48=
X-Google-Smtp-Source: AGHT+IGPV7WGk8V/erlggfl1NJtccJ455gGgh58pxq5PzPYIsVB04gvXUqKoDj8ISy2KRWffIur6gw==
X-Received: by 2002:a05:6214:dc7:b0:6e8:9b52:7a1d with SMTP id
 6a1803df08f44-6eaea9f4483mr268137126d6.8.1742242185528; 
 Mon, 17 Mar 2025 13:09:45 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:3131:60d1:4874:e2c7])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade20998asm58677966d6.18.2025.03.17.13.09.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Mar 2025 13:09:45 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-28-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-28-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 27/39] target/hexagon: Implement hexagon_find_last_irq()
Date: Mon, 17 Mar 2025 15:09:43 -0500
Message-ID: <018901db9778$86b0e050$9412a0f0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQGBmc+nsvY+RBA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250317-4, 3/17/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf30.google.com
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
> Sent: Friday, February 28, 2025 11:29 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 27/39] target/hexagon: Implement hexagon_find_last_irq()
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



