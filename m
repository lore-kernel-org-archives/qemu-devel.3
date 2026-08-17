Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC8EC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvyRt-0005HI-9N; Mon, 17 Aug 2026 10:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wvyRS-0005AG-EM
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:36:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wvyRO-0007sE-52
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786977351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=srK9rCY+p4HTDZdTXJpnt6fS/lC7pnNa3yXIsVmx6BQ=;
 b=JEfAm6dULixArKjbs2WND0lmiAvD6rnJY2zH52DDIWLvuzzHDdkFIgGGgLG65u68z3X9u2
 G/FmI10v2o5V4xrcTJ39Ut7Wo8QFSLrjzGqU2LBThKDKjelfm6hKMc01hKRaAETVg+pp2S
 NBgj3Shc4aRk4NvzefMRsiu7dZXBm6Y=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-APaOjNJ5Op-3OCP-o93EIA-1; Mon, 17 Aug 2026 10:35:49 -0400
X-MC-Unique: APaOjNJ5Op-3OCP-o93EIA-1
X-Mimecast-MFC-AGG-ID: APaOjNJ5Op-3OCP-o93EIA_1786977349
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84c4cd31b51so4957215b3a.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 07:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786977348; x=1787582148; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=srK9rCY+p4HTDZdTXJpnt6fS/lC7pnNa3yXIsVmx6BQ=;
 b=PCwvy0C/i+7UDC3MYDL/PDEIL7W3iShKdYLMuYsx4dOwsszEXFF+nnNqjssCaj8MQr
 K3oAtxqdoxKK/jfuU/DCzTm9GlMAHBvlHSpN9LDBziEU345pkCaSWIUCeUQk/CjimZTU
 6+7h/jsyQuSPYo40h9SjukCMbRUDFB+b7W9HtKgzyQTBGAmirtq1KK6873/zODCcWeoQ
 K3Ntyox3iFAZ4tkMib+LXqdddeRMFa375psqknI3wg89Tg5SgQG91VHeX9N8xzdcUzwc
 cuuCqUWTNaiQ46GdtklThnr3fTzMc+dXLF9FuVmrM7Fs9UwRwC11Ks+8F1gQm8Q0hYbc
 7/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786977348; x=1787582148;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=srK9rCY+p4HTDZdTXJpnt6fS/lC7pnNa3yXIsVmx6BQ=;
 b=j0hcDIwG/vk0P5vxdQOwinxhWS1I/VsAVvWBp4cK2UCKJY7t8uUQLv6tGxySLmLr33
 S1Bbvk8Rx/BYSS4zEyG6mXtRuQLIuAuwqB88l4gs0eyK/W4eBn0gBX/0vuyaHIQIz6no
 s00hZtLXbM8NsaVBDuysSO2j2DRuGwxIpjD76PaTbx48Gxt8E+RaQXqEoZnyuWK1Mz+h
 eTBOQE6tlmXuVDvKeG48TJG86CR14ORX7oOkfCBOU44/UFVBpRH0zZBF1mhZAgh3Icmq
 lzXrVQ9tukx7U2kW+6cGGeSZ2OyqSfvzKDGuhWwGFIMy2+jLKy5LOaLuFjjAicWpwdkJ
 JGHQ==
X-Gm-Message-State: AOJu0YyZbAyWkMflzNfkUKg1GW7sg64RkKgK2OdH0TnTotO7sQk4Yj/y
 2IbGtqN8h2HYGO3CETLIdTtTxJiYpvh7EEtJrFcymC2V78O3I1BW9PpcwC9UxDRwRQ0Sr/ht/UL
 TcZKZAt+vQ+RPiU9uGvT5NwEawmDjO/7trfkTlW406EgCfgDrnhbB/fh/
X-Gm-Gg: AR+sD13M7UPXxatKOrToOwpvZCxUbjQzY9GgZZIBqNqjzHz7YDuRHWpFPpwZSZpmY5C
 I3ZdjGAq1GXKt4WtsavxpeeW5lYZhmBT4OtXpAfJVJrMNJx/3QI28gl2hcrsLaq086lonYdp6CX
 oE6gVmtT9kOmjnIiK9Adx9iOex+PcTC6A4dJ7dxuIEuLbLfDba0UXQx13SDg+a0nECtcpo+maew
 MWnp4m9oZba5tSfB/nUq+iAxTYpBwVF1S9RdhPZA0wX97BpvyFxE9/+hfac/WcHEmBXnboWkLLj
 8vhnFoplUnM/UZcwfMfrNTVelpv0AMFxE364aLKVJef36sD9R8T8ZrODofI4Z6klH3Ef5t1HEoG
 jqWtaLCN4Ld7LSQuZAeghOHSEQJjK5NO4DmOOhErtUSIxjOzNEc52kQ==
X-Received: by 2002:a05:6a00:4f96:b0:84e:c851:a058 with SMTP id
 d2e1a72fcca58-84fc7c1d1e1mr28587591b3a.10.1786977348538; 
 Mon, 17 Aug 2026 07:35:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:4f96:b0:84e:c851:a058 with SMTP id
 d2e1a72fcca58-84fc7c1d1e1mr28587550b3a.10.1786977347978; 
 Mon, 17 Aug 2026 07:35:47 -0700 (PDT)
Received: from smtpclient.apple ([106.219.133.98])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b404944bsm695851b3a.23.2026.08.17.07.35.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Aug 2026 07:35:47 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH] test/qtest/launchupdate: add another test to exercise
 load and set host igvm
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <D1CE7121-3EFF-4A2D-B501-4AB19660244C@redhat.com>
Date: Mon, 17 Aug 2026 20:05:33 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FA941C81-E6AC-4F36-B1D2-69CD51C8F346@redhat.com>
References: <20260815042845.184329-1-anisinha@redhat.com>
 <CAK3XEhO3d1C02AkywDoU1OvbMJGyDPmprYcfJk0LQa+agpG_Ow@mail.gmail.com>
 <D1CE7121-3EFF-4A2D-B501-4AB19660244C@redhat.com>
To: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 17 Aug 2026, at 12:13=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
>=20
>=20
>> On 15 Aug 2026, at 10:39=E2=80=AFAM, Ani Sinha <anisinha@redhat.com> =
wrote:
>>=20
>> On Sat, Aug 15, 2026 at 9:59=E2=80=AFAM Ani Sinha =
<anisinha@redhat.com> wrote:
>>>=20
>>> A new test is added that loads a new IGVM bundle and sets host igvm
>>> ctrl at the same time. The expected behavior is that first reset =
will load
>>> the passed IGVM. The second reset will restore the original host =
provided IGVM.
>>> This test exercizes this functionality.
>>>=20
>>> Some refactoring is also done at the same time to re-use common =
operations from
>>> within multiple test routines.
>>=20
>> This applies on top of the v5 patchset here
>> https://lists.gnu.org/archive/html/qemu-devel/2026-08/msg02509.html
>=20
> Tested this patch on CoCo and the test runs fine there =E2=80=A6
>=20
> serial console file is /tmp/launchupdate-qtest-serial-sKLAJU3
> # starting QEMU: exec ./qemu-system-x86_64 -qtest =
unix:/tmp/qtest-896542.sock -qtest-log /dev/null -chardev =
socket,path=3D/tmp/qtest-896542.qmp,id=3Dchar0 -object =
monitor-qmp,id=3Dqmp0,chardev=3Dchar0 -display none -audio none =
-run-with exit-with-parent=3Don -machine =
q35,igvm-cfg=3Digvm0,confidential-guest-support=3Dlsec0 -m 1G -accel kvm =
-device vm-launch-update -chardev =
file,id=3Dserial0,path=3D/tmp/launchupdate-qtest-serial-sKLAJU3 -serial =
chardev:serial0 -object =
igvm-cfg,id=3Digvm0,file=3Dtests/data/igvm/snptest-nohello.igvm -object =
'{"qom-type":"sev-snp-guest","id":"lsec0","cbitpos":51,"reduced-phys-bits"=
:1,"policy":196608}'  -accel qtest
> initially booted with host igvm
> guest paddr: 100000  igvm size: 195048
> writing igvm file into the guest memory
> tell hypervisor where igvm is loaded in guest memory
> qemu-system-x86_64: info: vmlaunchupdate: new IGVM context set.
> resetting the virtual machine. This should load user provided igvm.
> qemu-system-x86_64: info: virtual machine state has been rebuilt with =
new guest file handle.
> qemu-system-x86_64: info: vmlaunchupdate: next reset will use host =
igvm
> hello world found on console
> Now resetting again in order to reset to host igvm
> qemu-system-x86_64: info: virtual machine state has been rebuilt with =
new guest file handle.
> qemu-system-x86_64: info: restoring original host IGVM: =
tests/data/igvm/snptest-nohello.igvm
> qemu-system-x86_64: info: vmlaunchupdate: host IGVM context set.
> booted with host igvm
> ok 5 /vm-launch-update/ctrl_set_once
> # slow test /vm-launch-update/ctrl_set_once executed in 4.81 secs
> # End of vm-launch-update tests
>=20

Squashed into patchset =
https://lists.gnu.org/archive/html/qemu-devel/2026-08/msg03368.html


>>=20
>>>=20
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>


