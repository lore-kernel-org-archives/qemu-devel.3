Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1126E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 12:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWwsD-0004HS-FX; Sun, 12 Jan 2025 07:15:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWwsA-0004HJ-2g
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 07:15:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWws7-0002oc-Co
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 07:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736684113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HvFJhUqrtq6bQfE2kSYXXfez2XKH+rcw6PtUjI6Io8U=;
 b=YN1ZFUHqScUdAP2JV0VdmT2VuUywOjRiHjoeY7PAj3bnxTfYJiN17bNtwUfE6gxewtQ1cy
 Xey7H9dZbNBLUaOrJFDY6BO3pY2lF3nZiagYofrxVY913WCiRTAIDc+MLKXbJqdx1juE7G
 vYGnATne3ZOq3Tz6hp9XiipRgH+pn90=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-PmYxhdFBOmCOrAL0yK2thA-1; Sun, 12 Jan 2025 07:15:11 -0500
X-MC-Unique: PmYxhdFBOmCOrAL0yK2thA-1
X-Mimecast-MFC-AGG-ID: PmYxhdFBOmCOrAL0yK2thA
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ab2e529dc35so217544966b.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 04:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736684109; x=1737288909;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HvFJhUqrtq6bQfE2kSYXXfez2XKH+rcw6PtUjI6Io8U=;
 b=rf7XJq1WYsdby0SznFTWPxin8h+i78ogC/waiVjlDrclzQ5wcLee6ssLpXAzLykCKL
 3ckgUZD/PHj6yKd5Oxpvck2FOKwbaVfIB8kUpMwBgWOsVESteEChQf5WachKlH7Sy3fs
 GahM5WrdijQmlsRo2Z9MbQ7D8DRkJ6nmo5WK/8eet4Vm3TZSd1nZqdej0smVfnj8gMS4
 2cTe8mXzmQzJsUm1hM8UerdaiAS3APH9v3FbItL0umeOxlHXPH1UCbO/yzOpH0wglYfw
 d33NVa7KkFRjDhkKzVGORgJ6lc8nTNPBo7+8D1uvc5ppVDwNvlYeLNV3iqsKlnZXRRii
 Vb2A==
X-Gm-Message-State: AOJu0YwSqOHVDDI2sUCBLlucblRqqXNdsC0467nJHMhH/xBDSmg5P3s0
 N3AzNYNgRHESEDWWGnj9KvEOodzPA7mB7IlXZquAibbWgCDnTneC6KzUAKOzrWFvutlzGYbKwd8
 /dUDLyNQfgAlrCF+oeIheQ6ndKCGlPVlIJNcCqKKZezSucUQxwpDa6di6kLgl39c=
X-Gm-Gg: ASbGncv0CxM3+I+TND9d2KP0hKiCTf3M8ojmshIyx49/S6jj95Hl8gsT4ULi2kY+rI1
 d63s8ZV2yQ0KT6n+Y3iK98/TZA/i9Prlmd/BLmI4XVIYGGwVfeobxxzROOQ2Q2XFkqIBare26e7
 aO+VgJaeTSuCJpHnzBBKZxMui9+DOQX/NI5zakAVubnosdYaJVzUePX03ldZIoiyst1TTsynNaX
 c9XeiuEkUU9XGqFkwjM2hqHujkQIiXqgjXwdBBSVWpFJwTug2/pVGM5vDw=
X-Received: by 2002:a17:907:3e9f:b0:aae:bd4c:22c0 with SMTP id
 a640c23a62f3a-ab2ab70aeccmr1461046266b.19.1736684109409; 
 Sun, 12 Jan 2025 04:15:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWgPEG36JaIVRHxIySqLpl+6fC3J1jTbKRS5ltu/u5h7YrgN+9cocbtYJpeArZRlhir+HMWQ==
X-Received: by 2002:a17:907:3e9f:b0:aae:bd4c:22c0 with SMTP id
 a640c23a62f3a-ab2ab70aeccmr1461044866b.19.1736684109066; 
 Sun, 12 Jan 2025 04:15:09 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ab2c964dc9dsm371000066b.178.2025.01.12.04.15.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jan 2025 04:15:08 -0800 (PST)
Message-ID: <633c548f-2053-4bde-9fc8-52e4dc418d38@redhat.com>
Date: Sun, 12 Jan 2025 13:15:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/38] rust: add --check-cfg test to rustc arguments
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250110184620.408302-1-pbonzini@redhat.com>
 <20250110184620.408302-3-pbonzini@redhat.com> <Z4GRpOqXOka2f8Up@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z4GRpOqXOka2f8Up@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.025,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.798,
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

On 1/10/25 22:31, Kevin Wolf wrote:
> Am 10.01.2025 um 19:45 hat Paolo Bonzini geschrieben:
>> rustc will check that every reachable #[cfg] matches a list of
>> the expected config names and values.  Recent versions of rustc are
>> also complaining about #[cfg(test)], even if it is basically a standard
>> part of the language.  So, always allow it.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> error: invalid `--check-cfg` argument: `test`
>    |
>    = note: expected `cfg(name, values("value1", "value2", ... "valueN"))`
>    = note: visit <https://doc.rust-lang.org/nightly/rustc/check-cfg.html> for more details

Ouch. :/ That's even in the GitLab pipeline...

I fixed the branch for now and will send the v2 pull request for the 
record tomorrow.

Paolo


