Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF68C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 16:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weEpn-0003Be-VO; Mon, 29 Jun 2026 12:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weEpm-0003BJ-GQ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 12:27:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weEpk-0004h1-Qk
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 12:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782750462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PCvgt7Lu1b8GYX0uU3LTdesw9Cib0NFFU4HY18f3gZ4=;
 b=ObWQo5La9/E8lDLZQ8ZXEX+ENTWm1SHExkskd3Cy7zQRr3P/uTV1U3DLmoodHQqtc3gUO7
 TMyx0kBSeZhpwFty7ujM6oq9hTPoqYCzIE9ywcRc0wnUnJEZuNDMfWuJyuuYE82dg4xyKM
 ttJu84lAhFFNieRXqJkh2fc49YrD9yM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-hcQVuzrENB2cx_RwOPfAVw-1; Mon, 29 Jun 2026 12:27:40 -0400
X-MC-Unique: hcQVuzrENB2cx_RwOPfAVw-1
X-Mimecast-MFC-AGG-ID: hcQVuzrENB2cx_RwOPfAVw_1782750459
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-473bc66c837so922881f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 09:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782750459; x=1783355259; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=PCvgt7Lu1b8GYX0uU3LTdesw9Cib0NFFU4HY18f3gZ4=;
 b=Fv0JXy13FeQuz64eQeWKn3WVdu0/sG5WxMVy66SZiJfNodpJoiARDQN98/iWq64tJ/
 Aizz3UJtx71RK4n5Qv4dr01qAe3vz1NBUnBVQggRvwk6HFWlDVURuZvX696/J5Hf+tLX
 Kq/myuTIUbeWMkqLEOSC/9KK53/D/vyQ83MxIUnJ4pauVg9hUGEFh+ewoT6Nf/qytv/D
 I4uoElrqcRD2VQyQoNvkfZThrfU3Ooap6nD2KVsfHQCoYG1gXHWPGrnRRr3PtKiuyI/X
 lJTwtwAv82zGRuhJJjZL2NPZA86QIujfsECqE/pCsh3bmwazJufRe00fcslbQdkekqXp
 biFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782750459; x=1783355259;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PCvgt7Lu1b8GYX0uU3LTdesw9Cib0NFFU4HY18f3gZ4=;
 b=jY4LTl0B5W9D1jo0zihJ7jUnwpOy5TjU20eM70tH9cmZjnWmVZIoDJwUelGcsEYMRh
 p4laKmfKj6AsHEeQoXBJ2QM/sG0Lj3/hXu+sijry7lNGtrXvsoKYghZwML9w8ca5w9m3
 a1aDi8MSji+Ny9cXKquynfp9Ai5rRFU093DL+PGvoCc7nBFKPWQzJZW+SzJ8iYCELolS
 DoQDmpnGU4te/N0ZTWSSu4e6rtRSeLcOCwR76H4Z7rVK0vG1GfrUMdQfY3bICD0VvQYa
 /q1RudF0eD2C6emQAsFxO20fE6POxBQypyCk+pE0gtQ6e4lquwZl+L176X/YX/PxxXVF
 mVMg==
X-Gm-Message-State: AOJu0YyRq80UgGR5ot2jQaS5xKc0UepGVfsG8UjHlMSQS0Qa0LDprJ4C
 34NJaozhlXhrYV+1hyB0CJNw4t1j+SP0PycBW9YBqIXeEuiOnPiNsJctLrLD3qdevOR8vFqwQEV
 scRicLmLCD8li4pADvMQxqhwQ3rLO3O8k8Rs5BL2QyybJuLsAG2X/ubWL
X-Gm-Gg: AfdE7cm4Ty1IlFAdAmrZQnFLfUS1kyX/yqedp0W4/Ayn028n130xR7dTAP7i4gf7Ozq
 5X3WDGUQQ5jfzkSmd7tN024Bb/Ke2SIrvmkGMIYFlkEi3Fd/4VMHtWH5Ka0f1rJluEiXeG6GCRe
 9SygY5RfPnbeYwZwE5X/3kUtVfvBRCimj8dDPVOJjV/wD5h8l3Werks+GSrPxsNNQTEXCdK34+G
 Ie1m7VkcSReoeu7RW9Q7fAjJdrPIIdDUYKEhKTASuVwZv/+HgrAYG36NzMiimvTqoVtxotKIf0e
 gt3hb21EhsNobu1pVRNgK1a6N1I1sDmncpBtNkdliaVeUCI38PfaNDv4Y+0oS6FWVhzJif1TZrM
 KYryBlPXNYlC7NLtKn/kHpVtof28I76buJsYqOEUGqszxDsMFeg==
X-Received: by 2002:a05:6000:2481:b0:473:b63c:8a21 with SMTP id
 ffacd0b85a97d-474ff09c3a8mr2003042f8f.18.1782750459494; 
 Mon, 29 Jun 2026 09:27:39 -0700 (PDT)
X-Received: by 2002:a05:6000:2481:b0:473:b63c:8a21 with SMTP id
 ffacd0b85a97d-474ff09c3a8mr2002961f8f.18.1782750458970; 
 Mon, 29 Jun 2026 09:27:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47496fd271bsm5037268f8f.31.2026.06.29.09.27.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 09:27:38 -0700 (PDT)
Message-ID: <457ee606-5e99-4438-a107-4130f8a6dc90@redhat.com>
Date: Mon, 29 Jun 2026 18:27:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/14] migration: Make switchover-ack re-usable
To: Avihai Horon <avihaih@nvidia.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Maor Gottlieb <maorg@nvidia.com>
References: <20260622101214.25770-1-avihaih@nvidia.com>
 <20260622101214.25770-8-avihaih@nvidia.com> <87v7b520uo.fsf@pond.sub.org>
 <b997b3f7-0a95-4c21-bf18-c19bf8754936@nvidia.com>
 <9fa2038d-f75b-4d6a-a2fc-1bc871878b74@redhat.com>
 <675f8d2f-ca22-4b04-bc30-8fa7b6d3a6dd@nvidia.com>
 <4a3457d3-d892-494b-b8a9-556ad9a7912a@redhat.com>
 <59fa369a-b5a1-4484-bcb0-93b663fb0c44@redhat.com>
 <64207c96-affd-4895-a6ab-2cee7ac4347e@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <64207c96-affd-4895-a6ab-2cee7ac4347e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Hi Cedric,
> 
> Actually, I have plenty of things on my plate right now and I'm not sure if I'll be able to send it this week.
> 
> Would it be OK if you merge the series as is and I send those two patches separately early next week?

Sure.

No rush needed for this. It can be addressed as a followup
during this QEMU cycle.

> (They are actually more related to migration core, so this question should be addressed to Peter/Fabiano I guess...)

yep.

Thanks,

C.


