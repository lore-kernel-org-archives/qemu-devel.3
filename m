Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC81E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 06:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKXTE-0002Cn-N8; Mon, 09 Dec 2024 01:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tKXTC-0002CO-5y
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 01:42:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tKXTA-0003ws-B5
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 01:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733726528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=47QraEJ+xuNrfTuFWCq0Utof6dbStIQa4X2tb9rCAyw=;
 b=h8G/HNrqT0EYWGaBeXGcFxAndZJQbPwLrjaUxmXu9hyr8+VTJo7h17mdNAuNndXjfcmVGO
 /DHs2kd6eKV1e8wXw2Gb7wQbSgbFrAP03REvidDg5WFEiz0E3mMBFLCX5kMzi+5hrdPc3R
 mGNNHL5YDp3vCBurCZEST5tOentohpY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-TtKThH1EMnufa4SWzuM-yw-1; Mon, 09 Dec 2024 01:42:05 -0500
X-MC-Unique: TtKThH1EMnufa4SWzuM-yw-1
X-Mimecast-MFC-AGG-ID: TtKThH1EMnufa4SWzuM-yw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3862b364578so1256074f8f.1
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 22:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733726525; x=1734331325;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=47QraEJ+xuNrfTuFWCq0Utof6dbStIQa4X2tb9rCAyw=;
 b=csD/Wq8ociAD60oozPdldggbkbVqhPy3NCZHotvuKC4AjjZjTRwtTxbCOf6HvKlEtz
 3v107i3yjx/tSifh5ayAgRpymivJFMH9udTbXPOq0zoaHtL1a9J68TvOyKOlv+o0IcIX
 YN2YUwZHslfW0eT3Zs6WMS9d7SV6UWUe02I4UvUsBAHEhRU/gVmrtEAoDrGE8+NuaY05
 Q3wUo+VqxeONIdBk8aETi8Jhj/Y3Pfw7WOepNe+e+h13m7AgrKFDca4YmvPvKOwD/kwS
 kgPw61EFpPkDO01ckMLi6EfkfBtPj/Wqa9O/YzEbUtK39Gls1Jnz9husua/xFXV8x3cV
 XQ1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaBmQRaCTDqV27BUR42ANJksgMObVtntD0wGeLb0Ak7YIDJs39zmRgwPw5FNFS6fNwovwk4l0hGxTb@nongnu.org
X-Gm-Message-State: AOJu0YwnQ4NUomauJUQlaq/CM/AKuCOu/++vPbWwBiOn4LW86J0slb25
 TqScYinLSkbvzhJ15VK71wDzWMfgnEEeXsaHKmRNXjh/QLkLes4eBVpBnYS1VPKQSLIAZzqqRKb
 iOsQHVCBw6YyZhCXZbX9UYMTZOmlDU2mihcHhXGqJVuhME5kf16jT
X-Gm-Gg: ASbGncvmqylFXjMed50eujrXHEyV7TbHoms5xApYDffzmUZdBegYjeopz3w/xdY8yr0
 ZE+SPG5VAkNNhUy5fztc7OrJlkfQnWBjgjrHW3CH0/0twvRk6n+49g30/akD4Mw50z6JUgQYh0r
 ejPYFOfzp6v839avhGHO5m55OZtjkThDmZ/9Yfwl815742Tz3Uuq4QHHam5h0PcXV0PlI15EZ+l
 G2uwpxFfgltR8rA7nEbduEXgkk8q7oddYpytThLbAYMw7XP9lO0aGAirTDwffYdiwRvMfT1xo4k
 IK4=
X-Received: by 2002:a05:6000:1568:b0:386:35f2:a3a with SMTP id
 ffacd0b85a97d-38635f20cfamr4704021f8f.11.1733726524772; 
 Sun, 08 Dec 2024 22:42:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxpZSaMrvlFzny5Vc4vzMnegQYgl5odJXJFZTc9Ucn2NJUAunkmUUGVz3G1TEalSlWvLJHeA==
X-Received: by 2002:a05:6000:1568:b0:386:35f2:a3a with SMTP id
 ffacd0b85a97d-38635f20cfamr4704012f8f.11.1733726524479; 
 Sun, 08 Dec 2024 22:42:04 -0800 (PST)
Received: from [192.168.0.6] (ip-109-42-49-52.web.vodafone.de. [109.42.49.52])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434eb8f18fcsm72162335e9.24.2024.12.08.22.42.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Dec 2024 22:42:04 -0800 (PST)
Message-ID: <50d9751c-5399-4caf-85ed-912aa8227aea@redhat.com>
Date: Mon, 9 Dec 2024 07:42:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Please Read: Error in website redirection
To: Myles Wilson <Mellurboo@outlook.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <AS8P192MB200003EB31EB6CD8EF3FE6C2B1332@AS8P192MB2000.EURP192.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <AS8P192MB200003EB31EB6CD8EF3FE6C2B1332@AS8P192MB2000.EURP192.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08/12/2024 01.17, Myles Wilson wrote:
> Hello,
> I was recently trying to download QEMU and noticed, on the landing page of 
> https://www.qemu.org/ <https://www.qemu.org/>,//the button titled "Full list 
> of releases"
> redirects to https://download.qemu.org/ <https://download.qemu.org/> which 
> results in a *403 forbidden* error.
> the same issue is present throughout the whole site with any button or 
> hyperlink to see full releases (even the one found in https://www.qemu.org/ 
> download/ <https://www.qemu.org/download/> )

It seems to be broken for "https://download.qemu.org" but if you manually 
add a slash at the end ("https://download.qemu.org/") it works at least for me.

Paolo, Stefan, looks like a server misconfiguration to me, is this something 
that could be fixed in the configs? Otherwise, I think we should update the 
links on the website to include a slash at the end...

  Thomas


