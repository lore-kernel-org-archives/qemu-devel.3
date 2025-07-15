Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C276DC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubcAY-00084L-Ki; Tue, 15 Jul 2025 05:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubcA6-0007w0-DH
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:41:24 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubcA4-0001Oa-LO
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:41:22 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45600581226so31956975e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 02:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752572477; x=1753177277; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j+QESgReb7Md5vCSefZcoqCHHLyn3vfzzQy8PHg0QHk=;
 b=vqE8X4uqGdUE9oNHRbls2BgWmFbVeKmAqgWA2SnxRpvtKcFpN0BZPM56NMCwb41GvG
 37fh8/em3rjVKQb4SztGBsqaMlltitkd60VEH/djAnyNmlT/YG69uDJzGTn9rcVwVf91
 uJboDbqGIU4u2Bu1BrBMRRcOSUTjHQYwayKf9glKJALqW881zFWjAsVgyY2LujqyFtQn
 WmR9qaeVgCYX73EqCAJLG2b5JeL+J8cSY46R8I/TA07bw89Ch1X9DDvSDrdbGCNWL6H1
 p4qpwqyCETflam800uyt7454DSmedVT+L6P2PQq2/8j+af7e9LKIJoUT2ye+C8BZX1Hw
 3dPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752572477; x=1753177277;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j+QESgReb7Md5vCSefZcoqCHHLyn3vfzzQy8PHg0QHk=;
 b=e1oL6A7tVQnBQXo6Vxh8zVzw/z/tUi54nColnD60I+vcT8oaVI9NWdZiu8ovkWYgvY
 PzRFRqVSSs3Ms7qCArvc3hZZfettn6GSL8UFLp6XeFTsVVuQuTLFZZJSzWJVj36ysHMi
 ToBR66iklQcl09xIW9UbXH+ilveSd+OIVJEK+rkVkKRNzwCkj35x/Qi3LwRmBk9cJZhK
 JOi3eIgsgcmLRaCI/ecqFe0XGzXbwNqUW6XSjEQ4WrqjbXvBGvLuGajtHgwCwR+jIoro
 VV6U2cTA2aKEsQT28jBUor0BBHuM+EfOgyRJr8GU+k9rZwYTwkMTW17JDzh4jbh3COcs
 N6sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTO9O2wW4Jwkjswfnewp0wOdij4dFAgnQka2Vpk++S7crqY4Y+4oV+HCfBrs6kkoMwfeHsqJltv/aZ@nongnu.org
X-Gm-Message-State: AOJu0YwCbYy37rQOpEJ8zD0YZnmKIUrM7Pbb+JRw9AQ60jLisXY63PEI
 BNfUO+YKk79wXgPD+3cJVqPpWjljnlMYYcaXbm7q/70C7lvrH0jp81cV3T5N4pa7E8I=
X-Gm-Gg: ASbGncuXzBlHZbsCEDg/rvcMLt5kYLmhAmasyi+HCrnqQFcI6h1sRcEHZ9Y1vmINTyi
 gQdh9EQwekwyag8o18xBm0bIT11OXqhOVZBg+O85gjoW5/VuvRp54fuy8c+MIIay3dq8YlWrJDH
 fHMRpVVUJ1VqPZKqqr/pyTbaqeNdXRMmBL61AvF7618fQzDxXirheP/WJ55sCnKt+XxuSkW+NhK
 ypVqkIM24zGXT4+Q20pVfizduIcmaJDn1upAAMq7nYKxJyOqjbSUXUnK/Y155ozh8Zx22kmYWPS
 AtuCV3nBAGv4yVgFuWMFA1J3clfV104EiYhlEVRxPmeDDYzxUrl3eKm+cUEG29AL5XCcIh1WLR0
 5pU97aIA53mIWXjbh3FTjgukljyNHQihl+QGXKhel43bkkX5SEwmx87mbYg7Q2qwQkKoJMck=
X-Google-Smtp-Source: AGHT+IHDwWZLYYgnW21UAzIOPBhaqPuwx++nULS5gSB/YFdq1KPOBLZdx/UiOL/1ryiub+Gc38QFFA==
X-Received: by 2002:a05:6000:20c2:b0:3a5:52cc:5e29 with SMTP id
 ffacd0b85a97d-3b60a145410mr1048190f8f.7.1752572477292; 
 Tue, 15 Jul 2025 02:41:17 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd17b7sm14668886f8f.11.2025.07.15.02.41.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 02:41:16 -0700 (PDT)
Message-ID: <8beaa797-46d8-47cf-8f44-50aa15313003@linaro.org>
Date: Tue, 15 Jul 2025 11:41:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/22] vfio-user/container.h: rename VFIOUserContainer
 bcontainer field to parent_obj
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-11-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250715093110.107317-11-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 15/7/25 11:25, Mark Cave-Ayland wrote:
> Now that nothing accesses the bcontainer field directly, rename bcontainer to
> parent_obj as per our current coding guidelines.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/vfio-user/container.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


