Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5825C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNID-0002L0-C8; Tue, 18 Aug 2026 13:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1wwNIB-0002J5-Gl
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:08:03 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1wwNI9-0006BJ-O8
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:08:03 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5aebe49b227so19944e87.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:08:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787072880; cv=none;
 d=google.com; s=arc-20260327;
 b=CzTp1BKb0hN7yeNJGuRP1d4zu5dKFkBh+I8quXVXzqm5CU4Xc5hyvhVKAxzH8NuCIp
 3OjL0Fi3pa5jDqfP+vK24FQoBlYe7v9Qn5nG5Ue/+UC90Ik9aXNcxQ8Gm1PyGYY+AjyK
 En8KJPa7BAY+/plBmQ/PSg2eAk6uCFztwjYsi+6hmCZ8+QqcrLEej3NuhacFiAt45vN8
 vg0LT6kCf6ySuOTNYITX2ZWsKADh9BpJl/ceqvEe+fDHWjpvwZ/snDpKCf/BkQoj+IW7
 WFYUt2pePtMPPpUG5j+Ef8AubjblmftJ5IMdGFoBBWpH+jH81S4Z7R7sNPNl7SobrGzi
 D+Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=p2WxHWJBwj+XZuMU0S5rd1AQ0z2lrBqScw3701Hy880=;
 fh=sKJfdWmlXdbO0ULypAS3MiGzy7Q3ZwsXwppXqdFH4Zs=;
 b=WcsACzIeZdrt5LeE8jtJooF0yvakR3anT4QsaVzhsrA140zT977vD70e4/NhtJBuxm
 al7UpY4Jt6s0vdvCA2u8cBne9/huZlQq8kbc1zJsp7unET4ha/901HBNE+quTmX691DJ
 TDGLBiuP4XZENRJJoErD9NvDYLS8vUNdV8S3bP8cO68D3VhvJlHXuxgzCMXmZCLQr2hI
 f/tI/imx/vNSZ14Rq7aXr0g9WB3zhtUGT647ol0VFU0+CiwV1z7sRKVaVio5z49E29Nf
 CgedE0cczMmCwY5oco4aQ+/nkrS6zpzIEPPagLCKajqBDHLLLUmRPc/FJCju+IKf6cDS
 dL/Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787072880; x=1787677680; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=p2WxHWJBwj+XZuMU0S5rd1AQ0z2lrBqScw3701Hy880=;
 b=ZFiDH9uGtjHTmFOnlLXJ0rdSUAiVs0feF1/QLsXTR1nRyGk7NJc7OhjDdXNLfOWSnV
 ZrT8HDGJ8/XDtClZiqbuAqawlxGBy5vcWJrv8gn46lrkzl0W1ADnIEH5tCAIB/rxW2e7
 qhCUqAllGGlnxRLO7ZAlrE1DCSCMl/VkWUgP7tbqLCSwHvTB791cQ7cyViXfQgCT4zpZ
 IjEKUWytaMY0+IBuYTE1Z8KDmncrp+t+JgzFedJtUfJVyNVJ+T6dj8IyFrxkG9SmpzIY
 2hpmqlQ7VQ6dOdgODQUvH1X+RrjfjTGrcX1nKMSEGSI11DTekF5mUHfb/4gQk3QlCFn/
 KC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072880; x=1787677680;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=p2WxHWJBwj+XZuMU0S5rd1AQ0z2lrBqScw3701Hy880=;
 b=XJMVr1M0zXqLJ29g+jl2QsRnlKLpdKOpm1NImH11HeW6e+EpILjfmmD1A/kyZ5CJG6
 EyHjIb9GTC/dQhb/cEHt5TklfVcI2OYt5jjNgAFWRfknYX/crRakRZR3j8gYaZ2cCo6Y
 rRu3YbaT+A+VxeX4RgT9Nw5Uk2nuZJXZ4vqLRO+wKcvsLH4mZWpUtSHDdZMfQvczl+lf
 3FlYR7YXnPsjfBkD+B8DPMDJFevFYD00UPG4wDdkrIpACNlld6EOF0SUZFlsxni3g9a4
 xsk4+s6yg4BMDXG5H7N4dkJFsyvRONRZ1eOWTB1N0ZQHNw1rL2WMwu0T+81phGgkLVHq
 1Z5Q==
X-Gm-Message-State: AOJu0YxhSp7JjeebMK8gSWk7P8W4UQ0zdHZWDNxyKWHT/nWc8INUAJBZ
 IGiv23i7udFo1Np2k7UhRyjwAvA/NI1hDZptweO2TfoNPLP8M+MgZR0bv9LsYTxJ9Cavdb9mAm0
 AR8HFhwgKhTPzSMtjhfdSIJwixUFJ0Yg=
X-Gm-Gg: AR+sD13tx/oHFMNIpo9JJrod3k2vya6ARHHweSQx64tb1oHzVQfGjkfNTbf0/pGCoEX
 k2aC4REZ+cQKO3XE777hpebKdbOShgBU1QxbghulFTTY9RpQOB1VgCTNtrGHd7WYvwrf2AeOrtJ
 yMF0sAmlSH5BID+O1HypGnNXg2tCyrQaVdHUgiV224SWR90yOkYc4ZDVMJLDw3HtbIoH4qAJVtE
 lcF3fxlbSGEOXcE5SnMbiXsQLnhc0BsUsAjwEfsZ9wYkvsxpDNcBaEW7qtg80K0PqVf0rEicNoc
 mRDAR9WKLiyzcZIUMMPuumu8yQiO2fXiMpJWRPn72RtN2lE6RnMH5cdry76oO5e2Xtgx9oQcaVA
 d
X-Received: by 2002:a05:6512:3c98:b0:5b2:8f21:9208 with SMTP id
 2adb3069b0e04-5b459138277mr5686354e87.2.1787072879742; Tue, 18 Aug 2026
 10:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260813005031.518387-1-richard.henderson@linaro.org>
 <CAJOT6qOr+YL=Z_uVzPNtz5=8+gjLhg0dQ=99pwADZb5XEgKGag@mail.gmail.com>
In-Reply-To: <CAJOT6qOr+YL=Z_uVzPNtz5=8+gjLhg0dQ=99pwADZb5XEgKGag@mail.gmail.com>
From: Yogesh Vyas <yvyas1991@gmail.com>
Date: Tue, 18 Aug 2026 22:37:47 +0530
X-Gm-Features: AcwNN1XPfxFxnno1IhFYfA6SJeysMg3Z0vW3EaenrgmCPUZVhwd1m9R1rnHP-mM
Message-ID: <CAJOT6qMuSpzUw_hxu2TQsscwSqxOnorbJvpoNYKVWXv52iCN1w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] tcg: Defer tb_flush when initial thread region
 alloc fails
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, rathc@linux.ibm.com, 
 anushree.mathur@linux.ibm.com, npiggin@gmail.com, harshpb@linux.ibm.com
Content-Type: multipart/alternative; boundary="0000000000002f54d20659555470"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=yvyas1991@gmail.com; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--0000000000002f54d20659555470
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Sun, Aug 16, 2026 at 10:38=E2=80=AFPM Yogesh Vyas <yvyas1991@gmail.com> =
wrote:

> Hi Richard,
> Thank you for improvising on the initial patch shared.
>
> On Thu, Aug 13, 2026 at 6:20=E2=80=AFAM Richard Henderson <
> richard.henderson@linaro.org> wrote:
>
>> Hi Yogesh,
>>
>> The main problem with your patch is where you've placed the change:
>> tcg_region_initial_alloc__locked is also used by tcg_region_reset_all,
>> used by tb_flush.  Along that path, we really can't have a failure.
>> The path on which we can defer allocation is via tcg_register_thread.
>>
>> The second change I made is to use code_buf_ptr =3D=3D NULL to signal
>> reallocation is required.  In addition, tcg_tb_alloc doesn't need
>> to immediately fail: in the interim since thread creation, we may
>> well have performed a tb_flush already.
>>
>> Please have a try vs your hotplug test case.
>>
> I tried testing these patches on my x86 host running qemu-system-ppc64 by
> initially hotpluging 400 vCPUs.
> While the response was relatively slower than the initial patch that I ha=
d
> shared, I also observed the VM is as slow as stuck when I retried
> hotplugging upto 1024.
> I will share more feedback if I have any.
>

I have shared one minor comment on patch 2/3, with that:

Reviewed-by: Yogesh Vyas <yvyas1991@gmail.com>
Tested-by: Yogesh Vyas <yvyas1991@gmail.com>


> Regards,
> Yogesh
>
>
>>
>> r~
>>
>>
>> Richard Henderson (3):
>>   tcg: Return success from tcg_region_alloc__locked
>>   tcg: Return success from tcg_region_alloc
>>   tcg: Defer tb_flush when initial thread region alloc fails
>>
>>  tcg/tcg-internal.h |  2 +-
>>  tcg/region.c       | 40 ++++++++++++++++++++++++++++++----------
>>  tcg/tcg.c          | 24 +++++++++++++++---------
>>  3 files changed, 46 insertions(+), 20 deletions(-)
>>
>> --
>> 2.43.0
>>
>>

--0000000000002f54d20659555470
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br clear=3D"all"></div><div><div di=
r=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr">Hi Richard,</div></div=
></div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Sun, Aug 16, 2026 at 10:38=E2=80=AFPM Yoge=
sh Vyas &lt;<a href=3D"mailto:yvyas1991@gmail.com">yvyas1991@gmail.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div =
dir=3D"ltr"><div dir=3D"ltr"><div>Hi Richard,</div></div>Thank you for impr=
ovising on the initial=C2=A0patch shared.<div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 13, 2026 at 6:20=E2=80=
=AFAM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org"=
 target=3D"_blank">richard.henderson@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Hi Yogesh,<br>
<br>
The main problem with your patch is where you&#39;ve placed the change:<br>
tcg_region_initial_alloc__locked is also used by tcg_region_reset_all,<br>
used by tb_flush.=C2=A0 Along that path, we really can&#39;t have a failure=
.<br>
The path on which we can defer allocation is via tcg_register_thread.<br>
<br>
The second change I made is to use code_buf_ptr =3D=3D NULL to signal<br>
reallocation is required.=C2=A0 In addition, tcg_tb_alloc doesn&#39;t need<=
br>
to immediately fail: in the interim since thread creation, we may<br>
well have performed a tb_flush already.<br>
<br>
Please have a try vs your hotplug test case.<br></blockquote><div>I tried t=
esting these patches on my x86 host running qemu-system-ppc64 by initially =
hotpluging 400 vCPUs.</div><div>While the response was relatively slower th=
an the initial=C2=A0patch that I had shared, I also observed the VM is as s=
low as=C2=A0stuck when I retried hotplugging=C2=A0upto 1024.</div><div>I wi=
ll share more feedback if I have any.</div></div></div></div></blockquote><=
div><br></div><div>I have shared one minor comment on patch 2/3, with that:=
</div><div><br></div><div>Reviewed-by: Yogesh Vyas &lt;<a href=3D"mailto:yv=
yas1991@gmail.com">yvyas1991@gmail.com</a>&gt;</div><div>Tested-by: Yogesh =
Vyas &lt;<a href=3D"mailto:yvyas1991@gmail.com">yvyas1991@gmail.com</a>&gt;=
</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div=
 dir=3D"ltr"><div><div class=3D"gmail_quote"><div><br></div><div>Regards,</=
div><div>Yogesh</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
<br>
r~<br>
<br>
<br>
Richard Henderson (3):<br>
=C2=A0 tcg: Return success from tcg_region_alloc__locked<br>
=C2=A0 tcg: Return success from tcg_region_alloc<br>
=C2=A0 tcg: Defer tb_flush when initial thread region alloc fails<br>
<br>
=C2=A0tcg/tcg-internal.h |=C2=A0 2 +-<br>
=C2=A0tcg/region.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 40 +++++++++++++++++++++++++=
+++++----------<br>
=C2=A0tcg/tcg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 24 +++++++++++++++-----=
----<br>
=C2=A03 files changed, 46 insertions(+), 20 deletions(-)<br>
<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div></div>
</blockquote></div></div>

--0000000000002f54d20659555470--

