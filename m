Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5C8C28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqf6C-0002Qb-AD; Fri, 07 Mar 2025 16:19:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqf69-0002QR-Q1
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:19:13 -0500
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqf68-0003LN-D6
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:19:13 -0500
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7be8f281714so248089985a.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741382350; x=1741987150; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9HFmVul+mtR5DMe3/SpLNd674IaZKbMm7ChCrcfELIA=;
 b=WS3TWv2xtikD9dvPC046OaVSbtbSFaRs0R/EaRNPOFFRWULRqKkKUoxrSPhvMyyhaE
 BuW0QAFLZvSZDwb0iad3Ph7mJCte9tcGOqbhB29vTIjWLYck9pC5LVEwcTP3mkXW1lr1
 1pLsBUiuguP1oN2eSooeja6CbKtwtt+R5BrehGX3qNz8QircPQCmN+E0+HlmjPE6UIhS
 c+9Uv70lkpoDxs2KGBS1J43GtuZMn7s9zUMXdTrLNR5O/csad99DmjwcBRHbkkG8UHHm
 OswQ3mfYI6A//Un6wWyAP+Le2fAAIcMqL2ItMLSIL8eQ/SODrJFxlfm6vHsW4lXz5IpJ
 Xytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741382350; x=1741987150;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9HFmVul+mtR5DMe3/SpLNd674IaZKbMm7ChCrcfELIA=;
 b=eS1Bg63+j1tSgIEViMwwxwGVN/jH3WPxP56C8h28DWGz68UtW5Nlx268hoImqr7fbw
 wN/Tlj2JcuFoTBNGZio0fJmh5I+xAFG6pI9aPK7mVwdzeArnmdX0YtJXUC6e2UM1yztg
 wWwzO7Kp8/UUJjxzHVAG+13aBFoMO8bZvf84HQy76D6T0jvFOjQ7V1NCjp1XvIvMdXSh
 ruT8TyFdLFN9vsKow1cz3P8yFwRIqMk9YD92fHN+7dZNO8sK1xoX88XvNxwqQQTyXSm/
 fTLc1J5v4ZKYhjc4LFYUB7Iw01txsvjfHZsOywZyewqQCodntxXkXMFoi9pM16lZ7qGK
 8lEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb3Qcd3j0tq9PxPxQ7+YAvvwj1Cfomd5vr0sw1ZX+43pwQ4yL6f7GJqPuHGt1Ec1OEsX33cMvdrdSl@nongnu.org
X-Gm-Message-State: AOJu0YzbsqA6hXF8roHNhOHMZpHng8mJ3sZDO7NnjfPJMYMHwAfvbFJ2
 tNRyXPNaIox5369SrlBGEBVp2JRRRXifojSWVJZydcH+NwewGRZn
X-Gm-Gg: ASbGncudkJVj/62vGBq7Hg4G5bXy0x1TBhrkyrR1kc6ZWe/GxChvfHmdokVE2n5IpTn
 n4rV8cSUjjWfNYqKL9Ws11zv0jWkEzT4RgibT7xpzwJ54oT5LsJgl9a2gvaH5Wj6j/xcbJ817fj
 uH4WB8kgZQSPZpR0s29Yvz3jB4rHEbhEHvL9uHp7xCVxfrXhbs56FWPYByLO7EJ/O6DsIUdbblg
 ZBQMGjGQOBF0bf0iG4KgXP3o9X0NdUGu8urIgSpcRmk7FQCSuOp17Bfb9cCK2oUCkOB8I5UMO1K
 yQ2cgWLkXBLzYaiIIMAHlNYy+X4Gz9MaquV+vKnxooxazZyFY/UVc3QnLDk5oUI=
X-Google-Smtp-Source: AGHT+IFNWJrzynTaBdWSpwZKUvUZUcit3m8uYt6RgnGqbEE0RE6sZ1FIo9/Qt3BlOHlu5Y9n36WhfQ==
X-Received: by 2002:a05:620a:4803:b0:7c0:b6de:338d with SMTP id
 af79cd13be357-7c4e6193e8emr859370485a.47.1741382350178; 
 Fri, 07 Mar 2025 13:19:10 -0800 (PST)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:8188:4e08:c1e3:fcd4])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4751d7540c6sm24391681cf.0.2025.03.07.13.19.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Mar 2025 13:19:09 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-18-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-18-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 17/38] target/hexagon: Add vmstate representation
Date: Fri, 7 Mar 2025 15:19:08 -0600
Message-ID: <02a801db8fa6$911f6ae0$b35e40a0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgM0TltntOLp0XA=
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
> Subject: [PATCH 17/38] target/hexagon: Add vmstate representation
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



