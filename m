Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A9FC28B2F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 17:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsPZL-0004s2-3O; Wed, 12 Mar 2025 13:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tsPZG-0004rZ-Gw
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 13:08:31 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tsPZD-0000ai-Hq
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 13:08:29 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6dd01781b56so1593126d6.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741799306; x=1742404106; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TAg6LjGqdw55wwo0PFmfEKGXSJ28o71PdnB4lDV0sFU=;
 b=KU/nw8g/knaImoHT8DxF7EzF7sfCB/MxuqoZmwW3z9F5DqTStygJnXbg5xzY3GWN2i
 FjzyZ7LvRsAn2hS+fPpIm0GUVTnLZ9paPEkvzQfvfrVZpwWeQnWfcz6uEp+tu+BnBuOp
 mSKZE8qsqMTdbdvw9b5rEROAOxEyGaALmt4AmUo2NJrhKKRbi5iR7rAg1Dqt05QobZXE
 HSuZO1e3t2MIhCzSdez7k2GNPMWYJVtYOo6a/Sub/EFrUmZGGRJ2PIvLC28yQ9iMbm2X
 zi3jSXPGc4fcWRFosn33RbdBYsS5VZUkJAst+xWwW0+hDdUunIypI2p/ZvB1v7tec76c
 T3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741799306; x=1742404106;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TAg6LjGqdw55wwo0PFmfEKGXSJ28o71PdnB4lDV0sFU=;
 b=SJweTuOpWBcGZ7sWZpSBK7SFelc5kvCamOwSBHjcqcKXJcsk0pM7NCLlf5zOTzW8+V
 3pNRia8BweJLoghzNN4Z9hHHLKaF27IiRhVTVY/zIKfG9HjYlKvwSQGjMrCF600ozw1O
 vcog4siNTQBnoaILnO1Tidl7dp8wo0pw9l6B7I5BUfjbc7blC7IsofrqclgCHzM0r8KY
 tQnn5fa1fIas1onQHZdIAPFDR8NEcXaHoz9kJGeaALSCAOXsTKb33pbqtIFLZaQWVyIN
 q32iMI0YIk7IN1Gw1gT85T5zWx6XlA/LRb7AAhqLRQ74CcucYbAZ4s3hxs4pmhFQrzUg
 cXyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv+0Or6T5496+JNVWWnFfeDMBqeTIi4wKu4d8k6XMo1IcYwjVsTPLNBWzx8iwwVYFDABNaiJ2cCKDq@nongnu.org
X-Gm-Message-State: AOJu0YwdZwkk5ucSZPV9eF169Cr65SkEGlY5uIigvFisjb03d9qa+1Zo
 gNtucs2haQWIRPq12gD+U34Uo6aeWh47KIXg5X82Dis/4Cq707vQ
X-Gm-Gg: ASbGncursmh/OFF8XByVL2bL0PLC3CxFrpNPQUWPt2H/eI6vuqwMbwqcbmZbtsUcaG8
 cJ3mWRozX+9p1GcRng/Y6/SVjWqGS0tSgrh+80QioyWliV5iFoc9tiXXOvJeUV4iA9ziT3uPBfv
 9mBKb/nUxHjrWpGXzYiJWR6+jTk/nNjXe034yFt6lytlKSDofq8ECnu8W1PmD1GrKbPG996Hwjg
 tMrGigz/aCHT/HhLQkeOyZl9EaJDgH/0yQgQ4Hgp/auuKm4OdNXexu6q/OZF5GC3fPRAaWBAqvz
 Fl0nn3+RlEd/Xv5Oo2+mS0NvirE48j9O3lYcOf/AdR5QmMB7pQXGGH4Pfw0vhU0=
X-Google-Smtp-Source: AGHT+IERphaFiRxav+VNOjZ49p6bfFyMCky//zSFHrOMNPIYWJfoQv5xV/Peg/m5qtzzBClRoha3XA==
X-Received: by 2002:a05:6214:80b:b0:6ea:d393:9634 with SMTP id
 6a1803df08f44-6ead3939835mr32492276d6.3.1741799306081; 
 Wed, 12 Mar 2025 10:08:26 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:9cc3:cdb3:7013:e1db])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f7170971sm86694376d6.101.2025.03.12.10.08.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Mar 2025 10:08:24 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-37-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-37-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 36/38] target/hexagon: Add clear_wait_mode() definition
Date: Wed, 12 Mar 2025 12:08:23 -0500
Message-ID: <011301db9371$5d8f1fd0$18ad5f70$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgGeawcdtPcvC0A=
Content-Language: en-us
X-Antivirus: Norton (VPS 250312-2, 3/12/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf2c.google.com
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
> Subject: [PATCH 36/38] target/hexagon: Add clear_wait_mode() definition
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



