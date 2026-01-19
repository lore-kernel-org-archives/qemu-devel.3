Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF93CA5FFA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 07:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhjaG-0005Re-DF; Mon, 19 Jan 2026 02:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vhjaE-0005Jy-4I
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 02:21:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vhjaB-0004LK-Jd
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 02:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768807309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aeIbH8kdgupS02kPKYVcLTbBxpteozq7XfJWMQR7IHk=;
 b=ECr9CtumPjf0KVhjWkk9VwWDwQkbI/cQ99CCb6LCoe/fmeXOLd2G0AT/u7H41/m1J6sdsD
 jtWZVs5Y6N1gtIZym3GNRTibalYCmiwU3iC2+wgpnBBC9PPZeo7+ytHhyUIFK6OBE3HOcA
 M7uGgkoWP/ao5NEQenIF3ZhYaEqs8kg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-5J9Fh8R_NROl9EIMNRTqvA-1; Mon, 19 Jan 2026 02:21:47 -0500
X-MC-Unique: 5J9Fh8R_NROl9EIMNRTqvA-1
X-Mimecast-MFC-AGG-ID: 5J9Fh8R_NROl9EIMNRTqvA_1768807306
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-34c93f0849dso4099607a91.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 23:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768807306; x=1769412106; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aeIbH8kdgupS02kPKYVcLTbBxpteozq7XfJWMQR7IHk=;
 b=m+bZuHDTyiEsCrlv+rsAmH08v8wmoexyCNXcozev9HGC/Z0WQydUCvNkJQ6Lj9noFR
 ODh5zK2FQKVYlWCxKYVTstvmcDO3uiHhWfaDews1SdDH8nal98c/m6OAO1zk2x3I6/SD
 GF0ySYCYV5Og3f/wE/8nDRl3z42iHlH+yhu0HFikLuRxA+/NXxYNCYgyXU8T8aHRZq4X
 lIElz1flk5lZo3KR9CFntDnpFiaGbm8dKMKN23hmn+vzQj6QZTz7QoocGNl0Y0ELad/H
 eHxCENsMAXe0o/L6iQpatHDvMV7+mj3vpYdUWpg4tk2SDo8Sv7DuJf4NPLUg05+HLB3U
 Wzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768807306; x=1769412106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aeIbH8kdgupS02kPKYVcLTbBxpteozq7XfJWMQR7IHk=;
 b=jiKJvIiD887Sg7VyOHgwnfH7fqBVnHMsDPSCrl6TAVd9BFDtIwAawF314G9Eqvticc
 qembFP4YXLcrWwnv53Xth08+1BOwAKaHiA2mlvCoq8jj1sidYZ5pmwrYcm5eQnsjZCSn
 zztan/pO8y66bsr2Cs546TA9fjC+hlzGTS1quTqricQ4XdaSaH15yIn9xDhfkYeQ+zsy
 1peuzhFFAxSz/FAezjz33Z29ma3PUrUm+sTCJtOW/0bnKQ02+GuveSQ8fxwFbZv9pfWV
 RDbB7D0vk7Mg6iHW3qaAdFMHehGtHtCXGh6V9Wczz+HMSPT1yO9CP2wo6J/mdhP62lIv
 vr9w==
X-Gm-Message-State: AOJu0YycCOwXs3hbc6AtxBl3LydgWkGXIgTcPgjOMINZfqx1Dl2Boixh
 /Qu/R9RJ9Asp9A8PvlVsZknUkaDIehJpCqYe+5efvwJ+2zK+taB8wafBqpQibSYSQT0fRzDmK+l
 gFpxxykwE+Qxze5f03KVKROFAJ1S1V0feYXScWAVvGKjqOhhh3lYEkDWBplTMj1/OlgmQmytcfX
 0Nb4i7v4+YRCywprnpyYfheVcRPN/yHN4=
X-Gm-Gg: AZuq6aKojkmvXLDtULOTi1Jy+SIPAv8mjpW71ys/kvJsJUfmer6uJbvfRWPx/jSGi11
 86Kd2//rPNw/AGnvAMNg/RJmw0plQRgcL7zWNQCTBLQ349yxeQf3J/sDsr1gp21t0m6us8U+JaL
 YyHoxO8LCLmvHRWExktbGjw0HULc7FQ+F4voPoyLD8yN6zN8JOkzPSPCB/l3dYpkbz2RU=
X-Received: by 2002:a17:90b:2dd2:b0:343:e692:f8d7 with SMTP id
 98e67ed59e1d1-35272c8de28mr9882771a91.11.1768807306011; 
 Sun, 18 Jan 2026 23:21:46 -0800 (PST)
X-Received: by 2002:a17:90b:2dd2:b0:343:e692:f8d7 with SMTP id
 98e67ed59e1d1-35272c8de28mr9882708a91.11.1768807305431; Sun, 18 Jan 2026
 23:21:45 -0800 (PST)
MIME-Version: 1.0
References: <20251030164023.710048-1-vsementsov@yandex-team.ru>
 <a8dcf37b-f7c1-486b-bc7d-5877c4d9ccfe@yandex-team.ru>
 <CACGkMEtUn8aLApCu5RCF2tpNgMskOYycp4jjrNCvgNe3aWuTLA@mail.gmail.com>
 <d95df5d1-2837-42cb-9654-b5fa60f8e1d0@yandex-team.ru>
In-Reply-To: <d95df5d1-2837-42cb-9654-b5fa60f8e1d0@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 19 Jan 2026 15:21:33 +0800
X-Gm-Features: AZwV_Qii_vNSPqFEYheouu1Syq1frWvDw2egS3kg2sqZQYAwAJbbMCIoyF_ZkxM
Message-ID: <CACGkMEtUq5YDS6dGe8iXOW078E+sGUn7CLffy2i4Qggbv-UREg@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] net/tap: simple refactoring
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, leiyang@redhat.com, davydov-max@yandex-team.ru, 
 yc-core@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Jan 16, 2026 at 12:47=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> On 05.12.25 09:19, Jason Wang wrote:
> > On Fri, Dec 5, 2025 at 4:05=E2=80=AFAM Vladimir Sementsov-Ogievskiy
> > <vsementsov@yandex-team.ru> wrote:
> >>
> >> ping
> >>
> >> (now as 11.0 material)
> >>
> >
> > I've queued this.
> >
> > Thanks
> >
>
> Hi! Gently remind. Aren't these patches forgotten?

Thanks for the reminder. It's not, I plan to send the pull request no
later than the end of this week, it should include this series.

Thanks

>
> --
> Best regards,
> Vladimir
>


