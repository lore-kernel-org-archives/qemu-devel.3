Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82573C982DA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 05:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Wgc-00080C-5P; Mon, 21 Sep 2026 01:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x8Wga-0007yS-O5
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 01:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x8WgZ-0002E5-5A
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 01:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789968924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V52oqNR4NVIAj9fgT+1WyLsSqNdVhDDDgwpiTasJDds=;
 b=Y9zlCWIV5TQn73vOLdT+hyCh5Ij0fHYtQN0dqrP+2piJZSrSfxt3+u8uUuBClhHZUjKeKT
 dJsEFgCQb6APB3GipraWzAjliSIviX6kh09+x3uQgcdLQOXAxM4kKMs7Pma0GrgfbgtsCT
 Xo+KCJ1uRlsgvUwX8VdVkL3cBthu/vY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-2TWke6YUNCW3rsfal4WytA-1; Mon, 21 Sep 2026 01:35:22 -0400
X-MC-Unique: 2TWke6YUNCW3rsfal4WytA-1
X-Mimecast-MFC-AGG-ID: 2TWke6YUNCW3rsfal4WytA_1789968921
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49ccfbe060aso19062935e9.0
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2026 22:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789968921; x=1790573721; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=V52oqNR4NVIAj9fgT+1WyLsSqNdVhDDDgwpiTasJDds=;
 b=Jw4WN2IcUnStngt1RF30pX/a1iE117M5+x4fCF/dxr1uv/9XmK5vIU7O3KhBrPz0bz
 eM15axKevLPkxPq+3JP2IpxVqu8X2ieJfZqabht7PwYtvJ+Vi4Wa4hG3TvStmMkn2tvO
 YT7N00aCswiBcr0C3y1C3Nkk1Vhviwifl+MQI/SmYLpowDsdj6Wy2n4pr/TQsJCkC9YU
 WohcoKlXA836mh9oWAI3BGDZwgXSM+w+cUdmZpTz28Q0XecwV0kBUfAmI08Cbjc0xorg
 TtqR0f7dEb4Gy6U88PqfVrPkdqPSXzXZ31EsxLlKskXOSvKO5VVeXGhBpimZJCpHqCU0
 +iTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789968921; x=1790573721;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V52oqNR4NVIAj9fgT+1WyLsSqNdVhDDDgwpiTasJDds=;
 b=HlwkAlIrEXygUybE09N/MGRnNhK5K0TZzBvLfI9W/XgNowcONgGy69iE4WCdiTbxu6
 4NcgooP2nC+FdofTIOWyQJr6zlYL/Qy0i2QsZErDvOHaulO/gM2FsRH47mgbdkppeXMZ
 4xvxITPnTQbslYxzKQ5yqFbujdxhjCdh00JRa9j7m8GzesyHWbAZd19TsU9p11T6jnim
 FTbBZaD+GULg4KNGAfORIi+0Ne3ctUSHMNHOTCDH2BcvzFkf5PW5G4qO9qAD1AvuLRSX
 Vndv0crqJCR1jWx8t728EjFoGBoHL1ZprgoqndbmbSwjteXm3aNpFU6lrIfTf78t280Z
 sE1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqU6ycycCrUsGFmfKfHNQM/FqZNDYMlYdxWaYoEawHGwytG9GJDROiabbr1yYBeaXkHPnyIcF7Fbdw@nongnu.org
X-Gm-Message-State: AFuF++natszzBxWayZqDUp3rzae81OByjomOkPyH3M9FMTpv7gxlKNJn
 Vyml2jzNL5wz9HCyUxKzGxlLwiADls5Lcdd3jboGpH+ZCfnjJmCuTUzmM8T7L9Rk9SZ5tOFQUPB
 6kGKTe2TA+0BegAYUISgtqrzGCphPMMxcFBpjcue77fQ8dhYLUCnLfhYB
X-Gm-Gg: AYBFou1cT44EGsdGXjhrMxDHGAM/h5fXbGrBoe8Dh0C2q5JLZMfSaI7OuYSB3ARi1vi
 KJ2UMAExOt4t05Pq0hvoGI4Etxo/7Jj9kTDy2+XCm+0cffCnI2hpcdN8XiNk7EKOO1U2JtniiSf
 X0yesDC1yHLHsIxVuiclZT7vS28MGOMZv2+8Lt3Ak5zLXXmqRtyZgGrDCpTnfFD/o2G1DMz3osN
 j0ceq1EA2G+ajMePGpQUm9Ec19BPuO771WmGUeVFdBoGHOyVj6fK5wqA54F78csKsSwsgV8DwtZ
 R5t/+Z9vfkX8LFKg76slneziF5RbBskjKCT6GsKzY1J9LUEU3GBzx9pVHIsw1pKebAI1w8Of
X-Received: by 2002:a05:6000:186a:b0:487:958:795a with SMTP id
 ffacd0b85a97d-4871e238019mr13584912f8f.25.1789968921419; 
 Sun, 20 Sep 2026 22:35:21 -0700 (PDT)
X-Received: by 2002:a05:6000:186a:b0:487:958:795a with SMTP id
 ffacd0b85a97d-4871e238019mr13584885f8f.25.1789968921112; 
 Sun, 20 Sep 2026 22:35:21 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-487244229d5sm20737976f8f.2.2026.09.20.22.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2026 22:35:20 -0700 (PDT)
Message-ID: <c923b372-728e-4561-855a-c363a907023e@redhat.com>
Date: Mon, 21 Sep 2026 07:35:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: Fix meson suites invocation from make check
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20260918203153.3874488-1-farosas@suse.de>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260918203153.3874488-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 18/09/2026 22.31, Fabiano Rosas wrote:
> make check is currently by default running tests tagged
> "slow". 
That's a regression, it did not used to be that way. Thus could you please 
add a "Fixes:" tag to your patch?

  Thanks,
   Thomas


