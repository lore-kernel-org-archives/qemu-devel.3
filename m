Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3E6C5CFC1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 05:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wv6eD-0005UE-Al; Sat, 15 Aug 2026 01:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wv6eB-0005U5-Iv
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 01:09:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wv6e8-0004KC-Nn
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 01:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786770566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y4PSiDnrZtXYZVLVOpdyDVlZvTLW99fTF18yniemprE=;
 b=QtLES+RrKEkLlDPs9V3efwzOrlv48zi8cDt419MQN5k413Yhkuzwvg466gJDN9znBxq4HB
 Zf2FdBOuJSXQ+2iSLy2Po1b2svf2zHAwpdqipeOTdd4ukz/gHvSXJq3vX69v8a1ZoqMBz8
 RVsh1yxeBtn25Irv580VqSH32YBremk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-zGnFL2JvP8aXgTZb_kjMCg-1; Sat, 15 Aug 2026 01:09:24 -0400
X-MC-Unique: zGnFL2JvP8aXgTZb_kjMCg-1
X-Mimecast-MFC-AGG-ID: zGnFL2JvP8aXgTZb_kjMCg_1786770564
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8f113592bf3so30618556d6.2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 22:09:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786770564; cv=none;
 d=google.com; s=arc-20260327;
 b=senp17A8FkL6A0TxSIRcKlHIkJwcFqi9ug1hn5T+iwiafBGYh0KXwdrbiqGpSvUkL7
 pLjnxeMFRnQ4nFUqLj5f+HSk0MwB0hmbLwM4S0ieLHdvIK1GzqWYTbrfF0U7oOOG2//D
 0NadGq8u3jKIeZW0pYWJc0kiEuScncdAcI8fI0X28gzwGk+w7zhdSOQ9WWi9liwlu5+E
 oaxx87QCAnRCy27zbrMlAWDI1G3vV6+1/NDTPOymoFqSqylC7tHqsuq0rz4mZ/vCSN9n
 cttKqMRlHWsZ2VhovBaI+WVP/Z2xiNwrxwbmNp0hTcq5tVx5pWCMm1TW8di3gxp+vcDP
 5mRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Y4PSiDnrZtXYZVLVOpdyDVlZvTLW99fTF18yniemprE=;
 fh=gSnfsrtcN2qVaQ1W3IvizQdGmSYLtEvNm7mT74ak584=;
 b=AJqcb6rDNu4CigyWACLIwPQ+OlNEJ9zBKB6Rh8zth/i8tjRz66jUfkEWJTPcanMbSq
 kwnnEuBQh1uM0vDWW6GlmIwUsEBPlzFYN8OlfFLI3ZL54F0yP6vwgjfGt2NWVFWE2wyK
 34jSILpniBlCN4XP8YZWEl3QSLup8PSfPqnU62SIKPMOE1pH8qofxtTmbbNxUqFEy05x
 Km4cQbN/4GmZtDFRkcAsWxK5woZVfPfzMPV4GZDeYMaezDCAbW5owHEWzIdsGnMyghUX
 DNyG7oGRsk/Mbg4kBk3RbSJvfTit38eTVM2jreIERn+Llq8nT0H7D8ceGhknb8tvFc6y
 KGBA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786770564; x=1787375364; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y4PSiDnrZtXYZVLVOpdyDVlZvTLW99fTF18yniemprE=;
 b=Ipv9+b6DlxXdAejSWI/ycP+jCLhAK/TtuTsZp6Rcf06URcQF3fG1sQ627sKEb+1SXf
 ZLeU+4Ot0rp7cp0cInhebm5OnCikGB7pUuvUQl+R+GdtThbNt/1e7HFS3Gin8jEocPdz
 MZl7QS/IbL9qmMhXa2G2fDAKiLS+beXhu5rYr0lv0tvhGOwqrovPcgqdjZOWXbosNaQH
 6c66uQyOEe9FJZJj6FJ35qC6XCv/y6/dryfsj/AlILq5wteTdsT82aVpwfO/i7ccLIbs
 TyCGGRDJi6uU9zCJCfrneR29/R5XKPNF7Sd3SgdpqcnWTOrWwpl0dvEKzRW98/klHfKE
 q5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786770564; x=1787375364;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y4PSiDnrZtXYZVLVOpdyDVlZvTLW99fTF18yniemprE=;
 b=MfPUVIYxYmXD6/6bxdNCKUgNyzGrIyh2TD2aw7Sz8H6+R6X7RZoLt4YGxCZlwmkeWI
 Bq/J2cicagZEacgC1hRMe+yCG5KpFNwH4deD7yFHJwyX7b41kjvFAkr2rxAgfDK84mSA
 1+Fw0V+5m44i2hQB8o5G7/mdeXJDCFBcfswWZ2zZQRcsDzSZ72sgeW0gt5fWlBqsU3PD
 56vl3OLBivMYjTkdOVElKY1ZXyqbVAO/JzzJSzfyPwvFlaudL499sOMc9gXoTcHiTFzC
 iGbgdZ/pU7Q6ByBa+5M5qRNLKP2FeeEqW+Pcyx2pqM8rKtfGySTezHDAmAVtn3ri2WrE
 LZUg==
X-Gm-Message-State: AOJu0Yyfw8hJp+fEquCNtqLtcZzmaXp/DfIvV8qM2AEhvMmnKUQD2Er3
 K3BySUD77qqQlMJAGArFaJw4s94hBpLu52I5ugNaUhJQY2xPA3PvWIte4qli3vGtQa6qt56M6cE
 iqAKDiT9TAEhrz/kU39p59ZuUGwrAS3WgGwYeJClLCyRZaXSpvVajO8CAT+CAa9PgkPQXDTNA5Z
 W3Ks/sPR15k9HfRYrcqXQyLa6mEeqEV6k=
X-Gm-Gg: AR+sD10edV8kVZvzK7mMo/ipvdRKXXxakJH8eIndj4OuenSmEnOfPHtsSlkFqJ1KCPw
 cm6EE1AfgOlOEMRF7t4fBPeqaWCVQ+slv4LUS51JNpQXL2VH1GqE1/uwliZEjIKd6Tdn4ff5Ypt
 mDfcahkB1VspUsCde8I6dgqSYwD2YNZq+AsXeX7hs1kjHT4eQUx2/n2ZKbtt8VM15N3drPd7GNs
 ivfl/qi9r9ni0zekA==
X-Received: by 2002:ad4:4eec:0:b0:8f6:8d46:5f47 with SMTP id
 6a1803df08f44-90a91c90282mr121778826d6.5.1786770563977; 
 Fri, 14 Aug 2026 22:09:23 -0700 (PDT)
X-Received: by 2002:ad4:4eec:0:b0:8f6:8d46:5f47 with SMTP id
 6a1803df08f44-90a91c90282mr121778516d6.5.1786770563455; Fri, 14 Aug 2026
 22:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260815042845.184329-1-anisinha@redhat.com>
In-Reply-To: <20260815042845.184329-1-anisinha@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Sat, 15 Aug 2026 10:39:12 +0530
X-Gm-Features: AcwNN1WdMZVdrDAyL7EhuLhzm_QO5eOJKOOV9Vg05TYX-XvQfmhT9_KX-tuXujo
Message-ID: <CAK3XEhO3d1C02AkywDoU1OvbMJGyDPmprYcfJk0LQa+agpG_Ow@mail.gmail.com>
Subject: Re: [PATCH] test/qtest/launchupdate: add another test to exercise
 load and set host igvm
To: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.751,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Aug 15, 2026 at 9:59=E2=80=AFAM Ani Sinha <anisinha@redhat.com> wro=
te:
>
> A new test is added that loads a new IGVM bundle and sets host igvm
> ctrl at the same time. The expected behavior is that first reset will loa=
d
> the passed IGVM. The second reset will restore the original host provided=
 IGVM.
> This test exercizes this functionality.
>
> Some refactoring is also done at the same time to re-use common operation=
s from
> within multiple test routines.

This applies on top of the v5 patchset here
https://lists.gnu.org/archive/html/qemu-devel/2026-08/msg02509.html

>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  tests/qtest/launchupdate-test.c | 245 +++++++++++++++++++++++++++-----
>  1 file changed, 210 insertions(+), 35 deletions(-)
>
> diff --git a/tests/qtest/launchupdate-test.c b/tests/qtest/launchupdate-t=
est.c
> index 89a117dfe4..de780eac62 100644
> --- a/tests/qtest/launchupdate-test.c
> +++ b/tests/qtest/launchupdate-test.c
> @@ -248,6 +248,68 @@ static int wait_for_match(char *serial_f,
>      return ret;
>  }
>
> +static void set_test_params(const char **igvm_f, const char **igvm_init,
> +                            const char **snp, const char **cgs)
> +{
> +    if (confidential) {
> +        *snp =3D "-object \'{\"qom-type\":\"sev-snp-guest\",\"id\":\"lse=
c0\","
> +            "\"cbitpos\":51,\"reduced-phys-bits\":1,\"policy\":196608}\'=
";
> +        *cgs =3D "confidential-guest-support=3Dlsec0";
> +        /*
> +         * The following two IGVM files can be built from the source
> +         * present in https://gitlab.com/anisinha/virt-firmware-rs .
> +         * Typing 'make' from the top of this repository will build the
> +         * IGVM files for both confidential and
> +         * non-confidential tests. The IGVM files for the non-coco
> +         * case has been checked-in into the QEMU repository for
> +         * convenience and easy CI pipeline testing.
> +         */
> +        *igvm_f =3D "tests/data/igvm/snptest.igvm"; /* prints 'hello wor=
ld' */
> +        *igvm_init =3D "tests/data/igvm/snptest-nohello.igvm";
> +    } else {
> +        *igvm_f =3D "tests/data/igvm/hello.igvm";
> +        *igvm_init =3D "tests/data/igvm/qemuinit.igvm";
> +        *snp =3D "";
> +        *cgs =3D "";
> +    }
> +
> +    return;
> +}
> +
> +static void set_expected_out(const char **exp_out, const char **exp_out2=
,
> +                             const char **exp_out3)
> +{
> +    *exp_out =3D "Hello world!";
> +    *exp_out2 =3D "Test succeeded!";
> +    *exp_out3 =3D "boot process complete with initial igvm";
> +
> +    return;
> +}
> +
> +static QOSState *set_qemu_args(const char *cgs, const char *tp, char *se=
rialf,
> +                               const char *igvm_init, const char *snp)
> +{
> +    QOSState *qs;
> +
> +    if (tp) {
> +        qs =3D qtest_pc_boot("-machine q35,igvm-cfg=3Digvm0,%s -m 1G -ac=
cel kvm "
> +                           "-device vm-launch-update %s "
> +                           "-chardev file,id=3Dserial0,path=3D%s "
> +                           "-serial chardev:serial0 "
> +                           "-object igvm-cfg,id=3Digvm0,file=3D%s %s",
> +                           cgs, tp, serialf, igvm_init, snp);
> +    } else {
> +        qs =3D qtest_pc_boot("-machine q35,igvm-cfg=3Digvm0,%s -m 1G -ac=
cel kvm "
> +                           "-device vm-launch-update "
> +                           "-chardev file,id=3Dserial0,path=3D%s "
> +                           "-serial chardev:serial0 "
> +                           "-object igvm-cfg,id=3Digvm0,file=3D%s %s",
> +                           cgs, serialf, igvm_init, snp);
> +    }
> +
> +    return qs;
> +}
> +
>  static void test_load_igvm(void)
>  {
>      const char *igvm_f;
> @@ -255,9 +317,9 @@ static void test_load_igvm(void)
>      int ser_fd;
>      g_autofree void *igvm_blob =3D NULL;
>      g_autofree char *serialtmp =3D NULL;
> -    const char exp_out[] =3D "Hello world!";
> -    const char exp_out2[] =3D "Test succeeded!";
> -    const char exp_out3[] =3D "boot process complete with initial igvm";
> +    const char *exp_out;
> +    const char *exp_out2;
> +    const char *exp_out3;
>      const char *tracepoints =3D "--trace memory_region_finalize "
>          "--trace qigvm_cleanup_memory -D /tmp/qemu-debug.log ";
>      const char *snp, *cgs;
> @@ -268,35 +330,13 @@ static void test_load_igvm(void)
>      QOSState *qs;
>      VMLaunchUpdate launch_update;
>
> -    if (confidential) {
> -        snp =3D "-object \'{\"qom-type\":\"sev-snp-guest\",\"id\":\"lsec=
0\","
> -            "\"cbitpos\":51,\"reduced-phys-bits\":1,\"policy\":196608}\'=
";
> -        cgs =3D "confidential-guest-support=3Dlsec0";
> -        /*
> -         * The following two IGVM files can be built from the source
> -         * present in https://gitlab.com/anisinha/virt-firmware-rs .
> -         * Typing 'make' from the top of this repository will build the
> -         * IGVM files for both confidential and
> -         * non-confidential tests. The IGVM files for the non-coco
> -         * case has been checked-in into the QEMU repository for
> -         * convenience and easy CI pipeline testing.
> -         */
> -        igvm_f =3D "tests/data/igvm/snptest.igvm"; /*
> -                                                  * this prints 'hello w=
orld'
> -                                                  * on console
> -                                                  */
> -        igvm_init =3D "tests/data/igvm/snptest-nohello.igvm";
> -    } else {
> -        igvm_f =3D "tests/data/igvm/hello.igvm";
> -        igvm_init =3D "tests/data/igvm/qemuinit.igvm";
> -        snp =3D "";
> -        cgs =3D "";
> -    }
> -
>      if (!trace) {
>          tracepoints =3D "";
>      }
>
> +    set_test_params(&igvm_f, &igvm_init, &snp, &cgs);
> +    set_expected_out(&exp_out, &exp_out2, &exp_out3);
> +
>      if (!g_file_test(igvm_f, G_FILE_TEST_EXISTS) ||
>          !g_file_test(igvm_init, G_FILE_TEST_EXISTS)) {
>          g_test_skip("igvm file bundle(s) does not exist!");
> @@ -326,12 +366,7 @@ static void test_load_igvm(void)
>          fprintf(stderr, "serial console file is %s\n", serialtmp);
>      }
>
> -    qs =3D qtest_pc_boot("-machine q35,igvm-cfg=3Digvm0,%s -m 1G -accel =
kvm "
> -                       "-device vm-launch-update %s "
> -                       "-chardev file,id=3Dserial0,path=3D%s "
> -                       "-serial chardev:serial0 "
> -                       "-object igvm-cfg,id=3Digvm0,file=3D%s %s",
> -                       cgs, tracepoints, serialtmp, igvm_init, snp);
> +    qs =3D set_qemu_args(cgs, tracepoints, serialtmp, igvm_init, snp);
>
>      fw_cfg =3D pc_fw_cfg_init(qs->qts);
>
> @@ -342,6 +377,11 @@ static void test_load_igvm(void)
>
>      /* exp_out3 should be printed once from initial boot */
>      g_assert_true(wait_for_match(serialtmp, exp_out3, WAIT_SEC, 1) =3D=
=3D 0);
> +
> +    if (debug) {
> +        fprintf(stderr, "initially booted with host igvm\n");
> +    }
> +
>      g_assert_true(load_image(igvm_f, &igvm_blob, &igvm_sz) =3D=3D igvm_s=
z);
>
>      /* create a data buffer in guest memory */
> @@ -389,7 +429,7 @@ static void test_load_igvm(void)
>
>      /* check if VM_LAUNCHUPDATE_CTL_HOST_IGVM function works */
>
> -    /* set VM_LAUNCHUPDATE_CTL_HOST_IGVM control */
> +    /* set only VM_LAUNCHUPDATE_CTL_HOST_IGVM control without IGVM bundl=
e */
>      memset(&launch_update, 0, sizeof(launch_update));
>      launch_update.control |=3D VM_LAUNCHUPDATE_CTL_HOST_IGVM;
>
> @@ -410,6 +450,139 @@ static void test_load_igvm(void)
>       */
>      g_assert_true(wait_for_match(serialtmp, exp_out3, WAIT_SEC, 2) =3D=
=3D 0);
>
> +    if (debug) {
> +        fprintf(stderr, "booted with host igvm again\n");
> +    }
> +
> +    close(ser_fd);
> +    guest_free(&qs->alloc, gaddr);
> +    pc_fw_cfg_uninit(fw_cfg);
> +    /* qtest_quit() kils QEMU, first by sending SIGTERM, then SIGKILL */
> +    qtest_quit(qs->qts);
> +}
> +
> +static void test_set_ctrl_once_and_reset_to_host_igvm(void)
> +{
> +    const char *igvm_f;
> +    const char *igvm_init;
> +    int ser_fd;
> +    g_autofree void *igvm_blob =3D NULL;
> +    g_autofree char *serialtmp =3D NULL;
> +    const char *exp_out;
> +    const char *exp_out2;
> +    const char *exp_out3;
> +    const char *snp, *cgs;
> +    uint64_t gaddr;
> +    size_t igvm_sz;
> +    size_t filesize;
> +    QFWCFG *fw_cfg;
> +    QOSState *qs;
> +    VMLaunchUpdate launch_update;
> +
> +    set_test_params(&igvm_f, &igvm_init, &snp, &cgs);
> +    set_expected_out(&exp_out, &exp_out2, &exp_out3);
> +
> +    if (!g_file_test(igvm_f, G_FILE_TEST_EXISTS) ||
> +        !g_file_test(igvm_init, G_FILE_TEST_EXISTS)) {
> +        g_test_skip("igvm file bundle(s) does not exist!");
> +        return;
> +    }
> +
> +    if (!qtest_has_machine("q35")) {
> +        g_test_skip("q35 machine not available");
> +        return;
> +    }
> +
> +    if (!qtest_has_accel("kvm")) {
> +        g_test_skip("No KVM accelerator available");
> +        return;
> +    }
> +
> +    if (!qtest_has_device("vm-launch-update")) {
> +        g_test_skip("Device vm-launch-update is not available");
> +        return;
> +    }
> +
> +    ser_fd =3D g_file_open_tmp("launchupdate-qtest-serial-sXXXXXX",
> +                             &serialtmp, NULL);
> +    g_assert_true(ser_fd !=3D -1);
> +
> +    if (debug) {
> +        fprintf(stderr, "serial console file is %s\n", serialtmp);
> +    }
> +
> +    qs =3D set_qemu_args(cgs, NULL, serialtmp, igvm_init, snp);
> +
> +    fw_cfg =3D pc_fw_cfg_init(qs->qts);
> +
> +    g_assert_true(wait_for_match(serialtmp, exp_out3, WAIT_SEC, 1) =3D=
=3D 0);
> +
> +    if (debug) {
> +        fprintf(stderr, "initially booted with host igvm\n");
> +    }
> +
> +    g_assert_true(load_image(igvm_f, &igvm_blob, &igvm_sz) =3D=3D igvm_s=
z);
> +
> +    /* create a data buffer in guest memory */
> +    gaddr =3D guest_alloc(&qs->alloc, igvm_sz);
> +
> +    if (debug) {
> +        fprintf(stderr, "guest paddr: %"PRIx64 "  igvm size: %lu\n",
> +                gaddr, igvm_sz);
> +    }
> +
> +    if (debug) {
> +        fprintf(stderr, "writing igvm file into the guest memory\n");
> +    }
> +
> +    qtest_bufwrite(qs->qts, gaddr, igvm_blob, igvm_sz);
> +
> +    if (debug) {
> +        fprintf(stderr,
> +                "tell hypervisor where igvm is loaded in guest memory\n"=
);
> +    }
> +
> +    /* now tell hypervisor where we loaded the bios */
> +    memset(&launch_update, 0, sizeof(launch_update));
> +    launch_update.fw_image_size =3D cpu_to_le64(igvm_sz);
> +    launch_update.fw_image_addr =3D cpu_to_le64(gaddr);
> +
> +    /* set both host ctrl and format_igvm ctrl once */
> +    launch_update.control |=3D VM_LAUNCHUPDATE_FORMAT_IGVM;
> +    launch_update.control |=3D VM_LAUNCHUPDATE_CTL_HOST_IGVM;
> +
> +    filesize =3D qfw_cfg_write_file(fw_cfg, qs, FILE_VMLAUNCHUPDATE,
> +                                  &launch_update, sizeof(launch_update))=
;
> +    g_assert_cmpint(filesize, =3D=3D, sizeof(launch_update));
> +
> +    if (debug) {
> +        fprintf(stderr, "resetting the virtual machine. This should load=
 "
> +                "user provided igvm.\n");
> +    }
> +
> +    qtest_system_reset(qs->qts);
> +
> +    /* expected string should be printed on the console */
> +    g_assert_true(wait_for_match(serialtmp, exp_out, WAIT_SEC, 1) =3D=3D=
 0);
> +    g_assert_true(wait_for_match(serialtmp, exp_out2, WAIT_SEC, 1) =3D=
=3D 0);
> +
> +    if (debug) {
> +        fprintf(stderr, "hello world found on console\n");
> +        fprintf(stderr, "Now resetting again in order to reset to host i=
gvm\n");
> +    }
> +
> +    qtest_system_reset(qs->qts);
> +
> +    /*
> +     * exp_out3 should be printed twice, once from initial boot,
> +     * once from restoring host igvm.
> +     */
> +    g_assert_true(wait_for_match(serialtmp, exp_out3, WAIT_SEC, 2) =3D=
=3D 0);
> +
> +    if (debug) {
> +        fprintf(stderr, "booted with host igvm\n");
> +    }
> +
>      close(ser_fd);
>      guest_free(&qs->alloc, gaddr);
>      pc_fw_cfg_uninit(fw_cfg);
> @@ -435,6 +608,8 @@ int main(int argc, char **argv)
>      g_test_add_func("/vm-launch-update/errorcheck", check_error);
>      g_test_add_func("/vm-launch-update/load_igvm",
>                      test_load_igvm);
> +    g_test_add_func("/vm-launch-update/ctrl_set_once",
> +                    test_set_ctrl_once_and_reset_to_host_igvm);
>
>      if (getenv("LAUNCHUPDATE_DEBUG")) {
>          debug =3D true;
> --
> 2.54.0
>


