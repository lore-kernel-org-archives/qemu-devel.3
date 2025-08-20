Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE89FCA0EE6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 02:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoYeN-0003YU-Vo; Tue, 19 Aug 2025 22:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uoYeK-0003Y2-GB
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 22:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uoYeG-0001g0-SA
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 22:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755657238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nPwy6+VLiuA7RzA0JYQfp6xpgY8i7J4k6EsdsMd6jyA=;
 b=Uj4RZriBX6wquc0nQCQ1dCSSce78ARq6JkFI1JmYWvxAR5GT6/bE/hcpm6abP4uVDRhfHC
 Uwitp+fjMFlr+4R1DUVRKsYHXSDQAlTzDdSBdfZQcUlN7qWCSWwGtDKaZh/bz9SozKpff5
 60nbSRzvh9xW5A3TaSAWIBezWpAF3p4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-4b40vzOxPACMNKLamybMHw-1; Tue, 19 Aug 2025 22:33:56 -0400
X-MC-Unique: 4b40vzOxPACMNKLamybMHw-1
X-Mimecast-MFC-AGG-ID: 4b40vzOxPACMNKLamybMHw_1755657236
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-24458297be0so137108655ad.3
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 19:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755657235; x=1756262035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nPwy6+VLiuA7RzA0JYQfp6xpgY8i7J4k6EsdsMd6jyA=;
 b=n3voeGqUau9UvyO4aEH2tl+5axe+rlQl6gNBDk4UgTtd8ejH2VdFsUv/7HfpNrqVfo
 uMdefnqTFvSg1cvSgNtVcjCvqYMQ+1wFNICs1emG4HlFomGru49HHVVeYFqilHzHlojn
 Q5mJRN/K75ykdVcjKc25eueua0t+phnOiwotfvGFcn4otf7Gw0sRYSCaREoatbxJCP4l
 WxLPdO+ibgQQ3EN/va/hEWmboxO+H7yZ7WSXLlSM9Jdgq/cj6NnRktXyRTI6orOn+O0G
 k/z7l99ItbBpN0RKQ3qILjkc9akC8MNijC4ZlPi0U5/6niPJHLTEjkM45PjqkyNqMo97
 qiNw==
X-Gm-Message-State: AOJu0Yxt4GinidD67AYcWkCWAUeqU5cbUmwK6vizwIQ9TBKgPtPQ8D76
 zIU3MWKpSt9pW9hrqKYqORVV2to5rotdlROeaMIDHIlRy7otjt/TVZ52mFMh0iQyaGAJqiDYWFR
 vXRvGRfWxVk7y1GWv20qkvowToQKLox2QrjreDt3RmFOA2X/frwsDyFyVwONvjnzaYGlsAcyngI
 Ajuasb4Ezs8lP2xFWBs/rE3e5BoMj/PptviPZlvN/yVFbk
X-Gm-Gg: ASbGncv2D6hvwga1XCU+JkMUw+15FGpIro+9iGhi9XAQqmKcMoqFHoDkj/mL0jaY+yx
 KXs9gRhujbHEdMRcVpmHYjLTzgyuNhW6vnE/Bzv7X3J4FL3AU8qiqp0dil3UhvnX/7TsSq0zS+T
 wENAX8Xxidiztr84lVtYtSM6A=
X-Received: by 2002:a17:902:fc8e:b0:240:14f9:cf13 with SMTP id
 d9443c01a7336-245ef278ba4mr14051485ad.51.1755657235343; 
 Tue, 19 Aug 2025 19:33:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXvysspjBtZ2Bz4GALhSjZvufK4rNhHtKtE2n4Jwd23oIQMgY32tl2fJe8qgXoxegn9mhCCbof0PETnwa2JFc=
X-Received: by 2002:a17:902:fc8e:b0:240:14f9:cf13 with SMTP id
 d9443c01a7336-245ef278ba4mr14051105ad.51.1755657234749; Tue, 19 Aug 2025
 19:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250818140645.27904-1-vsementsov@yandex-team.ru>
 <CACGkMEvHXy0=vwAGS+2S7jCa5TjLxOso-SYb15TTE5q=VtPA2A@mail.gmail.com>
 <bcc0adcc-4d50-454c-abf9-334e15c712e4@yandex-team.ru>
In-Reply-To: <bcc0adcc-4d50-454c-abf9-334e15c712e4@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Aug 2025 10:33:43 +0800
X-Gm-Features: Ac12FXxYNlm7Nw5hfnm5Sshqaz1flNPwRIZJ0W2Y8S2AaoAnPVv92lMRdbZOEZ4
Message-ID: <CACGkMEsh2XCHsvMF49xJ0SrxY4bRAvjVWASrxWjqqsBYx5XKZA@mail.gmail.com>
Subject: Re: [PATCH 00/19] TAP initialization refactoring
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 19, 2025 at 4:41=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> On 19.08.25 05:45, Jason Wang wrote:
> > On Mon, Aug 18, 2025 at 10:06=E2=80=AFPM Vladimir Sementsov-Ogievskiy
> > <vsementsov@yandex-team.ru> wrote:
> >>
> >> Hi all!
> >>
> >> As preparation for further development of TAP live local migration
> >> (passing open fds through unix socket),
> >
> > I'm not sure I understand this, but I think it has been supported now,
> > or anything I miss?
> >
>
> Hmm, may be I missing something, but where?
>
> I see no code which put TAP fd into migration channel. Nothing about migr=
ation in tap.c at all.
>
> So, normally, to make local migration with TAP device, you have to create=
 a new TAP for new QEMU
> process.
>
> I want to add a migration state, which will include needed part of TAPSta=
te, including fd,
> to continue using same TAP device in target process, avoiding also any in=
itialization steps
> on that fd.

Ok, I see. But the question is that TAP is not something that is
visible to guests. Doing that may be a suboptimal as we need to deal
with the migration compatibility.

Can we simply teach the management layer to use the same TAP fd
instead assuming it's a local migration.

Thanks

>
> --
> Best regards,
> Vladimir
>


