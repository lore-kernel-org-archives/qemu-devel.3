Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB92CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 20:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoSh6-0000RY-Bl; Tue, 19 Aug 2025 16:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoSh5-0000R8-KM
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 16:12:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoSh4-000558-9b
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 16:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755634349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F7h1oXZOArq5Kt0brqn10RJF++tc1uwLLGB67VVMe48=;
 b=LbLdxaPjMSQZzBrAv7NldA9eDjpkJHFRrGs+S6K8I9YBM82LCrhdNIhKH8huJyG9r6QdhL
 wH7+o/+yhEv3cY2LUgIusU2X0/ycCxmtLoaVlqHemvOnrOnx19xQd6P9j2pTCwQGUgLRob
 JXSkejbLDkVRwBBER7WCajZPAiLuFFE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-AvtQsgL5NRWSDPF0lm4V-g-1; Tue, 19 Aug 2025 16:12:26 -0400
X-MC-Unique: AvtQsgL5NRWSDPF0lm4V-g-1
X-Mimecast-MFC-AGG-ID: AvtQsgL5NRWSDPF0lm4V-g_1755634345
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-24458194d82so58975545ad.2
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 13:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755634345; x=1756239145;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7h1oXZOArq5Kt0brqn10RJF++tc1uwLLGB67VVMe48=;
 b=tfWCzUUsAXrTzpj6FBe7phPSI6vHVWiGjqm/yNrGPJqj6FISkSTYg1RjHU+p4p5RWs
 hMs1Qzfo1HJM5ni1ahUGBzzuojhVuwgiq6AD4xNRAlCxZWU2UbeNKkD/4JYkS4IsmFzq
 o4HCT8tXr+UlA4PVFzhNfxJ6feGzNZb0BxQChWpNyzRDRJ0eGaieYrUDtid1RxuX6CoD
 RQewXRRmLUIo4RDS1A3P4mAu/53OjwWc5ECaQ6iYjZ+GsNQ4edh//2oza1603Z29T2+c
 OCQUyt7sDTpoPWda+DABkD1SvDZtQIGWdLVgZAlEUKC+jExBWl5y6YPDe7XaEk+clDfC
 o2KQ==
X-Gm-Message-State: AOJu0YzofQoMG+L9TkI5RyyyRm2JVrlW5NLQ9y5tJfQDbFkRilKrHS8e
 66eEKTs2KUieczpVa6kQGSl7oolxURtln64Kda7AWtM8fQbHfVhuytNpLAQvicCMJRW4nOjSmZk
 yJgH9TGrpxvnvwHwPm93iMILl5C0+0ssSKDsqPbB7HlAVESXfavhF+J2IWFD9m4UanwlCnxnuG3
 dcDG1tfBgHEkmpfKY92tTG7lgkZoAYATE=
X-Gm-Gg: ASbGnctxgfTV/uWmSCN1F112ZDjmsvnVi6U0XjW8/0cEu5K1b2u92RftiwwOOmvC7da
 6EeOTzB+GxfET9KYnxsLaIngVLQ4NavHEflipv4oDMqzliYZuGryKqRxd2l9IvmkaBosIjiLZAS
 X4XAmiIrg+fVY1LQ3q+Oe3sJd2xjbfNbP12ZRhcSH2To0LvaCuFLOR
X-Received: by 2002:a17:903:183:b0:240:640a:c560 with SMTP id
 d9443c01a7336-245ef14c4acmr3710615ad.24.1755634344955; 
 Tue, 19 Aug 2025 13:12:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV8FG+zTZuUdlLadrP2MUPuTXJYup5uv430xrk4yH98/CzPICbEASdbJ67cEoBVEmoS3kklGN4UeqWTRAjeGc=
X-Received: by 2002:a17:903:183:b0:240:640a:c560 with SMTP id
 d9443c01a7336-245ef14c4acmr3710315ad.24.1755634344591; Tue, 19 Aug 2025
 13:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250715143023.1851000-1-berrange@redhat.com>
 <20250715143023.1851000-12-berrange@redhat.com>
In-Reply-To: <20250715143023.1851000-12-berrange@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 19 Aug 2025 16:12:12 -0400
X-Gm-Features: Ac12FXyanhFX2C8dTEyfTt6GdYwXv0jQXDVmxnP915DFgYxP2C1GkV6JFGLdPMg
Message-ID: <CAFn=p-YmCbBi_puVXV-0iEoFixuGvyfGcKB6EMkWWNjcxczvRg@mail.gmail.com>
Subject: Re: [PATCH 11/14] python: ensure QEMUQtestProtocol closes its socket
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Thomas Huth <thuth@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

On Tue, Jul 15, 2025 at 10:32=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> While QEMUQtestMachine closes the socket that was passed to
> QEMUQtestProtocol, the python resource leak manager still
> believes that the copy QEMUQtestProtocol holds is open. We
> must explicitly call close to avoid this leak warnnig.

Huh. I wonder if that's a false positive, or if it's actually true?

>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Well, either way...

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  python/qemu/machine/qtest.py | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/python/qemu/machine/qtest.py b/python/qemu/machine/qtest.py
> index 4f5ede85b2..781f674ffa 100644
> --- a/python/qemu/machine/qtest.py
> +++ b/python/qemu/machine/qtest.py
> @@ -177,6 +177,8 @@ def _post_shutdown(self) -> None:
>              self._qtest_sock_pair[0].close()
>              self._qtest_sock_pair[1].close()
>              self._qtest_sock_pair =3D None
> +        if self._qtest is not None:
> +            self._qtest.close()
>          super()._post_shutdown()
>
>      def qtest(self, cmd: str) -> str:
> --
> 2.49.0
>


