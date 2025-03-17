Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12D7C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 19:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGYl-0006Ly-Pn; Mon, 17 Mar 2025 15:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGYj-0006LT-Cg
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 15:55:37 -0400
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGYg-0005Zw-QG
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 15:55:36 -0400
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6e6c082eac0so44748926d6.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 12:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742241333; x=1742846133; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+sDUSUrerDwewjtcp0ahQVvGpH4HxEOFVa2zW+VNp24=;
 b=X5TsjcX6iBPMYVTED4A+VO8NFrYxgbyGK7VsGoUFP2JhjKWedJ9qdAYpMAQYUtgP7w
 FkWEinVwFICJkd9YclpxwJeoW7OX6Aj9TikvuJCMOYmCEhYuZuNgErTToqNdryc3DtzN
 LL3xp373I+Oygph2e0yK0a5K2fTpJsdng39gWwbTA9IJQ502lLL8strNlmbSKJ826owO
 EuF8dbOD8Q5NNSGQIAip3XAl7HlWh4oA7sglc00nFl6A643xca6g0Rq59EDMphNwdKt3
 9R4QbIkuXTEpRDtedimEK0iklGxq8rtAbdJ1Pi9tl1cHByhc67vP4mvggnM2BGDEPckE
 VqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742241333; x=1742846133;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+sDUSUrerDwewjtcp0ahQVvGpH4HxEOFVa2zW+VNp24=;
 b=uicaUURlENsv7t9d9x1O7mAZ2yhiDYD06iJrzIQqnPuD2hpseonnIS5uEExHbmQRHq
 +tMuocxCfGKtrfQK1aSvtcV5NHrJI6f0ADqPgRVUkWs1APPJyRjuECPBjgys4c6eOYwC
 S8wommsrhtuqDsD413CO/e52hiq4fSe/b/5Zs0b0P/Ydly4Pxd+JPqsitDc7U9Ta5mvE
 6jqkdnlHiTtZV7nWo0RFtuRI0wKLPzKataOl1BbLCpD4pTKe2oYx8Zt/jrpnvG8quMQr
 fUOjJYkCjRHuhdiIa0XlOHlomnvOuijvhpUEXVQhgI/5o6FHw+R+DNzVT1B2JLoufwmm
 xOPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYFlAuvl5WJHw+O5Sw0b31p6K7wWZU0YxOEm24YnAnoAJ5E2BXWCyemfeGVcBbNuzmjb2Ekl5iHbbH@nongnu.org
X-Gm-Message-State: AOJu0YxEnIKi5SGPSD3CWTpCgYxvxVOV5cFXjTiVAEXAUIMuxvTRtJao
 R+5hnJQEe3mZahrE6skIh1f1NAA1h+c9ZK9PW74MD/B4efgoSOKxgt7B5c5kG+8=
X-Gm-Gg: ASbGnct1Pb7LnL2PdNi0ZzFPX4QD1wksa+AODIDy2a6wPlJYuWfHLQX8+dSiVM+KADG
 197DDwYd7pyBfqELehV0mGHgaChp7Y75fc1HBkSkou1oqmkx4QVQULGc7BN/7HtYh7CALYBg9T8
 Py6U7bDTD5kbqC2pJYChBAfA2vJeOQuJkArhirEcOVMKHj2dcvg0Q1vk3Cp4j6dVWHRRO4gbPU9
 2l/nVMYNK5bn4LZEd8znGT/ldV6TMLWkr77z7iA3f+OTN3wwEO7Ubz62USKu9KgW/ZbrFx/dWDr
 NiUmd4k5uN6bVDcSSwl1efu3ETvkKOrGH9cX9W5CREtIGeBbKYGwhWMDHD7U89M=
X-Google-Smtp-Source: AGHT+IF4sO+PsENGxAXrUXbCNrhDHgSWK/f0v963fIEfL38J0zPl4fit42sqNbL+lxpgS1gw6wr9Mw==
X-Received: by 2002:a05:6214:2426:b0:6e8:fb7e:d33b with SMTP id
 6a1803df08f44-6eaeaae68dfmr174192736d6.33.1742241333709; 
 Mon, 17 Mar 2025 12:55:33 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:3131:60d1:4874:e2c7])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade2092e6sm58700006d6.21.2025.03.17.12.55.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Mar 2025 12:55:33 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-20-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-20-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 19/39] target/hexagon: Implement hexagon_tlb_fill()
Date: Mon, 17 Mar 2025 14:55:31 -0500
Message-ID: <018401db9776$8af811d0$a0e83570$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQLnzw5AsusFrNA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250317-4, 3/17/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf35.google.com
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
> Subject: [PATCH 19/39] target/hexagon: Implement hexagon_tlb_fill()
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>


