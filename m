Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E786EFEA82F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 07:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5ItZ-0003LZ-Dh; Wed, 25 Mar 2026 03:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w5ItX-0003LL-IJ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 03:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w5ItV-0007i0-9k
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 03:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774424592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9cFcKqzUReN2Kb59QJDJyaHQhrpjICdAyYiji/oVqSc=;
 b=Lf9jMhStX8Xxyzh1DyH95eyXE51lXuWSlhgouw73PhpQ7Xl+H92OQZToDaYvwuxDoXt3rD
 3tLPvCjcQ0cFBzmFy+aWXCBeI8WbYO3uASuH+cc1i+5ggklpUUgJuShDTkzgQVUwmw6kf8
 PZUsnaDI6T5McxtZu6/e5bJZL4BWOSQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-RsSa1PjLM-uSChTQ0V-JRA-1; Wed, 25 Mar 2026 03:43:10 -0400
X-MC-Unique: RsSa1PjLM-uSChTQ0V-JRA-1
X-Mimecast-MFC-AGG-ID: RsSa1PjLM-uSChTQ0V-JRA_1774424590
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89cc5305180so35147056d6.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 00:43:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774424589; cv=none;
 d=google.com; s=arc-20240605;
 b=eptIF2WDy/0Mm12NMyxSc/kulQaredtxZdT3bUuVXzE2Z1GFlyGVMNjTAr4lr6Ltqz
 s2ZY1ielq3LAP45HAc7Zo5RFqD5S6uT1jAsXrzoNqQH8XSWHLAK+oAU2IbKT73OXvqx8
 XHczY/Pjo/yyXblqw4Z5nDe/mj6OvQ+gTmLDQPsHHGYeemYEsWVLCIMda/m+HGrKvfTT
 bRTF1dY2SIqA995G/EvWBBQCg8qDI+mTieGT1lIGM97STdtIznp/5EdLRWEv3xf9Mhuc
 89asyERRnYI5pfKGrfJTnmo/r35raaU/Dt9m6uOHk4Kuaw4lQjLj6lPYsGGt8vsjqfxv
 QrNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9cFcKqzUReN2Kb59QJDJyaHQhrpjICdAyYiji/oVqSc=;
 fh=paY6DLCz1Xl/OSo6ZOZWU9H/qfLs/so0o6ytPY632Xs=;
 b=BOFgwRA6h9UDrbqgeblOVIidymTTXo4YvPzzVMSBfHQLrO+aj5c3+dO7Eo7uXzfS7j
 vmZUA4TA6PPvBnz8mvYaeoLlAURqVMGkZFGmfQnfgmYIR2EIZh9jHs/LJK4atW/00MIf
 NKABg9UVsgTlbV2GBQrQb4tPjcXNdUP9gGv+FERsVl2SbH+0VUM2Wetu95fQynSLt5WA
 frmXi4UH1hKiPZ0PsFBdWU0XwZApkOresCdsoHOsYT/qWOe8/iGmwtAF/P3khvqMvkpy
 yv9O6MqX/BGNdpTzO/11DUcKvot2t3UsfL3Wnx4E8q1mXKIwEYEk/kNb+fxCdjt8mU06
 35Zg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774424589; x=1775029389; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9cFcKqzUReN2Kb59QJDJyaHQhrpjICdAyYiji/oVqSc=;
 b=SxNSIgIMlL77OmjF5lUG/P/ju/EWAqNR+xpJfSm1LzUhDcLOXY8/4WEX7cEI+cc386
 vhxRznTznkfAeuD+WMdOUNwWgHRiLdw4PKbBnOAo+0hVp68LCuh1m1okO1Bl48JXVaGO
 e5wRmxbZDt5H5Ew09shW5X/q1I9qBkS5Pw9usCo3W1GGhaPmWZF7Em2aP1IrJcKVwwb+
 sJ3/YkMBykCNYcXnAs9jFeXlFVRQ1QpJkqXvVAlHMu8+sBjfkmrSbMQgOQR089irh0uN
 xjzXBoooiyt3v06AY1VA4MaPgJn5aoK+G4142rR4OwqJYM+bcX7n/H51l+GahAedEpL/
 qcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774424589; x=1775029389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9cFcKqzUReN2Kb59QJDJyaHQhrpjICdAyYiji/oVqSc=;
 b=RGBd4SuoaIb40cgpI6Tqr5c0rKKsvvfAkpWpPl5j1ofmFzLSHkRn8OUFzojVA2PlDo
 1+DScIAsI6YsfmXCgXU+d7rFBJEIcv0eA4jplbmLFMgP8KGUhb+efLRBcmxvCFxo/+ox
 BCvGkMDVVgIT5FFbjZykOB/BWpnMIlC2axnKhAuHGst/URuOUIU2VnH2GzBVYfTVi8Lh
 fBSf4YfxYnDAwS5j/cDjGrkaGNAbd58b4NkRF4S+HhJiqjDPemV0CCt0cah1cZAHegAL
 jyQIehZPW0HdEnsbp71ibOIPOSfnoTPCtk2AnOCfqvhfw0JxQ/DRiBcfu84Y7ho0xzAZ
 jyow==
X-Gm-Message-State: AOJu0YwSMnWTWvCc1qqaPxiNtP4Eca8bwgJPlUjilE4uh1BZOiBu01xv
 TF1QjxfrdPsHssYFjh6RwDDXhh+B+IfYlZLOndmZvoMetzJwg4Z9l3TET1AdmbbnUkqYRlxMsFp
 OJpdjl6lc6TuoObMidUSEtYZOyiHW5ujCu/Fb5/BUMIhq+fRvQfKBPQt4cLAcCsvf1fuZvZ42sO
 /osWfQcEevKuem7O2Y0NQk14+KBn8uHYI=
X-Gm-Gg: ATEYQzxyxK6dytt2i5QusU3+/R+1NOsiFiNpPaGkOgMIsPKXjtXP/mdvWV68eWqny7h
 zUy1fKLEAPfAnPY8N1kr2vi7VGbaBcuLdPSNscjgV1Sh5lNh6prHwK5NfBw0EFD3Lj3MwiDBxiW
 wG12pxFSDu9629SJDcaYjeipllv90idVAsHUMAiay8VoXuNfc+pE4Qb1SHLOB4PSLMPsmpFPniM
 28IFq2c
X-Received: by 2002:a05:6214:5f0b:b0:89a:116b:e67c with SMTP id
 6a1803df08f44-89cc4abf04dmr41789036d6.45.1774424589602; 
 Wed, 25 Mar 2026 00:43:09 -0700 (PDT)
X-Received: by 2002:a05:6214:5f0b:b0:89a:116b:e67c with SMTP id
 6a1803df08f44-89cc4abf04dmr41788786d6.45.1774424589132; Wed, 25 Mar 2026
 00:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com>
In-Reply-To: <CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Wed, 25 Mar 2026 09:42:58 +0200
X-Gm-Features: AQROBzAKK3GaJNC9kD07QMq8_6w6Fz7YLwXkIqHsWYtFvbxPSo81PpweMcstRDs
Message-ID: <CAPMcbCoT+HT14GQrCPjNpfivSM+o8oHF0h7mjGPWMYfnVdfbCA@mail.gmail.com>
Subject: Re: Cleaning up contrib/ and tools/
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000050f70c064dd46b43"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000050f70c064dd46b43
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 7:09=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> We have a couple of directories in our source tree which have
> accumulated things in them that don't really belong there; this is a
> proposal to clean up by moving things to more appropriate locations
> (as 11.1 work, obviously).
>
> Firstly, contrib/ has a tendency to be a dumping ground for stuff that
> we didn't think hard enough about finding a good home for, and for
> things in a weird "not really maintained" state. We should either
> (a) care enough about something to give it a correct home and to
> maintain it, or (b) not care about it, and kick it out of our tree.
>
> Secondly, tools/ exists but is very under-used. I think it should be
> for the set of standalone tools that we build if you configure
> --enable-tools and which we document in docs/tools.  Currently it
> contains two things, one of which doesn't match that idea...
>
> So, starting with tools/:
>
>  * tools/ebpf/ is the source for the pre-generated
>    ebpf/rss.bpf.skeleton.h ; it should move to ebpf/
>  * tools/i386/qemu-vmsr-helper.c is the source for the
>    qemu-vmsr-helper tool; it can stay (should it lose its
>    i386/ subdir ?)
>  * the tools which currently are in the top level directory
>    should move into tools/:
>     - qemu-bridge-helper.c
>     - qemu-edid.c
>     - qemu-img.c
>     - qemu-io.c
>     - qemu-keymap.c
>     - qemu-nbd.c
>
> And for contrib/, easy ones first:
>  * contrib/vhost-user-{blk,bridge,gpu,input,scsi} move to tools/
>  * contrib/elf2dmp moves to tools/
>  * contrib/ivshmem-client and contrib/ivshmem-server move to tools/
>  * contrib/plugins moves to plugins/plugins (or a different subdir
>    name of your choice)
>
> For contrib/, ones I'm less sure about:
>
>  * contrib/vmapple/uuid.sh is a one-liner; we should either commit to
>    having this, by giving it a better name and documentation and
>    installing it in 'make install', or else junk it and have
>    docs/system/arm/vmapple.rst give you the plutil command and tell
>    you to run it directly.
>  * contrib/gitdm moves to scripts/ ? It's just config data for
>    generating statistics about patches, so with other
>    developer-related stuff makes sense.
>  * contrib/systemd -- we don't do anything with these (e.g.
>    'make install' ignores them), so I am sceptical about their
>    usefulness. We could drop them, or move them to scripts/, or put
>    them in tools/ and qga/ with the tools that they are systemd
>    scripts for.
>

Not sure that we need qemu-guest-agent.service at all. Fedora/CentOS don't
use it and create a different service file.
I think this one can be dropped.

Best Regards,
Kostiantyn Kostiuk.



>
> Then we can delete contrib/ entirely.
>
> (scripts/ is also in danger of being "miscellaneous dumping
> ground", of course. I have tried not to suggest it as the
> destination when I could think of an alternative.)
>
> -- PMM
>
>

--00000000000050f70c064dd46b43
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 24,=
 2026 at 7:09=E2=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@=
linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">We have a couple of directories in our =
source tree which have<br>
accumulated things in them that don&#39;t really belong there; this is a<br=
>
proposal to clean up by moving things to more appropriate locations<br>
(as 11.1 work, obviously).<br>
<br>
Firstly, contrib/ has a tendency to be a dumping ground for stuff that<br>
we didn&#39;t think hard enough about finding a good home for, and for<br>
things in a weird &quot;not really maintained&quot; state. We should either=
<br>
(a) care enough about something to give it a correct home and to<br>
maintain it, or (b) not care about it, and kick it out of our tree.<br>
<br>
Secondly, tools/ exists but is very under-used. I think it should be<br>
for the set of standalone tools that we build if you configure<br>
--enable-tools and which we document in docs/tools.=C2=A0 Currently it<br>
contains two things, one of which doesn&#39;t match that idea...<br>
<br>
So, starting with tools/:<br>
<br>
=C2=A0* tools/ebpf/ is the source for the pre-generated<br>
=C2=A0 =C2=A0ebpf/rss.bpf.skeleton.h ; it should move to ebpf/<br>
=C2=A0* tools/i386/qemu-vmsr-helper.c is the source for the<br>
=C2=A0 =C2=A0qemu-vmsr-helper tool; it can stay (should it lose its<br>
=C2=A0 =C2=A0i386/ subdir ?)<br>
=C2=A0* the tools which currently are in the top level directory<br>
=C2=A0 =C2=A0should move into tools/:<br>
=C2=A0 =C2=A0 - qemu-bridge-helper.c<br>
=C2=A0 =C2=A0 - qemu-edid.c<br>
=C2=A0 =C2=A0 - qemu-img.c<br>
=C2=A0 =C2=A0 - qemu-io.c<br>
=C2=A0 =C2=A0 - qemu-keymap.c<br>
=C2=A0 =C2=A0 - qemu-nbd.c<br>
<br>
And for contrib/, easy ones first:<br>
=C2=A0* contrib/vhost-user-{blk,bridge,gpu,input,scsi} move to tools/<br>
=C2=A0* contrib/elf2dmp moves to tools/<br>
=C2=A0* contrib/ivshmem-client and contrib/ivshmem-server move to tools/<br=
>
=C2=A0* contrib/plugins moves to plugins/plugins (or a different subdir<br>
=C2=A0 =C2=A0name of your choice)<br>
<br>
For contrib/, ones I&#39;m less sure about:<br>
<br>
=C2=A0* contrib/vmapple/uuid.sh is a one-liner; we should either commit to<=
br>
=C2=A0 =C2=A0having this, by giving it a better name and documentation and<=
br>
=C2=A0 =C2=A0installing it in &#39;make install&#39;, or else junk it and h=
ave<br>
=C2=A0 =C2=A0docs/system/arm/vmapple.rst give you the plutil command and te=
ll<br>
=C2=A0 =C2=A0you to run it directly.<br>
=C2=A0* contrib/gitdm moves to scripts/ ? It&#39;s just config data for<br>
=C2=A0 =C2=A0generating statistics about patches, so with other<br>
=C2=A0 =C2=A0developer-related stuff makes sense.<br>
=C2=A0* contrib/systemd -- we don&#39;t do anything with these (e.g.<br>
=C2=A0 =C2=A0&#39;make install&#39; ignores them), so I am sceptical about =
their<br>
=C2=A0 =C2=A0usefulness. We could drop them, or move them to scripts/, or p=
ut<br>
=C2=A0 =C2=A0them in tools/ and qga/ with the tools that they are systemd<b=
r>
=C2=A0 =C2=A0scripts for.<br></blockquote><div><br></div><div>Not sure that=
 we need=C2=A0qemu-guest-agent.service at all. Fedora/CentOS don&#39;t use =
it and create a different service file.</div><div>I think this one can be d=
ropped.<br><div><br clear=3D"all"></div><div><div dir=3D"ltr" class=3D"gmai=
l_signature"><div dir=3D"ltr"><div>Best Regards,</div><div>Kostiantyn Kosti=
uk.</div></div></div></div><br></div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
<br>
Then we can delete contrib/ entirely.<br>
<br>
(scripts/ is also in danger of being &quot;miscellaneous dumping<br>
ground&quot;, of course. I have tried not to suggest it as the<br>
destination when I could think of an alternative.)<br>
<br>
-- PMM<br>
<br>
</blockquote></div></div>

--00000000000050f70c064dd46b43--


