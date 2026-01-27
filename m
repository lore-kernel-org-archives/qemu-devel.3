Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9D9D2FEDE
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 19:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkpCR-0002o2-C2; Tue, 27 Jan 2026 14:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kashif04x@gmail.com>)
 id 1vkpCN-0002n6-0f
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 14:58:03 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kashif04x@gmail.com>)
 id 1vkpCL-0006vy-Hh
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 14:58:02 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-59dd9aef51eso6954905e87.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 11:58:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769543879; cv=none;
 d=google.com; s=arc-20240605;
 b=iEwNzF1YYWLqVkturWlVxbjkOBZQLy05j98FK8132xGRHPonqACnUDbz+jBG+qFWTc
 LhhrgHXKoPZQHm4XAUch5tUXjILi4OCA5oNe5juOEvMfShvyDKtw19K9GxiylreUmbiq
 yPzhxo33Y0YRhXUVp483uePjDoQPOh2dtkI26uGy97WfENdTsDkOirxl0L2EQJSY5R/m
 v85cy3wbusKPygWXUwNryfL4/3EEyKXzYPlyudCIc/wJ+VtTDz2dl5XErhMGixMA1ibf
 Ap2tZG2ZyHfiD42hdH8xpe2Wz4DftidISCe/8+bcQOKdRUmNX06MhCwqkUnTH470HiZm
 EtLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=pnjRYBbj8toptCNHlFKZ+9NH6NWsW1MzAkq5dN+ZFio=;
 fh=OTkfrEnbNDInppsfj4HB8z6V33zCj7LOct256XBfW6M=;
 b=kD+aKzLnpPZNgw4HZtzInCaEEG+ZsayWQGeeGwv4gK1/pVAFiiJRWCTVg5tFLWEwKa
 QESQfeWg/NkPPhdkc94Fpv7wBGp3vjNHIVRGVcOQhh27v0/Dh3VXg0WPDb4mRJXCt+2L
 2xAJpj5yXuZkXdxzQbxbGnnCB4BpXbbnHBSupm4wM0XaVF8uzyxkdfU27tcDyj/3qOoS
 9P0d6091Zot3VZ7hoKpa3M0tJqGGJULBV0W/pQeAjb6UX3A0PgpaXQwN0Ox/4JHeTF0L
 ZaZSrsT9bqd9mByYpU6NpHedpwAunmGbDT7hzm8giu5C5gd2vNwE3MzSCJkoN6UwZljg
 NFdg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769543879; x=1770148679; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pnjRYBbj8toptCNHlFKZ+9NH6NWsW1MzAkq5dN+ZFio=;
 b=SBYuP/h6TCymqDp6vOFxJZl6nE43AbX41nwApRCXl4a9qaiD/8pRks1U48cG3TXTdT
 kFgYa5b4GPOj/SCyT8PtrtF3f4XiTKupvJ3DrQhjk7MxGnNYLpHR8CjpwOqHGtJz390d
 19oUfqZ2uURf0iD5dQhU2rGi8YYIzluKr6ZLcdqyKJ4L2Vs5ZwOgoeRc8q1YwXCVOUlc
 EmKBak9qcp6yoAjRR/Gd2Pf2j2mrtdkyfBwkY3cCyQHQHmyWeQMBnZ00sU9Af8dCT21z
 MBAcKLplCi2dE8iZfZ9P3ZGr/mdQgKen+cGV9ae5R8sJVLB2xdkXRlPT1tT+DXetaexD
 NTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769543879; x=1770148679;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pnjRYBbj8toptCNHlFKZ+9NH6NWsW1MzAkq5dN+ZFio=;
 b=ubI3eeNyu4rM1wgYcavXqYqxEE4wQ42bxHV7JmQ6q234pLDEtkAcRng34ZNfYSMr/K
 a75dtsQMf931UfmDexZwjCWiwf26UMI1aR3mMPkgxSh2Of8ArSUbR+Kfk4eui9CcfTf1
 7HsQpCgGBw+1V5uGc2TwcXhdESl7wwZ+2aEIy+Zw5bbYPIm7WstLxdYRUDkUcdqxq2Y8
 AlM2ZqcCLR4XKgZfAkzqSHUQKi2sc53r07aHSxHXevRVuJIu9CFqY+mYsjWc4M8aK5Mf
 FuhbWL31ia5YcpNLmO66cBytkRQvvrwjgWF95YN8EsH3Reih4D/ntOgLnbRlC4Whygpj
 NEZA==
X-Gm-Message-State: AOJu0YxDd9WcVW6YBqfV8jtblQD8tvqGMUaYbLc4SruChpFM8TdynfKM
 k/CE3lc4J0OlFs12z5oeB8F2BQ1dkybJtiHIQM8uNs3AxuE1bSGQQ1HzeCPoh4Xt0hJLCvqH52S
 qVQL99YyMv9rWDCKcDaAnNyxdG0ylJ843T5z+
X-Gm-Gg: AZuq6aJoUfY4dDLvXW2CZIrloqz2B2I0PPo9QkMYzjc1gDROtXQFdS1x1KAt8jF3SsO
 I+0DQN0pliAP9OTWxKLUr/uLVreWdzk56bq8vmvYq/7vT8yRy7PHsOuV/YuGkqnBIkHCwUJz6pz
 dBcdTbFlv6irJ4KpwuRKz23aPHHoQHGCfEnZdl7M1lQdNc6Fy+yuaCNN5VWD40zmV27RpO7IWgp
 Es+rRsbHmprCkBR7JmkfkGTnTyAB8HHI43qRcJEdqU70Vt/8prqQekVZYFZv1wJidC83qLoYkSl
 53tEVYy3wmhZebyV5wXpbPOsTCoG0A==
X-Received: by 2002:a05:6512:2394:b0:59d:e65e:b38d with SMTP id
 2adb3069b0e04-59e04136572mr1312479e87.45.1769543878627; Tue, 27 Jan 2026
 11:57:58 -0800 (PST)
MIME-Version: 1.0
From: Mohd Kashif Khan <kashif04x@gmail.com>
Date: Wed, 28 Jan 2026 01:27:46 +0530
X-Gm-Features: AZwV_Qg41DHxPO34xoOAZ4pxw9504vnj852u9kz8qtxV03QKqU-kVcS5IIKtVec
Message-ID: <CACSvEXZAYPCCsC8hHSmo4w2cRhbzwb+=Nj6xfz=TAtMDodKjwQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: add CMSDK APB Watchdog device
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004cd60b0649640a9b"
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=kashif04x@gmail.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000004cd60b0649640a9b
Content-Type: text/plain; charset="UTF-8"

Dear Paolo,
You are right, and I sincerely apologize.
I made an error in judgment by relying on generative tools to draft this
boilerplate and failing to rigorously verify the functional logic before
submitting.
I understand now why this was disrespectful to your time and to the
project's standards. I did not intend to pass off generated code as a
finished product without understanding it, but that is effectively what I
did by not testing the functionality.
I am sorry for wasting the community's time.
Sincerely,
Mohd Kashif Khan

--0000000000004cd60b0649640a9b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail-gE gmail-iv gmail-gt" style=3D"font-si=
ze:0.875rem;padding:20px 0px 0px;font-family:&quot;Google Sans&quot;,Roboto=
,RobotoDraft,Helvetica,Arial,sans-serif"><span style=3D"font-family:Arial,H=
elvetica,sans-serif;font-size:small">Dear Paolo,</span></div><div class=3D"=
gmail-gs" style=3D"margin:0px;min-width:0px;padding:0px 0px 20px;width:auto=
;font-family:&quot;Google Sans&quot;,Roboto,RobotoDraft,Helvetica,Arial,san=
s-serif;font-size:medium"><div class=3D"gmail-"><div class=3D"gmail-ii gmai=
l-gt gmail-adO" id=3D"gmail-:ob" style=3D"direction:ltr;margin:8px 0px 0px;=
padding:0px;font-size:0.875rem;overflow-x:hidden"><div class=3D"gmail-a3s g=
mail-aiL" id=3D"gmail-:oa" style=3D"direction:ltr;font-variant-numeric:norm=
al;font-variant-east-asian:normal;font-variant-alternates:normal;font-size-=
adjust:none;font-kerning:auto;font-feature-settings:normal;font-stretch:nor=
mal;font-size:small;line-height:1.5;font-family:Arial,Helvetica,sans-serif;=
overflow:auto hidden"><div id=3D"gmail-avWBGd-74"><div dir=3D"auto"><div di=
r=3D"auto">You are right, and I sincerely apologize.</div><div dir=3D"auto"=
>I made an error in judgment by relying on generative tools to draft this b=
oilerplate and failing to rigorously verify the functional logic before sub=
mitting.=C2=A0</div><div dir=3D"auto">I understand now why this was disresp=
ectful to your time and to the project&#39;s standards. I did not intend to=
 pass off generated code as a finished product without understanding it, bu=
t that is effectively what I did by not testing the functionality.</div><di=
v dir=3D"auto">I am sorry for wasting the community&#39;s time.</div><div d=
ir=3D"auto">Sincerely,</div><div dir=3D"auto">Mohd Kashif Khan</div></div><=
/div></div></div><div class=3D"gmail-WhmR8e" id=3D"gmail-avWBGd-75" style=
=3D"clear:both"></div></div></div><br class=3D"gmail-Apple-interchange-newl=
ine"></div>

--0000000000004cd60b0649640a9b--

