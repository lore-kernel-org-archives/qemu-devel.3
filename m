Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55B3C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzDMl-0003cD-0L; Wed, 26 Aug 2026 09:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzDMj-0003bK-1C
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:08:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzDMh-00010a-BW
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787749706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QoCSOzI45Itufc9voOV+yZkRqvuzGYKWQZIfic3RwL8=;
 b=boIt5sZ0nG0tTH0YUszFyD6U2OMgIrLJcFHwFJB8saXzdlotrsk5pmvXcymYezhOXS/y1P
 JuAJsjfcJPrA0Pb8tDQRL4BD/BLwF23JrJgXhImAM/EhmRuuBSjYBgFA5cOmw2KOw1uhMI
 C0MX1FW0rFRftRP0yZzmYZgR+MRlNUk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-E01sWuuxMkq9KvvZYLLedw-1; Wed, 26 Aug 2026 09:08:24 -0400
X-MC-Unique: E01sWuuxMkq9KvvZYLLedw-1
X-Mimecast-MFC-AGG-ID: E01sWuuxMkq9KvvZYLLedw_1787749704
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc1cdfb337eso346771a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 06:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787749704; cv=none;
 d=google.com; s=arc-20260327;
 b=EuRPjI920ihVJtPNe/eDP35zyiy6WF0gMKrs6KIG66YjOKwGTKL9P0cvTodcBd8Ppb
 pd/hcIlXl7qy7yAoOEkb4pH9EVgVdwkudBPG+cPMjmrkP2oAoXK79oal3C4RfuaNYmS4
 zNx0DNiw3Iiqmp9QRkh+NNgpNzFHIi2a7161GlPLoghkdrGDs9Fl70emTynD5fTYvFSl
 UA6JvY+CBHTEL4vSsdT2Qq7gO9hjwQXvvA7H/zKsrbifn7ZxLsvmc5XvC/f7S/oma9Lh
 YGO3+0oKbmHjAtNNmYtSW8XqDsLbT4VhRFvOQLKapBxu5h8t1Pk2QlP2s6l2j+pBi2Hp
 DCEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QoCSOzI45Itufc9voOV+yZkRqvuzGYKWQZIfic3RwL8=;
 fh=tRqzMg6IAwxpdMfHxGpkqttIW7DliqjPrzykKCFHKCw=;
 b=oY7aSTxXx5ASIjTDTB4IFvyTBgTdVRlZ7wMT7VRh0VjGqWVUJBje+MRZXUvxer3roR
 DoG4KafTri3+TlnCd9jerhTS29cPFbKINL6tP/TUAni1GAYqnHeXpf9WVHtnsQcglSJ4
 o8UEXmkf9HvFiD0TdI/Zdff/bWf9ZLJDORSs2kEIuBHPYCo5lAsmXetShKgVEYq34xOU
 oGTgpa/0QSQTXXJoY7Owkxq0HdfB5wU54wmlvx2OfexotVpxS0tIgnnAuGVFeSRm0Iqd
 ZgbxF6ZmKj123qDMV67RqdnJAtghS55g2p5DHLgUihbtoFSLVt5QzhEOR+nhpQwdZgp/
 qtWw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787749704; x=1788354504; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QoCSOzI45Itufc9voOV+yZkRqvuzGYKWQZIfic3RwL8=;
 b=O0KjdZ30S/fK17RfwydZqVcm47WJ24y/+mUbj3STELjjmhkIJjAvQR5aFYNBRo4KEF
 x48YLyfcb5VVq+3aoSnPqK6CCz9C4UFvwEBOx5PtKixVsxhCDr0EnVoIh3NH5t53e2AZ
 sUgLL1IhjZcxzgIOtCqRhDKZx4V76YCytKprLk3pT461+nLsHRMh8t+MuXMeAKIHty1o
 EsPIuFE/9yvEz+SFGsR3CYFJL/xFQArc1dJy2KeWhbm/vMzY0wR463iX+06OxzxEE9Mj
 dWKTPSoS4FLizsebeEpXCe8Yj4YnCpOtHxshTaUT5O/NoVKV4zjkENVTpObOc64v/gLE
 TPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749704; x=1788354504;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QoCSOzI45Itufc9voOV+yZkRqvuzGYKWQZIfic3RwL8=;
 b=YNSetRAk+WQAjY932LYSCo0fWXDoGL+ozH8k3Wxo23GTdY/eBBjKssV3wTiR6j44yb
 hE2iLYdNOXKypw+y7iFYh2dbKvUiYjmqUJcPS+pcT7H1omunOM4C1c2PO5tG3ewdjJzM
 vItHoIy+r7uaK1PF4fdmrKXDLoZxpO9XiHXZTuhCy6bU69i5Qb127d59RyxGZm+MbwOy
 jNlh28MhYYsYtnb5BM9yYLUSA11I6z7MY1lBHu1K2DPCSIKSrM+O4nvLMVYW7mRm8GOR
 NIxiwA0I5xAVAhMKOtd6uY9BP9pmb0/gDJLhtlJHUgjYBWws7ewWWf58zGc3ItmbJkU3
 rhAg==
X-Gm-Message-State: AFuF++ltyVoPl6fQH6+BQTABJi7n9ZVrnbMDu2r8b1fnZtv3FqCGmixv
 UARAvSIgTykyCji4D3QlprxFfcGVFz5GvLdZY0VjxUUPvzRPFWVTzuk9eiW48ECl065XPMvIy7m
 Xo91eDPG3UYEFLoMm27hjfdNeQwU0RX+44roQwuo/JA24htUcxsYNfw5FGqnmJgzJtiwV76fjGf
 UA1pEZj3Om8TQ5k1Nm5lZf+8q1P3ddtdE=
X-Gm-Gg: AR+sD11yCkvnA7d0x/omRLI7WErjUBJ72Xd35/GY/IYYF2LyrUeippxAVaBYRQhKc7I
 8ToD/tBGyiyTxgqacnA9a22UUNEmZalEF9rjmG3GUq5dRGyxCnO9g04ANT30UE1ngIJw5eLGaIl
 OjGEMidQMTM3rAMTV7hafRzcTL0gf96RjsXc14eI8H0beGf0Dvnlhk8UGcJpzDIy/gHC1/EYA/t
 qR6veKj86JT96ok4TVYgdms7g29Ox01kSNVeg740ditafDiwQm+vge3efttsKBfWaxTo5vyUjH2
 lQ==
X-Received: by 2002:a05:6a20:6a09:b0:3cb:8810:631d with SMTP id
 adf61e73a8af0-3cf7596814emr11725614637.1.1787749703559; 
 Wed, 26 Aug 2026 06:08:23 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a09:b0:3cb:8810:631d with SMTP id
 adf61e73a8af0-3cf7596814emr11725456637.1.1787749703063; Wed, 26 Aug 2026
 06:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-21-af60857c2fbe@redhat.com>
 <ec58e02f-6ced-4910-94af-0aac76b010bb@oss.qualcomm.com>
In-Reply-To: <ec58e02f-6ced-4910-94af-0aac76b010bb@oss.qualcomm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 26 Aug 2026 17:08:09 +0400
X-Gm-Features: AcwNN1V0alJkCCf5vhpalDKZWOK0wNf_4RCi128R-5gIFZbYpKs_O83kBttmuJM
Message-ID: <CAMxuvayE-8ymQax7f8qZ1AODdGKTNbgy-S5nOaU4yjeN8HEd5Q@mail.gmail.com>
Subject: Re: [PATCH v4 21/49] block: add x-qemu-io QMP command
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi

On Wed, Aug 26, 2026 at 4:44=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 25/8/26 21:09, Marc-Andr=C3=83=C2=A9 Lureau wrote:
> > Add an x-qemu-io QMP command that runs qemu-io commands on block
> > devices. The command accepts a device name (block backend name,
> > node-name, or qdev ID) and a qemu-io command string.
> >
> > Refactor hmp_qemu_io() to be a thin wrapper around the new QMP
> > command, following the standard HMP-over-QMP pattern used by other
> > block commands.
> >
> > This change is also required for the qtest qemu-io command in the
> > following patch.
> >
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   block/monitor/block-hmp-cmds.c | 60 ++------------------------------
> >   block/monitor/meson.build      |  1 +
> >   block/monitor/qmp-cmds.c       | 79 +++++++++++++++++++++++++++++++++=
+++++++++
> >   qapi/block.json                | 34 ++++++++++++++++++
> >   4 files changed, 117 insertions(+), 57 deletions(-)
>
>
> > diff --git a/qapi/block.json b/qapi/block.json
> > index 46955bbb3e34..012a9d73333b 100644
> > --- a/qapi/block.json
> > +++ b/qapi/block.json
> > @@ -603,3 +603,37 @@
> >              '*boundaries-zap': ['uint64'],
> >              '*boundaries-flush': ['uint64'] },
> >     'allow-preconfig': true }
> > +
> > +##
> > +# @x-qemu-io:
> > +#
> > +# Run a qemu-io command on a block device.  Take either a block
> > +# backend name or a qdev ID to identify the device.
> > +#
> > +# @device: the block backend name, node-name to run the
> > +#     command on.
> > +#
> > +# @qdev: the qdev ID of the block device to run the
> > +#     command on.
> > +#
> > +# @command: the qemu-io command string to execute.
> > +#
> > +# Features:
> > +#
> > +# @unstable: This command is for testing only.
> > +#
> > +# Since: 11.2
> > +#
> > +# .. qmp-example::
> > +#
> > +#     -> { "execute": "x-qemu-io",
> > +#          "arguments": { "device": "virtio0",
> > +#                         "command": "read 0 512" } }
> > +#     <- { "return": {} }
> > +##
> > +{ 'command': 'x-qemu-io',
> > +  'data': { '*device': 'str',
> > +            '*qdev': 'str',
> > +            'command': 'str' },
> > +  'features': [ 'unstable' ],
> > +  'allow-preconfig': true }
>
> 'qemu-io' HMP command was a bad name decision. This is a good
> opportunity to clean it: can we add QMP 'x-block-io' or
> 'x-block-cmd' / 'x-block-command' instead? Keeping the legacy
> HMP name (or adding an HMP alias)?

Given that it is a x- command, if you don't mind, we can easily decide
and switch after this series.


