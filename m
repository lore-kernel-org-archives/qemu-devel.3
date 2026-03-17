Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC3FFD877B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2V8h-0007gq-3B; Tue, 17 Mar 2026 10:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w2V8e-0007g3-55
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:11:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w2V8c-0006up-3Z
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773756672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b0GZWQXymxYZmxBxaZaWmGldukS7O5Q/iB5voI4qmb4=;
 b=V4xX2DOFvsN0sMgqDx5EcTfiCgmqxhlmuZZtmfF224h+kh3LjW6rHvp0x/gpX1OW0k4Cat
 zSla8oO6yvLdHkBKqOTCmLTJSx4rEsOa4kC4FI4OQlSQnUQ4SvnjJHl7nVzldLkom9o4XC
 eAOMvx/PxzHfN8wMZkr6d/1aLlvku/o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-UpbqP3s7Ps2BUQUo3oqfIQ-1; Tue, 17 Mar 2026 10:11:10 -0400
X-MC-Unique: UpbqP3s7Ps2BUQUo3oqfIQ-1
X-Mimecast-MFC-AGG-ID: UpbqP3s7Ps2BUQUo3oqfIQ_1773756670
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-899fa82ebb9so248483556d6.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 07:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773756670; cv=none;
 d=google.com; s=arc-20240605;
 b=j3KBwQ+qlxrkpeLrv3L1jWMfxwq1SyM/Ux23oF+jsaWi31eeotA7sJAFKOxPlAW6H5
 DpNM/oP2uiYKfL/iYya7JxcJAuc0XKEw5cxcKueLyWxe/2Qvq/SyicDYBaphrg9RS6iz
 PTk8ffYsw0zEVXxnunFF1/D6Ft2hhXyZ2y/4fwjRt93G95UkmXlL1Hb0fkr5GM0ELI8Q
 OlsZ59mpNSKymzWdzw/mkwS5q23Ka/8S92ywUpzfrusaNAiPmfBxaQutrK9xuxk0+pQG
 GvrXaLXN4GfG97Nky6kC0K8IcaRBectqHxFM7Ds8bbn0Bo6zEA9oqKZ6mey/D2cglbgC
 ZK+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=b0GZWQXymxYZmxBxaZaWmGldukS7O5Q/iB5voI4qmb4=;
 fh=BeZRKHJnXg5VKpZp9pIG1L6JBImdwLr5Kxe/kRWzq0c=;
 b=GZEh80MrPuf/iDnZKW60kjpQgEVuIa+xl20liP+TZw1Ib6016nFI8pnxr9zL+Kb1w8
 8pmKHdRXZmFGRJMyzCZgPQK3ZTmYl8h2L4fodXP4n8i3F9KycYQPdKOWdMQC6Gtdj8oQ
 lmkaY/hU33XFk5g4229ipMb2ky9j2gVuDKBgMcBYyGGu8XYVKlOTjkXF4aE0kPx86CSV
 EMfGk6j1O3XCiYdF8LEFnjtviOrn84ZI/z4aKIAE9kyC6HUIGYz7p3nIzgVV3bHF14CQ
 xnMm2ipf1nH8AjFwYqPOiIv8Xp/xhJQwfSI4s0OmakSdaFmpkj6I13HMVRdDWiPL+3pC
 njsg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773756670; x=1774361470; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b0GZWQXymxYZmxBxaZaWmGldukS7O5Q/iB5voI4qmb4=;
 b=EFO+xo5XLKregW3NxznRVdWeZOzuBHVswyBum8YDOz9l7WrhVgo6QB1ZSn0wf11rch
 mJQwYJS/vDQdgzzitLPy/a/f23DdNNfYhkQvx8nbpJbqKA+DQHZGA4xmiaFdolIZq+kf
 R+gavgG2G8Ry9iu66TyXl1y/BoyYhazzN0beOJACy132H2tm5gUOPJhRkSLtJAfWOGVP
 281KhxUUcQ+/V2oiQZceBCOOoqwyQa7/ZBsL8XxEOJGeSCXJ88wdvFP+xryA8vLEhK2E
 iMl23h6OumyPxzqppOuLSYKheQD/G5laoHw7pDVnYS2qmz+TtARbbWKUEdhiByRJE++9
 tOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773756670; x=1774361470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b0GZWQXymxYZmxBxaZaWmGldukS7O5Q/iB5voI4qmb4=;
 b=MBLYbeA0Rq3zGvscJebscAW1gYwEGCXnsNoDYtD3zskAHsPc1HJypfBkWbWbN3Kcow
 fflFszaV8SZQBnfEyWhUI1xtxeUuMylAyHsYw5hL8pCgEsu8wtviZhJeKHTn4MyUlz7v
 K6VWJaTcNo1pmahy/GUxIO4ZnA2O1gHYD4Yy/LNRK//HG351CqqpfkbRJuyZm0yVj+U4
 fdrGCdSq+8Aj8eZoJy4kJKp5WD3DVH0Ttv3vAhmqVXUfdW/OlmFtcuJasCJZ3UwK3gEi
 evH2In7kdhn/R+wnxY0W0uQXCTdXo1VGVpXTA++npEi74wMAosdDOz9P2TeOd2MbVKqR
 mrdg==
X-Gm-Message-State: AOJu0Yw3zrhw2VK76g9BcBaBsDfy4VNzY5nSYb/KH5en1DY0PBVJoAia
 +AB5tMf7KRAWKI6sjomfsuZKP8j0YtcyUNOgWANEr4hCv+6yWHJTXMSANW/Au9Oy+b876+H7iXF
 9qZP+DJFOCR7GpDCf1lQimQmYOG8QbQ1d1CiJP7zKpGXQMzlEhpnQ/xWEUIC5buK122NXNYPOhI
 IDTe+vSVxs1h6Uahg+Cfkj5Kog8WkVKK2esB3ieWNfHg==
X-Gm-Gg: ATEYQzynlYgp2VoqNQuWbN0R5IU6ShQPA+BeixFk0DcplFRxD/4+GLrPrHFLq9+akNr
 AyEH2tftpVPhgYbJ0mEkH5bQfkKL6waEMf0r39WFeZSKWJ5Suz3v9wnZZ7hdwWbooEDYm6PvPqq
 0U98fZzR+N+YA8kykrxpw+6Vamr4Lrl74kMSzrS9Ph/9HNpRMWpj3R4N9XqFmTkYAJr53y5wCZ2
 PnGlcwP
X-Received: by 2002:ad4:4ee6:0:b0:89c:5927:15af with SMTP id
 6a1803df08f44-89c59271a31mr74291926d6.60.1773756669836; 
 Tue, 17 Mar 2026 07:11:09 -0700 (PDT)
X-Received: by 2002:ad4:4ee6:0:b0:89c:5927:15af with SMTP id
 6a1803df08f44-89c59271a31mr74291346d6.60.1773756669172; Tue, 17 Mar 2026
 07:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260317094806.1944053-1-peter.maydell@linaro.org>
 <20260317094806.1944053-3-peter.maydell@linaro.org>
In-Reply-To: <20260317094806.1944053-3-peter.maydell@linaro.org>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 17 Mar 2026 16:10:57 +0200
X-Gm-Features: AaiRm51OMNg6USCfF25zfFsNtFwkE6NHBMOlFsfkyh7akMyFO46ReuEKfn0_FaU
Message-ID: <CAPMcbCpmjuMZsnCFmvn2pYYnHkpR_a8qwm108Fy0mSZ=mm1NvA@mail.gmail.com>
Subject: Re: [PATCH 2/3] scripts/qemu-guest-agent/fsfreeze-hook: Avoid use of
 PIPESTATUS
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000002f2c62064d38e8dd"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--0000000000002f2c62064d38e8dd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Cool magic

On Tue, Mar 17, 2026 at 11:48=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org>
wrote:

> PIPESTATUS is a bash-specific construct, and this script is supposed
> to be POSIX shell. We only use it in one place, to capture the exit
> status of a command whose output we are piping to 'logger'.
>
> Replace the PIPESTATUS usage with the trick described in
>
> https://unix.stackexchange.com/questions/14270/get-exit-status-of-process=
-thats-piped-to-another/70675#70675
> which uses a command-group to capture the status of the
> first process in the pipeline.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 85978dfb6b1c133 ("qemu-ga: Optimize freeze-hook script logic of
> logging error")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3339
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  scripts/qemu-guest-agent/fsfreeze-hook | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/qemu-guest-agent/fsfreeze-hook
> b/scripts/qemu-guest-agent/fsfreeze-hook
> index 6e2d7588af..21eb5c5145 100755
> --- a/scripts/qemu-guest-agent/fsfreeze-hook
> +++ b/scripts/qemu-guest-agent/fsfreeze-hook
> @@ -47,8 +47,23 @@ for file in "$FSFREEZE_D"/* ; do
>          "$file" "$@" >>"$LOGFILE" 2>&1
>          STATUS=3D$?
>      else
> -        "$file" "$@" 2>&1 | logger -t qemu-ga-freeze-hook
> -        STATUS=3D${PIPESTATUS[0]}
> +        # We want to pipe the output of $file through 'logger' and also
> +        # capture its exit status. Since we are a POSIX script we can't
> +        # use PIPESTATUS, so instead this is a trick borrowed from
> +        #
> https://unix.stackexchange.com/questions/14270/get-exit-status-of-process=
-thats-piped-to-another/70675#70675
> +        # which uses command-groups and redirection to get the exit
> status.
> +        # This is equivalent to
> +        #   "$file" "$@" 2>&1 | logger -t qemu-ga-freeze-hook
> +        # plus setting the exit status of the pipe to the exit
> +        # status of the first command rather than the last one.
> +        { { { {
> +                "$file" "$@" 2>&1 3>&- 4>&-
> +                echo $? >&3
> +            } | logger -t qemu-ga-freeze-hook >&4
> +            } 3>&1
> +          } | { read -r xs ; exit "$xs"; }
> +        } 4>&1
> +        STATUS=3D$?
>      fi
>
>      if [ "$STATUS" -ne 0 ]; then
> --
> 2.43.0
>
>

--0000000000002f2c62064d38e8dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto=
:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br><br>=
</div>Cool magic</div><br><div class=3D"gmail_quote gmail_quote_container">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 17, 2026 at 11:48=E2=80=
=AFAM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.m=
aydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">PIPESTATUS is a bash-specific construct, and this script i=
s supposed<br>
to be POSIX shell. We only use it in one place, to capture the exit<br>
status of a command whose output we are piping to &#39;logger&#39;.<br>
<br>
Replace the PIPESTATUS usage with the trick described in<br>
<a href=3D"https://unix.stackexchange.com/questions/14270/get-exit-status-o=
f-process-thats-piped-to-another/70675#70675" rel=3D"noreferrer" target=3D"=
_blank">https://unix.stackexchange.com/questions/14270/get-exit-status-of-p=
rocess-thats-piped-to-another/70675#70675</a><br>
which uses a command-group to capture the status of the<br>
first process in the pipeline.<br>
<br>
Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-stable=
@nongnu.org</a><br>
Fixes: 85978dfb6b1c133 (&quot;qemu-ga: Optimize freeze-hook script logic of=
 logging error&quot;)<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items/3339=
" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu=
/-/work_items/3339</a><br>
Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org=
" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
---<br>
=C2=A0scripts/qemu-guest-agent/fsfreeze-hook | 19 +++++++++++++++++--<br>
=C2=A01 file changed, 17 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/scripts/qemu-guest-agent/fsfreeze-hook b/scripts/qemu-guest-ag=
ent/fsfreeze-hook<br>
index 6e2d7588af..21eb5c5145 100755<br>
--- a/scripts/qemu-guest-agent/fsfreeze-hook<br>
+++ b/scripts/qemu-guest-agent/fsfreeze-hook<br>
@@ -47,8 +47,23 @@ for file in &quot;$FSFREEZE_D&quot;/* ; do<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;$file&quot; &quot;$@&quot; &gt;&gt;=
&quot;$LOGFILE&quot; 2&gt;&amp;1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0STATUS=3D$?<br>
=C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;$file&quot; &quot;$@&quot; 2&gt;&amp;1 |=
 logger -t qemu-ga-freeze-hook<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 STATUS=3D${PIPESTATUS[0]}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # We want to pipe the output of $file through =
&#39;logger&#39; and also<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # capture its exit status. Since we are a POSI=
X script we can&#39;t<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # use PIPESTATUS, so instead this is a trick b=
orrowed from<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # <a href=3D"https://unix.stackexchange.com/qu=
estions/14270/get-exit-status-of-process-thats-piped-to-another/70675#70675=
" rel=3D"noreferrer" target=3D"_blank">https://unix.stackexchange.com/quest=
ions/14270/get-exit-status-of-process-thats-piped-to-another/70675#70675</a=
><br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # which uses command-groups and redirection to=
 get the exit status.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # This is equivalent to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0&quot;$file&quot; &quot;$@&quot;=
 2&gt;&amp;1 | logger -t qemu-ga-freeze-hook<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # plus setting the exit status of the pipe to =
the exit<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # status of the first command rather than the =
last one.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 { { { {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;$file&quot; =
&quot;$@&quot; 2&gt;&amp;1 3&gt;&amp;- 4&gt;&amp;-<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo $? &gt;&amp;3=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } | logger -t qemu-ga-freeze-hoo=
k &gt;&amp;4<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } 3&gt;&amp;1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } | { read -r xs ; exit &quot;$xs&quot;=
; }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } 4&gt;&amp;1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 STATUS=3D$?<br>
=C2=A0 =C2=A0 =C2=A0fi<br>
<br>
=C2=A0 =C2=A0 =C2=A0if [ &quot;$STATUS&quot; -ne 0 ]; then<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--0000000000002f2c62064d38e8dd--


