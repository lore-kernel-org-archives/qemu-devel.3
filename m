Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A40C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp208-0000jN-MW; Wed, 29 Jul 2026 06:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wp205-0000jF-Vy
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:59:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wp204-0004An-9l
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785322738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gbbOOZ9edXRdO5oL5PUqsfy6kruH31DrN6E/HuLURsQ=;
 b=K0J98UeM6x8MigTqLHvcWN2lc7q5p0E+hi/AwR8++JPdtqWhFbV6iAqIFittuxj3DRF8hz
 rb6RMByn01YK+2bmsyP5/n3UFCx1ulArq+uP114B8NB/kxkKLmE3UXJVTTciUoHpoCtJPC
 utpnHLn3l96VmQWDuITYb7rRSGCmqAg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-yKLfjksROD-66q1cUQLbVw-1; Wed, 29 Jul 2026 06:58:56 -0400
X-MC-Unique: yKLfjksROD-66q1cUQLbVw-1
X-Mimecast-MFC-AGG-ID: yKLfjksROD-66q1cUQLbVw_1785322735
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-496c06ba017so5543075e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 03:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785322735; x=1785927535; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gbbOOZ9edXRdO5oL5PUqsfy6kruH31DrN6E/HuLURsQ=;
 b=AQby/CtG2F7CLUwwQCadmX/UUyaiZoXC7ln/dlo+BNguff2WZ7wxqtmL+ZIwffFZLn
 yxRByEaEiePgaDTBVBMjml+ITyiD57eN5o6PYmp9MMLcH9qjcAd+zBgBsH4lfiVbJt1f
 1FvsIntQpTQJk3qCMXyKw+NorkEp5Rg5vkALcIVbEJcr1i1k+6sULe2daN4JfgCl0bj0
 UQcJpL+RbcPSGfemNXs+h7Dda3XsNlRysLL8t4GRQJO+I8T0ew6xmzjSOsCEOxLpQHmw
 V3dRo+sqduAy77MnmJo7sJczwOjL9wO+RGaKikz6cCxUWkwEKsPfNQ1SvZKbSjbgW7Oc
 nt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785322735; x=1785927535;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gbbOOZ9edXRdO5oL5PUqsfy6kruH31DrN6E/HuLURsQ=;
 b=YhUGzBynqUZ7j9XY3pzi1wiJLc74k1H5TcL6dzZTnSTlaMS0G0kLEaCko5+QN0k4HW
 SESLkQyexeSTJJRBZw6ERNDbi7YW5VTE9D2CJ7j16de9PXfaoBbXTeuwr1Jy2yGtU9vr
 4DE1Unim+7ISu1w0YjB4wxzpxj0rYsJCiC3GBVrX0evDo34NeLfBW759lOt3rehHPDuF
 XH1EnSjDeKE3/1FvvA+G3DU52NP6V/lyIi9VhU+28PJfRKp97INn3+DjWBK4sXYn+4XS
 OaeEr2yN86UPgXoDoWmoUolPcW5FXmEx0zHvvaDOjbbdhhKDz7IJEJ89StaFDXDvXoz2
 daZw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpQCS4AVslRmd/znRJVAczp8bcsITUikyNa5vW2a7Zfn81TUThSF6RZw8Mp/wsFBUN113B+4QVi12pz@nongnu.org
X-Gm-Message-State: AOJu0YyIZi82yH4evt8ukwMrLIyZXL4PLNIkVSyKq2R2/5OCin/pghCE
 wDDL6x4CGq1gn5a5hLSdh0X4mNO2vr8iYYa42l8Riiz/jsyPs9nOXOyzNtnb5iiIXp8jalWvs0t
 WGVWaff52Vhu8Svu4ZjJduiogQ8acP3+uCjiTjq3+GvKDwTx/3bNNjzQ9
X-Gm-Gg: AR+sD133zotzovAMdQom84y6/DPvn6vu5OW53AyXYnRgnIy6uSsmcvT0UMK5ZHoch3N
 eH4+60nhEi9Q79c0awZj8dqR32kz5whZ0+2DolfZ2K6K0Tkn3V4le5bP9wGbM5XvPy755zSWoA4
 jHU0Sm++IFaOQnb11qnl21xLXGqhjKvvP0PC8kIZhRkBCbXx28/LarsGuT6wwoilop7wy9j+llh
 Jg2GckD6f7ZfdYPximTaLWA7W7q3xZJDgGGuKnkiSgQ9NZ5FpSgCF/qrhR7/eWN4btb3UMtS7iL
 UWzOW+2Td5V3euj/NtJhH4VVbpt5oRQiWnEf1W+bVykQpSaaw+Hx+jAbjL6ovnbjH2GeOSo=
X-Received: by 2002:a05:600c:b99:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-497fd315023mr21161525e9.16.1785322735281; 
 Wed, 29 Jul 2026 03:58:55 -0700 (PDT)
X-Received: by 2002:a05:600c:b99:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-497fd315023mr21161115e9.16.1785322734824; 
 Wed, 29 Jul 2026 03:58:54 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.51.53]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49764d8e81asm49765005e9.7.2026.07.29.03.58.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 03:58:53 -0700 (PDT)
Message-ID: <2aa76fe1-dbb9-4229-9f59-feba7127649a@redhat.com>
Date: Wed, 29 Jul 2026 12:58:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] tests/functional/qemu_test: drop *args argument from
 .get_vm()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 jasowang@redhat.com, mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260729093146.1893719-1-vsementsov@yandex-team.ru>
 <20260729093146.1893719-3-vsementsov@yandex-team.ru>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260729093146.1893719-3-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 29/07/2026 11.31, Vladimir Sementsov-Ogievskiy wrote:
> It's redundant. Only one caller use it, and it may be simply
> substituted by .add_args().
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   tests/functional/migration.py          | 3 ++-
>   tests/functional/qemu_test/testcase.py | 9 +++------
>   2 files changed, 5 insertions(+), 7 deletions(-)
Reviewed-by: Thomas Huth <thuth@redhat.com>


