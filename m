Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F401C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 11:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFswy-00026C-Ib; Fri, 16 May 2025 07:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uFswv-00022U-4c
 for qemu-devel@nongnu.org; Fri, 16 May 2025 07:09:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uFswt-0005bu-2x
 for qemu-devel@nongnu.org; Fri, 16 May 2025 07:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747393791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RZtughWOQW5+oyA0sran9LCwcoTykep1FiZBXH2O+2s=;
 b=dK8c6WdS7kQS7i8g1NSQcc0Xqvk/x6/443tfrNlSEYV8oulAZmdgxecSF1uD7nXnccVZZU
 LTfqxXDOrsNjNuThN5/dPDtkY38A7+rfiyYc1ezSv7wpfUrw1KKBQrc6Wd93Rmb1BQQ7X4
 p5TaozdVvwop8sQJXhXGZRsQUt3giAU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-3Eku7e1GO12TeVl_YGpPfA-1; Fri, 16 May 2025 07:09:49 -0400
X-MC-Unique: 3Eku7e1GO12TeVl_YGpPfA-1
X-Mimecast-MFC-AGG-ID: 3Eku7e1GO12TeVl_YGpPfA_1747393788
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a35c8a7fd9so460980f8f.1
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 04:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747393788; x=1747998588;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RZtughWOQW5+oyA0sran9LCwcoTykep1FiZBXH2O+2s=;
 b=jOMyBIwL4ht8zSfpOVRIudK2ElHhFFTM1gHsiwjvgvhS/tlZFj3VZwwCcQzry1ort3
 AEJB3dcx1pxcEIvptQq3TnvZMZVTdquBQ7zIc9E7LddUa6/wCP41lRVK3KODAi4YEZ20
 pVxDC0JF+g+l1GzyDAZ7bjgk8oWDUAwStYaQTo0nE1K52L1y7aozOKa0i5qFcL4btLQI
 FEk7n+LQ2zuVZh8SqIRRlDk843yd4/CXNoVbfEwL+L+iJ9Ah2BK/iIWddUWBtAxx+fjt
 AQZDqJAcyZ0JuTq9/Kt51aC3Qq3fvcowD1QobobhL5KxHozUG727Vykn7bOLHM+r2y2I
 /MHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrFhoOvYoSkuQzDYfuqXS6hRhvu6zI/w2unHizZyJSsCqlgP85UBBNW5RPnqJpLzrsvWqMylrml9yn@nongnu.org
X-Gm-Message-State: AOJu0YwhvffDFpF8vmEQv8V2VC9YErJtlgoBOuaDzcReVqaqgLY9jief
 WL0mbb5jYkkn4nCTUVpGZK4skA/Kls2a4DTAqETCpWcYv6er3vuYyxpbabMH3qGbm4tw6FyiqiA
 qLj7d9iYfCfSHm5ABJL9ow3B30oCa/OyyRWkZNdjwW1AabFfhnIXhJOKTBXlmbTliWKSxKrqj4p
 bX2eiOlMAZHBF8dliTvLtpTAOWwsRdOFQ=
X-Gm-Gg: ASbGncsVH397gR3lzHy+WXVhphqdxUHmlqFUyBGrvo4U/wEckXXUGAft9ABmu8J407S
 +gtAcUZR/YQAKqcY0OqzzPEEwdAAg4PUxNtyTdi9fd6xAFcbDBK+1rwtALNKxGrVIBo/jpg==
X-Received: by 2002:a5d:4b8a:0:b0:3a3:62e1:a7ba with SMTP id
 ffacd0b85a97d-3a362e1a8fdmr1010434f8f.9.1747393788514; 
 Fri, 16 May 2025 04:09:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB3rMVUZkzrVjH3CbzIsv37uUz3r61+BG9BvVKRO5FlIhIOYlbvN+STxGYZ5eiPG9jMTT4+FwuQTqlnwir4Tg=
X-Received: by 2002:a5d:4b8a:0:b0:3a3:62e1:a7ba with SMTP id
 ffacd0b85a97d-3a362e1a8fdmr1010405f8f.9.1747393788165; Fri, 16 May 2025
 04:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250511-event-v3-0-f7f69247d303@daynix.com>
 <20250511-event-v3-4-f7f69247d303@daynix.com>
 <e86aeab6-ef67-4f5a-9110-93309a77acf6@redhat.com>
 <a40b0b1d-b1f8-478d-bde4-cac386323691@daynix.com>
In-Reply-To: <a40b0b1d-b1f8-478d-bde4-cac386323691@daynix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 16 May 2025 07:09:35 -0400
X-Gm-Features: AX0GCFud55TCB3gp343izrCj-KLKdGNyhBIk4avSXnpKHn2HBdTXsS1Upenb28A
Message-ID: <CABgObfa+sBbA3OURGm=6WGzs1TQKyaHjRj+QS3n9dUvSjEPkZw@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="00000000000006da4406353ed2af"
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

--00000000000006da4406353ed2af
Content-Type: text/plain; charset="UTF-8"

Il mer 14 mag 2025, 08:57 Akihiko Odaki <akihiko.odaki@daynix.com> ha
scritto:

> Honestly, I do not understand why smp_mb() is placed here even in the
> futex case. The comment says:
>  > qemu_event_set has release semantics, but because it *loads*
>  > ev->value we need a full memory barrier here.
>
> The barrier is indeed followed by a load: qatomic_read(&ev->value) !=
> EV_SET
> However, the caller of qemu_event_set() should not care whether the
> event is already set or not

so I'm not sure if smp_mb() is needed in
> the first place.


The barrier is needed to ensure correct ordering in all cases. You have on
one side

done=true
Set
  Read ev->value
  If not EV_SET, set the event+ wake up waiters

>
And on the other

Write EV_FREE
  Write
If not done
  Wait

If one that calls qemu_event_set and the other calls qemu_event_reset, you
need to avoid that set reads a previous EV_SET for the value *and* the
other side reads done equal to false. The only way to avoid this is for
both sides to use a memory barrier before the read.

qemu_event_set(): release *if the event is not already set*; otherwise
> it has no effect on synchronization so we don't need a barrier either.


It needs to be release always. This ensures that, whenever the setter
declares the event to be set, the other side sees whatever the setter did
before the call.

It's the full memory barrier that is only needed, in principle, when the
event is not already set. But in practice you cannot know which barrier is
needed until you read the value, so you do need smp_mb().



qemu_event_reset(): acquire; this enables checking the state for the
> event set before resetting.
>
> qemu_event_wait(): acquire
>

These are correct. However, these are the semantics seen by the caller, but
(because of the algorithm used with futexes) there is a store-load ordering
and full barriers are necessary. Without futexes indeed it's enough to have
store-release and load-acquire in set/reset, and the mutex and condvar take
care of synchronizing set with wait.

Paolo

Regards,
> Akihiko Odaki
>
>

--00000000000006da4406353ed2af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 14 mag 2025, 08:57 Akihiko Odaki &lt;<a href=3D=
"mailto:akihiko.odaki@daynix.com" rel=3D"noreferrer noreferrer" target=3D"_=
blank">akihiko.odaki@daynix.com</a>&gt; ha scritto:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Honestly, I do not understand why smp_m=
b() is placed here even in the <br>
futex case. The comment says:<br>
=C2=A0&gt; qemu_event_set has release semantics, but because it *loads*<br>
=C2=A0&gt; ev-&gt;value we need a full memory barrier here.<br>
<br>
The barrier is indeed followed by a load: qatomic_read(&amp;ev-&gt;value) !=
=3D EV_SET<br>
However, the caller of qemu_event_set() should not care whether the <br>
event is already set or not</blockquote></div></div><div dir=3D"auto"><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"> so=
 I&#39;m not sure if smp_mb() is needed in <br>
the first place.</blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">The barrier is needed to ensure correct ordering in all cases. =
You have on one side</div><div dir=3D"auto"><br></div><div dir=3D"auto">don=
e=3Dtrue</div><div dir=3D"auto">Set</div><div dir=3D"auto">=C2=A0 Read ev-&=
gt;value</div><div dir=3D"auto">=C2=A0 If not EV_SET, set the event+ wake u=
p waiters</div><div dir=3D"auto"></div><div dir=3D"auto"><div class=3D"gmai=
l_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">And =
on the other=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">Write=
 EV_FREE</div><div dir=3D"auto">=C2=A0 Write=C2=A0=C2=A0</div><div dir=3D"a=
uto">If not done</div><div dir=3D"auto">=C2=A0 Wait</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">If one that calls qemu_event_set and the other =
calls qemu_event_reset, you need to avoid that set reads a previous EV_SET =
for the value *and* the other side reads done equal to false. The only way =
to avoid this is for both sides to use a memory barrier before the read.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">qemu_event_set(): releas=
e *if the event is not already set*; otherwise <br>
it has no effect on synchronization so we don&#39;t need a barrier either.<=
/blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">It ne=
eds to be release always. This ensures that, whenever the setter declares t=
he event to be set, the other side sees whatever the setter did before the =
call.</div><div dir=3D"auto"><br></div><div dir=3D"auto">It&#39;s the full =
memory barrier that is only needed, in principle, when the event is not alr=
eady set. But in practice you cannot know which barrier is needed until you=
 read the value, so you do need smp_mb().</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
/div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
qemu_event_reset(): acquire; this enables checking the state for the <br>
event set before resetting.<br>
<br>
qemu_event_wait(): acquire<br></blockquote></div></div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">These are correct. However, these are the semanti=
cs seen by the caller, but (because of the algorithm used with futexes) the=
re is a store-load ordering and full barriers are necessary. Without futexe=
s indeed it&#39;s enough to have store-release and load-acquire in set/rese=
t, and the mutex and condvar take care of synchronizing set with wait.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</div><div dir=3D=
"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
Regards,<br>
Akihiko Odaki<br>
<br>
</blockquote></div></div></div>

--00000000000006da4406353ed2af--


