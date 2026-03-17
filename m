Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E39FFD877B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2V7O-0006vq-Go; Tue, 17 Mar 2026 10:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w2V7M-0006vA-13
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:09:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w2V7K-00068n-8X
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773756593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dBRGOYnCg0AQQ94AQ28BLDsZiZdyjLqiHJNiPxxl20I=;
 b=BYHRxG3QINhJoLMnQqRO+G6ybVG84Tq12TK41Fx+SKGgkCkcv5qHorcj1hekiSutDPhD/o
 AlE/K5CKwY+Jtt73FJCyZAnirbSoC164rRHnkE2ULCoZlgMpzmd3alf12cPlvIKXcjFsML
 RTpLO5aGgKuZlPn+T04qT6Dv8Dwo/2o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-kyYUg0RxPYyiEZJWV_baqw-1; Tue, 17 Mar 2026 10:09:51 -0400
X-MC-Unique: kyYUg0RxPYyiEZJWV_baqw-1
X-Mimecast-MFC-AGG-ID: kyYUg0RxPYyiEZJWV_baqw_1773756590
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-89c519dbafeso175435936d6.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 07:09:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773756590; cv=none;
 d=google.com; s=arc-20240605;
 b=XxBioDcqVZx4cpXNjX+R/MJx/HeiVXXezwonlAvzL0/I1JJAAI82DBdFQDXYzxeMRU
 R5elYC15lgYTrcBtVtphkvm1/Jh3MZm4jpVW1kq5Kc3TE3T7eEQVewu3c4tAxUMUeaTg
 keLe353wGhh0rch+QA1eBzqWq/0tL/tDRMVAPHo27q1H1wbKaw1lr0IBg8bWGI2XnCRt
 +f0SoX8AoElIDOoVnM4ZyvFRBKgA7nhG3MmERVaHJWrMvnP4W0AVyqbRMEmbKBwylS+g
 4dnQNVYa2JXZoIXaJCVTtawk4D6r5JFUOtDDyhx1JGXDk9bdeeozBZWNlJeDhxsgkOaW
 sVXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dBRGOYnCg0AQQ94AQ28BLDsZiZdyjLqiHJNiPxxl20I=;
 fh=BeZRKHJnXg5VKpZp9pIG1L6JBImdwLr5Kxe/kRWzq0c=;
 b=aWJuOS2Hh2DZTt9CXaHIMdquwv4ZelUlkR/rXGP9yKVoTicsDq6SvesNB8PQx0AMvl
 J51jMX+Hn2/R06qbGBNk8GJ8bglwFxvHp+tZZ15FK5nXdWStW7dvaOhOgl7U2FNknQTJ
 2UmY0K66/EB7V+mewUoGYrIpWnMQqrcx9+1sYdLKBZHhOAuh5cB67rrTiIahIwCwfrWm
 wDeaabaoSDHkGQUo8ojSZxaGJhWdUaNDmxrBS0tjVOvPYAUv0Go1gLzC4m+28FdCIbFn
 R2fM4lsVe31AfqB3S2YJwNTufX1js1HTiUYyN2hFMrx/HEi7K0bpJT38GgI/ZvTf5OuV
 eFmA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773756590; x=1774361390; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dBRGOYnCg0AQQ94AQ28BLDsZiZdyjLqiHJNiPxxl20I=;
 b=d7qubZOaDFtYcWRECl+O/3ouvCL814ozuGjW9Q0FPC+koZAU0KwN7/zJf2+A8bU3TX
 u+TaVoQsuiBKdOqav1hucGYV20Eb9fz+a6+PoWvintPoYJWAW//jLX2usMsadS1Ssq+8
 Vuc4DlskabAAcTT7fZJljsIPsmvz/X6H6ARmlrvA5k176BVHxlICm5lXBSC3r/7NCl0W
 p8t42+CtOZKCM7FJ/aGH2kd1aRY09F5JDwerqb2uOUN7oYYECEz7ekCKh0wQuhuFk0XV
 W/e1eR36atXDPV+CvlTZ/JVn/leUwXzMOIw/Qqct4S8cieZdXu6klyYhopwpcFWhc0bC
 bm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773756590; x=1774361390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dBRGOYnCg0AQQ94AQ28BLDsZiZdyjLqiHJNiPxxl20I=;
 b=CQzxpZeOnUjdrGnBkXW41ZTIn66mwRGR1xSL/PZ9mmcVBQYEq9+ODByWIOH/G/1PtF
 UFDA8JFu3O3k+mPkMDM+51DKCkW2PYaxAsW5QMvVZK0wnRD5NZ63YAixyb+AYTcvQ6Oe
 Zkp1W6H0RB/9F+qjS9rKO9RFP3EsSHUzmjLRxM0fkD6Q/ktoBuTZaUM9J9xnYpKPx8Vv
 P1/ZgNhQXgSOrB+xanJBoiFrkPYldDWT3GjajIiI8zq22hyMDPzPJnYryDYZZm1hxFBX
 8r3Pzoi8K55Bt0l6nT3Nm3iI7H0DgvkMjbKNy5dh2ytVEkDtmXpnQ8fSOb44pTwBwe/p
 /EVw==
X-Gm-Message-State: AOJu0Yx9MEH8BUJZzPQqzXLzmlgpH2H0l4u+Rkndu4iNF8BI67iEVIyB
 Bfi/TqMQLwrjKsZfyRszfKZYDk0CIruW1aACjFWnoRnBmbpe5N7Epmd3SGNBpHPqkhym3wVkzVI
 qF7t0Adg4+5cyupv0MXkSJh+RKEEQMiw+tRSdtoTzk+3zVGAcAPlT2pvY8L5eSOlP4lI46FN9Pc
 nCjYOvzVsMxh5MuJG6fvWCgNzUmPEKyRE=
X-Gm-Gg: ATEYQzxm2DNWR55IWXwQgJjf9Sm4cj4WdcKXs7mvkobFK77WSrFag3RDaP480eLdXV7
 HUxWCMy07qvTQL/DS1hhGhvycDLIWdJ8Bf3oIRarVac+scDKxm3Wb5ZC8h00G71YJB+iOwW6q6n
 h9772/ci/nbog/CDTDrPVeMzKMSB7/+a4NKyXuW6hN8FZY8xUeShGUVVOo1YDwPg1uxzlKOJYxj
 D4vVF/9
X-Received: by 2002:ad4:4aeb:0:b0:89c:4cac:74c5 with SMTP id
 6a1803df08f44-89c4cac7911mr84320436d6.25.1773756590385; 
 Tue, 17 Mar 2026 07:09:50 -0700 (PDT)
X-Received: by 2002:ad4:4aeb:0:b0:89c:4cac:74c5 with SMTP id
 6a1803df08f44-89c4cac7911mr84320036d6.25.1773756589822; Tue, 17 Mar 2026
 07:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260317094806.1944053-1-peter.maydell@linaro.org>
 <20260317094806.1944053-2-peter.maydell@linaro.org>
In-Reply-To: <20260317094806.1944053-2-peter.maydell@linaro.org>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 17 Mar 2026 16:09:39 +0200
X-Gm-Features: AaiRm53-yd5j-Dqr2FSktJoa7WxyrmpYhGNO717OgJ5SmmYMxDi9MYtHZ_Dj234
Message-ID: <CAPMcbCp9USsLS01a1-zsn2mkRB8beKfWf7RjCKmwpEtcYNkbtw@mail.gmail.com>
Subject: Re: [PATCH 1/3] scripts/qemu-guest-agent/fsfreeze-hook: Avoid
 bash-isms
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000746f85064d38e32c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

--000000000000746f85064d38e32c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Tue, Mar 17, 2026 at 11:48=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org>
wrote:

> The fsfreeze-hook script starts with #!/bin/sh, but it uses
> several bash-specific constructs, resulting in misbehaviour
> on guest systems where /bin/sh is some other POSIX shell.
>
> Fix the simple ones reported by shellcheck:
>
> In scripts/qemu-guest-agent/fsfreeze-hook line 27:
> touch "$LOGFILE" &>/dev/null || USE_SYSLOG=3D1
>                  ^---------^ SC3020 (warning): In POSIX sh, &> is
> undefined.
>
> In scripts/qemu-guest-agent/fsfreeze-hook line 31:
>     local message=3D"$1"
>     ^-----------^ SC3043 (warning): In POSIX sh, 'local' is undefined.
>
> In scripts/qemu-guest-agent/fsfreeze-hook line 46:
>     log_message "Executing $file $@"
>                                  ^-- SC2145 (error): Argument mixes strin=
g
> and array. Use * or separate argument.
>
> In scripts/qemu-guest-agent/fsfreeze-hook line 55:
>     if [ $STATUS -ne 0 ]; then
>          ^-----^ SC2086 (info): Double quote to prevent globbing and word
> splitting.
>
> There is also a use of PIPESTATUS that is more complex to fix;
> that will be dealt with in a separate commit.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 85978dfb6b1c133 ("qemu-ga: Optimize freeze-hook script logic of
> logging error")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  scripts/qemu-guest-agent/fsfreeze-hook | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/qemu-guest-agent/fsfreeze-hook
> b/scripts/qemu-guest-agent/fsfreeze-hook
> index 5b915af017..6e2d7588af 100755
> --- a/scripts/qemu-guest-agent/fsfreeze-hook
> +++ b/scripts/qemu-guest-agent/fsfreeze-hook
> @@ -24,15 +24,14 @@ USE_SYSLOG=3D0
>  # if log file is not writable, fallback to syslog
>  [ ! -w "$LOGFILE" ] && USE_SYSLOG=3D1
>  # try to update log file and fallback to syslog if it fails
> -touch "$LOGFILE" &>/dev/null || USE_SYSLOG=3D1
> +touch "$LOGFILE" >/dev/null 2>&1 || USE_SYSLOG=3D1
>
>  # Ensure the log file is writable, fallback to syslog if not
>  log_message() {
> -    local message=3D"$1"
>      if [ "$USE_SYSLOG" -eq 0 ]; then
> -        printf "%s: %s\n" "$(date)" "$message" >>"$LOGFILE"
> +        printf "%s: %s\n" "$(date)" "$1" >>"$LOGFILE"
>      else
> -        logger -t qemu-ga-freeze-hook "$message"
> +        logger -t qemu-ga-freeze-hook "$1"
>      fi
>  }
>
> @@ -43,7 +42,7 @@ for file in "$FSFREEZE_D"/* ; do
>      is_ignored_file "$file" && continue
>      [ -x "$file" ] || continue
>
> -    log_message "Executing $file $@"
> +    log_message "Executing $file $*"
>      if [ "$USE_SYSLOG" -eq 0 ]; then
>          "$file" "$@" >>"$LOGFILE" 2>&1
>          STATUS=3D$?
> @@ -52,7 +51,7 @@ for file in "$FSFREEZE_D"/* ; do
>          STATUS=3D${PIPESTATUS[0]}
>      fi
>
> -    if [ $STATUS -ne 0 ]; then
> +    if [ "$STATUS" -ne 0 ]; then
>          log_message "Error: $file finished with status=3D$STATUS"
>      else
>          log_message "$file finished successfully"
> --
> 2.43.0
>
>

--000000000000746f85064d38e32c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Tue, Mar 17, 2026 at 11:48=E2=80=AFAM Peter Maydell &lt;<a href=
=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The fsfreeze-h=
ook script starts with #!/bin/sh, but it uses<br>
several bash-specific constructs, resulting in misbehaviour<br>
on guest systems where /bin/sh is some other POSIX shell.<br>
<br>
Fix the simple ones reported by shellcheck:<br>
<br>
In scripts/qemu-guest-agent/fsfreeze-hook line 27:<br>
touch &quot;$LOGFILE&quot; &amp;&gt;/dev/null || USE_SYSLOG=3D1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^---------^ S=
C3020 (warning): In POSIX sh, &amp;&gt; is undefined.<br>
<br>
In scripts/qemu-guest-agent/fsfreeze-hook line 31:<br>
=C2=A0 =C2=A0 local message=3D&quot;$1&quot;<br>
=C2=A0 =C2=A0 ^-----------^ SC3043 (warning): In POSIX sh, &#39;local&#39; =
is undefined.<br>
<br>
In scripts/qemu-guest-agent/fsfreeze-hook line 46:<br>
=C2=A0 =C2=A0 log_message &quot;Executing $file $@&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^-- SC2145 (error): Argument m=
ixes string and array. Use * or separate argument.<br>
<br>
In scripts/qemu-guest-agent/fsfreeze-hook line 55:<br>
=C2=A0 =C2=A0 if [ $STATUS -ne 0 ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^-----^ SC2086 (info): Double quote to pr=
event globbing and word splitting.<br>
<br>
There is also a use of PIPESTATUS that is more complex to fix;<br>
that will be dealt with in a separate commit.<br>
<br>
Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-stable=
@nongnu.org</a><br>
Fixes: 85978dfb6b1c133 (&quot;qemu-ga: Optimize freeze-hook script logic of=
 logging error&quot;)<br>
Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org=
" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
---<br>
=C2=A0scripts/qemu-guest-agent/fsfreeze-hook | 11 +++++------<br>
=C2=A01 file changed, 5 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/scripts/qemu-guest-agent/fsfreeze-hook b/scripts/qemu-guest-ag=
ent/fsfreeze-hook<br>
index 5b915af017..6e2d7588af 100755<br>
--- a/scripts/qemu-guest-agent/fsfreeze-hook<br>
+++ b/scripts/qemu-guest-agent/fsfreeze-hook<br>
@@ -24,15 +24,14 @@ USE_SYSLOG=3D0<br>
=C2=A0# if log file is not writable, fallback to syslog<br>
=C2=A0[ ! -w &quot;$LOGFILE&quot; ] &amp;&amp; USE_SYSLOG=3D1<br>
=C2=A0# try to update log file and fallback to syslog if it fails<br>
-touch &quot;$LOGFILE&quot; &amp;&gt;/dev/null || USE_SYSLOG=3D1<br>
+touch &quot;$LOGFILE&quot; &gt;/dev/null 2&gt;&amp;1 || USE_SYSLOG=3D1<br>
<br>
=C2=A0# Ensure the log file is writable, fallback to syslog if not<br>
=C2=A0log_message() {<br>
-=C2=A0 =C2=A0 local message=3D&quot;$1&quot;<br>
=C2=A0 =C2=A0 =C2=A0if [ &quot;$USE_SYSLOG&quot; -eq 0 ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf &quot;%s: %s\n&quot; &quot;$(date)&quot=
; &quot;$message&quot; &gt;&gt;&quot;$LOGFILE&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf &quot;%s: %s\n&quot; &quot;$(date)&quot=
; &quot;$1&quot; &gt;&gt;&quot;$LOGFILE&quot;<br>
=C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 logger -t qemu-ga-freeze-hook &quot;$message&q=
uot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 logger -t qemu-ga-freeze-hook &quot;$1&quot;<b=
r>
=C2=A0 =C2=A0 =C2=A0fi<br>
=C2=A0}<br>
<br>
@@ -43,7 +42,7 @@ for file in &quot;$FSFREEZE_D&quot;/* ; do<br>
=C2=A0 =C2=A0 =C2=A0is_ignored_file &quot;$file&quot; &amp;&amp; continue<b=
r>
=C2=A0 =C2=A0 =C2=A0[ -x &quot;$file&quot; ] || continue<br>
<br>
-=C2=A0 =C2=A0 log_message &quot;Executing $file $@&quot;<br>
+=C2=A0 =C2=A0 log_message &quot;Executing $file $*&quot;<br>
=C2=A0 =C2=A0 =C2=A0if [ &quot;$USE_SYSLOG&quot; -eq 0 ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;$file&quot; &quot;$@&quot; &gt;&gt;=
&quot;$LOGFILE&quot; 2&gt;&amp;1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0STATUS=3D$?<br>
@@ -52,7 +51,7 @@ for file in &quot;$FSFREEZE_D&quot;/* ; do<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0STATUS=3D${PIPESTATUS[0]}<br>
=C2=A0 =C2=A0 =C2=A0fi<br>
<br>
-=C2=A0 =C2=A0 if [ $STATUS -ne 0 ]; then<br>
+=C2=A0 =C2=A0 if [ &quot;$STATUS&quot; -ne 0 ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0log_message &quot;Error: $file finished w=
ith status=3D$STATUS&quot;<br>
=C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0log_message &quot;$file finished successf=
ully&quot;<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--000000000000746f85064d38e32c--


