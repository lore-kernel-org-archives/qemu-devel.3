Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F78CE8FDA1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 07:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZ2G4-0002QJ-FF; Fri, 26 Dec 2025 02:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vZ2G3-0002Q5-0V
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 02:29:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vZ2G1-0007CA-7l
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 02:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766734143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3wuBrOzv/WROQ/jqFlR9I0JMRB6X3k573m7rzDA4Ngk=;
 b=G/F6e6LHiqe6u+Nm0OHviFFW8e85wuwM/E8UQE9hC/uVABr3kQBIcjpqNbX+SGq9FzGpaq
 MW429bbvDw+YslFuoQz6ybbLnllYepx96swgfXi4ZPglOgTtVg/6U4/HGOqzV1im+DV10T
 I+RtpERFz8njyslWfL/BbH0IHEVmYnw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-PG87bJE_MMu9yAaveliEVQ-1; Fri, 26 Dec 2025 02:29:00 -0500
X-MC-Unique: PG87bJE_MMu9yAaveliEVQ-1
X-Mimecast-MFC-AGG-ID: PG87bJE_MMu9yAaveliEVQ_1766734140
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34eb6589ed2so5641518a91.2
 for <qemu-devel@nongnu.org>; Thu, 25 Dec 2025 23:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766734140; x=1767338940; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3wuBrOzv/WROQ/jqFlR9I0JMRB6X3k573m7rzDA4Ngk=;
 b=Cvg4Yq80j/J23SuONJ6VmR/x6R5q+HGUy3QQ2X1wb7JOg2NOYajZlpLOy5OK5/3nAB
 tRUuW6wqmBfX9CKHLv19TThRlYWsxHRi1XOnY/tIgd2jwU+nL1KL9YSLKWgmGhUQAkM6
 FS3qZE2S4Vdsuo1apDpJv8TWDJFLjsS2W0QMIxe5l75iirb/OHBMmAP4XCadN2OtCBm6
 4N0M9g01yx7+1LrarErvsTEbEJPHeOdHS/oPRiSlPc0BAvAqcqSRS5QLIJUhdqyuMAlZ
 wtrsqJJKuCAJEIGeJp5NkKU7cH9d8xLq6XmKKzhji0fYF3+vK9Ml5XVqKUkq6WZy884V
 Omcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766734140; x=1767338940;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3wuBrOzv/WROQ/jqFlR9I0JMRB6X3k573m7rzDA4Ngk=;
 b=RGt5nI+BILBHB4y6YoGMn7X0Fc8BHkO+uvQn9rzEFLc53O2QBxhxM5tTLSSJIu4rOJ
 xMLVTMd6qpi2mN33Lw5ZObH+3ve62pTMtHODd1AGz45ctvRqCUJ33zk+8GxIe+WYrBE2
 tNyZ9TUS7JLoIPM2WwmXJHZJuBrHFA00uxt6E9BFqvH8wEuu/QhO/uzpwzK53ih4wMvR
 AXB3XPfrkABX1oMxPlr/FKOsZ1lwvYNFSO6TOmGH4Eh92ItO70FgP64XiZBq1vIIyqED
 g/2+Wv+O+CWB7daYlI5yRTkUcyZSffdW6FNxNB8L1X1A6KsOpIc4nPIQpcHEgXyHVBAi
 04Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmkDRS5YCTsM4JSVT+JKYx/d2cNqDveI/vAiDLIC/aduXcB598OCr1zVQ0ctENMiclrLZrjmihaIfM@nongnu.org
X-Gm-Message-State: AOJu0YwB46Yq6V0W8Z4JNMpquII1U8jkJYr5V97ItC7ArZ3VMkNo3OQ4
 nELY0y/ArCGsCI+iFAg9ExVbwItAFGfU0sEexaFWC1ImQc5rrx//KTtCmpAMT03/7+NlbBzmPyZ
 aSxfZATIZA2uCdECBjyGvLJr1TCnRTfY+60JHw8PRKvF2oBltm1dnse5kv/BSzMbst0S2NgRcg7
 IBeZ6gXQ88UcNIIVFcMoFzXWQ2gHurnlU=
X-Gm-Gg: AY/fxX7A/ChDiC7NGD8k3cSaVqD9OEtItmf6H+rpq+3AwcDiWFBYC+yeF2KSxUSpAEu
 EVFrnCMcQEbU3M2G9d0oAoNaY2dKi6WulkxuMF+FUAiP0qyMxEzBnccxUurgyhSdIkdv4BljMLI
 BgYb7Ez2NkOQHXjTHFvmnkU9PiC0SoxxPoklyEwfHBzA7GvBZDpNAPn8wa2lk4GS3ffFM=
X-Received: by 2002:a17:90b:35cc:b0:340:d578:f2a2 with SMTP id
 98e67ed59e1d1-34e921301d9mr20246938a91.6.1766734139792; 
 Thu, 25 Dec 2025 23:28:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVMmtcianvpOsp4h50t7kwDVSaVgRZsYlmy9qeBx6UxpJdw71MzCFnjSREgXMdYj4m5rBjz0Kh8sLxmjfjzgw=
X-Received: by 2002:a17:90b:35cc:b0:340:d578:f2a2 with SMTP id
 98e67ed59e1d1-34e921301d9mr20246919a91.6.1766734139372; Thu, 25 Dec 2025
 23:28:59 -0800 (PST)
MIME-Version: 1.0
References: <20251225072442.36012-1-jasowang@redhat.com>
 <20251225072442.36012-2-jasowang@redhat.com>
 <CAK3tnvJQCV3YFMB-YWwE5aRmAt6dVepVssKSu+1c7fy8FbUP7A@mail.gmail.com>
 <CACGkMEsUy-ATw1vEZ+Wb3Gm4a2Kc6pjXx3uCWceTJ32cNKbs2w@mail.gmail.com>
 <CAK3tnvK7NL4eCx=ndqr=ZKkCkjqapyt=zHEqqWk9ogzFBFFFWA@mail.gmail.com>
 <CACGkMEsJCf0OnrP10XGTgpf3Km=9Dg9KcStcF1pB2vOYkgfQEw@mail.gmail.com>
 <CACGkMEtTCXTPB2oE9mwEOgSuSJfYoyA803w-yYcyojxBJRDHNg@mail.gmail.com>
 <CAK3tnvJ+L-XJ6yRiKUTAy0FJV5bTfgNFJwZuGzJ2tEfs9QQDVw@mail.gmail.com>
In-Reply-To: <CAK3tnvJ+L-XJ6yRiKUTAy0FJV5bTfgNFJwZuGzJ2tEfs9QQDVw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Dec 2025 15:28:48 +0800
X-Gm-Features: AQt7F2qA-2xJxVGFl0Z2QvKB8D6LylYipdatGtaNTdT64r64sjMPwGkfCgFrgC8
Message-ID: <CACGkMEvvE=Wyga7+tScUXW=VG7OEL7i240e+1FOYX0a1k4Xeeg@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests/qtest: add test for filter-buffer interval
 change
To: Zhang Chen <zhangckid@gmail.com>
Cc: lizhijian@fujitsu.com, qemu-devel@nongnu.org, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Dec 26, 2025 at 3:19=E2=80=AFPM Zhang Chen <zhangckid@gmail.com> wr=
ote:
>
> On Fri, Dec 26, 2025 at 2:30=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Fri, Dec 26, 2025 at 2:26=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Fri, Dec 26, 2025 at 11:15=E2=80=AFAM Zhang Chen <zhangckid@gmail.=
com> wrote:
> > > >
> > > > On Fri, Dec 26, 2025 at 9:37=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Thu, Dec 25, 2025 at 6:27=E2=80=AFPM Zhang Chen <zhangckid@gma=
il.com> wrote:
> > > > > >
> > > > > > On Thu, Dec 25, 2025 at 3:24=E2=80=AFPM Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > >
> > > > > > > Add test_change_interval_timer to verify that modifying the '=
interval'
> > > > > > > property of filter-buffer at runtime takes effect immediately=
.
> > > > > > >
> > > > > > > The test uses socket backend and filter-redirector to verify =
timer behavior:
> > > > > > > - Creates filter-buffer with a very long interval (1000 secon=
ds)
> > > > > > > - Sends a packet which gets buffered
> > > > > > > - Advances virtual clock by 1 second, verifies packet is stil=
l buffered
> > > > > > > - Changes interval to 1ms via qom-set (timer should be resche=
duled)
> > > > > > > - Advances virtual clock by 2ms, verifies packet is now relea=
sed
> > > > > > > - This proves the timer was rescheduled immediately when inte=
rval changed
> > > > > > >
> > > > > > > The test uses filter-redirector to observe when packets are r=
eleased
> > > > > > > by filter-buffer, providing end-to-end verification of the ti=
mer
> > > > > > > rescheduling behavior.
> > > > > >
> > > > > > If user try to simulate network latency by filter-buffer, the a=
ccuracy
> > > > > > of time is important.
> > > > > > Do we need add some note about the first buffered packet time n=
ot
> > > > > > equel to dynamic
> > > > > > changed time (default interval time - new qmp cmd effected time=
 +
> > > > > > changed time ?).
> > > > >
> > > > > I'm not sure I will get here, we can't forcast when the first pac=
ket
> > > > > will come. So the behaviour is always that the filter-buffer will
> > > > > flush at a fixed interval. Or I may miss something here.
> > > >
> > > > This case same like this test, before change the user target interv=
al time,
> > > > filter-buffer maybe already buffered lots of packets, for this part=
s, the user
> > > > external measured time did not meet the expected settings.
> > >
> > > There's indeed a change of the behaviour, but I'm not sure if there's
> > > a user that depends on the previous behaviour.
> > >
> > > Or if we really care, we need a new attribute.
> >
> > Btw, the use case is something like these (out of the scope of COLO).
> >
> > Mgmt want to buffer the packets for a while and release the buffered
> > packets immediately when something happens.
>
> Yes, I know that.  And back to COLO, do you think we should change the
> colo-compare module
> to a general network comparision module? Any comments about it?

I don't see how colo-compare could be used out of the scope of COLO,
but I do see buffer, mirror and redirector can.

Going back to this patch, are you ok with this or expect something else

Thanks

>
> Thanks
> Chen
>
> >
> > Thanks
> >
>


