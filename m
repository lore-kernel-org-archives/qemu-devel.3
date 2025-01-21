Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DF4C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 04:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta63b-0004hY-Sy; Mon, 20 Jan 2025 23:40:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1ta63Z-0004f7-DM; Mon, 20 Jan 2025 23:40:05 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1ta63X-0001xk-Hs; Mon, 20 Jan 2025 23:40:05 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2eeb4d643a5so9268405a91.3; 
 Mon, 20 Jan 2025 20:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737434400; x=1738039200; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LAVllneEu9d5MPfvV9UKUITKCp43vcZcdrgmQ7OCT48=;
 b=R1loIVOeLFKm6kVE2amJEGQondLctG5lB2vaebL4TClP7OiUElrfFV8iW52y320bpH
 VvWe/h2/1wtKWNWl7Dc0FeEGfSyGqEHI/skmlpq/L/ZsVu66SkEvtcafwafFzUO/qIzn
 VCC38y/gl85x5YETAdIPmViZE0WBPsFV/au5CUjpWtVEt92SGIK74jClI93E7ifRq1pm
 MfzPmQMPVcIUozpYNtOdZbvJXfxvyMeSSm2jp34Mar1CiCGh/3h21UJloyMia27Bc3zv
 ZQsMvkUE1G2Auua8hHF6KwSnJB8RWmwRVyARcRyVaoO+ifbDJWcaME64y+nJ6XQpAQw5
 WziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737434400; x=1738039200;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LAVllneEu9d5MPfvV9UKUITKCp43vcZcdrgmQ7OCT48=;
 b=D6j2kZm6pwhyMXVXGYySjl2563LTBXZaV8ViOb2X8MDw2hX2YGCEHvEH2JBcr6PTRY
 Lmt4NTwSW6AwL6rgEP/fj0jHof+ndyUbnivJEEzbwUTGtnKgCnh4eGrpAjfdjSaSxSZu
 xhVmR2WqC+4jqhzBRADW5s4GhLYitOE3ZVqlOCeIGduo6xR63ImIo0V8lvn6gblAETVi
 IUEmSMkVtVsBfPnwcsAunIvDPBB244h6yjjXVRQQPfZe+2NogPf1/CeYow/R6j8sGFes
 tHU/q2zKu6+34aVgCXCHhDlaQE31eWft6X8RqbcbNKU3PniPaiQzdPnMNepgs6zKQJ5y
 rryQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLXVH9KKV9jGvl3yoxNSkPZt/zAYV/+j0GuDuyWAlW/7B3yhoF2sNpP/ZeSxZCBluANaUNDs01M8ftkA==@nongnu.org,
 AJvYcCWWMfDdcTcXuZqa1mCK7Ftah4jMf09T2tqUeAw2mO/yLoFx0ar0f+cUuaG6k9/ycPIVC3AD6uueIjLj@nongnu.org
X-Gm-Message-State: AOJu0YyJ8piT7sINRLSCXEJVD7afoy1L96uZaDOjrW/WDCnRiaO1rakb
 y7NNeixJJ82uvBwS6x0ElUM3k/tSvj6bxSCOwE/o36H/fpBnNnwl
X-Gm-Gg: ASbGncsGOLiAbvl7dzmiUgN7S5OphU7sCTDq1uNmB9v65fH53cYw0LSc5TtUUPyZde8
 IGFpNfwv6anD1mvd/y/mYunqu+DoQ6x2yESCllhHJZsB7OJwKgeKmUQ2Qv5sta8N2Gi86/ZaBnr
 fRzOT3og15QwS8i28FW92nLTm/XGyAFPEzq/wgMn1T59vX7WaWSINcbM5gVa9ex98Cpih+/FCdH
 9wdtb+inYnvg6oIHdMRgDb+Z+W+00PkU1fWfNMECBxU8xbSj89j54MELfn9Ri1I
X-Google-Smtp-Source: AGHT+IG6lwytEjL5bIWUjSuaSBrJlach/T5RxfJ+OBxGugWWNlxW4liLvUy6bYN8O46YOWUChalOfQ==
X-Received: by 2002:a17:90b:1f8a:b0:2ee:f687:6acb with SMTP id
 98e67ed59e1d1-2f782c94b50mr23137433a91.13.1737434400148; 
 Mon, 20 Jan 2025 20:40:00 -0800 (PST)
Received: from localhost ([138.44.251.158]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f72c17fa07sm13034075a91.14.2025.01.20.20.39.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2025 20:39:59 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jan 2025 14:39:33 +1000
Message-Id: <D77H30AHH52R.NMFINJAZGOD0@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Fabiano
 Rosas" <farosas@suse.de>
Cc: "John Snow" <jsnow@redhat.com>, "Laurent Vivier" <lvivier@redhat.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, "Akihiko Odaki"
 <akihiko.odaki@daynix.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, <qemu-block@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 2/4] qtest/libqos/pci: Enforce balanced iomap/unmap
X-Mailer: aerc 0.19.0
References: <20250117172244.406206-1-npiggin@gmail.com>
 <20250117172244.406206-3-npiggin@gmail.com>
 <0584eb66-ab11-40ab-bf97-64299eaab52d@linaro.org>
In-Reply-To: <0584eb66-ab11-40ab-bf97-64299eaab52d@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102c.google.com
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

On Mon Jan 20, 2025 at 3:29 PM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Nick,
>
> Only nitpicking comments...

Hey, no they're good comments actually.

>
> On 17/1/25 18:22, Nicholas Piggin wrote:
>> Add assertions to ensure a BAR is not mapped twice, and only
>> previously mapped BARs are unmapped. This can help catch some
>> bugs.
>>=20
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   tests/qtest/libqos/ahci.h       |  1 +
>>   tests/qtest/libqos/pci.h        |  2 ++
>>   tests/qtest/libqos/virtio-pci.h |  1 +
>>   tests/qtest/ahci-test.c         |  2 ++
>>   tests/qtest/libqos/ahci.c       |  6 ++++++
>>   tests/qtest/libqos/pci.c        | 32 +++++++++++++++++++++++++++++++-
>>   tests/qtest/libqos/virtio-pci.c |  6 +++++-
>>   7 files changed, 48 insertions(+), 2 deletions(-)
>
> Maybe put the AHCI fix in a preliminary patch?

Yeah, this was just laziness. I will fix.

>
>> diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
>> index 83896145235..9dc82ea723a 100644
>> --- a/tests/qtest/libqos/pci.h
>> +++ b/tests/qtest/libqos/pci.h
>
> Consider using a definition rather than a magic value:
>
>    #define PCI_BAR_COUNT 6

Now I look again at PCI code and it has PCI_NUM_REGIONS 7
where ROM slot is the last entry. qtests doesn't use it
AFAIKS but maybe it could(?) so should I just use that
existing define?

Thanks,
Nick

