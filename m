Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE55D43341
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 20:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTn5D-0008TT-I1; Thu, 11 Dec 2025 15:16:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaronlo0929@gmail.com>)
 id 1vTn5B-0008SO-R2
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 15:16:13 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aaronlo0929@gmail.com>)
 id 1vTn58-0003cU-L9
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 15:16:13 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-78c33d0df85so7968317b3.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 12:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765484169; x=1766088969; darn=nongnu.org;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=l8sNp1FbO22fEu4IpnSJlPcqXCSY+sOrWvZTo75PDcs=;
 b=eCUNxQYPmnfUbuZ3ma00X74tjCYkcqFMrY9YGLssI8ISFa6fRv+jEPsS9UOuyFsjC9
 4uKxeu6xS4K3hyfWpxwl9FZKqyPABzwrNiOPkvDwpQoEH/kMemwI/Z5vXvA88H2olVbm
 youYeOgYjzDQQSbT67ftt7lrOmVomWE6N5+tLSVv8F9UuGWbM+SlpRrG47CbtrA0+o54
 aLPYSmoVwarRTcddY2gG/871EA0mPImSz7Go3TzM/GrKkuNuiw9udVhVVU0jy7PYq61I
 lY77kk58vTcuAk0USGfviqbbWfHzg90mye3gBYdioBcYjod8KCodEqlUP/5HfYrAwID8
 yjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765484169; x=1766088969;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l8sNp1FbO22fEu4IpnSJlPcqXCSY+sOrWvZTo75PDcs=;
 b=uV2vfqirh10OZp99CjPCbODAMeHLF62u0Yd+V5m7kIwB0UncTAhO3lPJ4NqFVkOCy2
 iw6w7B4pLpMVN4PtiCY4JCgMtFJyP5829sFEEyEBLFWwuNg5HYaMaYPxKGQ/MRjKA22d
 Ey78P+IaIDOjtFPJKj6nN00OnOdyTKljXBO3bD7aeFU9vEy1Dx6hrnnpY1MArfqe86Md
 j7E4Z1fUbbw3djCb0U1/6cJmgXHMiYwJi7GvOFoA0geFk/wJVpy9H30L/MZnj1vNKPqg
 kbBkTqTGNhVzjsaw6gk++KM39c4hAT0sKjvrkF34jAo1ttKSDYYp096pp4FaYjl1JbMD
 sAyg==
X-Gm-Message-State: AOJu0YzDAfrVS6NUPiariwuyZfSKW70MprpcY9vZQRvEu+Svsmno4nxb
 YKXck4Q7Hc4+TFhgYzIpSgvT/ZaTZtJdK/BVTMsDrX9pleWSmb13mgJm
X-Gm-Gg: AY/fxX6hBZw7L4TRHP0Ltmv5B7a7i0rfEG8rdM5bzcJf4v5HbEqlyo8Kq9rc+gCL40z
 IKrIJEg6KoEyuIwH7rWydvX+7LC7R5xMdc+ep8eSHo771UhK9oMfLLfNZLwjvTRMWOP8+/J8X2J
 LVtxGo366Y9aLpMxYoh4PFliNuji6uKZJbbo5+m9srn+BVDndotRInqSWOkwZyPLtCHUNM+i1Br
 6zmnXrKcxF7powz2M2+e1S/3pKrnHh/1Dt5EPlmtkKykJTnCfULnv3xchkjti/vbc50O55E9RQQ
 z/mof0PcV8KHi1tQutMqaQ3pGWUxiJHZD18DD1MRICcPkkltlEapWLDYbjdO5u9DWVVIzw7XUaT
 XUtgXQd91Zrbz0zgeiiPadW29LPBuXB7VxHwn/1tlWoA4qjrH/z3bSZBXruC/6kB9vRADbqCyIR
 pCPirlkQN1n3AUeHshkSeSnvraKpUxIvmoSA==
X-Google-Smtp-Source: AGHT+IGq0Hgngas8XXauSHnS5b7HI7q3N9zpDPjzvCYBiAhn7BL+U4c9+ARj7m/1Ob3XxC57MgWtWQ==
X-Received: by 2002:a05:690e:13ca:b0:63f:b18a:7812 with SMTP id
 956f58d0204a3-6446e957639mr5716193d50.40.1765484169460; 
 Thu, 11 Dec 2025 12:16:09 -0800 (PST)
Received: from smtpclient.apple ([66.112.242.31])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-64477db607esm1550834d50.18.2025.12.11.12.16.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Dec 2025 12:16:09 -0800 (PST)
From: Aaron Lo <aaronlo0929@gmail.com>
Message-Id: <E383EEBC-073E-4C5B-B793-E9ADD17EFBD2@gmail.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_304AF4BB-51FF-4C08-8D0E-738206348A5D"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH] virtio-balloon: only create statsq when
 VIRTIO_BALLOON_F_STATS_VQ exists
Date: Thu, 11 Dec 2025 14:15:58 -0600
In-Reply-To: <aTrTsbhiyKjspttD@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, qemu-trivial@nongnu.org
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
References: <20251211-balloon-check-stats-feature-v1-1-ae8951957b80@gmail.com>
 <aTrTsbhiyKjspttD@redhat.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=aaronlo0929@gmail.com; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--Apple-Mail=_304AF4BB-51FF-4C08-8D0E-738206348A5D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Daniel and Michael,

Thanks for the quick feedback.

Given the migration concerns and issues with the spec itself, I think =
it=E2=80=99ll be best to drop the code changes for now.

Thanks again for the guidance,
Aaron

> On Dec 11, 2025, at 8:22=E2=80=AFAM, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
> On Thu, Dec 11, 2025 at 03:05:49AM -0600, Aaron Lo wrote:
>> The VirtIO specification (section 5.5.2) states that the stats queue
>> is only present if the VIRTIO_BALLOON_F_STATS_VQ feature is
>> negotiated. QEMU currently creates the statsq unconditionally.
>>=20
>> This patch guards statsq creation so it occurs only when the
>> feature bit is enabled.
>>=20
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3188
>>=20
>> Signed-off-by: Aaron Lo <aaronlo0929@gmail.com>
>> ---
>> hw/virtio/virtio-balloon.c | 9 +++++++--
>> 1 file changed, 7 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>> index 02cdd807d7..f5d4d5f60c 100644
>> --- a/hw/virtio/virtio-balloon.c
>> +++ b/hw/virtio/virtio-balloon.c
>> @@ -892,7 +892,10 @@ static void =
virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>>=20
>>     s->ivq =3D virtio_add_queue(vdev, 128, =
virtio_balloon_handle_output);
>>     s->dvq =3D virtio_add_queue(vdev, 128, =
virtio_balloon_handle_output);
>> -    s->svq =3D virtio_add_queue(vdev, 128, =
virtio_balloon_receive_stats);
>> +
>> +    if (virtio_has_feature(s->host_features, =
VIRTIO_BALLOON_F_STATS_VQ)) {
>> +        s->svq =3D virtio_add_queue(vdev, 128, =
virtio_balloon_receive_stats);
>> +    }
>=20
> This seems like a change that is liable to break live migration
> state compatibility, as IIUC the queues are encoded in the state ?
>=20
>>=20
>>     if (virtio_has_feature(s->host_features, =
VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>>         s->free_page_vq =3D virtio_add_queue(vdev, =
VIRTQUEUE_MAX_SIZE,
>> @@ -932,7 +935,9 @@ static void =
virtio_balloon_device_unrealize(DeviceState *dev)
>>=20
>>     virtio_delete_queue(s->ivq);
>>     virtio_delete_queue(s->dvq);
>> -    virtio_delete_queue(s->svq);
>> +    if (s->svq) {
>> +        virtio_delete_queue(s->svq);
>> +    }
>>     if (s->free_page_vq) {
>>         virtio_delete_queue(s->free_page_vq);
>>     }
>>=20
>> ---
>> base-commit: 9c23f2a7b0b45277693a14074b1aaa827eecdb92
>> change-id: 20251211-balloon-check-stats-feature-7ea658e038ce
>>=20
>> Best regards,
>> --=20
>> Aaron Lo <aaronlo0929@gmail.com>
>>=20
>>=20
>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com <https://berrange.com/>      -o-    =
https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org <https://libvirt.org/>         -o-            =
https://fstop138.berrange.com <https://fstop138.berrange.com/> :|
> |: https://entangle-photo.org <https://entangle-photo.org/>    -o-    =
https://www.instagram.com/dberrange :|


--Apple-Mail=_304AF4BB-51FF-4C08-8D0E-738206348A5D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;">Hi Daniel and =
Michael,<div><br></div><div>Thanks for the quick =
feedback.</div><div><br></div><div>Given the migration concerns and =
issues with the spec itself, I think it=E2=80=99ll be best to drop the =
code changes for now.</div><div><br></div><div>Thanks again for the =
guidance,</div><div>Aaron<br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On Dec 11, 2025, at 8:22=E2=80=AFAM, Daniel P. =
Berrang=C3=A9 &lt;berrange@redhat.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">On Thu, Dec 11, 2025 at 03:05:49AM -0600, =
Aaron Lo wrote:</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><blockquote type=3D"cite" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">The VirtIO specification (section 5.5.2) states =
that the stats queue<br>is only present if the VIRTIO_BALLOON_F_STATS_VQ =
feature is<br>negotiated. QEMU currently creates the statsq =
unconditionally.<br><br>This patch guards statsq creation so it occurs =
only when the<br>feature bit is enabled.<br><br>Resolves: =
https://gitlab.com/qemu-project/qemu/-/issues/3188<br><br>Signed-off-by: =
Aaron Lo =
&lt;aaronlo0929@gmail.com&gt;<br>---<br>hw/virtio/virtio-balloon.c | 9 =
+++++++--<br>1 file changed, 7 insertions(+), 2 deletions(-)<br><br>diff =
--git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c<br>index =
02cdd807d7..f5d4d5f60c 100644<br>--- a/hw/virtio/virtio-balloon.c<br>+++ =
b/hw/virtio/virtio-balloon.c<br>@@ -892,7 +892,10 @@ static void =
virtio_balloon_device_realize(DeviceState *dev, Error =
**errp)<br><br>&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;ivq =3D =
virtio_add_queue(vdev, 128, =
virtio_balloon_handle_output);<br>&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;dvq =3D =
virtio_add_queue(vdev, 128, virtio_balloon_handle_output);<br>- =
&nbsp;&nbsp;&nbsp;s-&gt;svq =3D virtio_add_queue(vdev, 128, =
virtio_balloon_receive_stats);<br>+<br>+ &nbsp;&nbsp;&nbsp;if =
(virtio_has_feature(s-&gt;host_features, VIRTIO_BALLOON_F_STATS_VQ)) =
{<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;svq =3D =
virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);<br>+ =
&nbsp;&nbsp;&nbsp;}<br></blockquote><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">This =
seems like a change that is liable to break live migration</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">state compatibility, as IIUC the queues are =
encoded in the state ?</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><blockquote type=3D"cite" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><br>&nbsp;&nbsp;&nbsp;&nbsp;if =
(virtio_has_feature(s-&gt;host_features, =
VIRTIO_BALLOON_F_FREE_PAGE_HINT)) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;free_page_vq =
=3D virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,<br>@@ -932,7 +935,9 @@ =
static void virtio_balloon_device_unrealize(DeviceState =
*dev)<br><br>&nbsp;&nbsp;&nbsp;&nbsp;virtio_delete_queue(s-&gt;ivq);<br>&n=
bsp;&nbsp;&nbsp;&nbsp;virtio_delete_queue(s-&gt;dvq);<br>- =
&nbsp;&nbsp;&nbsp;virtio_delete_queue(s-&gt;svq);<br>+ =
&nbsp;&nbsp;&nbsp;if (s-&gt;svq) {<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;virtio_delete_queue(s-&gt;svq);<=
br>+ &nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;if =
(s-&gt;free_page_vq) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;virtio_delete_queue(s=
-&gt;free_page_vq);<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>---<br>base-commit=
: 9c23f2a7b0b45277693a14074b1aaa827eecdb92<br>change-id: =
20251211-balloon-check-stats-feature-7ea658e038ce<br><br>Best =
regards,<br>--<span class=3D"Apple-converted-space">&nbsp;</span><br>Aaron=
 Lo &lt;aaronlo0929@gmail.com&gt;<br><br><br></blockquote><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">With regards,</span><br style=3D"caret-color:=
 rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline =
!important;">Daniel</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">--<span =
class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">|:<span =
class=3D"Apple-converted-space">&nbsp;</span></span><a =
href=3D"https://berrange.com/" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;">https://berrange.com</a><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;"><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;-o- &nbsp;&nbsp;&nbsp;</span><a =
href=3D"https://www.flickr.com/photos/dberrange" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;">https://www.flickr.com/photos/dberrange</a><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;"><span =
class=3D"Apple-converted-space">&nbsp;</span>:|</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">|:<span =
class=3D"Apple-converted-space">&nbsp;</span></span><a =
href=3D"https://libvirt.org/" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;">https://libvirt.org</a><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;"><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;-o- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><=
a href=3D"https://fstop138.berrange.com/" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;">https://fstop138.berrange.com</a><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;"><span =
class=3D"Apple-converted-space">&nbsp;</span>:|</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">|:<span =
class=3D"Apple-converted-space">&nbsp;</span></span><a =
href=3D"https://entangle-photo.org/" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;">https://entangle-photo.org</a><span style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;"><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;-o- =
&nbsp;&nbsp;&nbsp;</span><a href=3D"https://www.instagram.com/dberrange" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: =
0px;">https://www.instagram.com/dberrange</a><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;"><span =
class=3D"Apple-converted-space">&nbsp;</span>:|</span></div></blockquote><=
/div><br></div></body></html>=

--Apple-Mail=_304AF4BB-51FF-4C08-8D0E-738206348A5D--

