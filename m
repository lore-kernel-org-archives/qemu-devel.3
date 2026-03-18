Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2A810854DB
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nR1-0003dc-0j; Wed, 18 Mar 2026 05:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2nQz-0003Yu-GC
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:43:25 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2nQx-0007BY-PO
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:43:25 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-38704f70ea3so4568611fa.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 02:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773827000; cv=none;
 d=google.com; s=arc-20240605;
 b=NASOs4A0+Mkue40pe0+GyZPai96os/GhlTY7971N53dC62upOxGKbpHJpoYeVxtjoh
 /XhHKccMEHjRhcBRlAIwrgU2UFaaIWX32bm2lV1zcXuj6kRJm1UzpXj7v62Oc5WFVS+b
 76XDYuAO6M086ghVmlnEb19ADaFoxXWZOV/K+kFJv58SY+xwFrtrI2BSx6HwMXN/OGFo
 ktTV3jS+5vMB1wrV6i/gMCu82jHwiV5No030Sbl6cEKbngCZsKvNfTK7R+jGEfUy6xU/
 9jxiUy9ib5KeYQe2Do4QGWOTuUxqJLyiQdwSXX4d85vDxawOJuCUiUNR/XKEFYlzT99h
 zhVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IJxwf5SgzfLhgADZeXzYRku4DwbWvAvx8RIxt6kQKis=;
 fh=D9TiOsAcOSpRlHrkA38ELZyIVSvZmg48LLzTtJLYv+0=;
 b=AGKFoWmXBMi98Ub4OF2w9iDAXR3COO+MGRS4xkq1A2JVcQg7uXoA3C9zIYXKqy7hk7
 Bw7i6W5wf45Y7RDgKldxE07IWOxqvBbxIc2SQmxSzD5QeBIeSfd13L79Th/530uoBaZr
 VGBa9PEBGlTjRtlYl6maXpRFnBMLlyNOgrrSb5pDzM8dcTXiu7n/7v8Zb46L9o95T9bk
 es8hozzUCgPJDGM0cDTjNRgY7b6fQR3HneT3eFlIQgD7Q3DySSUxBSj4z9CpxGzl2rR1
 VDleaw7rkJKwokwaXB8JXTc2bUx2BcwQd7KsJgaZBHlquha7MnZswwfWo79Jj8cC5PdM
 G9dg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773827000; x=1774431800; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJxwf5SgzfLhgADZeXzYRku4DwbWvAvx8RIxt6kQKis=;
 b=eMH/N8QQqcYA6V+2ANACZ4TWJUl9NTxJhpgOfX+nENjH9YjX+RRdDWzHMGi/+vp8Ft
 +GkLh7ep0vG8wEDiduylYRM8O3PQjQzim780y4b9fokgZyzP0BNiuzwMx0xWWKMmKQkv
 oOzqFqHRW8+TjGtV31Bv3WhD0vIx2OP3uTbQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773827000; x=1774431800;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IJxwf5SgzfLhgADZeXzYRku4DwbWvAvx8RIxt6kQKis=;
 b=kMMAIE4AQnVvUTtZJNdWAR85fs5CwBXHA95e/XcslPK8gPmwdxhqk/ccbZZFP5+pUC
 6AFzyfcdw6+jraliAnTQi2bL7WfpBIcVVv4a2aNO5fSfGi7biYTUKNlUyzF9Uj4CPgcL
 wd/Wj/WldnWMMgr3UmhQhwYYlAs2+BbnJw4Yn/XeinPke1sxeMkKl4ttYKt7CmjTFay6
 xNjNUCFSrPl3Tbp57E3fDo/i+ineU+LBRFH0U2NvoKa8WS4Zn/E/0wGfzXLD7FvDsuhY
 y/HwXp0DoisgP/wLD9BPkT4n+ioSCF/av2sPQPM5Q7XG/xujGa1qHvNykARD2Ef2VdEw
 g+ag==
X-Gm-Message-State: AOJu0Yyvh7oomWuk3biQZtrQHcaDIqzAKrRIiucRbCEPpqWJ9ZnvTTvk
 WozykY21c9Vk9yEmz1rijiOkxajXVK2r3hHYN8aC53c/hy+CoUApWmrIuZKalJVJNHgA38biBlw
 0dbzMOSVS727dtt0jP9aGrIRyqffCh2Z9Ey+C4oZDsA==
X-Gm-Gg: ATEYQzyW3ySaPznCqpC43EfbiUtSAQDCcwpgBJHuEX0yUr+3/FdRBgoZlqPfzbKWEeR
 GtpjoNV7q9BfFwtFhzaoAalZwsOhxOoR+EKsKqNKbCVyexAEqsmCdwrs7KO1tBoDx4dXtCt0kz1
 lFPZ+HbxUYPzFGp21f1Fp92kGnqMwrmlHboZEAVcrN1BOXqx1SD5R6IYbaXbtZ1zwk0hxoHT2cU
 JoVmxX3wUzhHjIEZdo+HSyh9Hv0EyotJ+qnzSJDU4zV3RvjOnsGyEY/3ENif3mP4bcgxczV0f8F
 NWLsdUCJPj7gabx8XqN8FHh8ZyU9DkSDkuIUX6hdmZEmbmkwtA==
X-Received: by 2002:a2e:3805:0:b0:385:c7f0:2b1a with SMTP id
 38308e7fff4ca-38bd5abc7b4mr7954701fa.33.1773826999545; Wed, 18 Mar 2026
 02:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260317232332.15209-1-peterx@redhat.com>
 <20260317232332.15209-5-peterx@redhat.com>
In-Reply-To: <20260317232332.15209-5-peterx@redhat.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 18 Mar 2026 10:43:07 +0100
X-Gm-Features: AaiRm53vHVlniclOpffE9mQZ_47FV2VdeGjuw8jepysAm4jirklaPgEiC5GHTQE
Message-ID: <CAJqdLrqnADRVnnZMnEoHkgbmuF9GC1qnu6k0SbqeW=_p+1MbPw@mail.gmail.com>
Subject: Re: [PATCH RFC 04/10] vmstate: Limit the vmdesc_loop dedup trick to
 compressable field
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=alexander@mihalicyn.com; helo=mail-lj1-x22d.google.com
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

Am Mi., 18. M=C3=A4rz 2026 um 00:23 Uhr schrieb Peter Xu <peterx@redhat.com=
>:
>
> We have a trick in vmstate_save_vmsd_v() where we will try to compress
> multiple JSON vmstate field dumps into one line with a count to avoid
> duplicated entries.
>
> That only applies to the cases where vmsd_can_compress() should return
> true.  For example, vmsd_desc_field_start() later (who will take the
> updated max_elems as the last parameter) will ignore the value passed in
> when vmsd_can_compress() returns false.
>
> Add that check to the trick too, it will be used later to bypass this log=
ic
> to some special new VMSD fields.
>
> No functional change intended in this patch alone.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  migration/vmstate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index e29a8c3f49..caa7b50bce 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -578,7 +578,8 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VM=
StateDescription *vmsd,
>                  }
>
>                  /*
> -                 * This logic only matters when dumping VM Desc.
> +                 * This logic only matters when dumping VM Desc, and onl=
y
> +                 * when the VMSD field can be compressed.
>                   *
>                   * Due to the fake nullptr handling above, if there's mi=
xed
>                   * null/non-null data, it doesn't make sense to emit a
> @@ -587,7 +588,8 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VM=
StateDescription *vmsd,
>                   * vs. nullptr). Search ahead for the next null/non-null=
 element
>                   * and start a new compressed array if found.
>                   */
> -                if (vmdesc && (field->flags & VMS_ARRAY_OF_POINTER) &&
> +                if (vmdesc && vmsd_can_compress(field) &&
> +                    (field->flags & VMS_ARRAY_OF_POINTER) &&
>                      is_null !=3D is_prev_null) {
>
>                      is_prev_null =3D is_null;
> --
> 2.50.1
>

