Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE81C369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 06:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBpdO-0006eA-QO; Mon, 05 May 2025 02:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uBpdN-0006de-Am
 for qemu-devel@nongnu.org; Mon, 05 May 2025 02:49:01 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uBpdL-0007qA-KV
 for qemu-devel@nongnu.org; Mon, 05 May 2025 02:49:00 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22e15aea506so29486665ad.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 23:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746427738; x=1747032538; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O1zsHaIWxCFIu/Uw6I34sysuwFBNVHH2siKV6Dk/rlU=;
 b=lt/OJjH8nClIgy6VutgzDfK7l5bQwD3t/KDnmDy8BKhJeJAWkrMBYiSi7jo2XKI7x2
 Ls/J0KQCUw5Y6AAjXBmLiFcftIP2Yc63IVW0Gr2qLVCRRKawBIzlGl8Ucf76/aqjxlg8
 HzfRuxWyC4P6/bDcG00XPE+YoSmtxWaf9qFnfNt1BtVHr87hH1zsYvxCdYVZwB2yPnTQ
 7f940DfslEqNer28ULeXrvFU1gH5fykRO7+vGIi87rTAcmLLCPx0Y5DZZE/7faTPdLwo
 Biw35nsx4pex88L1ey6ubXFgIJFqUI0N4+uguCihlAdcqPr8iWV4QOVc9lhmjY6nO84z
 XFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746427738; x=1747032538;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=O1zsHaIWxCFIu/Uw6I34sysuwFBNVHH2siKV6Dk/rlU=;
 b=CbxMu4ogUARx5tbNBQ+vCb28J3SifiQjxhMqUmHgjghiIL1ogPspu8jEfrda/ind8b
 VWCuQG+3/WANNs6JHZ+AMDxAUCFHB+GBjWjNwMW/8/52qYLC4zA3rDlcmxYMeOT1xfl5
 oYpmfmb0z04DPrr78eU3jxDVfar+Orm5GmqAuCz1Gjat4KjZUlPFcJ0rVGv0NEUsqIuP
 73UHze7yIs/vt7yflNYzjhvL52Y6nXPhTeb8etaaRnRE35jzHz3D1BWrO+P4eTbI39mW
 mBYwux3xvNNbWfzHdLO4yjzu2mU7pCZ6rJ13acttNoaNhLR+jEe/W1FX5/QFmaaRTKp9
 9SiQ==
X-Gm-Message-State: AOJu0Yy6GK9OgEVNFsGGlQookW1cGgs9x79Uznhka1JOP9WAK4HrQKCB
 L8KiQLw2IVZIaBSrR2x8gcyG7OrdXmYR7cRB4JBi+nl/KlMFlNzsqWEp1XU5
X-Gm-Gg: ASbGncvo9L5FQ1TTnU82hGvrHe+mHPsdQmTS+s7RbtqVSoso01P9Lp3a/oBZkuEd+6C
 KsToCyn2zC/svOZmCqMhpetFodYUSmcwYx+dPRQXQS1v/+7i6zPh8ATsxIU0J9iP2v8Gy6XCgwq
 mhvO3CY0La0Wcanh6u9oQevrIgLKu7g+HbnpJEJVdHv1NuNWT5I3j5lvv4cB+U4neibCzH8O3CN
 Hn2RuuqsDdymCi9/v1Ht+fEE1fKjLsnClSwABz7tNS6RCzTtUJVtGuGO/uQWvlRRhk/qkyXuerM
 RipXxg6DVgduLMsNJgqNDZcM+JX0tBAw
X-Google-Smtp-Source: AGHT+IHleDuOnCDHUtYmxz7dFtnm26fyUPvZtd+wK6bPVzAoSW9r4hLj/o+IcPHSmuWBKP0WKVSt1A==
X-Received: by 2002:a17:902:e80e:b0:224:13a4:d61e with SMTP id
 d9443c01a7336-22e1eb0a454mr84664235ad.51.1746427738154; 
 Sun, 04 May 2025 23:48:58 -0700 (PDT)
Received: from localhost ([1.146.78.151]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150eb089sm47463395ad.20.2025.05.04.23.48.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 23:48:57 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 May 2025 16:48:50 +1000
Message-Id: <D9O0YNNU6ICB.9X03ZS82BC5M@gmail.com>
Subject: Re: [PATCH v3 10/12] net/e1000e|igb: Only send delayed msix
 interrupts that have a cause
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Akihiko Odaki" <akihiko.odaki@daynix.com>
Cc: <qemu-devel@nongnu.org>, "Dmitry Fleytman" <dmitry.fleytman@gmail.com>,
 "Jason Wang" <jasowang@redhat.com>, "Sriram Yagnaraman"
 <sriram.yagnaraman@ericsson.com>, "Fabiano Rosas" <farosas@suse.de>,
 "Laurent Vivier" <lvivier@redhat.com>, "Paolo Bonzini"
 <pbonzini@redhat.com>
X-Mailer: aerc 0.19.0
References: <20250502031705.100768-1-npiggin@gmail.com>
 <20250502031705.100768-11-npiggin@gmail.com>
 <0ff9c661-bb52-4a07-924b-96fb57ecda81@daynix.com>
In-Reply-To: <0ff9c661-bb52-4a07-924b-96fb57ecda81@daynix.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

On Mon May 5, 2025 at 3:51 PM AEST, Akihiko Odaki wrote:
> On 2025/05/02 12:17, Nicholas Piggin wrote:
>> The msix interrupt throttling timer expiry sends an interrupt even if
>> there is no unmasked interrupt causes. This can be observed by seeing
>> two interrupts in response to a single event when throttling is active.
>>=20
>> The e1000e non-msix paths seem to get this right by masking and testing
>> ICR and IMS. Add similar checks for the msix cases in e1000e and igb.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   hw/net/e1000e_core.c | 10 ++++++----
>>   hw/net/igb_core.c    | 11 ++++++++---
>>   2 files changed, 14 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
>> index 022884a2ea0..d53f70065ef 100644
>> --- a/hw/net/e1000e_core.c
>> +++ b/hw/net/e1000e_core.c
>> @@ -230,10 +230,12 @@ e1000e_intrmgr_on_msix_throttling_timer(void *opaq=
ue)
>>  =20
>>       timer->running =3D false;
>>  =20
>> -    causes =3D find_msix_causes(core, idx);
>> -    trace_e1000e_irq_msix_notify_postponed_vec(idx);
>> -    msix_notify(core->owner, idx);
>> -    e1000e_msix_auto_clear_mask(core, causes);
>> +    causes =3D find_msix_causes(core, idx) & core->mac[IMS] & core->mac=
[ICR];
>> +    if (causes) {
>> +        trace_e1000e_irq_msix_notify_postponed_vec(idx);
>> +        msix_notify(core->owner, causes);
>
> I think this should be: msix_notify(core->owner, idx);

Yes good catch, it was fixed in the next patch but it's a but from
splitting. Thank you.

Thanks,
Nick

