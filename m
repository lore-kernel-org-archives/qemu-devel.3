Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F37D1BDD9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 18:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t81cM-0002gy-Ns; Mon, 04 Nov 2024 13:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t81c3-0002Ww-Vt
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 13:15:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t81c1-0004yq-CV
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 13:15:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730744135;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lBmPx7J81kPDhku9+xjmgrgbxAjE1ApCT3Q/Pe7qD4o=;
 b=V0Q7b4HeHI1zWgIvSPlqfjtl4VVdV+ej5Zos2UM//I+aN3uFyzK1W5nLJwJoWzcKU/gWxY
 2Of6HUNbzZbgsqZsXGPqYlvRHpRc1gyPg39qy1mzTLdev13hSQuIlLZy7bqAlQQpU33HMm
 Nx6sX/jl0dX4EHyukoypW5b0znmryCM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-ZUdRDRkwPVCTwIvDbHkhgw-1; Mon, 04 Nov 2024 13:15:34 -0500
X-MC-Unique: ZUdRDRkwPVCTwIvDbHkhgw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d458087c0so3385261f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 10:15:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730744133; x=1731348933;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lBmPx7J81kPDhku9+xjmgrgbxAjE1ApCT3Q/Pe7qD4o=;
 b=MN7TkCfu53qZO2JwE6aTuxhyAlO0UEDTThPPZy0V6K+ncAHBxm+TzWKWENIISdRCk/
 /bRrglYbU5kVPg/Bi2XZFqJyAFzrbppqznXbeDCDJRGbAWi5oSeHJ1ffbmOgVINqQxpG
 TdCaJMuB0M+zQ1rWxue4V7gQiR5dhse1Xw/KTbXciZ0/SquJsfg86a6bBZyhXKultcY1
 sUAk3D+m7K9S28gDgzte5Ylufssa7pOKSHvxr9JeuBBx+4syM9ea8g7B/Hk/xaHz7Vnh
 x5jjT2z0brSasL97J6F8RRPZ69KiPUUqN9GpbtLG0S55YGQdMPu/BDjnjEC44Vcskq+w
 35Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXkTBp1EzNqDBlrb1jxF3UdJklCCvALjkvjYbiitAuVdk2X8R2X81iYV2o7sLq8XisOxHUh93/E6TA@nongnu.org
X-Gm-Message-State: AOJu0Yzt2cM0bkSpprV+dWcwQ/OkEaDm6+faJLN/NOvY2kpuGvPfYhrM
 sEIn6Us9HzZctsgg0mKOyfLEtNtiQjfyfl4DuaHpclQQS5wLIoY0idfAEqBk5Mhy7t+Q5jJbUhq
 hvjiRi2lXv/GWXMoESGamOm3QEnKqmCznPswPpfW5C/uEPsXV4vQZ
X-Received: by 2002:a5d:47ac:0:b0:37c:fdc8:77ab with SMTP id
 ffacd0b85a97d-381c7973202mr11463765f8f.7.1730744133002; 
 Mon, 04 Nov 2024 10:15:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0xxiT0gNzh7c1eBS3/tOiILacXPaDItLf/SGOxQ5FHjMTBEFHqhkRjrtudfCG35tsJSGMPg==
X-Received: by 2002:a5d:47ac:0:b0:37c:fdc8:77ab with SMTP id
 ffacd0b85a97d-381c7973202mr11463740f8f.7.1730744132625; 
 Mon, 04 Nov 2024 10:15:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a153125asm1938525e9.2.2024.11.04.10.15.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 10:15:31 -0800 (PST)
Message-ID: <d275b86b-75d0-40a4-90b6-b519748ccc5f@redhat.com>
Date: Mon, 4 Nov 2024 19:15:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 18/21] arm/cpu: Introduce a customizable kvm host cpu model
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Oliver Upton <oliver.upton@linux.dev>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 eric.auger.pro@gmail.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, shahuang@redhat.com,
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-19-eric.auger@redhat.com>
 <ZxuX4i9NjVRizB72@redhat.com>
 <cb6c8f62-c5dc-416d-865f-fbdf96164dac@redhat.com>
 <Zxub7ol4p8P_sWF8@redhat.com>
 <CAFEAcA_wQu17y0PyQwxw0wuf2H5y2VE5aX16nLP2-u7QUP2ggA@mail.gmail.com>
 <Zx-9WxXkmkMuGIlQ@redhat.com>
 <CAFEAcA9w0mb5bcU8p+fScQony-=oqLmNurGWpnL_sBneQCzxUg@mail.gmail.com>
 <Zx_CU9eeQByANMRW@linux.dev>
 <6c05fc4e-ce14-4000-bb2a-63496bce9e98@redhat.com>
 <CAFEAcA_XhkBrco=V3Ky+cgvyp3cwqHXjDkmm+dP7N2B2av03bA@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA_XhkBrco=V3Ky+cgvyp3cwqHXjDkmm+dP7N2B2av03bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

On 11/4/24 18:16, Peter Maydell wrote:
> On Mon, 4 Nov 2024 at 17:09, Eric Auger <eric.auger@redhat.com> wrote:
>> Was just wondering if all the writable ID reg fields were associated to
>> an official FEAT_ listed in this feature list.
>> Let's take for instance CTR_EL0.DIC. Is it associated to a given
>> extension or is it just implementation defined?
> CTR_EL0.DIC is IMPDEF choice of 0 or 1. There's no associated
> FEAT_* -- as an implementation, you are effectively just
> reporting here what your implementation's properties are.
>
> (CTR_EL0 is not an ID register in the architectural sense.)

thank you for the confirmation. So this means we also need to be able to
tune such bit although it does not have any fellow FEAT_*.

Eric
>
> thanks
> -- PMM
>


