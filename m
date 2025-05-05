Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF26C369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 07:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBpxe-00009K-UA; Mon, 05 May 2025 03:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uBpxc-00008i-Sh; Mon, 05 May 2025 03:09:56 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uBpxb-0001iz-7U; Mon, 05 May 2025 03:09:56 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736c1138ae5so4052584b3a.3; 
 Mon, 05 May 2025 00:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746428993; x=1747033793; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B4DMuYEGhP8BAtAEszjKnWbiO437bdU7dOgQFi4v1j0=;
 b=loNgI818i6NDLiNwJNP/sNxDKJTWbHLwqrYSa60dfxqTAvYxf8qLPvgLrXt3f9c74l
 N7pncIKK1YUnoaicaBJBSZSBxcX8zSrSfy5nfFvCiZ1+gPDU3hkY/KqMVwqEAtVpm6ub
 Zw4qh2Pajs9/Wc5+ruV+8jDWjt6diDA2quQcdyjQilXhIX49C89YFD4eOYpSVhpcLYA+
 MBHpG9/zrQ6gvUP7D/e9AFAgUOWywvOEC4OfhuAFBIs+tKndOzdXRA0+cs4gEjlbE6tt
 MsDzd5bZQpLxKLecm+XPJlkbeG+NS8lVwfCu60I2B5T7Kv2kbcJIWaJSZ6iIsaVukn7r
 klgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746428993; x=1747033793;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B4DMuYEGhP8BAtAEszjKnWbiO437bdU7dOgQFi4v1j0=;
 b=T7sWMjnz9rYbTcD4FQdnIYlt0nUytzc1U1ufj0dsrK9Mgi7GXLeC9E3Qf7l2WBDIOv
 npByYvt8xhcdpHeky6Mo5KDgYvNQFV8YjQddlwJFoBFzSgEZpysLXZeXLfIAEq/BPl6T
 mneUIpEHtLqmRviVD7EzVBCI4qG7Gd2Ki9zmH9Rl+IjcYMm3BQfbJWvpcJSG+cvA/Nnh
 9FiyFk6fD9OtwddUU4Y3HDsy1rxQA9MQryNoxDI4eK/WA2tiQ5OYkFcxP+bub3Zi5+Tv
 zYrY4BQbSMWpoAs6U01WEcYxuA/7w7Bf4cW6grtbZgKAzBqTpvlgD5yQtW9U7vP6ph5o
 6J7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/lcNBhQ21VLHfN4XCBkSjRu2GyJzPrGaCU/XaUDj8Xay/lPf2zoyZKO+rnUIP04ewaR8kZP/mjWOq@nongnu.org,
 AJvYcCXjc4zJoPDBskPaOsz5BtKuJXnnKU9v0fMM5Us5sbJwhq0fdTIETXh2ctBUscaczu6PxPss8xo4BqA=@nongnu.org,
 AJvYcCXxgemCMd0GDdSGeiGdcVTawiGGoYVzGyojCxc1WtYHFyEbxYoVp0Gf/vJS+asu2IXtzh864uqM7T2usQ==@nongnu.org
X-Gm-Message-State: AOJu0YxmCjGht8vFJ8GUdZW3LL6hcvY0rRUOZFioaBDSlNn0wY54P+BH
 XsazGEZgl0NcKHKVx9nBwMybX0O0nGJaQDBD1jAa667mtVOiXk/r
X-Gm-Gg: ASbGncu9FMnPcrFCjyJm9Xek5VRMkje/NQ26DnOEr64lX4I6O2eAJSNM1Wyyier0e10
 tqCSWVELRw7uAs511LOkzvE8aDo8K4356Ja08bWj0EnZM9asWyJaUpNMB7G/sHkoJblWU6bmdTC
 6ZROqYk6dMpPEe/SNdKJdrFm9pCbSOqNUA28x+xWLJoMVHGPqXL5DfKuolUtGFRj1MDoaL3cmZ/
 CDmbI89pOfJf3Wk1fZNjR+UhlmnGO2Yau2289sSzImrngcOAz91EYKr2fmWSq3h3LxxNGjbbriu
 F8yFwW2bFaEozLZM9EXk4tXCBw9esZPW
X-Google-Smtp-Source: AGHT+IGykZHIOh5eYc4+sXvVZJJQxA84Dl1cD8Gv21folYHVWyCXQNWNJrcFyoTotITtmU3vjWHgeg==
X-Received: by 2002:a05:6a21:9186:b0:1f5:874c:c987 with SMTP id
 adf61e73a8af0-20e96605740mr9165481637.15.1746428993076; 
 Mon, 05 May 2025 00:09:53 -0700 (PDT)
Received: from localhost ([1.146.78.151]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fd2f96ec2sm1084032a12.13.2025.05.05.00.09.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 00:09:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 May 2025 17:09:43 +1000
Message-Id: <D9O1ENDX16N7.27K5L7ICNM95X@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Akihiko Odaki" <akihiko.odaki@daynix.com>, <qemu-devel@nongnu.org>
Cc: "Fabiano Rosas" <farosas@suse.de>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, "John Snow" <jsnow@redhat.com>, "Laurent Vivier"
 <lvivier@redhat.com>, "Paolo Bonzini" <pbonzini@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-block@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v5 03/11] tests/qtest: Add libqos function for testing
 msix interrupt status
X-Mailer: aerc 0.19.0
References: <20250502030446.88310-1-npiggin@gmail.com>
 <20250502030446.88310-4-npiggin@gmail.com>
 <e9af660f-713a-4bc4-889d-f619e91c01d8@daynix.com>
In-Reply-To: <e9af660f-713a-4bc4-889d-f619e91c01d8@daynix.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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

On Mon May 5, 2025 at 3:37 PM AEST, Akihiko Odaki wrote:
> On 2025/05/02 12:04, Nicholas Piggin wrote:
>> This function is duplicated 3 times, with more potential future users.
>> Factor it into libqos, using qtest_memset instead of qtest_writel to
>> clear the message just because that looks nicer with the qtest_memread
>> used to read it.
>>=20
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   tests/qtest/libqos/pci.h               |  2 ++
>>   tests/qtest/libqos/pci.c               | 48 ++++++++++++++++++++++++++
>>   tests/qtest/libqos/virtio-pci-modern.c | 31 +++--------------
>>   tests/qtest/libqos/virtio-pci.c        | 40 ++++-----------------
>>   4 files changed, 62 insertions(+), 59 deletions(-)
>>=20
>> diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
>> index 83896145235..9f8f154c301 100644
>> --- a/tests/qtest/libqos/pci.h
>> +++ b/tests/qtest/libqos/pci.h
>> @@ -92,6 +92,8 @@ void qpci_msix_enable(QPCIDevice *dev);
>>   void qpci_msix_disable(QPCIDevice *dev);
>>   bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry);
>>   bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry);
>> +bool qpci_msix_test_interrupt(QPCIDevice *dev, uint32_t msix_entry,
>> +                              uint64_t msix_addr, uint32_t msix_data);
>>   uint16_t qpci_msix_table_size(QPCIDevice *dev);
>>  =20
>>   uint8_t qpci_config_readb(QPCIDevice *dev, uint8_t offset);
>> diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
>> index a59197b9922..773fd1fb6cf 100644
>> --- a/tests/qtest/libqos/pci.c
>> +++ b/tests/qtest/libqos/pci.c
>> @@ -351,6 +351,54 @@ bool qpci_msix_masked(QPCIDevice *dev, uint16_t ent=
ry)
>>       }
>>   }
>>  =20
>> +/**
>> + * qpci_msix_test_interrupt - test whether msix interrupt has been rais=
ed
>
> Nitpick: Let's write as "MSI-X" instead of msix in documentation.

Okay.

>> + * @dev: PCI device
>> + * @msix_entry: msix entry to test
>> + * @msix_addr: address of msix message
>
> Perhaps deriving the address in this function may make things simpler by=
=20
> removing the documentation and assertion code and not requiring callers=
=20
> to pass it.

addr and data could both be derived from the MSI-X table, but passing
them in here is how some of the existing helpers are structured, so I
will leave it like this. I think I have slight preference for this way
but if there is strong preference for deriving them implicitly then it
could be a follow up patch.

>
>> + * @msix_data: expected msix message payload
>> + *
>> + * This tests whether the msix source has raised an interrupt. If the m=
six
>
> Another nitpick: "whether the device has raised an MSI-X interrupt" -=20
> "msix source" is not a pharsed used elsewhere and it can raise other=20
> kind of interrupts too so let's make the kind of interrupt specific.

Sure.

Thanks,
Nick

