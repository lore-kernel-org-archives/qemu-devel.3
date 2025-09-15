Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECFECAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 10:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy6I9-0003Yq-DY; Mon, 15 Sep 2025 06:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy6Hy-0003Xh-45
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:18:26 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy6Hr-0007gP-Bm
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:18:25 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3e9a9298764so987462f8f.2
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 03:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757931491; x=1758536291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2ck9EsIZdxLpCL1f1+FrnvhFEOA2XCCEgsiWF/xBVw=;
 b=p8qD6UlDt4Bj6C3A1evyStz6MOyHHdrf27DeQ57aqxuElCOTqadNRIzN2Lybny9tZf
 oJqqgFhocihkrCDG8W2pOzYDLomfTuZfWRj9OKil59es/YCXcQIEJcXxd/Mc50U0R78G
 xJ3wlX6YWFn+Mwfbi5AtQkAkIKUWPbh/Ev6C3LzWE3kAOFc110ysz0X4YoEiu0PrW8Ut
 B43+e1EetTUNxU7ClNYlPhZSE66U6HKJ7CMWC9MSSp1GJjcTPkWb23YwDB+OjQlENfpO
 NdgslpiZGaMa0/Sj+49MaBbEspTt+UKJ06Qa++MAPHpIyQUtSQUXpqLq+Nh4UeaXxNju
 UoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757931491; x=1758536291;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E2ck9EsIZdxLpCL1f1+FrnvhFEOA2XCCEgsiWF/xBVw=;
 b=Z8RG76jkavqVVSFp7y9u1e3awquO3jxcujQ+6at4u8gfg0p5fDZHrHM2YIxTelqKN9
 o5vkqZZ/Q+swNGm1o+2L44LF+KPRQcEMe+9Ac6NvK0C1c455F8D5uZRnNRIVsZ5BmEXp
 B8EmWifF9hqu4QaG2cn2lSISW8RPKWuBPEymmVZbL9LD+PqHezyVklynBLbJQdEY7SXz
 R25QJ2DWG7CtXsxLdeBnw+9BoPrqfjUdhe7xSCM2wTldbLm1ojQUvcymOp/C8TycE0zi
 K0Evgo3WzYrhyIHuJERWTqBKrRPnW2bbpnHEvL/m2OKZTbUpZrlxfuJF7KJHHZfN8Vct
 MvxA==
X-Gm-Message-State: AOJu0YySPwA9YGN61gbz4dPgbJMoO/PzILiH0sg9sGzvaedBVn0LdRCA
 HadX3YBVUJpcOfAMK3C+HTYKXO0F9g8umB+ecGl+AzAHQJog1qtu3Y6I1z/qRzV8jT2YRNVzPiw
 GbwYvyPo=
X-Gm-Gg: ASbGncuHavF5QkNDcCn49kJSM3gkRBc4gbHzW769mFXY8d3MNzDuskBP5lL9/4IDuqC
 9qEz8fZ3o0+n/pOIFse/gPAVnpturQtGIG3h4fWlJxSJp5vN3vsLqsG2v5DJPoZpMe4hjP+4u6J
 3CQI6deQ20sXBcQbAgrfquGdsrFWXdFb8iS33HUJ3zN6P4NEmBwzqOy1SFyp8Ka6hapxuJjjqxK
 QMgkrjF/+HA9BrMYqHi1swuG3lluxTQnTMwYkstPUf3bpeM9Uj53wsi/KP24SSdtbjooqY4ROOC
 npl8jO6EsQvF92VeNgZVTyedDgveWYS45jOlvQFLC4U8b5jWxYrwZpN3GiAcscA16mrlomPslnm
 wUYHC5j7xnJK7Xj7EwZeNnkA=
X-Google-Smtp-Source: AGHT+IHdB/rLjOnvKoDCo+Dyo/lcEGvQLm/ijcjxK5Z8vSJidM8apnlGWbJi5uAORoivGA5AT1nVmQ==
X-Received: by 2002:a05:6000:2212:b0:3e7:471c:b11a with SMTP id
 ffacd0b85a97d-3e7659c44d9mr8159976f8f.19.1757931491348; 
 Mon, 15 Sep 2025 03:18:11 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7607cd4cdsm17252945f8f.37.2025.09.15.03.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 03:18:10 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C85815F867;
 Mon, 15 Sep 2025 11:18:09 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 4/6] tests/functional: drop datadrainer class in reverse
 debugging
In-Reply-To: <20250912182200.643909-5-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 12 Sep 2025 19:21:58
 +0100")
References: <20250912182200.643909-1-berrange@redhat.com>
 <20250912182200.643909-5-berrange@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 15 Sep 2025 11:18:09 +0100
Message-ID: <878qigrpcu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The reverse debugging test uses the avocado datadrainer class to
> create a background thread that reads from the console socket and
> dumps it via python logger.
>
> Most tests log console output as a side effect of doing calls
> to match strings, but this test never tries to match anything.
>
> This isn't critical, so just drop the functionality.

We do end up with zero length logs for all console output although I don't =
know
if we got that far before:

  =E2=9E=9C  find tests/functional/ -iwholename "*reverse_debug*log" -exec =
ls -l {} \;
  -rw-rw-r-- 1 alex alex 3196 Aug 26 10:18 tests/functional/aarch64/test_aa=
rch64_reverse_debug.ReverseDebugging_AArch64.test_aarch64_virt/base.log
  -rw-rw-r-- 1 alex alex 0 Aug 26 10:18 tests/functional/aarch64/test_aarch=
64_reverse_debug.ReverseDebugging_AArch64.test_aarch64_virt/record.log
  -rw-rw-r-- 1 alex alex 0 Aug 26 10:18 tests/functional/aarch64/test_aarch=
64_reverse_debug.ReverseDebugging_AArch64.test_aarch64_virt/console.log
  -rw-rw-r-- 1 alex alex 0 Aug 26 10:18 tests/functional/aarch64/test_aarch=
64_reverse_debug.ReverseDebugging_AArch64.test_aarch64_virt/replay.log
  -rw-rw-r-- 1 alex alex 5968 Sep 15 11:09 tests/functional/aarch64/test_re=
verse_debug.ReverseDebugging_AArch64.test_aarch64_virt/base.log
  -rw-rw-r-- 1 alex alex 0 Sep 15 11:09 tests/functional/aarch64/test_rever=
se_debug.ReverseDebugging_AArch64.test_aarch64_virt/record.log
  -rw-rw-r-- 1 alex alex 0 Sep 15 11:09 tests/functional/aarch64/test_rever=
se_debug.ReverseDebugging_AArch64.test_aarch64_virt/console.log
  -rw-rw-r-- 1 alex alex 0 Sep 15 11:09 tests/functional/aarch64/test_rever=
se_debug.ReverseDebugging_AArch64.test_aarch64_virt/replay.log
  -rw-rw-r-- 1 alex alex 2656 Aug 26 10:04 tests/functional/ppc64/test_ppc6=
4_reverse_debug.ReverseDebugging_ppc64.test_ppc64_pseries/base.log
  -rw-rw-r-- 1 alex alex 258 Aug 26 10:04 tests/functional/ppc64/test_ppc64=
_reverse_debug.ReverseDebugging_ppc64.test_ppc64_pseries/record.log
  -rw-rw-r-- 1 alex alex 0 Aug 26 10:04 tests/functional/ppc64/test_ppc64_r=
everse_debug.ReverseDebugging_ppc64.test_ppc64_pseries/console.log
  -rw-rw-r-- 1 alex alex 516 Aug 26 10:04 tests/functional/ppc64/test_ppc64=
_reverse_debug.ReverseDebugging_ppc64.test_ppc64_pseries/replay.log
  -rw-rw-r-- 1 alex alex 2620 Sep  4 18:03 tests/functional/ppc64/test_reve=
rse_debug.ReverseDebugging_ppc64.test_ppc64_pseries/base.log
  -rw-rw-r-- 1 alex alex 258 Sep  4 18:03 tests/functional/ppc64/test_rever=
se_debug.ReverseDebugging_ppc64.test_ppc64_pseries/record.log
  -rw-rw-r-- 1 alex alex 0 Sep  4 18:03 tests/functional/ppc64/test_reverse=
_debug.ReverseDebugging_ppc64.test_ppc64_pseries/console.log
  -rw-rw-r-- 1 alex alex 516 Sep  4 18:03 tests/functional/ppc64/test_rever=
se_debug.ReverseDebugging_ppc64.test_ppc64_pseries/replay.log
  -rw-rw-r-- 1 alex alex 2656 Aug 26 10:04 tests/functional/ppc64/test_ppc6=
4_reverse_debug.ReverseDebugging_ppc64.test_ppc64_powernv/base.log
  -rw-rw-r-- 1 alex alex 0 Aug 26 10:04 tests/functional/ppc64/test_ppc64_r=
everse_debug.ReverseDebugging_ppc64.test_ppc64_powernv/record.log
  -rw-rw-r-- 1 alex alex 0 Aug 26 10:04 tests/functional/ppc64/test_ppc64_r=
everse_debug.ReverseDebugging_ppc64.test_ppc64_powernv/console.log
  -rw-rw-r-- 1 alex alex 0 Aug 26 10:04 tests/functional/ppc64/test_ppc64_r=
everse_debug.ReverseDebugging_ppc64.test_ppc64_powernv/replay.log
  -rw-rw-r-- 1 alex alex 4810 Sep 15 11:09 tests/functional/ppc64/test_reve=
rse_debug.ReverseDebugging_ppc64.test_ppc64_powernv/base.log
  -rw-rw-r-- 1 alex alex 0 Sep 15 11:09 tests/functional/ppc64/test_reverse=
_debug.ReverseDebugging_ppc64.test_ppc64_powernv/record.log
  -rw-rw-r-- 1 alex alex 0 Sep 15 11:09 tests/functional/ppc64/test_reverse=
_debug.ReverseDebugging_ppc64.test_ppc64_powernv/console.log
  -rw-rw-r-- 1 alex alex 118 Sep 15 11:11 tests/functional/ppc64/test_rever=
se_debug.ReverseDebugging_ppc64.test_ppc64_powernv/replay.log
  -rw-rw-r-- 1 alex alex 2642 Aug 26 10:05 tests/functional/x86_64/test_x86=
_64_reverse_debug.ReverseDebugging_X86_64.test_x86_64_pc/base.log
  -rw-rw-r-- 1 alex alex 0 Aug 26 10:05 tests/functional/x86_64/test_x86_64=
_reverse_debug.ReverseDebugging_X86_64.test_x86_64_pc/record.log
  -rw-rw-r-- 1 alex alex 0 Aug 26 10:05 tests/functional/x86_64/test_x86_64=
_reverse_debug.ReverseDebugging_X86_64.test_x86_64_pc/console.log
  -rw-rw-r-- 1 alex alex 0 Aug 26 10:05 tests/functional/x86_64/test_x86_64=
_reverse_debug.ReverseDebugging_X86_64.test_x86_64_pc/replay.log
  -rw-rw-r-- 1 alex alex 5317 Sep 15 11:09 tests/functional/x86_64/test_rev=
erse_debug.ReverseDebugging_X86_64.test_x86_64_pc/base.log
  -rw-rw-r-- 1 alex alex 0 Sep 15 11:09 tests/functional/x86_64/test_revers=
e_debug.ReverseDebugging_X86_64.test_x86_64_pc/record.log
  -rw-rw-r-- 1 alex alex 0 Sep 15 11:09 tests/functional/x86_64/test_revers=
e_debug.ReverseDebugging_X86_64.test_x86_64_pc/console.log
  -rw-rw-r-- 1 alex alex 0 Sep 15 11:09 tests/functional/x86_64/test_revers=
e_debug.ReverseDebugging_X86_64.test_x86_64_pc/replay.log

>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/functional/reverse_debugging.py | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/tests/functional/reverse_debugging.py b/tests/functional/rev=
erse_debugging.py
> index 1b880cda8f..9c89f5c897 100644
> --- a/tests/functional/reverse_debugging.py
> +++ b/tests/functional/reverse_debugging.py
> @@ -35,8 +35,6 @@ class ReverseDebugging(LinuxKernelTest):
>      endian_is_le =3D True
>=20=20
>      def run_vm(self, record, shift, args, replay_path, image_path, port):
> -        from avocado.utils import datadrainer
> -
>          logger =3D logging.getLogger('replay')
>          vm =3D self.get_vm(name=3D'record' if record else 'replay')
>          vm.set_console()
> @@ -54,10 +52,6 @@ def run_vm(self, record, shift, args, replay_path, ima=
ge_path, port):
>          if args:
>              vm.add_args(*args)
>          vm.launch()
> -        console_drainer =3D datadrainer.LineLogger(vm.console_socket.fil=
eno(),
> -                                    logger=3Dself.log.getChild('console'=
),
> -                                    stop_check=3D(lambda : not vm.is_run=
ning()))
> -        console_drainer.start()
>          return vm
>=20=20
>      @staticmethod

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

