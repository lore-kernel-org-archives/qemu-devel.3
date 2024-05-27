Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB38C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 11:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBYVU-0001Uy-3t; Mon, 27 May 2024 07:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBYVP-0001UD-ID; Mon, 27 May 2024 07:27:07 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBYVN-0000dZ-Li; Mon, 27 May 2024 07:27:06 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6f69422c090so5825111b3a.2; 
 Mon, 27 May 2024 04:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716809224; x=1717414024; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pvZFfc1JrD0uZx4TxCsfgTmAeXb0pRwZtVzdOINWG30=;
 b=mYWvYjE/S0IXxibBWB/GPn4DmtiSsvkoYgDqXY61c64U0JIiaOl43G1wYvAMbFgKyy
 /F72lhGfYG/JekpdlXkRv8peAaQo1Wb8HK2o1Rr+RgnNBsjBKnVufb1hNmAlbuIurUsi
 Sv5c4lod06zImoMMxc9gK9ntmhJTQfiaCzMhRvabJbWF6Eer9twNYuI2jA24eiVtBjIB
 bJ2Z8txZI4QKkxQNL+F/a9QCWnhoyPB/+Um8NVW47ingio2DQZrD31nt7ZE+Yiiu4Ue7
 lL+DAVGMnCPKmdojDkYHAqV813SEsHohdQugfhq7ePnk6lx3I7Ak4NkCF+yUjWNPOk/p
 ykiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716809224; x=1717414024;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pvZFfc1JrD0uZx4TxCsfgTmAeXb0pRwZtVzdOINWG30=;
 b=woo+eyfWdp1iMj6/rhdt4/kxEfSvkBv9IWYilh3paV3l1Rf26TupHNkPI3dDHuGzgC
 XIbrEPx18L2q0F9ZhfZle12idN5fa1cN9aP9S3al3JR54UMiDgy4gN8yXdrj0JbQVTED
 0cGlcd9ZXd/Mj2CdVjN0ETkzfk1/eAzFXD26wrI965dKUwTH9x6MM482Uyg/MS0vdvZ1
 e1vFh2JD9psR+SwtrczA1BdsJzwdhDbQg1YqRlgXt4GoDoCmZxnouA4Za9NXje7Phu7o
 Xyk9OgkKBTfOyFGwDkqRn29uMgHyO/RcfmjJ7WHEGXkzttWEVm6NeS68oRsR/5w2iEGz
 7mQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVayGUPSQ7ujbyyFfyMwIRAlYMtwdCFSgURb+MIxI6El5o6pdjMyyHS90nJL2WA5tN4iwWYGh5n4V93lrOcVma+GxG8qcg=
X-Gm-Message-State: AOJu0YxbzbLsJeOJorH93OnmuGnUG4xaVlv2TVcGzp77IktUEHXL3e84
 tjGQVKiNMS3bKgyEEmRZhWD637WSPsA8oZIIOYVxhhWQ//cHeYJK
X-Google-Smtp-Source: AGHT+IHrj4N4KI9DLk3R+8hHn32a6rJYRYWYiQ8ebPLFlfo1NdrDkw5u40r5eToMBxM/wAEJmIIZ3Q==
X-Received: by 2002:a05:6a00:300d:b0:6f8:d95b:9467 with SMTP id
 d2e1a72fcca58-6f8f329f88dmr11335294b3a.13.1716809223568; 
 Mon, 27 May 2024 04:27:03 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6822654961fsm5651455a12.67.2024.05.27.04.27.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 04:27:03 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 May 2024 21:26:58 +1000
Message-Id: <D1KE2R5951UL.10T7UNCCZZPBU@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/3] tests/qtest/migration-test: Quieten ppc64 QEMU
 warnigns
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Thomas Huth" <thuth@redhat.com>, "Fabiano Rosas" <farosas@suse.de>
X-Mailer: aerc 0.17.0
References: <20240525031330.196609-1-npiggin@gmail.com>
 <20240525031330.196609-2-npiggin@gmail.com>
 <98ec8131-2b81-4e40-abfc-d5fbcf1b41d8@redhat.com>
In-Reply-To: <98ec8131-2b81-4e40-abfc-d5fbcf1b41d8@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon May 27, 2024 at 5:32 PM AEST, Thomas Huth wrote:
> On 25/05/2024 05.13, Nicholas Piggin wrote:
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   tests/qtest/migration-test.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.=
c
> > index b7e3406471..c13535c37d 100644
> > --- a/tests/qtest/migration-test.c
> > +++ b/tests/qtest/migration-test.c
> > @@ -21,6 +21,7 @@
> >   #include "chardev/char.h"
> >   #include "crypto/tlscredspsk.h"
> >   #include "qapi/qmp/qlist.h"
> > +#include "libqos/libqos-spapr.h"
>
> It's a little bit unfortunate to include a libqos header in a non-qos tes=
t=20
> ... so in case you respin, maybe add a comment at the end of the line lik=
e:
>
>    /* just for PSERIES_DEFAULT_CAPABILITIES */
>
> ?

Same as other uses of it by the looks. Could just put it in a new
header in tests/qtest/ppc-util.h or something?

Thanks,
Nick

>
> >   #include "migration-helpers.h"
> >   #include "tests/migration/migration-test.h"
> > @@ -742,7 +743,8 @@ static int test_migrate_start(QTestState **from, QT=
estState **to,
> >                                         "until'", end_address, start_ad=
dress);
> >           machine_alias =3D "pseries";
> >           machine_opts =3D "vsmt=3D8";
> > -        arch_opts =3D g_strdup("-nodefaults");
> > +        arch_opts =3D g_strdup_printf("-nodefaults "
> > +                        "-machine " PSERIES_DEFAULT_CAPABILITIES);
> >       } else if (strcmp(arch, "aarch64") =3D=3D 0) {
> >           memory_size =3D "150M";
> >           machine_alias =3D "virt";
>
>   Reviewed-by: Thomas Huth <thuth@redhat.com>


