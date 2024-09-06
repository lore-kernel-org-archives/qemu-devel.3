Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF293CE7AB8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 07:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smTlR-0003em-Cw; Fri, 06 Sep 2024 03:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smTlP-0003Wd-AR
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:52:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smTlN-0002Ap-Pt
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725609132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=c2ykeHS5HVnB1uIbUoyC/rssVheEUlB2cDf+I6ecNFo=;
 b=NUjDY8YilQ6Md9DWwW0iR1rbWfMLvpv0gSjXFd0F5jwdwKxQVd4VUzd78DlccA3IhghR15
 41B/aFbTGXSyBOYx5yZA4EjjhwALNOza/lguZmN99GNIns3HWoJC05uM42d5fo7Ld1fASw
 CnDqnuWBNnhagDmPgRH2X/a16jupdG4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-Boc_GLW9NAOYOXhVlVRbwQ-1; Fri, 06 Sep 2024 03:52:10 -0400
X-MC-Unique: Boc_GLW9NAOYOXhVlVRbwQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5c3c205df73so1289980a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 00:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725609129; x=1726213929;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c2ykeHS5HVnB1uIbUoyC/rssVheEUlB2cDf+I6ecNFo=;
 b=e+svw3ypdgYRBGtY3Z7HUp7GkoWvpFxWIpxbmdRID2iibsBqghClPTsSE6gEbLYvj9
 /Q2BDQylZRKQEMPcX9AaDt00WYbm438D6ukJ0rj3AM/k+Koru7nTtfusl8xNjQpVJVFX
 sRqcsZ2zu0wlBs31AMTvLSynltJIxG+sa2duN6GDCmTHUWs7NrXTJHyPh82zZlTtaFyS
 VbklxA0ewgOykl2GSHZBjSkd1x9/2QmqwN1SeiPQjo63/v3GQVIY9WLnoEG/OMwH9uD9
 Kk9IjeIg2h25R7ctJG9+8cJm+dRH57yeKu2k0kkf6qR377tjiBD4gOe3HmXN58SKY87I
 NfWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViMuEvJZfgnkB+TjenQf48rDO9CuOGmaMKLJVwLro/iBfk6tkuICCQJL0SFZfvI7R0WKaS5KLAz9mI@nongnu.org
X-Gm-Message-State: AOJu0YypC4ZqoOkAPGCvNCSgazLFAFVIzRuWjky7wNDrUUhnjm9NB1YN
 vIYQZWYfufqHbgn1Hp1nH7soC36ycfRvtNZlCtL58OxTW8+dIeH/3BXSBAueylem+IYWMC+gB4K
 Wjy/7JVVeULqhFDVCDJLdip3yvHk5iF+/Sf0poyyHEGCFC9KTusl6
X-Received: by 2002:a17:907:961a:b0:a8a:58c5:78f1 with SMTP id
 a640c23a62f3a-a8a885bfc1dmr116960966b.11.1725609129368; 
 Fri, 06 Sep 2024 00:52:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbEO8YLbiHpWpWKG9u8jP/bKsWBuGBuD2oH/Q30K7Q6Qt5qXExFrX/E5KGhexWJ3qfj7QQQg==
X-Received: by 2002:a17:907:961a:b0:a8a:58c5:78f1 with SMTP id
 a640c23a62f3a-a8a885bfc1dmr116959166b.11.1725609128874; 
 Fri, 06 Sep 2024 00:52:08 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-115-52.web.vodafone.de.
 [109.43.115.52]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a623c1ee0sm238361466b.160.2024.09.06.00.52.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 00:52:08 -0700 (PDT)
Message-ID: <e92dc548-6deb-45b3-b564-ce77e00b5dfd@redhat.com>
Date: Fri, 6 Sep 2024 09:52:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] tests/qtest/hd-geo-test: Check for availability of
 "pc" machine before using it
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-riscv@nongnu.org
References: <20240905191434.694440-1-thuth@redhat.com>
 <20240905191434.694440-5-thuth@redhat.com>
 <9abc2f6e-6352-4083-b396-250e1ac23fb0@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <9abc2f6e-6352-4083-b396-250e1ac23fb0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 06/09/2024 09.50, Philippe Mathieu-Daudé wrote:
> On 5/9/24 21:14, Thomas Huth wrote:
>> In case QEMU has been configured with "--without-default-devices", the
>> "pc" machine type might be missing in the binary. We should check for
>> its availability before using it.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/qtest/hd-geo-test.c | 71 +++++++++++++++++++++------------------
>>   1 file changed, 38 insertions(+), 33 deletions(-)
>>
>> diff --git a/tests/qtest/hd-geo-test.c b/tests/qtest/hd-geo-test.c
>> index d08bffad91..85eb8d7668 100644
>> --- a/tests/qtest/hd-geo-test.c
>> +++ b/tests/qtest/hd-geo-test.c
>> @@ -1074,17 +1074,26 @@ int main(int argc, char **argv)
>>           }
>>       }
>> -    qtest_add_func("hd-geo/ide/none", test_ide_none);
>> -    qtest_add_func("hd-geo/ide/drive/mbr/blank", test_ide_drive_mbr_blank);
>> -    qtest_add_func("hd-geo/ide/drive/mbr/lba", test_ide_drive_mbr_lba);
>> -    qtest_add_func("hd-geo/ide/drive/mbr/chs", test_ide_drive_mbr_chs);
>> -    qtest_add_func("hd-geo/ide/drive/cd_0", test_ide_drive_cd_0);
>> -    qtest_add_func("hd-geo/ide/device/mbr/blank", 
>> test_ide_device_mbr_blank);
>> -    qtest_add_func("hd-geo/ide/device/mbr/lba", test_ide_device_mbr_lba);
>> -    qtest_add_func("hd-geo/ide/device/mbr/chs", test_ide_device_mbr_chs);
>> -    qtest_add_func("hd-geo/ide/device/user/chs", test_ide_device_user_chs);
>> -    qtest_add_func("hd-geo/ide/device/user/chst", 
>> test_ide_device_user_chst);
>> -    if (have_qemu_img()) {
>> +    if (qtest_has_machine("pc")) {
>> +        qtest_add_func("hd-geo/ide/none", test_ide_none);
>> +        qtest_add_func("hd-geo/ide/drive/mbr/blank", 
>> test_ide_drive_mbr_blank);
>> +        qtest_add_func("hd-geo/ide/drive/mbr/lba", test_ide_drive_mbr_lba);
>> +        qtest_add_func("hd-geo/ide/drive/mbr/chs", test_ide_drive_mbr_chs);
>> +        qtest_add_func("hd-geo/ide/drive/cd_0", test_ide_drive_cd_0);
>> +        qtest_add_func("hd-geo/ide/device/mbr/blank", 
>> test_ide_device_mbr_blank);
>> +        qtest_add_func("hd-geo/ide/device/mbr/lba", 
>> test_ide_device_mbr_lba);
>> +        qtest_add_func("hd-geo/ide/device/mbr/chs", 
>> test_ide_device_mbr_chs);
>> +        qtest_add_func("hd-geo/ide/device/user/chs", 
>> test_ide_device_user_chs);
>> +        qtest_add_func("hd-geo/ide/device/user/chst", 
>> test_ide_device_user_chst);
> 
> Just wondering, could a qtest_add_machine_func() method be helpful?
> Maybe not if we want to check for multiple machines?

For adding multiple tests, I think a check at the beginning of the block is 
better than checking it over and over again.

  Thomas


