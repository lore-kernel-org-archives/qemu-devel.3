Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A0CC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whT5j-0007eM-5a; Wed, 08 Jul 2026 10:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1whT5Z-0007VQ-F6
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:17:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1whT5X-0005YI-VL
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783520241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n59jMt2lctejhvE9sQWjQSAcIDnSAtinJezXAj4dDNs=;
 b=cWplpHizTQ0Juv52AsUetTRz5kqB2pnHlRvDGubfc03iTJZPJnTSdPnnNXkv+fiuzbGRiy
 IK1ch2AcJpxM+xRzHqfnhWkhomgnn/BjachciPOgOhbfTE408nAFdQ2YeqRA2rexqpFMyp
 GJ9lmGoyLTDNJ357DEtY7GuD1xjIzw8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-n2nWo4RMM4SMRQLy_t5gDA-1; Wed, 08 Jul 2026 10:17:20 -0400
X-MC-Unique: n2nWo4RMM4SMRQLy_t5gDA-1
X-Mimecast-MFC-AGG-ID: n2nWo4RMM4SMRQLy_t5gDA_1783520239
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493b21b1fe8so5915635e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783520239; x=1784125039; darn=nongnu.org;
 h=content-type:mime-version:references:message-id:in-reply-to:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n59jMt2lctejhvE9sQWjQSAcIDnSAtinJezXAj4dDNs=;
 b=qlMvM+VGsIe5B4M4waZK/5aTOTFHl/Cjlsg/6zN13Uvy14FjET9OKtW24wOVWs0+vT
 oML8YOo04F582jpn+VQi8fmd1l81A9FIY39hRf4ZEqmIYxIOrtL6ZuSbuef8iUvJNYZY
 /w/BBjAsHEBl+EjyHGyQEWaeicoJZoo6BWxTflOtG7mZHxNWlECZRSTEZkkHn++jNlID
 1NoU23tH2gJpXmtLftkYmR9qu0zRwIt7TMFUxod3Q4v+j//VjXbYEWAFptAFaFpMdHAx
 V/e8Tl8WhmTWItH0iC2pkEwsivYd/B7oc6pD5vUeFWH+Nj8vjEYQ5azvk8poRoNTGHia
 dl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783520239; x=1784125039;
 h=content-type:mime-version:references:message-id:in-reply-to:subject
 :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n59jMt2lctejhvE9sQWjQSAcIDnSAtinJezXAj4dDNs=;
 b=ZslUxhOFekKhiDlTKQSKNMNImP8uXC0ohE4NOyJF6VEz2O4HtCIsh3fJfsAXVm/EKl
 Jqxuq0FOu+EOgVEJkWwyKrRfLud0CbAshJuhoOc63Tmc5Zjvy8y2GDHKlE4nL5Vk+neq
 LxAxPnb6l8RQGpqe9XybowIi6i2BywiKyb4ZECL+wamETDUnby+TBhL3m4xSD/UFOQ8X
 X77mX69rtAd3Wde6qIIuUJ+L20g2pNr6KmPGRNK21HYpo7XiJb/C3hp7Dwl5wJO5Jga+
 ZlylSfNU1Y1Fx6KlAJB2HWJa+Aum16SrVlqX39UEPQkWZZctZFaIZFjwESZejp0fZhsi
 BMsQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Roc4tcVFGRsXf9Hgj8Aa0Lwm4EwwlqBUesiHlN9ORv9n3vrcQqN00Ak8ZVfTuVYjt/pfE4V1o3p0AtA@nongnu.org
X-Gm-Message-State: AOJu0YxCBO/2Y++1vrTJ6mRFhk9Cxl+Tkc7I3WVdyCJUhhkzN5YXTq/2
 ZPnIHePFGAYwNE2Z3rsqx4mZG2NGadlY8a99wAiV104HoKMycDhJSBc13rnZtgm6xZT8WchNuBg
 0JncOw9siEv/2dqc2vBfHoiSG/G2tZYqKUeKQpwjXx2CCVd3XKfhgJb71
X-Gm-Gg: AfdE7cnGhAEbuNRPha4P3bDJ8Ouw1jqPdxOeM/mbfFyqKigIioBMvhmG7xp6kg+gNuq
 L+iZmfPl3XA5STkUUehuATYOGnZhB20ZsPLAo3LUjTfzOTMHVAAkds7Wy9+oZ2+CQLgdoNUz245
 jrQKP/VPVc5di7TXVH41qwhYeNLMm6Jtm+k0tDhhAk4d5Ea472eoFWCfID/Sbb4BgAhIAQ9Z00+
 7FlbEFDJr099ik8igl4YNj1vnbfTfhCyGBJeB8Ffiu4rNVtQ0hQKbJzmjDJBAu0EoUVhXUf5j7V
 nFCxiGT0ht2HkYABXrDwbgB27IqS4dk+VM7mtCr75f7/cJ851r1ZjeN8g4KVq/D/VUdJPecrBci
 Ls59UyIQnNBnb3CM5tE3J2TMmc67Kz3yEO2vk3fP2aRPWA4VO9Kct9N8Li8VE
X-Received: by 2002:a05:600c:c4a7:b0:493:c845:bc20 with SMTP id
 5b1f17b1804b1-493e688c7c9mr28112355e9.4.1783520238823; 
 Wed, 08 Jul 2026 07:17:18 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a7:b0:493:c845:bc20 with SMTP id
 5b1f17b1804b1-493e688c7c9mr28111925e9.4.1783520238390; 
 Wed, 08 Jul 2026 07:17:18 -0700 (PDT)
Received: from rh (p200300f6af371400309b667846b924fb.dip0.t-ipconnect.de.
 [2003:f6:af37:1400:309b:6678:46b9:24fb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e5a6240fsm46592525e9.2.2026.07.08.07.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 07:17:17 -0700 (PDT)
Date: Wed, 8 Jul 2026 16:17:16 +0200 (CEST)
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
Message-ID: <9673dc6e-a15c-69bd-0850-5eced2174f17@redhat.com>
References: <20260702133606.34529-1-sebott@redhat.com>
 <20260702133606.34529-4-sebott@redhat.com>
 <7ab742c2-2354-4316-a727-a56175a321b9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> ccsidr[i] initialized from KVM before?

Nope. They were not.

> What is the actual motivation to read them in this series.

Consistency I guess. Qemu maintains a view of the register values as
seen by the guest. This patch does the same for the demuxed regs.

> Doesn't it bring the risk to expose new values to the guest?

I don't see how. We obtain register values from kvm, we don't modify
them nor write them back.

>
> For instance, in [RFC PATCH v6 11/17] arm/kvm: Initialize all writable
> ID registers from host, I generalized the initialization of all writable
> id regs and I noticed that the new initialization of CLIDR from KVM
> broke the execution (which is not the case for the CCSIDR because I did
> it a try) because CLIDR was previously uninitialized and null.

I'm currently playing around with that..

Thanks,
Sebastian


