Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399F1C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 20:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvM8H-00028I-3P; Thu, 20 Mar 2025 16:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tvM8E-00026w-EF
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 16:04:46 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tvM8B-0006gS-Kz
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 16:04:46 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7c5b2472969so112541985a.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 13:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742501082; x=1743105882; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mfyhA5GejRLV4KHasyeczWQeMaULjQc1TJs4WUP8mR8=;
 b=LzdOM2nuiovlBVhfzxXkuOLcL39iHcDLVunWnGpMsldBKZpnxlyVPnczsmf0LZoVv6
 /qG3foGM35Vr9dT+rYyYSRZKUvbXBw/l8QkUO3ZV5j565NsIiGkzb/0roTY4KrQoydkD
 VJW65JtTL2v9cAvFIpuLhZVqqyu1Tbm060Rp3nyjSWOhivpYwza8JNRWHbFEoXCAtWpc
 WgPDS1/vo15wh3w8EwkR85zEER87+ic/k4g+YSF6fL9fNlBm1t19eHJxEoYQ0VARNI0o
 7pblsKta5rY57lZ1ALHp2w9B84Q92uMmCus2EvbYVRgjjzRAjNNw66jTkQjcL8fpUrn1
 do/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742501082; x=1743105882;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mfyhA5GejRLV4KHasyeczWQeMaULjQc1TJs4WUP8mR8=;
 b=M78WuHNX6FJtsl3faZMlTaKMA2TSkdOwA+SHuxqEbhZ2JxJUjVlSlcTDlIMuYZNC5f
 o7o8BJ/znyExK5wC17BexCrutUDryD5Fe+YOdzUhLBZ1c1U/K2nibzRM2TeV4BFOyI+5
 o7klF60Gy9igW07TSj69O67DDrzUq5HDl3O2RQM9AiAeUSapf/2rQyrsnxq7AIOZyply
 hHcka0TqhfCufSrykMfBSJl4mi8KOFDxQLEGy8dt6JlaEyQBjujiLwAvzZF0AIlfr5/V
 t6D/S/n9/BO+zYBSKVs6w+e/mvuEEL+6CIAY0LqPdYGK4QK+SIWjBbhRXBxXcI35S1+w
 vEKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVepRFFRA5OL9/OyrsJORHnjRiQYZvGQ9plGVz1Qr/+7Iwee4HaUtEFH5gsPfJrSsEbdTB/0f0GbRPH@nongnu.org
X-Gm-Message-State: AOJu0YxsBHPYaoivnytUd8wnfpVQ/tfuBdf+jLJhlI6WTNbZmw4TiK7s
 e3jX+k63zKrWayh4UXbeBra2Ci5zHmMvHdXqEcnglqHduRvPXDDhbYljzItS/D0=
X-Gm-Gg: ASbGnctsl01qS8TEQGR+ag5nonYhLOdqyn3W/eTLwx4FCDVCuUBLLf+b1KuBHZ1RPtF
 j51psiI74FgywSvzBik+deFdHuwAt9zaxK3hjprFvmm2hRZX1WFRlQz4ED0pwTDFRb+AuaF5QIA
 FXfatOsaAlsPrzsw9Kwo7S4nhw8XYPe2jacI1AcRzQWfZGfY/Kf04Mc/PMyK1dW96AEA2XnNb08
 5zmMvMMJzxV39Q4aGukdj+8nwmTtGCRlSJ+V5umalQnKpGbczsib/oHdh8nwR39516XffLGlUFg
 eSHpWyO7R5vKEXk0MPNzay43iZWe9JGSeo1u4laS9Z52aCNG011OgKyL7Wq1+S1bNFBUiaYahw=
 =
X-Google-Smtp-Source: AGHT+IE1qKJWT8roCPAnBHx0H0FplsWJairAqvOTKJwMWlotX/Ot0cH7flXrB/cjLDVmRoIyQBDpWg==
X-Received: by 2002:a05:620a:4443:b0:7c5:5909:18d9 with SMTP id
 af79cd13be357-7c5ba15a850mr70887685a.5.1742501082256; 
 Thu, 20 Mar 2025 13:04:42 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:7462:60e4:5895:7c5f])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5b92d4e57sm27852085a.32.2025.03.20.13.04.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Mar 2025 13:04:41 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-38-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-38-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 37/39] target/hexagon: Add support for loadw_phys
Date: Thu, 20 Mar 2025 15:04:40 -0500
Message-ID: <03a301db99d3$5146df70$f3d49e50$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQFbUkJnsvwlneA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250320-10, 3/20/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x733.google.com
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
> Subject: [PATCH 37/39] target/hexagon: Add support for loadw_phys
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



