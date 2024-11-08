Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B40D5C0C0
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 12:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9OFs-0001KG-6K; Fri, 08 Nov 2024 07:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t9OFm-0001Jv-5R
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 07:38:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t9OFh-0003Eo-AF
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 07:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731069491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MZEbbVPOIY9IXV9V6NIJFi0q/d85Jvj9KqLe3S17U5o=;
 b=K4RH1ts5UZBkeSCuaOF74FBfII7Oq8NXI5Xb8zqkzB0NtMdVwqyqt7HWD7E3K2xAUe4nsV
 +RH+SoVtSskg+8aa8BZmDTfxhFFjMwFvuY66RW8jRv86PY5m6Nbjq0raoLn/LN7JRb0/rR
 xM1h0M105Zcs0kol/tpVsqreebsRse0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414--GX1p6bHPFOImXPpKaeblA-1; Fri, 08 Nov 2024 07:38:07 -0500
X-MC-Unique: -GX1p6bHPFOImXPpKaeblA-1
X-Mimecast-MFC-AGG-ID: -GX1p6bHPFOImXPpKaeblA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315f48bd70so14796095e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 04:38:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731069486; x=1731674286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MZEbbVPOIY9IXV9V6NIJFi0q/d85Jvj9KqLe3S17U5o=;
 b=t90HKF/Z2kGeEC4ZcJ81n0zqboFVOoB3IfhD8o04TZz2abpcLjTJ1cT1z/PzXR4umA
 L/yCkhZDRcuZKgMtG2gxNG0ASF//GapU67mExdo1KgU8XehoTaV8sSx0w6TDczmZoKZE
 IEtt3bCYNaRdEMREFUlRzit52po7W2W9ew176kTycj86bWS+ZhEpphLH7pbw/eB7pFEG
 3EaUkSM59VYa9M6f3sMnee2y8e+PTHLYhy9z6urUF511hRUPi+ulZQSZW5PcoDIc3Sl/
 LiBKmxMiH4ueCf6G2kSMwMu85RH7ZclgJPrJR6hb3Bixg5cnhZS/3bVUbTCDY2Nl4hcy
 R0jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQUt4+N5Wv6ktOz/yBRUVUjXBtZfinEnM1/nBN8RMrL7I/phamvV8iVUpvo+0oxyFlqByshea/PFFc@nongnu.org
X-Gm-Message-State: AOJu0Yz4K1qImRl10KvD/qFQetrtAXejqo5WuRhksdo4PLhJs+was4Fl
 oRZgcPWb2hc6XtfhI/ke9nReZixCiyhfHOZy+aRhZXOYpll14cKWY5LcgLR8M//efyXmEJxrkiq
 kIPrlKuGb05UVjaCxl9gJxD7soJ+diY3fotbxlQ8QYrGuw3QsYbtpT5nOAKNZG2gOH7H3QrOFE6
 d0Wb/TTvLX2MeT1hVzr6ztAsqW5Wg=
X-Received: by 2002:a05:600c:46ca:b0:42c:bd4d:e8ba with SMTP id
 5b1f17b1804b1-432b7502429mr20731515e9.8.1731069486580; 
 Fri, 08 Nov 2024 04:38:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYgpM/Oi/zzP+vPNf+06u5zDnCvEaAVcHefPItsQrjnDR4z/VkY4rg+2pArn5eg0zrAE2K2ac7NhlBFgMPOes=
X-Received: by 2002:a05:600c:46ca:b0:42c:bd4d:e8ba with SMTP id
 5b1f17b1804b1-432b7502429mr20731285e9.8.1731069486208; Fri, 08 Nov 2024
 04:38:06 -0800 (PST)
MIME-Version: 1.0
References: <CAE8KmOyzWRqpGDOyAK7V2X8+SWVt_kR1897tiFm7vdBNRRE2QA@mail.gmail.com>
 <ZykB3voFw_-ByWfh@x1n>
 <CAE8KmOzuGxdU7zp+vsf1yY_FP8bf-KTv7UJ+8h6bfmkE=0H-bA@mail.gmail.com>
 <ZyoW3ue3WTQ3Di1d@x1n>
 <CAE8KmOxW8K-YoCUbK5XOLeUQk8WCPB4UxbaQuUONhzsanvrLMw@mail.gmail.com>
 <87ldxw1p8k.fsf@suse.de>
 <CAE8KmOwM2wjkyUZL5v=3gjkUNa8VhA6oick35KMX-FO2-BidaQ@mail.gmail.com>
 <ZyyzjWY-1nPpPgSW@redhat.com> <ZyzoGvOaybHs4uMl@x1n>
 <Zyzxihj37-pfTQWx@redhat.com> <Zyz8wnTkooE4V4UQ@x1n>
In-Reply-To: <Zyz8wnTkooE4V4UQ@x1n>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 8 Nov 2024 18:07:49 +0530
Message-ID: <CAE8KmOwOsb-qot3sUfXJF_NvG=zgwxr=siaRCFQmht05v_sT+Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] migration/postcopy: magic value for postcopy channel
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Peter, Dan, Fabiano,

Thank you so much for the detailed comments, I appreciate it.

On Thu, 7 Nov 2024 at 17:41, Fabiano Rosas <farosas@suse.de> wrote:
> The handshake will be a QEMU-only feature. Libvirt will then only start
> the migration on src and QEMU will do the capabilities handling.
>
On Thu, 7 Nov 2024 at 18:03, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> Libvirt does what it does because it has had no other choice,
> not because it was good or desirable.
>
> This kind of handshake really does not belong in libvirt. A number
> of exposed migration protocol feature knobs should be considered
> private to QEMU only.

* Right, okay.

* So then IIUC, libvirtd(8) would invoke migration by sending (without
first checking with the destination libvirtd(8)) the migration command
to the source QEMU and in qmp_migrate() before setting up the required
connections, QEMU will add the feature negotiation (or handshake)
step, right?

> It has the very negative consequence that every time QEMU wants to
> provide a new feature in migration, it needs to be plumbed up through
> libvirt, and often applications above, and those 3rd party projects
> need to be told when & where to use the new features. The 3rd party
> developers have their own project dev priorities so may not get
> around to enable the new migration features for years, if ever,
> undermining the work of QEMU's migration maintainers.

* True. I've seen the mismatch/disconnect between QEMU features and
how libvirtd(8)/virsh(1) offers them to the end users. ex. What QEMU
calls Multifd, virsh(1) calls --parallel-connections. Features like
'postcopy-preempt-channel' are implemented in QEMU, but no way for an
end user to see/enable/disable it from virsh(1) side.

* TBH, Multifd is such a misnomer, it could have been a plain simple
--threads <N> option.
    ex: virsh migrate --threads <N>: precopy migration with <N>
threads, default <N> =3D 1.

   Irrespective of the number of threads, the underlying migration
mechanism/protocol remains the same. Threads only help to accelerate
the rate of data transfer through multiple connections. We don't have
to differentiate channels by sending magic values then.

* Since we are thinking about correcting past wrongs, does having a
unified migration protocol make sense? OR that is too ambitious a
thing to think about? (just checking)

* Meanwhile, @Fabiano Rosas If you have not started with the handshake
or feature negotiation in QEMU, I'd try it on my side and we can
discuss how the handshake should work. If you've already started with
it, I'd be happy to help in some way as possible.

* Are we thinking about dynamically adjusting migration features based
on their availability on both sides? Ex. say source says open 10
parallel connections, but destination can do only 5, then source
reports an error and terminates migration or continues with 5
threads/connections OR say user does not mention parallel connections,
but still we automatically start multiple threads because both ends
support it? Just checking about dynamic adjustments, because earlier
while discussing with Peter, he mentioned that we can not
enable/disable user supplied options.

Thank you.
---
  - Prasad


