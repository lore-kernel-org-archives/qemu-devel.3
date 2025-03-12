Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E77C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 17:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsPXq-00043b-UR; Wed, 12 Mar 2025 13:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tsPXl-00041j-7b
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 13:06:58 -0400
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tsPXi-0000M1-Ro
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 13:06:56 -0400
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6e8f254b875so1189966d6.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 10:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741799211; x=1742404011; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9qxJO3t87HokaQgQ+VUMHcoC1dEtPzH9AuCylHmhRNw=;
 b=GiB/HmLJBVO4L1SGdggQe17/57vorCSFGhh+RiQQyEAhdH4prX1LxCT+PIo/+eOXpg
 zJsUMb0Ts4IMOkZ4k1ogdyD85aSQvBQalTAAR6R959gOXZiJwDOjehPTodzNlFxS+LfX
 Kh+qcwO1CLE/4OnHRp1epm4HJE/zbONzWPt6A2SGZ/rZIiDsU/na8kF2OLu4nMSKVP0r
 Yr9Jcb/6kCaiip8y7rzv6hc0YeBF/iKkQXoFVQsLx6U2wVRha+nChxPIFJnNWPlz+UPc
 WEKAapQ79HJzWcUNM5EuLJmw7deNJyARuAWi3e1z5sPeU/vKglgPjF70LrRQipUI1ruU
 wWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741799211; x=1742404011;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9qxJO3t87HokaQgQ+VUMHcoC1dEtPzH9AuCylHmhRNw=;
 b=GtnVebk8QHYRmCq0c5QJqD3OE9ab687H0+zd39qdcur47Yj+QnHcM0qFEvMFqlspfU
 Rp+EOYee/Fq490TNTpLcVq6d+K/xaIUQt4q3MdBH3j8NxcMVcp5DZv9Zn2m2t6FeqfFC
 ZQ8pTEJSfsK0rw9OA+9On0DQIf5XsDb0cWWa3PVRtL+l3145MvleqiP0WeLg0KHsVOMt
 yOnB43YlzVq1foPxjx761nLRelIlPxwiP4GJu+CmKmfhaTLuXX7hx5D/jDuNfjRpAQao
 wHBY3yQuWIadnLP9oT4hxN49uXfuPIdTamZrv+7HYUjAuPLSEXz8gZCQ9YNFfy53Ngim
 xuKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5lCH5hsCnw7tRFmYrN/SqsxuXZVQ7+f1Jm4RucczeERMQXfnHgoHuvxx9Aavr6JZUKMLyFcXIjxi1@nongnu.org
X-Gm-Message-State: AOJu0Yzgy3OHdcXehkTcABXAiAaY9iP3uXkVlYLKzj9Cmz0LqJh7DsnH
 d2OWtoy1FYQdKSfHDAylalkXHx0kRonY2dTupb6UNNgxYjZnaCIIjushrNxIRjs=
X-Gm-Gg: ASbGnct70ISdeUneHKL9toCqdMSFoJfkm/clCn6gXAx18VDzSL72csFrjpSoMG2Vxyf
 x+RaW0qsEfmPf4OCDOzepsB3KB9TBydG3D0OAwG1UJokAye6M93d1giHxjxD5Ouwqora9/DT2Es
 g7QojcNsfrpkwbesiVh3p/mnEMv4mjPa5LRPO5dHHDSmyyZCgKdtilE+TSL6Q82Kcq0IoidMJqP
 R0xwBlJVvDGNmLoY+s2n1Cn3dBS+CuZ3kk0FSW4/4S24pBFjPUNiLvRq730Q3hBdgxHgV3nFDTW
 bz2NN4zOyYnKoBY7gpb+ECWNIYlp8PZKoOWiyJMiM7h6d1Cz7EDtstkxI3u4UQo=
X-Google-Smtp-Source: AGHT+IGWtLf6GDJG/tkuxcxihDQrcHdhlBmqwMkeC2kf6reyRoRYbLekIVUqsGTuLN8IZsQWfsVnsw==
X-Received: by 2002:a05:6214:da8:b0:6e8:fd4d:dba5 with SMTP id
 6a1803df08f44-6ea3a6965e4mr102231566d6.33.1741799211082; 
 Wed, 12 Mar 2025 10:06:51 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:9cc3:cdb3:7013:e1db])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f715baaasm86457866d6.85.2025.03.12.10.06.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Mar 2025 10:06:50 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-36-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-36-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 35/38] target/hexagon: Add IRQ events
Date: Wed, 12 Mar 2025 12:06:49 -0500
Message-ID: <011201db9371$2576ece0$7064c6a0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgL8gOkUtOw+HJA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250312-2, 3/12/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf2a.google.com
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
> Subject: [PATCH 35/38] target/hexagon: Add IRQ events
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



