Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A83D1D88B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 16:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0kk3-0007fw-UD; Tue, 15 Oct 2024 12:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t0kjx-0007fZ-2a; Tue, 15 Oct 2024 12:49:45 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t0kjt-0000VW-J3; Tue, 15 Oct 2024 12:49:44 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-539fe76e802so1337752e87.1; 
 Tue, 15 Oct 2024 09:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729010977; x=1729615777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=szSNw4iCM6lsZci+VjOI55OeV1nZGXX+WEU6BV9WNdQ=;
 b=NAOUE/4SxysDGxRaKa5rKItPGjKlq5iGUeM32blnw4jnBuG2vc1KRWYnpO8cEnhiDF
 gGZ/O2ycu7FT72SfitWtMECKx6GM42K1JWqvUkGmUjFV9PqzhX+Epy9wfhwnvV9/7cX1
 8RabptNRXxpmcBDkhBeSeGe6OknRuX5b6Mhj7JNNP4jA6HHTL+IFKpuipgE26vVPGwYa
 1xGKd74UumQx977U5J2ybIHy+BXipLYHF4kktigauw0g4k0z85B7d4JBlfycNY0Y1oUk
 pr2LPLF3BAKL4PYXFk9UDjlKLCGk2aghInDeVGi2eYx7c+TfWCGSpaUYoM2fSqFbpbcv
 hMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729010977; x=1729615777;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=szSNw4iCM6lsZci+VjOI55OeV1nZGXX+WEU6BV9WNdQ=;
 b=azHUWE7gpEDnNw2ky5TjPNxaeeMSnpD1+zb0UvhCSJeEWSHcVhhxH4PLdIkiYLwTaC
 tnl4H1QEF5xgj38R6wV/S2jjPfFwu+t/0G6uXnJJKcBdyh8ufIHn7wNXfzLySIUJm9/w
 VYNKxBH4klqXQtpjsvbSEO2zn/ePwJe2FtSSCcrMZPPtJ56YXZ9jDLcRsGqdltIMRccC
 6UwOOAdwSGIWBlENvxjckCJKNjR/GzbYmQH/YHQQM1doxesmjeUxyZRarNDhT5wz5LGj
 RkBdw4NTb0N1Fwr3Uq627NZgvOYqj6nc4kVJWZ2b+6DkR38B1zBToKJz9hrPuLnKSd3M
 Jh6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj9SiEEuNFWamD9bfabe2M2ekNtc/j36W8ASDuM3z8dZMVibrWlnQTguAR4i6cyQki9nqkK3u2qQ==@nongnu.org
X-Gm-Message-State: AOJu0YyW8aqcH8b+oLD/8zpwg9i1YDGabNjnct5E2bqd2F6Gfms7jXBC
 QIQYW7vHMo8Hqiyh5piCgy8k2wXEcQpgtGaCGsvUTcqGriHAc5+vaBVtPw==
X-Google-Smtp-Source: AGHT+IE2WnHW+uBWSApeBpk4uO9EmQE1oWb/CYfbjISgHp6Yw2fpEbOoYfaD8pImpC+djgNcOf0Beg==
X-Received: by 2002:a05:6512:138c:b0:539:8d2c:c01c with SMTP id
 2adb3069b0e04-539e571dd25mr5972910e87.41.1729010977092; 
 Tue, 15 Oct 2024 09:49:37 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-183-076-057.77.183.pool.telefonica.de.
 [77.183.76.57]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f55e054sm23396715e9.4.2024.10.15.09.49.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2024 09:49:36 -0700 (PDT)
Date: Tue, 15 Oct 2024 16:49:33 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/4] hw/net/lan9118: Extract lan9118_phy
In-Reply-To: <CAFEAcA8cEFprRy-9AbPsGLU4p1DmVepmWCsgY1LkKh26tHo6qw@mail.gmail.com>
References: <20241005205748.29203-1-shentey@gmail.com>
 <20241005205748.29203-2-shentey@gmail.com>
 <CAFEAcA_2EU8Q+=Zm7pKJpO42=nAeGf9jpCsoM8ped1ngw66gKw@mail.gmail.com>
 <E3D8FB20-605D-4E29-A430-DD3C4B01102D@gmail.com>
 <CAFEAcA8cEFprRy-9AbPsGLU4p1DmVepmWCsgY1LkKh26tHo6qw@mail.gmail.com>
Message-ID: <DC6BEBC3-FAA6-44C8-AE38-CDFBAADA5AE0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 15=2E Oktober 2024 09:27:40 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>On Mon, 14 Oct 2024 at 19:50, Bernhard Beschow <shentey@gmail=2Ecom> wrot=
e:
>>
>>
>>
>> Am 14=2E Oktober 2024 12:47:52 UTC schrieb Peter Maydell <peter=2Emayde=
ll@linaro=2Eorg>:
>> >> +typedef struct Lan9118PhyState {
>> >> +    uint32_t status;
>> >> +    uint32_t control;
>> >> +    uint32_t advertise;
>> >> +    uint32_t ints;
>> >> +    uint32_t int_mask;
>> >> +    IRQState irq;
>> >> +    bool link_down;
>> >> +} Lan9118PhyState;
>> >
>> >This takes state that was in a QOM object, and moves it
>> >into something that's kind of a device but not a QOM
>> >object=2E I think we should avoid that, because at some
>> >point somebody's going to have to QOMify this=2E
>> >
>> >Making this a QOM device is a bit awkward for migration
>> >compatibility, unfortunately=2E
>>
>> Do we care about migration compatibility here? Or is it
>> sufficient to check the version? In the latter case I could
>> QOMify it=2E
>
>
>Doing a quick grep it looks like the lan9118 is only
>used in a set of Arm boards and none of them are ones where
>we care about migration across versions=2E

Four i=2Emx boards using imx_fec will also be affected=2E None is versione=
d afaics=2E

>So I think we're
>ok to break compat with a version-bump=2E We should mention
>the affected boards in the commit message=2E

Will do=2E

Thanks,
Bernhard

>
>-- PMM

