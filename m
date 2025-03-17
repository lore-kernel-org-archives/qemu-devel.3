Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA214C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 20:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGk7-0002Ph-Bs; Mon, 17 Mar 2025 16:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGk4-0002Ot-Tl
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 16:07:21 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGjz-0008FZ-2H
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 16:07:19 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7c24ae82de4so552527185a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 13:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742242033; x=1742846833; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=IA5XgviI0YHCR5OtSsgZ32rPlNgCrBQ1BskCBkgSn4k=;
 b=GFyeM9Kd+DlyUcSLrybdsYmTowevB6jh+iN0P38cozuh6kQAZ7C6lQIClU12PweYv/
 73Vtv5oOh/mvV9JBwrXgul5vd013YSCM0jxJJ3trBZGmSLiE3CxJ+dhLi2ji3zanV9Dk
 hnMym41/ZC/QXkb5zk4pSc8g0D/TGHAVaSVHTD/C7Jd6+gocN2SPq7MSw8flQ9J2PzEE
 ETx7vbVMglz+UdrM3/RLrjnAqBNW7MkGP7Kg7KNodGkzIFikpGgHNejCQx8G4fjRP+V4
 NXGAZDI219ARTAW279UWRnidSgR7kN0ocgmvfc0m7cMM89ZVGGaQg61DdQCnWrtfDyAg
 2iCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742242033; x=1742846833;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IA5XgviI0YHCR5OtSsgZ32rPlNgCrBQ1BskCBkgSn4k=;
 b=nb1+f5eLJO2J7FRgQDzM3nVTqxNIUtNCNIbsvWGIqYEFvcj99W+07DfvJce8RaNJl8
 S4AsIM366LXc/OSquJzlHv55F3QajERUeD51NHbnz+hobpx1vjSatJftt9frBLvznYam
 GCykfkKcVbKcNA26Glnrb59THayzMnnWp2f7D5BRibFi6OROfflGrjvCaPSaZ7ySUvZV
 A/qj3e8TgiXuIs/XhgAytPUX/9U8YD/YJ3+QDX+cLByKfC9jaZC4l1Ep3CNhc8jwLk/M
 BNhntl0uc0N8udqrWVFB8tZv3USdiyk7IXAeYR17oG4KAcKZfy00km215Ix2WpEQJlZd
 ZNMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBgAAVhxD01l2V6aIzMwCFvkw8ERfr6rlmxpVCQpvALysHfaBW2kLK8W5GYAFIFElK/bd3/PfcKf2n@nongnu.org
X-Gm-Message-State: AOJu0YxmNhN/ELEfFJGfCgrFNKvovA6AYIOyQx8Fhi+CCTCJutlsNup5
 N+K64MvLDD8wSiBH72tGbG900zzJz05bx/beEAY5WMqh00RC7iPV
X-Gm-Gg: ASbGncuNznZB724DI2htp+nf7+Fr5DxFvJjgsZMDZbDWMizicQeUNyrDXcCueq4t8Ri
 0JTlUValZmBGrvN07jknWU1Z1b8r8KQyC7XYMYN50A74x6kM3TjYQuMWvTTA4TFu7jVbRWcziF5
 2i8H5ZLVAnsSSmLPFMWPC11DmxbuIiXxsvwF8eCO0lTAEoO4NmFvHtm6407qm/ZFyclGMXNLpTy
 w6DJPXZhDUaFzV3KgvzuRzKz4X80hClX3Iu/a25xUfOBF/XFv8vLQ+lQW/hEDMq9FlCRPFJJt+C
 p5F4wPZG8CtmvczbrhjT4tqhjWst9LOdtVXyHeuFHlqRWCn5wPhaTAF24JMunSA=
X-Google-Smtp-Source: AGHT+IHB2oyonDmyFzX6qD4WJ29JT7dbAlbcwhlK3GDkDdo1xzDqnJf60mYgTvSYK73tH4TIM4TESA==
X-Received: by 2002:a05:620a:4482:b0:7c5:49d6:733a with SMTP id
 af79cd13be357-7c59b1bbb31mr140863785a.21.1742242032820; 
 Mon, 17 Mar 2025 13:07:12 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:3131:60d1:4874:e2c7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c9b193sm626795185a.57.2025.03.17.13.07.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Mar 2025 13:07:12 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-26-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-26-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 25/39] target/hexagon: Add hexagon_cpu_mmu_index()
Date: Mon, 17 Mar 2025 15:07:10 -0500
Message-ID: <018701db9778$2baba320$8302e960$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQJqgJ38su716xA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250317-4, 3/17/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x72e.google.com
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
> Sent: Friday, February 28, 2025 11:29 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 25/39] target/hexagon: Add hexagon_cpu_mmu_index()
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>


