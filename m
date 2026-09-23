Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA56C982EA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9KYE-00031l-8C; Wed, 23 Sep 2026 06:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x9KYC-00031U-R6
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:50:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x9KYA-0000lZ-Va
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790160606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nnii+uTnwTDNMmy4AkThStrLEsYMRKsHw4FY/I/9oWU=;
 b=hA/as3uqsJJaU6aLIHHPGmvpi3jhTce5F7paYLZUQDix/1TmqEpw15pjVQgAwo7UA3gu7P
 Qgv5JA9q81i5Jw7VFsby5uH3WudAaVH7vfK1w7rVt16mVcc7pvpDnpjwMNL9SXG3Iz/lh5
 OAGarMZxuvqojLehOuQHcOi5oohzPxA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-bEfhYjyqMr2CwekUryWgSg-1; Wed, 23 Sep 2026 06:50:04 -0400
X-MC-Unique: bEfhYjyqMr2CwekUryWgSg-1
X-Mimecast-MFC-AGG-ID: bEfhYjyqMr2CwekUryWgSg_1790160604
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6a125f5b317so1082406a12.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 03:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790160603; x=1790765403; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Nnii+uTnwTDNMmy4AkThStrLEsYMRKsHw4FY/I/9oWU=;
 b=Eo43qlq0jFarfwfrzzvU2uN+rgmqKNQx5WkKX3CkbfcGiRHERsNzANelNFET9x7eJh
 rRS654MgZpetZIPmcyyVD90A3SflhmbFtzr0rLREF1CtRJb09u8heTy8V3BYKRJuc47L
 Ej5tkfXAo8K7Md7JhkE0hp4yiJK0zzpyORQvyOKmmE4K8s6h+A/LWGjyVNiMtab5CQCA
 lUzM/wUBJ07NT0C5aq/g8RkkPkULSgm4a5yXvKzFrd4cUZJGgn78zlJop3nfy73nmfyX
 6wWQVD54z8dv6kuIPa/nDRfHW+v2CHWsy1oXlkTNvjhGkdL8wBR/Dq9o94Kj5dwejCt6
 PoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790160603; x=1790765403;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nnii+uTnwTDNMmy4AkThStrLEsYMRKsHw4FY/I/9oWU=;
 b=ltkvw4mWtOegJhrz3qbY7KqkyHvpZn+01aBWlWt3OYUAPEsxfIVKEXWxsRgyLhi7+h
 VUwjsRNK0N6hcxFfPV+MEBvXXKes530LqjlxzJGyiTsEHcaXqlHGQvWjtWDgQbGWH3Gk
 Z5ZxIaXhAiIGZsGI9wEdQaQy1kMRhTHJo1lKevwwBRJVbkcjhuvQsFHT/7kszTsB8m8U
 9fK1WXNhrelbgu/a+bKdgJ+5pjQBhhpWU6FD3Z/HO10vbT5StxQ0eLFDH2dEcqSkWpfI
 EhbaU/Op8N+XUvWICBWNGj6BwcQZjZkGlKpofi5HInItFTqRA8tZWrvJC6pAYPMibYbg
 4d0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJ3Ictxlqw0tQWfFXEdZBLr51Dmc/Ib6Ux8GVz9ufrHt93ZuEdPZ7VegbDgaexz1KBObUrIP6xXCwA@nongnu.org
X-Gm-Message-State: AFuF++mouqYfvXMsjdvEPMq5pAwuIXOLYcLrzYvNLMnQN62egqo7Hz54
 kBAs/rcWZ/uIzLCVBw3JTlgsxxRs+a+X5okO6LvmEOwyc2HFgK/nB72EiDz6LrEl+ZXrv+pn/Dy
 heiOiYo5ct9coJBlmveiq6PULUw3RnmlCcs/jgUc9dq6+Ud8wnz8vYaTI
X-Gm-Gg: AYBFou2sOf+Ny1sW4dLSztW74WJoj3Mvf60M+9mPZIenqXS9tUbRn+H4O64hRLScr3g
 TNS75tHZ76dVcLJpq/P1A7L1VqPiehIsWl4KX+Ex6AF+MLp7fX2TvR0TVmF8MwFFzdC1Lnsk3KX
 umS9rkOjIfi9NU5NyGVjU1wh6uIMQeVk8O7BbLXo3fqjOh1Dqypo8U9eAIWX7xuqdBx2chIYjA1
 SrUlOKgqnI6Rj4xOhf12tZ1ScY1+26Es7StMg7vnIn5SVVdBfVDjXBj0GwMRTtpqEFhzeA56xSr
 1RNaQwiqR49PFQuGtDSJWXYtgTTSQhFUKzvb57/pntU5z9KLHtJCwyKY+l0ugQY3G8j/fVobLxq
 PYuDm7r6ROVhl5qWYvW2gx/u39j4W/iIM+mdaBZCP7t8hfIT/gXtGTU5ViKSb/hvAQ8/M6ijGT8
 HzekgzjstkXcXKiS4revAqKN7/x+oRmQ==
X-Received: by 2002:a05:6402:5514:b0:6aa:129a:1f70 with SMTP id
 4fb4d7f45d1cf-6aab3b647e8mr1868526a12.43.1790160603533; 
 Wed, 23 Sep 2026 03:50:03 -0700 (PDT)
X-Received: by 2002:a05:6402:5514:b0:6aa:129a:1f70 with SMTP id
 4fb4d7f45d1cf-6aab3b647e8mr1868509a12.43.1790160603015; 
 Wed, 23 Sep 2026 03:50:03 -0700 (PDT)
Received: from ?IPV6:2003:cf:d749:526e:3864:2ce3:24f2:e6d4?
 (p200300cfd749526e38642ce324f2e6d4.dip0.t-ipconnect.de.
 [2003:cf:d749:526e:3864:2ce3:24f2:e6d4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aab38bd31bsm1367972a12.31.2026.09.23.03.50.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 03:50:02 -0700 (PDT)
Message-ID: <d95d1349-277e-4f4e-b7f9-4946e7fca643@redhat.com>
Date: Wed, 23 Sep 2026 12:50:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] block/accounting: Move latency_ns override down
To: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-9-hreitz@redhat.com> <20260903150842.GF825275@fedora>
 <292ff2f9-b3fe-423b-9b36-ada26904a617@redhat.com>
 <20260921204237.GD115897@fedora> <arJ8tNgp9tDtKkfO@redhat.com>
 <w51mrt9tn76.fsf@igalia.com> <arKIHIneJEkNNjRM@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <arKIHIneJEkNNjRM@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 22.09.26 15:52, Kevin Wolf wrote:
> Am 22.09.2026 um 15:44 hat Alberto Garcia geschrieben:
>> On Tue 22 Sep 2026 03:03:56 PM +02, Kevin Wolf wrote:
>>> Am 21.09.2026 um 22:42 hat Stefan Hajnoczi geschrieben:
>>>> On Wed, Sep 16, 2026 at 10:21:22AM +0200, Hanna Czenczek wrote:
>>> What's even stranger is that both things were introduced in the same
>>> commit. But it seems clearly related to 136 because the change was made
>>> right before the test was added.
>>>
>>> Berto, do you remember why you didn't rely just on clock_step?
>> No, sorry, I don't remember :-/ I guess I wasn't familiar with that
>> function? 136 was one of the first tests that I wrote.
> I thought so at first, too, but then I saw that other places in the same
> test do use it.
>
> Anyway, thanks for the quick reply. Then let's just try out what breaks
> if we change it. :-)

Yup, I’ll take a look.

(Thanks for chiming in, Berto!)

Hanna


