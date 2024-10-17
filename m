Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6B3D3C526
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 17:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1UbN-0005QN-1n; Thu, 17 Oct 2024 13:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1UbF-0005Oy-98
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 13:47:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1UbB-0002pN-DV
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 13:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729187256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OGe8oGGeeiUi+F5s3emF2aDh6uT/NSPtKzdNasxpxKM=;
 b=DD4FwVvMeht42bY1XhEfnzuTjyxm2qN/V/7QPFKU1wXl9532ZKW6W47Me8/i7c9QIyCjck
 yqczO0kJHXt5x4zcJF0gK73zIHPHKvVxBHkryecahByzotT8aKUCqUu97oA7WjFi7vw5xy
 PDCahZIulSlD1F9+4E4xbZKLWLiV8MI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-2maNFDWKO7KQnl10QWK5_A-1; Thu, 17 Oct 2024 13:47:34 -0400
X-MC-Unique: 2maNFDWKO7KQnl10QWK5_A-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-539fbf73a2fso1135080e87.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 10:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729187253; x=1729792053;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OGe8oGGeeiUi+F5s3emF2aDh6uT/NSPtKzdNasxpxKM=;
 b=hJlXWPzOh+WkIr/F5HOAMGvB6YlGzROEkvlc/O9mIl1DJwr2mzxtjd7O10UWmBiGQO
 Fuh0LzU7JiczaKNa2EwmW8Zp5NkiPUwHIjkKaEUMV5WnnKrqPbzFUPxmy3RPeZiFbl4W
 MeUR8HU9Ef1F6C3FGt+jkHnH1nnjMA4nGsANzkPTYyB8n0g8BQNoTiOeInyXUigOWM2G
 bPxoXW0PJTd8Iy9cxF6pAfRF4Fj0adi6Ql0TbbdYgjaxS2avqjD4l3DrDGSR0K3lJCV+
 DZ1uZeC+Yw/InFVRjBxtx34axA8DDZmdcIb/bygsAANwbhFYCmGzPVYNlkQbaLoNj7KZ
 LwAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUShITFRJGEk7NbLTkctff1VPtMd8K3nFnlcP7Lwf96jWiodKH+pPgulA+bvpn7BEzNVIUOXPcQEl5R@nongnu.org
X-Gm-Message-State: AOJu0YwPJIhYjWleigdXBGzHgV6BLHoHTLdhOpKdjPDA7/oVPo3xP2jz
 NseWckG3lMX8L+qH7xclkP7aBWwPrJptvl3ozV1ZzxjczaLoQB9FcT3NS9fRdF+qrfzZr/mk2RX
 IrECqZ9lg6XRWfiMUKk0A1PtcAB80wHW45phNbe3tzz2hcZYo8SsI
X-Received: by 2002:a05:6512:e9d:b0:539:e510:d83f with SMTP id
 2adb3069b0e04-539e54d8180mr11828227e87.5.1729187253081; 
 Thu, 17 Oct 2024 10:47:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERdge4WnSZy63B2ms1BKkO+/MeQZAV87AwkwN711cV85bXpngIV0gqGOEcn6wF/GpQHXFFVg==
X-Received: by 2002:a05:6512:e9d:b0:539:e510:d83f with SMTP id
 2adb3069b0e04-539e54d8180mr11828208e87.5.1729187252593; 
 Thu, 17 Oct 2024 10:47:32 -0700 (PDT)
Received: from [192.168.10.28] ([151.95.144.54])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-431606a50f0sm2291545e9.33.2024.10.17.10.47.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 10:47:32 -0700 (PDT)
Message-ID: <5cec4c84-e30e-4567-9afb-ef60b4b7c2e1@redhat.com>
Date: Thu, 17 Oct 2024 19:47:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Stable-9.1.1 00/49] Patch Round-up for stable 9.1.1, freeze on
 2024-10-16 (frozen)
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <qemu-stable-9.1.1-20241016195251@cover.tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <qemu-stable-9.1.1-20241016195251@cover.tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/16/24 22:09, Michael Tokarev wrote:
> The following patches are queued for QEMU stable v9.1.1:
> 
>    https://gitlab.com/qemu-project/qemu/-/commits/staging-9.1
> 
> Patch freeze is 2024-10-16 (frozen), and the release is planned for 2024-10-18:
> 
>    https://wiki.qemu.org/Planning/9.1
> 
> Please respond here or CC qemu-stable@nongnu.org on any additional patches
> you think should (or shouldn't) be included in the release.
> 
> The changes which are staging for inclusion, with the original commit hash
> from master branch, are given below the bottom line.

My next pull request includes a few more:

https://gitlab.com/bonzini/qemu/-/commit/15d955975bd484c2c66af0d6daaa02a7d04d2256.patch
https://gitlab.com/bonzini/qemu/-/commit/64e0e63ea16aa0122dc0c41a0679da0ae4616208.patch
https://gitlab.com/bonzini/qemu/-/commit/615586cb356811e46c2e5f85c36db4b93f8381cd.patch

Thanks,

Paolo



