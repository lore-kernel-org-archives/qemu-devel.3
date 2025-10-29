Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02B6CCF9EA
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 02:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDvSq-0005bd-AK; Tue, 28 Oct 2025 21:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1vDvSo-0005bN-4R
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 21:59:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1vDvSg-0003Eb-Lm
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 21:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761703130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FPrpYPEQYt3XPeiLW8heNMMADC+MpM2brBVJFmfPfrE=;
 b=Gsj33O1AwAwI5XtHepTZqXWjnvIv9Cjzo//N5aES+gj3QZG9AyTh/s3lJB5OkJjgBD/am4
 +F512+Qs98u+8qt/dOgrKfy2IX0AnUqXaur1EB0MT9TxuRfZt1+dxbgixOYArwf3PNDCxl
 0rAFuu7S9vVG7BFCzguF7NWZoxVyrfo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-elqR7gokNZGU0uEk6ip_Dw-1; Tue, 28 Oct 2025 21:58:48 -0400
X-MC-Unique: elqR7gokNZGU0uEk6ip_Dw-1
X-Mimecast-MFC-AGG-ID: elqR7gokNZGU0uEk6ip_Dw_1761703128
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8904a9e94ebso1386883285a.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 18:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761703127; x=1762307927;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FPrpYPEQYt3XPeiLW8heNMMADC+MpM2brBVJFmfPfrE=;
 b=VEnOrfXc2F8h3aOy+pAHIJfOKN2p2PBt7+jZShK/kPH5nkM0S4hmTBwcQfIlF2hIU0
 8OQu76t2ZcKZJmmA7ZPEVmLd1RAC59m8fe0GXeQ+CVbxZe+9kWsU0Gtaq/kThch9PlYc
 s3fdbAR+LJXtz4vVBSO2dHCb8gCI+rREXlb9tgP7aWB8/r0W/J2xUTVJUEGhF7too8md
 I8G+jmUViQi6+3loHgB1JBd2WzHw1BmuhzZw/5fTyQ+Yoajd4C68NZ8PfPVV5ybHz1fb
 hIu8jL1YULn68cgAOuh8KM8CxGAGJVdePwesBy46fPYJ0VgvUKnqGXTVGQI4r3MRD4MB
 isXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaNlKyPUIOcXEFE52jeMQlA/bCOVYxvcDQcy/nN6Y59F6ZibTP7s5ATkZEVBknu5Y1OjH3pgtQSQzz@nongnu.org
X-Gm-Message-State: AOJu0Yyr8Ppr0uIDy5koC1HXBNg8hCGNcQJnAlQeuyMI513q1bdBqDbm
 WQG/31IpIK3wtqOI2RZB39esxYcSECbxog02FyazaV1rtkFx0heT1XpitqECyBeMAp9CiQB8pxp
 sbEsQuFMT7HBtLLh23APfXNTpTHc3ZizWsp7UzvsYdFBpZnlOnhPvBl9l
X-Gm-Gg: ASbGncs8S5S4YOksJ0lOT5YxVurwcdGX5AQMiwosgSnMQDPaZ563Yy/fRP45uCwO71c
 9Xvpf4KIHmrQ+F6HxdXYZdV4LK/v2Tcnq++KkAmXQ94gSm0GGJ8A+uC4FdXCxUn1OUudrtmHgc3
 hc/Gaz8Ox3i1HjFJnLCCOCudtscmKZOB9Abogim43+tmyFYAAjDyUFoyyYjFNjKFAmpxa4R/IPl
 diCYoqvJpuAdxriHizlSSt4pxaNJ9JFR+yVHDxxYUSN8DbJV/TC7xootZOsAx93fIffy0u2ooGt
 pedzAH2LU2/4BUUH/DtjMM3M46qWIIZDyygIi3EbJogQs0uL4YA+dVFWiS7aIHMHbXopVenYwCA
 =
X-Received: by 2002:a05:620a:46a4:b0:891:d993:1bdb with SMTP id
 af79cd13be357-8a8e6087428mr182184285a.86.1761703127199; 
 Tue, 28 Oct 2025 18:58:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3L9U4c7qyuEkqjAdyObHCsaXovP3dT3P8SqQ00IPzMISKCb+3P9DrcwD/eSLN6y+BZfX+sg==
X-Received: by 2002:a05:620a:46a4:b0:891:d993:1bdb with SMTP id
 af79cd13be357-8a8e6087428mr182182885a.86.1761703126829; 
 Tue, 28 Oct 2025 18:58:46 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f25b89f04sm952154685a.43.2025.10.28.18.58.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 18:58:46 -0700 (PDT)
Message-ID: <deb77f19-3a23-4ebf-8b64-020241b230b9@redhat.com>
Date: Tue, 28 Oct 2025 21:58:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/system/arm/virt: Document user-creatable SMMUv3
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jonathan.cameron@huawei.com
References: <20251024084350.252702-1-skolothumtho@nvidia.com>
 <CAFEAcA8SAQO0frmN-rK6zp_-fEGXLefAXAxHmT=LASqEL-UU5g@mail.gmail.com>
 <c21641fd-1a35-4b47-a361-bfc2daf7dbd7@redhat.com>
 <5e897607-2c33-46f2-b2ab-579a2f4b6385@redhat.com>
 <87v7jzk2rb.fsf@pond.sub.org>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <87v7jzk2rb.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/28/25 1:35 AM, Markus Armbruster wrote:
> Donald Dutile <ddutile@redhat.com> writes:
> 
>> On 10/27/25 10:13 AM, Eric Auger wrote:
> 
> [...]
> 
>>> Looks good to me as well
>>> Fell free to add my R-b
>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>> Thanks!
>>> Eric
>>>
>> +1; looks good; can add my r-b if another is desired/needed.
>> - Don
> 
> When you put in the review work, claim the review credit!  Suggest you
> spell out your R-by.
> 
Trivial doc; I reviewed it previously; Shameer modified it per Peter's suggestion/request.

I added my USD $0.01 ... :-/


