Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4E8C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 16:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4MyG-0006jq-Gb; Mon, 14 Apr 2025 12:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u4MyF-0006jc-8S
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:47:43 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u4My5-0007hP-8U
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:47:42 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3d439f01698so16745625ab.1
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 09:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744649249; x=1745254049; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=23pOhn9/kUhZJY809wb2h7tKRYcRBHcjQIXknivCKZw=;
 b=i3gx0MrrQwMJE1/H/pKJs22UBIkvYPo6xu13JdVgLJlGpgu4rlE38um6V6R6F5H6a7
 mf12yTMNeMNllksBgsuOzF6Ak+SvM0+PL2cknPcsxFb5bwPraN8PgzfA6+qv+YN9Hf1b
 znDyHCOX6IubczsTKAOV8fgbwkR2n+LrOEwtrishcmDG5CFvU0+gsdfyCV9sGPAPMgQE
 GiPNPbeE1hkzATeK6aR348o+tjLWrR2OAnjPIX1KDpVq6Qt/QIzvfiKBf94BjVMZ6+D6
 NJj7wkFslVHU/iAof8nNFwqLhGynOIQmwQVmQZsIQX3zXaSe9YRwhTMijcWg5FBK26v1
 yYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744649249; x=1745254049;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=23pOhn9/kUhZJY809wb2h7tKRYcRBHcjQIXknivCKZw=;
 b=jbUuCubdamCMohLP+y0daV0mAsfjPW2z6n5kRnU0qLOLxAKsT5Nghrl/j7I+dSQehw
 4s4lEyksTfoGseHFT4Y0qJZwkKRrIRp/jyB+nQes2mqDfyYY8RXf/S5oSKZHdJLdUK3O
 +QXK6zV/MiyRCZZf+8btCNAFlF8m0NbUPFg15jz0qcYhs0iVQiFWAwH6ISEgU4KQKYjr
 6nJDyJ1bDHBLw2SVaPIH3W2oj+44teMgibD+PkS3yi6ufPkWSxpZTcuhTgBn/YUtiHKQ
 KPqDNQWjQms2oXioeLqVqiKFrlSBc+71Dt8G+mTYu5aw+/FmIw+O9Q+XMEeHxQ2KXbUh
 xQgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP4u73RII8roTrAJsyQx2r2OAUujdGN94lbm24FbmiwGZ6ZSaSrkIa6CW57FeuNxpmvbruB7XMU689@nongnu.org
X-Gm-Message-State: AOJu0Yw+7fMDKwW6DODZ+2MjbnuHhQHVP/KTxx4xVhqs8sQgjYZnDgAT
 tRMZcqh89B/3yQgnSYnsZvnIdb8B0mUoOwFA5J8NiEytKQetwOXt
X-Gm-Gg: ASbGncu61qG6vBY5DoeELYVi2Revf04yK1kHs7tDPs0MSM+THQ+GPpTeLJW8HHPnaPu
 sWjZo9SOwFRt6cNnjizstttYSaBTf14w1or0WPnD8nU/yXHmCSZI3fMILLo4/YpCrMHHSxjEAYd
 VMpCA91wUu54zzDB9+9sh2KfGYOOld/oYQXntoU6Zk7Ldxe81o8kMIXgMqM/VRhcyCSlctiRhzn
 CMqGrSx6oC2PF9vzeufg8UKiwobunci9BszqfNn+rG/i6uCvgyHYhloFY2Vbpdz2NZ89vN0Qswj
 rqCep9ynjZ2J5ebe6QZ7Svykd0yJV6i40Myw8jRGz+MXC+iwnMZNByptCfEoXenN6XKCy7Ald9U
 =
X-Google-Smtp-Source: AGHT+IEuOluo+/3FrT80CqCzELB8owY/4y+WWXtk+bDrU4sCzXcSAXSWtOQJIIeAbRxF7BZIyByc9g==
X-Received: by 2002:a92:d20c:0:b0:3d2:af0b:6e2a with SMTP id
 e9e14a558f8ab-3d809c7870fmr1223925ab.5.1744649249521; 
 Mon, 14 Apr 2025 09:47:29 -0700 (PDT)
Received: from DESKTOPUU50BPD (c-67-190-160-7.hsd1.co.comcast.net.
 [67.190.160.7]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f505d16a6esm2688655173.46.2025.04.14.09.47.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Apr 2025 09:47:29 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <matheus.bernardino@oss.qualcomm.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <marco.liebel@oss.qualcomm.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>
References: <20250407192705.2605614-1-brian.cain@oss.qualcomm.com>
 <20250407192705.2605614-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250407192705.2605614-2-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH v3 1/5] target/hexagon: handle .new values
Date: Mon, 14 Apr 2025 10:47:25 -0600
Message-ID: <058001dbad5c$e8a5fb70$b9f1f250$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFxbseScfkce8xHjxBW05Q6egvQNQHlP9S2tGiyJpA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250414-0, 4/13/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x132.google.com
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
> Sent: Monday, April 7, 2025 1:27 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; matheus.bernardino@oss.qualcomm.com; ale@rev.ng;
> anjo@rev.ng; marco.liebel@oss.qualcomm.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com
> Subject: [PATCH v3 1/5] target/hexagon: handle .new values
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hex_common.py | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



