Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D936FC5CFC1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 06:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvr4u-0007s7-8R; Mon, 17 Aug 2026 02:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wvr4p-0007rf-UR
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 02:44:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wvr4m-0006ig-0a
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 02:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786949041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKgThnxQZPCTNgHr+TklIfGEqv4mPn08WOSgMz5t0P4=;
 b=Wovh3zXyvAOC9f7LGjLtmXkf/3ZJKjgbb/yIE7Ex0TqHnMYnFtNB7A6bOykSKyL2GKRv4U
 2CoqWoyFZdBDAmr1FbfTUuPlbqqxA2XEYIfjjvT0o99iXPmLA9FvSnztn+HluUDNkn6/My
 jUHOqFtYx+hsiFQbAIHUFR9/66SvPIc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-6BPv0-2BPi6fCU66k5CgaQ-1; Mon, 17 Aug 2026 02:43:59 -0400
X-MC-Unique: 6BPv0-2BPi6fCU66k5CgaQ-1
X-Mimecast-MFC-AGG-ID: 6BPv0-2BPi6fCU66k5CgaQ_1786949038
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8484ba00601so3036571b3a.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 23:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786949038; x=1787553838; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dKgThnxQZPCTNgHr+TklIfGEqv4mPn08WOSgMz5t0P4=;
 b=goMUVx7uGo2FWDmXcx2tv2eCV5H6x5i3QRCtoI0E8wutxuCwQ+DIxjeiC4vJDt29WW
 6qh7WxNe9SUoacYPokKhVNj3fMDpNTFW50IM1JN7JbgSdAvbA2NCXF3NNa23M5pTTEXT
 6Av1Dl15csZmordw+lly7iAsZ/t3fB4xr1BNUIqoTnbUnRznn0VfdPzmzkxxzNkGw/Jm
 I+o6QvqovZb81ki39wO0x+/M5S3u040P7HhUTZ50Sa3eYVqSc73Qp3z2EFTpzqNlXsqy
 6LWptDaTtZQ54CB8orcghmZbn8Yu4k4OrAgOAgMv8XFHaeo30j1t/2KvG8QGy+vkGnoX
 lqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786949038; x=1787553838;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dKgThnxQZPCTNgHr+TklIfGEqv4mPn08WOSgMz5t0P4=;
 b=sSk4RBRSIqkelcZ8ksuq6becb3/n7PVqr0ZKHbsqw5w7BVDE1400MvfPrjM+mj1dD6
 X0Jxv5qbDKm5vHlID6m094iT74ALURZTxHd0lGRxX4Io6LDB1egyc87bQODSzLT4+hNR
 fW9Y2tzyh3CW8698CowMhpPSHyuzdshPVtpKk+HTLTQBxUKYnQwPlf0juIOfH+vM57qK
 eXZ/O3kSq8sgUGSphYjZvmg3GUu4K7ntv0j4l/NC45EDv1O/7zNm9nZTFxKTPkq6lyeC
 FuYr/imgyqFluBGg++H80l/F7JAQIlpxIoNzhMJGECZL/HQitPZopqMuglaG+y6x4BZj
 Xwvw==
X-Gm-Message-State: AOJu0YxN8y8kocIKZ+r/Lj1EkfawedmHhYGpT8P/T0Y2EPTANm+qka0N
 2MpN8ixaTe5dUrfUIbIl/C7zen4Qmn13oOp4PRTzrdOBH1YPiVG/rNt5HRiDjMILiekLHBLg50Z
 Uso7W3fmn78ggiePwjquEOO4CXGkiIHuOkBs540adUyQ5yGBCV7GDa5Vn
X-Gm-Gg: AR+sD10e3mTgMdc03SWASVDJsL6llJ6pV5uzIuMRvGS9imqLqINs3609OLmyGNsLV/3
 A7pjNXFVfEkB7lxRKLDAnYqaGo8xGl9paK59/Sid6YnU/M6XfsmCN4l973k382Gin/0j6lKkksT
 0Y0Lhd8kvEoueV5pLJYr6z+VU6Rs1bhxG5kL+PB2MeW1odnGXp8CzjzqMykYyv58H2SzfcQqHJX
 eTQtk/1E6ZoF+qtBwQCX3yNZPZWWl/hciqrXh11TPNq4SvnRnSzpjaUQavhEJ/r8rDIiTV6zeny
 juHmtScOWsHmtoHCmVGamNbQYdNl7reksdQ65EGB4Quhm6gkGyUTxsXlDgQrlwN2IqgFrEjFcB6
 7f5BsPdubFBUZUAj6M5d/Q041/vGBYaLxdYyZYl7dJ6lThfrRnAdWrw==
X-Received: by 2002:a05:6a21:6494:b0:3bf:a0e5:999f with SMTP id
 adf61e73a8af0-3cc71c93b3fmr27203786637.22.1786949038118; 
 Sun, 16 Aug 2026 23:43:58 -0700 (PDT)
X-Received: by 2002:a05:6a21:6494:b0:3bf:a0e5:999f with SMTP id
 adf61e73a8af0-3cc71c93b3fmr27203723637.22.1786949037568; 
 Sun, 16 Aug 2026 23:43:57 -0700 (PDT)
Received: from smtpclient.apple ([106.219.133.98])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267be8e272sm2608416eec.17.2026.08.16.23.43.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 16 Aug 2026 23:43:57 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH] test/qtest/launchupdate: add another test to exercise
 load and set host igvm
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <CAK3XEhO3d1C02AkywDoU1OvbMJGyDPmprYcfJk0LQa+agpG_Ow@mail.gmail.com>
Date: Mon, 17 Aug 2026 12:13:42 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D1CE7121-3EFF-4A2D-B501-4AB19660244C@redhat.com>
References: <20260815042845.184329-1-anisinha@redhat.com>
 <CAK3XEhO3d1C02AkywDoU1OvbMJGyDPmprYcfJk0LQa+agpG_Ow@mail.gmail.com>
To: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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



> On 15 Aug 2026, at 10:39=E2=80=AFAM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
> On Sat, Aug 15, 2026 at 9:59=E2=80=AFAM Ani Sinha =
<anisinha@redhat.com> wrote:
>>=20
>> A new test is added that loads a new IGVM bundle and sets host igvm
>> ctrl at the same time. The expected behavior is that first reset will =
load
>> the passed IGVM. The second reset will restore the original host =
provided IGVM.
>> This test exercizes this functionality.
>>=20
>> Some refactoring is also done at the same time to re-use common =
operations from
>> within multiple test routines.
>=20
> This applies on top of the v5 patchset here
> https://lists.gnu.org/archive/html/qemu-devel/2026-08/msg02509.html

Tested this patch on CoCo and the test runs fine there =E2=80=A6

serial console file is /tmp/launchupdate-qtest-serial-sKLAJU3
# starting QEMU: exec ./qemu-system-x86_64 -qtest =
unix:/tmp/qtest-896542.sock -qtest-log /dev/null -chardev =
socket,path=3D/tmp/qtest-896542.qmp,id=3Dchar0 -object =
monitor-qmp,id=3Dqmp0,chardev=3Dchar0 -display none -audio none =
-run-with exit-with-parent=3Don -machine =
q35,igvm-cfg=3Digvm0,confidential-guest-support=3Dlsec0 -m 1G -accel kvm =
-device vm-launch-update -chardev =
file,id=3Dserial0,path=3D/tmp/launchupdate-qtest-serial-sKLAJU3 -serial =
chardev:serial0 -object =
igvm-cfg,id=3Digvm0,file=3Dtests/data/igvm/snptest-nohello.igvm -object =
'{"qom-type":"sev-snp-guest","id":"lsec0","cbitpos":51,"reduced-phys-bits"=
:1,"policy":196608}'  -accel qtest
initially booted with host igvm
guest paddr: 100000  igvm size: 195048
writing igvm file into the guest memory
tell hypervisor where igvm is loaded in guest memory
qemu-system-x86_64: info: vmlaunchupdate: new IGVM context set.
resetting the virtual machine. This should load user provided igvm.
qemu-system-x86_64: info: virtual machine state has been rebuilt with =
new guest file handle.
qemu-system-x86_64: info: vmlaunchupdate: next reset will use host igvm
hello world found on console
Now resetting again in order to reset to host igvm
qemu-system-x86_64: info: virtual machine state has been rebuilt with =
new guest file handle.
qemu-system-x86_64: info: restoring original host IGVM: =
tests/data/igvm/snptest-nohello.igvm
qemu-system-x86_64: info: vmlaunchupdate: host IGVM context set.
booted with host igvm
ok 5 /vm-launch-update/ctrl_set_once
# slow test /vm-launch-update/ctrl_set_once executed in 4.81 secs
# End of vm-launch-update tests


>=20
>>=20
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> tests/qtest/launchupdate-test.c | 245 =
+++++++++++++++++++++++++++-----
>> 1 file changed, 210 insertions(+), 35 deletions(-)
>>=20
>> diff --git a/tests/qtest/launchupdate-test.c =
b/tests/qtest/launchupdate-test.c
>> index 89a117dfe4..de780eac62 100644
>> --- a/tests/qtest/launchupdate-test.c
>> +++ b/tests/qtest/launchupdate-test.c
>> @@ -248,6 +248,68 @@ static int wait_for_match(char *serial_f,
>>     return ret;
>> }
>>=20
>> +static void set_test_params(const char **igvm_f, const char =
**igvm_init,
>> +                            const char **snp, const char **cgs)
>> +{
>> +    if (confidential) {
>> +        *snp =3D "-object =
\'{\"qom-type\":\"sev-snp-guest\",\"id\":\"lsec0\","
>> +            =
"\"cbitpos\":51,\"reduced-phys-bits\":1,\"policy\":196608}\'";
>> +        *cgs =3D "confidential-guest-support=3Dlsec0";
>> +        /*
>> +         * The following two IGVM files can be built from the source
>> +         * present in https://gitlab.com/anisinha/virt-firmware-rs .
>> +         * Typing 'make' from the top of this repository will build =
the
>> +         * IGVM files for both confidential and
>> +         * non-confidential tests. The IGVM files for the non-coco
>> +         * case has been checked-in into the QEMU repository for
>> +         * convenience and easy CI pipeline testing.
>> +         */
>> +        *igvm_f =3D "tests/data/igvm/snptest.igvm"; /* prints 'hello =
world' */
>> +        *igvm_init =3D "tests/data/igvm/snptest-nohello.igvm";
>> +    } else {
>> +        *igvm_f =3D "tests/data/igvm/hello.igvm";
>> +        *igvm_init =3D "tests/data/igvm/qemuinit.igvm";
>> +        *snp =3D "";
>> +        *cgs =3D "";
>> +    }
>> +
>> +    return;
>> +}
>> +
>> +static void set_expected_out(const char **exp_out, const char =
**exp_out2,
>> +                             const char **exp_out3)
>> +{
>> +    *exp_out =3D "Hello world!";
>> +    *exp_out2 =3D "Test succeeded!";
>> +    *exp_out3 =3D "boot process complete with initial igvm";
>> +
>> +    return;
>> +}
>> +
>> +static QOSState *set_qemu_args(const char *cgs, const char *tp, char =
*serialf,
>> +                               const char *igvm_init, const char =
*snp)
>> +{
>> +    QOSState *qs;
>> +
>> +    if (tp) {
>> +        qs =3D qtest_pc_boot("-machine q35,igvm-cfg=3Digvm0,%s -m 1G =
-accel kvm "
>> +                           "-device vm-launch-update %s "
>> +                           "-chardev file,id=3Dserial0,path=3D%s "
>> +                           "-serial chardev:serial0 "
>> +                           "-object igvm-cfg,id=3Digvm0,file=3D%s =
%s",
>> +                           cgs, tp, serialf, igvm_init, snp);
>> +    } else {
>> +        qs =3D qtest_pc_boot("-machine q35,igvm-cfg=3Digvm0,%s -m 1G =
-accel kvm "
>> +                           "-device vm-launch-update "
>> +                           "-chardev file,id=3Dserial0,path=3D%s "
>> +                           "-serial chardev:serial0 "
>> +                           "-object igvm-cfg,id=3Digvm0,file=3D%s =
%s",
>> +                           cgs, serialf, igvm_init, snp);
>> +    }
>> +
>> +    return qs;
>> +}
>> +
>> static void test_load_igvm(void)
>> {
>>     const char *igvm_f;
>> @@ -255,9 +317,9 @@ static void test_load_igvm(void)
>>     int ser_fd;
>>     g_autofree void *igvm_blob =3D NULL;
>>     g_autofree char *serialtmp =3D NULL;
>> -    const char exp_out[] =3D "Hello world!";
>> -    const char exp_out2[] =3D "Test succeeded!";
>> -    const char exp_out3[] =3D "boot process complete with initial =
igvm";
>> +    const char *exp_out;
>> +    const char *exp_out2;
>> +    const char *exp_out3;
>>     const char *tracepoints =3D "--trace memory_region_finalize "
>>         "--trace qigvm_cleanup_memory -D /tmp/qemu-debug.log ";
>>     const char *snp, *cgs;
>> @@ -268,35 +330,13 @@ static void test_load_igvm(void)
>>     QOSState *qs;
>>     VMLaunchUpdate launch_update;
>>=20
>> -    if (confidential) {
>> -        snp =3D "-object =
\'{\"qom-type\":\"sev-snp-guest\",\"id\":\"lsec0\","
>> -            =
"\"cbitpos\":51,\"reduced-phys-bits\":1,\"policy\":196608}\'";
>> -        cgs =3D "confidential-guest-support=3Dlsec0";
>> -        /*
>> -         * The following two IGVM files can be built from the source
>> -         * present in https://gitlab.com/anisinha/virt-firmware-rs .
>> -         * Typing 'make' from the top of this repository will build =
the
>> -         * IGVM files for both confidential and
>> -         * non-confidential tests. The IGVM files for the non-coco
>> -         * case has been checked-in into the QEMU repository for
>> -         * convenience and easy CI pipeline testing.
>> -         */
>> -        igvm_f =3D "tests/data/igvm/snptest.igvm"; /*
>> -                                                  * this prints =
'hello world'
>> -                                                  * on console
>> -                                                  */
>> -        igvm_init =3D "tests/data/igvm/snptest-nohello.igvm";
>> -    } else {
>> -        igvm_f =3D "tests/data/igvm/hello.igvm";
>> -        igvm_init =3D "tests/data/igvm/qemuinit.igvm";
>> -        snp =3D "";
>> -        cgs =3D "";
>> -    }
>> -
>>     if (!trace) {
>>         tracepoints =3D "";
>>     }
>>=20
>> +    set_test_params(&igvm_f, &igvm_init, &snp, &cgs);
>> +    set_expected_out(&exp_out, &exp_out2, &exp_out3);
>> +
>>     if (!g_file_test(igvm_f, G_FILE_TEST_EXISTS) ||
>>         !g_file_test(igvm_init, G_FILE_TEST_EXISTS)) {
>>         g_test_skip("igvm file bundle(s) does not exist!");
>> @@ -326,12 +366,7 @@ static void test_load_igvm(void)
>>         fprintf(stderr, "serial console file is %s\n", serialtmp);
>>     }
>>=20
>> -    qs =3D qtest_pc_boot("-machine q35,igvm-cfg=3Digvm0,%s -m 1G =
-accel kvm "
>> -                       "-device vm-launch-update %s "
>> -                       "-chardev file,id=3Dserial0,path=3D%s "
>> -                       "-serial chardev:serial0 "
>> -                       "-object igvm-cfg,id=3Digvm0,file=3D%s %s",
>> -                       cgs, tracepoints, serialtmp, igvm_init, snp);
>> +    qs =3D set_qemu_args(cgs, tracepoints, serialtmp, igvm_init, =
snp);
>>=20
>>     fw_cfg =3D pc_fw_cfg_init(qs->qts);
>>=20
>> @@ -342,6 +377,11 @@ static void test_load_igvm(void)
>>=20
>>     /* exp_out3 should be printed once from initial boot */
>>     g_assert_true(wait_for_match(serialtmp, exp_out3, WAIT_SEC, 1) =3D=3D=
 0);
>> +
>> +    if (debug) {
>> +        fprintf(stderr, "initially booted with host igvm\n");
>> +    }
>> +
>>     g_assert_true(load_image(igvm_f, &igvm_blob, &igvm_sz) =3D=3D =
igvm_sz);
>>=20
>>     /* create a data buffer in guest memory */
>> @@ -389,7 +429,7 @@ static void test_load_igvm(void)
>>=20
>>     /* check if VM_LAUNCHUPDATE_CTL_HOST_IGVM function works */
>>=20
>> -    /* set VM_LAUNCHUPDATE_CTL_HOST_IGVM control */
>> +    /* set only VM_LAUNCHUPDATE_CTL_HOST_IGVM control without IGVM =
bundle */
>>     memset(&launch_update, 0, sizeof(launch_update));
>>     launch_update.control |=3D VM_LAUNCHUPDATE_CTL_HOST_IGVM;
>>=20
>> @@ -410,6 +450,139 @@ static void test_load_igvm(void)
>>      */
>>     g_assert_true(wait_for_match(serialtmp, exp_out3, WAIT_SEC, 2) =3D=3D=
 0);
>>=20
>> +    if (debug) {
>> +        fprintf(stderr, "booted with host igvm again\n");
>> +    }
>> +
>> +    close(ser_fd);
>> +    guest_free(&qs->alloc, gaddr);
>> +    pc_fw_cfg_uninit(fw_cfg);
>> +    /* qtest_quit() kils QEMU, first by sending SIGTERM, then =
SIGKILL */
>> +    qtest_quit(qs->qts);
>> +}
>> +
>> +static void test_set_ctrl_once_and_reset_to_host_igvm(void)
>> +{
>> +    const char *igvm_f;
>> +    const char *igvm_init;
>> +    int ser_fd;
>> +    g_autofree void *igvm_blob =3D NULL;
>> +    g_autofree char *serialtmp =3D NULL;
>> +    const char *exp_out;
>> +    const char *exp_out2;
>> +    const char *exp_out3;
>> +    const char *snp, *cgs;
>> +    uint64_t gaddr;
>> +    size_t igvm_sz;
>> +    size_t filesize;
>> +    QFWCFG *fw_cfg;
>> +    QOSState *qs;
>> +    VMLaunchUpdate launch_update;
>> +
>> +    set_test_params(&igvm_f, &igvm_init, &snp, &cgs);
>> +    set_expected_out(&exp_out, &exp_out2, &exp_out3);
>> +
>> +    if (!g_file_test(igvm_f, G_FILE_TEST_EXISTS) ||
>> +        !g_file_test(igvm_init, G_FILE_TEST_EXISTS)) {
>> +        g_test_skip("igvm file bundle(s) does not exist!");
>> +        return;
>> +    }
>> +
>> +    if (!qtest_has_machine("q35")) {
>> +        g_test_skip("q35 machine not available");
>> +        return;
>> +    }
>> +
>> +    if (!qtest_has_accel("kvm")) {
>> +        g_test_skip("No KVM accelerator available");
>> +        return;
>> +    }
>> +
>> +    if (!qtest_has_device("vm-launch-update")) {
>> +        g_test_skip("Device vm-launch-update is not available");
>> +        return;
>> +    }
>> +
>> +    ser_fd =3D g_file_open_tmp("launchupdate-qtest-serial-sXXXXXX",
>> +                             &serialtmp, NULL);
>> +    g_assert_true(ser_fd !=3D -1);
>> +
>> +    if (debug) {
>> +        fprintf(stderr, "serial console file is %s\n", serialtmp);
>> +    }
>> +
>> +    qs =3D set_qemu_args(cgs, NULL, serialtmp, igvm_init, snp);
>> +
>> +    fw_cfg =3D pc_fw_cfg_init(qs->qts);
>> +
>> +    g_assert_true(wait_for_match(serialtmp, exp_out3, WAIT_SEC, 1) =
=3D=3D 0);
>> +
>> +    if (debug) {
>> +        fprintf(stderr, "initially booted with host igvm\n");
>> +    }
>> +
>> +    g_assert_true(load_image(igvm_f, &igvm_blob, &igvm_sz) =3D=3D =
igvm_sz);
>> +
>> +    /* create a data buffer in guest memory */
>> +    gaddr =3D guest_alloc(&qs->alloc, igvm_sz);
>> +
>> +    if (debug) {
>> +        fprintf(stderr, "guest paddr: %"PRIx64 "  igvm size: %lu\n",
>> +                gaddr, igvm_sz);
>> +    }
>> +
>> +    if (debug) {
>> +        fprintf(stderr, "writing igvm file into the guest =
memory\n");
>> +    }
>> +
>> +    qtest_bufwrite(qs->qts, gaddr, igvm_blob, igvm_sz);
>> +
>> +    if (debug) {
>> +        fprintf(stderr,
>> +                "tell hypervisor where igvm is loaded in guest =
memory\n");
>> +    }
>> +
>> +    /* now tell hypervisor where we loaded the bios */
>> +    memset(&launch_update, 0, sizeof(launch_update));
>> +    launch_update.fw_image_size =3D cpu_to_le64(igvm_sz);
>> +    launch_update.fw_image_addr =3D cpu_to_le64(gaddr);
>> +
>> +    /* set both host ctrl and format_igvm ctrl once */
>> +    launch_update.control |=3D VM_LAUNCHUPDATE_FORMAT_IGVM;
>> +    launch_update.control |=3D VM_LAUNCHUPDATE_CTL_HOST_IGVM;
>> +
>> +    filesize =3D qfw_cfg_write_file(fw_cfg, qs, FILE_VMLAUNCHUPDATE,
>> +                                  &launch_update, =
sizeof(launch_update));
>> +    g_assert_cmpint(filesize, =3D=3D, sizeof(launch_update));
>> +
>> +    if (debug) {
>> +        fprintf(stderr, "resetting the virtual machine. This should =
load "
>> +                "user provided igvm.\n");
>> +    }
>> +
>> +    qtest_system_reset(qs->qts);
>> +
>> +    /* expected string should be printed on the console */
>> +    g_assert_true(wait_for_match(serialtmp, exp_out, WAIT_SEC, 1) =3D=3D=
 0);
>> +    g_assert_true(wait_for_match(serialtmp, exp_out2, WAIT_SEC, 1) =
=3D=3D 0);
>> +
>> +    if (debug) {
>> +        fprintf(stderr, "hello world found on console\n");
>> +        fprintf(stderr, "Now resetting again in order to reset to =
host igvm\n");
>> +    }
>> +
>> +    qtest_system_reset(qs->qts);
>> +
>> +    /*
>> +     * exp_out3 should be printed twice, once from initial boot,
>> +     * once from restoring host igvm.
>> +     */
>> +    g_assert_true(wait_for_match(serialtmp, exp_out3, WAIT_SEC, 2) =
=3D=3D 0);
>> +
>> +    if (debug) {
>> +        fprintf(stderr, "booted with host igvm\n");
>> +    }
>> +
>>     close(ser_fd);
>>     guest_free(&qs->alloc, gaddr);
>>     pc_fw_cfg_uninit(fw_cfg);
>> @@ -435,6 +608,8 @@ int main(int argc, char **argv)
>>     g_test_add_func("/vm-launch-update/errorcheck", check_error);
>>     g_test_add_func("/vm-launch-update/load_igvm",
>>                     test_load_igvm);
>> +    g_test_add_func("/vm-launch-update/ctrl_set_once",
>> +                    test_set_ctrl_once_and_reset_to_host_igvm);
>>=20
>>     if (getenv("LAUNCHUPDATE_DEBUG")) {
>>         debug =3D true;
>> --
>> 2.54.0
>>=20


