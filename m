Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2359FCAC5B3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 15:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1o2g-0000CO-3t; Thu, 25 Sep 2025 11:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1o2X-0000Ad-UC
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 11:37:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1o2M-00046e-1Y
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 11:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758814651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bNQJIITM2tFao0NlH+7Q0exmGeE4I8URHpfL+F6GN7k=;
 b=QD20lTZlYMLq7kMTiUoWc3iGIfG8ORaTc1JyAYXo/52UErRPaAcF8ANIZySuZrZk5FtMmH
 CY3lzAjvUFJOwyODycay/v9Ouvjal0lnOcGm1wJgm7gUVS/aO17w8X6d5ZrNFDOCIcam9C
 iYau3/G7TAU4oJhfGDNkdDN+tqJAAYU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-exI5AqUjO-u-JzQgfVB-Pw-1; Thu, 25 Sep 2025 11:37:27 -0400
X-MC-Unique: exI5AqUjO-u-JzQgfVB-Pw-1
X-Mimecast-MFC-AGG-ID: exI5AqUjO-u-JzQgfVB-Pw_1758814646
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b353cefb829so86810266b.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 08:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758814646; x=1759419446;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bNQJIITM2tFao0NlH+7Q0exmGeE4I8URHpfL+F6GN7k=;
 b=vpDKtHBSX4X6AMCfw5JwQKFvMW1F6n9POwOn2FZOgE+u4RkMWVR4PVIm0gB5lF8h10
 ObB5jou1qiLZzz6d31HL2T4nWBo6WNKczMAH15fkhNoMBW8GorcXTHrRHdlEuyt17gse
 sRFLsZQ6dBJwQ2XQ5C9RmS14t5J9GF9st+gXJdkNDVDcXJsxToQzPsE3hRJ9P8Xwc3vy
 01prRUmY3OfV4gCSHlCmC43aozEMtBwCG1iIoaUYCQbDeD0uEpNiCv5NfNfra+9+Fm/e
 VNzmin9ynLNfrJLFAkPWAu/eHm4unGegcTlvAICGrCOmdIzDcgEsq4ccZmo1MM8u/f4b
 PB3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7rOePM729lZ0bws3q7qqk8pTUVi6CMrj6GtxxBMauYP7HqPxev2UIkN+1nAabnZnr98+gLjvIQE9r@nongnu.org
X-Gm-Message-State: AOJu0YwoaIs02v1KxA227X8OHCxkyHvvXsy/nXYVUYFULu9HWf4NFeCq
 xKShpE1zLPo/5goyue22KUryP/18+j6H6KSxDdcWNhVTMGNy9uvUawV+W89/YOdHzx5LGe4Nuhe
 YUoH6HD9JPqgGDOPvAT6eguUeDpcpShOXBb/lpTeX1lOrdBXaGOaQBMzf
X-Gm-Gg: ASbGncufDuodRs7Okhsds85DXonpGEZaiBzz11ary6eSNaGcqrUdwDI3bmYMKOW+2JV
 W0x0WV/38jc0eTE9BGjFSK4L9bBrhAWQ4VoQ9GFgAN5scW59JSsN5zA8MkpRbLkMJyKB2gMdxN3
 AOiM5O8s1lLh4szQGhO8TDKPAHt/Kw6m0Vl6iZilPrI6kiCooYK/pdeeg01sWsMaBkq7E4AeWZc
 6kz1ZXKeZ8u3Dery3i/iliPOoH2irvBwUpUSVklDDkSnb7AQzk8iCJZWrMFfqBeoMj2r59sOSXR
 Z+o5XtxhN6YgUddA6T7Nw1O+YDZPQU36GDuAzmz3i7hHNiHevtC60Qx2NbzNHtVGo3314nIQyHw
 1kv+2ZkpPT/wPw8JdbyVFvxhO7oIE5ViMwYJdvX5mHg==
X-Received: by 2002:a17:907:c21:b0:b1d:285c:e0ef with SMTP id
 a640c23a62f3a-b34bb701b01mr462993566b.26.1758814646139; 
 Thu, 25 Sep 2025 08:37:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs6012sb1K0S3n3KVk/XUVgsfoYpCZTEgwSF4OYo3pXkrlocyV2GV/bjOFlrDHsMA90Pxy9w==
X-Received: by 2002:a17:907:c21:b0:b1d:285c:e0ef with SMTP id
 a640c23a62f3a-b34bb701b01mr462990266b.26.1758814645667; 
 Thu, 25 Sep 2025 08:37:25 -0700 (PDT)
Received: from [192.168.1.84] ([93.56.170.206])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b3544fcdd89sm190852466b.79.2025.09.25.08.37.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 08:37:25 -0700 (PDT)
Message-ID: <d36504ef-6b5e-4764-aa09-9da6137e4f88@redhat.com>
Date: Thu, 25 Sep 2025 17:37:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] tracetool: Add Rust format support
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel
 <qemu-devel@nongnu.org>, Tanish Desai <tanishdesai37@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
References: <20250919112536.141782-1-pbonzini@redhat.com>
 <20250919112536.141782-9-pbonzini@redhat.com>
 <20250923192354.GL509965@fedora>
 <85ebee67-3c30-4f14-93ca-d9cf65708619@redhat.com>
 <20250924181024.GB6015@fedora>
 <CABgObfbDphuWOx9r8JEpQCtvGtZM2XYkEd+mBxO4LeqoVPvW6A@mail.gmail.com>
 <20250925115047.GA22729@fedora>
 <4d7d946f-db87-43b6-a5f4-4f6cc583df20@redhat.com>
 <CAJSP0QU-XSrY3NZFoSiFDPLduJw_md0+7YEGr3PZ3UEWGyvEsQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAJSP0QU-XSrY3NZFoSiFDPLduJw_md0+7YEGr3PZ3UEWGyvEsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/25/25 17:09, Stefan Hajnoczi wrote:
> On Thu, Sep 25, 2025 at 8:40 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>> No problem---in fact I have now realized that, for systemtap, I have to
>> ensure that the semaphore is shared between C and Rust!
> 
> Is anyone working on the DTrace support? If not, I'll keep it in mind
> in case I get some time over the next few weeks.
No, the plan was to use the probe-rs crate, which is almost trivial 
except that it does not support the shared semaphore.

For the shared semaphore probe-rs needs modifications.  It's also 
possible to just import its single file with magic asm[1] into QEMU's 
trace crate and modify it as needed; and contribute the changes upstream 
later.

There is also the usdt crate, which recently grew support for systemtap 
SDT as well.  It takes a much more complex approach and has many 
dependencies, as it almost completely reimplements the dtrace compiler. 
It may be interesting for the future since it is more portable, but for 
the time being I'd stick with the lower-level probe-rs.

Paolo

[1] 
https://github.com/bonzini/probe-rs/blob/extern-semaphore/src/platform/systemtap.rs


