Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794BAC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzCwx-00025N-IV; Wed, 26 Aug 2026 08:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzCww-000250-0v
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 08:41:50 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzCws-00070A-VG
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 08:41:49 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c197e7e4e94so132957966b.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 05:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787748104; x=1788352904; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gxttHIuMhHi9GXmIRh83s4TWOIJ8ZtJhZscX1EyRin4=;
 b=zb06yhT8o45RCvCB2v8JakrONOY0CLf4A4fbStLJimjC081Y/plS+BpgzfWTt7ggea
 ijOYhfeqOtvWOsaCw5h5/lm1875Tnqc6tFJ9OuU0UkQZBZDs2GLXsK9j2DqhrFeXgxXu
 SsWGgrXoGlTm7vLpd7/ebO2nBSw/GuNa+Uvh+ubLYLNc1Dmnim6eKQDFaCvHFEzxXnqR
 DqZppV7F2CnZXwB2V2f11IdOmt1vS9xZ3gjg7Em6KLlWsk/oOolCAjJCztEwxmRoTn3+
 F7QnTmuqI7ATrf0YX7cClqI7W9wYvv71AMz2wcv6CQm0MywmqTBL8ONde1N8OLAGorIa
 6pYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787748104; x=1788352904;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gxttHIuMhHi9GXmIRh83s4TWOIJ8ZtJhZscX1EyRin4=;
 b=oOaAkcvhgm8NTK+cD5850KDcAebXONbyRg1VGOsGUuAlrp7t7O3Y3ukzfmllfa4cFF
 87SDuk71SCnsS6iUwXL2C6ntd2pFyUTeg4pckI5Kt81TfzVbVUY06Xd0RLMgMLbg/X+v
 fdv1ppjfOfMrY0d/6H4OEwvG9T74jG2hen4evSB4i6uPCH3ZdNxti9nWRCi/Bz9H6EEk
 ySE4gS3lXkwTBHOsjEENQH3baImX7SGCndwnGJcAWdcKs4BmWGLBKx9e3tNlY/DrBmrw
 /ji7NyzVuOJOXr89hVawFTNOTAPX6D0graMBpzEVMcJ7EmfWNqSo/624ZNkOqyFaHvHg
 lcng==
X-Gm-Message-State: AFuF++mZKMPbDyE4qUMvwkUXfN9yGBNSdWxzZ3DbY8iusyPSmUUhTpih
 CBXd298ZZm4K8fDY7W43sVAtdfPwd4/1nchPpz3Jjn7vGDyuX4CNKDMWC/a7M8sHao4=
X-Gm-Gg: AR+sD13uPzQ8mRWuVZJ6F03jrqwLAY57UMwV7l21dkwnG52aAkFry6M04eXlkDkXiJ9
 YcKnIFSQcMLcNwGs5b/K1Ud/wRndKEBV50cYkPIoMnjHDv5orRSlBvfZ0KJ8FrlB+bqnbKIAd2M
 uvMGXZvzc+7Qf1JZUYa4BdBfBYkeElLvsP1bMFJGIWVwt51/VxLKEBny3bNWwCsrNn7B7edcp9I
 v6mtOEKHSz0PjE1mmZjqy3R1eVHHVunj1RQfR1cPlLhdTzH5NAjOtBYvuL2nhJ4iyxQiPbYkqgf
 TjKdannPwYlPR8jfO21iqoWl06XLZov8wLu7uDZqb9x55baj3ggUEFSYsD2dBAUCNJkQRc6NJ6d
 xR/sxEpjUphlmNWsl8NXDZRMQdyeUn7yuoJI+5aPRQEMa5Z2xHbX9Vh9c6r6PrvY9jr1JB6Vikv
 zZvCym4dW2FfbJPWdA+/nxfHXnnjhD0qWDagq2bMbRLRDRIOkSzmI7tI3XDuuB
X-Received: by 2002:a17:907:6088:b0:c21:35d0:f435 with SMTP id
 a640c23a62f3a-c250bc0f8f0mr819962466b.10.1787748104403; 
 Wed, 26 Aug 2026 05:41:44 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9b4e9csm509884366b.54.2026.08.26.05.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 05:41:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 599245F877;
 Wed, 26 Aug 2026 13:41:42 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <laurent@vivier.eu>,  Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Helge
 Deller <deller@gmx.de>,  Paolo Bonzini <pbonzini@redhat.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,  Aniket
 Sahu <asahu1x@linux.ibm.com>
Subject: Re: [PATCH v7 035/104] tests/tcg/multiarch/gdbstub/prot-none.py:
 detect if /proc/self/mem can be used to access PROT_NONE pages
In-Reply-To: <20260818192309.22169-36-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Tue, 18 Aug 2026 19:21:59 +0000")
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
 <20260818192309.22169-36-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.3; emacs 30.1
Date: Wed, 26 Aug 2026 13:41:42 +0100
Message-ID: <87mru9oxyx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> Recently (July 2026), this issue became reproducible on debian stable
> with kernel (7.1.3) from backports. I suspect it's a default hardening
> of kernel related to recent CVEs.
>
> By tracking error reported, we can see that /proc/self/mem pread from
> cpu_memory_rw_debug in accel/tcg/user-exec.c returns an error
> (Input/Output error).
>
> Detect this situation directly from our gdb python script, by trying the
> same thing from current process. If this operation fails, we can
> gracefully skip the test.
>
> Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3329
> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/tcg/multiarch/gdbstub/prot-none.py | 35 ++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/tests/tcg/multiarch/gdbstub/prot-none.py b/tests/tcg/multiar=
ch/gdbstub/prot-none.py
> index e653bc697f6..393626a9798 100644
> --- a/tests/tcg/multiarch/gdbstub/prot-none.py
> +++ b/tests/tcg/multiarch/gdbstub/prot-none.py
> @@ -5,6 +5,8 @@
>  SPDX-License-Identifier: GPL-2.0-or-later
>  """
>  import ctypes
> +import ctypes.util
> +import mmap
>  import os
>  from test_gdbstub import gdb_exit, main, report
>=20=20
> @@ -18,6 +20,34 @@ def probe_proc_self_mem():
>      except OSError:
>          return False
>=20=20
> +def probe_proc_self_mem_access_prot_none():
> +    libc =3D ctypes.CDLL(ctypes.util.find_library("c"), use_errno=3DTrue)
> +    libc.mmap.restype =3D ctypes.c_void_p
> +    libc.mmap.argtypes =3D [ctypes.c_void_p, ctypes.c_size_t, ctypes.c_i=
nt,
> +                          ctypes.c_int, ctypes.c_int, ctypes.c_long]
> +    size =3D os.sysconf("SC_PAGESIZE")
> +    # mmap a PROT_NONE page
> +    PROT_NONE =3D 0
> +    addr =3D libc.mmap(None, size, PROT_NONE,
> +                     mmap.MAP_PRIVATE | mmap.MAP_ANONYMOUS, -1, 0)
> +    assert addr !=3D ctypes.c_void_p(-1).value
> +    fd =3D os.open("/proc/self/mem", os.O_RDWR)
> +    try:
> +        # read it through /proc/self/mem

It might be worth pointing to it here:

modified   =EE=9C=BC tests/tcg/multiarch/gdbstub/prot-none.py
@@ -34,6 +34,7 @@ def probe_proc_self_mem_access_prot_none():
     fd =3D os.open("/proc/self/mem", os.O_RDWR)
     try:
         # read it through /proc/self/mem
+        # this is the fallback in cpu_memory_rw_debug
         data =3D os.pread(fd, size, addr)
     except Exception as e:
         print("/proc/self/mem pread error: " + str(e))

I think the comment in cpu_memory_rw_debug is wrong through, pread isn't
using the ptrace interface.

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

