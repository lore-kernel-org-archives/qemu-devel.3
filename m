Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B66E95386
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 11:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnb4x-0002wF-St; Wed, 04 Feb 2026 06:29:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vnb4w-0002w0-Tq
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:29:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vnb4v-0000uU-0F
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770204586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Govs1oq1tcQZmh6JtQzySed38GV3dIWKC+XzG9jLqF0=;
 b=PSqan6r89eg7kLL6mtwVFVOSAhTtSFoRfPb113/iarOoioGIdaKN/e7xRxxV/qoc2B9sP1
 XSQ/0ztHaZL3jeMUt46n5LOPhVGEiGB9oZmwVcPBvGDHmHV2cabuOPsks6dBMIGaAbOUtu
 do4q6+PWC6g7UIMmYeUYKOqz9Sq1kf0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-HpoD10BbPvCxsO-o7XeW4w-1; Wed, 04 Feb 2026 06:29:45 -0500
X-MC-Unique: HpoD10BbPvCxsO-o7XeW4w-1
X-Mimecast-MFC-AGG-ID: HpoD10BbPvCxsO-o7XeW4w_1770204584
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477c49f273fso67322635e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 03:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770204584; x=1770809384; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Govs1oq1tcQZmh6JtQzySed38GV3dIWKC+XzG9jLqF0=;
 b=LXeZOkFjc0ShAy8MgRKzT76WHsHcEEfvz+O67nr91eW3CbGz0EPaBEqH9EqlN6KrtQ
 qJc1HaSynqydGz1Yx/5JBTC+d9wxwojE5Xw/EDXqN9Mbo5u+6w5mEycMmzQA/lfJrPn+
 0bca/QkPy0dlL7OaOHaTvXhc0TpXMp/cSJq1JQ5v3UKqfa7uuMbu6Pgriw8R+Qk+C0s8
 IjSMkm2/x1quP0HzhtBSOOPSxkFlIVnczEmI8S32VezclTUeuRIYouaZMHQvw3j54PZN
 Yz/Eg/M070SwWLvaUiTbYa7RwyFY2oiJdJ+hL8UTKxveizjADZlNFUrNxeF0BqekOeOA
 9gwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770204584; x=1770809384;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Govs1oq1tcQZmh6JtQzySed38GV3dIWKC+XzG9jLqF0=;
 b=AiZ156wcXi93O9Qnspn0vZ7IHZqfYusbqjjpUKYNtp92BfXzOyaEp9sVN7XJ+FkBq/
 KwJJjHNmxA1cV4Q3yBbnXyIi/0Mzv4pT5+/LN2+WVNerq6pblh8qcXyNL0wjVk3k+ei+
 D2fbHcEzo6LU3k07MlBnJgK9zPARtZqQYF8cf2dNSmV6C74rZOi5/9M2n63DHCsPSJAK
 3MAU/ykmEiINE5MuLQvnyZUy6qVft8V6lo3F6v6TIgdCc7FjontsS1W0FMtmskRTMTiL
 2BbkSYMSarFXdF+8KxksIxZGYwjVfOkGCSnFX1DFKF39f6DxE33wjUlW53r8RDNu2m+b
 CFUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3rFz8q/ZiG/1MlGGcnblznJSrG73Jh2S/y+fTgjdTYJrCnmRhN3y4++j07DSQ6YhvKE1ecvpzAi6I@nongnu.org
X-Gm-Message-State: AOJu0YzYDceicXX9qIhqCtU/tZiwLzJmgPF/NxKT+tbeDDSvmp2y4U1P
 3aBSp+7onU+i1vx68IEc3EYxKzROhTdBOzCARi4hu4WbRE0T8AEjGeugkUjVJTTi8Kl8gd5V6yQ
 6Q1XLQ2cJr5ocYOMaKPFboknbRRqzNsb8wwFyFKQBM75gr1Tcp8f+oH5F
X-Gm-Gg: AZuq6aJJ8UW2pU7a4ZW6U7z/zHakOzrqzbNicMPDDs6Ree91RvHsxWeeWrsU8EAJ1Uu
 8cfYWt+Lodi+OTtAcj8EzFvFO+Dks6HjlCGV5twRsRcEOeh94vcxc6WtpGWMrEOx4bP4DriG9vs
 BplIwh91okwg6LUUhMm1HvLl4v4zRGutaKFSKAGWiLBMKdy44jvz1IUfC81tYShkH7ZHqBPvI+H
 8Vus1uQBzXE5loK4AyiZdWGXpwmdCjtBRpr1+lBVJh6fZzuTVcXlhzkqB0my5U+tS2qTxb1KLiK
 R2rq65v/dToSDZUYY4K+rqPfiec6UvcxymdgvkIA4ZQjrQSh76IRqQUK/xZI0+gPZzh5eMMbUW1
 3hHRcofV1GC8BdGO9MNOD7/tOtHjLqOmf6qs=
X-Received: by 2002:a05:600c:6217:b0:480:4b59:932e with SMTP id
 5b1f17b1804b1-4830e9402c4mr40392255e9.11.1770204584015; 
 Wed, 04 Feb 2026 03:29:44 -0800 (PST)
X-Received: by 2002:a05:600c:6217:b0:480:4b59:932e with SMTP id
 5b1f17b1804b1-4830e9402c4mr40391815e9.11.1770204583592; 
 Wed, 04 Feb 2026 03:29:43 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830fe86bebsm16119165e9.10.2026.02.04.03.29.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 03:29:43 -0800 (PST)
Message-ID: <21696be6-daa0-4a7e-94a3-5dc2be130290@redhat.com>
Date: Wed, 4 Feb 2026 12:29:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/16] meson, mkvenv: add functests custom target
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Maksim Davydov <davydov-max@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
References: <20260203203512.672552-1-jsnow@redhat.com>
 <20260203203512.672552-6-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260203203512.672552-6-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 03/02/2026 21.35, John Snow wrote:
> add the "pyvenv_functests_group" target to meson. This target will
> invoke mkvenv.py to install the associated dependency group to the
> build/pyvenv directory.
> 
> A "pyvenv_tooling_group" is not included here as it is the plan to
> always install this group by default, so it will not need an on-demand
> trigger.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   meson.build        |  1 +
>   pyvenv/meson.build | 27 +++++++++++++++++++++++++++
>   2 files changed, 28 insertions(+)
>   create mode 100644 pyvenv/meson.build



Reviewed-by: Thomas Huth <thuth@redhat.com>


