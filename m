Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B46D3C91D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 15:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTLv5-000852-3V; Wed, 10 Dec 2025 10:15:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTLut-000827-55
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 10:15:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTLuq-0000cz-Ro
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 10:15:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765379742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vF+o86Z2V1s5JdivbOsPvcLehJ2lyBWXIuobyN8CE50=;
 b=PHunGBmO1dPU+ZF3eINsUeriV3mYi9zeLU5FFda3GvtmlTbjTtDxTJGTfemul3W+XzdIXB
 kTuCQLru72MJ5TiVjyrUSOo5Zr0YQAgu1SSpG6xAd1kcb9c3z3w+M57Jmi034WOGhETZuw
 sab9Bqb6Iot2JPzzYiwiwp6wV2UCUkA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-AAHIttcdPB6FDE_42tsBHw-1; Wed, 10 Dec 2025 10:15:38 -0500
X-MC-Unique: AAHIttcdPB6FDE_42tsBHw-1
X-Mimecast-MFC-AGG-ID: AAHIttcdPB6FDE_42tsBHw_1765379737
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477a1e2b372so54427335e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 07:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765379737; x=1765984537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=vF+o86Z2V1s5JdivbOsPvcLehJ2lyBWXIuobyN8CE50=;
 b=oohJ62m5bj3LY6QjOibpsDzUJS11b99vO2u36kMFUvwxyTmkSkRhRIxwW6C66PYFix
 LqiWwTwFO1CyYFxNGlfTKH/53PshBtYFj8yzR/J/S0T3sUBPt5FHaL0ExWuM/+zUdf58
 JvjAdpYheaP/QBpoxHfX46cYOZ5ISjydiD6f1kl64K6lW73yDFqGJjPVeuTKMdM5gRJ8
 dklpJq9c4pAywCF65DDFlJni7iUbsbIKiCY7rsFns7hguaiD+JzoZbKMouFzyUhOghvK
 FjpnYHOcmP/d4tqXJFxxd40rIC3qfABHnj6FRTq3xuR2xa+gYQhF/Ro7+k4wXA485vrT
 7w9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765379737; x=1765984537;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vF+o86Z2V1s5JdivbOsPvcLehJ2lyBWXIuobyN8CE50=;
 b=WFewyS702T7FVuu4druykG+znYSXcBC/NVvfOEb3m0RIjQ/tPs8Lo2DADabeQXozPs
 /om5mP+ybaqlrmGN0agh4qPoULKHZCC4f44LC4R2GDRnPnkyK5EQihsx/SU7p+VDSsEn
 1qJ6+EPo7nd7nUFoq5WPyxZTNybFD6ty5lo1JXT1DcGmn0r4R+CofJkFTbtz+aOWEsj0
 rki3vIAdSStLgrQz7YwZJrccghoqeohtKdwixdObg5/bGj9nlsTXj1vC8HU0yKdcpgmz
 UprUzArW2ngSIVdB1e7AAzAdE7X7qLEwfdzVHSxO2vEzZmFs2nUXsjaC5h4BUE5ZxSzW
 AupA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9wAp/yWDca5BEgk2vUabWA+uR6qH4lvJpGkCzsn0Nd5I6kfvOihhuwdSLiOhhlojCTdMczT9pfgYk@nongnu.org
X-Gm-Message-State: AOJu0YzgPL4Z8YrlUybGnRDPmQozQQmsWpUD+2/ErcHn36sgNPnJrjp6
 M4a6l+9ikqdmhJSj58AzwI0wfeTiUvEv0iOfJYItzGoL1vvvgtMmkv0LNDnYWGy8L6z6ZHRRlzS
 n7iHylRaKaXdkMcMsYeKPTcMIJ+8M0dquSQcNCC/P9eln7BaAmdHG33bH
X-Gm-Gg: ASbGnct6DDaWmequNIhRclvTjeZ8RKrHF/EvF0zbF0z23cD9wATSplAcVLM5EqEZIPg
 Awhz16azDfc+3l8df8rvm0ZT2M8XKB2qJT8vx56ppqRydmjT54hAcvoLdUFSs4/c58IK3gAR/Q3
 tmGi/ON6AE/D2+38Yk9BWXM7CGnHcooGVFcrQKhzBoRqij7nMQxntTCuMQD08p8ULDvOHNCQmfa
 UYGF1q+0HPSeTl6R/uz+OslNFFhvUgXWPmO7l0+YwZ7qPnd6LTvR7rtoVUL9s5q7RiQv5KTn66M
 GBbfZoMsnKpIh+3awK0MKs3gB+Hisb6VdPt0VAmhLSKKUfYGsy6QCHefU4H7BCSef5N/bAWzCDk
 6v1jWpe9EJjuuV9Zlerbv3IhBr16P/QiZ8mr7sfWri9G1OD9Q
X-Received: by 2002:a05:600c:530e:b0:477:6d96:b3ca with SMTP id
 5b1f17b1804b1-47a8380b068mr28262195e9.5.1765379737122; 
 Wed, 10 Dec 2025 07:15:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8wnyiBzNNLq2hTCLH2HHiI2P6Fs7KyqAtCNazI7rPJF2jgjbOx5sjs2fINaxPrSVY7xmj1A==
X-Received: by 2002:a05:600c:530e:b0:477:6d96:b3ca with SMTP id
 5b1f17b1804b1-47a8380b068mr28261745e9.5.1765379736686; 
 Wed, 10 Dec 2025 07:15:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d367dfbsm49035825e9.2.2025.12.10.07.15.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 07:15:35 -0800 (PST)
Message-ID: <25132957-3d0f-49cd-a011-79cf5acf3d71@redhat.com>
Date: Wed, 10 Dec 2025 16:15:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 31/32] vfio: Synthesize vPASID capability to VM
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-32-skolothumtho@nvidia.com>
 <2ce54748-5a35-4ae9-9dea-f893a3467825@redhat.com>
 <CH3PR12MB7548A7288E01FBFCABD89033ABA0A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CH3PR12MB7548A7288E01FBFCABD89033ABA0A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Shameer,

>> Also, IOMMUFD backend is not supported on all platforms, so these
>> changes, even if correct, won't compile.
> 
> Hmm..I am not sure I follow the compile failure case mentioned. Is the problem
> will be with HostIOMMUDevice above or within this #ifdef CONFIG_IOMMUFD
> block itself?

Try a ppc build.

Thanks,

C.


