Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFD2C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 09:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU0a9-0001o1-N2; Wed, 17 Jul 2024 05:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sU0a5-0001lz-5j
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:04:13 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sU0a3-0005Io-1u
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:04:12 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-595712c49ebso7715215a12.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 02:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1721207044; x=1721811844; darn=nongnu.org;
 h=cc:to:subject:message-id:date:user-agent:in-reply-to:references
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y0LqsCxko4olx/YR/NHOVwdTXAQBQDQXrA3CQBqbc90=;
 b=gUjZpZLJZYxMh+00i2iqjDQxYfn4mdDySKf4QmHYBOjY+6i/bjdFZNQJtiZYADncCy
 X5rEtyeM+4XLMSmWgO8V1gqlUi2EJcpQUORrrkh9DfubmlzVAnq29I+NSAsadNgAS+yE
 LLR9Oxud2jk11f1XdiPx9hXkwkbqYt5GlmaGI3PsNNMS2A6dqxwyHVDmAcJCPSn/QnKL
 5CRg64w4VRiunze8Df2TnIAMNvlEdf/PmDkinetCqXK6tlXz0S/mji1uyom/9IRjidkP
 Gej8kvxvYigzVSMl1eLgjELRldTj+pgnbk9AfyRNb2mpm75Lp+ZrBvetuKf2vEPjdLmr
 tiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721207044; x=1721811844;
 h=cc:to:subject:message-id:date:user-agent:in-reply-to:references
 :mime-version:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y0LqsCxko4olx/YR/NHOVwdTXAQBQDQXrA3CQBqbc90=;
 b=BRzUxxt6/Tj43cWV8X8S7kwucDoWJ+7NnqtLDcGpCihVLmdvVjXlIW7L63UwMauMRK
 SCKXuBWI3D2oBMSyUvQ0XH6NskbGsRkeWDdPq0un0BEYsQZHYVZZYcft6q07yaE4O203
 OFmJTCYPmbIihX98Ir05M9XllTazuWDVuY3F6kcWI3Z/pb5wkGS9atPRS9r0NpkBKDt1
 LBpbYUp52d/fX5rNXFa8sKsFak8kH+Gp0T1+5YTCW7n4I0P8osVqikrRhxZFRtoqbZxP
 Vi7CM8zUBzrNKpIPeZqgWHbvvArOINswiQZcYpbH6RR7FXJFnK3hBKFn7ttCHOXPAS43
 k6cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbLiFX6a30eKcpN+XhIIPiHcH4MuU9PqM/A+aTAuWT9WNukLk2gDY3XoasW1RP6dA22wSAfF0O+G4Bi4LIWV2jsVQIMQ0=
X-Gm-Message-State: AOJu0Yy3/AlOeGp5agDsm/uOmgqDtE4RWye3FD6VloiA6RDC571v6z/Y
 6jgArY3rGJnXbma07tvStKEJlzvXGYx7X0rqYQ8GlVGubddjqnKpXrIBXu6t5UuzgbdjUVC1w9d
 rNhDvT/Nv6yuNg0wHH9Py8vAo3RS65AUJ33FfKQ==
X-Google-Smtp-Source: AGHT+IFT8Kcnx+WvdpSV+ZI+YlyaDIEFUSjDcM9O5Hd9lxo3GkN3eD9v8Q4+Y9NTFIwOnrCauV/EdngX2F5ICSC78Ao=
X-Received: by 2002:a05:6402:538f:b0:57c:aab2:7311 with SMTP id
 4fb4d7f45d1cf-5a05cd1a833mr819654a12.29.1721207044136; Wed, 17 Jul 2024
 02:04:04 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Wed, 17 Jul 2024 11:04:01 +0200
From: =?UTF-8?B?5Y2i6ZW/5aWH?= <luchangqi.123@bytedance.com>
Mime-Version: 1.0
References: <20240712023650.45626-1-luchangqi.123@bytedance.com>
 <20240712023650.45626-10-luchangqi.123@bytedance.com>
 <ZpT1ZnOjx48_6q0j@cormorant.local>
In-Reply-To: <ZpT1ZnOjx48_6q0j@cormorant.local>
X-Original-From: =?UTF-8?B?5Y2i6ZW/5aWHIDxsdWNoYW5ncWkuMTIzQGJ5dGVkYW5jZS5jb20+?=
User-Agent: Mozilla Thunderbird
Date: Wed, 17 Jul 2024 11:04:01 +0200
Message-ID: <CAO5cSZDsVB8unOGjxjwKwWWkAxft++1v65i9Ya+Lz-7+Lsp9zg@mail.gmail.com>
Subject: Re: Re: [PATCH v9 09/10] hw/nvme: add reservation protocal command
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net, 
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de, 
 kbusch@kernel.org, foss@defmacro.it, philmd@linaro.org, 
 pizhenwei@bytedance.com, Klaus Jensen <k.jensen@samsung.com>
Content-Type: multipart/alternative; boundary="000000000000738394061d6dbe92"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_MUA_MOZILLA=2.309,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000738394061d6dbe92
Content-Type: text/plain; charset="UTF-8"

Hi,


Thank you for your support.
1. I will add a guide on how to get a simple test at next patch.
2. I think hostid is stored locally like cntlid, but I can't
find a way to get the host ID. Is it correct to get it through
qmp_query_uuid() method?

Using spdk as target will not fail, but it will show 0 at hostid
at present.

On 2024/7/15 18:09, Klaus Jensen wrote:
> On Jul 12 10:36, Changqi Lu wrote:
>> Add reservation acquire, reservation register,
>> reservation release and reservation report commands
>> in the nvme device layer.
>>
>> By introducing these commands, this enables the nvme
>> device to perform reservation-related tasks, including
>> querying keys, querying reservation status, registering
>> reservation keys, initiating and releasing reservations,
>> as well as clearing and preempting reservations held by
>> other keys.
>>
>> These commands are crucial for management and control of
>> shared storage resources in a persistent manner.
>> Signed-off-by: Changqi Lu
>> Signed-off-by: zhenwei pi
>> Acked-by: Klaus Jensen
>> ---
>> hw/nvme/ctrl.c | 318 +++++++++++++++++++++++++++++++++++++++++++
>> hw/nvme/nvme.h | 4 +
>> include/block/nvme.h | 37 +++++
>> 3 files changed, 359 insertions(+)
>>
>
> This looks good to me, but two comments.
>
> 1. Do you have a small guide on how to get a simple test environment
> up for this?
>
> 2. Can you touch on the justification for not supporting the remaining
> mandatory features required when indicating Reservation support?
>
> hw/nvme *does* compromise on mandatory features from time to time
> when it makes sense, so I'm not saying that not having the log
> pages, notifications and so on is a deal breaker, I'm just
> interested in the justification and/or motivation.
>
> For instance, I think the SPDK reserve test will fail on this due
> to lack of Host Identifier Feature support.

--000000000000738394061d6dbe92
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>Hi,
<br>
<br>
<br>Thank you for your support.
<br>1. I will add a guide on how to get a simple test at next patch.
<br>2. I think hostid is stored locally like cntlid, but I can&#39;t
<br>   find a way to get the host ID. Is it correct to get it through
<br>   qmp_query_uuid() method?
<br>
<br>   Using spdk as target will not fail,=C2=A0but it will show 0 at hosti=
d
<br>   at present.
<br>
<br>On 2024/7/15 18:09, Klaus Jensen wrote:
<br>&gt; On Jul 12 10:36, Changqi Lu wrote:
<br>&gt;&gt; Add reservation acquire, reservation register,
<br>&gt;&gt; reservation release and reservation report commands
<br>&gt;&gt; in the nvme device layer.
<br>&gt;&gt;
<br>&gt;&gt; By introducing these commands, this enables the nvme
<br>&gt;&gt; device to perform reservation-related tasks, including
<br>&gt;&gt; querying keys, querying reservation status, registering
<br>&gt;&gt; reservation keys, initiating and releasing reservations,
<br>&gt;&gt; as well as clearing and preempting reservations held by
<br>&gt;&gt; other keys.
<br>&gt;&gt;
<br>&gt;&gt; These commands are crucial for management and control of
<br>&gt;&gt; shared storage resources in a persistent manner.
<br>&gt;&gt; Signed-off-by: Changqi Lu=20
<br>&gt;&gt; Signed-off-by: zhenwei pi=20
<br>&gt;&gt; Acked-by: Klaus Jensen=20
<br>&gt;&gt; ---
<br>&gt;&gt;  hw/nvme/ctrl.c       | 318 ++++++++++++++++++++++++++++++++++=
+++++++++
<br>&gt;&gt;  hw/nvme/nvme.h       |   4 +
<br>&gt;&gt;  include/block/nvme.h |  37 +++++
<br>&gt;&gt;  3 files changed, 359 insertions(+)
<br>&gt;&gt;
<br>&gt;=20
<br>&gt; This looks good to me, but two comments.
<br>&gt;=20
<br>&gt;   1. Do you have a small guide on how to get a simple test environ=
ment
<br>&gt;      up for this?
<br>&gt;=20
<br>&gt;   2. Can you touch on the justification for not supporting the rem=
aining
<br>&gt;      mandatory features required when indicating Reservation suppo=
rt?
<br>&gt;=20
<br>&gt;      hw/nvme *does* compromise on mandatory features from time to =
time
<br>&gt;      when it makes sense, so I&#39;m not saying that not having th=
e log
<br>&gt;      pages, notifications and so on is a deal breaker, I&#39;m jus=
t
<br>&gt;      interested in the justification and/or motivation.
<br>&gt;=20
<br>&gt;      For instance, I think the SPDK reserve test will fail on this=
 due
<br>&gt;      to lack of Host Identifier Feature support.</p>

--000000000000738394061d6dbe92--

