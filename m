Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484A4CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 21:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoTv8-00016Q-Mf; Tue, 19 Aug 2025 17:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoTv5-0000zb-RP
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 17:31:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoTuz-000778-V6
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 17:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755639054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z6ngWuAj4uC2iChQyAjmuht1AtGU8sgIEG/lqjJRWqw=;
 b=ALReXaEUyxfuK9Sm9ONAfHST1Sid9Sr2kSBOm3vwG63An4/PewPViUAOwXfEyxnqOBkneR
 hIWaCrLiZeiBGIXA+PdpUvNXmmOxPAvw0xTQbLH5P0vOrIXqVWnTCOkL7qjltiXI/tUdoj
 mniv25Om4kgQpy39a40cRUBk5MzrihE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178--poaVHqwPw-qv03loc1UaA-1; Tue, 19 Aug 2025 17:30:52 -0400
X-MC-Unique: -poaVHqwPw-qv03loc1UaA-1
X-Mimecast-MFC-AGG-ID: -poaVHqwPw-qv03loc1UaA_1755639052
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-244581ce13aso117620765ad.2
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 14:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755639051; x=1756243851;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z6ngWuAj4uC2iChQyAjmuht1AtGU8sgIEG/lqjJRWqw=;
 b=BzVIsT7Yuj2OJEzoUGriCqRsCwQ5TWv7TvyUdNTWZ5Gmv/EDlU5FYTpEp7CzA2ryql
 cCtqtCihoH+mXFfwgL21RCv7LhJgwaXFju73lh3d3N2on8QvumOqXjO+ur6hXwccyENM
 yiTZPJxm0GEaJT4djKXctfmNowv4w81fiSrNSjrpQcHEt7uakRpLk4Ul3IwWj+zF247P
 8kG7MqhbCr1kP6uZ6a6RH6ElVjWJQm3c841+WGIFD7CWeY+MPKje9JbaLEcXFuF0cprc
 TFQBXvnj4Y/kgfHc7RBv6UdrOORSaiAetBC0YQhGn1Je1t9Z1vZlQDie7iIfJA0o+xtS
 AJGg==
X-Gm-Message-State: AOJu0YwlMAqGuE+W03JU0WdoEQvgLhjx/KsE9W4A8eB8wdMlKy/YTskO
 7Ol3+xQUHdVQAkC4j6ziLR2Go789l/tuAy9uUvrL+57BViKjAx/Qn6Ck7J+shHB7DX+/h1gQKWc
 G9AhpyFpvTdTtb4FsIfF0ahMrtv5gtltzRO+ONGKO6d8IwRfvO62AMlKS7c+c2X6KylHzlOeK+I
 QMRPG1NGFlkJefLVfCgET12ZhrXPkg5hZk3K9wEOY=
X-Gm-Gg: ASbGnctr6XCKGn0aL7iAl08OfzTiTicrJV1UKX1RG7q4uRziuSLhGn6wbcNEuYiwBsO
 7D6iroYv2bHBZdeXyh90imVKBazfACRV7rh3h2qYg3jNTnd8hJuOKVV/Sz+H4PMCGHY3b9dNFKk
 yNYcsZiTgJDUyfpg6iF4gErtZWWOW0wXVhRf50WY1tbc5wwj3wq1/i
X-Received: by 2002:a17:902:d512:b0:224:910:23f0 with SMTP id
 d9443c01a7336-245ef26d2acmr6158385ad.49.1755639050995; 
 Tue, 19 Aug 2025 14:30:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc54VJvAjhLQIZtnzcheXUlpO2ek9jwP/6zdB4T50+dD5VxxhRRGRfGcwkgvtMlxX+9ux1RK+ZFKeqv+sWjiU=
X-Received: by 2002:a17:902:d512:b0:224:910:23f0 with SMTP id
 d9443c01a7336-245ef26d2acmr6157915ad.49.1755639050333; Tue, 19 Aug 2025
 14:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250819102409.2117969-1-peter.maydell@linaro.org>
In-Reply-To: <20250819102409.2117969-1-peter.maydell@linaro.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 19 Aug 2025 17:30:38 -0400
X-Gm-Features: Ac12FXz30ZAK7JBRkzkOS-JRrMZRem2wwy0hyTwPdIyp1SuQBIIQY9HLcg8WIKo
Message-ID: <CAFn=p-Y_-HEKWDrZeZjG5GLaM6dk6fRFHqGr9KCiL1ri+TaCnA@mail.gmail.com>
Subject: Re: [PATCH] tests,
 scripts: Don't import print_function from __future__
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 19, 2025 at 6:24=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> Some of our Python scripts still include the line
>   from __future__ import print_function
>
> which is intended to allow a Python 2 to handle the Python 3 print()
> syntax. This particular part of the future arrived many years ago,
> and our minimum Python version is 3.9, so we don't need to keep
> this line around.
>
> NB: the scripts in tests/tcg/*/gdbstub/ are run with whatever Python
> gdb was built against, but we can safely assume that that was a
> Python 3 because our supported distros are all on Python 3.  In any
> case these are only run as part of "make check-tcg", not by
> end-users.
>
> Commit created with:
>
>  sed -i -e '/import print_function/d' $(git grep -l 'from __future__')
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  scripts/userfaultfd-wrlat.py                           | 1 -
>  tests/guest-debug/test_gdbstub.py                      | 1 -
>  tests/tcg/aarch64/gdbstub/test-mte.py                  | 1 -
>  tests/tcg/aarch64/gdbstub/test-sve-ioctl.py            | 1 -
>  tests/tcg/aarch64/gdbstub/test-sve.py                  | 1 -
>  tests/tcg/multiarch/gdbstub/interrupt.py               | 1 -
>  tests/tcg/multiarch/gdbstub/memory.py                  | 1 -
>  tests/tcg/multiarch/gdbstub/sha1.py                    | 1 -
>  tests/tcg/multiarch/gdbstub/test-proc-mappings.py      | 1 -
>  tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py    | 1 -
>  tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py | 1 -
>  tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py  | 1 -
>  tests/tcg/s390x/gdbstub/test-signals-s390x.py          | 1 -
>  tests/tcg/s390x/gdbstub/test-svc.py                    | 1 -
>  14 files changed, 14 deletions(-)
>
> diff --git a/scripts/userfaultfd-wrlat.py b/scripts/userfaultfd-wrlat.py
> index 0684be4e044..a61a9abbfcb 100755
> --- a/scripts/userfaultfd-wrlat.py
> +++ b/scripts/userfaultfd-wrlat.py
> @@ -17,7 +17,6 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>
> -from __future__ import print_function
>  from bcc import BPF
>  from ctypes import c_ushort, c_int, c_ulonglong
>  from time import sleep
> diff --git a/tests/guest-debug/test_gdbstub.py b/tests/guest-debug/test_g=
dbstub.py
> index 4f08089e6a9..e017ccb55d7 100644
> --- a/tests/guest-debug/test_gdbstub.py
> +++ b/tests/guest-debug/test_gdbstub.py
> @@ -1,7 +1,6 @@
>  """Helper functions for gdbstub testing
>
>  """
> -from __future__ import print_function
>  import argparse
>  import gdb
>  import os
> diff --git a/tests/tcg/aarch64/gdbstub/test-mte.py b/tests/tcg/aarch64/gd=
bstub/test-mte.py
> index 9ad98e7a54c..f4a7d7b4465 100644
> --- a/tests/tcg/aarch64/gdbstub/test-mte.py
> +++ b/tests/tcg/aarch64/gdbstub/test-mte.py
> @@ -1,4 +1,3 @@
> -from __future__ import print_function
>  #
>  # Test GDB memory-tag commands that exercise the stubs for the qIsAddres=
sTagged,
>  # qMemTag, and QMemTag packets, which are used for manipulating allocati=
on tags.
> diff --git a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py b/tests/tcg/aarc=
h64/gdbstub/test-sve-ioctl.py
> index a78a3a2514d..2c5c2180319 100644
> --- a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
> +++ b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
> @@ -1,4 +1,3 @@
> -from __future__ import print_function
>  #
>  # Test the SVE ZReg reports the right amount of data. It uses the
>  # sve-ioctl test and examines the register data each time the
> diff --git a/tests/tcg/aarch64/gdbstub/test-sve.py b/tests/tcg/aarch64/gd=
bstub/test-sve.py
> index 84cdcd4a32e..7b0489a622b 100644
> --- a/tests/tcg/aarch64/gdbstub/test-sve.py
> +++ b/tests/tcg/aarch64/gdbstub/test-sve.py
> @@ -1,4 +1,3 @@
> -from __future__ import print_function
>  #
>  # Test the SVE registers are visible and changeable via gdbstub
>  #
> diff --git a/tests/tcg/multiarch/gdbstub/interrupt.py b/tests/tcg/multiar=
ch/gdbstub/interrupt.py
> index 2d5654d1540..4eccdb41b97 100644
> --- a/tests/tcg/multiarch/gdbstub/interrupt.py
> +++ b/tests/tcg/multiarch/gdbstub/interrupt.py
> @@ -1,4 +1,3 @@
> -from __future__ import print_function
>  #
>  # Test some of the system debug features with the multiarch memory
>  # test. It is a port of the original vmlinux focused test case but
> diff --git a/tests/tcg/multiarch/gdbstub/memory.py b/tests/tcg/multiarch/=
gdbstub/memory.py
> index 532b92e7fb3..76d75e52512 100644
> --- a/tests/tcg/multiarch/gdbstub/memory.py
> +++ b/tests/tcg/multiarch/gdbstub/memory.py
> @@ -1,4 +1,3 @@
> -from __future__ import print_function
>  #
>  # Test some of the system debug features with the multiarch memory
>  # test. It is a port of the original vmlinux focused test case but
> diff --git a/tests/tcg/multiarch/gdbstub/sha1.py b/tests/tcg/multiarch/gd=
bstub/sha1.py
> index 1ce711a402c..3403b82fd4a 100644
> --- a/tests/tcg/multiarch/gdbstub/sha1.py
> +++ b/tests/tcg/multiarch/gdbstub/sha1.py
> @@ -1,4 +1,3 @@
> -from __future__ import print_function
>  #
>  # A very simple smoke test for debugging the SHA1 userspace test on
>  # each target.
> diff --git a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py b/tests/tc=
g/multiarch/gdbstub/test-proc-mappings.py
> index 6eb6ebf7b17..796dca75f0c 100644
> --- a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
> +++ b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
> @@ -1,7 +1,6 @@
>  """Test that gdbstub has access to proc mappings.
>
>  This runs as a sourced script (via -x, via run-test.py)."""
> -from __future__ import print_function
>  import gdb
>  from test_gdbstub import gdb_exit, main, report
>
> diff --git a/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py b/tests/=
tcg/multiarch/gdbstub/test-qxfer-auxv-read.py
> index 00c26ab4a95..fa36c943d66 100644
> --- a/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py
> +++ b/tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py
> @@ -1,4 +1,3 @@
> -from __future__ import print_function
>  #
>  # Test auxiliary vector is loaded via gdbstub
>  #
> diff --git a/tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py b/tes=
ts/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py
> index 862596b07a7..b18fa1234fb 100644
> --- a/tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py
> +++ b/tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py
> @@ -1,4 +1,3 @@
> -from __future__ import print_function
>  #
>  # Test gdbstub Xfer:siginfo:read stub.
>  #
> diff --git a/tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py b/test=
s/tcg/multiarch/gdbstub/test-thread-breakpoint.py
> index 4d6b6b9fbe7..49cbc3548f6 100644
> --- a/tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py
> +++ b/tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py
> @@ -1,4 +1,3 @@
> -from __future__ import print_function
>  #
>  # Test auxiliary vector is loaded via gdbstub
>  #
> diff --git a/tests/tcg/s390x/gdbstub/test-signals-s390x.py b/tests/tcg/s3=
90x/gdbstub/test-signals-s390x.py
> index b6b7b39fc46..398ad534ebf 100644
> --- a/tests/tcg/s390x/gdbstub/test-signals-s390x.py
> +++ b/tests/tcg/s390x/gdbstub/test-signals-s390x.py
> @@ -1,4 +1,3 @@
> -from __future__ import print_function
>
>  #
>  # Test that signals and debugging mix well together on s390x.
> diff --git a/tests/tcg/s390x/gdbstub/test-svc.py b/tests/tcg/s390x/gdbstu=
b/test-svc.py
> index 17210b4e020..29a0aa0ede4 100644
> --- a/tests/tcg/s390x/gdbstub/test-svc.py
> +++ b/tests/tcg/s390x/gdbstub/test-svc.py
> @@ -1,7 +1,6 @@
>  """Test single-stepping SVC.
>
>  This runs as a sourced script (via -x, via run-test.py)."""
> -from __future__ import print_function
>  import gdb
>  from test_gdbstub import main, report
>
> --
> 2.43.0
>


