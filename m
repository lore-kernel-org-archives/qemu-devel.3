Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666CFC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 10:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY16b-0001Bj-8x; Wed, 15 Jan 2025 05:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tY16Z-0001Ba-O0
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 05:58:35 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tY16X-00070X-5K
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 05:58:34 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361f796586so68604645e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 02:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736938710; x=1737543510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pv2Z4GXzGZ5tqykXVYkoToZsERSzvM62/gCY+YkaUTw=;
 b=mHUOHTFZsJHYEIq/TAnfqaKt3vC49Q/YSR6R6Y0uTSSbIapEWufk+9DRSECbHCnIt7
 CDp5N0IKBhftdOSRiICMKqhd1RiebBfUpJVRK1TXM1sgF+qzvVRWnKgK1BIGtFmp3ELU
 UXshx5tt5nkcZSUCitM3V6ULnO6X7kL8jzD4Ya+mZfPITPROVFAHGYTjTOAPrstTHaT6
 Z4+1PymzFYQieqB9m5j7fn1lVlX2zPKlVNNB3738VOXaVp3a2vyscAxsmsXlUVyEQlZf
 8TssCkzwF4DUi7cYd+Y1Iyt0naYh50EH80FvzqDAXIn5ViaXB45cmh8ivDJqtVih3CcO
 nDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736938710; x=1737543510;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pv2Z4GXzGZ5tqykXVYkoToZsERSzvM62/gCY+YkaUTw=;
 b=Q8+SlzmPRfydYHnUJgZNoTk3wAZOysScXDV4jU/eqf3ikQPbP+yYEsqogEgTF36h99
 lk+HVz8zCA2Xa22bkoGM7S8loXaKZuqickT5XhkWnb4voTBlMkBIAGlmGYDmrKFNPi/X
 sb9pU9zVbCzLfMRI6XDyUG48/q6L0fRijU+d+DpmY13w7cq44zFPDlqgXeHzJXRvX3mv
 6QMTK4luD4AoYx7KSZ1RD6ABphPUdpR4kC99MoqhSnaoRlgiFjnXo2twKd1HLtBiEwEi
 wum8wmNYgZxXAr/lOal39lOGrKEMB0eYihKleo91438q9iQcFqbekEP/9to5QOTIGHAy
 +qBA==
X-Gm-Message-State: AOJu0YwMaVb2Fr5dHv12tecp1816TwjEpjOyGWoTwHHtTwVnCQ3QAU4W
 oGbib+RUPYYLwT2omETI/uivuxw3+ykH4nvZ2oGutcNyTUdHrBFwWlXHKUmezaA=
X-Gm-Gg: ASbGnctquyEy7hMzBYv+yN8K2x3etgRZBdEXH4geR929ul9HK3To1Uh/2e58vDFZ7ep
 JfOErrDVLuMhuRnropZiSngGkhdrV55STrKZzhjT0nXASls/L1bFeZUlOOhgfaW6G0xYqrngMw7
 cbqv3b4GM9Y3DMxSzENr8PpJqMoXER715/O2zQJ8VsKYPAc7jdzSYuXTxZfX+K1ouan2OW3DUNb
 WOHanUjetbedc5JuV320OU/5O7YcxiTdOwhOa9bZsRUyTNnstYyH50=
X-Google-Smtp-Source: AGHT+IHlfyge1RcO7ZYxWoW6SAwiboE7Voxh/1OVAutsFperxA9DU/0wOPXQe6bAD4/BzPP9DnJr2g==
X-Received: by 2002:a05:600c:54c5:b0:431:557e:b40c with SMTP id
 5b1f17b1804b1-436e3fb231cmr238534775e9.27.1736938710368; 
 Wed, 15 Jan 2025 02:58:30 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d447sm16936092f8f.4.2025.01.15.02.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 02:58:29 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 067115F8A7;
 Wed, 15 Jan 2025 10:58:29 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Stefan Weil
 <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Laurent Vivier
 <laurent@vivier.eu>,  "Dr. David Alan Gilbert" <dave@treblig.org>,  Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 10/37] system: propagate Error to gdbserver_start
 (and other device setups)
In-Reply-To: <ac7210776db3b844ffb1af1d3e345da235bf986e.camel@linux.ibm.com>
 (Ilya Leoshkevich's message of "Tue, 14 Jan 2025 22:45:42 +0100")
References: <20250114113821.768750-1-alex.bennee@linaro.org>
 <20250114113821.768750-11-alex.bennee@linaro.org>
 <ac7210776db3b844ffb1af1d3e345da235bf986e.camel@linux.ibm.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 15 Jan 2025 10:58:28 +0000
Message-ID: <8734hkjqcr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> On Tue, 2025-01-14 at 11:37 +0000, Alex Benn=C3=A9e wrote:
>> This started as a clean-up to properly pass a Error handler to the
>> gdbserver_start so we could do the right thing for command line and
>> HMP invocations.
>>=20
>> Now that we have cleaned up foreach_device_config_or_exit() in
>> earlier
>> patches we can further simplify by it by passing &error_fatal instead
>> of checking the return value. Having a return value is still useful
>> for HMP though so tweak the return to use a simple bool instead.
>>=20
>> Message-Id: <20250109170619.2271193-11-alex.bennee@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
>
> Apparently the BSD code needs to be adjusted:
>
> ../qemu/bsd-user/main.c:631:32: error: too few arguments to function
> call, expected 2, have 1
>   631 |         gdbserver_start(gdbstub);
>       |         ~~~~~~~~~~~~~~~        ^
> /home/user/qemu/include/exec/gdbstub.h:63:6: note: 'gdbserver_start'
> declared here
>    63 | bool gdbserver_start(const char *port_or_device, Error **errp);
>       |      ^               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
>
>> ---
>> v2
>> =C2=A0 - split some work into pre-cursor patches
>> ---
>> =C2=A0include/exec/gdbstub.h |=C2=A0 8 +++++-
>> =C2=A0gdbstub/system.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22 ++++++++=
--------
>> =C2=A0gdbstub/user.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2=
0 ++++++++-------
>> =C2=A0linux-user/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +----
>> =C2=A0monitor/hmp-cmds.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0system/vl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 58 ++++++++++++++++++++--------------------
>> --
>> =C2=A06 files changed, 59 insertions(+), 57 deletions(-)
>
> [...]
>
>> diff --git a/gdbstub/user.c b/gdbstub/user.c
>> index 0b4bfa9c48..fb8f6867ea 100644
>> --- a/gdbstub/user.c
>> +++ b/gdbstub/user.c
>> @@ -13,6 +13,7 @@
>> =C2=A0#include "qemu/bitops.h"
>> =C2=A0#include "qemu/cutils.h"
>> =C2=A0#include "qemu/sockets.h"
>> +#include "qapi/error.h"
>> =C2=A0#include "exec/hwaddr.h"
>> =C2=A0#include "exec/tb-flush.h"
>> =C2=A0#include "exec/gdbstub.h"
>> @@ -372,15 +373,15 @@ static bool gdb_accept_tcp(int gdb_fd)
>> =C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> =C2=A0}
>> =C2=A0
>> -static int gdbserver_open_port(int port)
>> +static int gdbserver_open_port(int port, Error **errp)
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0 struct sockaddr_in sockaddr;
>> =C2=A0=C2=A0=C2=A0=C2=A0 int fd, ret;
>> =C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0 fd =3D socket(PF_INET, SOCK_STREAM, 0);
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (fd < 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror("socket");
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Failed to =
bind socket: %s",
>> strerror(errno));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>
> I think return -1 needs to stay here.
>
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0 qemu_set_cloexec(fd);
>
> [...]

Will fix. Thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

