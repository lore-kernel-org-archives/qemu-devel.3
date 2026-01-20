Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADC5D2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 08:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi7U0-0006ER-R3; Tue, 20 Jan 2026 03:53:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vi7Tz-0006Cm-RS
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:53:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vi7Ty-0007a6-4d
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768899181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LmF+Xv8BW1WzRntkzSKLO536IUl7vgsmDDR+ZVEj1zw=;
 b=aU/i7iDrTJYBmAVX6/ogF0OFt+BVShQz/+tOHIbFrhjQHpZRF7lpmfpS0dS/K8XXxlPT8v
 64jM44vkDEnwFzR3Tu+nH4ZSlbaOGyuOhLaTpAN6mZwl+oK9gSSpFT5nEkDYJqDX/7DlSt
 WTOakRgAE8C61UpC5CpuIho70PM5Nss=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-YRngdzkFO6qj1n0o69imhw-1; Tue, 20 Jan 2026 03:52:59 -0500
X-MC-Unique: YRngdzkFO6qj1n0o69imhw-1
X-Mimecast-MFC-AGG-ID: YRngdzkFO6qj1n0o69imhw_1768899178
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47ee3dd7fc8so37113405e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 00:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768899178; x=1769503978; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=LmF+Xv8BW1WzRntkzSKLO536IUl7vgsmDDR+ZVEj1zw=;
 b=U3vFVM+cXlYtwZmHeVBoS0lB0RqaNUriYXvU6x3pzlTzirgGZqNTtV1tFu/j9vANfk
 7FsWJkGDT099Nr8/kxhMp919ik6IOLR6wq6QDN2ztaUfbzDp4XW679KgRNR4yZOkoKW7
 xqS4RHp1tGuB6mRiMlLQ4aITElsirq6t/ES0vRYqCSSnqxLZD284j5EO7wNWVwidCOZz
 62Qg3LE1dgmF1G3uiZ9fck5q99iTy460zQPcvd+s2CGQHokYQvMZ1wG3mvMA6NwjbPhd
 1GodQCr//Z2ad3POcvnDdw9OgVvnQVKxxCYNstps+xM8C4WYrKKvI1uuoJPT0bqV0wBz
 ac2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768899178; x=1769503978;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LmF+Xv8BW1WzRntkzSKLO536IUl7vgsmDDR+ZVEj1zw=;
 b=lsPZtZuEo8GaCoqKPRsOx0DtstM/WWmZNukkQNLz7dOjRFQY6rkDMqsYrnbvVBtqhA
 pq+z2IRpyJ1Ed0lIBkskL7ZHMSSxMkYXhiXnAAQ4oKC/kNIOsSILF3BeFLaL6Kz0I+CQ
 PUEVDBWeVVIEIackHNSxXlKrytt5vPexZyyY/2SZdMK+E/aw2dDuLEF4yXvkehlkHlDS
 ZTPjXLONHS97GV0e+EMe5RWqFW9BoBzIGipnH12IzJZKz9UCwhU/i3rqCH/ynCb2Xp97
 kM6Ycr9pRbPityGOy+qIcKHutsmGHvVaz4Yt7JtEL5oU/zGbX0yLyCmA4LygQmCCYipX
 fJtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwGgzqLnAlI3xNJiBB1YgF2wZf0WZCH4q9aq5JV//jsZ+U9FnrHQKfvEtGL/oZnkAqB9Da7HHfhiju@nongnu.org
X-Gm-Message-State: AOJu0YxUgGV6PuvRyMi4QF/8KBzxI3FcI+nAezgSP/hEzJHSYxfrr1az
 bhdQz5MqlLeUOI9TXK9a4AqrKHN4nT6b2QsH5cRBQU/cekngY1YJAvZiD5vl+XA5PGg9vVDQQF1
 K3OM8Zku+Ukm2Jh6d6WQl0DxPBXVfcbiZBE0rL26LdpRGqs4uk+Jkb6+r
X-Gm-Gg: AY/fxX4rIAB/GhAvmBbiMKldlelSjyji76mCNLq+2/Uacb2RFD0H8eoJpHSvjX2ZChd
 4ViAXcw3cpARhF7Z5RGM1mZDTeRygIBTxpAse5fulU1JAU2zoow/IGz7U/I0o1i9DOg5hVPpMw+
 3yPooAH+AkVdoGQ4A0i4oD1OmSXfU+NL8NmWwXrgCGcpWdeifyRfNWtVLsOoqH++t5uNR56CC5j
 b0BHVA2/PwHFQCz67pokssT60y8fZAWjV6bhiJl7EHGmM9JME4MxEF4Zno95NGuu64Gr22moJuF
 7iJZi9ogv5YCwjFm1AGavdvZNALAVIH+ce2lFj4e+JVjkzaGdoZ68tEFJQZFGMxD3hqg9es68qw
 GLtbkcNlBm1h7pYNs5YUP/izozrMKsSE8sPs=
X-Received: by 2002:a05:600c:1910:b0:47a:8088:439c with SMTP id
 5b1f17b1804b1-4801eb181b8mr167427625e9.35.1768899178302; 
 Tue, 20 Jan 2026 00:52:58 -0800 (PST)
X-Received: by 2002:a05:600c:1910:b0:47a:8088:439c with SMTP id
 5b1f17b1804b1-4801eb181b8mr167427195e9.35.1768899177770; 
 Tue, 20 Jan 2026 00:52:57 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e879542sm245980555e9.4.2026.01.20.00.52.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 00:52:57 -0800 (PST)
Message-ID: <026d2aa0-857f-4085-af74-6a4336cbd1e0@redhat.com>
Date: Tue, 20 Jan 2026 09:52:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/17] tests/lcitool: add python3 wheel and setuptools
 deps for qemu
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Maksim Davydov <davydov-max@yandex-team.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Hanna Reitz <hreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Ed Maste <emaste@freebsd.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260119212744.1275455-1-jsnow@redhat.com>
 <20260119212744.1275455-9-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260119212744.1275455-9-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
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

On 19/01/2026 22.27, John Snow wrote:
> Installing local dependencies while offline, without PyPI access,
> requires the python3-setuptools and python3-wheel packages. Most
> distributions have these available anyway for one reason or another, but
> not all of them.
> 
> If you are asking yourself "Wait, aren't these packages guaranteed via
> installation of pip, via the ensurepip module, which mkvenv takes
> immense pains to provide for us?" - Well... since Python 3.13, "pip"
> does not actually come with "setuptools" or "wheel" anymore, and so if
> we want to build and install a python package, we actually need these
> available in the host environment.
> 
> (Note that you don't need these packages just to install a pre-built
> package, you only need them to *build* a package. With cutting edge
> setuptools and pip, all locally installed packages, even in editable
> mode, must be "built" first before being installed. Thus, these
> dependencies are being added specifically to facilitate installing
> qemu.git/python/qemu to the configure-time venv.)
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   .gitlab-ci.d/cirrus/freebsd-14.vars     | 2 +-
>   .gitlab-ci.d/cirrus/macos-14.vars       | 2 +-
>   .gitlab-ci.d/windows.yml                | 2 ++
>   tests/docker/dockerfiles/alpine.docker  | 2 ++
>   tests/docker/dockerfiles/centos9.docker | 2 ++
>   tests/lcitool/projects/qemu.yml         | 2 ++
>   tests/vm/generated/freebsd.json         | 2 ++
>   7 files changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


