Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36785C369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 07:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBqKD-0000WT-63; Mon, 05 May 2025 03:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uBqKB-0000Q7-Ba; Mon, 05 May 2025 03:33:15 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uBqK9-0005LJ-DR; Mon, 05 May 2025 03:33:15 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736ab1c43c4so4065322b3a.1; 
 Mon, 05 May 2025 00:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746430389; x=1747035189; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pX1/R0BwZvK/hATHy4WCF4UxfTxafJoEm7vzhjt6VsE=;
 b=mUiMUH08z5Mw1VwO2Oe67qJX0EEkcnEcOOEPenfBwNcsHSHAhe3BvMxoNFPwGjKrth
 IT2YZ1KggZP7WSPEvreNisk3ulw4DdV9w2DEuUwb4otKvOdkZLKEK3gi138qCJ6zqnOA
 3EBrnCUMvD3H7Ww/f/rXBd8YWlNfo8qGYJqniXyDdgNpslFjCuaqHn446AJ4WLhQuuUM
 FKK778mfWsvLR5dNEILSLWCZQwrvrIAnBW/KumWAiFXcGngR6P5Bkh9d2bBxsiDcok0g
 DnY9WHC0b5kC4l145fvTVWQ91qhzAFZ/kSlJweXIBF/SGczAj3MavSVKXU6Z7j6V+4G3
 ELaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746430389; x=1747035189;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pX1/R0BwZvK/hATHy4WCF4UxfTxafJoEm7vzhjt6VsE=;
 b=VzKDEp/E+ROiu/xZqIaKb90mBYE+eus/Nf46ywh7KowLN4hY4quItSmVkZTLzCBoOR
 BhJIi+8YemUDN4zC1z1MB8IV7drg0Z0KZ6/uyEfv7vWC3Kl/3Az5cSSdAinJTXL1XewX
 7mlkZk+LNwY/2zvXuzTQAjg8iO42loXZ++ZZ+LWn8bQwp6YFGY2XHrJo1tz0tWi/W5Tf
 Dlh6wlfGlzoSaI0xh/+NpvlQzO2QoWFgeei2Kw1ierEUM0v9bcv2Qzgppeyo1A6SYAZA
 VRZpvf6DnnNct+OMw4rQcbNaKNxWnnuA+hgIWegb32ke5CrRVAXa6oYm66eH4Nuyp5Go
 9ZMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR8PoLtQQ1cyOWdz/hzzboeYiJg2mIUNnGmMQkxk3HlPvGzfvDZcvov4f7XcSt+ojw/0ZkAM5KG8eq@nongnu.org,
 AJvYcCVWUYIeWGO5zPFkdN7jpjEgTkN5ktvtuo9/N9+WPk2zFGldMRw+MDp5UvwlxcYj56kZtEVETRs8oCwQLQ==@nongnu.org,
 AJvYcCW5gTEmruiE27A/mMSv3K5egxPOvCHOFdYSCp3qbKurn8T1ooj/pR8iiZfuVf9HkcDoL60km7ounrI=@nongnu.org
X-Gm-Message-State: AOJu0YzRmp5WBoxlE9peKyR3WvWUK15mxGZO/lXVoq3JMvM8h2NpSpap
 IiMPA2/UZ7jaweGWZv+psSWhl2vNkmY36qSw+n1gJBlFETCh3EhJ
X-Gm-Gg: ASbGnctMv4mSoGcAxRJWP9axONLQW0GVRBxMjjNyzu36Y3e6jm8DzN+4YsayM/cGlCy
 giTbstYmihYYnAqtWptcXL812wkZOXq2FwvjhsZIdehLRuc+AQ0qWXz5Z+2Y2BJ7YVwfh1pNl2R
 69js3YhTK4ohuLHIffN+JOQklzMnVn4Jf4Sz6KXbEvjZ/Yodu9d5bZponqzxmq2uI1ZBdY3D7Kj
 32iX9kgdB9ngMEYOp1KBHIoh9G7TtCPciuM4QMl7NAsf/WHNldmTSa/T3zPEJRv0QqNhFT60q3I
 Gg1JKi8iYp2kuOtxRlqB+2Ly01yKUbem
X-Google-Smtp-Source: AGHT+IG3S7bJz+sph9Jatx0f5W3nPF8lzZUqKR8FO7NYfh6kig/719kZP6AGjL33QZmwDmBK/bsNxQ==
X-Received: by 2002:a05:6a00:2e9d:b0:740:6f7f:7645 with SMTP id
 d2e1a72fcca58-7406f7f7a1amr10170397b3a.8.1746430389658; 
 Mon, 05 May 2025 00:33:09 -0700 (PDT)
Received: from localhost ([1.146.78.151]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3924df3sm4046419a12.3.2025.05.05.00.33.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 00:33:09 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 May 2025 17:33:01 +1000
Message-Id: <D9O1WH9RPAPP.UZ3PGQUKX3OC@gmail.com>
Cc: "Fabiano Rosas" <farosas@suse.de>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, "John Snow" <jsnow@redhat.com>, "Laurent Vivier"
 <lvivier@redhat.com>, "Paolo Bonzini" <pbonzini@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-block@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v5 06/11] tests/qtest/ahci: don't unmap pci bar if it
 wasn't mapped
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Akihiko Odaki" <akihiko.odaki@daynix.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250502030446.88310-1-npiggin@gmail.com>
 <20250502030446.88310-7-npiggin@gmail.com>
 <20b79b43-71ab-438c-9617-ff95bbf5eef1@daynix.com>
In-Reply-To: <20b79b43-71ab-438c-9617-ff95bbf5eef1@daynix.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

On Mon May 5, 2025 at 3:25 PM AEST, Akihiko Odaki wrote:
> On 2025/05/02 12:04, Nicholas Piggin wrote:
>> ahci-test has a bunch of tests where the pci bar was not mapped. Avoid
>> unmapping it in these cases, to keep iomaps balanced.
>>=20
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Cc: Fabiano Rosas <farosas@suse.de>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   tests/qtest/libqos/ahci.h | 1 +
>>   tests/qtest/ahci-test.c   | 7 ++++++-
>>   tests/qtest/libqos/ahci.c | 9 +++++++++
>>   3 files changed, 16 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
>> index f610bd32a5f..d639692aac4 100644
>> --- a/tests/qtest/libqos/ahci.h
>> +++ b/tests/qtest/libqos/ahci.h
>> @@ -342,6 +342,7 @@ typedef struct AHCIQState {
>>       uint32_t cap;
>>       uint32_t cap2;
>>       AHCIPortQState port[32];
>> +    bool pci_enabled;
>
> The following patch also adds a similar variable for virtio and has a=20
> slightly different semantics; qvirtio_pci_device_disable() is no-op but=
=20
> ahci_pci_disable() aborts when no-op.
>
> A bool flag can be added to QPCIBar instead so that we can enforce the=20
> "no-op if not mapped" semantics everywhere consistently with less code.

Now I think about it, the reason for the patch in the first place is
to ensure tests balance their maps and unmaps.

If we want to just keep allowing iounmap() of not-mapped bar to simplify
error handling and cleanup cases that's fine, I think I can just drop
these patches and remove assert in iounmap.

Thanks,
Nick

