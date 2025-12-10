Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A227AD3C922
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 15:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTMIm-0006dA-Ks; Wed, 10 Dec 2025 10:40:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTMIl-0006cv-Ba
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 10:40:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTMIj-00070K-26
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 10:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765381223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+3FhxDpZB0u5WUhUj5j8Fls95/qXI6o6xioL0BxIeYY=;
 b=OQ0x02hcS+sx1MAe8q4bHOQdCw90u8sUFju1Hgkm2CPfMg72xiKTKq4++p6RnDF50diZfF
 BCJLEkXsodJPJlu1chxJBtD8INd3FgkEJ9ShpseSkRxvhVIBevjioS1sx3r/4Nmu8f2HeO
 2n0cURm4tKc6aSLzjFlcu5+i4fJbP9g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-MlR6IR5iMCisF7EQDD61DA-1; Wed, 10 Dec 2025 10:40:22 -0500
X-MC-Unique: MlR6IR5iMCisF7EQDD61DA-1
X-Mimecast-MFC-AGG-ID: MlR6IR5iMCisF7EQDD61DA_1765381221
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47910af0c8bso48570815e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 07:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765381220; x=1765986020; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=+3FhxDpZB0u5WUhUj5j8Fls95/qXI6o6xioL0BxIeYY=;
 b=jnkF6SdW2nOXKVt5AKVnzdemTX9AAPvehIsr4TgGaYi99z8MhIrBpaIXkL4GqIdd3u
 yYZOD8ha+IAYzrqlZWRLx9aanvBsTfn/hbQa5Ln7FAH4yrt+poqHlbOm0SngQiiRTDhs
 QAVm9YjXE82cGJgjBnoDffjCTp/UkRj/IjlMv4HMEagJJr1H7vZ4JsaOU3PfSuw+o46m
 0PiSl7ChrWE41e1QI9Yl37nTW426JiCtP15bFkA5tbP01LYmgVwOsDhg0cjJm/+5AMqh
 Xt8tI5cLTE+D6zGQ0R8cuKjlCUDpw8fkVqXbfzTrbI4M8WoHgorzfkwNTnEa4TQTlOYQ
 eIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765381220; x=1765986020;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+3FhxDpZB0u5WUhUj5j8Fls95/qXI6o6xioL0BxIeYY=;
 b=wnZ7yqhjAXObnH4NGgAEQLztQrrm4ZUaR9MWFBLDhVGzRI3WyRd3CTppM0mzk3lvHm
 /kn9ZyTkmTjzBijMX56J/gW9XOTjKKr+O6drxztDTpzboRXerxr4enTzqg1inlCtSKsJ
 i2uVZVhUKhlk+JY8emOQzyH3HCbNDnRPWvi0gvW1q0Vl67bdZM2f8Pdr9NYgAkxzi3Za
 5M66eOP89yTZaXXhfJPwD5/wIhvcDQl596tgstDiCn6aA2jx+SVmnrLFV+oFNqO/6oWG
 60LTawb1SyzE+CtzmqFJTGaWFWRGo1xZb9teaT/7oSVgRfv83jd0alr6fAs8coZw3/3p
 Locg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJEVU0jEPVAkvTD8bO2XIdaRcwPFYIWUBg77eSgc6eTpTnCqbO+xuoSDQ2RtnH0BJ0Te1srZE0hEU4@nongnu.org
X-Gm-Message-State: AOJu0Yz398RolafXrztEtG0V+R+ruZO0OGnS2eYs0w1dCxMQ/aWUnNey
 YSLatqPOf/7gC2R0b8EBTjichtnRXq/MiY6UKdcHC207cA9wCqaQwxU5Du1K+SndUvy5Q7rBvSK
 44aJ0osaSte651C6jYFICspB4BX/6PwmfIOEQcdldmRN/ZgRiS3WFKbaHOMTSwf0e
X-Gm-Gg: ASbGncsy8Ar66FwiV6nXUgd6HRUf9YD762ecKTRxl4NJiiqS1/7uobaxNGuMbhUDsoi
 emlT5/+nReUCYibQ68BtFwZ+3oxumHsh3rQ9JvCWyEs/Nc5VFRfbO1Fm18BqHxihw7LQaWCWlPX
 lwwq+Sq1BIhei2rvMgevNfC4ZC+AN6XTXfanqvv46spEr0YDSMjgGb5KzMaH3XItKqDWqSx+HGv
 Cg/HgzkdYEAtdlMyDrwBcIlM2HtjQ55915j850h2z+wy9y+wpBTwJCEfc7682Cw8GJYwvnbldKV
 xOuRvpkJ9O9w1k24CNzf7/W7JsB66kobNbIVEgKMOSlzttHQpBwWtQZIR/u+NFTnxHH5M9r2VQW
 TJdnDS2v8n/IYLC4kRT++MNF0rAFQObYpLrVz2q2z3OO16fMk
X-Received: by 2002:a05:600c:198f:b0:45d:d8d6:7fcc with SMTP id
 5b1f17b1804b1-47a8384cf91mr30465955e9.27.1765381220247; 
 Wed, 10 Dec 2025 07:40:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFs4eSU1W40ahiF06Q1l0tOOfn7o6SDqRfoYZWrnwXo2Go1TyhepRx85a67ANgUJQ5vrdajPQ==
X-Received: by 2002:a05:600c:198f:b0:45d:d8d6:7fcc with SMTP id
 5b1f17b1804b1-47a8384cf91mr30465465e9.27.1765381219760; 
 Wed, 10 Dec 2025 07:40:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8816877asm56455e9.0.2025.12.10.07.40.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 07:40:18 -0800 (PST)
Message-ID: <a3d872a0-5c5c-4daf-89af-fe0ca19e6ddc@redhat.com>
Date: Wed, 10 Dec 2025 16:40:17 +0100
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

Hello again,

>> In this case, I think we can extend HostIOMMUDevice and associated
>> class, to handle PASID support. Please rework this patch. I can
>> merge as a prereq change.
> 
> I had a go at extending the HostIOMMUDeviceClass in v4 here,
> https://lore.kernel.org/qemu-devel/20250929133643.38961-26-skolothumtho@nvidia.com/
> 
> Is something similar you have in mind here?

yes. That's the spirit. vfio-pci should be host IOMMU agnostic.

Thanks,

C.


