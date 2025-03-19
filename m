Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6994AC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 21:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv15Z-00029I-Ec; Wed, 19 Mar 2025 17:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tv15S-00028A-WF
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 17:36:31 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tv15R-0000kZ-ER
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 17:36:30 -0400
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7c08fc20194so30313185a.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 14:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742420188; x=1743024988; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8C4BJK+Fw6TqPpnhkPclincHpBQsurs2tRFaN9a1sUU=;
 b=SZ+gYBrvpcbjZg+XljNMYhIpmfsp+iuK5uuUWfZnGWlMy/wD1dTZ+/hnz6S7T+nOHs
 CpnCfr8bI5zaOSrdvxAad/WK5InoF2AXBM6GAkXA4GKfDp8iYpUh6VVkrTokoHr1p6tX
 AOFO2H7jtIS7m30vUt6zKTA0cy+GMgay0s4ZB/YBxGf9iBcsGTsEn3LhnvS6gX6q2D3R
 0HjqEOuGXRnSYEXP6Nu/k9S9u5wTCemm4AKLVbnHnV4DzR3Ra1BZzFnS5Jt6JX//KtO1
 MA9Gtbq5Lu+U9uWgLLESfdVLiif1kmSGs03opb6Xhd3B2v4AkK7MydCt3nh1rgYE+4kX
 WBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742420188; x=1743024988;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8C4BJK+Fw6TqPpnhkPclincHpBQsurs2tRFaN9a1sUU=;
 b=t94TaFznnyXpOXUZ6dfHiwmgyVtgeCwOf8k+8WYRsk4biK6xe0+dyWm9Fw0taDdrXI
 pfnFV80YrNvROaggSzXPxsPA942L81FyM0pj5qHdLpiwn+aSht9PinA3saMBpahkvPmJ
 F995rmg2qICqyjevu/nET1bkS3H67AugqVO072f3lkgYmXxSg963Ea3Lz8MSSxo8ddI5
 yViRkTuVgB+qfkPnbM277iu6f4jabeLKAW7GNaROnBaBl/24R8W9lNGX89sZalhLjVxS
 7iUtnRPBpMN4p3tNlRcXne3xYMKvpNYyf5dn4bSh77o2ejyhUYZ8CUeu2/+aDnCRLAQw
 9dIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzS8n/SkjtS7CcFLjhf2Sdd88Div60SDkQwtkkHw74ir54ib2/92QgQoU9i0nbWx9QsrDdLcGGozvB@nongnu.org
X-Gm-Message-State: AOJu0YxQr4oGfLsE1t3wz4R3/unaRi5t3eqOE7qvrHbuy5pJmvUTfe/a
 K1t/tfAfwfAJ60Jb2wcDgH8Kq/03FTZ4TY8wcRz2339ZxTkDdVid
X-Gm-Gg: ASbGncv+k9lCmHTlD9nsnDH6aOcEXkS9xETt3RBn+o/vY06W0GfZlZ5V74hYDurVCyE
 lf5mzLQ67/80Z8kwM2i5UhVrG52G+Hn9+Q2MSG9R0M0QaIcK4ERf/1nkdOi4cckwU3cbKU86xfX
 wMeZZ3U0a6Y4+wDlIXZHQlkIp633zuU6YC9cYUxZIGxKdpZgry7CCnM7G0EGxDVXO32kcWwu44N
 hCL7X+nCzc9QxqPmsG6J9uZQfssYREnfxzWNBe0YTo8yq1iKk1695zoNozcvogi9hfhgyeqrWfK
 2YkpD3NKS1FyIhcu3pg9UWjOAv9rAj+3aeRbm9XeIWyO3/gsRk+OlcyR0UMDqA==
X-Google-Smtp-Source: AGHT+IGTRJXw4FcQBOCedZgQeYvhlj/INxRpMkBAIuvx7zzuIcnv3OyM/rXHI/JUdvLoI9gom4hCRw==
X-Received: by 2002:a05:620a:4550:b0:7c3:cde7:a685 with SMTP id
 af79cd13be357-7c5a8396ad0mr601818185a.13.1742420188063; 
 Wed, 19 Mar 2025 14:36:28 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:992d:4509:eca7:6f8])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c52246sm906556285a.11.2025.03.19.14.36.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Mar 2025 14:36:27 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-22-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-22-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 21/39] target/hexagon: Implement hexagon_resume_threads()
Date: Wed, 19 Mar 2025 16:36:25 -0500
Message-ID: <02e301db9916$f862db00$e9289100$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQI0aONIsvPkNJA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250319-0, 3/18/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x72c.google.com
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
> Subject: [PATCH 21/39] target/hexagon: Implement
> hexagon_resume_threads()
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



