Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8060CA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 14:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uutz6-0000W3-Ns; Sat, 06 Sep 2025 10:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uutz5-0000V6-E7
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 10:33:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uutyv-0004ce-Jw
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 10:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757169208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n31bFV4Iy3GeoZaiAQ5lYmkcCmuO+Aj9eyB3qlc3Lt4=;
 b=Q+Zx0uqyAfcVPTwj5ne8VeVRk4+nL6OurhLwIM2Es01N7kBdTzprLrcW7UOzP6MJakuqoB
 Kfdxn/4g36h06sFja77a3hnvflBJzWiVQif24LtpZDzD/TwgZlOdPHROA/8j5zwhFuziU2
 XsICpZELuNHfprDI6NhXk53CAQbcC4Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-H9ChDU43PD2WxRGYrk4jlQ-1; Sat, 06 Sep 2025 10:33:27 -0400
X-MC-Unique: H9ChDU43PD2WxRGYrk4jlQ-1
X-Mimecast-MFC-AGG-ID: H9ChDU43PD2WxRGYrk4jlQ_1757169206
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3df19a545c2so2575058f8f.3
 for <qemu-devel@nongnu.org>; Sat, 06 Sep 2025 07:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757169202; x=1757774002;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n31bFV4Iy3GeoZaiAQ5lYmkcCmuO+Aj9eyB3qlc3Lt4=;
 b=XlJ1tBOXAaPoAhV0PenA3HHrvkqro5qON6MvPeJozcbICAsgSmMeWY9a2nD2rQeyR+
 Fi0uvInoJ+UKfiJRX19qeyJN3Qv6tq7TCx74/9olvVQRHpKUhlXRgpqdmZkHvmXtefT3
 mvPtCGkkR1QTKJMIrvgnAyjtGEkKncxby6a6dDM2Rf/gyLL5Uspsow+CRSDZU85pyW6k
 KtuAGwOdvSOBCCdTdtOxwYArcZKAzWdOma5pexiVzEXb4zsmgy9owpCCkvK3d2MsOaaP
 7/5T6VwFtupx4jZE8Ak0c/Fy1HMGGozl62w19xeevpq1WnX8ofprnxjQ5+2SMzC6INRf
 Yebw==
X-Gm-Message-State: AOJu0YxIYiSaVumqfPT39m1yegmcxZQ7/KWBNlHTFUPhkVfOgmdm8I5l
 HsYaSrvSJ0Zvek8eaxvHY656GsjlqbDPniyQf1qvu7YqsBT/Lqi74bCpd1A8+CVSo5q7AepdF42
 UpIwYG5fZagOTyLzd2Q4qnui/1/2v0GfGX6bblQTk2u3eW4EA+pHM62XKzmXxZ9v4MDo9bptvC/
 lqRxOy65zE/o6fpmtt3RZn9sEhIDS2Fu8=
X-Gm-Gg: ASbGncv+XQajOD7yqfIZUO+g8jTJXpeLybHVysIXFzuPSc/aLXWWkfPC7X5+QrW9OB/
 mTFXoloVG/TVvTq7aCu85j9dADlJRcAstPKTl9Hkf0DuIeupRdmdBGZnl/07IbAuHAB0BayNQmH
 ILlduCq4gu+TnB5lPS9XqnhPLdOnnE49SrscZI9Z9tupGyCnvPabtDBXoZZ9oUc7Qa3I1zyLf7H
 3g+XwK5vhT3MmaIEwvQny8r
X-Received: by 2002:a05:6000:290f:b0:3d2:4085:c37d with SMTP id
 ffacd0b85a97d-3e643ff6f80mr1559872f8f.29.1757169202469; 
 Sat, 06 Sep 2025 07:33:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETK11Up6+UxWRo/nILOCi+L2gSmRDkYoqf/lwYh0MIgHHEypR0DTOQhnmhMtjKkr+lEbxPj0dapnyEQL7CrZo=
X-Received: by 2002:a05:6000:290f:b0:3d2:4085:c37d with SMTP id
 ffacd0b85a97d-3e643ff6f80mr1559848f8f.29.1757169202036; Sat, 06 Sep 2025
 07:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250904-python-v1-1-c43b3209a0cd@google.com>
 <6e43209d-645f-46e4-a23a-2a1ec149dfe8@redhat.com>
 <CAAAKUPM=vSJuc-jjPQufezBi_0GPeeTqEje05uSOgKj3_7dHtA@mail.gmail.com>
In-Reply-To: <CAAAKUPM=vSJuc-jjPQufezBi_0GPeeTqEje05uSOgKj3_7dHtA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 6 Sep 2025 16:33:10 +0200
X-Gm-Features: AS18NWCoE_HTBPgRgcVg25lz9r8T5AmzYS9TaQGFmi4vmkgA-wuhWyLG0q0TFJ8
Message-ID: <CABgObfZN4EoupW=fFHWsuqza0ro7yuBmA+pn=QrTvoKZGK8mZg@mail.gmail.com>
Subject: Re: [PATCH] Use meson's detected python installation
To: Peter Foley <pefoley@google.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org, 
 nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Sep 5, 2025 at 5:01=E2=80=AFPM Peter Foley <pefoley@google.com> wro=
te:
> Interesting, that's not what I'm seeing in practice.
> For example, locally reverting the change to block/meson.build results in=
:
> FAILED: block/module_block.h
> /build/work/046b6fd7014012220d3de53b1bd62f6eb1e9/google3/third_party/qemu=
/block/../scripts/modules/module_block.py block/module_block.h
> /usr/bin/env: 'python3': No such file or directory
>
> Where module_block.py is *not* executable:
> -rw-rw-r-- 1 pefoley primarygroup 2751 Feb 10  2021 third_party/qemu/scri=
pts/modules/module_block.py

What is the version of meson, and the actual command line? In my case
it's  "/home/.../+build/pyvenv/bin/python3
/home/pbonzini/work/upstream/qemu/block/../scripts/modules/module_block.py
block/module_block.h"..

In case you would like to debug it, here are some pointers. The Meson
code that handles it is, starting from the constructor:

    if search_dirs is None:
        # For compat with old behaviour
        search_dirs =3D [None]
    self.command =3D self._search(name, search_dirs, exclude_paths)

The search_dirs list is simply
[os.path.join(self.environment.get_source_dir(), self.subdir)]; see
program_for_siystem in mesonbuild/interpreter/interpreter.py. _search
simply walks the list:

    for search_dir in search_dirs:
        commands =3D self._search_dir(name, search_dir)
        if commands:
            return commands

and here is when the non-executable case is handled:

    def _search_dir(self, name: str, search_dir: T.Optional[str]) ->
T.Optional[list]:
        if os.path.exists(trial):
            if self._is_executable(trial):
                return [trial]
            # Now getting desperate. Maybe it is a script file that is
            # a) not chmodded executable, or
            # b) we are on windows so they can't be directly executed.
            return self._shebang_to_cmd(trial)

from which you go to

   # Replace python3 with the actual python3 that we are using
   if commands[0] =3D=3D '/usr/bin/env' and commands[1] =3D=3D 'python3':
       commands =3D mesonlib.python_command + commands[2:]
   elif commands[0].split('/')[-1] =3D=3D 'python3':
       commands =3D mesonlib.python_command + commands[1:]

and mesonlib.python_command should be the pyvenv Python interpreter.

Paolo


