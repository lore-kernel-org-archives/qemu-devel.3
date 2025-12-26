Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BF3E7AD74
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 06:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZ1LG-0003IS-Ip; Fri, 26 Dec 2025 01:30:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vZ1L6-0003HB-KD
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 01:30:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vZ1L4-0005t1-8u
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 01:30:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766730613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pa43QT+gEVoFf/W4V4Iqr9zVaX/7vl/yJkCPfxeIx+A=;
 b=gZ4TUQJw/CO99vW2m6vveru6nAYvARESYlwcFeAbhfiHsJk7Ren/Y4FrItb+Ne47qdS8rZ
 UpJYN76BQDIucFDgiUTzMJRqheCQNvwpX/C6AnBrCTESlG8KvTfEe5B6/bYrvp61tPtBll
 cUxec9lyaGwDtgKOcu9h/QvbTGfv5G4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-QsTyrWz4OLCsw1J-x_Yk2w-1; Fri, 26 Dec 2025 01:30:11 -0500
X-MC-Unique: QsTyrWz4OLCsw1J-x_Yk2w-1
X-Mimecast-MFC-AGG-ID: QsTyrWz4OLCsw1J-x_Yk2w_1766730611
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a089575ab3so97229885ad.0
 for <qemu-devel@nongnu.org>; Thu, 25 Dec 2025 22:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766730610; x=1767335410; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pa43QT+gEVoFf/W4V4Iqr9zVaX/7vl/yJkCPfxeIx+A=;
 b=c8dJUUxc4wKu1qfmSiMQGbODQnybTX1G99rz7FVrIexQk0rWDGePXuqsMpSPMw+QfX
 yXfrApLnxYHyzXmFfktoV6VD0l5C7FQC6hv45Nf2qwYBt8rc450RAiZ0gRIYH3GsejHY
 uW9e/TqBq9CW3rADxVzA7VSBwhygyDdFG9vmti9iV1KcJ6ouDF0zaU7MRdu465b0lXuR
 4gPabsAXLq5w7ByRpVg9ID60LDTev6ZCCm0lUIYyR/TM2gp8mLEfbkjD4D2uNni6dbHT
 P5t/rff3yf6YK7bxNIKb+By+eqsjy5hsD3LYgSaU5RBCaw6o/JCE/FJEutfk0lXg2M6W
 k3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766730610; x=1767335410;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pa43QT+gEVoFf/W4V4Iqr9zVaX/7vl/yJkCPfxeIx+A=;
 b=KrxgknHDbzCOgnd9owIX7hVBpUY8QGAfskrcKhZKeOGTlSPrBLyaRUvF+OGWqmat7n
 gb/aeJ4D1+uHN9Hty/UZZn6HsR4gfWQunej/J3wRFME8XYFQDXIs/O+BeQaV3qePZF+o
 dzNOarVWoDrkvAjCR44Wv6RjBQEhXz3AEeOjrW+2RsrXBYZIVkPR0N/ADjTG/5qlrMyl
 j+4r4t9kFwKcu/i2QrRKSEREZH1hYzV9A1Uni4lMa/3k787k6trEI42x+oNx5PKOZi9F
 leMS+HTerpKENseLb7bwmNom3d8kkVgkfun2NgV2CIieWqcPstJsZxskiaXhdGdUSLCi
 ictw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd3noO2zE4NVA4F5JJpeoGfuUs+bIzw5+yy1jI+U0sB1V+R3yjyG3ljHG/93IlPtj1d1bKARRc8gac@nongnu.org
X-Gm-Message-State: AOJu0Yyf3n3gHfX2OXYYnyujmQiAXUymNF7BCsUiS9fzM9TAx2BDssPA
 wVA22dmyLb70l6gw3GC2Kdsni5L0b69MCLH+w5ucNcK+WM8oVRjuPUOe/JL+5c5DFzwObvM1W25
 UCQ1o6n8ZinylvloNTWFFgssY+VcxYaHPCTIUtsucVVko0WrZPzn0iJnSOze7yJTOEcOc9KmKIz
 SB1AoiBVE/JbJwF4BqQP5u/PTC/iE9ZoKjpHcuYpe+MQ==
X-Gm-Gg: AY/fxX5KBGlpzUQoXo45j9g08KtGNiRofHhFm+pg1F98n2sgM3iDbqsLn9fLtyuTLW3
 o52y+uAulC4sLl9MSoCDUaWsYSGtpu8Zbx1byVoBNcnrgaO6sDxKLEUupTUk/8dHXCWbEoB3vWu
 ldE/usKmIuojRialpa7ByBrOtMDQT0EBomLdEfwu+Y9j/qHcjdOpXsxjn5wYdlyUeus6Y=
X-Received: by 2002:a05:6a20:9185:b0:366:14af:9bd2 with SMTP id
 adf61e73a8af0-376aa0f0667mr23694433637.72.1766730609958; 
 Thu, 25 Dec 2025 22:30:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzVbycc4NYzos83VWsKxmyupqkAHh84k1o1lZCd192vTdpN9OFSRaZTI4rMLmON3G+uOOTLKvsapDRLaKgDK8=
X-Received: by 2002:a05:6a20:9185:b0:366:14af:9bd2 with SMTP id
 adf61e73a8af0-376aa0f0667mr23694406637.72.1766730609538; Thu, 25 Dec 2025
 22:30:09 -0800 (PST)
MIME-Version: 1.0
References: <20251225072442.36012-1-jasowang@redhat.com>
 <20251225072442.36012-2-jasowang@redhat.com>
 <CAK3tnvJQCV3YFMB-YWwE5aRmAt6dVepVssKSu+1c7fy8FbUP7A@mail.gmail.com>
 <CACGkMEsUy-ATw1vEZ+Wb3Gm4a2Kc6pjXx3uCWceTJ32cNKbs2w@mail.gmail.com>
 <CAK3tnvK7NL4eCx=ndqr=ZKkCkjqapyt=zHEqqWk9ogzFBFFFWA@mail.gmail.com>
 <CACGkMEsJCf0OnrP10XGTgpf3Km=9Dg9KcStcF1pB2vOYkgfQEw@mail.gmail.com>
In-Reply-To: <CACGkMEsJCf0OnrP10XGTgpf3Km=9Dg9KcStcF1pB2vOYkgfQEw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Dec 2025 14:29:57 +0800
X-Gm-Features: AQt7F2qkkv70_RdwRoDVWsvtAddYEX7tgDuNrVtEF2Q7cAH1NWyMCahbSr2mSGs
Message-ID: <CACGkMEtTCXTPB2oE9mwEOgSuSJfYoyA803w-yYcyojxBJRDHNg@mail.gmail.com>
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

On Fri, Dec 26, 2025 at 2:26=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Dec 26, 2025 at 11:15=E2=80=AFAM Zhang Chen <zhangckid@gmail.com>=
 wrote:
> >
> > On Fri, Dec 26, 2025 at 9:37=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Thu, Dec 25, 2025 at 6:27=E2=80=AFPM Zhang Chen <zhangckid@gmail.c=
om> wrote:
> > > >
> > > > On Thu, Dec 25, 2025 at 3:24=E2=80=AFPM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > Add test_change_interval_timer to verify that modifying the 'inte=
rval'
> > > > > property of filter-buffer at runtime takes effect immediately.
> > > > >
> > > > > The test uses socket backend and filter-redirector to verify time=
r behavior:
> > > > > - Creates filter-buffer with a very long interval (1000 seconds)
> > > > > - Sends a packet which gets buffered
> > > > > - Advances virtual clock by 1 second, verifies packet is still bu=
ffered
> > > > > - Changes interval to 1ms via qom-set (timer should be reschedule=
d)
> > > > > - Advances virtual clock by 2ms, verifies packet is now released
> > > > > - This proves the timer was rescheduled immediately when interval=
 changed
> > > > >
> > > > > The test uses filter-redirector to observe when packets are relea=
sed
> > > > > by filter-buffer, providing end-to-end verification of the timer
> > > > > rescheduling behavior.
> > > >
> > > > If user try to simulate network latency by filter-buffer, the accur=
acy
> > > > of time is important.
> > > > Do we need add some note about the first buffered packet time not
> > > > equel to dynamic
> > > > changed time (default interval time - new qmp cmd effected time +
> > > > changed time ?).
> > >
> > > I'm not sure I will get here, we can't forcast when the first packet
> > > will come. So the behaviour is always that the filter-buffer will
> > > flush at a fixed interval. Or I may miss something here.
> >
> > This case same like this test, before change the user target interval t=
ime,
> > filter-buffer maybe already buffered lots of packets, for this parts, t=
he user
> > external measured time did not meet the expected settings.
>
> There's indeed a change of the behaviour, but I'm not sure if there's
> a user that depends on the previous behaviour.
>
> Or if we really care, we need a new attribute.

Btw, the use case is something like these (out of the scope of COLO).

Mgmt want to buffer the packets for a while and release the buffered
packets immediately when something happens.

Thanks


