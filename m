Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BB7E9128C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 07:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnuAU-0006TE-He; Thu, 05 Feb 2026 02:52:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vnuAS-0006Se-RK
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 02:52:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vnuAQ-0007J7-AN
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 02:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770277964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8Qho+huysIScBhKvKmO4lCdU3Y+8AzrohpzfVM5PVQ4=;
 b=RYU0b4H10dxTiz7Fx9LZbk/iwd3bHe/Z6dLdhonw9ua5+RCsbS5HY6D+2X03VtcQz5S3lu
 2t2vEPdUB7nGS1XjITx2L+xhN+uQPMkY4gMngT+pavssmfQFzWrg2dhTq3cxdMZse3Cdsm
 QPyKjjvmv94/FBz1/Hmgr7wKtFhQX1w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-LtMl6GmPOSadRX4dwvfFcQ-1; Thu, 05 Feb 2026 02:52:43 -0500
X-MC-Unique: LtMl6GmPOSadRX4dwvfFcQ-1
X-Mimecast-MFC-AGG-ID: LtMl6GmPOSadRX4dwvfFcQ_1770277962
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-435aadfaf4eso469276f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 23:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770277962; x=1770882762; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=8Qho+huysIScBhKvKmO4lCdU3Y+8AzrohpzfVM5PVQ4=;
 b=tBxSgvWXTDJctIyWduV6TAiFpCUX2FsuoLjtBuaJa6AnlNWdnBvphV2GGdE3AtNE/7
 trEA1dVAr7vxQgoNDCZZ911cwm2qcsKGBTzELgmjSLJuQFRaXMh4t6jTLck3hRf5XaR2
 kw5zViN34M0oeCJDYFgDGGSNm/RRaZVLaOTvqtMOJTp9SwhGkt0gC334Ys8TpOhBg2IS
 I9Cym0vB3mlD5K1ql8V2mdPudJxGOXo0mK5vbF09+U5ifWodg0nZqER5anrUMn46tHpb
 bAmsvNwlmGntcycnWeWbydvWB+Mzt5t8u1UbBQhDVagUI5mVU5qcAznTUKbgmeQ1cLn3
 ecgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770277962; x=1770882762;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Qho+huysIScBhKvKmO4lCdU3Y+8AzrohpzfVM5PVQ4=;
 b=pxepbtmaPhJjm/eGuDZRn5Hqydb1oFm5LaBJGTf7v7gQpizAr/dlLu9sWuadQGEmdV
 5hpv0/r7RmdjXHLDXUl/8kxpeQEWSeiY7tZDeEUMUr+u1PAEbWZomRH3AZcTrHbgllSn
 KZ1u8cK2+/EZnPJSOd9vGGjPBXAOXIam30KjgT+Syg7yDGLy2mhViIPBGm5eg3AIjBFh
 R2YXUffxg6qB0EdSsPXoUZfsdrblLOEhEvTFqkzYKQqBfebqygV1Rd8Y/waN5T/ULBbz
 k0Wl3M95TlM8D+OBwpb+rpsmlfgDCZiF2QlZ5kWHJkTCq+ohsEaKCCtopCtfSa00omRc
 WF+A==
X-Gm-Message-State: AOJu0YxITzT+WzMezyDNsEL/2AYM07eRwCQVmSg9CGoCRgLMAo6hAZFD
 wqmjjqjOYMZWPIX/5qAH/jq865cctwKOkDj5tVpF2yXPylssGTYgsi67Q4c/rnYyC50VEHcfgnY
 ITxN68VfRRWCCK8K2yMIS7LQXKHtcRxhaSRLIyUZveqTuo0dqhYivFtpU
X-Gm-Gg: AZuq6aJWIGgmcNMIxbKp8zRYCbfF9JR4SsOhlYNX4eAPjqajl1k2K1v1VFWAGCwZ78F
 JKutHUTY0xZWBcx+HYhWQFNeCqcRH8LNopG9ggZXUkXR3QsjgnI5yV/muTZzANCacDMt6bCu9ad
 aYXC/z5OCbtqCNHm/4wlLturOa6jsWnA9IYs2oSHZ8B8G8h6fsZj9Y80DaUr44JVuwe6B0cJGDz
 x5idsHw6jhHejaFbTp2fyA9178BJV/vdtPURdvEW7QVlrxxHR1iCUdmrsziol4TCTvlfjF/PABd
 383QDx5XI8Sg7E+l5gSmwxo8EuGxPqYBii8tqAPS6lNvdPJ8q4TzY3AszqkkTEtXwlw+a7iyY2h
 hkZPFNHw=
X-Received: by 2002:a05:6000:1842:b0:432:a9d9:b674 with SMTP id
 ffacd0b85a97d-4361806172amr8142064f8f.63.1770277962005; 
 Wed, 04 Feb 2026 23:52:42 -0800 (PST)
X-Received: by 2002:a05:6000:1842:b0:432:a9d9:b674 with SMTP id
 ffacd0b85a97d-4361806172amr8142034f8f.63.1770277961591; 
 Wed, 04 Feb 2026 23:52:41 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436180647aasm10894802f8f.41.2026.02.04.23.52.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 23:52:40 -0800 (PST)
Message-ID: <f26f58c0-cae5-471c-a12c-0a429b8875cb@redhat.com>
Date: Thu, 5 Feb 2026 08:52:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/16] meson, mkvenv: add qemu.git/python/qemu package
 to pythondeps.toml
To: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Roth <michael.roth@amd.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
References: <20260203203512.672552-1-jsnow@redhat.com>
 <20260203203512.672552-12-jsnow@redhat.com>
 <CABgObfYtKr88BvhPUL4KfX464u=T4d7BP70XRLMdn28sXSKU4g@mail.gmail.com>
 <CAFn=p-bq8siBh0f2bs=x6ZeHQn6y2_2RuwKVnVrH+CvOTe-4ig@mail.gmail.com>
 <CABgObfYA12a08yXPsn84hX8dv59x7DDDLW0X3u5Cre3od6iMFw@mail.gmail.com>
 <CAFn=p-aforipvpRhUyLbStYPSRC4Pc0Oadcq8HzT7GzEGL+BnQ@mail.gmail.com>
 <CABgObfYOYykc+af+HawH9-vVj7vpUikrVPYDmY-ykD8cEVv-TQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CABgObfYOYykc+af+HawH9-vVj7vpUikrVPYDmY-ykD8cEVv-TQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 04/02/2026 18.53, Paolo Bonzini wrote:
> On Wed, Feb 4, 2026 at 6:03 PM John Snow <jsnow@redhat.com> wrote:
>>> Use whatever is in bookworm or 22.04?
>>>
>>
>> OpenSUSE Leap 15.6 and 22.04 until April

I don't think we really really have to support OpenSUSE 15 anymore, do we? 
16.0 has been released since a while, and we state that "The project aims to 
support the most recent major version at all times for up to five years 
after its initial release." - and OpenSUSE 15.0 has been released more than 
5 years ago.

> Technically for OpenSUSE we would use py3XX-setuptools;
> py310-setuptools in particular is 67.6. But yeah, 22.04 is the oldest
> at this point and we might as well pick that one for our accepted
> version.
Sounds reasonable. But in case it's causing trouble, 22.04 goes EOL on 
2026-04-25 and the next QEMU release is planned for 2026-04-14, so IMHO 
that's close enough to at least consider to ignore it?

  Thomas


