Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E430C982CC
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6rhk-0001fM-3N; Wed, 16 Sep 2026 11:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1x6rhj-0001ez-B0
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1x6rhh-0003Kn-Ql
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789573064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vSAynfvsOSukGpzaqAs0KqHS2LOd6h6pm2e8ic0McA4=;
 b=Z75sRUY5Sc9bzCTwNoQW1l4CEdPunolQ7Ws4l6SxIExwnmH7/hWcc08BzQKO0zffEsUK5v
 gl1Zr3x2F2n4WB+uAzx1Te2UxxAwxffwrCkZPnHkRi9UdrbZXY8LevepQbpAqPhxVWYN9o
 i7arwuva9fjSNvAD/UW5q4XJ7RR7j1U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-cw4-zEFVPKmlVGv0zNHxYw-1; Wed, 16 Sep 2026 11:37:40 -0400
X-MC-Unique: cw4-zEFVPKmlVGv0zNHxYw-1
X-Mimecast-MFC-AGG-ID: cw4-zEFVPKmlVGv0zNHxYw_1789573059
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-486f77056cfso3840167f8f.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 08:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789573059; x=1790177859; darn=nongnu.org;
 h=content-type:mime-version:references:message-id:in-reply-to:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vSAynfvsOSukGpzaqAs0KqHS2LOd6h6pm2e8ic0McA4=;
 b=QjBWBo/Pb9zxjRW2c4GZ8SNn40zQnHthwEsPVXXP1iMC4SrMD0YMdUJPp20E4dNPO0
 d6leFoBXb3S2CGFeTMeZvLMakgfExjECSrBLtKbMpcxc/xb71geGVOTzUnU6r7H+G9G8
 Oi4v9hxhgkYzHNdA++8A0f5ofozn6V7VFYcHzn7n2G7sk6ZElcs5lzWXnYyicXrf6ooS
 6FbHzybOWtGQFyvsUJ8NtXk9CEnLD2gUdbi5DKw+9WadPMR3n8LQSca4SyXda/FP2vIV
 wjh1gNuRRXiSIHtXwXBejrTBKnZvIRCpQ9K4O1Eu3/eaACThhIElQSLfEOHtsT0uXee8
 lNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789573059; x=1790177859;
 h=content-type:mime-version:references:message-id:in-reply-to:subject
 :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vSAynfvsOSukGpzaqAs0KqHS2LOd6h6pm2e8ic0McA4=;
 b=Uq2BVeY4t7G0XyCvO//W/7B03IBMAmQ/HLvszahZdBfzAA4q3Yxy1Kkf/UxckCBrEp
 1sNmr6mfUFMQdvqNPEr1NAJ6G5aiFHLIjWYBBvdEIQNAk+mfjDzM3q99jVT62pSYg1hr
 DVhb2UXM8X5xlujSDt/+1I7LFckpVj/4V21rYcA171XPhtYKcNYQ8G1oVqX/5op+ToYz
 rk4DxOiNhv4LbuQ2V177jfvZ8GquXjyb3EkXEdhJrgy8PqdMdZ7AQSmaLXGsDYLpNpqH
 Ivf1heOifW31FYEgW7ONsIy0jQLpYX8atuV0fcujY8z4SLYxrr+1RzvvUU8g5HQQdcIr
 trHw==
X-Forwarded-Encrypted: i=1;
 AKwUvByO/j/MrZSwBQROxN96+0kapLzzVhvzFs3AEx1HcUE98bHd/gHZM88SDcLHkD8IoS/ZMBXFGNcCG+Ws@nongnu.org
X-Gm-Message-State: AFuF++n1abphyjTreb656OAL0sYtLu2WNTJRqaf3zm2oXHViOdCvqXFM
 358PM29P14yMmqO/JloT31VRucBavC+alABDa8zQtKz++/rE815x2J+QV0crb7Ylglkx4bEjSbq
 omvnPqkM2uKKwO4Mm1ebIsZk9ZLa6KxENaZdc+SdXE5NmcLkxnFFasKqN
X-Gm-Gg: AYBFou0bJpeem/3f85DEa412U0udIXpbAiVoEqp482XUHBwuMG5bb2MV5K8Ic1QHFKt
 ulAGfTYFsKrlG3oW8JD9U92dP9l8iBHZIqVVp4J9FDoJ3LaEbzjR3+oKNOqS2VOaF7fao/GzlKY
 hEefrCwRHDDL3LueINIUfesi1ZYGtJzDQfXup37k9ehUBEErp4bEzBVIKd04X4Jgv3XRzDHhPVJ
 wNpiBMIkLuuDLchltkLdzWUQFJe0PY1ZiQVoBYJdm0yMylLGJEOZEu7P2im6E7Ml6KvXnYZmWbH
 cRo2cXwBUpAquMyxIU9UQ1oPdkxWdNjk8p4gZosBokh2rDXgRn8gsq9csFl8YlmlHDssqueJiwN
 UflbbF2Wg9gx/P5At5/CKt1Pdf+rqVqco7OW6d+ZDy+XXB2zAAg==
X-Received: by 2002:a05:6000:220e:b0:486:ecc3:2d1a with SMTP id
 ffacd0b85a97d-4870d16b5cdmr3992111f8f.31.1789573059092; 
 Wed, 16 Sep 2026 08:37:39 -0700 (PDT)
X-Received: by 2002:a05:6000:220e:b0:486:ecc3:2d1a with SMTP id
 ffacd0b85a97d-4870d16b5cdmr3992070f8f.31.1789573058703; 
 Wed, 16 Sep 2026 08:37:38 -0700 (PDT)
Received: from rh (p200300f6af00a400b6f52cb1a2e89932.dip0.t-ipconnect.de.
 [2003:f6:af00:a400:b6f5:2cb1:a2e8:9932])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm9237597f8f.23.2026.09.16.08.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:37:38 -0700 (PDT)
Date: Wed, 16 Sep 2026 17:37:36 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Eric Auger <eauger@redhat.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Alireza Sanaee <alireza.sanaee@huawei.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Cornelia Huck <cohuck@redhat.com>, khushit.shah@nutanix.com, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v5 1/3] arm: handle demuxed ID registers
In-Reply-To: <CAFEAcA9HBVnBcSchvBrt-z9UgYBeJ2EZAJrdbeoL_CoKgvU6rw@mail.gmail.com>
Message-ID: <d10b4520-00e3-f86d-be36-637cb5cf18bd@redhat.com>
References: <20260909144151.26803-1-sebott@redhat.com>
 <20260909144151.26803-2-sebott@redhat.com>
 <CAFEAcA9HBVnBcSchvBrt-z9UgYBeJ2EZAJrdbeoL_CoKgvU6rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 14 Sep 2026, Peter Maydell wrote:
> On Wed, 9 Sept 2026 at 15:42, Sebastian Ott <sebott@redhat.com> wrote:
>>
>> From: Cornelia Huck <cohuck@redhat.com>
>>
>> For some registers, we do not have a single ID register, but actually
>> an array of values (e.g. CCSIDR_EL1, where the actual value is
>> determined by whatever CSSELR_EL1 points to.) If we want to avoid
>> using a different way to handle registers like that for every
>> instance, we should provide some kind of infrastructure. Therefore,
>> add accessors {GET,SET}_IDREG_DEMUX that are similar to the accessors
>> we already use for regular ID registers.
>>
>> Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Sebastian Ott <sebott@redhat.com>
>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index e3f931dba2..9652f8b0bf 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -919,6 +919,18 @@ typedef struct {
>>          i_->idregs[REG ## _EL1_IDX];                                    \
>>      })
>>
>> +#define SET_IDREG_DEMUX(ISAR, REG, INDEX, VALUE)                        \
>> +    ({                                                                  \
>> +        ARMISARegisters *i_ = (ISAR);                                   \
>> +        i_->idregs[REG ## _IDX + INDEX] = VALUE;                        \
>> +    })
>> +
>> +#define GET_IDREG_DEMUX(ISAR, REG, INDEX)                               \
>> +    ({                                                                  \
>> +        ARMISARegisters *i_ = (ISAR);                                   \
>> +        i_->idregs[REG ## _IDX + INDEX];                                \
>> +    })
>
> Would it be reasonable to assert() in these that the INDEX is within
> the range we expect it to be (i.e. >=0 and <= REG ##_IDX_LAST) ?
> That would compensate for the loss of the compile-time checks
> in patch 2 and the fact that static checkers won't be able to
> see the intended bounds now this is just a slice of idregs[]
> rather than a standalone array.

Sure. I'll send a V6.

Thanks,
Sebastian


