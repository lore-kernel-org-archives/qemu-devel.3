Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E722ED2ECE9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 14:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viCRU-0004ZW-G4; Tue, 20 Jan 2026 09:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1viCRS-0004YK-2t
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 09:10:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1viCRQ-0001mF-Ge
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 09:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768918242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=biEriWypYV8n7KXyRIJjtlJmi3bc+/LzQPT0u4Tvi7Y=;
 b=gMesvsnWWeSOyyIDZI6XqnL0R4jPXP+pOu21ni+f6gNkd/m9o142ix0/s2fUE6di/NgL8W
 nzFoWXgakp+GXrKqEwgSMi78pAcp/M6NDQMU2VLWucOFnfqDHxJqn/vrQeC+/da1EEcnAK
 8IBnaj145aphC44/s/GTBeedfmxDwmQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-C4tALEU-M06JiVwhJ73SKQ-1; Tue, 20 Jan 2026 09:10:39 -0500
X-MC-Unique: C4tALEU-M06JiVwhJ73SKQ-1
X-Mimecast-MFC-AGG-ID: C4tALEU-M06JiVwhJ73SKQ_1768918238
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-59b6a9bf5cbso4118231e87.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 06:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768918237; x=1769523037; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=biEriWypYV8n7KXyRIJjtlJmi3bc+/LzQPT0u4Tvi7Y=;
 b=dwSR8Qhrgr7DgVn3lAk/C+4uDIq7bBQA+ldNGVSqdHsbtXMK5SRGt3F9h1cE47SaDq
 RqMOQ3ddDJO0Kxoeiro1G0vYVkh5/IhZGmbfHo7/WxuEVVqlofBu5dkyoeSCpNuGLR2n
 SKfd5AGYBP+c/b3oO4wkGzIGjRtIiUtlz4gTM0Nd6YOPwmjuFOxCMzLB2A1cSlbs3ha8
 cgEHoUnwg1fhSGfgg556AKP8sEsJjuCaGNMpnI0k0Arfj2FkiqkuVdIdVx0NRgn9CZcm
 RvyFHIVKisx9UY3Fne9t9Ih8d96w+eHW8Gk6mz8j5cV1T2rPObLt4fSF2rJGgn+1eHUE
 u00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768918237; x=1769523037;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=biEriWypYV8n7KXyRIJjtlJmi3bc+/LzQPT0u4Tvi7Y=;
 b=SsYyTALsNA4CUm93C1GiUNxLmaPG8nHj7e8cU69GXSeGuHcHlcSPhIeesTGEw8oKEB
 J8aEn79Jht2036grDCwL/VRmSqijneNNaV83upeW9DdgYq3urcdJsltOYTB9ZXQEAbrm
 8IWxeX3NWNEnxhdguYBOOiLaeScmwtvEx3pDkHQvJMntFZkVdx10xr0nox/H0PtXbpsO
 J6RSh0bGil+SXKo6MGUEiiKZi+yvMYUSuVIMny5CzGMQIwrHjOPqyPbYjsXRMg4nscAP
 D42psrv08eWMPHM/mUa8tLuCd8b3Jgw3Sz0Yv5Zga9ZjtX+c/qjew0t2c0rlbWMFp8nI
 0qPQ==
X-Gm-Message-State: AOJu0YxEP9YJnoszCJ3dFuRe6C1UMQNA4Sf1j5Ycm9yrJNVIytX8bH6X
 V8PhkVir5RwfLYis+5zwa1uCYlM3gABTBhqie0WvdGnZOHEKu5AcGja/qR8/l6NHlxUL+n+Akgi
 dmq72f6Y3M8JoEGFueIS1FyxgWq7TV9T1kW1P0mOhfSF+Y8XJOX8cMH9b
X-Gm-Gg: AZuq6aIvCcaDRUl6pmAzxGS0r1uMcJddA6WzU04VXQQHs/NiZCi/LPQ+AAGW3/v7rVS
 ZxtFR+3G7e1A63d+05+ItPwBC2/sJ61KSvU1xICqwvbjQNcj33/nD7G8+veN014gV67wk4w6+sL
 W1b/nRPwLBoCFlFEM5rwz0Yn8KeFi3ny0c0TwKrWphdC0lf0pMBYmBgx4Ft6aXNcdHtze5VIJ9E
 5Y1ltxo0Iz1CigVaw2m7NHrS0Tf+R4wt4sE5VV37aNIGz2eNqqBNMe4dtcQb6wiPB+Y/oddYp7X
 PcoFFGG0Dg9UgfK6biFkQglGZqbe2AP1TkcWU8AmNb5hlJEBmZip2odpRxFfVqwf9Sog6Pdivtx
 Ej8ahujQ=
X-Received: by 2002:a05:6512:1246:b0:59b:8436:79da with SMTP id
 2adb3069b0e04-59baffd6f05mr5287517e87.44.1768918237191; 
 Tue, 20 Jan 2026 06:10:37 -0800 (PST)
X-Received: by 2002:a05:6512:1246:b0:59b:8436:79da with SMTP id
 2adb3069b0e04-59baffd6f05mr5287507e87.44.1768918236769; 
 Tue, 20 Jan 2026 06:10:36 -0800 (PST)
Received: from [192.168.0.9] ([47.64.112.255])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59baf397672sm4220544e87.61.2026.01.20.06.10.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 06:10:36 -0800 (PST)
Message-ID: <4bee294c-e529-4e05-9bdb-48533aeff4f9@redhat.com>
Date: Tue, 20 Jan 2026 15:10:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts: Allow sha512 in clean_functional_cache.py, too
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260120121849.131604-1-thuth@redhat.com>
 <aW985Eq4d70yEPpH@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aW985Eq4d70yEPpH@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20/01/2026 14.02, Daniel P. Berrangé wrote:
> On Tue, Jan 20, 2026 at 01:18:49PM +0100, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> The functional testing frameworks also supports assets that are
>> identified by their sha512 checksum (instead of only using sha25),
>> and at least one of the tests (tests/functional/ppc64/test_fadump.py)
>> is already using such a checksum, so adjust the clean_functional_cache
>> script to support these checksums, too.
> 
> I wrote this code to match what we had in Avocado, but now I'm really
> struggling to justify why we should choose different checksum algorithms
> per asset. With only 1 test diverging from sha256, I'd rather we just
> dropped sha512 support

Fine for me, too ... could you suggest a patch, or want me to do it?

  Thomas


