Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6002FC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 16:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuDCQ-0007gY-UO; Mon, 17 Mar 2025 12:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuDCP-0007gA-16
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:20:21 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuDCL-0004zu-RA
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:20:20 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-47692b9d059so61096221cf.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742228416; x=1742833216; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mFQD3pnsT1p3p0CBcx7OKYifPwI4sRZBXl4mtUCqaKs=;
 b=XZDfhhBrtBrGWJJ5ozIjX41FPdVWTs3IsNrArpQxR1LryvFUjm1oKszQv+shTC6HrZ
 ZE4+hE/HRVu+PRdTo7awuM1fFOTtRnrVgiVKMA5x26LqLVf2J1aH14GfmdQpOpwLTbBN
 1JnocLzZwp7uxgU3+hLoXgSw53VM+Ue9LlQDrTGM9MHq3OzDoJ4VS6OylrimWH7XZ1IO
 HEtpYZiihIlIRMaeCoFJGYJbvjRALrWMldxcAdATV/YbMvirt8xJNfB2vBSwQKSbjiBb
 +xw0uKVMU5Qi9zairAiSgZftkolIDsYknir2TNnSeYk8GAtw7g2HNm6AWuVzoSNoIlW5
 R3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742228416; x=1742833216;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mFQD3pnsT1p3p0CBcx7OKYifPwI4sRZBXl4mtUCqaKs=;
 b=NjR8SzZoiUTQudDYSedodlXE96oQfBfdSUKCtRCW4JCdFFiYKgK8ya4/eJBdEsD11k
 kHHHsuUbxX3K+bTLJoXK12+4CsvatJ4xtWLQ6S2wm3bwQWA1IbjAJY8gR/DYxEd/yExf
 7qf12mJo7s00fBsm/rHbRvd53DaolHJu/oq+qHTMPhRQxWRDm9SGjS+7rI5YsbhmzEzG
 ychO0jTkp1fz7Z6+KlR0jlcKr8g3FyIcTOnBC+ofDSTh1VV52Je0XkzfMkaNFWAw7wAc
 NEkl8PE8t9eqhm7GLj5yTujwEf/nLiM+2kgp3sWssYfo4kLTEOPiRXbeeqF3VAUxx3sJ
 h26w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHK0jL/5rSyFtM1QveGsGNj6Ati8DoIjZ+rWrgFSW1GT3QtS1AoqMFryY4hVThDiNWomNnFMji5SRP@nongnu.org
X-Gm-Message-State: AOJu0YxkBdWXiUl9Usjf9erviagMiGDiR4lbRsQjZSqio8IK5ojO5J6/
 3cA/HcrEBtpFQWS297ekHXg2VywmXvWt4kmhKCHnINDDtD86I8NU
X-Gm-Gg: ASbGncsnCR6a5zyjAZkpp5IlfGCU4ojo14aixKvT2ERIB3DMNJZKNwkgxWwAfl7kdnB
 UBux4KVAPgYh/8fZ/3GLLQlhli5qy/vvPz8M+prEuVdQYB+MrXelRT+9+xbbfLKNpHwvhcrBzwQ
 Oyf19KTRMCgjBONfOzaQKGNCujPajgCcxQQN29+xxMxtSu+Je2NVlT+BBYEWihu9utL7uPblbDC
 jFxQBoVjo9MULkRUl6VzSTHd4NcTEzTwClj1ew78nzWGJgGrrpe45Z3ZQDbOWRCdKroRpGx0OHG
 SC8yk1362MJmMw8hXje2C7Azxw3gQSGC30fPZ0WBsgYaAvIvgQY0tSRk9tBIp5k=
X-Google-Smtp-Source: AGHT+IFhbGh5jqrEwuV8zYqm/XsaoDHSuGKFd9MV2dZfSYgCHEontsBSr9uUDtgat+HAPC6jbARKWw==
X-Received: by 2002:ac8:7f0f:0:b0:472:2077:827a with SMTP id
 d75a77b69052e-476c8141b59mr212805261cf.14.1742228416316; 
 Mon, 17 Mar 2025 09:20:16 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:3131:60d1:4874:e2c7])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb673824sm57104621cf.45.2025.03.17.09.20.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Mar 2025 09:20:15 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-4-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-4-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 03/39] target/hexagon: Implement iassign{r,w} helpers
Date: Mon, 17 Mar 2025 11:20:15 -0500
Message-ID: <016701db9758$77f5df40$67e19dc0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQMvjudLsuiLnvA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250317-2, 3/17/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qt1-x82e.google.com
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
> Subject: [PATCH 03/39] target/hexagon: Implement iassign{r,w} helpers
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> iassign{r,w} are the "Interrupt to thread assignment {read,write}"
> instructions.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>


