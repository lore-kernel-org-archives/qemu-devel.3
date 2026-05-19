Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE6ECD5BAB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPO6b-0003H7-Ph; Tue, 19 May 2026 13:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wPO6a-0003Gf-83
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:19:44 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wPO6Y-0000iL-4y
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:19:44 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-67c1e0229acso6434332a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 10:19:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779211180; cv=none;
 d=google.com; s=arc-20240605;
 b=QoJHGw+CfKPrgOVzmv8H4s1dRNGhP5uuOzX5xiXXeGOAGUrLxAocb4KpnEvPlHFD85
 bZU+7M+m+TXmQN1qx8iE2s25GLACxQ8TMbw4PPRVVcrQhVE32FKmDaNNDOwCcD2YO4MR
 VhdoQYZg5NVBH4sFwSBWriA/FDhD/8PRbxHPoKqvFDAXJx6jI6kb/qSvXF4js5xf08GM
 kGR1G/EHtEJ0aKgsRDNMX/ZpDBguNvxnxyEnxjeYL+81BPI1Ff2Z3SP/kKntRpbwEdTQ
 8oGuL95xd9Vj67Qd7kELqwNjDUCCfQyWCeqA4nKdsvc6NwX9IhtlyJz359FVC/e4slkT
 gRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pePZg+beYYp1v51OC15x8bHMaBwYrRb17aSXw9t9xZQ=;
 fh=+s0RiCGaIA/82M19jFqtg+L9HJt6IlJBT/x+CgEREBs=;
 b=d71SDmLqEQeTQBLGJ8ah9C7mwxgStpQ2z2hKz93jyhsq4UC5nkf+c3vPhv+B8mYdXd
 BYRjIoFImfAjhBVmp9dZsYnEubAAdN59rHKRzVTZQ2gk24KUqMJrSbXvVV9NTiP0gCyl
 nbTXacFFwmIgOEgipWUH+bUNeY0Q42L9DK1c1VdFxhI2Dwigid+8oyCQ5U9+MfzUp3Q/
 tw13UbCz8jS+I39wVIdMt14uqfoR08xO+tpWK5B786UIznkiP9tkSKbeFaSYGZbvmlBS
 dKl/JhahjU5e7s9BnpicXje6YHypQ+9CqM1YesoLqECn5I80bcSDyAwuKfXFPDPOQcVu
 9gyA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779211180; x=1779815980; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pePZg+beYYp1v51OC15x8bHMaBwYrRb17aSXw9t9xZQ=;
 b=hcOFQ9PjFxTCiel3KbOC+s6dytJlEPX6BMPxNPZBQwwypSQQ14lwwvV2KKcrsQTfSI
 vD9tUl+haUIFGOZL/o0HL/50RhClzgZ28pgGzkFk93dCBJxKQ+vZEiXydTpnVT3npWV+
 2QaC9j5HhEQV/6hr3Gy9nmSZLDOUVExklRGWWRzhW2owAvmKFB5UR5XuasBUyc2ilDgO
 m0BlsKUzbeR/BGohzk7MH12HAlZii1OLFXpCokwFFiXsPX3GT0oWdZKVRT8E1w9fI6Pr
 kmfsE+TEqXMX3iM3IqMBVluaEJtl9L3rTJUb6CRLPU+RkUwTlHM8L5waF3Tt46mQT81i
 DwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779211180; x=1779815980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pePZg+beYYp1v51OC15x8bHMaBwYrRb17aSXw9t9xZQ=;
 b=McuoFoqKudEwXvzpOVHlou65tlzCopK4z9sJwWVTTOu44+Eej3vzbICjBR0l+jqslS
 r9uWvDM+ZqdrGe1t1Yo99njNC0aQ6YOW/CAAgaUo75l15oWuQTw4oWO6Xdlokp/F3YPM
 Tojuh0t7tSdba0u1SyInjdWeJ8vdaegAqbg4FcMuqyDs2+G5TWQt6XsrcQQFTtR6uKY4
 +BLdT8VVAfhSkLul9GhRnsz0wL2JkWHJo+PquaSnKTI879eK4lfCpjhcvrY8208srcRi
 cF6EqrnF0k8F90nxs20CWjv3OUHXNVjCBP7pz6d6+uDbOox2Iih9SUjeqp34ahnMIN6L
 92pA==
X-Gm-Message-State: AOJu0Yx7X52/aEcgUqBk6H45Zg35LRS0l9SDSsJ1jK1CCwv/TtqcXDHO
 07c/ZrpytUEtD7GUbCE2jf/giDdTGTBNV1gl31D12AV/OMFriFuoFfvmdTZ0eMMLnc9hfQDumKB
 Wluf+NLjyN4Faj8W2Obh+qicKLN9hIWc=
X-Gm-Gg: Acq92OF4dZQRIdUnzey1ljxh4Ouwb5tLSSWl+zK/Ssfm3eNcw9pWFkzJcMVRQK5pFWc
 v4CHG1lNpaOMvcYuaZgyIXaUvT/TfSmkIoGMAFUYANu8yGwJRDY9IeRgCUQspNpF+mykMx/84zA
 I/cCKJmdA3Vxo6bcXAtgDCVD/anHFVoVfzTZsXoP5QVULu+A/rRGJ896aiqPMbJHLGdAd46OAeN
 bgPPTLvXO/lR3HnWGKTTFWcrLk6MbnzGInp4gdfaVc47ot+h7I4lhwkP9anICesyvUg1ymaYMvC
 n1TNPV+d/Yr8kuHWKCCRRKwlaoukeU03j8lStLqY7ZqPa0kflRPa
X-Received: by 2002:a05:6402:13c1:b0:67c:d93d:89ce with SMTP id
 4fb4d7f45d1cf-683bd99e2cfmr10379100a12.23.1779211179680; Tue, 19 May 2026
 10:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260519125153.1015315-1-berrange@redhat.com>
In-Reply-To: <20260519125153.1015315-1-berrange@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 19 May 2026 13:19:27 -0400
X-Gm-Features: AVHnY4LwQT7CYYVRxRW73CSrqFKB13xmWSgcK5M8dlC8LdiJXaIFYD7GS2mm8IU
Message-ID: <CAJSP0QXQgmWB9bH_Bc2jYDk_=v0oF55crwQD-qV--8u_Uc8iUg@mail.gmail.com>
Subject: Re: [PULL 00/28] Misc patchesfor python, iotests, qom, crypto & io
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
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

On Tue, May 19, 2026 at 8:52=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> The following changes since commit ac6721b88df944ade0048822b2b74210f543d6=
56:
>
>   Merge tag 'vhost-user-rtc-pr-1' of https://gitlab.com/epilys/qemu into =
staging (2026-05-16 17:37:33 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/berrange/qemu tags/misc-next-pull-request
>
> for you to fetch changes up to d92ae44c28906a219e4c8e4ee8929e5fcfb2d32c:
>
>   qom: drop user_creatable_add_type method (2026-05-18 18:23:34 +0100)
>
> ----------------------------------------------------------------
> Misc patches for python, iotests, qom, crypto & io
>
>  * Bump python-qemu-qmp to 0.6.0
>  * Fix client side anoymous TLS credentials
>  * Fix return value semantics for qio_channel_flush
>  * Add ID validation of internal QOM constructor
>  * Fix ability to create internal QOM objects
>    without a parent
>  * Merge user creatable object constructor into
>    main QOM file
>  * Print reason for skipping I/O tests
>  * Remove redundant meson suits for I/O tests
>  * Add I/O tests in meson for NBD and LUKS
>  * Expose make targets for all block driver I/O tests
>  * Run I/O tests for 10 block drivers in GitLab CI
>  * Fix sudo check for LUKS I/O test
>  * Mark I/O test 185 as flaky
>  * Ensure stable sorting for mtest2make output
>
> ----------------------------------------------------------------

The following vfio_user_client tests are failed:
https://gitlab.com/qemu-project/qemu/-/jobs/14442956771
https://gitlab.com/qemu-project/qemu/-/jobs/14442956762
https://gitlab.com/qemu-project/qemu/-/jobs/14442956764

Please take a look. The tests passed when I dropped your pull request
from the staging tree, but I'm not sure what caused the failures.

If you need to change something, please send a v2 pull request.

If you cannot reproduce the failure, please let me know.

Thanks,
Stefan

>
> Daniel P. Berrang=C3=A9 (26):
>   crypto: fix client side anonymous TLS credentials
>   gitlab: ensure all meson jobs capture build/meson-logs by default
>   iotests: print reason when I/O test is skipped in TAP mode
>   iotests: remove redundant meson suite for iotests
>   iotests: ensure all qcow2 I/O tests are able to be run via make
>   scripts/mtest2make: ensure output has stable sorting
>   scripts/mtest2make: support optional tests grouping
>   iotests: add a meson suite / make target per block I/O tests format
>   docs/devel/testing: expand documentation for 'make check-block'
>   iotests: add nbd and luks to the I/O test suites
>   iotests: use 'driver' as collective term for either format or protocol
>   iotests: validate dmsetup result in test 128
>   iotests: fix check for sudo access in LUKS I/O test
>   iotests: mark 185 as a flaky test
>   gitlab: add jobs for thorough block tests
>   gitlab: remove I/O tests from build-tcg-disabled job
>   qom: add trace events for object/property lifecycle
>   qom: validate ID format when creating objects
>   qom: make errp last param in methods taking va_list
>   qom: shorten name of object_set_properties_from_keyval
>   qom: have object_set_props_keyval return bool
>   qom: move object_set_prop_keyval into object.c
>   qom: add object_new_with_props_from_qdict
>   qom: fix ability to create objects without a parent
>   qom: allow object_new_with_prop* to trigger module loading
>   qom: drop user_creatable_add_type method
>
> John Snow (1):
>   python: bump qemu.qmp to v0.0.6
>
> Tejus GK (1):
>   io: invert the return semantics of qio_channel_flush
>
>  .gitlab-ci.d/buildtest-template.yml           |  30 ++-
>  .gitlab-ci.d/buildtest.yml                    |  27 +-
>  authz/listfile.c                              |   4 +-
>  crypto/tlscredsanon.c                         |   2 +
>  docs/devel/testing/main.rst                   |  26 +-
>  include/io/channel-socket.h                   |   6 +-
>  include/io/channel.h                          |   4 +-
>  include/qom/object.h                          | 121 +++++++--
>  include/qom/object_interfaces.h               |  18 --
>  io/channel-socket.c                           |  16 +-
>  python/scripts/vendor.py                      |   4 +-
>  ...ny.whl =3D> qemu_qmp-0.0.6-py3-none-any.whl} | Bin 72263 -> 72379 byt=
es
>  pythondeps.toml                               |   2 +-
>  qom/object.c                                  | 230 ++++++++++++++++--
>  qom/object_interfaces.c                       | 101 +-------
>  qom/trace-events                              |  12 +-
>  scripts/mtest2make.py                         |  30 ++-
>  system/qdev-monitor.c                         |   4 +-
>  system/vl.c                                   |   7 +-
>  tests/Makefile.include                        |   3 +-
>  tests/qemu-iotests/128                        |   6 +
>  tests/qemu-iotests/149                        |  13 +-
>  tests/qemu-iotests/185                        |   1 +
>  tests/qemu-iotests/common.rc                  |  16 ++
>  tests/qemu-iotests/meson.build                |  65 ++++-
>  tests/qemu-iotests/testrunner.py              |   2 +-
>  tests/unit/check-qom-proplist.c               |  97 ++++++--
>  tests/unit/test-crypto-tlssession.c           | 120 ++++++++-
>  28 files changed, 712 insertions(+), 255 deletions(-)
>  rename python/wheels/{qemu_qmp-0.0.5-py3-none-any.whl =3D> qemu_qmp-0.0.=
6-py3-none-any.whl} (64%)
>
> --
> 2.54.0
>
>

