Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D71C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 05:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5d2G-0008W2-9N; Sun, 13 Sep 2026 01:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x5d1y-0008VJ-Iq
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 01:45:35 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x5d1w-0003JE-TH
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 01:45:34 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a9c0cd47bbso1271310a12.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 22:45:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789278331; cv=none;
 d=google.com; s=arc-20260327;
 b=SjITewinyrO6z8ZsUs2xaKqT/4UXf5D04J/M++Qa+dpgwN0fegosAQO/xkuNJPlEEq
 DAvpPj+LQSRAcWWyrANmvybKn7Mego26tlRqrwJ4UdTOlAf0KolPVLEP2FwMZVd+eVyl
 BNUWnDPouMQBJyqbwV3wTj2Eyy+vOnjlnCNBLJGopSL02r025xa5PgfhT0b3Vhy0K+Zz
 3kPmp2WPICJ8uP1OdpB8ds04hhsSi/uknr81Npi2eRrPRu/8CtpHA5m/T6G5NxJ2Lvam
 oK2UX+Na4OsQrt+ewobcJF3+A7FZI5L/VW4owHu7WRGJldw8rUYkp5eUPoaZNWGfVB2r
 f3vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:reply-to:mime-version
 :dkim-signature;
 bh=scxl7hzq1fexuJeOQWGuxgYnttXmJ9gmk6z1KpbtGKQ=;
 fh=QhcAdaSbeqSautx9/lK4X4QqNNQW1+UWXoR5FLnSJns=;
 b=Zk+nUwt6EId3DQ+YYdiSxANuxJmzjoPiZbr2iILaBlMYbfklunxMJAOQ2uZRycURh6
 IC5YMJIBbc3of/aLHT//pjTkBd968XJ5J+scqEULCOfHVzq9CqNquk+We0YOapHJhKeG
 u0+uFIibOFKf4wA5vXzSmHafAAGdbcpxsP2ygmoWZoZbblLUKO/O8RdCTnO6JN1SX7rF
 QSPvxrtyuEP0KlOWcBoHIvjgyro9XT7XfK9IS/toQ0AZ8vom5ng/jspUiFD8RzqOMix5
 IeeQTNbxODC3OY2giu+BhjCCQCApVDq/NVnT7eI/KsgqOGDFgrMI/03D3uIXJQBajsN0
 96Ww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789278331; x=1789883131; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:reply-to:mime-version
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=scxl7hzq1fexuJeOQWGuxgYnttXmJ9gmk6z1KpbtGKQ=;
 b=NZ1hhWNiv0rW/JIhDEi3Q0d3wCKvLM6YbH9gsgKM+bXhMGUz7b/+JaRUih9UxTRLm9
 EAX0wIXHy3uPkIOIUPGr3bki+c+1boSLkCDUvyzQpcrh51DkN2H3xsOz7pIocxeGeMEU
 q96Zh58oicWUmasXe6Eh/jFP0+jg7BbxiMpxpOlg5/aRE34X2Er3SQDo7f2jIuf+IccD
 5xYFWCGkgxwlBQVPTYxZyrdFwQnfGZ+WgrXQdA4xgPC3u4L135WFiPmlz6UHgeWjVQoy
 /Tx8RYiRpB7ijs5/SLBcIIuNK3zGg85DUR6+Mgfzr20tZ+xdP9SjYzfa9uq1Znu/T9sL
 pKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789278331; x=1789883131;
 h=content-type:to:subject:message-id:date:from:reply-to:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=scxl7hzq1fexuJeOQWGuxgYnttXmJ9gmk6z1KpbtGKQ=;
 b=TqsAbtTEV56R38vX62y1tl8sUZkT2TNrf0iRCtCnNMzIMoz3IVF3c/xiDcmttyoTS5
 7TfmbnOs9W2orfSnuSSJzrTkZr9oRilnazD5A538X+PIi8nFCaFKWTzn5PpixW6xj+EB
 foiYrsuPcXejGiiUxtQY4UsOUNevpTjUB2xlL73Uk+UqHuHeDeZqwzunPE3ixoMOheta
 EtSIWoxz7oR7A1XeEWiztulbNcY9d6mkSMGt8aXN90uiBeQ/6AnLJ+ZBEGoAkNhOFbKU
 ZebWv1wqM5xsP7BFfPlsVmBLG8kUdlaNBEdOQFOgBvWd1+WhdmR7fO+j4TfREQcr7uxW
 8mzQ==
X-Gm-Message-State: AFuF++mQAzD665qeYlQDFZaHpUTZC8pAN84wVIZESS8kNtIt+NJv0WcS
 CflXPqF1snzufS8h2FeLypIQIUS0QptfyiCH3KiQVi5s32ZW/Q8tuBZUz5wT0V/a5++4OjedggA
 3ORTP7GBy7OzL+sg6dxVoRbWAW8Iv2fXSDE0WkdM=
X-Gm-Gg: AYBFou28XP8+OKjzsYF7GXOOLGTUbkTaEaniA9hK846sQCrsuIrjENg0XKX/6pqtAwR
 Xg//9UA+jKXXZQsISJfgeT4FcdMQymAOwPKGI+Kjv+l5WZDYLMa+kgWr+BHLOzCFti5kViJrSZz
 WFKKoITHvjujO3RPZi9iOQ0qQy627YyooxPwVIxgT5+zLDCKKKOpxp6LclR6GgXOPJr4q4/qfAD
 hmcU9Y0PVDLAB8Ld1x7zbB5TtwpiHPc0rl5Nu/15y4URRqf9FXt/5N08F3biBr0T5wn57av3rhi
 Bgwi8T2eXLmn8+DCotw4pk+Ke8KFtmGOCiljmhpdbhx8mzc2AFRxsNw=
X-Received: by 2002:a05:6402:190b:b0:6a8:f45a:dbb1 with SMTP id
 4fb4d7f45d1cf-6a9cd4022c3mr2892560a12.45.1789278330552; Sat, 12 Sep 2026
 22:45:30 -0700 (PDT)
MIME-Version: 1.0
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sun, 13 Sep 2026 13:45:18 +0800
X-Gm-Features: AcwNN1XObeL23G4UVXz-9TRUcsD_Y0L4ZfA1_jtTw4fDkrFktQfPec2qSIoumes
Message-ID: <CAE2XoE_=G5Ri9p23vJRX3iJMHSDH4Ec+0vWWbVNf4DksxtbG2A@mail.gmail.com>
Subject: The CPU_RESOLVING_TYPE is not fixed for x86_32 and x86_64. is that
 proper?
To: qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000004c0733065b56d3c9"
Received-SPF: pass client-ip=2a00:1450:4864:33::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000004c0733065b56d3c9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#define CPU_RESOLVING_TYPE TYPE_X86_CPU, and TYPE_X86_CPU is vary for for
x86_32 and x86_64. can it define TYPE_X86_CPU to be a fixed 'x86-cpu' like
other arches?

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000004c0733065b56d3c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>#define CPU_RESOLVING_TYPE TYPE_X86_CPU, and=C2=A0<sp=
an style=3D"background-color:transparent">TYPE_X86_CPU is vary for=C2=A0</s=
pan><span style=3D"background-color:transparent">for x86_32 and x86_64. can=
 it define=C2=A0</span><span style=3D"background-color:transparent">TYPE_X8=
6_CPU to be a fixed &#39;x86-cpu&#39; like other arches?</span></div><div><=
br></div><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"l=
tr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=
=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></div>=
</div>

--0000000000004c0733065b56d3c9--

