Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0769C28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqf7Z-00032h-EZ; Fri, 07 Mar 2025 16:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqf7G-0002zn-8r
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:20:23 -0500
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqf7E-0003xk-Bz
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:20:21 -0500
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7c3d3147b81so264060085a.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741382419; x=1741987219; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=RWo4pr7ra5lCL48VesI/iKkA7JXZJZAG+Vl7lygzDtE=;
 b=clKs/dnepl3p1v+I58iWAW96+cHtGjJ9TuZDMnv5ZqkJ7XknSHUWStyeSAS15c3QcM
 Zl/mp3K2EKsBZHi8v9RmiWDy+DJw6I0YCHIneviYWXFd7a0EOjUI/tmX9HSfzwHXQvAg
 kadR+8vM8r7FPXg0lr/GvzA4ZyIzLWQQQZdNbUFFVmG7AMdIXyHGXeev7Xan6vJDnBiG
 b9/DawqV9urpK5jf9zgtkxeqnD3mhl7+ykvDrK3UdF2zLsflp2NrQtfe7TTTuIL599te
 VfqtSWgM2+W9lwnlbv6F8ILzEsfVj05NHHsJnIs2U4PoJ68IroUZiKJsEfOkLVIbA36p
 p75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741382419; x=1741987219;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RWo4pr7ra5lCL48VesI/iKkA7JXZJZAG+Vl7lygzDtE=;
 b=iJm9Px2XOCd8viGkDGw9+cKjtV/85JdJXeAhFTeHYn/jNG2bHrYRsUJDybu58IVoff
 A1iCoWViKTxtMGhBuwSc2kmnSaU1Xsq27aFBC4wvFetE6YRZqhtjLSvjDzY1h7QS96C9
 feClU8tw+SQg6cXgbh4+ZaKFBEtvWZogws2Qhk/b6uxYujPJ/Mwf0kWE+7gYZZdntshY
 22h+9yG7cY4t4gN6JYf6peDtCL68FUVATEBzh/CvLE2JgM0Y8NPfYpKmaYaP6bP0lAM5
 tQOTtdm0c/yngzD0dHSw0otBpn1akLFsq2EKbbBs9wpoU67OS44KWCT44I0M7iXqe3pk
 rYbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu8PRxQW8aJG6ONp/dBfU4Tbmr4iCJqa3Ygfr+/iaNZOCyDhh9DrAJvTFY5X8yh48DbjrMZCsByL6F@nongnu.org
X-Gm-Message-State: AOJu0Yzj7VgZh5sgDMUZdHd8b3wUCOyzaHIARVVbeSmzlPyrRm/Napn1
 54u7U6m4hGKmJ5tltTox8srKKCQai2D5rftI4DzOahiz8UX0kzgu
X-Gm-Gg: ASbGnctY4UweWtaHJPAjW8l6oLs9CzcNBidQgP969kN2HAk8rdX9K4mak3pZ1ENHgAX
 q0n5GBRLlgGctHhgtRjem7yA8QZ+TrEivx+ZwRofy/qs5xbtR6+9NC3n7p4JraTi13G38OBwcdx
 NDcg3UkzDZxLHH4p6DFFLwS/zNyhzL8iKTi+eBVQsayYfFjhVwWHc7XGaups2IDxddK6TcfJCE4
 zaPP60Oeyt7Bo63DUz2/2UhUsGbavt1+V9GdfiUFQTYz7VU+3iiZAc4qQ3h8qYvLBhXBb04DjdZ
 m2SPzvBJmPvNljSuY2J0lMca7UbVEaaAOr6r2xTSQjhSAKySlzHWfDNYjScNuXo=
X-Google-Smtp-Source: AGHT+IE/fF81tDx8RyDClXriAICF5XpqptF0i8j5mUoY1QOAAsoKTQ2GRQmURYRbUZvLtOTTzFmzIA==
X-Received: by 2002:a05:620a:2625:b0:7c3:cd78:df38 with SMTP id
 af79cd13be357-7c4e1679bd7mr632283285a.10.1741382419217; 
 Fri, 07 Mar 2025 13:20:19 -0800 (PST)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:8188:4e08:c1e3:fcd4])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c3e5339e75sm291689485a.7.2025.03.07.13.20.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Mar 2025 13:20:18 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-19-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-19-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 18/38] target/hexagon: Make A_PRIV,
 "J2_trap*" insts need_env()
Date: Fri, 7 Mar 2025 15:20:17 -0600
Message-ID: <02a901db8fa6$ba607bb0$2f217310$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgFa/zQvtPG1UMA=
X-Antivirus: Norton (VPS 250307-8, 3/7/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x72f.google.com
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
> Subject: [PATCH 18/38] target/hexagon: Make A_PRIV, "J2_trap*" insts
> need_env()
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>




