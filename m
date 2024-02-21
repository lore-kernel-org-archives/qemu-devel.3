Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153B6C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoqC-0003wC-9g; Wed, 21 Feb 2024 10:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akilan.purushothaman@gmail.com>)
 id 1rceA8-0004yp-OV
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 23:24:52 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akilan.purushothaman@gmail.com>)
 id 1rceA6-0004Zk-BR
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 23:24:51 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5101cd91017so8115431e87.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 20:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708489487; x=1709094287; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Og9d873d3uZpMwdAH+IUxEqRHLkd4OjG/C+AOnPcogc=;
 b=K6GRLUxpEafN/A333QpaihHLEE7XQW9+lAykqcTtLC0PZRg8VkoI6HbE+7Uwp2Xunf
 w0j+/R3UUuX9N1xtvNtHdKmtUzkUgY7qazcI3jZEYtAU/bxtickz3UVawfmSx+eCgrjq
 AV7i4QeOlOPAK3mgdrCFo/gw9QfCVzq0XiWErbXw/ZzT4QMLqiijRYxBZRVfuB4qNUGx
 gV+uoYc0Tlsx0WZZsGsgkRnyYqdpVtROiFNIs22iJ8rmgt4S8VEOF7/qotwpacGy4TOK
 U8qZ1iSQAOSyzfJmqZcTyWpbeK7sj4eZFadyyUuCfYVoMbPUGpkLc9y/wH8TVymS3FHC
 hKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708489487; x=1709094287;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Og9d873d3uZpMwdAH+IUxEqRHLkd4OjG/C+AOnPcogc=;
 b=upeWunPvqwrRMMDl2lCJfLX4M7GJlmhs8N2pymjgKZLPokqZkaEQy45dzJExkWtmKi
 ++YTRSAHmAwN5xS/AGSe1BgeE+YBzsr35y6h38pP7IdYBVfO4ub+f55gflWG9zXMSwLm
 lMqMSI/nlU3AqKo6aHnxRbsXnBB/a+YjNGtViihiTcreAajnejYeMerp/5rDnAErHKIY
 mOS4M23A8P93vO4Ph2yBx1fEofxkxQclZd7u8/CmgPt6Gv3sb4Eqk308vU2GI6PPMaHk
 bLvZXjoxFCpz+DIkSzcuB5WHZJ/7NvW3Bie9ryA0btst97ZSrJ13JG/NKnC6VwQ5c3yR
 NWog==
X-Gm-Message-State: AOJu0YwLwAFgrowoKLkiz22TOYOWbgbZtzvj/8gnyLkpX1j7YeSagN0J
 quF+e6YrfrKpP4P5QtiHk58Q1gb3VUV5hexxsFVw2sCDHeB9uuIcImQBML8CjM901WQYsDFXDVp
 7MlFaQXj+K+fPqxFFl7XyxsjpztCEPTQE2ag=
X-Google-Smtp-Source: AGHT+IFPz1XvWy6r3bmB6+qeu0nt+LcjP8q7GSgMv3U/sgUcijO231KG0Y2x7ezcptHgBMz8D1yge1wJNSAZtPtksGY=
X-Received: by 2002:a05:6512:3445:b0:512:a885:c377 with SMTP id
 j5-20020a056512344500b00512a885c377mr5664122lfr.60.1708489487161; Tue, 20 Feb
 2024 20:24:47 -0800 (PST)
MIME-Version: 1.0
From: Akilan Purushothaman <akilan.purushothaman@gmail.com>
Date: Tue, 20 Feb 2024 20:24:36 -0800
Message-ID: <CAMQL4mtzZr5Fg_iSWY3S5eRRrM9u6ya5itssXb+q0FaaWW4FXA@mail.gmail.com>
Subject: Help with qemu_input_event_send_key_number and IOThreads in Qemu
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000fc1f510611dcb48e"
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=akilan.purushothaman@gmail.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 21 Feb 2024 10:48:59 -0500
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

--000000000000fc1f510611dcb48e
Content-Type: text/plain; charset="UTF-8"

Dear Development Team,

I'm trying to use Qemu as a shared library for my Android app. It is
working fine so far. I can get the display output, but I cannot send it any
keys. When I try, I get an error about an assert() failing at line 91 in
tcg-accel-ops.c
<https://github.com/qemu/qemu/blob/da96ad4a6a2ef26c83b15fa95e7fceef5147269c/accel/tcg/tcg-accel-ops.c#L91>.
I think I'm supposed to run it from some IOThread, but I am not sure how it
is done. I would appreciate it very much if you helped me with this.

void snd_keypress(const char *ke, int len){
>     int id = index_from_key(ke, len);
>     printf("yop\n");
>     if(l.kbd != NULL && l.dcl.con != NULL) {
>         printf("convert%d\n", id);
>         printf("start event\n");
>         qemu_input_event_send_key_number(l.dcl.con, id, true);
>         qemu_input_event_send_key_delay(0);
>         printf("started\n");
>         sleep(1);
>         printf("end event\n");
>        qemu_input_event_send_key_number(l.dcl.con, id, false);
>        qemu_input_event_send_key_delay(0);
>     }
> }
>

Best regards,
Akilan Purushothaman

--000000000000fc1f510611dcb48e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Development Team,<div><br></div><div>I&#39;m trying t=
o use Qemu as a shared library for my Android app. It is working fine so fa=
r. I can get the display output, but I cannot send it any keys. When I try,=
 I get an error about <a href=3D"https://github.com/qemu/qemu/blob/da96ad4a=
6a2ef26c83b15fa95e7fceef5147269c/accel/tcg/tcg-accel-ops.c#L91">an assert()=
 failing at line 91 in tcg-accel-ops.c</a>. I think I&#39;m supposed to run=
 it from some IOThread, but I am not sure how it is done. I would appreciat=
e it very much if you helped me with this.</div><div><br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">void snd_keypress(const char *ke, int=
 len){<br>=C2=A0 =C2=A0 int id =3D index_from_key(ke, len);<br>=C2=A0 =C2=
=A0 printf(&quot;yop\n&quot;);<br>=C2=A0 =C2=A0 if(l.kbd !=3D NULL &amp;&am=
p; l.dcl.con !=3D NULL) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;conve=
rt%d\n&quot;, id);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;start event\=
n&quot;);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_event_send_key_number(l=
.dcl.con, id, true);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_event_send_k=
ey_delay(0);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;started\n&quot;);<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 sleep(1);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 pri=
ntf(&quot;end event\n&quot;);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_input_even=
t_send_key_number(l.dcl.con, id, false);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu=
_input_event_send_key_delay(0);<br>=C2=A0 =C2=A0 }<br>}<br></blockquote><di=
v><br></div><div>Best regards,</div><div>Akilan Purushothaman=C2=A0</div></=
div>

--000000000000fc1f510611dcb48e--

