Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2981AD1037E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 05:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO8Ap-00042u-On; Wed, 26 Nov 2025 00:34:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vO8An-0003w3-C8
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 00:34:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vO8Ak-0000YJ-9b
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 00:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764135271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Yw3tvf8LTq1b43s862XXuy/uChwOoza35QQWV2AqGYU=;
 b=XdUv9k6Yqf0XpjOeeYwSF3ZnbqvNGNy9/c080/sMZ//pr/CfgwYpCfKSaUOQWcT78ngd5U
 nJizHzs6qI0pZNznovs+Pz5xUKGVbY0tb4CyBxHsvBy88Qaf+qZ1U44AGCbuXPSLCGS2YM
 plUX0uv7PzHr3PDj52Ii2v2sByAaiLo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-uuINdbaFNpq97mMxvC0IAw-1; Wed, 26 Nov 2025 00:34:24 -0500
X-MC-Unique: uuINdbaFNpq97mMxvC0IAw-1
X-Mimecast-MFC-AGG-ID: uuINdbaFNpq97mMxvC0IAw_1764135264
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-640b06fa998so7145068a12.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 21:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764135264; x=1764740064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Yw3tvf8LTq1b43s862XXuy/uChwOoza35QQWV2AqGYU=;
 b=AjqTc9CWLUWxRzcBP1dHDBeBd8TgYR9R0E8iseVUlH3m0406Nc9e+ytOc2TtuC7BNl
 Feid9FbWwJWd6ObAW0W4kSkRxegV5LuCJEUBoQ6bAGBTmzSotddrz+wv2zccLh10rpcy
 Pe33nIOd1EjRSPVKFfay5cEH/tMpYprulZrSgMnXam4Zj8l095BgAXVRp69d0fh0jkmb
 DtbcDLMd2fgC7hq9SqI3qpmQ2pyutCY8mSokYCQgQkL7lpwXX30+NJo0z+9jkpKnQk58
 MxWUPlZ83N48Rnn5nxm5vnkDOVlQqpj3HxkWfkLa4WcPG2J8ZLLp7sS0SMMxCWkZrf4N
 vRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764135264; x=1764740064;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yw3tvf8LTq1b43s862XXuy/uChwOoza35QQWV2AqGYU=;
 b=m1aItW0yUklnxbFnQc3/XAGBU7VUL4JXhcTACCeYIMDByCHx4P60vvQdueKq9L7I1d
 n23RnTtAyE95XR5Vj6neW63TTPTXJvPktCzdK+zAnri0wbp9VASpiqn7Nv9VHdT0qW8a
 avckIHXFkBbqmU7rBkx8pRb88aGJ2T6FG/eaH2flOIhkWhuGiNi6A0J4fErwa11SEObz
 LxtzXhM34DDZQlrOOlAP2gFztLC6eCeH3AWBKMoGAfNDEnAgJZ0NizvARQXifOEMRKkr
 H/bqwbmFtFj4Ex64PVqtlWXCqYHKyueoYcxeg6xBVIgxZ1SW4AmL9/y2PemW8e90gOFA
 7WYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYsU3dcaNj3TdVq11g49d4+9eU3wvv9hIKkPj9A28oAENha6XzMlYuA42nwPjIx8zx0D6/A4EUQAk8@nongnu.org
X-Gm-Message-State: AOJu0Yxqu6fwEC7EOQt42RZdp+8X1JgDWXLnZXrclaun9meekCVxzty2
 N7N/urL1s7XDnDJgWbW6zzb/gmafRlL3wWat/w/vR64/CApY/M3bQ8RoOB7XvqPAmAoSkwA8qth
 nrG0z3/8OskneyxZvARu1R3kiACTP8G1DAi6xklgQrRLuw9s58PFLX7tF
X-Gm-Gg: ASbGncsxJe0a1lIzeSUOJqf3nTNGTaS4UZzZrnqE2m/A5OQ2GGzpWk0Cd3DFIVQzgsW
 ub9Pr+foWDAmAyWa0/+Xi7Dr171Xf7/tg2qKbJojo3GokdbDjmeBoV9iskrwHK9tVMBvVA8iD8r
 XQAtndXyTYVSHdf/ftdqD+j4jgePMAVp2q/fOCptbOpJPEOyWoMz5whW0KbKvhsdPaczt4zmKqc
 AdPMf/rBn5NWOHa7J8Furuws40X8Fg0IIcF8sHOAOCv2VAoK1d35ufHu/C4HVkKWFaw7GMpgk3u
 sWfY+9ltzMc2j0KRliNIxklFha6xSgXB1HmR7nzm0oul8mNMV3Cmzop4Jm1GSDMsDTZgx5rmM2P
 jl+FzTZU=
X-Received: by 2002:a05:6402:35ce:b0:640:aefd:f47d with SMTP id
 4fb4d7f45d1cf-64555cd8cdbmr14087013a12.21.1764135263777; 
 Tue, 25 Nov 2025 21:34:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTsqo5yxY3GwsIqjX4MufNLOfN8wQ3Oups9ZPXFbIyxDTwA81MKWYJcFD65Xt/kbQZyeiG1g==
X-Received: by 2002:a05:6402:35ce:b0:640:aefd:f47d with SMTP id
 4fb4d7f45d1cf-64555cd8cdbmr14086991a12.21.1764135263416; 
 Tue, 25 Nov 2025 21:34:23 -0800 (PST)
Received: from [192.168.0.5] ([47.64.115.162])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64536443337sm16863957a12.23.2025.11.25.21.34.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 21:34:22 -0800 (PST)
Message-ID: <20a0d8d1-d617-4a2d-93f7-c8f84d7b334f@redhat.com>
Date: Wed, 26 Nov 2025 06:34:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] python: drop qemu.qmp from qemu.git tree
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Michael Roth <michael.roth@amd.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
References: <20251125040045.461148-1-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251125040045.461148-1-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 25/11/2025 05.00, John Snow wrote:
> Hi, this series does a few things, but it's ultimately in service of
> dropping the python qemu.qmp package from the qemu.git tree in favor of
> using the standalone package instead, to prevent any further issues from
> the two codebases diverging.
> 
> v2:
> 
>   - move "make check-venv" earlier in GitLab CI/CD pipeline, to avoid
>     re-running configure
>   - Fix functional tests not using PyPI to fetch pygdbmi package
>   - Remove pre-requisites which are now merged
> 
> I think this series is probably close, but with some attention needed on
> the mkvenv packages to allow installing the local python
> packages. Everything else feels good-to-go, as far as I can tell.

  Hi John,

I gave the series a try in the CI, but the macOS and FreeBSD jobs are 
failing now:

  https://gitlab.com/thuth/qemu/-/jobs/12211713065
  https://gitlab.com/thuth/qemu/-/jobs/12211713061

Have a look at .gitlab-ci.d/cirrus/README.rst if you want to enable these 
jobs in your gitlab CI, too.

  HTH,
   Thomas


