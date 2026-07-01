Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0F3C43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wepTn-0006IU-Br; Wed, 01 Jul 2026 03:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wepTh-0006G9-6e
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 03:35:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wepTe-0000yN-VW
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 03:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782891321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hxG03dAVDxHberO1StLOJcympOGebyx6jTxne2nH974=;
 b=TjqUbzxGBw0nUiqetItTebPVH78QJlV58MVflpTsqpg22huPLxoQW5QBHfYxFJPqZkp0t+
 T++4idRuienKHaPbxO4MqFancSE+W57g9Wb/aEJgi7hWPrPyrDtXfDrnNLz5Y1/oA/NFHw
 xCgc2e52l+imduyhxsiP/VdCWaxO5Gg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-0RzVoWlmNESZ800O1iSHBQ-1; Wed,
 01 Jul 2026 03:35:18 -0400
X-MC-Unique: 0RzVoWlmNESZ800O1iSHBQ-1
X-Mimecast-MFC-AGG-ID: 0RzVoWlmNESZ800O1iSHBQ_1782891317
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDB111956077; Wed,  1 Jul 2026 07:35:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 246DF3000C25; Wed,  1 Jul 2026 07:35:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BB21F21E6920; Wed, 01 Jul 2026 09:35:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  devel@lists.libvirt.org,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian
 Brauner <brauner@kernel.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH v5 33/35] tests: switch from -mon to -object monitor-qmp
In-Reply-To: <20260624173752.2928717-34-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 24 Jun 2026 18:37:49
 +0100")
References: <20260624173752.2928717-1-berrange@redhat.com>
 <20260624173752.2928717-34-berrange@redhat.com>
Date: Wed, 01 Jul 2026 09:35:13 +0200
Message-ID: <87jyrf6u32.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Use the new preferred low level option for configuring the
> QMP service in libqtest and the python Machine class used
> by tests. This will avoid triggering deprecation warnings
> after the subsequent commit.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Tested-by: Peter Krempa <pkrempa@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  python/qemu/machine/machine.py | 4 ++--
>  tests/qtest/libqtest.c         | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine=
.py
> index ebb58d5b68..5f4845f5fb 100644
> --- a/python/qemu/machine/machine.py
> +++ b/python/qemu/machine/machine.py
> @@ -304,8 +304,8 @@ def _base_args(self) -> List[str]:
>                  )
>              else:
>                  moncdev =3D f"socket,id=3Dmon,path=3D{self._monitor_addr=
ess}"
> -            args.extend(['-chardev', moncdev, '-mon',
> -                         'chardev=3Dmon,mode=3Dcontrol'])
> +            args.extend(['-chardev', moncdev, '-object',
> +                         'monitor-qmp,id=3Dqmp,chardev=3Dmon'])
>=20=20
>          if self._machine is not None:
>              args.extend(['-machine', self._machine])
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 4e22c66b75..c33c799c92 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -460,7 +460,7 @@ gchar *qtest_qemu_args(const char *extra_args)
>                        "-qtest unix:%s "
>                        "-qtest-log %s "
>                        "-chardev socket,path=3D%s,id=3Dchar0 "
> -                      "-mon chardev=3Dchar0,mode=3Dcontrol "
> +                      "-object monitor-qmp,id=3Dqmp0,chardev=3Dchar0 "
>                        "-display none "
>                        "-audio none "
>                        "%s "

Have you considered tests/functional/qemu_test/testcase.py

        if sockpath is not None:
            vm.add_args("-chardev",
                        f"socket,id=3Dbackdoor,path=3D{sockpath},server=3Do=
n,wait=3Doff",
                        "-mon", "chardev=3Dbackdoor,mode=3Dcontrol")

and tests/tcg/{aarch64,arm}/Makefile.softmmu-target

    QEMU_SEMIHOST=3D-serial none -chardev stdio,mux=3Don,id=3Dstdio0 -semih=
osting-config enable=3Don,chardev=3Dstdio0 -mon chardev=3Dstdio0,mode=3Drea=
dline

?


