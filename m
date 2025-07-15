Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CB7C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 17:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubjwD-0007I2-3U; Tue, 15 Jul 2025 13:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ubjRB-0006Y6-H4
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 13:27:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ubjR7-0001w6-Ju
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 13:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752600440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dQpyIpg2nEn3xeo7P2Ii4Wow/2lXCsk1HJhDeBQtdqE=;
 b=WDAKWizmZEZd/byvcVNM8iE/MnDPrDkXU8w/WrcHkzs79exA/sFYUk1Zee6aO/agDgVHHf
 LspMR3pxy/FUySWopfX98J/r6tWFEiIBFavcQ6Jq7Bf7H7cxaEXyGX0QxjpZwhGmmMeYSU
 uxD4eaG5wTJuz8pWfiGMcm7Fcj30W2k=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-3sbYrCDUOmSqiWg1giKUFA-1; Tue, 15 Jul 2025 13:27:19 -0400
X-MC-Unique: 3sbYrCDUOmSqiWg1giKUFA-1
X-Mimecast-MFC-AGG-ID: 3sbYrCDUOmSqiWg1giKUFA_1752600438
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2369dd58602so54969385ad.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 10:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752600438; x=1753205238;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dQpyIpg2nEn3xeo7P2Ii4Wow/2lXCsk1HJhDeBQtdqE=;
 b=E2rLaJ3PExhN54qwL8pXS++YXW1ETy/Bys6assZRNMhWYyQ7N1fR/tNR7ja85jHji+
 ttjEaOUEBzxB9fjzaJe+0zaXJO9Qzn6zHAh4CQqoCOFiHM5t+HFPj7r7uvfJQ6pmAkoX
 12jAJpsEuYRJXUPWD2n7CM9iKjz03uG5RTBnVBlyci/xiJUiGWV2h6/BNlKRYPFULq+/
 LVR1zJ6+H6pohEkl36XWqdma7DKY1cfQrOiUigSSO4VA3cJLLPSCcihqXgo+APGNk+49
 lnHmYQGORyYKGQ9n/N4HHfk79I48sektNFhTAf6WypjGivScwloIKfYVQ34GhJENh5Sz
 GJrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWRR9arADrDy+p/ECgMe7Gzwece/A2oQGFasUdXCYWELHaJkKVbdA7gS3H6dSSVkSr7Sq/M/y+yTL4@nongnu.org
X-Gm-Message-State: AOJu0YzVQX9gNQXicwC77Vpj76PqWCAQiJVtHtweQg55etQNKfRkGP35
 h/GMqR3u02TNnaUBExPfE5Drzzbz/AUEJQzVG+Ddfr01DkxxC9IhEjnpEbk0P70lXKFHNfiBNq3
 9kxPDqBYAnSmBFnxM1F4eP3r2S4et0pnwUAiy5NQUIKOXBQ2cD9WflE3z3QH1uR/iCEVRfoPOF1
 zZfmj+vfyz49OluRYWzaYoAMSSisCvFM0=
X-Gm-Gg: ASbGnculDr/NEERKlcFaJlVLqPlrlSyuDKnRRc3DJmbgE3sOveAibc9lJzTyGbMuuP4
 tYRhWL1RKbmewoeUHl2DA/5cbdmdDYv/8fwOeQ9Vg8zqBJjdJxysivombbOiA/by21Av8EsTwPk
 e8STKTLbgSzh9cwX733nP/5ZUDc3oDYwjmWiNRK8Azlfn8fxGz6+XA
X-Received: by 2002:a17:902:c408:b0:235:eb8d:800b with SMTP id
 d9443c01a7336-23dee26def9mr258948795ad.26.1752600437757; 
 Tue, 15 Jul 2025 10:27:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqO2YrM+WHcgmcq5kMhq9qWB3WLziIKgDGU7dkUNNuHtSQZ88hJeBLg2mZmkgDUhlp+68XBwJACtxfDZJHmRM=
X-Received: by 2002:a17:902:c408:b0:235:eb8d:800b with SMTP id
 d9443c01a7336-23dee26def9mr258948195ad.26.1752600437169; Tue, 15 Jul 2025
 10:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <1752164694-215567-1-git-send-email-steven.sistare@oracle.com>
 <1752164694-215567-3-git-send-email-steven.sistare@oracle.com>
 <871pqmwzqr.fsf@pond.sub.org>
In-Reply-To: <871pqmwzqr.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 15 Jul 2025 13:27:05 -0400
X-Gm-Features: Ac12FXyZd4p6SZz3b0TzlZVkAESRQDKTQmPzwq50P4wnJbU6MpFgPycPQAuJk6Y
Message-ID: <CAFn=p-YhYqG5oyWt=zpPCic=2npUkxNJuvuGBuxwthqfMAxL1g@mail.gmail.com>
Subject: Re: [PATCH V4 2/3] python: use qom-list-get
To: Markus Armbruster <armbru@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>,
 qemu-devel <qemu-devel@nongnu.org>, 
 Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Philippe Mathieu-Daude <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000007dcf520639fb1620"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000007dcf520639fb1620
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025, 10:47=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> Steve Sistare <steven.sistare@oracle.com> writes:
>
> > Use qom-list-get to speed up the qom-tree command.
> >
> > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>
> Quick test...  Differences in output before and after match expectations
> (see appended diff).
>
> New version:
>
>     real    0m0.446s
>     user    0m0.062s
>     sys     0m0.017s
>
> Old version barfs a stack backtrace (appended), and is ~18x slower:
>
>     real    0m8.176s
>     user    0m0.395s
>     sys     0m0.126s
>
> Did you see the stack backtrace, too?
>
> Regardless
> Acked-by: Markus Armbruster <armbru@redhat.com>
>
>
>
> $ diff old new
> 59c59
> <   rtc-time: {'tm_year': 125, 'tm_sec': 24, 'tm_hour': 14, 'tm_min': 39,
> 'tm_mon': 6, 'tm_mday': 11} (struct tm)
> ---
> >   rtc-time: {'tm_year': 125, 'tm_sec': 28, 'tm_hour': 14, 'tm_min': 40,
> 'tm_mon': 6, 'tm_mday': 11} (struct tm)
> 486c486
> <   date: {'tm_year': 125, 'tm_sec': 25, 'tm_hour': 14, 'tm_min': 39,
> 'tm_mon': 6, 'tm_mday': 11} (struct tm)
> ---
> >   date: {'tm_year': 125, 'tm_sec': 28, 'tm_hour': 14, 'tm_min': 40,
> 'tm_mon': 6, 'tm_mday': 11} (struct tm)
> 832c832
> <   legacy-memory: <EXCEPTION: Property 'qemu64-x86_64-cpu.legacy-memory'
> is not readable> (str)
> ---
> >   legacy-memory: <EXCEPTION: property could not be read> (str)
> 1109c1109
> <   crash-information: <EXCEPTION: No crash occurred>
> (GuestPanicInformation)
> ---
> >   crash-information: <EXCEPTION: property could not be read>
> (GuestPanicInformation)
> 1554c1554
> <   legacy-i8042: <EXCEPTION: Property 'vmmouse.legacy-i8042' is not
> readable> (str)
> ---
> >   legacy-i8042: <EXCEPTION: property could not be read> (str)
> 2436c2436
> <   legacy-iothread: <EXCEPTION: Property
> 'virtio-blk-device.legacy-iothread' is not readable> (str)
> ---
> >   legacy-iothread: <EXCEPTION: property could not be read> (str)
> 2493c2493
> <   legacy-iothread: <EXCEPTION: Property
> 'virtio-blk-device.legacy-iothread' is not readable> (str)
> ---
> >   legacy-iothread: <EXCEPTION: property could not be read> (str)
>
>
> Exception ignored in: <function QEMUMonitorProtocol.__del__ at
> 0x7fcfcd080d60>
> Traceback (most recent call last):
>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/legacy.py",
> line 310, in __del__
>     self.close()
>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/legacy.py",
> line 281, in close
>     self._sync(
>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/legacy.py",
> line 102, in _sync
>     return self._aloop.run_until_complete(
>   File "/usr/lib64/python3.13/asyncio/base_events.py", line 719, in
> run_until_complete
>     return future.result()
>   File "/usr/lib64/python3.13/asyncio/tasks.py", line 507, in wait_for
>     return await fut
>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/protocol.py",
> line 399, in disconnect
>     await self._wait_disconnect()
>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/protocol.py",
> line 719, in _wait_disconnect
>     await all_defined_tasks  # Raise Exceptions from the bottom half.
>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/protocol.py",
> line 870, in _bh_loop_forever
>     await async_fn()
> RuntimeError: cannot reuse already awaited coroutine
>

Curious about this backtrace. It looks like something has gone
fundamentally wrong in the internals and the error is being raised by the
garbage collector which is not ideal.

Can you help me reproduce this? Even if it's old/bad code, I don't want
python-qemu-qmp faulting like this.

>

--0000000000007dcf520639fb1620
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 11, 2025, 10:47=E2=
=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@=
redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Steve Si=
stare &lt;<a href=3D"mailto:steven.sistare@oracle.com" target=3D"_blank" re=
l=3D"noreferrer">steven.sistare@oracle.com</a>&gt; writes:<br>
<br>
&gt; Use qom-list-get to speed up the qom-tree command.<br>
&gt;<br>
&gt; Signed-off-by: Steve Sistare &lt;<a href=3D"mailto:steven.sistare@orac=
le.com" target=3D"_blank" rel=3D"noreferrer">steven.sistare@oracle.com</a>&=
gt;<br>
<br>
Quick test...=C2=A0 Differences in output before and after match expectatio=
ns<br>
(see appended diff).<br>
<br>
New version:<br>
<br>
=C2=A0 =C2=A0 real=C2=A0 =C2=A0 0m0.446s<br>
=C2=A0 =C2=A0 user=C2=A0 =C2=A0 0m0.062s<br>
=C2=A0 =C2=A0 sys=C2=A0 =C2=A0 =C2=A00m0.017s<br>
<br>
Old version barfs a stack backtrace (appended), and is ~18x slower:<br>
<br>
=C2=A0 =C2=A0 real=C2=A0 =C2=A0 0m8.176s<br>
=C2=A0 =C2=A0 user=C2=A0 =C2=A0 0m0.395s<br>
=C2=A0 =C2=A0 sys=C2=A0 =C2=A0 =C2=A00m0.126s<br>
<br>
Did you see the stack backtrace, too?<br>
<br>
Regardless<br>
Acked-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br>
<br>
<br>
<br>
$ diff old new<br>
59c59<br>
&lt;=C2=A0 =C2=A0rtc-time: {&#39;tm_year&#39;: 125, &#39;tm_sec&#39;: 24, &=
#39;tm_hour&#39;: 14, &#39;tm_min&#39;: 39, &#39;tm_mon&#39;: 6, &#39;tm_md=
ay&#39;: 11} (struct tm)<br>
---<br>
&gt;=C2=A0 =C2=A0rtc-time: {&#39;tm_year&#39;: 125, &#39;tm_sec&#39;: 28, &=
#39;tm_hour&#39;: 14, &#39;tm_min&#39;: 40, &#39;tm_mon&#39;: 6, &#39;tm_md=
ay&#39;: 11} (struct tm)<br>
486c486<br>
&lt;=C2=A0 =C2=A0date: {&#39;tm_year&#39;: 125, &#39;tm_sec&#39;: 25, &#39;=
tm_hour&#39;: 14, &#39;tm_min&#39;: 39, &#39;tm_mon&#39;: 6, &#39;tm_mday&#=
39;: 11} (struct tm)<br>
---<br>
&gt;=C2=A0 =C2=A0date: {&#39;tm_year&#39;: 125, &#39;tm_sec&#39;: 28, &#39;=
tm_hour&#39;: 14, &#39;tm_min&#39;: 40, &#39;tm_mon&#39;: 6, &#39;tm_mday&#=
39;: 11} (struct tm)<br>
832c832<br>
&lt;=C2=A0 =C2=A0legacy-memory: &lt;EXCEPTION: Property &#39;qemu64-x86_64-=
cpu.legacy-memory&#39; is not readable&gt; (str)<br>
---<br>
&gt;=C2=A0 =C2=A0legacy-memory: &lt;EXCEPTION: property could not be read&g=
t; (str)<br>
1109c1109<br>
&lt;=C2=A0 =C2=A0crash-information: &lt;EXCEPTION: No crash occurred&gt; (G=
uestPanicInformation)<br>
---<br>
&gt;=C2=A0 =C2=A0crash-information: &lt;EXCEPTION: property could not be re=
ad&gt; (GuestPanicInformation)<br>
1554c1554<br>
&lt;=C2=A0 =C2=A0legacy-i8042: &lt;EXCEPTION: Property &#39;vmmouse.legacy-=
i8042&#39; is not readable&gt; (str)<br>
---<br>
&gt;=C2=A0 =C2=A0legacy-i8042: &lt;EXCEPTION: property could not be read&gt=
; (str)<br>
2436c2436<br>
&lt;=C2=A0 =C2=A0legacy-iothread: &lt;EXCEPTION: Property &#39;virtio-blk-d=
evice.legacy-iothread&#39; is not readable&gt; (str)<br>
---<br>
&gt;=C2=A0 =C2=A0legacy-iothread: &lt;EXCEPTION: property could not be read=
&gt; (str)<br>
2493c2493<br>
&lt;=C2=A0 =C2=A0legacy-iothread: &lt;EXCEPTION: Property &#39;virtio-blk-d=
evice.legacy-iothread&#39; is not readable&gt; (str)<br>
---<br>
&gt;=C2=A0 =C2=A0legacy-iothread: &lt;EXCEPTION: property could not be read=
&gt; (str)<br>
<br>
<br>
Exception ignored in: &lt;function QEMUMonitorProtocol.__del__ at 0x7fcfcd0=
80d60&gt;<br>
Traceback (most recent call last):<br>
=C2=A0 File &quot;/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/legac=
y.py&quot;, line 310, in __del__<br>
=C2=A0 =C2=A0 self.close()<br>
=C2=A0 File &quot;/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/legac=
y.py&quot;, line 281, in close<br>
=C2=A0 =C2=A0 self._sync(<br>
=C2=A0 File &quot;/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/legac=
y.py&quot;, line 102, in _sync<br>
=C2=A0 =C2=A0 return self._aloop.run_until_complete(<br>
=C2=A0 File &quot;/usr/lib64/python3.13/asyncio/base_events.py&quot;, line =
719, in run_until_complete<br>
=C2=A0 =C2=A0 return future.result()<br>
=C2=A0 File &quot;/usr/lib64/python3.13/asyncio/tasks.py&quot;, line 507, i=
n wait_for<br>
=C2=A0 =C2=A0 return await fut<br>
=C2=A0 File &quot;/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/proto=
col.py&quot;, line 399, in disconnect<br>
=C2=A0 =C2=A0 await self._wait_disconnect()<br>
=C2=A0 File &quot;/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/proto=
col.py&quot;, line 719, in _wait_disconnect<br>
=C2=A0 =C2=A0 await all_defined_tasks=C2=A0 # Raise Exceptions from the bot=
tom half.<br>
=C2=A0 File &quot;/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/proto=
col.py&quot;, line 870, in _bh_loop_forever<br>
=C2=A0 =C2=A0 await async_fn()<br>
RuntimeError: cannot reuse already awaited coroutine<br></blockquote></div>=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Curious about this back=
trace. It looks like something has gone fundamentally wrong in the internal=
s and the error is being raised by the garbage collector which is not ideal=
.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Can you help me reprod=
uce this? Even if it&#39;s old/bad code, I don&#39;t want python-qemu-qmp f=
aulting like this.=C2=A0</div><div dir=3D"auto"><div class=3D"gmail_quote g=
mail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--0000000000007dcf520639fb1620--


