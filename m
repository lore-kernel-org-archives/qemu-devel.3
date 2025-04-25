Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B236C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 10:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8GSO-00022t-0j; Fri, 25 Apr 2025 06:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GSL-00021c-HV
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:38:53 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GSK-0008GQ-2U
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:38:53 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43ed8d32a95so18084635e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 03:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745577530; x=1746182330; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9Pa3Q3oVD0zw97T/wAZga0Gi89pjN5UGaKdAtcjAuTY=;
 b=ozfXpXFcCLCwVQOpdEvub9A9Yfjj7hzYNIlaQBqb04qp6aGPC2Pfq7N1p69RbjpdxE
 3mOFsYFyw62lriNXWHEDgGGIvEQEOA88RHcKzzraEBCB7G9yTGqB4+Ub+1h62F++oxSc
 U5HkXF+ogeiGFB+tj4s+AqWRqqmNzwLgGmgm3q1wpvhFKifstudeHyuPdryduz0hNkYE
 5eUtD5ciNw1Kf1949PIVl1LYnlO98udQy1Il52E/Dp4eBdaZLGr8oGe0uHAVtjRAlv04
 cdibR3bdQgJODUllcvFgMn7f9hHrKK7jw9PC8fy8QYbzxKF1kp+WNlhoa2mIdumViYhs
 AwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745577530; x=1746182330;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Pa3Q3oVD0zw97T/wAZga0Gi89pjN5UGaKdAtcjAuTY=;
 b=Qh6JQ6pKtVLNRFfHB9vc/Te/A19hqSJyF0AROtivnu0AfsypeCYFEaw06Fsudq9+/c
 fx2mx5wD7l3J3iKXFsOjpkJ8Ds23igIGcQXex1PzOdX7Au2fchRl78rIvw31aPBBKMma
 V3oMCSAedysALjOeemFo1DIEa5eAD20+0Fq05zRXsnHqEWRQDcg7541q+bfWf8WbKPMj
 vvA08fHhEDkxMjehza4TlUf9d57s3LR7q9e8yQy+tO0gB1J6puyVfmgRoY9gANdmXBMn
 xXXYu6R+MJiXca4NdVWPiWrq0If/LdoSziblyMtCWRlYT67cD9RHoBhRf1sZatdmfk6L
 wqZg==
X-Gm-Message-State: AOJu0YyoQm9w4pDmQNl1NXUHPpchBnk5eSE1XqLkPfFHdEOuZDzAWyBM
 LnyJV5Krpn7EwtU4vHrDwdhJ3zt/14syhbfSxGDaFdA7WZX+Dfc0KcKtT8w1149g6SMDM57A5Cb
 O
X-Gm-Gg: ASbGnctYOlJcNAwslLS9n+91P7Ks2DIPwwzvCjLmJVZo0DgAZCZL7atnVqrM3FKpB5p
 EGKGUP0s7HoZzmLr34dTC6dbkPJ9SuBkgTRkBP7ORkpsp6NRHC4Yy3Pf9LmUyyAFKw9cw8fxAq1
 PKwgOCTcujqopNGcVu1NfSBSYGrGjttVSjdLc+ygQC2eMXH9HQ7Fq33jKUavs65+MTDm9abkYhx
 tHNmAL5geEO+9420iN+6TLiEQlGaOwGVf2BX/V7bt28710a8A643UulqXQcEJt2JQqxvejQPb0v
 VSVOHTagzCii4RIrvQ7Bl38OT0/8obtY9fM8bi5v1xkssJKe2WU7ADnaBaAM85w+euhaMQNFR4Y
 /wdDYdUER
X-Google-Smtp-Source: AGHT+IEKrjYIKxksJRQfLQHJ0pEfYC/s/4udSei6Q+vzFXcjsqCUBOSG787xBiYKUas1yq3zSOWwZg==
X-Received: by 2002:a05:600c:34ce:b0:43d:fa58:81d3 with SMTP id
 5b1f17b1804b1-440a66b0803mr13561225e9.32.1745577530171; 
 Fri, 25 Apr 2025 03:38:50 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca4e50sm2029388f8f.30.2025.04.25.03.38.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 03:38:49 -0700 (PDT)
Message-ID: <2e956c43-450d-4c18-af89-80808494258c@linaro.org>
Date: Fri, 25 Apr 2025 12:38:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] hw/ppc: Remove tswap() calls
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20241220213103.6314-1-philmd@linaro.org>
 <2568d2ea-8437-43ef-9d34-1fc1f2ae6242@linaro.org>
 <a40b4790-27bb-4da9-9472-238768cdca44@linaro.org>
Content-Language: en-US
In-Reply-To: <a40b4790-27bb-4da9-9472-238768cdca44@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/3/25 16:23, Philippe Mathieu-Daudé wrote:
> ping

Merged as c894bdf78b3..c2ac9f4c297, thanks!

>>> Remove the tswap() calls on ePAPR, and convert
>>> them to big-endian LD/ST API on sPAPR.

