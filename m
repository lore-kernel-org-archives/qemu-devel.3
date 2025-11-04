Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCF5CCFA00
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCq7-0004Hn-4J; Tue, 04 Nov 2025 03:56:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vGCpW-00040R-Id
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:55:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vGCpU-00073U-Ni
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762246551;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HN62QGwthL8facCp3VPYNlRtyyweQYgUZyqjYbLgJVk=;
 b=K9ZiRxel1OndwEZShsJyVAdevZ7iHrLAdgk2N6BRH9SZnGPNqbzJwvaYY7I3mZbhO9FdiR
 MAnE7NA1jLe1Rg4ZiFnFOCkTUDLbYr+eWD77rVLRoQbE1cZ08UpHDmyufWFc95DmIMwr/m
 SixF0/tWUXwLLyuLypSewWYJVzMnaSM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-xuJtucddPg2kIcA4ldiHMg-1; Tue, 04 Nov 2025 03:55:49 -0500
X-MC-Unique: xuJtucddPg2kIcA4ldiHMg-1
X-Mimecast-MFC-AGG-ID: xuJtucddPg2kIcA4ldiHMg_1762246549
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-470fd92ad57so61063655e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 00:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762246548; x=1762851348;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HN62QGwthL8facCp3VPYNlRtyyweQYgUZyqjYbLgJVk=;
 b=RgWh3+xIo8z+PBTUA6VacgY+vsFeh8hAT+9/Ye7u/qiS3klfgvLL4Q6ykISmdaEkgK
 qq6gtTobbljkSrVmtlcH3MNjl0GYJeO17LQbq8QdUo66w70ZB5pvKL5VSJC9JPW3zWl0
 kV5ne3r/uuO9nXw4C5jDXbi3Mv1YoFIYEwGctNgOsiaXgD0XN6Z39abdYK3wzigUVnDj
 XB2NcLBo6uJkoHt5uFdfGUyVbapk9M/U0T+4S5vBuy9TohuoDeAhKXvlMsLtjUJVt2jO
 vv6CZfI06cDcQeHp1GEskDZe+2M1VVdSgNGmnYWjSUedaKlyLJo4xZ40CAFvT/tLi4AJ
 S8DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWobcAH5hhpJG4u7heHgkSYrnp9ShOZB6ffPi1a1UlUvPKYX2K9YyUlfqoy64+52ASQ8sTtr2eWlX3X@nongnu.org
X-Gm-Message-State: AOJu0YwvKGKryDn/O6OkihS/yZtczUkJ/fEsn2/HKD9V0kZ+0ojYtFc+
 mjegPvu5qOwfQd/L/FzPtAbUMG5Ph0DoPo+vu/ylcAiwOXrNq1q1h6EInsdJ9g24glq2U3nwlfH
 sAEr6hauOyDYL2vaCFKWct80LCQYFg8J37vYZMPCtaAA+9Dd7AN0SqXxB
X-Gm-Gg: ASbGncteYWdJMp91X/+9YZxQ1RcDu0SDz+YFDmkyl/1Fd9LX7VTNXrrqH6z8oiVnctq
 XBpU2z/ZybJ9amL58l1lEn3L16hk730oG54YdkXAJGD7tkrwggh1ZkecZINJyy4Q2v9XfChp8Ys
 K70A3I97fEC24ry6GtJrLRlcKN1ae2fMBFMxCvSRvzpq2CKT0koCrQdkUtkumbSfkdlBYv//9Iu
 7tLW00lBpWtejbWD8MQ69bCHdlOax7pZgISn/WV3j6axyAm2JQQ4RjkTbxveDYam1ZNcpmfwl3+
 x7pzhXko2Gy08VoUgoR1rAj5ZUNRA9oaIQy3Ksfv8Wlsi78u60GJ5BJEj7zIypGXir4jG21ljQA
 b7Z//byG6EFTyH4mXMLkz7y071hlq5ZuLpe1IZ7gD7hMnZw==
X-Received: by 2002:a05:600c:3b13:b0:45d:5c71:769a with SMTP id
 5b1f17b1804b1-4773089c52fmr133016675e9.26.1762246548624; 
 Tue, 04 Nov 2025 00:55:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcS2niz5q7n38UG7b36aWFaAXXGFxK9u+bsbaWFxlhpVxtx4o48KibCE+hx/yFWkssgPfBWA==
X-Received: by 2002:a05:600c:3b13:b0:45d:5c71:769a with SMTP id
 5b1f17b1804b1-4773089c52fmr133016405e9.26.1762246548165; 
 Tue, 04 Nov 2025 00:55:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477563e25e1sm18275215e9.5.2025.11.04.00.55.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 00:55:47 -0800 (PST)
Message-ID: <b0a02ca2-6115-4313-88b2-f3218aa2b686@redhat.com>
Date: Tue, 4 Nov 2025 09:55:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/32] hw/arm/smmuv3-accel: Add support to issue
 invalidation cmd to host
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
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
 <20251031105005.24618-18-skolothumtho@nvidia.com>
 <aQVVxV4I/nh3aAXn@Asurada-Nvidia>
 <CH3PR12MB75481D898FF28E9832B0013EABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aQjpzdwbJVPN7AqF@Asurada-Nvidia>
 <CH3PR12MB7548CBA8B4C962BE867C9362ABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aQj5xQwsq/kBaJP/@Asurada-Nvidia>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aQj5xQwsq/kBaJP/@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 11/3/25 7:51 PM, Nicolin Chen wrote:
> On Mon, Nov 03, 2025 at 10:17:20AM -0800, Shameer Kolothum wrote:
>>>> The general
>>>> idea is, we will pass the errp to accel functions and report or
>>>> propagate from here.
>>> But there is no "errp" in smmuv3_cmdq_consume() to propagate the these
>>> local_errs further? It ends at the error_report_err().
>>>
>>> If we only get local_err and print them, why not just print them inside the
>>> _accel functions?
>> Right, we don’t propagate error now. But in future it might come
>> handy. I would personally keep the error propagation facility if possible.
> smmuv3_cmdq_consume() is called in smmu_writel() only. Where do we
> plan to propagate that in the future?
>
>> Also, this was added as per Eric's comment on RFC v3.
>>
>> https://lore.kernel.org/qemu-devel/41ceadf1-07de-4c8a-8935-d709ac7cf6bc@redhat.com/
> If only we have a top function that does error_report_err() in one
> place.. Duplicating error_report_err(local_err) doesn't look clean
> to me.
>
> Maybe smmu_writel() could do:
> {
> +   Error *errp = NULL;
>
>     switch (offset) {
>     case A_XXX:
>         smmuv3_cmdq_consume(..., errp);
> +       return MEMTX_OK;
> -       break;
>     ...
>     case A_YYY:
>         smmuv3_cmdq_consume(..., errp);
> +       return MEMTX_OK;
> -       break;
>     }
> +   error_report_err(errp);
> +   return MEMTX_OK;
> }
>
> Any better idea, Eric?

Can't we move local_err outside of case block and after the switch,

 if (cmd_error) {
   if (local_err) {
      error_report_err(local_err);
   }
../..  

Eric
 
>
> Nicolin
>


