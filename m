Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F2FE87822
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 12:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnFzs-00088G-Uc; Tue, 03 Feb 2026 07:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vnFzT-0007sZ-AW
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:58:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vnFzR-0004dd-93
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770123522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z9XAVErHudAdtUVaCD/df3evUo4dj686bpaSW7Nz3UA=;
 b=XxmZeeGRzRIplbg/CQI4UQFb6XRY19CE5DF4qejNJEC3KncuAEc25HEbQnMLcnbrKhpVTA
 3nWRsk6x/sAhwYBdpgIen57Ejoz6FuTSUMVpu2wqxjSw6fK4dYdOQYBa4A2I1PxDLzVUEX
 k3kifWnkZj2vMj3XodRAzmsqdHOASJw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-mTzu2fFCO2ShkkdYHHTCBQ-1; Tue, 03 Feb 2026 07:58:41 -0500
X-MC-Unique: mTzu2fFCO2ShkkdYHHTCBQ-1
X-Mimecast-MFC-AGG-ID: mTzu2fFCO2ShkkdYHHTCBQ_1770123521
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8c6b315185aso1254544785a.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 04:58:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770123521; cv=none;
 d=google.com; s=arc-20240605;
 b=AgnYGhHxwk+rD3Lrc4ilXpk4nUtTWgk/t1FLq/1raTsTqUq1G93owbwSjrHc6yue7f
 zTUddZQtv5kbwnOuJPpVC24rhnGKXeBtupf4138CppS8xbgNE3DlBoJ5h+pY9db94RD1
 a59LbrjVM3VYXv0gIwhIViLjsFbrfcHAcOJvWgcuLgb171o/8jFXkH9+MxnaHM+A5uvz
 wWZmNFFWQy2gkqdt4uTXDygZl2bebW6pBiMmbP76Mq4faybyb7QaD9sFyaxhELMs7Fyf
 KgfLuOCy8uOe3b+iEE5LQyuUyI8OaMhz0pXT2oevN2eRxkJBfgm83qcL5iIelPBuMXdc
 HHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=z9XAVErHudAdtUVaCD/df3evUo4dj686bpaSW7Nz3UA=;
 fh=tFbbyy6nTJWdhprEeRxjudxVDVBD2UID5FeaHQZqhG4=;
 b=kQZDhuDWZPgFuSBsa7vZ4frn3n53O1/W9uFJGWcnA1/esgzIrwu8cXWnE/4rjAsQgJ
 56Cv5FFxr4iPomguEyH2XawHkoeNKWPD7vdXcWRvOAwnvWc60MiXtJnAcpy4c5xOmaCC
 jHYHAdGW43J+72gE/J5B3UexVlg2FsXy7n75NntBM2K1NNfyoImOM1pAzCfXX8TKd2jB
 AhXlUTmCKvDNC9N8t71qrsIQjf/xDU2H/7F3+dhs55uGdkcUFOA5Au2F5wPdtaMYVnl2
 hafApmD2UnEvX3O789alDv/DTZ8IYJK8tTsjxFsZReHdLllE5dFBvIy39Q4KHmPlD1sH
 W+dQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770123521; x=1770728321; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z9XAVErHudAdtUVaCD/df3evUo4dj686bpaSW7Nz3UA=;
 b=R/Q69dSfS7TC0Ilap+8HswHTltGXNt95GFhwDotv5lnMtw5TNjtc946eQe+2PHMD5A
 SdKLDa/WuBEejCOyhdTBbw3jkQirxlMxumsZqKL/LSqluqco5uRJo8NncWB6/v/zyqXW
 2r0rcpmyAqp2Lq0mkE0cLbsLL70Wq1A/Dnfsc9AO2MxxhVqPPV/OwS5ap3srCQ4QPFpO
 jhb+qf9eiQG6+WjRkl+ILCGxmZKSHWCgnAcBQZdRy7OdDz8KXrh7bvXXMnAdA88uLLbn
 XIetQNUFGGc4l3h3+vwiLW2PHOpGEfenVElAws8HwsZoq8GcttRghlE3JwGwGKqwtYIa
 5vpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770123521; x=1770728321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z9XAVErHudAdtUVaCD/df3evUo4dj686bpaSW7Nz3UA=;
 b=eOQf5FJ7zQxleU1k8yD6LZN46q6WXLN/bLQpG+3poIQHKcx4f88OnYt6FFaYeezaiB
 nOdvhgTtamisXMcPMn5u6Kt7Uo2Po/Ri1pmpFBOKpR3XauwMc4UpDPj+hrmhJ6xi58Il
 QgwDrfHKDjioveevqZTq5JnLOkXNZQxPeSyXaF6ReDgoUsdZs2hqI+l5fHykd8o0V4E5
 JbkVL8FRdZ8iLKlmRqKh7fd7nHjWkLfOtYAaapH4mu8Z35QvkCo1lMyFvn+JE7mAKMDy
 rldZbQCEDkJ8K6IbqKpWkx1ODBY/QvoRrwagMJ0Ll/QJ0CvgI6RqtWYKxu+Fd6ydzxRK
 49IA==
X-Gm-Message-State: AOJu0YwuZIQrUIbWEC9KXf9/wh8aJIx2BM6b0EaAHFT8JoYp2CEAkZvY
 vIFnvZh1fY3W4ghhK5Y3FDQ3QzAJh1ZLcV4BWVL8RXUNucFjyR4cOXz+s0rOq+VPF3hTFBCzUwr
 K4FDs0M/l1CFqkWK1K16SQIm75UXR/rj0OwO3SByHPAlcgDqAdJl3pohVy1cc/IZlY8eRRqyME0
 Ml4ac6Wwzc8Et/BF0xeXufgsKq5LVMGIs=
X-Gm-Gg: AZuq6aKPiZjcE/dhhiqG/lCq6upRl1VLarlBmZM/0Q3Ldb4vCehrTLSkm+3aOZwm+pE
 RZSsPNFBsqiSyT4E7zMk2eO4w0tiJZH6047whguaag/wpO/2BdDuOzWrvjDR6Fldz9IiN3L9srD
 ipTJc5GtIDffGLgNWBc7A7GqCR7iz5g020TogLlVFwzwvz1J8+8NfIKfPVe5HmZIr77Kcj
X-Received: by 2002:a05:620a:29cc:b0:8c7:1ade:29a8 with SMTP id
 af79cd13be357-8c9eb266987mr1755477485a.23.1770123520807; 
 Tue, 03 Feb 2026 04:58:40 -0800 (PST)
X-Received: by 2002:a05:620a:29cc:b0:8c7:1ade:29a8 with SMTP id
 af79cd13be357-8c9eb266987mr1755475985a.23.1770123520415; Tue, 03 Feb 2026
 04:58:40 -0800 (PST)
MIME-Version: 1.0
References: <CANc8XmBVnkbrsJ+DMKXA7HhepStAPHRpXOH8fB16e=bghPOsqQ@mail.gmail.com>
In-Reply-To: <CANc8XmBVnkbrsJ+DMKXA7HhepStAPHRpXOH8fB16e=bghPOsqQ@mail.gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 3 Feb 2026 14:58:29 +0200
X-Gm-Features: AZwV_QjqGUloTo03xmyr7ohCBrmD8SE-La_U52CSA7aZTOfpy0WSQGclEtjpil8
Message-ID: <CAPMcbCq2oOYXo=O0D0fdBSG-vB7+q1=VtEqQpHqSzFU6+5Sq9g@mail.gmail.com>
Subject: Re: QGA fsfreeze blocks QMP: need async fsfreeze or alternative?
To: Noam Assouline <nassouli@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, 
 Qianqian Zhu <qizhu@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a4b2680649eaff6c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000a4b2680649eaff6c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Noam

QEMU agent was developed as a tool with a synchronous API, and adding any
async commands requires a redesign of the API. QGA also does not support
sending any event to the host.

First of all, if you send 2 asing command "file-open-async" and get 2
responses with FD, how can you know which FD is for which file? Yes, asked
about FS freeze API, but the idea is the same. FS-freeze allow to provide a
list of volumes to freeze, so you can have 2 requests to freeze 2 sets of
volumes. And get the same question.

Regarding multiple agents, this is theoretically possible because QGA is an
independent application. If you run each QGA instance with a proper
different state folder and a different communication channel, it should
work. The main problem is that QGA instances will be independant and when
QGA1 blocks all API execution because the guest has frozen FS, QGA2 will
allow any command, including FS freeze.

Unfortunately, I have no good answer for you. Windows VSS has a lot of
limitations, and we are trying to somehow work with it. Windows VSS doesn't
even have an API to report a FS state, so QGA builds and uses internal
knowledge that will be out of sync after snapshot restoring.

CC: @Yan Vugenfirer <yvugenfi@redhat.com> @Qianqian Zhu <qizhu@redhat.com> =
Do
you have any idea?

Best Regards,
Kostiantyn Kostiuk.


On Tue, Feb 3, 2026 at 12:23=E2=80=AFPM Noam Assouline <nassouli@redhat.com=
> wrote:

> Hello qemu-devel!
>
> I=E2=80=99m working on a KubeVirt fix for Windows VSS fsfreeze timeouts (=
PR #16653
> <https://github.com/kubevirt/kubevirt/pull/16653>). Up to now we=E2=80=99=
ve
> relied on libvirt=E2=80=99s default QEMU agent response timeout of 5 seco=
nds, and
> that often isn=E2=80=99t enough for VSS fsfreeze to complete. This PR pro=
poses
> increasing the timeout to 60 seconds so the freeze can finish successfull=
y.
>
> The challenge and the reason for this email is that qemu-ga processes
> commands synchronously on a single connection. While guest-fsfreeze-freez=
e
> is running, the agent is effectively busy and other commands (e.g. ping,
> status) will hang until it returns, which can impact pod readiness probes=
.
> I=E2=80=99m checking what we can do about this.
>
> I=E2=80=99m mainly looking to understand whether this can be addressed in=
 qemu-ga,
> and to get guidance on the right direction. Is there a supported way to u=
se
> multiple agent connections/channels, or is an async guest-fsfreeze-freeze
> with a completion event the more appropriate solution? More generally, an=
y
> best=E2=80=91practice guidance around Windows fsfreeze timeouts and respo=
nsiveness
> would be very helpful!
>
> Thanks in advance, and cc=E2=80=99ing qemu-ga maintainers.
>
> Noam
> KubeVirt Storage Ecosystem team
>

--000000000000a4b2680649eaff6c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Noam=C2=A0<br><br>QEMU agent was developed as a to=
ol with a synchronous API, and adding any async commands requires a redesig=
n of the API. QGA also does not support sending any event to the host.<br><=
br>First of all, if you send 2 asing command &quot;file-open-async&quot; an=
d get 2 responses with FD, how can you know which FD is for which file? Yes=
, asked about FS freeze API, but the idea is the same. FS-freeze allow to p=
rovide a list of volumes to freeze, so you can have 2 requests to freeze 2 =
sets of volumes. And get the same question.<br><br>Regarding multiple agent=
s, this is theoretically possible because QGA is an independent application=
. If you run each QGA instance with a proper different state folder and a d=
ifferent communication channel, it should work. The main problem is that QG=
A instances will be independant and when QGA1 blocks all API execution beca=
use the guest has frozen FS, QGA2 will allow any command, including FS free=
ze. <br><br>Unfortunately, I have no good answer for you. Windows VSS has a=
 lot of limitations, and we are trying to somehow work with it. Windows VSS=
 doesn&#39;t even have an API to report a FS state, so QGA builds and uses =
internal knowledge that will be out of sync after snapshot restoring. <br><=
br>CC:=C2=A0<a class=3D"gmail_plusreply" id=3D"plusReplyChip-0" href=3D"mai=
lto:yvugenfi@redhat.com" tabindex=3D"-1">@Yan Vugenfirer</a>=C2=A0<a class=
=3D"gmail_plusreply" id=3D"plusReplyChip-1" href=3D"mailto:qizhu@redhat.com=
" tabindex=3D"-1">@Qianqian Zhu</a>=C2=A0Do you have any idea?</div><div><b=
r></div><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"g=
mail_signature"><div dir=3D"ltr"><div>Best Regards,</div><div>Kostiantyn Ko=
stiuk.</div></div></div></div><br></div><br><div class=3D"gmail_quote gmail=
_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 3, 2026=
 at 12:23=E2=80=AFPM Noam Assouline &lt;<a href=3D"mailto:nassouli@redhat.c=
om">nassouli@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><div dir=3D"ltr">Hello qemu-devel!<br><br>I=E2=80=99=
m working on a KubeVirt fix for Windows VSS fsfreeze timeouts (<a href=3D"h=
ttps://github.com/kubevirt/kubevirt/pull/16653" target=3D"_blank">PR #16653=
</a>). Up to now we=E2=80=99ve relied on libvirt=E2=80=99s default QEMU age=
nt response timeout of 5 seconds, and that often isn=E2=80=99t enough for V=
SS fsfreeze to complete. This PR proposes increasing the timeout to 60 seco=
nds so the freeze can finish successfully.<br><br>The challenge and the rea=
son for this email is that qemu-ga processes commands synchronously on a si=
ngle connection. While guest-fsfreeze-freeze is running, the agent is effec=
tively busy and other commands (e.g. ping, status) will hang until it retur=
ns, which can impact pod readiness probes. I=E2=80=99m checking what we can=
 do about this.<br><br>I=E2=80=99m mainly looking to understand whether thi=
s can be addressed in qemu-ga, and to get guidance on the right direction. =
Is there a supported way to use multiple agent connections/channels, or is =
an async guest-fsfreeze-freeze with a completion event the more appropriate=
 solution? More generally, any best=E2=80=91practice guidance around Window=
s fsfreeze timeouts and responsiveness would be very helpful!<br><br>Thanks=
 in advance, and cc=E2=80=99ing qemu-ga maintainers.<br><br>Noam<br>KubeVir=
t Storage Ecosystem team</div>
</blockquote></div>

--000000000000a4b2680649eaff6c--


