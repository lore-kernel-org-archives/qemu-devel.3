Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECA3C3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 17:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCMZF-0002OJ-8p; Tue, 06 May 2025 13:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCMTo-0003n1-Fq
 for qemu-devel@nongnu.org; Tue, 06 May 2025 13:53:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCMTm-0003ss-Kf
 for qemu-devel@nongnu.org; Tue, 06 May 2025 13:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746553997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2w5PshLsWCFBJbdWiTBzzyJ6DacfI+1HzCZ7ghUF/Qw=;
 b=XS+lPM5ghNiahtrK3Xpy2jz9f4eIJKdOCEyZfIbyMNOsR1vhuh5VZlJ+Ps8z7otdWfeS+1
 eHnDn+45XFSAlftB9bWzqpCOG+FhkmeDHKsDOTIW8/Pnaco3vTn263pMUO5zeQ/ihGbqf1
 3GtaIgQTJjcY4Lp+3pZYcgFsI3XTgRo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-puKm2usxM06HAemwzs_fsw-1; Tue, 06 May 2025 13:53:15 -0400
X-MC-Unique: puKm2usxM06HAemwzs_fsw-1
X-Mimecast-MFC-AGG-ID: puKm2usxM06HAemwzs_fsw_1746553994
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43efa869b0aso40042695e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 10:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746553994; x=1747158794;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2w5PshLsWCFBJbdWiTBzzyJ6DacfI+1HzCZ7ghUF/Qw=;
 b=gy/CNldA/dga/7bXtJdO/SaJJtpoIaGxFq/Gp/wEYiUcfl3qTJLmfrbrsTvEPy+D0Y
 cxRdZ4yy1G/XCRXTQpf+h2il9CkRhQn41YZQ53iR2QT3spbDl9PBbFVyl7YEeihFcwDT
 QIDxliiMAjBjQyvbLuvvhmvMQe0qtjY3uyQSh64yfB8Wuwl9u0RsQ7vk9M09eTjmtFqs
 6ymS7Su+DJ8kv0oUzWtKGB8livMwZt2FpxBvT6kvaaDEHCev7W55AC2oIc9mId3zM5mx
 l/TmpV0AYYazLoFLp8kvlGUM1Zf2T0t7/pQdcZZX93FjTO+UavnxTSJXqy1uZbNcExWH
 ATiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYW71/VGGCfpAaAtVmaP22FVMnJ6jiO/Q24h/+0f8V/sDbiaXgnLGh3mMak/abfwAa6x32kGOLFSm8@nongnu.org
X-Gm-Message-State: AOJu0Yx0uxCWKqF6me+QMnGMuwrAOkDpUQ+c1ociwC6StOePsAIhh/8Z
 2Uf1fK1kJYXRL6Dcv82C8JZtd6oCrV4YV+oI49w6q3VPqTiqzIGTAkY9UeN42jiSiwF5VPxg1Tf
 CXcvGZeVqSBjsh9cqeMfQpUsc2uq9GQxHSgDieMK1mmIEPmT5s8u7
X-Gm-Gg: ASbGncsqYVrhPiX/EQaVOv+vBeG5F8sx8TyKeCrtpfz8+pHDCzcOpiS0ZUI6+E2OPQx
 IcYL7OScgktAZpsYrpb6flhaW3qM968GB0J4doIoUuJExiOURq4Z153WZZ/H7Bp8rvPGCU5VFjS
 S2Dkhgo8cSWhybyhWbZbwC5mT2gzxr4vhQaUIV2hdvwr0F7av+OLpEPXnkKus9BKIKQF+OA0DKg
 PbPcCZuraCl8mG3zmwfcJN4MTsq/XnHvGS+zlzeoO83wNlQa7DzEuN64dvD3SqGOdVIjxQY8eZL
 qc4CBGGIPgI2Zm6jKxPPYqX5NkaFHjPBsOsLz6RNbDjXyE/UT9th
X-Received: by 2002:a05:600c:3d05:b0:43c:e70d:450c with SMTP id
 5b1f17b1804b1-441c72eb09emr83460475e9.22.1746553994603; 
 Tue, 06 May 2025 10:53:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHG6Vwl3fDxqcMLxL0KnySgfaxICVpDJH/TogFXmZ89X8pPquqJ+52dvbH44fCDA366A2T9+A==
X-Received: by 2002:a05:600c:3d05:b0:43c:e70d:450c with SMTP id
 5b1f17b1804b1-441c72eb09emr83460325e9.22.1746553994259; 
 Tue, 06 May 2025 10:53:14 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-173.pools.arcor-ip.net.
 [47.64.115.173]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441d43a802csm1137335e9.39.2025.05.06.10.53.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 10:53:13 -0700 (PDT)
Message-ID: <967c7ef1-a269-4bef-96b4-44b4b021c790@redhat.com>
Date: Tue, 6 May 2025 19:53:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] docs: automated info about machine
 deprecation/removal info
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, devel@lists.libvirt.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
References: <20250506160024.2380244-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250506160024.2380244-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On 06/05/2025 18.00, Daniel P. Berrangé wrote:
> Since we deprecate and remove versioned machine types on a fixed
> schedule, we can automatically ensure that the docs reflect the
> latest version info, rather than requiring manual updates on each
> dev cycle.
> 
> The first patch in this series removes the hack which postponed
> automatic removal of versioned machine types to the 10.1.0 release,
> since we're now in the 10.1.0 dev cycle.
> 
> The second patch in this series fixes the logic to ensure dev snapshots
> and release candidates don't have an off-by-1 error in setting
> deprecation and removal thresholds - they must predict the next formal
> release version number.
> 
> The following three patches deal with the docs stuff.

Series
Reviewed-by: Thomas Huth <thuth@redhat.com>


