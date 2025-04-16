Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF95C369AB
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 02:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4sAb-0001TB-Qp; Tue, 15 Apr 2025 22:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u4sAR-0001Ru-Ue; Tue, 15 Apr 2025 22:06:24 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u4sAQ-0003mG-0R; Tue, 15 Apr 2025 22:06:23 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-224341bbc1dso58051235ad.3; 
 Tue, 15 Apr 2025 19:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744769179; x=1745373979; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HnRWfcc7PvadvcePhLdjz0skJBEAVbdJhnKhdI/dz+0=;
 b=MnAQ+VLV2C7qAHLThQ2Ted33VP6NyLoxER+0UP97cbJ+U3XyIjPvfImiEe25n0JT4d
 P8Ay5dGaECbPOGbIhfB8nL2DKSW+LGOsvKZAJWU3ICB1OOlMzh66fCSsq6ap163nm6gV
 V6zdO+ZiIXhSOT3SEITc4iXZwez+7qNNKrBs6RQkTKr9fsjYBP0J8ouSKwxnNI0Lyqcq
 THQyXWyG0LDPbeaUOmBx3Df3xRXOWJcaHrS2kZtH4E3MTnJe/PAoTZrYBCN0Ft9rRSnW
 w+wFJF9728a59uOxU43kYxOqHJfKIuYifgkliztTUaxTPXzlxlQKzf2RwTrEXODVYh6B
 44Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744769179; x=1745373979;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HnRWfcc7PvadvcePhLdjz0skJBEAVbdJhnKhdI/dz+0=;
 b=C7prrJ6kRPRMgnuIhao/lXnGK96fYsN2NEDFzAjIJMgpfCbXCpDNWgO1H9qIRA9Mbm
 57ewpOAMciHxtNs8ts/vlKs2tS1tfujS17k7QVknI0kx686bLl+m2QPZ8J4Kwq0iXadz
 zbQ6fz0FP5oAx1S1jyvN4Jx2eSkSQJ7N5mZmYa/qhJ7qDPKmtH5Z211s+WMnU2agOKzt
 YSWCvA6voOvx6Ot6L9Ob56kaZedbfcXwXqDbknE60VCDgHXA2vZhi1pPiDUSRYcvPMft
 Yutndz8ozr9rG9MQ4i/fMn/Ntm8ksM9u9lnymofhO8vN6vNZWLa7rbqH9tVhz1+HZ+Yk
 ST3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOrUCQ6tkibtR13p4ceuT0lz47x6Ey/g3K+EbmuuNZ28SCFhocuxHyjhHUhE+kr4msLFht0oiAraQ=@nongnu.org,
 AJvYcCUX8Nb9CgVYx2nltRpfBJqrhtDHOwuqRmLxPadFwhhoH1mhvS99ZFhICnHOx5aitQu1BPXjlPJfmKHm@nongnu.org,
 AJvYcCWjZpR11jSkoFGMyfuUZ4aWvAjnAP13G4FC+WQ8kJdMv2vj+MPD15C7dULuGk7NxNrsdaPEidXWBO1quQ==@nongnu.org
X-Gm-Message-State: AOJu0Yz9j6/ltE7MHqPPeegOxQJV98/N6jE2e4BIISl3nej74thw+y8b
 jpW/im1T5UdDyeD59QMUAXPkAR1q58qt2I9xQGcJY88cfO2RSlqm
X-Gm-Gg: ASbGnct2ThIIEWOZUImE4nLvThy9j+i1G6nmQ8PRWOn6Dokp+J04dpoaEVJhmDu8FwO
 2w61la/crJvA94Hc3SWYtse9C2MloGZ8aaExcrrx3GZ0V/E9u1nGTz/EK6cBwZUKFWpL6E++N+A
 u72K4ArWmnBmopZyD/7wZNsQTCUBjsqnm6+OAnKfRz7JhexOi5EAYXUy191hn87hdj01y3lMsS0
 P7uPO5ioL0jYNgQMQwoWvod7sfq7EQEZ+HWKp9u/lI0DD+txz5g32Yi+O0KHLajo67PyFs5VWMr
 CutwByKDFR1Sg+4Q/UYaLfQ+evLQLb0=
X-Google-Smtp-Source: AGHT+IExY1MNlq005oqxnGlOrCfUzgEILsDIerYqaFdnchs8YSYTgqNCvhPhzYQjo4m3ntAdvNccow==
X-Received: by 2002:a17:903:903:b0:220:c813:dfce with SMTP id
 d9443c01a7336-22c3596db31mr598655ad.39.1744769179346; 
 Tue, 15 Apr 2025 19:06:19 -0700 (PDT)
Received: from localhost ([1.145.6.120]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fc43edsm2361155ad.164.2025.04.15.19.06.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 19:06:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Apr 2025 12:06:12 +1000
Message-Id: <D97P1WO754K9.160CCPB9PO1FH@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, "Laurent Vivier" <lvivier@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Coiby Xu" <Coiby.Xu@gmail.com>, "Stefan
 Hajnoczi" <stefanha@redhat.com>, "Emanuele Giuseppe Esposito"
 <e.emanuelegiuseppe@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-block@nongnu.org>
Subject: Re: [RFC PATCH 2/2] tests/qtest: Enable spapr dma with linear iommu
 map
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Fabiano Rosas" <farosas@suse.de>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250415081914.378236-1-npiggin@gmail.com>
 <20250415081914.378236-3-npiggin@gmail.com> <87ikn5fgd8.fsf@suse.de>
In-Reply-To: <87ikn5fgd8.fsf@suse.de>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

On Wed Apr 16, 2025 at 4:07 AM AEST, Fabiano Rosas wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
>
>> qtests spapr dma was broken because the iommu was not set up.
>>
>> spapr requires hypercalls to set up the iommu (TCE tables), but
>> there is no support for that or a side-channel to the iommu in
>> qtests at the moment, so add a quick workaround in QEMU to have
>> the spapr iommu provide a linear map to memory when running
>> qtests.
>
> That's fine.
>
> But what would it take to add support? Add another callback such as
> qtest_rtas_call() to handle hcalls and call H_PUT_TCE from the test? Or
> is there some other complication?

Yeah, exactly. qtest_ppc_spapr_rtas_call() and/or _spapr_hcall() in
the qtest interface I think would do it.

It would be nice to do that in general to be able to test various spapr
bits with qtests. It's just getting all the pieces together would be a
bit more work than this simple bandaid.

>
>>
>> The buggy msix checks can all be removed since the tests all work
>> now.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  tests/qtest/libqos/pci.h             |  4 ----
>>  hw/ppc/spapr_iommu.c                 |  9 ++++++++-
>>  tests/qtest/e1000e-test.c            | 23 +++--------------------
>>  tests/qtest/igb-test.c               | 21 ---------------------
>>  tests/qtest/libqos/generic-pcihost.c |  1 -
>>  tests/qtest/libqos/pci-pc.c          |  3 ---
>>  tests/qtest/libqos/pci-spapr.c       |  7 ++++---
>>  tests/qtest/libqos/pci.c             | 14 --------------
>>  tests/qtest/vhost-user-blk-test.c    |  6 ------
>>  tests/qtest/virtio-blk-test.c        | 12 ------------
>>  10 files changed, 15 insertions(+), 85 deletions(-)
>>
>
> ...
>
>> @@ -173,13 +159,10 @@ static void test_e1000e_multiple_transfers(void *o=
bj, void *data,
>> =20
>>      QE1000E_PCI *e1000e =3D obj;
>>      QE1000E *d =3D &e1000e->e1000e;
>> -    QOSGraphObject *e_object =3D obj;
>> -    QPCIDevice *dev =3D e_object->get_driver(e_object, "pci-device");
>> =20
>> -    /* FIXME: add spapr support */
>> -    if (qpci_check_buggy_msi(dev)) {
>> -        return;
>> -    }
>> +    /* Use EITR for one irq and disable it for the other, for testing *=
/
>> +    e1000e_macreg_write(d, E1000_EITR + E1000E_RX0_MSG_ID * 4, 500);
>> +    e1000e_macreg_write(d, E1000_EITR + E1000E_TX0_MSG_ID * 4, 0);
>
> What's this about?

It's a rebase bug, thanks for catching it.

Thanks,
Nick

