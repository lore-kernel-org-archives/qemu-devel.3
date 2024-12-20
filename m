Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D59E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 23:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOmpJ-0002uK-Bj; Fri, 20 Dec 2024 18:54:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOmpB-0002tX-Px
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 18:54:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOmpA-0004zx-CX
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 18:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734738865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H4k97rFkfTApWV4ufhYHVn+GAg4VFcYKKZeZDsES8yk=;
 b=Uz0MAeBxOfOcOTvLOUU1Zk0siJklb2Rz4MW4OQ2F+1z3qOcFAZh9ZNHVXi4ECVLucS1bDx
 niTEJKSr+zHQ1oIQReXyIYdO4jJOiAuQW35WKMpQFTVEuvnT2fmvzpFm9di8ki/0Kwq24l
 EWknPZXhEMG7gUCCsMKnnhq5e+jdCW4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-IVNxVrWzN2KYHaT5RnOA0w-1; Fri, 20 Dec 2024 18:54:22 -0500
X-MC-Unique: IVNxVrWzN2KYHaT5RnOA0w-1
X-Mimecast-MFC-AGG-ID: IVNxVrWzN2KYHaT5RnOA0w
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385ded5e92aso1075327f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 15:54:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734738859; x=1735343659;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H4k97rFkfTApWV4ufhYHVn+GAg4VFcYKKZeZDsES8yk=;
 b=dbhdH1TnwBDi7etEIoAz3OSRuYFhJMv1zINImy9oEjZSyDOieMh4p6YQZdsTnFzvwM
 G86o7fEfh2pr6OfFgL5mJAlDP8EI7aZMy6nhpyI7ceD8Y4djBd3lkCC+RWAg+4wTdsUl
 Ee2jkfRukRi+jCZIXSlNgmG1IGvzXH3XIkjDkfOd4dj5sODxHFQ3I/mroT4gQ88w5N3w
 lB12BIvMc1hmxY/175SYExqkzAGx4m0GcqZFw/kTTmh5NYaSIer3uDcwzSgSSFh4R4im
 rPjRXuee38zzdTSuQl4OeWPYTIX+m80VPiXHFLL9hB/aJitC4QpbtCxZxXC+GmD4WHXP
 q0fA==
X-Gm-Message-State: AOJu0YwUI92OpRGxErRxqQravkTl3O3zUBozjDYRrTgnuKBHcLSBjn+P
 8WQVCzfgfTbJrAMXdL/poHUO6vzVAMUfPRrkVJ/pZaAxm7z+oU6/QMFsgTSy7cIssLxKJCZzxqk
 51i8v7SggOoS9AzwJ5mjswCDxrwRYAQxAIweGeJIZG/RO8a57/a0UmC5BVgfG6aGG6yv1akqfBd
 OGyMwEFZh3ndNIlIubJhoptaSjrnQ=
X-Gm-Gg: ASbGncvKwhVCRqiqtE319ln3yYgx8gEJ1kt4Wl3xX3DWJtbKndR6e89UO0IRML/o3qC
 7AmmOWcknkjeuEG/bQR0YEfeTJG7Ry+A21q+S+g==
X-Received: by 2002:a05:6000:3cd:b0:386:1cd3:8a03 with SMTP id
 ffacd0b85a97d-38a222009camr3714008f8f.32.1734738858704; 
 Fri, 20 Dec 2024 15:54:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKQYZMZf1R8iWFFDxKuch9Dp0+7nybQDls3ssmMJmeIuxXpqI0X7hWlIypCct1k5zkFeRTEGrbFC4W92b5w6I=
X-Received: by 2002:a05:6000:3cd:b0:386:1cd3:8a03 with SMTP id
 ffacd0b85a97d-38a222009camr3714002f8f.32.1734738858434; Fri, 20 Dec 2024
 15:54:18 -0800 (PST)
MIME-Version: 1.0
References: <20241220104220.2007786-1-npiggin@gmail.com>
 <20241220104220.2007786-14-npiggin@gmail.com>
In-Reply-To: <20241220104220.2007786-14-npiggin@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 21 Dec 2024 00:54:07 +0100
Message-ID: <CABgObfbZsfCCQotUXpRAM_-T5nM_w3tW_DOc6E5bc6XDz7niXA@mail.gmail.com>
Subject: Re: [PATCH 13/17] hw/scsi: Convert to new bh API
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 John Snow <jsnow@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006f788e0629bc5d8b"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000006f788e0629bc5d8b
Content-Type: text/plain; charset="UTF-8"

Il ven 20 dic 2024, 11:44 Nicholas Piggin <npiggin@gmail.com> ha scritto:

> Convert aio_bh_schedule_oneshot() to aio_bh_schedule_oneshot_event(),
> which can specify the clock type, making it compatible with
> record-replay.
>
> Operations on SCSI reqs do affect target machine state, so it should
> use QEMU_CLOCK_VIRTUAL to recorded and replay the bh.
>

This does not seem to match the patch below?

Paolo

+    aio_bh_schedule_oneshot_event(blk_get_aio_context(s->conf.blk),
> +                                  scsi_device_for_each_req_async_bh,
> +                                  data, QEMU_CLOCK_REALTIME);
>  }
>
>  static void scsi_device_realize(SCSIDevice *s, Error **errp)
> --
> 2.45.2
>
>

--0000000000006f788e0629bc5d8b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 20 dic 2024, 11:44 Nichol=
as Piggin &lt;<a href=3D"mailto:npiggin@gmail.com">npiggin@gmail.com</a>&gt=
; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Co=
nvert aio_bh_schedule_oneshot() to aio_bh_schedule_oneshot_event(),<br>
which can specify the clock type, making it compatible with<br>
record-replay.<br>
<br>
Operations on SCSI reqs do affect target machine state, so it should<br>
use QEMU_CLOCK_VIRTUAL to recorded and replay the bh.<br></blockquote></div=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">This does not seem to =
match the patch below?</div><div dir=3D"auto"><br></div><div dir=3D"auto">P=
aolo=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D=
"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+=C2=A0 =C2=A0 aio_bh_schedule_oneshot_event(blk_get_aio_context(s-&gt;conf=
.blk),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scsi_device_for_each_req_asyn=
c_bh,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data, QEMU_CLOCK_REALTIME);<b=
r>
=C2=A0}<br>
<br>
=C2=A0static void scsi_device_realize(SCSIDevice *s, Error **errp)<br>
-- <br>
2.45.2<br>
<br>
</blockquote></div></div></div>

--0000000000006f788e0629bc5d8b--


