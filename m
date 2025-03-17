Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6012AC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 18:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuFTk-00048K-Lu; Mon, 17 Mar 2025 14:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuFTa-00044s-UV
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:46:15 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuFTT-0000VE-I5
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:46:13 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7c55500cf80so362305185a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 11:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742237166; x=1742841966; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=APnbOF1Ithqj2Y9JYZd3qO7AXWqHzyA0TmQo2muTPX0=;
 b=J7IJQ+lOA/WG0Enu5yXuckc/okKavam0rJRNRai0qYObY9GD8ZIM8OZZIgUDozR2Cs
 1GlpU8G/q6gIXjy5yVXWjGeJkLX7bpGRiuZnuuUrrvzNDSnY+Ts0T8Z0rbs89P9qb8u+
 snUKHTP+KAPqDXmJzE0+T6yeoijN1RYIKdynH3Wq3k8nlKnrgdQgPGpYRSWm1Z50ie/u
 DSIAB79qqE3XVXoyg50jKjhR1sKpbQyWbsLVScyaVn24TOfuwD9vrvIhdwrgNT0CDqZ8
 W4at/oL3vL8YLFm1oo5kzAWf3dhow4d9eVV48prlFX7s4t0mbxtVYWynOlGn67rIKLtQ
 CmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742237166; x=1742841966;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=APnbOF1Ithqj2Y9JYZd3qO7AXWqHzyA0TmQo2muTPX0=;
 b=NDmMs64VT4GtPzy11/eCeO2M+yfKlgy+pqH6MWavoTVqybCmjeub3CTu5TQfJBFF/r
 KEKbHCGGWZD2LQY6L0DBL3hSLMAWlO6bOw6OtGuM1t1X/+h18bjVq+VhRjb6dzDrxqGj
 ctIfUUhN3baNY0+uB6M6dWKg2uxqyYPDLIF86/60VsmRtolrCxSdH2i3B0NpzAPG25A/
 PPScEeDIYkB+3MwsN30qBek1r0du+vT94cZg7cahC8JS7xRmOlW4op+AMSixFmMwz+G2
 JoiWX0Br+NR1+o78v0U065Zh1uisqiRCxJHRAktkKePBmNB4xvB9qAJri0CC8qkPmeKB
 oRiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXKp+HhcAr8ZgEnRT/yj9W7Zt8N2vSQkEKovwH0Orac8RCEDPTfIDYcA34nfskp3yQO965Ez31j7mz@nongnu.org
X-Gm-Message-State: AOJu0YzFIpdrzw9xvX1QlNh/f1Q8XzHRwYDELlN83/WWuWe9MTJwAFrA
 yGYveoYDwkHplSjUHnkprpwIdAeYg8saS4rbRCAoZCk/IVgIFTB+8G6Kyo+sQh8=
X-Gm-Gg: ASbGncu+c8c4Bsy82uHO0XMO+cV7rGpz8eRvoTCqOyn+YfwOSMeawK1ejHcF8WBD57O
 FU8NjmgkRv8B/KarIetUaiMB7TNBkLYCPouL6aWycWD9RLB6E3gRTPSH8Y2yOsq9xiSKLMGe2vi
 AP4yYqClcHNxApamT1L1P+LT4LldTCkA83M4wSqOQuogK074xuBd8RYQV2LUVkgm0ydCgTuhhNK
 yZVIWJMvtZ9lX+qqqEf30qFhFuRgvjBBip2/o8NIpZqJcg9YpkG19csyMIu9dNLmzQ+5z726NPU
 r14RzBx2qT3oFhllGy7dgSrCBHDr5PzKySi8lnKMJ60oShWbdsKHAM7/2h4gl8U=
X-Google-Smtp-Source: AGHT+IGwtc4IAGZAJaWR0YnC/G1Ye6F7TISa9FsCutha2kKLKnS7bgdJyO+Ni7rQ+iuIo0/jqZPPEQ==
X-Received: by 2002:a05:620a:2296:b0:7c5:9a4f:adf0 with SMTP id
 af79cd13be357-7c59a4fae38mr101029785a.33.1742237166350; 
 Mon, 17 Mar 2025 11:46:06 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:3131:60d1:4874:e2c7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573d8a062sm616427785a.94.2025.03.17.11.46.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Mar 2025 11:46:05 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-10-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-10-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 09/39] target/hexagon: Implement arch_get_system_reg()
Date: Mon, 17 Mar 2025 13:46:04 -0500
Message-ID: <017601db976c$d70c6ee0$85254ca0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQJQjz2Rsu+uptA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250317-4, 3/17/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x731.google.com
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
> Subject: [PATCH 09/39] target/hexagon: Implement arch_get_system_reg()
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>


Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>


