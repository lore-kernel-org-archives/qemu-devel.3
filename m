Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE8CC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 19:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGMT-0005HZ-29; Mon, 17 Mar 2025 15:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGMR-0005GH-5m
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 15:42:55 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGMO-0003HR-Hg
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 15:42:53 -0400
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7c2303a56d6so554471185a.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 12:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742240571; x=1742845371; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=eR0d/ermdizUsHANfiRqMS8GwHFKkrdUbpJ8UYqTX54=;
 b=PC82GIVLrQz/GF4UET4CfVov7HwItKrFrBDdZ5TlCPZWomIT5L3wy5aMRQH1pxGhWm
 LqVbZ/fjjFHNrvBHvCf+S2pGHDgZYDZL8J1zEmCnb4HJdO8EKBkAr8aJ4BhI1i7L0EE0
 zJKib+TgkRW+aTadKS8sw7j+LwLF2jXhaJtnAfUAPSrntU+tlumu0Iav2+EMp+YaqE9v
 AAURGBZz1DUomovm2wrgKancLxPHY7iRPt1daFr4ALvIRvD5KSWewVen/Xyl7BV6+O01
 sXf2HZDAVc7zizzW1nDhpBe7e056gX/TiNK77Q9RbobaA0PzSompROtxj2voaHO7Bz6g
 qIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742240571; x=1742845371;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eR0d/ermdizUsHANfiRqMS8GwHFKkrdUbpJ8UYqTX54=;
 b=FSpTLIvmz+NHNLPFsO5ItznKzhx6H7ShK4CZKf6AMWd+wtAAvdl2JWtoDY5dGQWIu1
 AI6Big641EAFLrktxsdR7z3T6p2eMF03teLMs17A5n+MXx1Q73dEupSoPSzqU8e4VzTL
 Q0403IN+Y+NeJUL3vFyT82ceG0H9wKvBMFrS+EvOnSRgbopz7GuhBDJrOd9O2FUIYge+
 N1VhjniEF76VHYfm85f3SpQEXk3vYDwMnpBaFyJJb1Dt+WlrAVzPNtf0p3FAX236+mZC
 0i0rBpPpb8mxhYwQghTi2WlUn/k0SiAUkgsvc9yT/x6Tr18GLMaKHLWJzmGrCS8XCtgw
 yquA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvvM7aGNRYk7gknYkQtpQekpuxL7phe9gJUR+o2tzDHjkDwmBBbNbeYUFAdhPdHkruObJ95RGifJv1@nongnu.org
X-Gm-Message-State: AOJu0Ywh/C8iNzrewN4TBuUgFQXB3cXnM/EPuOADcxtsZkZjt8y16QkG
 3F5veyTqDZyhr2usm2KIEUJLVJ4loIzm9f3VNTGEX+zmenwshCR2
X-Gm-Gg: ASbGnctTX74PFHkviGyWMYD25jVjsENz0HdmrrKX6O5u7OU0aToSMBTGimswmKoBKiu
 T3WwltGo4VZkNlqtK5V0F+7noi4yD77Ki1xcPzc00VbvO707Od0oqKjg48wH3rPx2Y8EA4UuljQ
 6MMVbvtWprQqcHjN//Hne4lEXUAIbHTe1nR8Ie95h/QBwbSzYraI6YwlMGyV7Pti0J3tW2nWmYy
 mQKJeifNJnIfHf46SaGGVnAVMRkXcQdHezgAssEQFDAOJMB+2kI/hzkOgeN43PVtBbACw/WUlSg
 YH9gKpJ7QemdLsu9y+P9axuqzK5jrm1wWBkeg9RTZNXlszVI9smyhNBLnMzRwFweRKkzxriMHg=
 =
X-Google-Smtp-Source: AGHT+IFt8qE5E2c+3nMFLkELUlTVBk/QSYF9dgA7cRy2SQgi4A6nd/UStQ5bzwuHpN+3FMlS73rcQA==
X-Received: by 2002:a05:620a:4042:b0:7c5:4c49:76a9 with SMTP id
 af79cd13be357-7c59b17ad32mr124752685a.4.1742240571351; 
 Mon, 17 Mar 2025 12:42:51 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:3131:60d1:4874:e2c7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573d6fc6dsm621103085a.88.2025.03.17.12.42.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Mar 2025 12:42:50 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-17-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-17-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 16/39] target/hexagon: Implement hex_tlb_lookup_by_asid()
Date: Mon, 17 Mar 2025 14:42:48 -0500
Message-ID: <018101db9774$c49485b0$4dbd9110$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQEEksPRsvoeeYA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250317-4, 3/17/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x735.google.com
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
> Subject: [PATCH 16/39] target/hexagon: Implement
> hex_tlb_lookup_by_asid()
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>


