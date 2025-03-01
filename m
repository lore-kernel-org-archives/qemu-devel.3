Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9D4C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 06:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toGSu-0002Cs-De; Sat, 01 Mar 2025 01:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1toGSs-0002CG-Kl
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 01:36:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1toGSq-0001eW-DT
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 01:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740811003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rjEO7MUHkNuv68oWi+2czUvA7et1su7XX+1jMHziWJ8=;
 b=bBpHyFTEPD6YiA0ThTGOJ7FSBoarD0PBcEmLy0SwgDZUcmhyotjf0oEtpLgKDVBck9r4Pc
 UEuDwaXSNlbnKs9D/MqgLMWj9Z03JxZ3pAGrB5gtBzO/RzS9wt2plTY4qrsuwyw/LOFBFa
 PwVMFr9Giqd+OvKOeS8L6/Qy3E7BqUs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-xf3Mf53wM3mxarCSzAvIOQ-1; Sat, 01 Mar 2025 01:36:18 -0500
X-MC-Unique: xf3Mf53wM3mxarCSzAvIOQ-1
X-Mimecast-MFC-AGG-ID: xf3Mf53wM3mxarCSzAvIOQ_1740810978
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-390f9d00750so162275f8f.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 22:36:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740810977; x=1741415777;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rjEO7MUHkNuv68oWi+2czUvA7et1su7XX+1jMHziWJ8=;
 b=nHegargW2RGEhrNtrvzY2om/ZYYU9mMKSvQaztCJsWG82aP1NPR8S1IaurbdoDMHzs
 pFGkSj/mj12VZ6AZ4K6nRpC0j9LW+fYhEcjQwNAV8U10xCddERbJUMBkfeHegNTndGba
 ZQvppm2laLeW/NatrUoECxrs4On/ZKinlYpGBf6vUqwawPyZwL2YyOYisv4Rlmf739F2
 m0SHs+GRGLRAg8UZt+cNQ5bxgCwdFxpOhx2pColcLqv6cxb2Tiza6v+0+jMC4Lkd5aNN
 bElqQOswDTVu8VP0CRLloflt7/VanbJswm7kT/dZEJCz9yyBViPh+ZVfLQyUdAEu389v
 woYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXlHjbSDzt0aqqacCoRUS803ygACHFaa497Lr3eYCixtIU65cMhVDHM10Ql5AzyIIG9VtDCgzbiF4x@nongnu.org
X-Gm-Message-State: AOJu0YybaKEACjtkpE+qRg+iSk7IIRMCWOpK8pS2hTIvvFAPXzfdEppC
 wy+2mhJK1o3kjVbymEiZTY6fbiDD6UzTLkupSquuDfQjJQT3AvnPuQsXwIVoLcdXN2ZPL7X8RFV
 ohxFDMbI57o5wPjF8DnUTbOLqSYbnjRsUnI3eclQLALYf0Sx8RqdA
X-Gm-Gg: ASbGnctNGPykl0Ff5GjUpHWTpWZKouF84j38b4OLddQytjrDvD0FWguEKjQv7lNPOuf
 J1oNT0tMsIsHvHVYHVZx36Vdsv3RmX8OxJGOYiKPz7zk6n/70Vf43mWI0508shsCxZ0n7W0CvCf
 8Xh0wm8BVFAY11+lk6kMNKM4xDCRGCTZt/iJYau7CBfLaSZLX1z7BKZ/DAy5fdluZK/cFFWoNXa
 6TvmqYe1Wpz2nreu4ScEo1ExGbzW95zT8JhYWJgksv3tSrRa48LdO0RTlc0D3zBj+XzZDIBACbU
 aVducNHsZdPIZX/edtRJ
X-Received: by 2002:a05:6000:1f86:b0:390:f6aa:4e80 with SMTP id
 ffacd0b85a97d-390f6aa5102mr2247870f8f.53.1740810977670; 
 Fri, 28 Feb 2025 22:36:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbi972NcrdT9BlqlPh1XMpLOIhwTnYxA1u7EpWUIlt3uV6tma8L4DqY7MVft38w555MdBW3w==
X-Received: by 2002:a05:6000:1f86:b0:390:f6aa:4e80 with SMTP id
 ffacd0b85a97d-390f6aa5102mr2247859f8f.53.1740810977291; 
 Fri, 28 Feb 2025 22:36:17 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-390e47b6cd8sm7276316f8f.44.2025.02.28.22.36.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 22:36:16 -0800 (PST)
Message-ID: <803732f6-6ab1-4298-a956-660496664f67@redhat.com>
Date: Sat, 1 Mar 2025 07:36:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kubernetes gitlab-runner jobs cannot be scheduled
To: Stefan Hajnoczi <stefanha@gmail.com>, Camilla Conte <cconte@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
References: <CAJSP0QUk77GViTBgBpfYH-AbAmQ5aUwi0K6UTH9iv=1mVb0Wbw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAJSP0QUk77GViTBgBpfYH-AbAmQ5aUwi0K6UTH9iv=1mVb0Wbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/1/25 07:19, Stefan Hajnoczi wrote:
> Hi,
> On February 26th GitLab CI started failing many jobs because they
> could not be scheduled. I've been unable to merge pull requests
> because the CI is not working.
> 
> Here is an example failed job:
> https://gitlab.com/qemu-project/qemu/-/jobs/9281757413

Hi Stefan,

until February 26th the Digital Ocean runners were not enabled; I tried 
enabling them (which is what caused the issue) to start gauging how much 
credit we would need to be able to move from Azure to DO for CI.  I 
posted a note on IRC, I'm sorry if you missed that.

> The cache PVC appears to be a manual addition made to the running
> cluster but not committed to qemu.git. I don't understand why the
> problems only started surfacing now. Maybe a recent .gitlab-ci.d/
> change changed how the timeout behaves or maybe the gitlab-runner
> configuration that enables the cache PVC simply wasn't picked up by
> the gitlab-runner Pod until February 26th?

Almost: the cache is not used on Azure, which is why it works.

> In the short term I made a manual edit to the ConfigMap removing
> gitlab-cache-pvc (but I didn't delete the PVC resource itself). Jobs
> are at least running now, although they may take longer due to the
> lack of cache.

Ok, thanks for debugging that.  I think what you did is right, and the 
caching setup should be tested more on a secondary cluster.

(As to the DO credits numbers, the cost of the k8s cluster is about 
$75/month, and since we were granted $2000 in credits we have only 
$1100/year to spend on the actual jobs.  The plan is to check on the 
credits left at the end of March and bring our estimates to DO's open 
source program manager).

Paolo

> In the long term maybe we should deploy minio
> (https://github.com/minio/minio) or another Kubernetes S3-like service
> so gitlab-runner can properly use a global cache without ReadWriteOnce
> limitations?
> 
> Since I don't know the details of how the Digital Ocean Kubernetes
> cluster was configured for gitlab-runner I don't want to make too many
> changes without your input. Please let me know what you think.
> 
> Stefan
> 
> 


