Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98455CD8C85
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 06:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWqOg-0001vw-OY; Tue, 09 Jun 2026 02:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wWqOe-0001vZ-DY
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 02:57:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wWqOc-00042S-Uc
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 02:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780988229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gl95qg3nbnYVhg+MVo7Efd04pVH9T97MZbXwP/hsLMc=;
 b=OoHU3augD0xIQ1YXW2R3re+rwZkbZbzK1ufhCK+n58dvgnqFnuJgWWqxSeVQV8CXcZJknm
 N90k3LpOkUv5pNIs3vZcE40LmRGF6edrwy4Dwtau6OvCIgb1t/LlPEvJcQd5zWw3V9ic52
 0lQQyB0JN+ySXeEybQV471oqJLA6FqM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-FZ7mRMADPjWh1llXR_nz4g-1; Tue, 09 Jun 2026 02:56:32 -0400
X-MC-Unique: FZ7mRMADPjWh1llXR_nz4g-1
X-Mimecast-MFC-AGG-ID: FZ7mRMADPjWh1llXR_nz4g_1780988191
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-36d98b828c8so6756895a91.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 23:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780988191; x=1781592991; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gl95qg3nbnYVhg+MVo7Efd04pVH9T97MZbXwP/hsLMc=;
 b=MXcI8nWGj8UlCNw5FEXXpiD58Kke6RGlXqEF6+J//NVuhnrP7D643xTjQ3d3iZuoeY
 NtJTk0+nLC6Rz89J2sQsTVXFPBoNyVX0u1KpOVxQVk+uw51A/7qCKoZvKcRWuLOn8rNP
 aeprNP5quNFnDxBkHeX4IKs0bT7HC7FV12az8m5O1EYbBpP9tedIi8ggiBDpLLrSN5uk
 1EVEkkh4BgaDNjtkYI5JTGo1EsfzFSY+LCGJ4ywci6lGOpA4sFB8w2rvzaR2h9fuXTrJ
 xXQMRKTSpXWdk14hnrpDN8oBYr1GHx88md2TMVjYYCm6bNmyICYopXvRD9j/f1YfbrkD
 OkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780988191; x=1781592991;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gl95qg3nbnYVhg+MVo7Efd04pVH9T97MZbXwP/hsLMc=;
 b=CSq0tMagG9fMagB017jllWX6BgPxACzrrywnIYExlbDRrs2qWctojyj0q4rZ1fLTFK
 +y58ul2PxfkewQXGdAsH6KlxDM7YvT/1HdGNB0vE3ae2KzXQITJBqRX5sXleUmrM+go5
 GjCT4aLlzhUM183DWx6ZzJ4wpDywmWl09tZHIpsHyOAOC8WjIfWPqNx12eY1BsH+ZCke
 zn5NSorl5Rkf52t70CnY8aDV6g0OKskAnxiS6ya+Kt9FYAJdIgoki4kxyo1Lr00MSsn1
 2GQwWy9Gxvc6VKO0p9VXKdp7RUsFrqYQ7QXGxJX52/RK83HHTq3X3Mg6lcyO7mHVBQxd
 K7PQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+56fXp/ch1e2AgXRStmxltGEdOBzitmp/dKITmdrGoQu/IYXoWVfK75ZGO/iidUMV4kU7Sj/SdMkm8@nongnu.org
X-Gm-Message-State: AOJu0YxTKwULfI+8xWvH1Xuoq7j7JefXcznu8sDobIUi9nxabUW0v6FN
 yKhBJGpHdwAWZATRjH4QHAV3FpFjs3kYNvV2Cdn7KvMMNwRaKCaGFP8wpS6HBkEUavKpYWsFu1Y
 kmwx/riqTfrD4yMpX+/b/RWsd+uvJCt++0n/eC8kArSnNkNWqqPJxF7mV
X-Gm-Gg: Acq92OHNFMfwajn1KTvR9B7Rl5V0GYtp3voi/jRd0GeIl+usgvRYevQQFT0MgzNSC1E
 iDwakqr1d8Vvg1C4WcsaOaXcdLxqEJhfR6AWUiNqRqKnAMqGGNsseh//ljRbTJKVCcUxfvGS5Yz
 53yE2OlEkQ6UEzMcDWMbRR6uxDPkilwtI8V1CFhzsz601YiaOVMdUqBbTZMriLV9uE8udEf7Rrk
 gMn+KHY2J2QNJIK6gA2+cRKEpgGaMBuQ8fUmUqEF93fbxgnJIhC7GDhHv/lLPgKWR+mtllQxfHn
 jDyqWu7sCB/Hz20Q4nFpZWCGaJdNaskO8pkpSCev56QgiGCkoiIuHfHrDW69i45bhmyAHmfTp1Q
 sms2/M5RVS8IS3t9H+7xodMjPRW85inTAH7WO8j57aE0ebF55LXw5fEbrOCyx4XXkTOu/y/Y4FI
 EcoSk1k8lfMA==
X-Received: by 2002:a17:90b:5106:b0:36b:afa0:c53d with SMTP id
 98e67ed59e1d1-370ee82fd0dmr19962291a91.2.1780988191515; 
 Mon, 08 Jun 2026 23:56:31 -0700 (PDT)
X-Received: by 2002:a17:90b:5106:b0:36b:afa0:c53d with SMTP id
 98e67ed59e1d1-370ee82fd0dmr19962258a91.2.1780988191055; 
 Mon, 08 Jun 2026 23:56:31 -0700 (PDT)
Received: from smtpclient.apple ([122.163.16.238])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37133082519sm10238798a91.1.2026.06.08.23.56.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Jun 2026 23:56:30 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: artifact download for qtest
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <9404eb90-9e83-4bd7-b061-6d1f700365cd@redhat.com>
Date: Tue, 9 Jun 2026 12:26:16 +0530
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A62C43D2-5D72-46EE-B6EB-B9D57A3855C3@redhat.com>
References: <CAK3XEhMNqHbkL2P6Xg3_hJ8WAxhPQgurjvuZg-vXUDZ5=x-RRA@mail.gmail.com>
 <f2516211-6fbc-4714-b674-4276464f94ff@redhat.com>
 <CAK3XEhPdaVqi9nECrJrcRaCKK0bVcRXw=t6hXM=EVwbxpu5wLA@mail.gmail.com>
 <CAK3XEhM3K1r3Q7zpqvQkLtuMEeXkb+nwDwN-j_+B0fwZpHhgkg@mail.gmail.com>
 <9404eb90-9e83-4bd7-b061-6d1f700365cd@redhat.com>
To: Thomas Huth <thuth@redhat.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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



> On 9 Jun 2026, at 11:52=E2=80=AFAM, Thomas Huth <thuth@redhat.com> =
wrote:
>=20
> On 09/06/2026 05.46, Ani Sinha wrote:
>> On Tue, Jun 9, 2026 at 7:54=E2=80=AFAM Ani Sinha =
<anisinha@redhat.com> wrote:
>>>=20
>>> On Mon, Jun 8, 2026 at 10:43=E2=80=AFPM Thomas Huth =
<thuth@redhat.com> wrote:
>>>>=20
>>>> On 30/05/2026 16.56, Ani Sinha wrote:
>>>>> Hi,
>>>>>=20
>>>>> I am trying to write a qtest for which I need an IGVM file. I have =
the
>>>>> file, about 54 MiB in size.
>>>>=20
>>>> 54 MiB is quite big,
>>>=20
>>> I was able to reduce the combined size of 2 files to about 400K
>>> =
https://gitlab.com/anisinha/qemu/-/commit/6aef476b59443dd1bc570c29e8e5ca43=
140cfed4
>> Compressed size is about 100K but I don't want to introduce =
dependency
>> on libarchive preferrably if 400K size is ok.
>=20
> We already have logic for libbzip2 in our main meson.build file, so =
maybe you could use that?

Hmm, maybe. But I still need to write the decompression logic.=


