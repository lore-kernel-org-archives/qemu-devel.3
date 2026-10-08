Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530F0CA600D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 18:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEt8j-0007qu-0g; Thu, 08 Oct 2026 14:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEt8b-0007qH-U6
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 14:46:44 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEt8Z-0005Km-RA
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 14:46:41 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6acb57c2b88so7904030a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 11:46:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791485198; cv=none;
 d=google.com; s=arc-20260327;
 b=bTvtO9wruKj7jwV3dJi//2/vLTzMbeldoWzI9MBoHxPnotfdG/IIvfDUPH4ROnsUAm
 tsPfr8IGLBC9XKYiTcaQakv7IHAcitlennEB7ofB5DNGGFWK+N+GMJGIRgcwoaqE03Ql
 Ur45Nqq+jKZvYefXj8HUaaHwf/FK2KYjopJplTeNg/q/qCkOvVhIRYia+zEf+PxuN1fF
 /AYe3xiuQoKm/Xq++LmVEGtKrPYdUl+d6x3MrdcOt+3deDEX+6ZZl3cpj+xBv/bX8dTK
 iIJmKLyx8nDsJdnTAQf6ffPkWD0UfU7tqya1wFKivORgfjDAtzJP5fPqeOhVKNFxsNei
 HtAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=dQQizFoFxXO7jmGRggCp+qtuDoi/Kuo2xU5Am4AjH/Q=;
 fh=fcC5xiTM+92K8aIn1D3M8zZ4o+HUHgs5TohCXsve6Lc=;
 b=GsHOLlf5h/QNyWIuk49BTPu4+2wnD3Bvrx97c92if9DfrPjxq/rXt//9GlISN7jfu0
 Jmwk8JSyGwQnZO9PudybqvjsrbGndHTJrrjjpA7MAhSgfztD1D0aWnDY5RrzVeXRVAvS
 dhJfPPzfOx0QF6CSEXaBV0/DXSaNZaUmy1tzqoHPmCkYIKwcX7dUun+RA9cp1zCZ7hFc
 vileeK8viSdASvTyXmum1rMGAdhSrATgS/KSSQ7CMq3BF2qdll5aDJ+6FNnBr7xIe7rR
 RPw0OO/AoUm25HBaMtUHDfiosj7y5rfm7Pa5rRXrMVqVRPDoHJvXTC6XjA6GartWc/vs
 TgCA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791485198; x=1792089998; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dQQizFoFxXO7jmGRggCp+qtuDoi/Kuo2xU5Am4AjH/Q=;
 b=oy1BgvXKPuushkJ6TExy075vUcR/PP+6zWhDguqxIU3XvAL+2bRLYGZYaqX7hLJB3y
 w4x0fvmqnKi0P9D7SdF9wOcuKxE1Bu4PovqBGZwyKR4feVFdp/V2pHI+7pp/IxgxxmzR
 aPLiZE0Scwz4QgnVDdnnK//X/MHJm04HJNFezlFHzIRUxHttng/1sLmUriHEKhe7jr++
 V7ZbYtwUGSDlnzFod2l5X+VxRdoqYzsjO/d073VnZh2HflIyF9oiC7sSLAW5yMISSkK6
 +nS4CYb/APPbRvilFzL2kbfWxTr/0ecyL3d25K0O1y94FWLYiUKnaBnwGdQLWk6eq1Q/
 sNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791485198; x=1792089998;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dQQizFoFxXO7jmGRggCp+qtuDoi/Kuo2xU5Am4AjH/Q=;
 b=dONjC9WysCjIB/wUT0jiCJjBDZyEisS/N3Ru0+GXbnIPbFPjaH0iNP9bwTUj+K5WNu
 l8080NFrzB89h+e6wC0LrrDqjJTJrTTpi5LVWgYptLgu1dSwHsrdpFsxNoshBl9vwvuL
 p6O2uZXcdxVeUpzYGgEXfk13qXBQd5RZyiT2oaxJpaQr9H6FGYHkga4EphazLNjqwHfP
 H5b2zJndjBMtZvFRRRFpycJVSUCSvsyqFapXQeKT8yMvx9RfWGhOzqdr761nY0J3ZYfO
 bTfAbyH//sb8aJ8mf4Z6tDs4CQpGNvj0647/e9565yt32zSe0p6MUksHhpLVfZz52B0n
 tD6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/5BPi+S22GHu25gmUfW/HksUtEQtgpcTddWHDqwZewaphqNRlHWpyDb1l6UsIR2te5Qjz3Xyk5znF@nongnu.org
X-Gm-Message-State: AFq9FYLHCHrLwofLNKmMLLd2WR2H4Rp24uNiMpZ0Q3XT3FcYlPqgFFQU
 GNVedAtyPS3Mm9wWg2lnXjGsY5lz721PC//bgSvmkyxFcvxXbbztiPhk73KGiLaigboEECx953I
 lldBvOjn0X33iA/2ps+/i+7HwckFDzNQ=
X-Gm-Gg: AYBFou3cjFQ3R+9gQARkd3sxVsAt6kPl+c5kYC3iGg1ext7g+5EVoyP3pKgSHt+pSpp
 lNXIpfnFa3S4Ol9/PBPL82ghFmcacowbFgB7j9h4Q7+oeXlEsgSWjvhzZS322GOdEWqsM89cEUo
 ECntZPtG/YZRVBHbSInEnTtZWRIK/cyakXxl2vBKztfm4G9TgUXlWgoCQFGbUm9jZXWrMpfcTuE
 QBvlSotZb0RQZwoPgWfyWCoqa+1ZzcWwXpFgUdbKAHz1JdgIhEIZQJJ1SBC/PtEPTOJyBfWBLV3
 lR5/MOtNTWX6/btQ9t0qnyCdiCeNVTg6iGiCBMtNkhTI8wNeNPFj0VNF
X-Received: by 2002:a05:6402:11d0:b0:6a9:f88d:c092 with SMTP id
 4fb4d7f45d1cf-6aff2dacbabmr6153592a12.0.1791485197448; Thu, 08 Oct 2026
 11:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20261008153435.207538-1-zycai@linux.ibm.com>
 <ase6pruX6UM-umNQ@redhat.com>
In-Reply-To: <ase6pruX6UM-umNQ@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 9 Oct 2026 02:46:24 +0800
X-Gm-Features: AclHuK9pXxDTNirNgeHjSpg9wUROW61urar-Nx_M4wUCOmYtz8ickPAyKQ_LTrw
Message-ID: <CAE2XoE9Dg2CQGF9uQvM2=LEaXdGR+1Djt0DnYxntfASP-uD5OQ@mail.gmail.com>
Subject: Re: [PATCH v1] test/qtest: Remove s390x boot device support check in
 pxe-test.c
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, 
 shentey@gmail.com, cohuck@redhat.com, farman@linux.ibm.com, 
 mjrosato@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52f.google.com
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

On Thu, Oct 8, 2026 at 11:47=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Thu, Oct 08, 2026 at 11:34:35AM -0400, Zhuoying Cai wrote:
> > The s390x PXE tests used `memmem` to probe the s390-ccw.img firmware
> > for device support strings before running each test. MinGW-w64 does
> > not provide `memmem`, breaking the MSYS2/GCC build.
> >
> > Remove the check as a workaround.
>
> Removing the testing on every platform due to a Windows limitation
> is rather a big hammer. Why not wrap the code in  #ifndef WIN32   ?

I did it in another way:
[PATCH 0/2] tests/qtest: fix and gaurd PXE test build on MinGW
https://lore.kernel.org/qemu-devel/20261008184119.142-1-luoyonggang@gmail.c=
om/T/#t


>
> >
> > Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> > Reported-by: Bernhard Beschow <shentey@gmail.com>
> > ---
> >  tests/qtest/pxe-test.c | 97 +-----------------------------------------
> >  1 file changed, 2 insertions(+), 95 deletions(-)
> >
> > diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
> > index 61c92a2df4..51e6bdac2a 100644
> > --- a/tests/qtest/pxe-test.c
> > +++ b/tests/qtest/pxe-test.c
> > @@ -26,7 +26,6 @@ typedef struct testdef {
> >      const char *machine;    /* Machine type */
> >      const char *model;      /* NIC device model */
> >      const char *extra;      /* Any additional parameters */
> > -    bool (*boot_dev_support)(void); /* optional: boot device support c=
heck */
> >  } testdef_t;
> >
> >  static testdef_t x86_tests[] =3D {
> > @@ -59,91 +58,9 @@ static testdef_t ppc64_tests_slow[] =3D {
> >      { NULL },
> >  };
> >
> > -static const char *s390_bios_load(gsize *len)
> > -{
> > -    static char *cached_contents;
> > -    static gsize cached_len;
> > -    const char *qemu_bin;
> > -    g_autofree char *cmd =3D NULL;
> > -    char dir[PATH_MAX];
> > -    char *found =3D NULL;
> > -    char *path =3D NULL;
> > -    FILE *fp;
> > -
> > -    if (cached_contents) {
> > -        g_test_message("Using cached bios contents");
> > -        goto out;
> > -    }
> > -
> > -    /* search the qemu binary's data directories for s390-ccw.img */
> > -    qemu_bin =3D qtest_qemu_binary(NULL);
> > -    cmd =3D g_strdup_printf("%s -L help", qemu_bin);
> > -    fp =3D popen(cmd, "r");
> > -
> > -    if (!fp) {
> > -        g_error("Failed to run '%s'", cmd);
> > -    }
> > -
> > -    while (fgets(dir, sizeof(dir), fp) && !found) {
> > -        dir[strcspn(dir, "\n")] =3D '\0';
> > -        path =3D g_build_filename(dir, "s390-ccw.img", NULL);
> > -        if (g_file_get_contents(path, &cached_contents, &cached_len, N=
ULL)) {
> > -            found =3D path;
> > -        } else {
> > -            g_free(path);
> > -        }
> > -    }
> > -    pclose(fp);
> > -
> > -    if (!found) {
> > -        g_error("s390-ccw.img not found");
> > -    }
> > -
> > -    g_test_message("Loaded %s", found);
> > -    g_free(found);
> > -
> > -out:
> > -    *len =3D cached_len;
> > -    return cached_contents;
> > -}
> > -
> > -static bool s390_bios_has_string(const char *needle)
> > -{
> > -    const char *contents;
> > -    gsize len;
> > -    bool found;
> > -
> > -    contents =3D s390_bios_load(&len);
> > -    found =3D memmem(contents, len, needle, strlen(needle)) !=3D NULL;
> > -
> > -    g_test_message("\"%s\" %s in bios", needle, found ? "found" : "not=
 found");
> > -    return found;
> > -}
> > -
> > -static bool s390_bios_has_net_ccw(void)
> > -{
> > -    /*
> > -     * Assume that netboot support always includes virtio-net-ccw supp=
ort.
> > -     * Check only that netboot code exists, rather than probing virtio=
-net-ccw
> > -     * support directly.
> > -     */
> > -    return s390_bios_has_string("Network boot starting...");
> > -}
> > -
> > -static bool s390_bios_has_net_pci(void)
> > -{
> > -    /*
> > -     * Check for a string unique to virtio-net-pci boot support in the=
 bios
> > -     * to determine if the binary was built with support for this devi=
ce.
> > -     */
> > -    return s390_bios_has_string("Setup failed for virtio-net-pci");
> > -}
> > -
> >  static testdef_t s390x_tests[] =3D {
> > -    { "s390-ccw-virtio", "virtio-net-ccw",
> > -      .boot_dev_support =3D s390_bios_has_net_ccw },
> > -    { "s390-ccw-virtio", "virtio-net-pci",
> > -      .boot_dev_support =3D s390_bios_has_net_pci },
> > +    { "s390-ccw-virtio", "virtio-net-ccw"},
> > +    { "s390-ccw-virtio", "virtio-net-pci"},
> >      { NULL },
> >  };
> >
> > @@ -174,11 +91,6 @@ static void test_pxe_ipv4(gconstpointer data)
> >  {
> >      const testdef_t *test =3D data;
> >
> > -    if (test->boot_dev_support && !test->boot_dev_support()) {
> > -        g_test_skip("The bios does not support booting this device");
> > -        return;
> > -    }
> > -
> >      test_pxe_one(test, false);
> >  }
> >
> > @@ -186,11 +98,6 @@ static void test_pxe_ipv6(gconstpointer data)
> >  {
> >      const testdef_t *test =3D data;
> >
> > -    if (test->boot_dev_support && !test->boot_dev_support()) {
> > -        g_test_skip("The bios does not support booting this device");
> > -        return;
> > -    }
> > -
> >      test_pxe_one(test, true);
> >  }
> >
> > --
> > 2.56.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

