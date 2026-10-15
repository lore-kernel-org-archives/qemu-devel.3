Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8509CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHM5n-0006Z2-2P; Thu, 15 Oct 2026 10:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHM5j-0006Yb-TZ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 10:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHM5h-0002OV-Mi
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 10:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792073153;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ro4VReCJbMXDDulID/D345/NuyZnyk0gEdYTf6PdAuE=;
 b=DH61S91ks5xU9Zu8x/HNJFbLjgUblBkDMvXLa7AvtECf3838ieRtjrCOPEUa67xOwX21Rj
 kOZmJYkb6c+CGzd4/TWCIZlUz03cB2A0HxipWc1mUMnJRGiw6zm2MT40PTa4bDqcPuj+rC
 5VH1oPtylMeH9v5ozwi71CBKdVExZWg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-z--7IRBrMbeQG2vptccERA-1; Thu, 15 Oct 2026 14:05:49 +0000
X-MC-Unique: z--7IRBrMbeQG2vptccERA-1
X-Mimecast-MFC-AGG-ID: z--7IRBrMbeQG2vptccERA_1792073149
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a1ad49096fso66855e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 07:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792073148; x=1792677948;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ro4VReCJbMXDDulID/D345/NuyZnyk0gEdYTf6PdAuE=;
 b=qW1FR3ZVrPY3ZsiNU4noDTbJmvNlSgE08qhZqJib7+tKE1UJfNZKkL+kpRALdnqaXR
 ExgyN4Sbl56BvMH7WqP4KSQv/i+8gMxQHzCanutn1sNdhg1Y68ZzFPZ1qji+6gaVFRte
 8bNXW3wcvkNgmmCXhWGRMPUU3NIxlqtmNJaattmOhDF2HFE5URHEfonKI4wM9GIzEEap
 +WzOkRxi60QtDXgsguTu8mqdeU8eoY0OszvOMXDR/TfIJ/CbV31G6lgTFsxFs1bw0/w6
 3oKtyUZFqipm353uUOYJvwyTfpwfCWC8b+6R2FDwMPY1xKyXAw43GuYWzni2aT2UhIps
 HZww==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwaE4Yf+7CDcpO3cKESfV71SCZYFZLYE8KBDBVfkyNqT0hClrYl2Kh1drz9qNma7YvxK7YkXFLr+R9@nongnu.org
X-Gm-Message-State: AFq9FYIy3ScGfDWD4ZiqrrIwwVtK4pjndpMW4y2EuEflmroeD8PRIjvV
 OQ7K4hOsOwRrpYfeDT3FR535opX+KLD76lDLUivwUeKJPAaZXbGfCnuueVErmUutplt4pfbeFD/
 ak9qV6xmRMdDylWNTohauIMmnE9jXtVPo4pC3tFTlzxBgdbplO+l80sVO
X-Gm-Gg: AYBFou2mLHs3U81KwyT98xKuv1t3KxJCbDpn+GhI4lgm4IKIti1CcaW27I3XNqZsazu
 ahzZHry2OMC6cXLDwFdisHcnyfsDTJElAPefJD5iDZhkRLJmiEU/kF4dI/wxQJztTLEd4KAaLKu
 9nIrpYcUg0P6C5e+VDqOepOYA+zNSXVMzLGpW4cM6sUj4KDm4RV9SVHxoDDxcelsshVorPyfh7n
 GeuT8YGVDKWVKZpr+YesUkwEX3TINhOEcQr4ngZAdL37Gs78emz7l8iOQSXPy3JWsdEQrPB0kS1
 sljV9Eb39VcR4hmF7iF1ojH1+GmzCxxscML3YX9e/U3X9c7f5f2R8ARksOs6Wbjnhj6ZdbKRJ+3
 9TueHmxC3HPoT7x4YK/tABqgKJlKtMprnc14uRGNVcaT/PxkT
X-Received: by 2002:a05:600c:2154:b0:4a1:ac66:604b with SMTP id
 5b1f17b1804b1-4a1c6635d20mr2234385e9.1.1792073148399; 
 Thu, 15 Oct 2026 07:05:48 -0700 (PDT)
X-Received: by 2002:a05:600c:2154:b0:4a1:ac66:604b with SMTP id
 5b1f17b1804b1-4a1c6635d20mr2233835e9.1.1792073147927; 
 Thu, 15 Oct 2026 07:05:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd6428b3sm67859615e9.1.2026.10.15.07.05.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 07:05:47 -0700 (PDT)
Message-ID: <a1245318-1843-45c8-9822-bea483a3e660@redhat.com>
Date: Thu, 15 Oct 2026 16:05:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 14/25] target/arm: add neoverse-v2-v2 named CPU
 model
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Khushit Shah <khushit.shah@nutanix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, cohuck@redhat.com,
 richard.henderson@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 gshan@redhat.com, skolothumtho@nvidia.com, sebott@redhat.com,
 armbru@redhat.com, philmd@linaro.org, yangjinqian1@huawei.com,
 shaju.abraham@nutanix.com, mark.caveayland@nutanix.com,
 ping@khushitshah.com, sandesh.patel@nutanix.com
References: <20260921123249.1708067-1-khushit.shah@nutanix.com>
 <20260921123249.1708067-15-khushit.shah@nutanix.com>
 <395b66c9-4173-401b-b469-8972b710aae2@redhat.com>
 <CAFEAcA8DcLLYJeE_NUKrFTKfYvHp+6YYAmCdZnBfz2AjRNDnzw@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA8DcLLYJeE_NUKrFTKfYvHp+6YYAmCdZnBfz2AjRNDnzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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



On 10/15/26 2:22 PM, Peter Maydell wrote:
> On Thu, 15 Oct 2026 at 13:13, Eric Auger <eric.auger@redhat.com> wrote:
>> Hi Khushit,
>>
>> On 9/21/26 2:32 PM, Khushit Shah wrote:
>>> Add a KVM-only named CPU model for Neoverse V2 r0p1 (TRM 102375),
>>> inheriting from neoverse-v2-v1 (r0p0).
>>>
>>> r0p1 only changes MIDR_EL1.Revision and adds FEAT_ECBHB
>>> (ID_AA64MMFR1_EL1.ECBHB).
>>>  static const ArmNamedCpuModel arm_cpu_models[] = {
>>>      {"arm-v9.0-a-v1", NULL, arm_v9_0_a_v1_props},
>>>      {"neoverse-v2-v1", "arm-v9.0-a-v1", neoverse_v2_v1_props},
>>> +    {"neoverse-v2-v2", "neoverse-v2-v1", neoverse_v2_v2_props},
>> nit I would call it directly neoverse-v2-r0p1 and leave the -v<n> suffix
>> for potential fixes. Same for r0p0 obviously.
> I'm not very enthusiastic about accumulating different CPU models
> for all the different rXpY variations that appear. We used to have
> a ton of basically identical pxa720 variants and I was glad to be
> able to drop those when we deprecated-and-dropped the pxa support.
>
> Is any user actually going to care about the difference between
> r0p0 and r0p1 ? In particular pX changes are just hardware
> bugfixes that QEMU was unlikely to be modelling in the first place.
I do agree. In terms of ID reg, there is very little difference between
both. Modeling a single one may be sufficient

Thanks

Eric
>
> thanks
> -- PMM
>


