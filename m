Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2435ECA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 16:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDlPs-00086a-C8; Mon, 05 Oct 2026 12:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDlPp-00084M-6B
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 12:19:50 -0400
Received: from mail-ed2-x0e.google.com ([2a00:1450:4864:33::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDlPn-0007fS-Gf
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 12:19:48 -0400
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6afbfed31d1so2136859a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 09:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791217186; cv=none;
 d=google.com; s=arc-20260327;
 b=lp10+fA2BG0ir9HomS0mmwNgdGV7UDT7AHV1c/6Jh1lxxVZhjfUcexQVSMPxgN41LQ
 7FmeecXWjcRx5uq2OwIPDzgNy6SZJZ+D8qqNgsigNa96XrOLUdmfO5JTUdiaIPLukZlN
 RS78XhcMi2Bc6ZW91BV9k3ktWkIpj3Qq+PrSUBEcoqeeu86pB5IwjxcVmm+DgpVmdrIX
 RgYDh203k87VnsjC5qyTm8WXJwPjNlqe0IGPEw+9C3Z4oaTWEu6NOjyweQMNRzd3oHzN
 Nv9g7e9Jta3iI51e22QOViAv/U9zCXzGY6EB8Cd6TbN49ZBSSMrJulTPD+UfXCxtbBTM
 SZsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=M5WS0nuyMVs7h8DkXPsyI9s0hvN9olYcOyC3QmjbYV0=;
 fh=IWV5i/bmsnDDiumGg7GH/qn1tjabzJqEv+mL/WiBNIs=;
 b=U52XRMpNYLDSaOMvriT5ShIScsJ96uSoRHThFtXCuiWlJTjGFZMp0MCjaMzQeEV7QM
 aod86mY2JxmP6EiW9yPVReg8A/h9Rn+RzfYsaj4wrBICsa6ZEIiecXRo/0xbrWTlEDl8
 jObF3GzRiC5GeBtDih1r3U9xzxMHatR01hdjPf5s8eC+BVNuBMmp8YydwmAWUMkHmubl
 vawJY/haLUYz9YzjUhhUapaOhdMxLwAYDXqp1n2UFjgCF/PGm1D5zEHqbgnWsQSsrBbM
 VE3Y3F64+3gmbJaEErXICKFgd6RJVWJjJH9uttJaTEZPDVOP1QYL7/i8rzgEbrcSYycG
 REmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791217186; x=1791821986; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=M5WS0nuyMVs7h8DkXPsyI9s0hvN9olYcOyC3QmjbYV0=;
 b=opZbiDQwhRSs4UtZSUP/Rd7ovZMrAx3zO9Ck7dkQVfRK9a4h5rPcFj+dYljARdrrv7
 iFWetnGeIC+eBgMRmMJOM9OPqzYhIWkoOfHkSO6mo3qdMSgUKpBXBLDNcObsCvjK5jQK
 Tjr4SQV41BxyCZkdCB+prVGPxr5xxM6oIcv/Gx3QVG7LPFgtYg3UckBdxrGb1WTlTonT
 CWWeuchkyIDMgUSQ48HTRUuWFhtBhXXehrHlx0wSs1Jq11z03zonIbpBo/0r2VK3wwue
 nR4k7FSeS9KZel1tu8FOJ6XEr5c7yAUL2GCHN8hu0veQs+hl2B8DJrb3iaRiMAAtZIFk
 6VzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791217186; x=1791821986;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M5WS0nuyMVs7h8DkXPsyI9s0hvN9olYcOyC3QmjbYV0=;
 b=hXjua205bp5fzaXl7Zbecq7T39PyNukrgjDcdR9cA45/rN1DWGe8d3+t56304NeKsr
 qxsQog1s7SbnEQ1tnU9nglfiRJb2lz5QT68MN/mLI6VjnKH/vMwFmR0o9fV2U6ut281B
 KOTi0QptzrIJ0MlL/Hw75zT283RN0ZxxjaIm0YfH/vgz+Ixnc1X4NUz1f3eMFoEsBPG9
 1LroDT85Pr9rWHBj5cyoMkpOrOAZRrk6K02AZbYY61KCnLYNBKMK+oOtBNMK7ofBdN8A
 DCDFLtSPNFnX6QBA9399xYfTUCwJG9mttdaAWUtBplbi04dgC6znuB/PACTdH/3yJ7e9
 E1ug==
X-Gm-Message-State: AFq9FYKBPs9iLOVJOsEu1Rq/uHMwAJ7IwlXesEUH3GVVxd1kF1e6kWZB
 r+QuQgPyfmCt4YFNuNzcw4M/rO3LvzoYLuapgZ6PWi733ciHl9TuWM1HgAwlYposufxzoYizWMp
 IK5IjiVPos5OXP70DZ2iKgy8SbhEOOl0=
X-Gm-Gg: AYBFou3xBAKDyXoBYIpI8VkqX8oBw2o5PvXhnFaMztBK5X41FRTeqcBtk95PdK7lH8l
 oGmQHh9WnE2qwdx2e+Yc0LAPcq0q7XWcBxhlu3BYE7iS/YKPJU5IfHLEH/MtDWTxiYJRE/fA61h
 aoI7W4Rs7rf9y5+R5gStvxBDdUt9iiiyTEvuUK6pPsDsp7tiyI4gPMtXuHWHtnqLhLJQV9L+oTP
 AWxVYGdDTng2j6wCD8Nh8Z7PU8fgG0rPzNFwzHWzXc86y8kWCXWFLJ1b6M7tk3Jp5cza/5loGCQ
 hvGI4c/XfQpaVdy38ikU2C0J9arKb1F3QKnjaTNyyUf7LW0+mJdBQ87Bq9uzmXWdMQ==
X-Received: by 2002:a05:6402:440b:b0:6ac:6a3f:c626 with SMTP id
 4fb4d7f45d1cf-6af9e2c4e89mr9871155a12.8.1791217185667; Mon, 05 Oct 2026
 09:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20261004072927.1142-1-luoyonggang@gmail.com>
 <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
 <CAE2XoE-joWZwrBy-jLe+=ZP7OGM9cyDrF_5hz7koVPODeys+JA@mail.gmail.com>
 <b2297f92-a685-4399-a755-bbe5a37b9b3f@oss.qualcomm.com>
In-Reply-To: <b2297f92-a685-4399-a755-bbe5a37b9b3f@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 6 Oct 2026 00:19:32 +0800
X-Gm-Features: AclHuK_F6ioAiGplarh4QH6FCThIBabSBzidntJs9B9Xv5AGs8HsFYbaIJoAr5E
Message-ID: <CAE2XoE-4Pdp_n3RgpqJ5se_KTHniMAJAodTLmkfV+0jjou=M5w@mail.gmail.com>
Subject: Re: [PATCH 0/4] target-info: preserve full softmmu target identity
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x0e.google.com
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 6, 2026 at 12:12=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/5/2026 9:10 AM, Yonggang Luo wrote:
> > On Tue, Oct 6, 2026 at 12:03=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 10/4/2026 12:29 AM, Yonggang Luo wrote:
> >>> `TARGET_ARCH` identifies a base architecture, not necessarily the ful=
l
> >>> system-emulation target. For example, `mipsel-softmmu` uses `TARGET_A=
RCH=3Dmips`,
> >>> which caused `query-target` to report `mips` instead of `mipsel`.
> >>>
> >>> Generate `TARGET_SYS_EMU` separately. Softmmu builds use the full tar=
get name,
> >>> as `SysEmuTarget` enumerates system targets. User-mode builds use
> >>> `TARGET_ARCH`: user target names such as `aarch64_be` and `mipsn32el`=
 do not
> >>> have corresponding `SysEmuTarget` values. This means `mipsel-linux-us=
er` now
> >>> reports the base architecture `mips` rather than `mipsel`; its execut=
able name
> >>> remains unchanged. Initialize `TargetInfo.target_arch` from this toke=
n and add
> >>> a qtest to check the `query-target` result against the target name of=
 the
> >>> running QEMU binary.
> >>>
> >>> Yonggang Luo (4):
> >>>   Revert "target-info: Statically initialize target_arch"
> >>>   Revert "meson: Add TARGET_ARCH to config_target_data"
> >>>   tests/qtest: check query-target architecture
> >>>   target-info: preserve full softmmu target identity
> >>>
> >>>  meson.build            | 11 +++++++++--
> >>>  target-info-stub.c     |  2 +-
> >>>  tests/qtest/qmp-test.c | 13 +++++++++++++
> >>>  3 files changed, 23 insertions(+), 3 deletions(-)
> >>>
> >>
> >> Why should we do this for user binaries? Current work around
> >> single-binary only concerns system binaries, where all targets are
> >> correctly covered by what exists.
> >
> > From my personal point of view, keeping target_arch as
> > SYS_EMU_TARGET__MAX for user binaries
> > is a better option. I am doing this is for replica of commit
> >
>
> Ok, but I'm not sure it answers the why.
> Could you explain the benefits?

Which part? keeping target_arch as SYS_EMU_TARGET__MAX for user-binary beca=
use
The following original code would return -1 for some user-binary
+    SysEmuTarget arch =3D target_info()->target_arch;
+
+    if (arch =3D=3D SYS_EMU_TARGET__MAX) {
+        arch =3D qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
+                               &error_abort);
+    }
+    return arch;
So basically assigning any value for the user binary is valid.
SYS_EMU_TARGET__MAX is more explicit as it's related to type SysEmuTarget.
-1 is another option but easy to confuse.


For why commit e934c624f32f6f44f427d73a2e6a67e983a02ae6.
"target-info: Statically initialize target_arch"
doing that, I am not sure.


>
> > "target-info: Statically initialize target_arch"
> >
> >>
> >> Regards,
> >> Pierrick
> >
> >
> >
>

--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

