Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008F6C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 11:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZqts-0005TG-SU; Tue, 13 Feb 2024 06:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rZqtr-0005T3-LG
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:24:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rZqtq-000279-9Z
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707823469;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LXrGvMu2PuYM9s7Uff+Yi8b8znW3yXmttoiKCwwY/ic=;
 b=dCwgsflJZ2wlTYHysypKgK9kNQ1mpHaLr8K7W5yQPhhEEsbQ2TsbLCp4hWOW+BEeWbwclf
 E2BseIRQKTbgrsh8nltjap2tquPg3l+9Cq2LZy7DlAdWH46ZGPb7xytKwWnb024iZrnd1o
 bOUGE5IlphvIGMrPWxgCC0Ed/h2tZAQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-g3DHH9jeNDmqnSblZJcDSw-1; Tue, 13 Feb 2024 06:24:27 -0500
X-MC-Unique: g3DHH9jeNDmqnSblZJcDSw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-785da5b71d3so165700185a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 03:24:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707823467; x=1708428267;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LXrGvMu2PuYM9s7Uff+Yi8b8znW3yXmttoiKCwwY/ic=;
 b=ftMdYaJPHpZ+O7DwECq8iZTKwXIzdLoIvLgqdQqtASnG+kbLgTvZ14FBXXsyBhTduk
 ZetN3oRFFDnTSyhakMqb2occWrIKFl4QD3/nMIlG8s+SXmX7VR0u3CI7JzIH2mrJG7t6
 Mi+ikuN7W5SNtU+fhBVEJi4fK6KaruTydcSFp7QTa1uBCBvc6C+8T3ymTayLkCWg5YRa
 hUtJtNxM5vCze1+329AzxYs4iANVn0ww54Lr2geZRrAUDvr9LqkTEfF7zLI8hiI71vAn
 IwFwkLphbj1kRLLDMTZC4bsiZ4R5vI4QWKJLn+8vaf79CvzLmc0abktmYtaOi3RAFOGG
 8hMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQabfmQqanRSZXnhnrtr4OtqlmLcugL73L7bGhXhRV53udE0uIKGR3JRAJTZFHlEZO11ncVHaAS4FHzMxbduNP/E8TFv0=
X-Gm-Message-State: AOJu0Yzq+Rj/WrVyX9LqJdJ6E0ZC8/hQy/svJnXFYxE6DIjSEObQDBz5
 DDWp/ADkz7ni1ZBph5A/+R6YglJAKxI+M63xbnteICXA1aQ3E04EbSif5avAcudab0Xqvi9jVzA
 xO0CsN+MBcXFygFwoeOebIckRVtL86Uox7MR5/55CI9eGKFtBYb9j
X-Received: by 2002:a05:620a:110c:b0:785:7403:8860 with SMTP id
 o12-20020a05620a110c00b0078574038860mr9246964qkk.50.1707823467502; 
 Tue, 13 Feb 2024 03:24:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEg9BvZjDEZLEc1iPN+otSldB3zWWag84RVSs6OQQ3zkx8MhiWdnbjYJIKb6cVNxyuTqBi9jg==
X-Received: by 2002:a05:620a:110c:b0:785:7403:8860 with SMTP id
 o12-20020a05620a110c00b0078574038860mr9246950qkk.50.1707823467311; 
 Tue, 13 Feb 2024 03:24:27 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW3c4sBUcYIw78AH9A0Kf1hUhYGlSaxMdtH2gfKt7bKsrZCZObeqzPJKyQBUU3Vr2A76WTCcWebcB7mKMFxFxrMzI7IIgd2J1SkBlqkz1jKdR3GUdVnMiKX3ZMFUKltsWReUocVgLy2MECs8H9kCjl3EEy/U4Nq6j/K0Sj9dvJxRFPT4IZFwKl8r2kT1PDpny9Z/FHAgf+zjrJq6Y+ZQ0lDm3/N3ralAxbE2PRvGXZhhjuHErmGUYB6hIk5NqULuq9Od1Y+5k72Okk2nmi/
Received: from ?IPV6:2a01:e0a:59e:9d80:4685:ff:fe66:ea36?
 ([2a01:e0a:59e:9d80:4685:ff:fe66:ea36])
 by smtp.gmail.com with ESMTPSA id
 g19-20020ae9e113000000b0078715e107afsm928345qkm.73.2024.02.13.03.24.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 03:24:26 -0800 (PST)
Message-ID: <417ea71e-fb45-4e1d-b8e5-9d54d93dba3b@redhat.com>
Date: Tue, 13 Feb 2024 12:24:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio-iommu: Use qemu_real_host_page_mask as default
 page_size_mask
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, alex.williamson@redhat.com, clg@redhat.com,
 peter.maydell@linaro.org, Peter Xu <peterx@redhat.com>
References: <20240117132039.332273-1-eric.auger@redhat.com>
 <20240213044312-mutt-send-email-mst@kernel.org>
 <6d4b5766-f8e2-4889-827d-01d3509239f7@redhat.com>
 <20240213060731-mutt-send-email-mst@kernel.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240213060731-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Michael,
On 2/13/24 12:09, Michael S. Tsirkin wrote:
> On Tue, Feb 13, 2024 at 11:32:13AM +0100, Eric Auger wrote:
>> Do you have an other concern?
> I also worry a bit about migrating between hosts with different
> page sizes. Not with kvm I am guessing but with tcg it does work I think?
I have never tried but is it a valid use case? Adding Peter in CC.
> Is this just for vfio and vdpa? Can we limit this to these setups
> maybe?
I am afraid we know the actual use case too later. If the VFIO device is
hotplugged we have started working with 4kB granule.

The other way is to introduce a min_granule option as done for aw-bits.
But it is heavier.

Thanks

Eric
>


