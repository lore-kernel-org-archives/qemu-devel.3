Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A22EC2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 10:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGEiz-0006Pk-Su; Sat, 17 May 2025 06:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uGEiw-0006PX-Qi
 for qemu-devel@nongnu.org; Sat, 17 May 2025 06:24:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uGEiv-0006fd-5v
 for qemu-devel@nongnu.org; Sat, 17 May 2025 06:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747477495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pBDiVNhN/1W6AGEBv3xW/VatF/M+FG5U9HDvHpuN9v0=;
 b=VQW0MGavEZG3qowuS8Xl7BnEwjZbbfbbZxvjWMc8DIFr+5NyMjzaBh2ImntfhdoZ2btZhZ
 YWkzzfEm8XWUz8AqIzmt+ktPYHGV8xJV2O/3acBSbDy6oKOUVLgqgKFZKEsGOSJKl82+yV
 BobFwVFjiUJNVRDg3eWIfG1glBx4cak=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-VcG25jC-OEmJ8dh9PaKsEQ-1; Sat, 17 May 2025 06:24:53 -0400
X-MC-Unique: VcG25jC-OEmJ8dh9PaKsEQ-1
X-Mimecast-MFC-AGG-ID: VcG25jC-OEmJ8dh9PaKsEQ_1747477492
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a3591c42d4so1953365f8f.3
 for <qemu-devel@nongnu.org>; Sat, 17 May 2025 03:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747477492; x=1748082292;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pBDiVNhN/1W6AGEBv3xW/VatF/M+FG5U9HDvHpuN9v0=;
 b=jEEb4S8EY7XKzw81yS7ctJFXryIyd1AN9XYKwkc8XrfGLPlhYhC7kbo6W5h7zWfv4m
 TpGV3TuX8VbWbrSiEdod5VFn6hgl2y4vW6yS01NSTkkOsNZ4rJ2ozUOTjJuf/6IYqvnM
 sQ+MCbTaTylGjJV+jKFfTioIRLtDWpFlgh3dy9jALW/1fVHg8qvI6mEjB/7k8lBUgCKn
 Kd4WFjHzdZ/xGgvFWH91HGMcGRUYKWnSVrLgn2i8YWD/lbtkg2CA59JNXPkeXcwP703g
 ZnW4Ep6Mt/JZCDfW7WfW3ATxDCCUDntt3N54jRxWrG/2f4K81kA334LOht8pehV1DuRD
 YqKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8eLAthae7I+56vw1vCzJ0sOmxawM3UBzyVaLBhzEkHwvQ6qdzvNyCdDWx/qoXN/47tVeslOaPSF6Q@nongnu.org
X-Gm-Message-State: AOJu0Yyx06nL7aWYv4MoF6grNqJf7/LKF/9cAFqyts3Qd0sbdeeNn19F
 Zc9d1d69/3fwvpAXq6CZ5ARzBWmrLVfRWbFAsDH/CgR5D3N+DBJbF2LblmBsJ6QtNzZ+cZ8xlZJ
 w5hobc0amudVS1C/uWlzeplAR2JsHWFTN8tVkMKED+9AzSeW2Oa5edsWulBvpWhTIvnm1zIEs46
 vLU9tdm7AE79O5rJz0BcnAo2fqJFGAtn4=
X-Gm-Gg: ASbGncs6CKEFyqKpt6c3Xno5JM15wX/g9gXEryNHi3d0ywVFRfsT/2rdSQ0jLFmreMS
 iCl+IacCQHEsUTInUWgOskGjH1QvHpxusIwuiL+zC3r7fcsAeUA0sJlarelwldwJLgWa0mg==
X-Received: by 2002:a5d:5f81:0:b0:39c:1257:cd3f with SMTP id
 ffacd0b85a97d-3a35c84f954mr6073307f8f.57.1747477491954; 
 Sat, 17 May 2025 03:24:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMbnpd7jsXh6fechaM+/tf4d4JWIFb8SXzmoE/izq3gWdE+SYDuIclBHVZemRAyclAs4NvIT90XVTRkc/9SiI=
X-Received: by 2002:a5d:5f81:0:b0:39c:1257:cd3f with SMTP id
 ffacd0b85a97d-3a35c84f954mr6073289f8f.57.1747477491627; Sat, 17 May 2025
 03:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250511-event-v3-0-f7f69247d303@daynix.com>
 <20250511-event-v3-4-f7f69247d303@daynix.com>
 <e86aeab6-ef67-4f5a-9110-93309a77acf6@redhat.com>
 <a40b0b1d-b1f8-478d-bde4-cac386323691@daynix.com>
 <CABgObfa+sBbA3OURGm=6WGzs1TQKyaHjRj+QS3n9dUvSjEPkZw@mail.gmail.com>
 <12b1dba8-ecb5-4167-841f-0a32256285d5@daynix.com>
 <CABgObfaT6XJTkkQMfQt4bMhXGu7EvTqAv-qf+qStU9cezBwBgQ@mail.gmail.com>
 <036ed37f-9403-40f3-9c07-4555d666894c@daynix.com>
In-Reply-To: <036ed37f-9403-40f3-9c07-4555d666894c@daynix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 17 May 2025 06:24:41 -0400
X-Gm-Features: AX0GCFsL7qGhDhW0UpDjcIqy3zAY0bA3STCjrQfDLDnL-kJt_V1yXSZJqU9IqWs
Message-ID: <CABgObfZG6pTned+YKtaU3ov5C15GdgmDygZTEGNiwyzwnrVELQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] qemu-thread: Avoid futex abstraction for
 non-Linux
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, 
 qemu-devel <qemu-devel@nongnu.org>, devel@daynix.com, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000002455930635524ffc"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000002455930635524ffc
Content-Type: text/plain; charset="UTF-8"

Il sab 17 mag 2025, 01:41 Akihiko Odaki <akihiko.odaki@daynix.com> ha
scritto:

> I think we only need a store-release, which is ensured even by the C11
> read-modify-write operation; we only need to ensure that ev->value is
> set to EV_SET after all stores specified earlier appear.
>

You really need a barrier to order the store against the load
unfortunately. Likewise in qemu_event_wait(). It's really central to this
synchronization pattern, otherwise it's possible that neither side sees the
action of the other (set does not see the request to wake, or wait does not
see EV_SET).

Paolo


> >
> >           if (qatomic_xchg(&ev->value, EV_SET) == EV_BUSY) {
> >
> >
> > Removing the qatomic_read() works, but it's more expensive in the case
> > that the event is already set.
>
> Removing the qatomic_read() (while keeping smp_mb()) is more expensive
> in that case indeed, but I'to m not so sure if the case is common enough
> that it depreciates the overhead added in the other cases.
>
> I don't know whether the qatomic_read() has improved the performance or
> not, but perhaps it is still a premature optimization.
>
>  > > The barrier before qemu_futex_wake_all(ev) could be unnecessary
> because
> > there is probably one in FUTEX_WAKE. But not being able to audit Windows
> > makes me a bit uneasy about it.
>
> With "[PATCH v3 01/10] futex: Check value after qemu_futex_wait()",
> qemu_event_wait() always calls qatomic_load_acquire(&ev->value) or
> qatomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY) before returning, so a
> store-release of ev->value is sufficient to ensure ordering and we don't
> need to rely on qemu_futex_wait() for that.
>
> Regards,
> Akihiko Odaki
>
>

--0000000000002455930635524ffc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il sab 17 mag 2025, 01:41 Akihik=
o Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@dayni=
x.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">I think we only need a store-release, which is ensured even by t=
he C11 <br>
read-modify-write operation; we only need to ensure that ev-&gt;value is <b=
r>
set to EV_SET after all stores specified earlier appear.<br></blockquote></=
div></div><div dir=3D"auto"><br></div><div dir=3D"auto">You really need a b=
arrier to order the store against the load unfortunately. Likewise in qemu_=
event_wait(). It&#39;s really central to this synchronization pattern, othe=
rwise it&#39;s possible that neither side sees the action of the other (set=
 does not see the request to wake, or wait does not see EV_SET).</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qatomic_xchg(&amp;ev-&gt;v=
alue, EV_SET) =3D=3D EV_BUSY) {<br>
&gt; <br>
&gt; <br>
&gt; Removing the qatomic_read() works, but it&#39;s more expensive in the =
case <br>
&gt; that the event is already set.<br>
<br>
Removing the qatomic_read() (while keeping smp_mb()) is more expensive <br>
in that case indeed, but I&#39;to m not so sure if the case is common enoug=
h <br>
that it depreciates the overhead added in the other cases.<br>
<br>
I don&#39;t know whether the qatomic_read() has improved the performance or=
 <br>
not, but perhaps it is still a premature optimization.<br>
<br>
=C2=A0&gt; &gt; The barrier before qemu_futex_wake_all(ev) could be unneces=
sary <br>
because<br>
&gt; there is probably one in FUTEX_WAKE. But not being able to audit Windo=
ws <br>
&gt; makes me a bit uneasy about it.<br>
<br>
With &quot;[PATCH v3 01/10] futex: Check value after qemu_futex_wait()&quot=
;, <br>
qemu_event_wait() always calls qatomic_load_acquire(&amp;ev-&gt;value) or <=
br>
qatomic_cmpxchg(&amp;ev-&gt;value, EV_FREE, EV_BUSY) before returning, so a=
 <br>
store-release of ev-&gt;value is sufficient to ensure ordering and we don&#=
39;t <br>
need to rely on qemu_futex_wait() for that.<br>
<br>
Regards,<br>
Akihiko Odaki<br>
<br>
</blockquote></div></div></div>

--0000000000002455930635524ffc--


