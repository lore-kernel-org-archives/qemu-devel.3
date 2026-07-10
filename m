Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E086DC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAsC-0006pT-Fz; Fri, 10 Jul 2026 09:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wiArM-00068l-Eq
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:01:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wiArJ-00062T-9U
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783688494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8yrNmqM1rUndTJ0w8K8WVuBrkzlm+ae3LiH8cPhp8Mo=;
 b=Oz0KE+kMMRJkWAieZTgUsxJUQXR53MX4YGQWIqm80kAygNBdOq6h0882zCUFgS4Mooo1tZ
 iKPVLF5Gs/2i3AlSYep8uFFX76yP5xj9PYBPkxXoHkvdQuiLCJCac5DVUlXv6Q8z8p6Ecr
 ySY0fLQSiMyKqSDpzHwJWtSztMYKaKo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-hDHWq8WhPmOm-NG4Z5XRWw-1; Fri, 10 Jul 2026 09:01:32 -0400
X-MC-Unique: hDHWq8WhPmOm-NG4Z5XRWw-1
X-Mimecast-MFC-AGG-ID: hDHWq8WhPmOm-NG4Z5XRWw_1783688491
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-475eba52438so831263f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783688491; x=1784293291; darn=nongnu.org;
 h=content-type:mime-version:references:message-id:in-reply-to:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8yrNmqM1rUndTJ0w8K8WVuBrkzlm+ae3LiH8cPhp8Mo=;
 b=cQdyroCrY5HdmkFYAopFabS19Xk4g/kQQ7TPMVyNxLeiVhAP/A7Rp3mUYDGs7jR1hv
 LcfI7csy7/CYfM/vAbYfR/34MmopHJ/DCU9c/xQW9jF257zEjgC0jn0zyU94yZ1loAZy
 kQC4PEkEWTeVILu7R5gqTtMNz+UeZmyr7+zKwGsD7I+Cm58bLgD+/D4DMIGOLG5VXx4U
 /u3dPkAN7SFjANA3CUqGAWOK15TTsQnQsRriPA/cfg5dLqiMAVMa1jlsYirJmlovPIjI
 hxPR63l4djF0cDtxkd1BJkbx+nBRPkuniApmPAVvzNFJduoX5feMEG15x2rcA/xws6t3
 n72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783688491; x=1784293291;
 h=content-type:mime-version:references:message-id:in-reply-to:subject
 :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8yrNmqM1rUndTJ0w8K8WVuBrkzlm+ae3LiH8cPhp8Mo=;
 b=qo4EHvOExtQQaPVJj/Rt0CTQ4CXyJFq/ZecgwYHR88MDWcMeJo+yx+TTq1XrDAnxcT
 urvCgFbMXRnjPNl1oqO9taPmkaxNlGHbbr+MKXnxhAe6Tw7KrFSNgLnssbvF6VVgo1Mk
 2EfMKAwZrlH5gLWwiEirB69ec2DM9ViauHt6tf+diTGtIALX+De0QBsYpnCgHEn5vRPU
 AC+Df5qIhvk8fgeqrAUZgiAJnjszayKJqIsfoddAWb7WLhx6vCsyW9dutCy5IPMrpwbw
 5knJqIZFtxPZ468SBjMcUwJWKpJmS1ZEXZiGQPcIqk5mQkJvjkqq9ASjM9/rX623gUwv
 mirw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr6AAwVcWfA6xJOcOZAxdzENgHWbgE0EmoEjp0YjbuhIeT/ToXwFA4RsZTsrvyV837UzU41+trfDRa5@nongnu.org
X-Gm-Message-State: AOJu0Yx+uHMtV3Q+D14TjRrCaU+BKVKMYui2pmlerv0S1a0yZX1XEa61
 xUw8hsUCYALmFsfLtwXZ8F9Uxr9s0ky07HHAeLSV6bPM1sd9f2gU9MqOqfX99fROWbb/XyWf80O
 Tg0cJiBp15wiAeKcRbkF+Ql6Ub0eVfFABgDAZunYaAnCF9eXAF70e4OSU
X-Gm-Gg: AfdE7cmFr3P+YU1slO4y5fYvZfBXUTnQoxXVI6SvPy2q7amUR7C52JSUvYTcvBbUE8+
 o2NDT9JB/jJ90+iEjsYxOsQTBHntBZLSt9005JF/hsJMTCCZC9NNTUpwOCAny3c78Johoedwltq
 oNju99xNo87nZqHYLadkdOog7yIRmaPty2mxLIhzDGpmS8nT/WvFVupGWtfoFZ0R3jpoecIDl7T
 0hPV1uwjSsbUWC+NKjVYhD5s767cT5UEqPtfAuKWM7dRaSzAZUGqPqy/HJiApJRrc3bsS7AI5k5
 XSbbw1YA4rDHwg5OBT0kbuQc2c5tSoBaeUcME8fXxTtfaNT6gLjrY1jbX9uaQkD1HxcmLE16bsb
 Od5eDuFTpdZNLRndbToE2rEdPCBiPcoTevwitpss7tmP0rUMPhJVRh9R8b+lt
X-Received: by 2002:a05:6000:1861:b0:47d:edb2:a4ab with SMTP id
 ffacd0b85a97d-47df07670c6mr12539010f8f.43.1783688488271; 
 Fri, 10 Jul 2026 06:01:28 -0700 (PDT)
X-Received: by 2002:a05:6000:1861:b0:47d:edb2:a4ab with SMTP id
 ffacd0b85a97d-47df07670c6mr12538420f8f.43.1783688482704; 
 Fri, 10 Jul 2026 06:01:22 -0700 (PDT)
Received: from rh (p200300f6af371400309b667846b924fb.dip0.t-ipconnect.de.
 [2003:f6:af37:1400:309b:6678:46b9:24fb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e6ccsm60023847f8f.5.2026.07.10.06.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 06:01:22 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:01:20 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eauger@redhat.com>
cc: Peter Maydell <peter.maydell@linaro.org>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Alireza Sanaee <alireza.sanaee@huawei.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 3/3] arm/kvm: get demuxed ID registers from kvm
In-Reply-To: <7ab742c2-2354-4316-a727-a56175a321b9@redhat.com>
Message-ID: <0a463fde-b206-cafb-8625-e03bb5d1ce58@redhat.com>
References: <20260702133606.34529-1-sebott@redhat.com>
 <20260702133606.34529-4-sebott@redhat.com>
 <7ab742c2-2354-4316-a727-a56175a321b9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hej Eric,

On Tue, 7 Jul 2026, Eric Auger wrote:
> On 7/2/26 3:36 PM, Sebastian Ott wrote:
>> From: Cornelia Huck <cohuck@redhat.com>
>>
>> We now have the infrastructure in place to handle demuxed ID registers
>> from kvm. Use it to get the values that kvm emulates for CCSIDR_EL1.
>
> I wonder whether that patch is needed at this point. Were previous
> ccsidr[i] initialized from KVM before? What is the actual motivation to
> read them in this series. Doesn't it bring the risk to expose new values
> to the guest?
>
> For instance, in [RFC PATCH v6 11/17] arm/kvm: Initialize all writable
> ID registers from host, I generalized the initialization of all writable
> id regs and I noticed that the new initialization of CLIDR from KVM
> broke the execution (which is not the case for the CCSIDR because I did
> it a try) because CLIDR was previously uninitialized and null.

The issue is holes in arm64_id_regs[] and we stumble over that in
get_host_cpu_idregs(). Maybe we could skip the demuxed regs when we
iterate over that array.

Sebastian


