Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCD3C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgeRV-0000Zk-Jt; Mon, 06 Jul 2026 04:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgeRK-0000Z2-P4
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:12:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wgeRJ-0003pA-3a
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783325545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Uo/O0O1RJMmY7YeJKeU5/ESZMuoTNQ2k26P/rCwzal8=;
 b=TzAJHmk13pUx78rOv/qUpdNsldOw/Xs9sy0DEtDVpZJprfYe++yHGCyr6VXB7iLy9qa1ZX
 zCl14hIK9lxReuL7gRElGhD5unxd3dovOl/Xb3UBuBnTnlMyEITnK+2TD3Z4k8+GIhZtdM
 5yn4UYYE2fFjTG7meb59b+FFkBdDUAY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-l7SiFvzhNo6-rgQsyZasbA-1; Mon, 06 Jul 2026 04:12:24 -0400
X-MC-Unique: l7SiFvzhNo6-rgQsyZasbA-1
X-Mimecast-MFC-AGG-ID: l7SiFvzhNo6-rgQsyZasbA_1783325543
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47248bd8bc0so2206995f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 01:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783325543; x=1783930343; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Uo/O0O1RJMmY7YeJKeU5/ESZMuoTNQ2k26P/rCwzal8=;
 b=Iv/cH2QuDqpl25176dysPdOVlDSjMOK24qiQAYuL7blqCldy0u/smsXRmEGLhGs48v
 dRtyO6EZoDFQUIsfP7DTgAEhhUPezUH0MsfNq5cNKjSZwAYYYMuoDAvQYg9dYFHMb77x
 t1ctoGD4bi3oCn/aYMYtDnTj+IPb5J3C2h10ZIiXy6YZ9bmdcSI/DjJ3EzkmYcktGYcb
 Jhr2nFDvoH5GQnek5PbB4iW53Znevhrnf3HIONXU4gHBc49ImCUGJaS+NFUpiJQEGVWJ
 SJnG8nHIVznV4U4gU+84NM/H2a+7G7+QpWyGkZG3xgldLEanUWYsOa3Uv08RrHpnGzYr
 Wt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783325543; x=1783930343;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uo/O0O1RJMmY7YeJKeU5/ESZMuoTNQ2k26P/rCwzal8=;
 b=UYzPmVXB3sCse6xzYEw0Op5Gchv9V6Vxx7oFVbKqAelNXX1Iqkg5OuXOeWjPbyb8f4
 mAl7YQ9ryFBtG4TnrqALEBH8VTK6HVDYjC0OQ46jm7gK3d8FzOzhdWJYwjhnVFpQOtrY
 sU0Rdm5CMsuL/m63FTAi2TlxEWL7dj/B5Vf7dtgPxCeQNhjozyoh/V9Po6iE4U3PDctl
 fDAimk051odKg8v9ukUj96EbRONjTIg1iS67gr+IPRelUs+RaKXofo14nKUPpVRK+Dww
 9IYwQDzydN0sJcSjskbc6w2bWyVoxaf0GGLwDKfRaHG3pKY2sqCt079Y+E4UFj4TQEVA
 JB5w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoTzNkH5+FNlTvV+O/IJ/lmHt0UIbyYEijBGs/WYMvj9xi1PwyQkLJ+xu/4n95ewWVFXqVZZWxhoFsm@nongnu.org
X-Gm-Message-State: AOJu0YwDVgNz5S1gNJ0FwT7iOaL+1f3ixnlsWMRejKBF31FrVPX6/HP3
 PgTvQ9gWYcOou7/fu0jPWZatytfjg3P33Ti0CYW8laKM4CrvLFv32IJTICkUiadvXJQHW6oGbIF
 MYZtyTR64DkX8LRGCmVnZdY9LoVKNoj/+0jnEbIvB8Iub0Ue1wY/248pi
X-Gm-Gg: AfdE7ckeyf3rJzNDJKzNoVVCx/M3vIklbES5wE2/ruUivB/91iMMwYq8oj/f16njSyK
 Xk8nHfvVNa+RJ5gKvTJl7U7PUOiPgyZcq3pdUJEYs4ggkZfS1NfDyxl6cCZErNNX4s1eN6yQYei
 mmxJpytl8NdG70sLtRB/YNRtXXVStb5N5MWNBhp2BP4c8Dy0D5Ubz85OBjWVY0nPTh6/BZ/a4Pl
 zv4FMlAj3B+SbDI4/YzYf4x2RqsqO/cQwm9jyERkNHhwO7LdyRylg67qQVFGZBYBtAK2hC4eDZh
 sUW7OlmtUOIzB3fz7r98ZLpC9tRJS9pUd8h7bkn5CJOf0PZTFrHsnWpSxzQpX6Vs7+NQGaHhMui
 aUVXLWhBE7BBiJDztD7zPY9jtGsUS8pW1nDa8bRS4WC4pQnQx5A==
X-Received: by 2002:a05:6000:4697:b0:46f:558:a42a with SMTP id
 ffacd0b85a97d-47aac209676mr7606589f8f.34.1783325540212; 
 Mon, 06 Jul 2026 01:12:20 -0700 (PDT)
X-Received: by 2002:a05:6000:4697:b0:46f:558:a42a with SMTP id
 ffacd0b85a97d-47aac209676mr7606565f8f.34.1783325539729; 
 Mon, 06 Jul 2026 01:12:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039af67sm26422081f8f.17.2026.07.06.01.12.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 01:12:19 -0700 (PDT)
Message-ID: <34f987ad-6664-4458-8d14-c0a8e337281f@redhat.com>
Date: Mon, 6 Jul 2026 10:12:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 08/23] migration: Run final save_query_pending at switchover
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, "Jason J. Herne" <jjhern@linux.ibm.com>,
 Lukas Straub <lukasstraub2@web.de>, Fabiano Rosas <farosas@suse.de>
References: <20260630043107.1511076-1-clg@redhat.com>
 <20260630043107.1511076-9-clg@redhat.com>
 <a82ece02-d9fd-4ea4-b934-a9bc5abde663@nvidia.com>
 <df58c2d0-cc0c-43c2-9dd3-ea0614de7d72@redhat.com>
 <e7bd3ab2-2eca-44d6-8a18-29cdbcb57768@nvidia.com>
 <9ea28269-924d-4996-a886-73f14cd31bee@redhat.com>
 <da6a564e-8fa8-41fe-b818-99582e246f1f@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <da6a564e-8fa8-41fe-b818-99582e246f1f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 7/6/26 10:00, Avihai Horon wrote:
> 
> On 7/3/2026 5:01 PM, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>>>> The culprit appears to be patch 3:
>>>>
>>>>   migration: Run final save_query_pending at switchover
>>>>
>>>> I can reproduce the issue consistently with:
>>>>
>>>> while [ 1 ]; do
>>>>     QTEST_QEMU_BINARY=./build/qemu-system-s390x \
>>>>         ./build/tests/qtest/migration-test \
>>>>         --full -p /s390x/migration/colo/plain/secondary_failover_checkpoint || break
>>>> done
>>>>
>>>> The patch you proposed seems to fix the issue.
>>>>
>>>> Could you send it as a follow-up patch?
>>>
>>> To make sure I get it straight, you suggest to merge your pull request
>>
>> The merge request won't be merged as is. It's broken and I will
>> have to resend with a fix or without this series.
>>
>>> and then send a separate fix patch for that with a proper Fixes tag, right?
>>
>> We either handle the breakage with an extra patch like you proposed,
>> which has to be sent and reviewed, or :
>>
>>>> if Peter, Fabiano, Lukas
>>>> would prefer it to be integrated in the appropriate place, it
>>>> could be included in v5.
>> We can address this in a v5 respin of the series by fixing it
>> where it belongs: in patch 3. I think that's the right place,
>> since bisect breaks at that point.
>>
>> Let's see what Peter and Fabiano think.
> 
> Hi Cedric,
> 
> I got the v5 ready to submit (it has the COLO fix + two new patches on top: one to refactor migration_completion_precopy to return bool and another to fix switchover typos).
> 
> Would you like me to send it?

sure. sooner the better !

Thanks,

C.


