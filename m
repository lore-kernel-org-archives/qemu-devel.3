Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA11ED3B7F2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 14:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vScRn-0002Ir-0f; Mon, 08 Dec 2025 09:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vScRl-0002IN-3q
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 09:42:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vScRj-00039X-LF
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 09:42:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765204958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1Zm67u8dBeuAgieINhsvVRc2vcicEfxwl+tSLz/yxX8=;
 b=hiCPLwf1XEzCk0h9NAGVrU1XXloK6RRGPWQM1e1mkcKTAzs1xHxwWJl+fVPXac4yajSXq0
 zrI0+rSDhsWz9cO0AmenW52wNJwmhTRTFzIBrVg/NbP/7Z/ijEMcSCSOqT3zkD9FbhRHPN
 DjA7TX1jGRiCzb+GorspLqs17vLdCv8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-EFGOe5usOI-ENZoqQxgeBA-1; Mon, 08 Dec 2025 09:42:36 -0500
X-MC-Unique: EFGOe5usOI-ENZoqQxgeBA-1
X-Mimecast-MFC-AGG-ID: EFGOe5usOI-ENZoqQxgeBA_1765204955
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4776b0ada3dso25644535e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 06:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765204955; x=1765809755; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=1Zm67u8dBeuAgieINhsvVRc2vcicEfxwl+tSLz/yxX8=;
 b=bwXUrpw6diR0U8optW1S4SQcbUPwiVCcAx3N5UBcBw11O75Mh0sflp0zg77kObg5hD
 EWNBICUk8cgU+7hVz0AI26oypb2vyv4O95qhCA03AFd5gwhpiSj2kveiY1rUkltH+bYY
 c+Pb2HXzFUihDOr8wBFCFYnhSUWCzF1dnTF+vY3pTLY3tJSUr8HWuQzodws5UEmJOBjc
 UCg+lZ/izg83R2TXIIcxl22iQx1pDvmLvGe2esAxEGp/CW3m6WdOCXO8Ok830DXiGJnB
 nM3A1sjzImvt9nrAPLznWQ5k6mkh33r+9o9ueVdjZCS9AVgpbl5vwLA7zzKpxvGUW+iv
 siqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765204955; x=1765809755;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Zm67u8dBeuAgieINhsvVRc2vcicEfxwl+tSLz/yxX8=;
 b=Mj981i0BurlCnlRbh1mmKoVew4RnQgfZNTnkRsKYGu4wmr++ShyjkxUlXeu9ihuWlB
 i9sCH1FNxr5LMGZSQyOW32v/yqYGl8rtx0gktkmDQ814glxiOmdAIOe29F7dLsE+QDDu
 zUeuAIoiYaWmbJvTAkuCilcAYg1dzCUFSFPBaQa1muFsW9nsqwh66mcbtel1MKO+l7w5
 sLc/zzP1nZJJ3Xm9BiEaKQXOfjS/V4tP6b8ht076/bMmNSyKusngDMLeQJRQcRyT1Phj
 xr8YqrR1R2cYRXKOcC7rFyyxWbCb41hqqZh3ybbxZ3q4ADd44nttX7mqb5O3jlMEYzbj
 wIxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7GihU9xJBk87ORQUK8cvUEjmCK9JA2HdzelFiDn5liTkRjBKHihZQg9l6MAD5e+kqzFfhNbVA6ymA@nongnu.org
X-Gm-Message-State: AOJu0YzRvAlMm7Wr3Cf9YY+ibJhJStAQ9f3Ph57fL61YJIft4laNKofp
 xO8OKHhtR9spdApZrkht83eGS9yib87a/+H88mb2rN9Up5xT3pl5E7xhPZpki4EAx/UCY9Nfayh
 GOztsmjV2fZoFfG7FsVBYZOSLcBdCoBs8wwt/c+xSOf90xD81aNOpyLgt
X-Gm-Gg: ASbGncumDJw711R2UYQYUyynWqkAbQ57r+qLy7f90w2x0CeHMi8fv7o6Z4/YYTTsceN
 lXMjl8oG5n8ViKKPkSYwg70YI54LFI5KaVxZ0N5ywLKmp6RvOMwa49CH4t5HwMJETEPoES8bdDW
 VS6o+drRftWKvHW0av+ORznc6O1RpUdhPx3kGAWumYFq9Mx2jebwE/Orpem+Ms3aXcT2s3Vt5CO
 QxGrPaZ+8Qob0F9ShcH0X8yQql77L74sYo/YFV32evTGMy96b1jnbHysr8AFxsBl88SZmCL+1wy
 utG/W6b3eoh3uOpjVf7W72aeFRVyGNRiRsjHYvLO3GPvJGPjE4rk8jmoaaFdsP4TGt7JIeY35yX
 AsnP9oeXQ9dtV29vprTVYT30SWXFYaWcXy7QAurMMp0724Geh
X-Received: by 2002:a7b:c7c4:0:b0:477:9890:4528 with SMTP id
 5b1f17b1804b1-4792eb05eddmr112270655e9.2.1765204955323; 
 Mon, 08 Dec 2025 06:42:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQvapd8dngoqdI+CGL2+NM/eINF8p0K3Y9Hif6ibOV8jrEzCsD7O7xYSHcJOljzVtyfhG4xA==
X-Received: by 2002:a7b:c7c4:0:b0:477:9890:4528 with SMTP id
 5b1f17b1804b1-4792eb05eddmr112270395e9.2.1765204954912; 
 Mon, 08 Dec 2025 06:42:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47930c7473bsm378010865e9.10.2025.12.08.06.42.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 06:42:34 -0800 (PST)
Message-ID: <d94f5ee1-afc8-44e0-ba24-defdbb02b4a3@redhat.com>
Date: Mon, 8 Dec 2025 15:42:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Live update: tap and vhost
To: Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan <hamza.khan@nutanix.com>,
 Joshua Hunt <johunt@akamai.com>, Max Tottenham <mtottenh@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
 <1728acb2-e098-490d-b37d-7455679ee3ba@redhat.com>
 <bc892dd6-d54e-4e0f-aab4-5295cdf93291@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <bc892dd6-d54e-4e0f-aab4-5295cdf93291@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/8/25 15:22, Mark Kanda wrote:
> On 12/8/25 4:08 AM, Cédric Le Goater wrote:
>> Hello,
>>
>> Ben, Mark,
>>
>> Since Steve retired, we have generic names under the "CheckPoint and
>> Restart (CPR)" entry in MAINTAINERS. Would you be willing to step forward
>> as Reviewers/Maintainers ?
>>
> You can add me as a Reviewer.

You should send a patch, such :

  https://gitlab.com/legoater/qemu/-/commits/9942c711835f

Thanks,

C.


