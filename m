Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317B6CD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 22:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPSn8-0008Pl-Fy; Tue, 19 May 2026 18:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scott.seal@trailofbits.com>)
 id 1wPO5p-00039I-6n
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:18:57 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scott.seal@trailofbits.com>)
 id 1wPO5n-0000QG-8V
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:18:56 -0400
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-911dfc86903so459156085a.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 10:18:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779211133; cv=none;
 d=google.com; s=arc-20240605;
 b=esEoDrUjp9QCbG19gQEFleI1rSJzyxw5b30vHSxnWbWMRNsZ+6eFdwKHRvmbLk5SWk
 +0Ve2FT9xVaESmFlE6UAcFUlPm+RytO6Lb5Jdvb+OtJuVb8H4S70v2GKcYiHR+JndtoO
 5QKcB/iG+qwULKMxc7iATieYdfKtJG3CPOV+Yo5hrU1OSU/4WZBeMS0Iy5l5nN5jizki
 5agMZZhah5TESn3Cy4POkFmkaLFsYdC1cKVYwYUH2Ki1sKrtUOAdU4fZcSMX9Iz2Ywco
 bvLLXP9kwakIOa5UxnD4FaIP0jrMKlL2zjhfoDD6bikYXxG5lqACCXlVoaf+9h6T3k0V
 ymnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=UbYPO8wWumjwOMLrIcOv36/c7++g3lqdtsj3xnoaYDM=;
 fh=okiVJJUM19CB7BkeW3ZPAX8bVES1G3mX4JYwUmSjpT0=;
 b=gtXjnViMJuVdLm4xwI40ImQv5o0bbmwxuWmXw7dy/Iec7Da9y+etw7SNWNQd+0UCbz
 FRdt9tmAlqBQilIpxS+e0eeX8HcWjBlrAsv/lSQhuNuf0dHbbW1AyeD5Xg6fZ2VMTf4d
 EyQJ2Vw+mtiU27e3q8Kk1vf5q2IhS/5yiScI/DgDgKWiTI4T1EAg6Iljur1obn2KiNmE
 fOLXg4TNw7pLoHmYbpvxyWPD6FBvMFtBXTNq7cU+RhHaW8qJMjkdlU696lHGEi5poZbE
 geZsFPamZoWwuXtDUvgGKqkWhFjZkPN+fArM6KBaN19OjbzLiSA+BxKfmnSbf8raaWac
 RdNg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1779211133; x=1779815933; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UbYPO8wWumjwOMLrIcOv36/c7++g3lqdtsj3xnoaYDM=;
 b=cGLunA8krmffbLBmxvVJ5PmVEL40+dZx/T98Ij0OVAia9Iz218WjIA3idAln5EWzuf
 KTibgDVIgfT+BLqxqTFmRtMz5ggdBOIMqnuOXMn6C2y/iqY70Fl7WDw3cBWs30Wlb9+d
 Sw0u86A8yBR0lgXK1GzfOOwbVjW5ZBNhYHXLcDT+v3xPQXcVewmmVDX++VjiiwKsu8Dm
 hvVhYKg5Dz1SvUJ+GrCsysZuBjzJXipD/ydz0vntBcYbhVZwU9K5RcHoS9YaMUO3bQm3
 v4OQyZcUPaBwuhWZOBsW9PXscQwOAgUQnXmvy8u27bKAE7a2qAHKHBljWCPNV5/eTYda
 D/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779211133; x=1779815933;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UbYPO8wWumjwOMLrIcOv36/c7++g3lqdtsj3xnoaYDM=;
 b=Ar38/Y5Xq3gJZVBfXWSFy2b9rVc8+Dsp3TKAxdrHjIYcfkWxzLra+buStzJPiWGhJs
 QyxteB1rK1iU7W2Z91siJPq17hy9uE6xBaJGO3+qGq3yKJaxW+ELFPfdAB5vrZMaA+rP
 0HsHSmleX4sSdgFF4XyzuGH9DQBoq+Uphn7uS8cOPWZ9caXMaU6hbjfAIUm0vz+upLs5
 eMztQF9KHXItTbEl3Iaqzjbl3Xr7ODV/nkG/zOsweoo3+wiHSUCYKX/GcwjbafbsJlum
 YHVfHN39RGNN44t95iUVYr2QmsYKsTQoN2/xJ9f4TkDRxryOMvFC6ucTROcToxzx0s93
 Xlwg==
X-Gm-Message-State: AOJu0YzXdBoTdGK4trAaivrJxEy1dg4NtW2GgC9nUZP9YA3RrYTC0Dml
 zoggz5R9GiqfypmXeyqlgQqvsJYIstwiJSMo6XH86czCpVneEjcIh9ZeGTRYtz20TwJE0yE2IH8
 d0CdrFXDTjDFHD//+dId3zcLzgpz8Rz1gaXqR0kvEFHt3KExdH/qo
X-Gm-Gg: Acq92OFWO16Fz1vkugxJjIKiRUm6B1+KFjbnidYkhv81/KyVeQZ40ftrwt+V/LfcZu4
 oSYrUZ06ymApONzSTeuCOgBmpzfvQkJgWwQEiG/bdZxajwdiGgVQkREzoy6CDdi1d8iK/woPb1U
 ESXbyPWASSUSNiAdezlNUHllgJTOyCy9sHkQH7kx5UyZ+/jlfFM8Cg5f0Yoa0El5Jdcc1KN9+jK
 0TlEmXIoWPXjEIJgxymknbW0oVB1timQPE+D9bhecdO1+kBZOdspVpoBFZe2EaND+aaB8UeQoNI
 hVTfUeMkW9t3oD2UcV4PlnQNwpVIbbzNbDIcM/bpZmL18IDBK2V4
X-Received: by 2002:a05:620a:4002:b0:8da:358a:c4d4 with SMTP id
 af79cd13be357-911d07874c4mr2945033085a.55.1779211133280; Tue, 19 May 2026
 10:18:53 -0700 (PDT)
MIME-Version: 1.0
From: Scott Seal <scott.seal@trailofbits.com>
Date: Tue, 19 May 2026 12:18:36 -0500
X-Gm-Features: AVHnY4LA4VmMHW7jjIUEjLhldqlp0QOtIscChoE5Dnfqx2zKnerKJ8MbL2w51tU
Message-ID: <CACuTwmpnpOwyk5s21idt+Sr8FjGivwQLNPtjjZ-3Zb2sJbjvAg@mail.gmail.com>
Subject: Trail of Bits + OpenAI security project with [QEMU]
To: qemu-devel@nongnu.org
Cc: patchtheplanet@trailofbits.com
Content-Type: multipart/alternative; boundary="00000000000094781306522edfe0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=scott.seal@trailofbits.com; helo=mail-qk1-x729.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 19 May 2026 18:19:56 -0400
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

--00000000000094781306522edfe0
Content-Type: text/plain; charset="UTF-8"

Hello QEMU Developers!

I hope this message finds you well. My name is Scott Seal, and I'm a Senior
Security Engineer at Trail of Bits. As a security researcher, I am a heavy
user (and great admirer) of QEMU.

Trail of Bits is running a security project with OpenAI: we're pairing our
security engineers directly with a small number of OSS projects to spend a
focused week finding and patching real vulnerabilities. QEMU looks like a
strong fit.

This is an opportunity for QEMU to get dedicated support identifying,
triaging, and patching bugs with the latest AI tooling, before independent
actors begin using similar tools to report or exploit vulnerabilities.

Trail of Bits does the work, you get the fixes:

   - A Trail of Bits engineer dedicated to your project for the week
   - We validate every finding and submit patches ourselves
   - You can be as involved as you want, including not at all

OpenAI is also happy to provide participants with:

   - 6 months of ChatGPT Pro, which includes Codex
   - Conditional access to Codex Security
   - API credits for coding, maintainer automation, release workflows, and
   core open source work

Two quick questions for the maintainers:

   1. Would you want QEMU to be part of this?
   2. If interested, are you available the first week in June, and how much
   time could you spend that week? "A few hours" "heads-down for the week," or
   "none, just tell me what you find" all work.

Let me know, and I'll get it set up! Thanks again for all your hard work.

-- 

Scott Seal
Senior Security Engineer | Trail of Bits
trailofbits.com

--00000000000094781306522edfe0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div>Hello QEMU Developers!</div><div><br></div><div>I hope this =
message finds you well. My name is Scott Seal, and I&#39;m a Senior Securit=
y Engineer at Trail of Bits. As a security researcher, I am a heavy user (a=
nd great admirer) of QEMU.</div><div><div><br></div>Trail of Bits is runnin=
g a security project with OpenAI: we&#39;re pairing our security engineers =
directly with a small number of OSS projects to spend a focused week findin=
g and patching real vulnerabilities. QEMU looks like a strong fit.<br><br>T=
his is an opportunity for QEMU to get dedicated support identifying, triagi=
ng, and patching bugs with the latest AI tooling, before independent actors=
 begin using similar tools to report or exploit vulnerabilities. <br><br>Tr=
ail of Bits does the work, you get the fixes:<br><ul><li>A Trail of Bits en=
gineer dedicated to your project for the week</li><li>We validate every fin=
ding and submit patches ourselves</li><li>You can be as involved as you wan=
t, including not at all</li></ul>OpenAI is also happy to provide participan=
ts with:<br><ul><li>6 months of ChatGPT Pro, which includes Codex</li><li>C=
onditional access to Codex Security</li><li>API credits for coding, maintai=
ner automation, release workflows, and core open source work</li></ul>Two q=
uick questions for the maintainers:<br><ol><li style=3D"list-style-type:dec=
imal">Would you want QEMU to be part of this?</li><li style=3D"list-style-t=
ype:decimal">If interested, are you available the first week in June, and h=
ow much time could you spend that week? &quot;A few hours&quot; &quot;heads=
-down for the week,&quot; or &quot;none, just tell me what you find&quot; a=
ll work.</li></ol>Let me know, and I&#39;ll get it set up! Thanks again for=
 all your hard work.</div><div><br></div><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmai=
l=3D"gmail_signature"><div dir=3D"ltr"><span><p dir=3D"ltr" style=3D"line-h=
eight:1.7999999999999998;margin-top:0pt;margin-bottom:0pt"><span style=3D"f=
ont-size:11pt;font-family:&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0)=
;background-color:transparent;font-weight:700;vertical-align:baseline">Scot=
t Seal</span><span style=3D"font-size:11pt;font-family:&quot;Open Sans&quot=
;,sans-serif;color:rgb(0,0,0);background-color:transparent;font-weight:700;=
vertical-align:baseline"><br></span><span style=3D"font-size:11pt;font-fami=
ly:&quot;Open Sans&quot;,sans-serif;color:rgb(0,0,0);background-color:trans=
parent;vertical-align:baseline">Senior Security Engineer | Trail of Bits</s=
pan><span style=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,sans-se=
rif;color:rgb(0,0,0);background-color:transparent;vertical-align:baseline">=
<br></span><span style=3D"font-size:11pt;font-family:&quot;Open Sans&quot;,=
sans-serif;color:rgb(0,0,0);background-color:transparent;vertical-align:bas=
eline"><a href=3D"http://trailofbits.com" target=3D"_blank">trailofbits.com=
</a>=C2=A0</span></p><div><span style=3D"font-size:11pt;font-family:&quot;O=
pen Sans&quot;,sans-serif;color:rgb(0,0,0);background-color:transparent;ver=
tical-align:baseline"><br></span></div></span></div></div></div>
</div>
</div>
</div>
</div>

--00000000000094781306522edfe0--

