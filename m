Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D00BC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh6QF-0002gO-Sz; Tue, 07 Jul 2026 10:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh6QE-0002fs-3V
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 10:05:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh6QC-0001y6-1F
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 10:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783433111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9ZpDvP9ORrYZ+gULk6fyKsTTX3L2zi+tlhvt2rwuV0E=;
 b=i3NSCAAD6uSl8TkBwXk6C2Yhst31b5gS9oS1Mfe8l1O0j3K7bET4xavXPmsnirXeMNf/qQ
 kmw3ggmuJsynna9L17wgJSL+iTaGRqngvKm3WpjJGgKWQwrnTl8qZhfnkEOxzp/+tKsgr+
 RVflpn892lx101mQDSVtXW2trRNoHsA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-CXTxxhsbNaOit4YcGS7A5Q-1; Tue, 07 Jul 2026 10:05:08 -0400
X-MC-Unique: CXTxxhsbNaOit4YcGS7A5Q-1
X-Mimecast-MFC-AGG-ID: CXTxxhsbNaOit4YcGS7A5Q_1783433108
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493b0fe95b6so24669645e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 07:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783433107; x=1784037907; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9ZpDvP9ORrYZ+gULk6fyKsTTX3L2zi+tlhvt2rwuV0E=;
 b=WwLD5nX3eCibID4oWmBupn3f0FAHXpIcxoTUlfUpdlPC7H2H35IlPrxniIRIfCGABT
 7iGtZjVdRPILf/+TezJyKYdNhl5kHC4MdMeJMSuzMjv6jdl3ay/GhJlL1q66ivr+s5Cz
 goixPOn8xqPF3am00vFysCZSjDeoaqdTW2uIPBy87vL3pG/vG7xqY6IGaVRfZ1BV6GHX
 YD0WUYsIGx8LX0+fv5+Ym7xvODLmOjxjTXY2O4I+Btf58Giw+zmsqDoqDylw8GpszZb6
 gSiJAQJagj2XOUTCmUaWHCAwOg8Z0Ect3KX0GCWWK3NpUseYtHljug9vUe9P3HuBf+ii
 7ZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783433107; x=1784037907;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9ZpDvP9ORrYZ+gULk6fyKsTTX3L2zi+tlhvt2rwuV0E=;
 b=OHdIzdft9rvSx7HNTi4tly9clkmymxQBri3CNhhtiaHbXi29JSb/eKv8EPUqalpGKK
 UOvuruD70dGp1jvOpAxmNln4BJQrwpKcuIMMG41pwDAxy07nl2ft5omaDJlI1SwMga0B
 /ur3L6Q259jqm7Gcpb5/1xVR/Q7D9BkVcKRYGoJTpfwXWwLHvj5suvhxxalizxRgt66L
 YFjnkmycNVyNPBpmSMYBxfEoKHAqPnlh5bliJ+LKh7jX9ZKREIgqAMSFPFRSK1ODt4o6
 8wn6SPrIiUUsRHW3Xg9B5iNXffVKeQZYiL9WITW5QSz8X1YXAgQRVuo70Lao78KHBgvm
 s7Nw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqh4DSvRCNbBnbcuAvo2L7ZULaaNk8HEbASb0mhYP0UQR46tD7RwbpO9MRizwHBDOJHkHQURBsiEbSB@nongnu.org
X-Gm-Message-State: AOJu0Yylbqyk3fJ2YkqCd9OyePuZAdb/vFjWVJkJM8ABhyPaw78c38Oh
 jQRPq588U4TRVwpYJIkaZmwL3CIYDDbDgqtUmZuDGWFT0PWHI659lRgIkTLuvdh5Eaztg1ugxPl
 /SlqR3jGkinO1Umdsnn0Zzls+XtV5Yd1npLLf/kwT0S+wjNzpUkaGtUXV
X-Gm-Gg: AfdE7clKpYRG0/rB3MHU5lO4ks/qjDq5iaSi6Y8hsRjpd2MFu2Rw8snMNtC5W1e2Npr
 3OMUDOcgrhV3G4+G4pUu8HmSA7InNIvmAg4rT2u4Nl8oS+lVyT+xrBrlBs3XEuMYA/LwU427Awa
 +ltAVtk7gNeL1a9zMw9PnfVvOaGBAbNnGeppZkVJS6CfkrEvf/MrThJtO2+DzmDTFzMGvHYcVIX
 +HsUZLjO/mlb7uS3sNO8kTMwGmJptsX9bwiEtZWlJQTArLgd6JaBRHR1mNm1bKbctm2niLasEUR
 HRzOe5tmxAswsAwwaqdYK1Dv1bTtKJfu2ktqli67raoi+kvIJhk8NOUfbY6YeImsn+3tQyAOHeb
 EVcBdC7EtCcaLgTrqwlQbZTTQoXAgXyNP869xX/883Z6wQLkZPw==
X-Received: by 2002:a05:600c:350b:b0:493:c77c:108a with SMTP id
 5b1f17b1804b1-493df09d2f6mr60578665e9.36.1783433107329; 
 Tue, 07 Jul 2026 07:05:07 -0700 (PDT)
X-Received: by 2002:a05:600c:350b:b0:493:c77c:108a with SMTP id
 5b1f17b1804b1-493df09d2f6mr60578045e9.36.1783433106765; 
 Tue, 07 Jul 2026 07:05:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d7801sm34625902f8f.16.2026.07.07.07.05.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 07:05:06 -0700 (PDT)
Message-ID: <a13c292e-fa89-4953-9893-d09629ac9872@redhat.com>
Date: Tue, 7 Jul 2026 16:05:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] hw/block: m25p80: Fix dummy byte handling for
 Spansion flash
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>, Hanna Reitz
 <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20260707083431.219671-1-bin.meng@processmission.com>
 <20260707083431.219671-5-bin.meng@processmission.com>
 <92dd132e-e4d5-43f9-a207-c59697c87204@oss.qualcomm.com>
 <1e79dc11-0df2-47ac-a1c5-819398303e48@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1e79dc11-0df2-47ac-a1c5-819398303e48@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


>> This breaks the test_arm_emcraft_sf2 functional test:
>>
>> not ok 1 test_emcraft_sf2.EmcraftSf2Machine.test_arm_emcraft_sf2
>>
> 
> 
> No problem on my side.
> 
Sorry. you are right ! It fails too.

So we have a machine using a Spansion flash.

     spi_flash = qdev_new("s25sl12801"); /* Spansion S25FL128SDPBHICO */


C.


