Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FED0C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 13:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Do7-0004zf-Jp; Tue, 22 Apr 2025 09:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Do5-0004xi-QB
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 09:37:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Do2-0004Dw-VJ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 09:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745329014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nmbPKry/+lHMlDJ1Cm+Z4/sgXpD1yihoh4SQr69d5yU=;
 b=XJ5WAfKIsVmK6PK489si15XjP448wI4yJtEUe1PAdwH/CZOm3V/n1f0yAtUSPRvd8O9+4n
 W43A20t/qbbxTDbE08ax3Zrksm9wVrma+BrVApPQgTo9/RLfh0MvOzvtE7MkQ2WscLD7+l
 nwSXN0Z3dRI6Nfg2OtxtLwT+GBIXhf4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-o8n46GMLMSiscguXX91JCw-1; Tue, 22 Apr 2025 09:36:50 -0400
X-MC-Unique: o8n46GMLMSiscguXX91JCw-1
X-Mimecast-MFC-AGG-ID: o8n46GMLMSiscguXX91JCw_1745329009
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cec217977so27154415e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 06:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745329009; x=1745933809;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nmbPKry/+lHMlDJ1Cm+Z4/sgXpD1yihoh4SQr69d5yU=;
 b=jXFOTHa3ej4adK3R1G6ARShg1KA3SCW6o7C/T+9vqpMpo9ux7zt4K0j41S7H/RgwFA
 pVfrQ5BPnJ4YHFGvtsdvoNQ9XRXQajjucQ57GMhGNFBy3DojB+KTHInRR+Wq69ZBpm/C
 9bAQONe0AbEf1pKK0xqM6FBgKUWEytWcNrG07xoHleSIEZLHpFdV/1gAyAfVvU8R1a5r
 SoI/leSqfzPB1ZjUnuoDpatOaqjvs5QE8o195lYu6v4nEIw4tWkjWU44BBbGxgWmdmMx
 DQ3SS6HtSEVZ64erN3/9XVbxAGXuiOyA8g5UjYU1FLreCSNJZ/x+yYDP8bJe+tjtLbQr
 GD6Q==
X-Gm-Message-State: AOJu0YwM2Ej5siuOv6ZXiaokrhOMM/WWcngn/YmGaWsulczG7Thpx9jx
 yaVRf696mhaliR1LzPvTbbi7mYIfO5b+bA8i0AgFpzTGIsxqOO8FynDviN7TUnZh2ejtYwFVVV9
 j8WlW/nyu/fiEuCvJklBBps7zRL428kmsdUjcNAUP9/A3fI/5i3cE
X-Gm-Gg: ASbGncsdFQghaXz62OOrVkHgDJeeoiMsNrI85VgLINfa2p0K7upkzT6vjUOQOMG+y6+
 Nq5s7EoY1JT1Tn3kQ8O9xM07qH0Gj42udCO3SfO16oAYNubNmD4+81b2tF+TXyFmDqb/2vdWA9s
 qykc2A/WNmxJBZJfHn4qX1uIM/HK/6mY1BgocQXL6OhVzsh9DMPLHLnuSiAeMcMSe2kcDJwNz0w
 t1J78K8wn52M0TXJfXwzWSyYmvCz33dGiRzqRokwFBSbIr3mwwGv+PF6eLHjkntScKYCKbEyd3e
 5kcDjEvgbl+RI3d+LDshQh62IG6VRwsqs8kx
X-Received: by 2002:a05:600c:1c2a:b0:43c:fb36:d296 with SMTP id
 5b1f17b1804b1-4406ac0a9c8mr126900555e9.25.1745329009580; 
 Tue, 22 Apr 2025 06:36:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaSjz1PDOKC5Zkpw2VT83ZG9PHkK4hqNtcusR+0uiZimCR71jFWQMlRoUv+/sRxPHhme++BQ==
X-Received: by 2002:a05:600c:1c2a:b0:43c:fb36:d296 with SMTP id
 5b1f17b1804b1-4406ac0a9c8mr126900325e9.25.1745329009227; 
 Tue, 22 Apr 2025 06:36:49 -0700 (PDT)
Received: from [10.33.192.219] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43bf20sm15062527f8f.48.2025.04.22.06.36.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 06:36:48 -0700 (PDT)
Message-ID: <b48a034e-dbb4-48d6-a889-d0212cb085e1@redhat.com>
Date: Tue, 22 Apr 2025 15:36:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/docker/dockerfiles: Use Fedora 41 for the python
 container file
To: Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250422125626.72907-1-thuth@redhat.com>
 <aAeUx41_yHq8QA1s@redhat.com>
 <CAJSP0QUAUss1aGSYbcyprzuxQv4bEQGc_Owv557hK-Te0PKSaA@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAJSP0QUAUss1aGSYbcyprzuxQv4bEQGc_Owv557hK-Te0PKSaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 22/04/2025 15.22, Stefan Hajnoczi wrote:
> On Tue, Apr 22, 2025 at 9:09 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Tue, Apr 22, 2025 at 02:56:26PM +0200, Thomas Huth wrote:
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> Using "fedora:latest" now fails with Fedora 42:
>>>
>>>    Failed to resolve the transaction:
>>>    No match for argument: python3.8
>>>
>>> Switch back to Fedora 41 for the time being, to be able to still
>>> test with Python 3.8.
>>
>> This page details why it is was removed:
>>
>>    https://fedoraproject.org/wiki/Changes/RetirePython3.8
>>
>> Based on the explanation there, it seems doubtful that any of our
>> targetted build platforms have python 3.8. Thus I'd question whether
>> we should test 3.8 at all.
>>
>> IOW, rather than pin to fedora:41, it seems better to drop
>> python3.8 from the dockerfile.
> 
> I'm in favor of pinning so that the test is reproducible. A test that
> passed on a given git commit should pass again when it is re-run.

Yes, we also don't use ":latest" in any of the other tests, so pinning to a 
specific version also sounds like the better idea to me.

Anyway, if we really want to drop Python 3.8 (which we likely should do now 
indeed), we also have to update "configure" and 
docs/about/build-platforms.rst and likely some other spots... John?

  Thomas


