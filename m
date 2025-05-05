Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92483C369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 06:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBpis-0000mQ-C0; Mon, 05 May 2025 02:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uBpiq-0000k9-Le; Mon, 05 May 2025 02:54:40 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uBpio-0008J0-Qa; Mon, 05 May 2025 02:54:40 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2240b4de12bso65133915ad.2; 
 Sun, 04 May 2025 23:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746428077; x=1747032877; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lhg+J/QcqAP+oVJTufv/v7f+jVoVu/5E0hPcs1BlPG4=;
 b=cmJB1BysqowPdtgiNjd5TgXIkPD3TZ9jHirZGW/usvJ5mEkg5+PK3iisJIQMUr+U/g
 sKCyVAaGgGyHkq6VGBTaw0vLRoENlHuVBSmvFhk4cGmcReTqHWNIIV/uxxQmc9ILel/z
 GwVwNQT0yWl49RZ6MLvhTZIi1cWqj5EVO5KZoscXMQeWYGjvRXVUpPao95Rn9Knp+f6q
 kNm8hNS+XgDwLuuNE4E28B1TgPAqJDkUGQRMs7HDmGfDaK4vHR6qkl3sPC7IW52WN47G
 ZzP5j42yYuYtIkNwLo3ddlSOSwYgvTdHPiDINTIxEaJ0GjOR+uBtnIeD6aQDQF7qnhJK
 ojYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746428077; x=1747032877;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lhg+J/QcqAP+oVJTufv/v7f+jVoVu/5E0hPcs1BlPG4=;
 b=tCZ8MJPHaU4ALpmND8Jat6PmLykq9Zsd5ktyceBGOEwBqd0Yn0SDtuaRUZNbdT39FN
 BwJQdfSAejak4zwb/t++jDvWKKQP0y/mLkxJIo1MKaAkBVm5F7Rh/gniSp5kPtU6/nON
 GdmLNjheponR2i/kaW5abpNDVxXvJavcKj7WIlG/5js7v5pDK/ptPnaswS99cEhYL4Db
 g76DKPObAIYaB1dHLdk2iM67T4XmTmrPo2O9K58kTJZAeOG2+jrR4CDYjYn5z6pLI0yI
 4f7rJ7WAyFg/AlfhZvdwfDYoqpn4NRffFwi6H59jYrjJ5iUsDGublkGcs3Em7kqvOvlp
 mf3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX2YLM4/wjmsOoV6D1NeYpuIYlI96XmTVwp/5ASBQe42QDw+DuSn83O9kqzJaBIB2QGmP10Q0Pil8=@nongnu.org,
 AJvYcCVr2EmMN1MSa+OHR8m8uF4bHEUFxSxlzukw7Y268PFXK721xNlRYg5LKqAMnNgWGX8fXYcAExYnZcXGew==@nongnu.org,
 AJvYcCWFbMBMHmoI4jRgZls/Y+hKVo6cVQX55AmIH93iDatELKJQQgaswCOSqoT/MhzkDqfL68yuXGPJ29L/@nongnu.org
X-Gm-Message-State: AOJu0YxwjPXQzMAkPviAe/m4zFEg8uGyFNjYVB/vT/o2Ty8lVfu8B69x
 lnEJ+3zMbbGleKI0j/WMLmj07v6tms6zj98vJqYmfcyor7Pl6eUy
X-Gm-Gg: ASbGncuzyEIwdo17eqOTTieRs9ANG6viSmXx/T8D5nARjfqVF2hH62n2derKnxEV5y5
 kFCHViC4Zxty8J4pQrpCzGnxd25CyLpLSMuB88Wnl6XqdjdGQ3tdykgpw379ywvFn5pohLaGEl/
 8clzm+rNPu4yrd/H7R0e9z+di0a3FHS8jOE0b8QNDqx891olHWx0t49FGV8t6JItGw9TRmXDbj+
 OoSwOR4XvT8l5UzUVVPU1YqD0SmxtRIUnp2YOOBsTpaVjS98V//rOYM9Kqsqr5uwHQ30UEIi1EN
 CSXA+wFTAkJ76cYFDZYsfxLzac4jf2tu
X-Google-Smtp-Source: AGHT+IFkpHjio01pQLg41VEBHkcS1TaMOjc6yT9RWg/E82xJZ4zDygmYabztRl/nDq+VEpUp+5KbAQ==
X-Received: by 2002:a17:903:289:b0:224:1609:a74a with SMTP id
 d9443c01a7336-22e1ea67c37mr100536095ad.34.1746428076747; 
 Sun, 04 May 2025 23:54:36 -0700 (PDT)
Received: from localhost ([1.146.78.151]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e15232648sm47415465ad.258.2025.05.04.23.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 23:54:36 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 May 2025 16:54:28 +1000
Message-Id: <D9O12YUPP327.2EA0I0SL5OGE6@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

Yeah that might be a good idea. I'll try out that suggestion and see
how it looks.

Thanks,
Nick

