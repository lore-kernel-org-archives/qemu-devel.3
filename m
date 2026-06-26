Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A05CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 01:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcuwK-0001Ja-RS; Thu, 25 Jun 2026 21:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcuwJ-0001EM-Ax
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:01:03 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcuwG-0001Ga-TT
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:01:03 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-697ce8cfe65so645178a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 18:01:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782435659; cv=none;
 d=google.com; s=arc-20260327;
 b=OiR4I32xK+GsE8CVJtAwO5fAFh5ZCR+RzE0pmfCADBGiLpjo/GXlfR7nWU+0AnaL6F
 snwP+qQ46u/lY/mUsJBuQRKP1tviN6IV5lFQOeuVpMyvmLeNL+CNQgVfE5AQ3raaINPa
 MkEQVF6nRmyZDvEi2MDsKc/vEkPX3Uv9zsR8pE5G2UlcCYF6OPvrALzoLlMXS8WKAk1d
 rO5IP+pln98sBHJjwi7gVoYdKZk3f1K82KYNXrOQwQlCnqNe4F83k96ymqlCrX+MeWXe
 dWt3VOCTUVScQMoeEdum2jBrJS0hOlhmxD/usjTTaK7R7ztpjZQhM815UguFwdegWL/o
 cg2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PFVpYKN5vzxzJlKubmFg2Ec/OfpTirTNcJf1/3JAEOU=;
 fh=9/4tzqKjgzJcjmYJcCvfm+LbcgW0ATp/rdwAYjKmbVo=;
 b=G8txJjvvZUZurRj96yIWLh8I4bJSXyYhmjoMmnrFcKkREE93FK8w9tKHZNVS6lSbJI
 SW/Gg70u+E2/oumW9/QP7no+OkzN3jXUZSihyxwA23HpKuIg4wQ1S1QfSmwbZ4L9cTNv
 iCrsZsNltvng9JfeCfPA9i4AoikaOfuZ9JGtT2kZNKe/5WR/R0GTSMjC0qQTcPUgdCrW
 +lXs9WMsFp+ERmwNworlw4HUuOrXvFOgTydAFedOixCV115OPsN0XMAafJumSG3ceJmn
 NVRxBUylgec9KeCsNw93RuaWEhieLFHwMLUAqIAdsx76t5WrULbB50pkP/E55e6s/Ite
 zMtQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782435659; x=1783040459; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PFVpYKN5vzxzJlKubmFg2Ec/OfpTirTNcJf1/3JAEOU=;
 b=THR2yWvVvqA1lmshRss9kp62p1+KjZKc7kDMXzeEvPSHFDsqrXbZ0IhSshCQzIFNEQ
 v7R8q2gYZ67/geDuSiyVtoEHzsu/54MAcjDIsz88PQfZVH71xHWY8VmXo3dmBfj/cePC
 CT+1T5QQHq6ild953lcar1Y589FE4d9pQsfqDm5Emgw54HNNieN0ck3W/DCNa+vMjuuH
 +x9f74mEdPF3sJB25I6HSst7DGi1yxnoZxaSzUI10RQS0OM+xj/fP7lnEbwQeNCTL122
 aoMO8fhfXYZwjpYv50amk1LIirB8uoCctZWIxTohStM+dWONxZPaSp9mDPtkA60RBVqn
 AN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782435659; x=1783040459;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PFVpYKN5vzxzJlKubmFg2Ec/OfpTirTNcJf1/3JAEOU=;
 b=FZFpcHr9AN6xbump1NycnYnr9jpj4glkso+EyYzu2MTkhd5o2nKFH+t3HJbla2EpE/
 NQ9bQ1enl/s8y05iGCYHOXwzMQSlSVD3zCfAGllpRq+azBirqaAiOh9N1qQGL5x/c0nu
 eobesVDqV3j71O0OnuNnIV56vnuCzILR771DE3Co5oKShUnRqYuYnwsQnVQUFkihnKaK
 spaE7Fs3F2dTntW31g0swzCm781wLPd34spGYQwFWtB3OA7PaYlNz8O/WvwqoMDvWR31
 DRBMvs3sFhkUQMnIaE9rlIBV55dso7dg6LQJqTIz6DkmgXQs1N16xHjfg177HalTZFZ+
 OAXg==
X-Gm-Message-State: AOJu0YxJzrjk2zVV9YcVg14yEPd3xUnFKJjuoBigWGvzqRPnD5OV7Zxo
 iB44MDug6q8LdPNXsa9CV3iqaZFKcU7IFGZvEFaAJpNzYu7X8JGUc8pC4ojK9bNwn9l4QOZVyOI
 rcrtpaHHBZg/19XAD0wf7jVTZ3D7QYbg=
X-Gm-Gg: AfdE7clwR5Der6kIWhY2c6hllGNfKe5hY40deKJb6iroSHH4SffCo/jl+Vv6cZsg50C
 mVSpqlwJbJSiFe5NSPETue4j05hH4ywA3DW5P8KB1fEmjaI0UeruhKw15y3XSIl/PlbIcYY3Drz
 AP9dg2KMFJY8xxtvn8suq2tjgopS40u7HPCkcLoP13MoQsDDZUDtDxyWtRHfQ3V/odL0peeJolz
 BHGoIHG4ePUsDuUc7gDq1mJxxrswqlTdJIWWgEepN2yNV3GMJ5Ao4dt7jDN0QXdO7HwI9fdL1YB
 AehggrL/Oi5Rw1vTM/BXy3EHto4=
X-Received: by 2002:a05:6402:a512:20b0:698:1504:4cd9 with SMTP id
 4fb4d7f45d1cf-69815044e44mr504782a12.30.1782435659068; Thu, 25 Jun 2026
 18:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
 <20260624000632.2149359-10-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260624000632.2149359-10-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jun 2026 11:00:30 +1000
X-Gm-Features: AVVi8CdVyHmn2YnUwDDG1oriF_DHv_2wDxRao4zknPl6F2woYH9NbWypqaimYtQ
Message-ID: <CAKmqyKM6_Fq6SDO7qxDsqByFuaWw9rGZazhb2LjOW=pDfVbp5w@mail.gmail.com>
Subject: Re: [PATCH v2 09/24] target/riscv: move csr.h to tcg subdir
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 fritchleybohrer@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jun 24, 2026 at 10:08=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> After KVM is no longer reliant on csr.h move it to the TGC only land.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c            | 2 +-
>  target/riscv/gdbstub.c        | 2 +-
>  target/riscv/monitor.c        | 2 +-
>  target/riscv/riscv-qmp-cmds.c | 2 +-
>  target/riscv/tcg/csr.c        | 2 +-
>  target/riscv/{ =3D> tcg}/csr.h  | 0
>  target/riscv/tcg/mips_csr.c   | 2 +-
>  target/riscv/tcg/op_helper.c  | 2 +-
>  target/riscv/tcg/pmp.c        | 2 +-
>  target/riscv/tcg/th_csr.c     | 2 +-
>  10 files changed, 9 insertions(+), 9 deletions(-)
>  rename target/riscv/{ =3D> tcg}/csr.h (100%)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5d44f993e4..96c92de2ee 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -24,7 +24,7 @@
>  #include "qemu/guest-random.h"
>  #include "cpu.h"
>  #include "cpu_vendorid.h"
> -#include "target/riscv/csr.h"
> +#include "target/riscv/tcg/csr.h"
>  #include "internals.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index a2bbaf7f07..f0a5e0d86f 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -21,7 +21,7 @@
>  #include "gdbstub/helpers.h"
>  #include "cpu.h"
>  #include "internals.h"
> -#include "target/riscv/csr.h"
> +#include "target/riscv/tcg/csr.h"
>
>  struct TypeSize {
>      const char *gdb_type;
> diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
> index 7aacd1d89c..f8042db9cd 100644
> --- a/target/riscv/monitor.c
> +++ b/target/riscv/monitor.c
> @@ -22,7 +22,7 @@
>  #include "qemu/ctype.h"
>  #include "qemu/qemu-print.h"
>  #include "cpu.h"
> -#include "target/riscv/csr.h"
> +#include "target/riscv/tcg/csr.h"
>  #include "cpu_bits.h"
>  #include "monitor/monitor.h"
>  #include "monitor/hmp.h"
> diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.=
c
> index b94e8391ed..2647deef91 100644
> --- a/target/riscv/riscv-qmp-cmds.c
> +++ b/target/riscv/riscv-qmp-cmds.c
> @@ -35,7 +35,7 @@
>  #include "system/tcg.h"
>  #include "cpu-qom.h"
>  #include "cpu.h"
> -#include "target/riscv/csr.h"
> +#include "target/riscv/tcg/csr.h"
>
>  static void riscv_cpu_add_definition(gpointer data, gpointer user_data)
>  {
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index d447204721..572a39d660 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -21,7 +21,7 @@
>  #include "qemu/log.h"
>  #include "qemu/timer.h"
>  #include "cpu.h"
> -#include "target/riscv/csr.h"
> +#include "target/riscv/tcg/csr.h"
>  #include "tcg/tcg-cpu.h"
>  #include "pmu.h"
>  #include "time_helper.h"
> diff --git a/target/riscv/csr.h b/target/riscv/tcg/csr.h
> similarity index 100%
> rename from target/riscv/csr.h
> rename to target/riscv/tcg/csr.h
> diff --git a/target/riscv/tcg/mips_csr.c b/target/riscv/tcg/mips_csr.c
> index 609718f288..884030e91d 100644
> --- a/target/riscv/tcg/mips_csr.c
> +++ b/target/riscv/tcg/mips_csr.c
> @@ -10,7 +10,7 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "cpu_vendorid.h"
> -#include "target/riscv/csr.h"
> +#include "target/riscv/tcg/csr.h"
>
>  /* Static MIPS CSR state storage */
>  static struct {
> diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
> index 775fd431d6..003f6ebb31 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -20,7 +20,7 @@
>
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> -#include "target/riscv/csr.h"
> +#include "target/riscv/tcg/csr.h"
>  #include "internals.h"
>  #include "exec/cputlb.h"
>  #include "accel/tcg/cpu-ldst.h"
> diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
> index d93563c36b..41b55519a8 100644
> --- a/target/riscv/tcg/pmp.c
> +++ b/target/riscv/tcg/pmp.c
> @@ -23,7 +23,7 @@
>  #include "qemu/log.h"
>  #include "qapi/error.h"
>  #include "cpu.h"
> -#include "target/riscv/csr.h"
> +#include "target/riscv/tcg/csr.h"
>  #include "trace.h"
>  #include "exec/cputlb.h"
>  #include "exec/page-protection.h"
> diff --git a/target/riscv/tcg/th_csr.c b/target/riscv/tcg/th_csr.c
> index 431f4cc286..e6f642991c 100644
> --- a/target/riscv/tcg/th_csr.c
> +++ b/target/riscv/tcg/th_csr.c
> @@ -22,7 +22,7 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "cpu_vendorid.h"
> -#include "target/riscv/csr.h"
> +#include "target/riscv/tcg/csr.h"
>
>  /* Extended M-mode control registers of T-Head */
>  #define CSR_TH_MXSTATUS        0x7c0
> --
> 2.43.0
>
>

