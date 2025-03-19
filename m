Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD03C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 21:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv13L-0000TZ-SM; Wed, 19 Mar 2025 17:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tv136-0000QZ-NL
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 17:34:08 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tv134-000090-WA
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 17:34:04 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-476ab588f32so2133751cf.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 14:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742420042; x=1743024842; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=l1zeUVvriVPFoJJ7fXXwHja/Ka6jkYJXXq1kyM3AFx4=;
 b=RFa0//0hHB9rBEMNgJzSWDHe/7Yf6NImZPTj3fTkTd/PKpOpJD63ajWVCzgA1zpLSM
 drnKjBuyDxG8cIK8qg/Iq+Q5uCJaCQprnEyEY1aKoDkyYYvcJpeVv3TN7C8cJlkwZWd3
 0COd9uGruiGNn8eOqBk5yQCQ89N74KsB/sssCsrKOY/NWW4ETIC0i9uK4px0iLnfCbMu
 45lVxdpYd3XVypuv8tu2YJGKgMQtXfz4VrTBhDb4yuLRi8/KwlzQaCboMiNLQhrmMRkA
 7sXVCUxUqbMxnZQcYCc76FeLyVg/7KzuxYlSSUOjOt94r0Yrc4srlPtW/7sT4OE0xvuJ
 6RHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742420042; x=1743024842;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l1zeUVvriVPFoJJ7fXXwHja/Ka6jkYJXXq1kyM3AFx4=;
 b=mWfW8nzAWLO7uBNYfOIGtwE922K2afAtbolywUFL7fRYXBUw8cZCMsdhDGOoC7LBB2
 2ZVJtT2eZz5BiFU697fLIiJv84KZDMgY3rUuoNHleULRpdlvwpikya4j/xojPX38Ogsz
 YztBa8jgz/9FCUWVTCFxQgFcpBFo3spRH7F9D52sfEbeNJBXkX4FXbXWv7bW73nV+bBO
 ue0euHtU9bdkVPmChRQK6VP+mBB7ACtAyi3txItETnNGWFUVTO0IK7vYEX8sExKjKOWZ
 38jIhAV5Fh+uE8VtJ+lgQuk1tfdHs5HJiVHBhFqnCraEkOviTmbBAQq19hrHmoqsU9S7
 b/Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeZhHHBCeTDb7Atjv7s1tohTr6MCsM6QHNmCb1xMvMDFEqKmiMNgrVZOvFmChYr6gTzyEmf+VhZuaQ@nongnu.org
X-Gm-Message-State: AOJu0Yzph7rs9GBXB3XCn9q7LBLoOgwmuMy/HjRxXN7vHxhr+VGjMp2v
 HRQl9Vtrh0njIYT0bG+Oco+NiWHaTjnng49ujHCPIERvr7gHo/4b
X-Gm-Gg: ASbGnctSiYs50UIeQxS6xtOR2zK5HaoFUtXDr8XDMVlTneBgf6v/BYLSMSzqnWvN00W
 249oOUtOZsQLVaZOXZY5+W3cZsZN44m4GCGxrkbdMZh94FBkWjHcYiLF5FbvZ7k18H9QXvRFp/7
 a7tNLQg4DXdQz7ZbDXg3AkVjKzdJf5j2Scr3OJ/GwmwJ+6XlDcBCE0wVzSukon0ao5HtPLmxOUu
 C5QMSp8+hw2zFJwjwab14xFipoefSiDDE4DfOChM16z81oBjce1GN6smBMZZfE8M8L010l6Cp6Y
 xR6F9SfPw4/jsXjSPVm96FAQRP8IkbnkyOoRDiuiKhvpoPNL4R/WfxD+pleSxw==
X-Google-Smtp-Source: AGHT+IH/T0+Cvo75ZC77l7fC+WQSOCzohlKyR8LKn0ZPXNohIdPymFCLZdLYyyCbENieiaS6EidScw==
X-Received: by 2002:a05:622a:4a1a:b0:476:8e3e:2da3 with SMTP id
 d75a77b69052e-4770835a0aemr73079631cf.30.1742420041596; 
 Wed, 19 Mar 2025 14:34:01 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:992d:4509:eca7:6f8])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb7f2ba3sm83858531cf.53.2025.03.19.14.33.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Mar 2025 14:34:00 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-19-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-19-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 18/39] target/hexagon: Implement exec_interrupt, set_irq
Date: Wed, 19 Mar 2025 16:33:58 -0500
Message-ID: <02e201db9916$a0aaf410$e200dc30$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQGIar1JsvlCkbA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250319-0, 3/18/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qt1-x833.google.com
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
> Sent: Friday, February 28, 2025 11:28 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 18/39] target/hexagon: Implement exec_interrupt, set_irq
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



