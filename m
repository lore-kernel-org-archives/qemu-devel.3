Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB0AD73EAA
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 01:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vldji-0000dD-Sp; Thu, 29 Jan 2026 20:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vldjh-0000cl-2y
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 20:55:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vldjf-0002P5-JK
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 20:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769738144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DDbR0+m0j6FfL91NbORL+AQy+tvqB4jmhP8gP8ZDIHk=;
 b=ZPx3EqxwE1ioUMVOUzHMNKxn9Ov0E/bVjjX3pe9hQRQDRR2GzzwFCYlGNLIDq4ZFf2kguL
 pGMQDMglNKxoo1gdk2/LsXulYbWQhj9tmMh7BGt+aycv35igiWA110gcOmZg46Q3xh4xDo
 bH6N6+jgzxkia7mH2zuqbceqvJOYI78=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-UeCiwG90MfmOmiIVHCeS6Q-1; Thu, 29 Jan 2026 20:55:42 -0500
X-MC-Unique: UeCiwG90MfmOmiIVHCeS6Q-1
X-Mimecast-MFC-AGG-ID: UeCiwG90MfmOmiIVHCeS6Q_1769738141
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34c43f8ef9bso2598316a91.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 17:55:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769738141; cv=none;
 d=google.com; s=arc-20240605;
 b=ECBX6e3necyQRaa0jKiue6Fv0a+6fbxJCqjurwmgMxkk3SzATF2oxmO9fhSxbfvqPK
 qvMXzNA9fgCAA8yssZkjJHbpO//fPIqrj/bQ7DomyRR7/y0HAPge11jKj4e7qmj5vClB
 o13dsPqIdprPoDGRmA5CeoAkkoDQCwNNo9YbfjCGCiP0gc55nzgROAEqNlkbwe8nCucP
 FkeWDZMkVStEEjYY49U5lZClEgGB8C5eapI9uKYxyLR8CloB/F2+xYoiTq3jz4AlmtNG
 yiFS+HAfT9iqc/UHV81beLQfx4MskQLgd1nOYmxdbH7f/LLecVzQDGtuniWHfzEcrPOf
 Ye8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DDbR0+m0j6FfL91NbORL+AQy+tvqB4jmhP8gP8ZDIHk=;
 fh=gy8fdH3+lk3Twu6PS/F4/DPKzFeI1rELOHwIjaKAg1M=;
 b=XJxeL61XtaO3efMqZEz5ErFfFjxh6fJmDA16f+jrn0GJVJUz9ZgjHqPTShjKj9fROw
 m1o94lxVgP8Voh44nXsQCAYuckqaFddoMhlSf/Pv5GLdD+E/ufmo+4aXLP7d4aI6u0VX
 Z38ZbiMAxgry5rUfXPsNS5PLpTOIUDkTqL+rBMTc3HN/z8OdOhamcOWdQUWsXnA6fLLN
 KREsRjn3kllzPm1j8NhcOxxlFj3fORKLUojVCmfg29cuFSst4TfpnnARgLdJKUEGbwlU
 t65WFXzMqg4kss207UuXjppsGYFlhgn4YvRGPPxwVPp5J5jaZV4EWtDNOfw7L22VMRB1
 AkaA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769738141; x=1770342941; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DDbR0+m0j6FfL91NbORL+AQy+tvqB4jmhP8gP8ZDIHk=;
 b=eLex9BTjrzHX5k60xObjNfxBO7UGhTQWBK6IOShwjHaJpvmCNbxyy6pHzRjresPfro
 zQcJhd2ibHw8QCmZRJ7kiOSAUw2ggY1uHfFzZPgxeDu4v9wphrBcp7QT6q96MvS8+1yW
 EF3CnmtcM4SmvCmH3HMfhI3amCLjkCrOHzKcVQjDQ/Y9CacrKThc/WPe8qiztgFWXLof
 +NYa35w1mIfaSLF/xvODpZp8Zrx+odYolo1gkaMKeb86snNR20xnevFPbFDYp1y92vTN
 PXRT27yhz7Ry5jfneu4IkeQecLPnCMHMPpVUYnv00kp0wFm0AWz6Tgz2eCmH9aeQcdlC
 6DgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769738141; x=1770342941;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DDbR0+m0j6FfL91NbORL+AQy+tvqB4jmhP8gP8ZDIHk=;
 b=LTDEfDJWhyNRmXITsum93sev0UKh0tK+cJAoty0LSfXlXAG1WxvprjjOCvU1FKuK0W
 PzEGmN+H7sO5jdAnV6w+MVGRPyJxPyKlNHw+rGYULT1+dS5fL1MU5agseWFhvNuTNd2f
 dqtOeU+qH7NG4I7V6Oxd2KgnJzVS0/5a/zqHtQYghqrTj7YeK9i0O8kCGciM5cW9lf5X
 50dj/t+z7gmqv9foMpax6exaXBr+LvygEnkODpG+UCS2hmUUjHNx7ATUPxRakVLdjqUk
 xwGd+JVqMPFTEsMdI7Gm3KS2bLXno7h2/HCtlGoXVLqq6tUAjiI6Hhile1sXHVc7v4Dt
 yhPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7Ur9HUfv6aO+3dC47A3kBFXiI7EgJT7d+nfL8zfL0fgaMLDeZ3RgB5VI5Z18IdQ/A4+a2CxtuU2Oc@nongnu.org
X-Gm-Message-State: AOJu0YzOc75HW5hKXNb7TswqIG+w+Il2a9aGgDn7ma6oyNDkCNM7t5Cd
 j04df/ZjN/oJw5hIQisJfbbKHoQCSKyvET5Z6K2mOl/E+9zXmwU9O0MQpBKozbzBWA6iT3YYG7l
 VDslFmMApo7u/Whl3tx3QgTLkghQfN1zy32CbKw17PWd7CXoAp82P6UpsLlr3jPEdfFZHNhfZNv
 07bNTG6aB19vRJLtajLzBvj+q9o0fUf+8=
X-Gm-Gg: AZuq6aLYZXPsqjLrFh8BgFB0X7GINaaIMaQZClpHSwl0/iOAiXmt+bxldVZZ+AnnU7v
 4ANeSO+vx+7LoFbu7GVpBEYTIN7PVv55q5A8KJmcGH1270gi/6y9zhXe4BI/eUoQD6i/LEv1+t5
 Ceob+/tawUsmBXnV4xDqVZffchdXAZAa4627SzEDi7tvTzJrDRcSEJAWDb3ef7Kopz
X-Received: by 2002:a17:90b:1c0e:b0:340:8d99:49d4 with SMTP id
 98e67ed59e1d1-354299f24a8mr4242254a91.1.1769738140917; 
 Thu, 29 Jan 2026 17:55:40 -0800 (PST)
X-Received: by 2002:a17:90b:1c0e:b0:340:8d99:49d4 with SMTP id
 98e67ed59e1d1-354299f24a8mr4242249a91.1.1769738140477; Thu, 29 Jan 2026
 17:55:40 -0800 (PST)
MIME-Version: 1.0
References: <20251113071711.349651-1-vsementsov@yandex-team.ru>
 <CACGkMEv=UYKjc5jZRSQCzgzCe6Bdz8OGMHYA5F-5OkRVrRom9g@mail.gmail.com>
 <a8a29f4e-ebc2-40ed-ad2d-4573a007d994@yandex-team.ru>
In-Reply-To: <a8a29f4e-ebc2-40ed-ad2d-4573a007d994@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Jan 2026 09:55:27 +0800
X-Gm-Features: AZwV_QjFMWNKAM7yYg8EEPjKvVtq4zg9sGsEv_yYlicOSNVmnBZ49Es1ti5nR0E
Message-ID: <CACGkMEvkV_mc8AsykSn1J_2RUG8Q2NwAucGZf6eE0eM6nnbLiw@mail.gmail.com>
Subject: Re: [PATCH v6] qapi: net: deprecate vhostforce option
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: devel@lists.libvirt.org, eblake@redhat.com, armbru@redhat.com, 
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, 
 qemu-devel@nongnu.org
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

On Fri, Jan 30, 2026 at 5:21=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> On 14.11.25 04:34, Jason Wang wrote:
> > On Thu, Nov 13, 2025 at 3:17=E2=80=AFPM Vladimir Sementsov-Ogievskiy
> > <vsementsov@yandex-team.ru> wrote:
> >>
> >> This option for tap and vhost-user netdevs doesn't make sense
> >> since long ago (10 years!), starting from commits:
> >>
> >>   1e7398a140f7a6 ("vhost: enable vhost without without MSI-X")
> >>   24f938a682d934 ("vhost user:support vhost user nic for non msi guest=
s")
> >>
> >> Prior these commits, to enable kernel vhost-net, or vhost-user-net for
> >> some specific kind of guests (that don't have MSI-X support), you shou=
ld
> >> have set vhostforce=3Don.
> >>
> >> Now guest type doesn't matter, all guests are equal for these
> >> options logic.
> >>
> >> For tap the current logic is:
> >>    vhost=3Don / vhost=3Doff : vhostforce ignored, doesn't make sense
> >>    vhost unset : vhostforce counts, enabling vhost
> >>
> >> So you may enable vhost for tap several ways:
> >> - vhost=3Don
> >> - vhostforce=3Don
> >> - vhost=3Don + vhostforce=3Don
> >> - and even vhost=3Don + vhostforce=3Doff
> >>
> >> - they are all equal.
> >>
> >> For vhost-user we simply ignore the vhostforce option at all in the
> >> code.
> >>
> >> Let's finally deprecate the extra options.
> >>
> >> Also, fix @vhostforce documentation everywhere to show the real pictur=
e,
> >> and update vhost-user test to not use deprecated option.
> >>
> >> While updating command line options, drop "experimental" word from
> >> "experimental in kernel accelerator". vhost-net is in production for
> >> years.
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru=
>
> >> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>
> >> v6: - update numbers 10.2 -> 11.0
> >>      - add r-b by Markus
> >
> > I've queued this for 11.0.
> >
> > Thanks.
> >
>
> Hi! Isn't this forgotten? You've recently pulled some my commits, but thi=
s one is still not in master..

Apologize, this falls through the cracks.

Thanks

>
> --
> Best regards,
> Vladimir
>


