Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DBED1681B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 11:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veAzi-0007md-JY; Fri, 09 Jan 2026 06:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veAzf-0007m2-0B
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:49:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veAzd-0005ku-K6
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767959365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Zhz5CZ/t3Kx0K81Q/q8axY4crGyYZLKFaPYwyEYpmLY=;
 b=Tbwrd3k7RpL5NV5ecev/DIfQTXaWkre7v9nfWepNtfDkZMLJcr+WLnN8Xfywp/37xfQbM7
 Il5b1NG/mCBeTfCKD1y2+V93AcNrsEJruHsD+zFsKHIh/E6MjkMtBkymWg6UlHBkBWfjX6
 QE8aiyu8AUBQSIHgfMunGLkNy7AYomU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-xZPORgBJN5KjkgGqRUrgFA-1; Fri, 09 Jan 2026 06:49:23 -0500
X-MC-Unique: xZPORgBJN5KjkgGqRUrgFA-1
X-Mimecast-MFC-AGG-ID: xZPORgBJN5KjkgGqRUrgFA_1767959363
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47d3ffa98fcso29082555e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 03:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767959362; x=1768564162; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Zhz5CZ/t3Kx0K81Q/q8axY4crGyYZLKFaPYwyEYpmLY=;
 b=OGJYyMGIDICw1bi2f2uH4uZW4hkgpEHEFb4BT34bTEDA16KmiAqLVNAXLj2HaCHln+
 E2Syi+7kVxzA1oIo40xF3jMOAnmieE5heYySX5IN4LbXP5/WJIeAEo1Lqm26ueYoXn90
 N8TaqcNU48sYJexRPeoaUpEWxgL2ge7Qp6MTUWlV1I0JKrWnI4XG5v6jroWAS0s6JqrX
 zr2CeElwM7XIGzeiPfR1y02vEBx0an+4lipNdY/xB1ct/bWhg202+n1nYwYopaaDvmfJ
 rfz1zDGqIFL5y2urGwpfHWfI3m7qZHq8bSRedSsmFxkIIvU2oEezYKs+5Yomecbx9sn0
 u7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767959362; x=1768564162;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zhz5CZ/t3Kx0K81Q/q8axY4crGyYZLKFaPYwyEYpmLY=;
 b=bUL/9epmH1EMKZ3jS/tKhhV4UY6Q+pALDI3J9DLVqBMETilJMGS983mw+WQW8Dyp9U
 OFXjXWXLAFvFuLpVKPTw94fGw6ovGYcINRyPfU7d5bKGQM1BdRiJBErW5Y2Axru6V3SN
 0oxUqWQ70e3hhIc9zwV/pNT6eXyVGF/MEQ0+sFZ/fz/U3ZAQMclUHK//k21ZkFeSVgCm
 XgXiufgyVCcgllZppALQypcwa5cHCUf2GehM2oG/IU8t2bv++44gI6dcRiHPEFKQ7B5W
 VF6coq6b7MPcBCX1WnNM8ePZhvS9cyumnQ/gQwtsjqhWCVGlmRY2FnTdwZvRCIIWe95g
 cBew==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/48WIAXdYF5c5EtAvbTagZSat8rVQ5ecieqA8SOe18RRj4PW3rZSmKrPAbnC8CQs4pBVp6RLIyhDe@nongnu.org
X-Gm-Message-State: AOJu0YznbtB2nxG3gMz4GKoKNoobYu/v/N0hQG7s4TsYNYGGExFKHN2S
 huHznZMLG9lumSM5WmDa3mqJm9ipPG+gSPs2dgNxAcvSTkvzAXffOwV0zPdJv7vUlmdc32Xp6vT
 9iE6esJyBW8CmA/F1xOSYVto8xnFw704hYKjcMP91V3G5gz+c9NmmV8ji
X-Gm-Gg: AY/fxX7ubPD35rhVVSDUkxdB5sFdmWJW2hENsAc/NOcyTnlGedDRRxDLh1R6g1iE9e8
 wfIFFE7/NxwOADiOiO6xc1tznebRKu3m17vhytDpuTTsWrrXKI3T0ufd/IdJnhGc1McLH4cBugg
 45kWYoy3I6y/mk/BoDpNZhdU9l6e5Il1oZtlXtX5KG8zV7u07ROx/VF2bS+dO08wbiM/pg8V+xa
 HjYa7lYtCDlNr9PCFeP3ayD4asj9p67DuRktqaOOlIF0o9rDdY8aUKYaR5gVfn+s+W46yr3tJTP
 KViC+13cpHcEQhthJgLXxzHZWWBqDDAz79yw/sd0OnH/Wjx7SPl/u3WcQK4PSE1u0wcD7ghqOm/
 r52HjzIMIUHMNAnjpbEYLZOEdKE0XjuF3w1/Cm0ZA3VGri/0hdMIlXgiy9FnWps/rJlG5PYxBT6
 flEgCkkBQXwpSuAw==
X-Received: by 2002:a05:600c:1385:b0:47a:94fc:d057 with SMTP id
 5b1f17b1804b1-47d84b0b0e7mr96048625e9.2.1767959362516; 
 Fri, 09 Jan 2026 03:49:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEC7TKzBBhJdg/tVaSZWnxMh0VOJxGDBn10kd04vjVF5ezlG6f8rSbseVYuOzCeeYHorlo4pw==
X-Received: by 2002:a05:600c:1385:b0:47a:94fc:d057 with SMTP id
 5b1f17b1804b1-47d84b0b0e7mr96048385e9.2.1767959362140; 
 Fri, 09 Jan 2026 03:49:22 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-47d86c6ff40sm133057385e9.2.2026.01.09.03.49.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 03:49:21 -0800 (PST)
Message-ID: <8867bff0-227f-46b9-b0c6-938fc0d6f625@redhat.com>
Date: Fri, 9 Jan 2026 12:49:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/24] util: add API to fetch the current thread name
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-9-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260108170338.2693853-9-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/8/26 18:03, Daniel P. Berrangé wrote:
> +static __thread char namebuf[PTHREAD_MAX_NAMELEN_NP];

... you can instead of the previous patch, add a constructor here that 
just sets namebuf to "main" with strcpy.

For Windows on the other hand it should be okay to call 
SetThreadDescription if available.

Paolo


