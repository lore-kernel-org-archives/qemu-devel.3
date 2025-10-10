Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227D4CCD184
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 02:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v72jf-0000Kf-49; Thu, 09 Oct 2025 22:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v72jd-0000KO-7w
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 22:19:57 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v72jZ-0000Z0-ND
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 22:19:56 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so10045445e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 19:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760062787; x=1760667587; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g+vNKejzR6V0jtRZUBGGU95Jl9y5Lua5p2J/58NSCrU=;
 b=tRVheYPAT/89FQjQ0g/BX5yZM3/UDjuYrZvGpICOuriBSGOIUKl09fiokqYHDRLeVm
 SM+WpiSHtSU5dzjSknPbaV3Q1OAeEadTZX9nhaq4U/8JTUkJufuW6WgBw+WdJm3ZkCFT
 XdoXXHv2Q5sIZZR7VGsw8+z7E06/LWIKyPLkmHXXp5LnKAhCpl2dgw9ssdPqFTe6ChPT
 x+v+DJxoBYstUKZxkYHmIzdiVeoGISMUb4tWMzo79rPkICz6FWrlJmv4MUPRweWQa7lH
 pLC0lajDMEdgod8cpV2w1qmbp4L3eML1Y9LgeTm2VSKnV1tbV1rnxiGK+ZcBKkCAH6vN
 ECyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760062787; x=1760667587;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g+vNKejzR6V0jtRZUBGGU95Jl9y5Lua5p2J/58NSCrU=;
 b=thWpz5NAw1nRBc4bAK2beVGiXY8gJwS1RnzwP93qih1KwCy2Y74ypw3E/+Z4Q2rDbJ
 ob0JtMnSzYNwoOSbBAWvPURTzA0mqqXHgw97/1dkf66IyEOLvZMZ41doy6e4S3/0I/Zq
 /xGdcC2ssAcPSSOXud0xoN2Tof5GgrPbsj0ADAnu7hH+43ZodWAoi01ywNy6+Af5DD/N
 9711s3vF5z5sehhgDRc+NcZWe77CWdENc/BfiUxLO2ij/3MZ7GBiKH5Jb0+a3gKG50ij
 jGMbqgIZw922dxAQXulzds8bXJ3q4AngNE/6pcJZGtMGEXaQGgraEwGLIttaEHKJAXb4
 mldg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgv+CSWuTnpfHIbpEmkeRAer9YPs/MuxgiZbAnd+GlA2amf1cgu3I35HZjqTUkouHf74MWioS1u8uK@nongnu.org
X-Gm-Message-State: AOJu0Yw4Q5ySJ60R1+2DVrsMq84zmR3R819EdtGnoZ61X4v1NpGfcLaB
 mmpl5aC9sMTbYC2qL6EknuN6+ahGXH87UgC1fd/rOYmwge+MLGAzq9hhVkDzQn0nbNg=
X-Gm-Gg: ASbGncsrhdFANyk/01V0KAQmGk9mBfhmu8zSt7iswRSQGJgSOlZQduQ3uXTdaL5d0p3
 wg7K4QJPSFNMQXnnwldbBm7B5WfB825Sd8xW1WKmFoKWVuIYyvfyAzDQx0p2Ugm3Mcw0FLPIus6
 GVd6s7kPnC/AgWw0uziB0VXQGrskaNrUInOHMw0W0rQQPfU79lqjhYH0gf4TyGkT8n+jY6oY2Si
 nnVV6vPXQ7x7x+aXTBh8SFyYK97564lt1meFSUjkRCIyMdefEtez0r1kVkzus/Z837XjblvSO+h
 7iFeAWyeV965P5pdqHe0oky0Y60717kp1sVVm8IqtO8QaDBaQF0sMSfX5nppIiBtEGQRFZDAJZu
 Bul/xJfZE91iI1+298G9/H5ZCA2VTGaDTGjeCpLfN51OVnOJQfZwcdebOP5e7gqnb3lxDZ0JVY3
 sK9dNLPWUlhnpx
X-Google-Smtp-Source: AGHT+IGkMCJibAeJlMqlMJaH9lhKkpXhFhiRBKgVsaSaeQlengNwZGuzMX3UYuFRIFRj2MruiYqrWw==
X-Received: by 2002:a05:600c:4e41:b0:45f:2cf9:c229 with SMTP id
 5b1f17b1804b1-46fa9a220b1mr65380505e9.0.1760062787600; 
 Thu, 09 Oct 2025 19:19:47 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab633cdasm48713935e9.9.2025.10.09.19.19.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 19:19:47 -0700 (PDT)
Message-ID: <0f6dbb37-9d00-43da-9807-c0629575cefb@linaro.org>
Date: Fri, 10 Oct 2025 04:19:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Cleanups and fixes (PART 2)
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, santosh.shukla@amd.com,
 aik@amd.com
References: <20251008164324.21553-1-sarunkod@amd.com>
 <e0cd4386-c367-49f0-b83d-6c38cc6eeef8@oracle.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e0cd4386-c367-49f0-b83d-6c38cc6eeef8@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Alejandro,

On 10/10/25 03:33, Alejandro Jimenez wrote:

> I know the commit log is not consistent so far, but going forward I 
> propose we adopt the shorter prefix "amd_iommu: " for commit summaries. 
> There is no ambiguity (only one arch has amd_iommu), so the full path is 
> not required (i.e. avoid 'hw/i386/amd_iommu: '). Shorter boilerplate 
> leaves more space for relevant details, and helps people like me who 
> struggle to comply with character limits :).

What about "hw/amd_iommu:" to keep 'hw' in subject?

