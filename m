Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A652C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 11:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGzyR-00061E-Ij; Tue, 11 Jun 2024 07:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1sGzyP-00060U-W1
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 07:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1sGzyO-00009T-7Q
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 07:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718106448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WXohnI87Xn+7yJvuIwYobxyqBo1gXB6rQaVAXUdKtnU=;
 b=UrElnlmrUQv8NyqF9ViG/FHBUbdjhxot8EgvN02B1Z52SU0I31HIhjH2FslNKDW3GeEL3D
 /3PVvz4lQxfEyHXomTnVXsXnLe8cdXA7nZZT5VCB3KmpSYdJfljd+cwE+ChlpC6Z8MChmZ
 bhCwWoKWl2DQnhNvd2UOIgRrW9+09P0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-VoFbJyX3NTGJO_YbU0dlQQ-1; Tue, 11 Jun 2024 07:47:27 -0400
X-MC-Unique: VoFbJyX3NTGJO_YbU0dlQQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ebf0863242so8236831fa.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 04:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718106446; x=1718711246;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WXohnI87Xn+7yJvuIwYobxyqBo1gXB6rQaVAXUdKtnU=;
 b=M/A6L2W0JuZyNsMqAvosuOXIDkOdPVGaUmxD/DxUbrDnXaZtXL36Y2Kkiqolq+wqFU
 hqrwX8zAdVXL/31vgzySTdkoH5j7wvVJRANGeENfmPbnkx5ukJQ4BvZ2gv0N/DAzkr8A
 NPo6bNGg/U6/WHNaqEJtLxFVb6tgCwdG2VOjbzg7iTBamX5vsF3ubWunFjz8p+yECoKi
 zoUxZszmVixrHeq0CbcblC5f2gqnzLXmoy8jvUMe3/qNhsiXn1C18JeJ8vSGMhSV7nXQ
 DhfUipVJ4Lt7rn1m/LrfQXaFdCGHBUihm41v3JpAvPDTWM8I9DWnVj3+qzmZUqsvr+SO
 yF6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4/ErHrukaTVJt7cIlaBnJ0JkbI6cPPHs6iZ/sC45OKjcJ2hwXMNAA1/pLiez95O5T9VrGdAQSB4VUkXbBy/V3i0wGU1s=
X-Gm-Message-State: AOJu0Ywd/IZrOSm9HPA+4k6dESVP3c9L3KsoLlfzJuF/CUmOE3P1asDc
 wS5FD3sI6IYph7DztlT6gW0cH7keaM6zyWai4VbtgOTzsaGuR2Dol2v6T/7vInQ4ohX7bQZEVo7
 VcbDMl8CWQb68KLZRlJmQ7/thdDss0IM4odTxjM1Fj99OkO9KzVis8gn6b/UmoEWlFLyDkNpVAi
 bndUrYZCP8bHjkfAkckT8QBxwAw+E=
X-Received: by 2002:a2e:97cd:0:b0:2eb:e6ff:7ddf with SMTP id
 38308e7fff4ca-2ebe6fff32bmr34159611fa.25.1718106445860; 
 Tue, 11 Jun 2024 04:47:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHzui7Hx33Fiu+tjaET/PjBI6BFagEPHdsIeitKHPPSe+akP7wdv6Er5d9d8I1ait0S4GKplpz6sS3VCt9SfY=
X-Received: by 2002:a2e:97cd:0:b0:2eb:e6ff:7ddf with SMTP id
 38308e7fff4ca-2ebe6fff32bmr34159441fa.25.1718106445438; Tue, 11 Jun 2024
 04:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240604062133.40637-1-anisinha@redhat.com>
In-Reply-To: <20240604062133.40637-1-anisinha@redhat.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Tue, 11 Jun 2024 13:47:14 +0200
Message-ID: <CAMXpfWs2WnZ91h=KrEuY3SbVts1=jOo4rRH7gfkQiCtAMEG2HA@mail.gmail.com>
Subject: Re: [PATCH] qtest/x86/numa-test: do not use the obsolete 'pentium' cpu
To: Ani Sinha <anisinha@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch has been successfully tested. After running the numa-test
binary, now -cpu max is being used instead of the obsolete 'pentium'
one.

# starting QEMU: exec /home/qemu/build/qemu-system-x86_64 -qtest
unix:/tmp/qtest-16915.sock -qtest-log /dev/null -chardev
socket,path=3D/tmp/qtest-16915.qmp,id=3Dchar0 -mon
chardev=3Dchar0,mode=3Dcontrol -display none -audio none -object
memory-backend-ram,id=3Dram,size=3D128M -cpu max -machine
smp.cpus=3D8,smp.sockets=3D2,smp.cores=3D2,smp.threads=3D2 -numa
node,nodeid=3D0,memdev=3Dram -numa node,nodeid=3D1 -numa
cpu,node-id=3D1,socket-id=3D0 -numa cpu,node-id=3D0,socket-id=3D1,core-id=
=3D0
-numa cpu,node-id=3D0,socket-id=3D1,core-id=3D1,thread-id=3D0 -numa
cpu,node-id=3D1,socket-id=3D1,core-id=3D1,thread-id=3D1 -accel qtest

Tested-by: Mario Casquero <mcasquer@redhat.com>


On Tue, Jun 4, 2024 at 8:24=E2=80=AFAM Ani Sinha <anisinha@redhat.com> wrot=
e:
>
> 'pentium' cpu is old and obsolete and should be avoided for running tests=
 if
> its not strictly needed. Use 'max' cpu instead for generic non-cpu specif=
ic
> numa test.
>
> CC: thuth@redhat.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  tests/qtest/numa-test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
> index 7aa262dbb9..f01f19592d 100644
> --- a/tests/qtest/numa-test.c
> +++ b/tests/qtest/numa-test.c
> @@ -125,7 +125,8 @@ static void pc_numa_cpu(const void *data)
>      QTestState *qts;
>      g_autofree char *cli =3D NULL;
>
> -    cli =3D make_cli(data, "-cpu pentium -machine smp.cpus=3D8,smp.socke=
ts=3D2,smp.cores=3D2,smp.threads=3D2 "
> +    cli =3D make_cli(data,
> +        "-cpu max -machine smp.cpus=3D8,smp.sockets=3D2,smp.cores=3D2,sm=
p.threads=3D2 "
>          "-numa node,nodeid=3D0,memdev=3Dram -numa node,nodeid=3D1 "
>          "-numa cpu,node-id=3D1,socket-id=3D0 "
>          "-numa cpu,node-id=3D0,socket-id=3D1,core-id=3D0 "
> --
> 2.42.0
>
>


