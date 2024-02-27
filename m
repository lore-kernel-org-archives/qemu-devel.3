Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68E6C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 19:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf31G-0001qD-Bu; Tue, 27 Feb 2024 14:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rf319-0001ou-6m
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 14:21:33 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rf316-0007S9-Tv
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 14:21:30 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33d118a181fso3072867f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 11:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709061687; x=1709666487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKhQrwYf+3+97tWYfLf/kuTzYSj0EdvcbN0cTglaspY=;
 b=qdr/yIB4326x6iKIoTvVSUnGBTn0kY+wwpTnF3rwCpOozFbs5PYg6ghXBPE/rDfSZG
 g1FkKGokeHIRtrHOA1JtCKMXlKU5S0cIS2lBrds7uBTtRg/ehlW1i0HoCYDorJs1dxB0
 meLWu4z69izKn4zalZUyXONPvLp5cseZDDww75uBvUMeN0a2zEdyp1jLWkuNEL0ewfho
 4INU46GVecek8GlUR/kGt8on1oFSJ/y2PC348XQ+C44/pg964ATBrdpBoIcRwSxTErFR
 9h2hIYIjL3O/y7gFZ0Gwe6zz95pWZG/R1NDBs4PIaao/wvZziYk1pDY4tHyipudM5ewO
 Pn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709061687; x=1709666487;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eKhQrwYf+3+97tWYfLf/kuTzYSj0EdvcbN0cTglaspY=;
 b=Un26FUD93IudDTj1PLHLhZw+fYf1/DXXn9sazsQUAmlP7Sg0dr+Y/l4wZqMoqd2CcQ
 wLtPS6We8MH/9FWn78nYZtzHwhWTfzhfUcps86HTl4L7nqRRsJKT6rTDIn9S/GEYGXaS
 8Cv6N6QyJN2kHn87pI7V6ezcIYM9UHuugDmsxIyTDVM7U3sDqLQiBbFJcgjAvygmzUO6
 uJWDrHfUwH3L7O4jZHIHL5QBMeFlw/i98pJJ8dcRKaZUixdzoNEmp2cXJWZ/fvEfhJcO
 JGDrj48sPwPhhb994hmAFL0s/PD8/v/HodKdnGFdFAL/z0BDcr8pJD0QVS6fmFaSghRC
 +K0Q==
X-Gm-Message-State: AOJu0Yx+0bJkm04YYcptGu3E8yQsHz5l3lb5AxxrPq+iFYBiMjKcCXPY
 +6T5kQ1JkUbCQiXw0rZn9hDazLEvO4jrgQYlffzQzJKILAzmIhVW8xVUFr3tv6k=
X-Google-Smtp-Source: AGHT+IFTDGnCFlxPXr6tza3TTB7utY/lE/avSlwqoAfZzLjyMSt76WdDayymAYSLmphSc7lYNpcVXA==
X-Received: by 2002:a5d:6982:0:b0:33d:b2fe:763c with SMTP id
 g2-20020a5d6982000000b0033db2fe763cmr6720868wru.33.1709061686831; 
 Tue, 27 Feb 2024 11:21:26 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t4-20020a0560001a4400b0033d06dfcf84sm12016755wry.100.2024.02.27.11.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 11:21:26 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 363585F79E;
 Tue, 27 Feb 2024 19:21:26 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org,  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>
Subject: Re: [PATCH v3 3/9] tests/avocado: excercise scripts/replay-dump.py
 in replay tests
In-Reply-To: <20240226082945.1452499-4-npiggin@gmail.com> (Nicholas Piggin's
 message of "Mon, 26 Feb 2024 18:29:39 +1000")
References: <20240226082945.1452499-1-npiggin@gmail.com>
 <20240226082945.1452499-4-npiggin@gmail.com>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Tue, 27 Feb 2024 19:21:26 +0000
Message-ID: <87frxdd87d.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Nicholas Piggin <npiggin@gmail.com> writes:

> This runs replay-dump.py after recording a trace, and fails the test if
> the script fails.
>
> replay-dump.py is modified to exit with non-zero if an error is
> encountered while parsing, to support this.
>
> Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  scripts/replay-dump.py         |  6 ++++--
>  tests/avocado/replay_kernel.py | 16 ++++++++++++++++
>  tests/avocado/replay_linux.py  | 15 +++++++++++++++
>  3 files changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
> index b82659cfb6..4ce7ff51cc 100755
> --- a/scripts/replay-dump.py
> +++ b/scripts/replay-dump.py
> @@ -21,6 +21,7 @@
>  import argparse
>  import struct
>  import os
> +import sys
>  from collections import namedtuple
>  from os import path
>=20=20
> @@ -100,7 +101,7 @@ def call_decode(table, index, dumpfile):
>          print("Could not decode index: %d" % (index))
>          print("Entry is: %s" % (decoder))
>          print("Decode Table is:\n%s" % (table))
> -        return False
> +        raise(Exception("unknown event"))
>      else:
>          return decoder.fn(decoder.eid, decoder.name, dumpfile)
>=20=20
> @@ -121,7 +122,7 @@ def print_event(eid, name, string=3DNone, event_count=
=3DNone):
>  def decode_unimp(eid, name, _unused_dumpfile):
>      "Unimplemented decoder, will trigger exit"
>      print("%s not handled - will now stop" % (name))
> -    return False
> +    raise(Exception("unhandled event"))
>=20=20
>  def decode_plain(eid, name, _unused_dumpfile):
>      "Plain events without additional data"
> @@ -434,6 +435,7 @@ def decode_file(filename):
>                                      dumpfile)
>      except Exception as inst:
>          print(f"error {inst}")
> +        sys.exit(1)
>=20=20
>      finally:
>          print(f"Reached {dumpfile.tell()} of {dumpsize} bytes")
> diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel=
.py
> index 10d99403a4..9b3ee6726b 100644
> --- a/tests/avocado/replay_kernel.py
> +++ b/tests/avocado/replay_kernel.py
> @@ -13,6 +13,7 @@
>  import shutil
>  import logging
>  import time
> +import subprocess
>=20=20
>  from avocado import skip
>  from avocado import skipUnless
> @@ -22,6 +23,11 @@
>  from avocado.utils import process
>  from boot_linux_console import LinuxKernelTest
>=20=20
> +from pathlib import Path
> +
> +self_dir =3D Path(__file__).parent
> +src_dir =3D self_dir.parent.parent
> +

Whats this for? It doesn't seem to be used.

>  class ReplayKernelBase(LinuxKernelTest):
>      """
>      Boots a Linux kernel in record mode and checks that the console
> @@ -63,6 +69,8 @@ def run_vm(self, kernel_path, kernel_command_line, cons=
ole_pattern,
>              vm.shutdown()
>              logger.info('finished the recording with log size %s bytes'
>                          % os.path.getsize(replay_path))
> +            self.run_replay_dump(replay_path)
> +            logger.info('successfully tested replay-dump.py')
>          else:
>              vm.wait()
>              logger.info('successfully finished the replay')
> @@ -70,6 +78,14 @@ def run_vm(self, kernel_path, kernel_command_line, con=
sole_pattern,
>          logger.info('elapsed time %.2f sec' % elapsed)
>          return elapsed
>=20=20
> +    def run_replay_dump(self, replay_path):
> +        try:
> +            subprocess.check_call(["./scripts/replay-dump.py",
> +                                   "-f", replay_path],
> +                                  cwd=3Dsrc_dir, stdout=3Dsubprocess.DEV=
NULL)
> +        except subprocess.CalledProcessError:
> +            self.fail('replay-dump.py failed')
> +
>      def run_rr(self, kernel_path, kernel_command_line, console_pattern,
>                 shift=3D7, args=3DNone):
>          replay_path =3D os.path.join(self.workdir, 'replay.bin')
> diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
> index f3a43dc98c..e4539c5551 100644
> --- a/tests/avocado/replay_linux.py
> +++ b/tests/avocado/replay_linux.py
> @@ -21,6 +21,11 @@
>  from avocado.utils.path import find_command
>  from avocado_qemu import LinuxTest
>=20=20
> +from pathlib import Path
> +
> +self_dir =3D Path(__file__).parent
> +src_dir =3D self_dir.parent.parent
> +

And here to.

>  class ReplayLinux(LinuxTest):
>      """
>      Boots a Linux system, checking for a successful initialization
> @@ -94,6 +99,8 @@ def launch_and_wait(self, record, args, shift):
>              vm.shutdown()
>              logger.info('finished the recording with log size %s bytes'
>                  % os.path.getsize(replay_path))
> +            self.run_replay_dump(replay_path)
> +            logger.info('successfully tested replay-dump.py')
>          else:
>              vm.event_wait('SHUTDOWN', self.timeout)
>              vm.wait()
> @@ -108,6 +115,14 @@ def run_rr(self, args=3DNone, shift=3D7):
>          logger =3D logging.getLogger('replay')
>          logger.info('replay overhead {:.2%}'.format(t2 / t1 - 1))
>=20=20
> +    def run_replay_dump(self, replay_path):
> +        try:
> +            subprocess.check_call(["./scripts/replay-dump.py",
> +                                   "-f", replay_path],
> +                                  cwd=3Dsrc_dir, stdout=3Dsubprocess.DEV=
NULL)
> +        except subprocess.CalledProcessError:
> +            self.fail('replay-dump.py failed')
> +
>  @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
>  class ReplayLinuxX8664(ReplayLinux):
>      """

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

