Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8B3C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 22:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts8A3-0000RC-US; Tue, 11 Mar 2025 18:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ts89z-0000Qp-BY
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 18:33:15 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ts89x-00076S-BF
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 18:33:14 -0400
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7c2303a56d6so691569485a.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 15:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741732391; x=1742337191; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=bD6vb85J5LRCwKEON9i/DDvJzuu1z56qekw2XxSUOig=;
 b=HZRj1w4ZQoQtG3UGkYDVtjBjp4aIFyX0hswafI61uQvmftmY6wY7vlJ9rqpdsaG5il
 gsi7JJcsFuA33q9ZWm8BDTF5yVGbKwYKJIbcvChvTYuKbNxC3FTLEIvu2Yak6/qliPlK
 2vBA4h3Spp/f225sU5oy6j+axPy+4bZdGpPWyYWvAltBU2CXBDqsL9+ZuYhS4pGYglpD
 PGYEV4eQeiAQzukYKezdZ2PLyQNP9UqdNE0aNFoOHjYB6ScXa4mhVFO4kEe7rZM+dLC7
 kBmfzVdKxwRyjmRyI7zyOUPazZ+Y3gPXUbu/Mc/qgTpT1jdZ+Tul/o3767vsG9X/Zl+z
 rBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741732391; x=1742337191;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bD6vb85J5LRCwKEON9i/DDvJzuu1z56qekw2XxSUOig=;
 b=BFIKjmxrO6eWSdkvzA1ka8VeSKi8iSDmhRL2KyiX2hVOGIcsgvBCtcUeQfV13C7aTo
 pSsgyHhfAhZyYWxMIcAoQ4cbfGdEf8qunKTTu1A3q9bqPyuXQLIXLKT2TNGuBn3wyy21
 m+BHvE/0DZhaiK6/l0iGX9bGJ3AtXrKg/HYDey6lvy7xndymvcuqQGahRLsyCMiSIkjX
 Mb6xa8wjqfkEl/2Y5g338EzboPK9+YpMRzTQlnoFfM9mD/xtoWctYx5OihedKywLM96i
 8h04m5gkJXezGw55az2Md68FeBq9cC8ktG3X8nXOw8RlaRcUvv8bKMVNDfRsudlCaIT7
 TQOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrHeQCQ78bp1rlZ/0yozp4CAZNCUzgyTsJgOXOnOnydGfMkoC8uPStFxaIh2Q675gTDhYcCzwHBiua@nongnu.org
X-Gm-Message-State: AOJu0YxaG3mX/lCe4e8ed6GuEFf9VtNTzb3WsRl0IIJ7B38C5+BKm2l3
 XwpVk9q7iykYoOSg4lY9omgVOHtCigqblMucOvlk+xRaUAb+wkRu
X-Gm-Gg: ASbGncvdZK56fsAnL0uv7veAxHLdsLUUKDDWYBWCqbMm+98q7X7XOqsvY1kLZWA/MUT
 z0EKLMYKhhSU06XNJ0xWY1LvTkU/LG8V5HSMDmF6+ucxm4ay51sKRlkV+1Ft6EVhhCGyH1Ywofe
 w7OhO2EYM8bQzU6mfTBrcd420YbpFtLIFXUEoupqMrq6Sw+mLjmu3f+2K5lnQS+ZmEm8AOcz5Gn
 qJULL8sA47EueX+T9PqDL7v9EQaIab+Cg+VB+KTCxSqhjSMBU91SC85wCcYFLXjYWxLFIG+/tRm
 NmmNmSSWO5bOeF+Ps8W4IvUYhcAYkYW443zENEE4EBOiul7ufVOl0GJmk9x1sjY=
X-Google-Smtp-Source: AGHT+IGIY8/yhC8bynqGcaIlEcumje9oWBJ5WQr7hkUgxtAsFc/87ARycupUCY5K971+jmy3tEL9uQ==
X-Received: by 2002:a05:620a:8011:b0:7c5:4b91:6a3b with SMTP id
 af79cd13be357-7c54b9171dfmr1470032585a.42.1741732391539; 
 Tue, 11 Mar 2025 15:33:11 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:a832:3b35:d71f:4119])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c55d83959bsm224489185a.8.2025.03.11.15.33.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Mar 2025 15:33:11 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-27-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-27-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 26/38] target/hexagon: Add TCG overrides for rte, nmi
Date: Tue, 11 Mar 2025 17:33:10 -0500
Message-ID: <009601db92d5$91e3b3f0$b5ab1bd0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgGAG34RtPbqKzA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250311-4, 3/11/2025), Outbound message
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
> Subject: [PATCH 26/38] target/hexagon: Add TCG overrides for rte, nmi
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



