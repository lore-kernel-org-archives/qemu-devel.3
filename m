Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D548C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 18:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf1S9-0006cB-TP; Mon, 03 Feb 2025 13:45:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1tf1S2-0006bX-5h
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:45:45 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1tf1S0-0004v7-FV
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 13:45:41 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso33238225e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 10:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738608334; x=1739213134; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kdyzcV6RoCyKvlams7PDk3xwDcNquzJmb1txR8vyHnM=;
 b=Kr5fgKYeeAaq+bZ92g0hoMLNNqzZB1A9+mV4GJbyLQPKP6hUgYdwb225XFK0TcRQrx
 G7UqboVgtnMCW0/8CABpKb4BfacxRpLkNacRAk4oIisfG3m2XdYTQNyPfYXGKy4xqTMc
 DglBX5TbufFUuy2aA95yHpK2Qv0TqGCecfY/c8DuO4CqRWbbb7yNxxquiiwq1Pd+L56h
 SDZhYREBzTx1VFzoyNNpBJkHv9qvZeRmGQD4qfF2F248rtbXnoKBxGPFF3gDbrWtm8un
 Fxur+YDeDNaHu7wFsFhGZYZqJ+FZ5F/cshgCQ2ZBRSElE1KKVmx/XhYKpqhwugScpnbq
 8zuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738608334; x=1739213134;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kdyzcV6RoCyKvlams7PDk3xwDcNquzJmb1txR8vyHnM=;
 b=cexZdyEk1TqUvoMD8mavLbV8f8/ezOiELpL0yAhtc3JEQBpE0UG8OUZMlJ7a7IK02o
 /Cj7JEXgQNniHtv/amXxJz80HlRYU6VglUQ6GFap7RyrPt8ZpC9dXOsWxE7JYgX/r6Tm
 MfqGXPFyEDnwO499MuNb9idszH9m3NIsVKe4+AkQXE3WF+I9IR32JcXOHrB/NKUkIOEK
 RSU7kKdHV702uNIZz9N1z3Iu7kV5tiGl7KELKiNoBF6ISFrzvo1Ti6BGQCCef23d7fyE
 +vBFVZsznullM4lUgqB03C1LRk5WMisFNw2dXPwmjAd31I8KPpb3EtajG9DI6fTWd02r
 qqHg==
X-Gm-Message-State: AOJu0YxsS9BZoGvoMrNw10WwAfyeZ7n0YqtIUZkBH9/IRvTjiwIzRHBJ
 lFqdqXOegRWHM0WJar6+VxsIXD6/0ErCJ4B/pOaz4K547asnsD/yruJFJA==
X-Gm-Gg: ASbGncuQ/nkSRtspuAITJ/F86P3tDnaq902JrjE5Gu+0ZICAj1tWvFOEmMBrpMeQ3DJ
 6sRTghOg2aRbmuAE/u17vfmYVV/LELuPJSxPMuDD8rI8rNMyGNPcdTw/2UZlPvMmnfwOrCuYnfM
 PrLn2m8JPGT+LSylPuNisMqIzQ2diVveFy5KI1O1QNL0RO9I3Y0QxiOsultpokGTOfx86lY+i+t
 +ZrlgCla1ZHylY0+aAVHxXs1S/Cl4bFS4MVE06ITE/vF01TsB4YUIm0zuMfXoli+TwyZZV7QkqS
 kJ5VDqUvLMxDINA/ZhGzqXw0VPRgZzZtbDg/82ZHc4Z1ZmFwjpJ1+ptwo6ss0U76
X-Google-Smtp-Source: AGHT+IEAtCl0QdoGkZ9b/3ktS1rtlJ/mZ4w8ngs/02p4xvqAi5iyevXtvwgqB2V1q5hwTlNLPj1KRw==
X-Received: by 2002:a05:600c:35c3:b0:434:a386:6ae with SMTP id
 5b1f17b1804b1-438dc3c2372mr209015785e9.7.1738608333660; 
 Mon, 03 Feb 2025 10:45:33 -0800 (PST)
Received: from smtpclient.apple (89-138-163-22.bb.netvision.net.il.
 [89.138.163.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81911sm197301405e9.38.2025.02.03.10.45.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Feb 2025 10:45:33 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: qemu-iotests 302 failing
From: Nir Soffer <nirsof@gmail.com>
In-Reply-To: <20250203182652.GA268514@fedora>
Date: Mon, 3 Feb 2025 20:45:20 +0200
Cc: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4105307F-69B1-4269-B500-6E7EDDC4793B@gmail.com>
References: <20250203182652.GA268514@fedora>
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=nirsof@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


> On 3 Feb 2025, at 20:26, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> Hi Nir,
> qemu-iotests 302 is failing:
>=20
>  $ git show
>  commit 6fccaa2fba391815308a746d68f7fa197bc93586
>  ...
>  $ python --version # on Fedora 41 x86_64
>  Python 3.13.1
>  $ tests/qemu-iotests/check -qcow2 302
>  302   fail       [13:16:45] [13:16:45]   0.5s   (last: 0.5s)  failed, =
exit status 1
>  --- /home/stefanha/qemu/tests/qemu-iotests/302.out
>  +++ /home/stefanha/qemu/scratch/qcow2-file-302/302.out.bad
>  @@ -32,5 +32,10 @@
>   Images are identical.
>=20
>   Kill NBD server
>  -=3D=3D=3D OVA file contents =3D=3D=3D
>  -[{"name": "vm.ovf", "offset": 512, "size": 6}, {"name": "disk", =
"offset": 1536, "size": 393216}]
>  +Traceback (most recent call last):
>  +  File "/home/stefanha/qemu/tests/qemu-iotests/302", line 118, in =
<module>
>  +    tar.addfile(disk)
>  +    ~~~~~~~~~~~^^^^^^
>  +  File "/usr/lib64/python3.13/tarfile.py", line 2262, in addfile
>  +    raise ValueError("fileobj not provided for non zero-size regular =
file")
>  +ValueError: fileobj not provided for non zero-size regular file
>=20
> Any ideas?

Thanks for notifying, I=E2=80=99ll look at that.


