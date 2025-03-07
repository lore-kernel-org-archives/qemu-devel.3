Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089C5C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcyu-0003Wn-VE; Fri, 07 Mar 2025 14:03:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqcyn-0003Vq-3h
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:03:29 -0500
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqcyl-0002py-IG
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:03:28 -0500
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7c3b533a683so247060485a.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741374206; x=1741979006; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=WAOzkhzEpY5DWwFo429YeQi4dH4n/O184rVme7sTzpM=;
 b=cmb6Y0lAkR4d+FiGadpeE9FAyS2HD2yojJLv7KtMoP+5pPMuPiKTov95OwJQX+qAF3
 kHQjiv00Es5iC5VkExj9Vyc7rZHnu+6v7Of0/JwKJsZa4U7xTiXEVDWpy9X3GkxvbrpJ
 vfgPmjFlLJW3gtVbDQq9VpH78sh2OqpRQbXTaK24h92EZn/o3olpTmfmi5hKD63U/6up
 gHeYlBopKgYyQMQPLmJGPJhz7n/zzYF8TwikoI6S5E6wK7hnQvVdlCT72XJzhxNs+T2T
 FJHLhJMq09pxJKyHlrGYufvsB6N14x5/5G6jaSx1GBMA91RCy5kXky3xFHhzOUtMHycm
 /I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374206; x=1741979006;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WAOzkhzEpY5DWwFo429YeQi4dH4n/O184rVme7sTzpM=;
 b=pyv6ARy9XwRL8kRLoEXHvVu5ZqwTVP8cFtkGLgQf6Xw6u+/WB0OvtOVtH93bftrk3j
 MC+pT1pYg7ymf87p6ISu7wlczqTwh08CgTbXaVwyeUyQ/ZJImaTbZpcUuH7fDZsO56ug
 DA3hYTqLTx7o8m/fEKkzIp1rVsEZ8XqLXNHD+NO6HFTdKNzaUp/FCq++FBajXe7Fbh7/
 BTTxeY4Hfpb1LgfitfX4P7F/oO2SUzFRvvREedtyYRjadE28jz49rWyQGqIPOVMBmhtX
 fVOcrVu/sb6LLPq2o+E3BmWqZr7h6UBV1oB3fllLFzUJ8m5j3YkK8rW3+Y/dX+T/U1sc
 EhrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUiMqam5v5q6Qdu/XM6t+BM3sVIBIu6gMUC0Iajrc88I6J++lfI4Vgyiq3XNAuoLRUL02Irgg64GpW@nongnu.org
X-Gm-Message-State: AOJu0YwSp4blIw0piitYnEN2sFrZsAylAG56QvakeIwap+zbPuif7EBb
 TJKDrTW8SJO6uklyi6znbzjQL6csyml9C3CIUy7TTMQBnyHzPh4D
X-Gm-Gg: ASbGncvlbb/L/eTXHwOhz2z3x4m+WteiBaduilFYgQvxjIXa+/+QK9F5KruY+YQB999
 GpNYh+wXOTcBoCWaiCADuY3IcGCEt9Gt03Bf/1nbYboazwOG6LdWVw7jAsv7nyt9JRQmeLdxB12
 MR7xQ0RCwGS7+QJwJ/2RvssTw4km5AGTXde+wb8c3zL+USBWIdEZtjPRbuKtoPDkk6GxtR/MoQd
 c7JcnlR05tQNLMI0+MCV9iStnVn4dIx7M4dcwJ9WnsNTV8ujgAwI1SK30H0oyiT9Dw2ysGWnRhv
 iWZBaLWmqztuCL00FMvx3SipEkdD67yy3nVVAinRsVt05E/QwfnkidVXUqfSuhY=
X-Google-Smtp-Source: AGHT+IE7C2voghsBbuVTW3tNSQiSnLOl2oRPYeMooTc4PQPYTL0tVRQq+v10tTUcX3ODx1STsgC8Sw==
X-Received: by 2002:a05:620a:1d06:b0:7c3:c853:dfd8 with SMTP id
 af79cd13be357-7c4e61126d1mr631334885a.26.1741374206358; 
 Fri, 07 Mar 2025 11:03:26 -0800 (PST)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:f449:4838:1970:9d05])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c53d010250sm10612585a.6.2025.03.07.11.03.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:03:25 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-14-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-14-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 13/38] target/hexagon: Define DCache states
Date: Fri, 7 Mar 2025 13:03:24 -0600
Message-ID: <028d01db8f93$9aaa7b30$cfff7190$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgLkLMeitOVFuLA=
X-Antivirus: Norton (VPS 250307-6, 3/7/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x729.google.com
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
> Subject: [PATCH 13/38] target/hexagon: Define DCache states
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_bits.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h index
> 6582bb4f16..5d26815eb9 100644
> --- a/target/hexagon/cpu_bits.h
> +++ b/target/hexagon/cpu_bits.h
> @@ -41,6 +41,13 @@ enum hex_cause {
>      HEX_CAUSE_PRIV_USER_NO_SINSN = 0x01b,  };
> 
> +enum data_cache_state {
> +    HEX_DC_STATE_INVALID   = 0x0,
> +    HEX_DC_STATE_VALID     = 0x1,
> +    HEX_DC_STATE_RESERVED  = 0x2,
> +    HEX_DC_STATE_UNUSED_WT = 0x3,
> +};
> +

Why is this needed?  QEMU doesn't model the data cache.




