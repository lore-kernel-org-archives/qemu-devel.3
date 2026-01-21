Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EF7C44500
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 08:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viTab-0001JI-F0; Wed, 21 Jan 2026 03:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1viTaT-0001ER-FD
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 03:29:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1viTaP-0002FJ-B5
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 03:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768984145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Jkh1/yZ8xAYuY0ThjazvsLWRdUVrLo8SdRyqplCKfEk=;
 b=SuxjY5adCr89x8Eg0YbiT+v2hmyvc+0Z4WwsDiXn8ggVyI1J+UmytHXzKdlUJ6Og0Dpk3M
 qAYvHczgWHlI+gnJ1aus5vvwDm3tM3ZkGGYUJC35tBwJA4FGcvESmL8DnUHO0gQUDZYBWF
 TWM3uCZvAaKvdGcru472FpOkyo1bkJc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-wo71SfWjMf-Y2Rqn-Bduew-1; Wed, 21 Jan 2026 03:29:04 -0500
X-MC-Unique: wo71SfWjMf-Y2Rqn-Bduew-1
X-Mimecast-MFC-AGG-ID: wo71SfWjMf-Y2Rqn-Bduew_1768984143
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47ee056e5cfso52229685e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 00:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768984143; x=1769588943; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Jkh1/yZ8xAYuY0ThjazvsLWRdUVrLo8SdRyqplCKfEk=;
 b=LFFjnXLxy2Ga+rrjFKZLo3MfpH8nswxOun1v4f6kF4bU73wtr8AaWpZuZecoeBpyju
 NJ6RLJMZKoKWLDxgonGRE5cmbXxC4IQwOMf4eRT73Zzw34mdscL4FDCH3PMqeD7fwRWD
 58fyc9GHORkJGaX1lQkwE0gzmS5rgqVhlbOA+znpmYGh2U5kfLMRNHq1L2oW5afSLr3o
 5xKMaqqLFoP7cgZK5HC03KFmxZ8Xgt/+x5P0CZ2og9BgcALTeCbw31culq7nZeiGthCS
 /sGz+AJ0SM/HIU0MaqlmaX6chfDkDUEl7AH6btZm0FymlwO+SV04F9hcFOF9sHeZSMfr
 yBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768984143; x=1769588943;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jkh1/yZ8xAYuY0ThjazvsLWRdUVrLo8SdRyqplCKfEk=;
 b=nhLlIMna7kr1g8fB1vk8GJ3CUbEXbGXagY8WeMsb1yf4Rzo8jXn3N2CMywkGpKgRee
 XdwAGrtSRO0p+pcuaNL6WkmZrmRlcHA9PrLjIT9U6/yfaBezLUlLjfb0vFcb7j/WmZ1J
 5Dj95UQul/bmXIpMIR25y82FALOtTLO7TUtNjdiuWzqqfm6G29q0Q7e6+ZYifd6PW8r4
 hUQWMQLyvSdE9bKsgeXmCrd4fiAv9iCQYrqa1nliHviDRyNff1oJkJ7RgSUP5XmzED2X
 DXmD+nPWC3Ruap/9JTsvjiM5GG5UZVkP1NvMmB7F01Hs8ZLpXKL7S2m8GHjvHIrfTHtP
 EtxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbimsGJx5D8IruD8Ddq5ToRimKio7bBDUWUlmlV2HS9QfnZL3U76cSE1QMoIw34SChurOeZPtusZer@nongnu.org
X-Gm-Message-State: AOJu0Yxz9y1UrJBfRj/mVtyf7ToWlI5PJDYTSAbukVOT/8VKPWutVr73
 uw8hvJ6dSClNYGIC+7nZtG7bq4Rdrss6RRxpY7qbt3UGncjYB7MEhWEFG421NtoD/3OUDw10tyt
 DzOCgIlLvs+v4byUMieeiC36IB7VjjlAfU3feu4JT2BR4829gh3EzJzpE
X-Gm-Gg: AZuq6aKxAy0EobXWOAA7iMJWn+4Q2khXjywOvb9Z7PqH5J+w/C2dtsMiP6/DykTsOaE
 A1eSL1IwXEJ/lQ7pql7clrUMIhi8KdgA3AnE4u6j6V+gFuKMRWjN4DK6Mn+/WjLR5YGOtc7d0w+
 RCRv2W5SFsgj7byrK1hPBQilz4QKb5oIuwgI1EolJUXKxGNZ/qOVHR3FSGb4f4FZmJoJmKdWpAU
 eG73acirfbmat7hHT41QuGvyLUGSubLYpOvJGPugZq2HUMjplFgmxnqV9QpjIRl96Bqo7Uso+Kr
 S7MyrgkRpzpqw89xF4QC8tKWf2ayuPMFfrGJHyRiWSQ3VGay6fWp2cKL9mEuz5BVZE9XxBIb1Pv
 khlpngtP8hP6HF1ByKPz/cy9OaU3fa3Ai6KJnwhMfcfsj5gnw
X-Received: by 2002:a05:600c:4586:b0:477:6d96:b3c8 with SMTP id
 5b1f17b1804b1-48026040621mr155327115e9.23.1768984143283; 
 Wed, 21 Jan 2026 00:29:03 -0800 (PST)
X-Received: by 2002:a05:600c:4586:b0:477:6d96:b3c8 with SMTP id
 5b1f17b1804b1-48026040621mr155326735e9.23.1768984142813; 
 Wed, 21 Jan 2026 00:29:02 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921df9sm35523024f8f.3.2026.01.21.00.29.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jan 2026 00:29:02 -0800 (PST)
Message-ID: <cf51bbe9-6029-40b5-870b-49a3c6fd59f7@redhat.com>
Date: Wed, 21 Jan 2026 09:29:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] linux-headers: Update to Linux v6.19-rc1
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex@shazbot.org, cohuck@redhat.com, nicolinc@nvidia.com,
 nathanc@nvidia.com, mochs@nvidia.com, jgg@nvidia.com,
 jonathan.cameron@huawei.com, zhenzhong.duan@intel.com,
 vivek.kasireddy@intel.com, kjaju@nvidia.com
References: <20260116092950.15796-1-skolothumtho@nvidia.com>
 <20260116092950.15796-2-skolothumtho@nvidia.com>
 <20260120135151-mutt-send-email-mst@kernel.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260120135151-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/20/26 19:52, Michael S. Tsirkin wrote:
> On Fri, Jan 16, 2026 at 09:29:46AM +0000, Shameer Kolothum wrote:
>> Mainly for adding support for VFIO DMABUF. While at it, update all
>> headers.
>>
>> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> 
> This breaks bisect (next patch fixes build).
> Pls come up with some way to avoid such breakage.

I missed that.

I am dropping the series from vfio-next. This needs to be resolved
first.

Thanks,

C.


