Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4DBC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whrVQ-0007aV-BJ; Thu, 09 Jul 2026 12:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1whrVO-0007aA-Fs
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:21:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1whrVM-0000T4-EE
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783614099;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JvSpfn16PCI7AVGm8bjsYoTTW8RjAvf/luRTkR4f58s=;
 b=PuYzKpMPldxb7mWAHqb9T4oetIpb2SRYCX4II/VZjjiYe4sZEubd1/8fXtT9SixbUNQAau
 kktkSbUKb73JjBJls5NYsObzLdJs1qlmvAve6O6pNbxNHFlH5CdKOJYE7HjPQBpkrbx7V1
 U4INBkFi4wo456WtofLPO4xwW/r9Vw0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-ZLbykzHlMjmbuks6vluBkA-1; Thu, 09 Jul 2026 12:21:37 -0400
X-MC-Unique: ZLbykzHlMjmbuks6vluBkA-1
X-Mimecast-MFC-AGG-ID: ZLbykzHlMjmbuks6vluBkA_1783614097
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493d742c668so17401935e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 09:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783614097; x=1784218897;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JvSpfn16PCI7AVGm8bjsYoTTW8RjAvf/luRTkR4f58s=;
 b=C5u70GuwIZS66a47cjfG6ifSRCDQPYcY8a2MpynFNN7gGQzJhjaqoDB/3jPjqXx10L
 MGUNWlhw3brmlUPD7vEOfyZVKdEdHHaZEBPTCAcuwkJ99a4VaCRhwylqXBJK2YO6D0jd
 tgVTVWjFalv1s9ka6EmpALSp5fkwMrwTkVy5xDuXkoN7pEEL+oSI+NklmKl5fPM45YpP
 LNDuLrbXPv3+Pl3UcM8sRwS8paX/w6IIRgm81mUoJFEovhjF0rA8SGFsq89rokzQTVtB
 +mdqx3XD8yPI4exX6nbYLcTzrdiuoQ/iRPmKVzhS/7PseHHqgYCoWIMJi38St4u5HlT2
 0wYA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp6QAcJc9fVpJf7bv4PIcKWlXFUiH3DLtXaFsiKlbtTXQ2tnBaazd5QEbGDm4ihm/25r5GnteS2Y2ve@nongnu.org
X-Gm-Message-State: AOJu0YxaWCw1YYrISo9w+1ZkR77R2UWxOV6M6K6wM2eWlcFeoLYF2Ume
 htMST2m49NrEbd8Laoq55czLUbcoB+LJQ0KRwtXVqi4ULDM4SUWAR06VSzVe96QmTcV5DO0iWr4
 z/JK8dxlYz3gAFurIEoz5NLSa2XnMg8f/CesVQNrk9Pn+kYJW2pdXSU8t
X-Gm-Gg: AfdE7cnSHn45l0NjoW/OQlHjS3HFwtGJxJlyeufba/bbBbv1cSwahfkYinF7I+coz+1
 UzGDWXUByHDYGNFtsQW0Qb9mFLm0YUDF6oVBMmizP43EpJYh4xwWVAs55ijqrHcNuRVYIApygYU
 CTpCRplLwrZlm/ZVWSMVeFKGLOQ2om3y8jDu8nIbmDs1uyaTHx6DybJ8iM0zE2oc9PSN+7ZgKsq
 uxxfeCotgwNMgkLNc9ykLBwAJZsnbhbLZupm/EFm9+C4MkMbJVI19/i/Vvkm0JI7aHbFo1FZvhX
 4XbUAzDnw1FjZAQ5ffvFcO+zxqKPX526Dm2y9NvTgxE9ozCmXFeFYNDNHC9ZBGvLSk/TXjPEZ0C
 90dZeqP1pe0L3msHeOyeNGchpdK0TfgykW3T8/Y/22rrSzxTq8nsgW3fgjcB+VQ==
X-Received: by 2002:a05:600c:4505:b0:490:b189:212d with SMTP id
 5b1f17b1804b1-493e68791demr78227335e9.33.1783614096621; 
 Thu, 09 Jul 2026 09:21:36 -0700 (PDT)
X-Received: by 2002:a05:600c:4505:b0:490:b189:212d with SMTP id
 5b1f17b1804b1-493e68791demr78226965e9.33.1783614096215; 
 Thu, 09 Jul 2026 09:21:36 -0700 (PDT)
Received: from ?IPV6:2a01:cb1c:263:8800:8714:9136:d3b4:25b3?
 ([2a01:cb1c:263:8800:8714:9136:d3b4:25b3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f16cfsm75008115e9.12.2026.07.09.09.21.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 09:21:35 -0700 (PDT)
Message-ID: <74be1bcf-91bf-4471-a34f-75bbd317bd64@redhat.com>
Date: Thu, 9 Jul 2026 18:21:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/tegra241-cmdqv: Do not sync GERRORN on VCMDQ
 allocation
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>
References: <20260707112450.111178-1-skolothumtho@nvidia.com>
 <5161e394-4f41-4fe4-af83-1c0993758442@redhat.com>
 <PH7PR12MB8593CB26D92493FE0EF0C3EEABFE2@PH7PR12MB8593.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <PH7PR12MB8593CB26D92493FE0EF0C3EEABFE2@PH7PR12MB8593.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/9/26 5:15 PM, Shameer Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 09 July 2026 15:51
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; Nicolin Chen <nicolinc@nvidia.com>; Nathan
>> Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jiandi An
>> <jan@nvidia.com>
>> Subject: Re: [PATCH] hw/arm/tegra241-cmdqv: Do not sync GERRORN on
>> VCMDQ allocation
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Shameer,
>>
>> On 7/7/26 1:24 PM, Shameer Kolothum wrote:
>>> When a guest hits a command error, the hardware sets GERROR and the
>> guest
>>> acknowledges it by writing GERRORN to match. These registers use toggle
>>> semantics, and since GERROR is read-only, both GERROR and GERRORN may
>>> remain set after an error has been handled. As long as they stay equal
>>> there is no pending error, so a subsequent VM is unaffected.
>>>
>>> When a new VM starts, QEMU allocates the hardware VCMDQ and flushes
>> its
>>> cached GERRORN of zero, while the hardware may still have both GERROR
>> and
>>> GERRORN set from an error the previous guest acknowledged. This makes
>> them
>>> differ again, so the hardware sees a pending error and stall the VCMDQ,
>>> leading to CMD_SYNC timeouts.
>>>
>>> Do not sync GERRORN when allocating a hardware VCMDQ.
>> One question: I see cmdqv->vcmdq_gerror[index] is likely to be set in
>> tegra241_cmdqv_setup_vcmdq(). Don't we have a risk to silence one
>> pre-existing error?
> Hmm..don't think so.
>
> vcmdq_gerror[index] is set only to report CMDQ_INIT_ERR when hardware
> queue allocation fails, meaning no hardware VCMDQ exists at that point.
> It is intentionally cleared after a successful allocation because the
> allocation error no longer applies.

OK. thanks for checking. Effectively we return and do not sync in that
case. there is no other cache sync call site so that's OK.

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
>
> Once the hardware VCMDQ is allocated, GERROR and GERRORN accesses are
> backed directly by hardware. Since QEMU no longer overwrites GERRORN,
> any pending hardware error where GERROR and GERRORN differ remains
> visible to the guest.
>
> I can’t think of any relevant corner case issue here, though I may be missing
> something.

Sounds good.

Eric


>
> Thanks,
> Shameer


