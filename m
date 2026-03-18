Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF9EFCD0DC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2mS0-0003XL-Hf; Wed, 18 Mar 2026 04:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w2mRy-0003TD-Ea
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:40:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w2mRw-0005Bl-4O
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773823218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z1v+Kj4YxRseLVEJSI8fA2/pmgcNdT+yqZKMt+hkt0k=;
 b=Bufyx4ZQOCZSDxz9NCWpsgKgyJiV6rXlsSpFZnY5n+C6GW04+e+i2HUEn4lmp6BCLEzJei
 SXk0UN4fXH74Q0Nffg6xAo2ArQUQueXtZRDtTw/+V6G3JQ1zxKrP6MosZTo6uQ2bS+het1
 HWR4GClpnsBlvLGZfi6s+vTbdec9aY0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-7OAFEyKzPX6K_aiNoTSI0w-1; Wed, 18 Mar 2026 04:40:17 -0400
X-MC-Unique: 7OAFEyKzPX6K_aiNoTSI0w-1
X-Mimecast-MFC-AGG-ID: 7OAFEyKzPX6K_aiNoTSI0w_1773823216
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-359fe456655so6031509a91.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 01:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773823216; x=1774428016; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z1v+Kj4YxRseLVEJSI8fA2/pmgcNdT+yqZKMt+hkt0k=;
 b=PwoM+TD8UanbLl5+Z9B9TIP+N3mpHyxoWO+v1LHMulyFqb9+qBojNIpqaU7kebcHfw
 qiFas78HxKxUZXITjUoBB13mwk4JsncjfjG6HOd8xBgtmFxR0Cv5F1m0tmNyvJDFCyqq
 jTYdubescW6y8374sqUyZ256PmMtvAdF+lL5iWhct8y/IOHL3ukKXHnpYLe3n+uWQhTV
 0vPa5MMi+Wb/7ik2CveLBlb/Q3Mujrv4khLjKgb3Vm/3O2fdFVU5N2/fa9/usPfRMktD
 z+LHkOXlsf5vy3wGzaN2po8Zt/gtHqcNQ+JI/bCu1mo/cPgBF2oQvLvi1xv4COn6xKFq
 zwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773823216; x=1774428016;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z1v+Kj4YxRseLVEJSI8fA2/pmgcNdT+yqZKMt+hkt0k=;
 b=IApRw/i7cHa6K5Uj/hjxvlkthXwqnXnSlpgO8NByL0icV07PPpdew+9rXLYnaJnA9d
 tPsKmom9VJKyq/rmH1pPU9YaOyybmaUqMQ005cbF7jv1BbaDzB6hBtjSS4JokpfxmR7S
 H3wHzZZqFvJCDeHVZLqBE//W4N7xWvuZwuwMTvY1XXRLfhuLTBu7iIxo2WW/GfeIcF6W
 frm10aQfQJAWegiwIvpE/In65AEVBYlcRH6TbrM8V8G21XNr3n3xbd1BxlzX8tQeOhbe
 kx5K05OCICuYmA613sZHiu+N4xe1PgqY/rtPPFaityJfdxTCEKb38UTI3Gz8v7DlcPCe
 KPHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfgChruzH7lpfUVmzMRM8/OuAriSCjLeJEuRX7REstFBXkLmby7Kj8XlCzEsrT5Md5MAOTgdxGwap/@nongnu.org
X-Gm-Message-State: AOJu0YyqDZunOCd6qFI8lsk2av+dTDA/8/nXCE5FpAKO0Sht77ziaRg0
 7Lv6XBijTrJoPj9VDZmIpD9oMN2hc5kiYR7gPUPkf9KAepjzwPu+bhTDmtqlKVb7NT/k/ZuIxMf
 WOUDhwr2aEgUuqlsFjNPBCDiOPTTS0ScBDbvTvtn2SFK7hOsBCUJqUoF6
X-Gm-Gg: ATEYQzy3U6itYumf+E+BfHwn1xwWYolwr4hRQI48NDXDrV+wp9WoQiuE4bZET8mhRGb
 DmqeqMX5xuvowcieYq718U4cNPBkY0y9Ofsn6cyobcp/+4yoDQMfmoDDZu98nGQliaiUz1iygdL
 OdrE4McLGnNLvrpeK4viZiZBiHsFEbMxAVIg5MxCQfZCZfIoFro+Bistzeu1ku8OAllyzI3RM26
 D/nCFp6fSEezreK5TqvXdimpHIikqksIGchDicH6CznnlOz9j6VW5VOLlHMiTk8UHX9jx0buayW
 KPJqrJxQGh4CMOk3yo/zumoFoDz/TEQmY/1g2e47Er3HvqDEO8QhWR3w/d4S7VXUpSBVJCUi2tQ
 tWbng71GLRRjRGp003gdQEaNF/3MSNg3nFV2ERgVLunx8K7uQeCgFfrbQUOteWvAocrXPVg==
X-Received: by 2002:a17:90b:1dc6:b0:34a:b8e0:dd64 with SMTP id
 98e67ed59e1d1-35bb9e41137mr2180246a91.1.1773823216252; 
 Wed, 18 Mar 2026 01:40:16 -0700 (PDT)
X-Received: by 2002:a17:90b:1dc6:b0:34a:b8e0:dd64 with SMTP id
 98e67ed59e1d1-35bb9e41137mr2180216a91.1.1773823215676; 
 Wed, 18 Mar 2026 01:40:15 -0700 (PDT)
Received: from smtpclient.apple ([122.176.129.56])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bb9f1cb48sm853753a91.0.2026.03.18.01.40.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Mar 2026 01:40:15 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [BUG] [powerpc] KVM guest boot failure - hangs on startup after
 commit 98884e0c
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <526d7172f3933baf913bf4b105a6fa9a@linux.ibm.com>
Date: Wed, 18 Mar 2026 14:09:59 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu Ppc <qemu-ppc@nongnu.org>, npiggin@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, vaibhav@linux.ibm.com,
 sbhat@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <9794AFF9-DFD9-48D0-B4EA-7745ABDED6F7@redhat.com>
References: <e0fa0840fa7758499aa8c64a148e5367@linux.ibm.com>
 <2cc23a5ce64847dd8a9278c87f58119b@linux.ibm.com>
 <5bc7997d-329e-47a9-9b4d-750a3104094a@linux.ibm.com>
 <4797B580-7853-490E-8852-B6312619FE95@redhat.com>
 <e966c053-2e69-b185-532e-fcb4173b4daf@redhat.com>
 <b088f554af34cbcc4d88271e227074e1@linux.ibm.com>
 <ED4A083D-2B96-468A-BE77-211E9F3FA88D@redhat.com>
 <7bbeb3cb105934e95bf1a5356cfc4613@linux.ibm.com>
 <7ACBCD63-B759-47FD-824F-0327726E47F6@redhat.com>
 <35f6361f69ef4f09f80bd915f3460a28@linux.ibm.com>
 <B2B682DB-1467-4C42-AF74-346BC61DE31B@redhat.com>
 <526d7172f3933baf913bf4b105a6fa9a@linux.ibm.com>
To: Misbah Anjum N <misanjum@linux.ibm.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 18 Mar 2026, at 1:49=E2=80=AFPM, Misbah Anjum N =
<misanjum@linux.ibm.com> wrote:
>=20
> Hi Ani and Paolo,
>=20
> Following up on the KVM guest boot issue due to commit 98884e0c, I =
have conducted additional testing that reveals important new information =
about the nature of this issue.
>=20
> The hang is specifically triggered when SMP is configured, that is, =
when -smp parameter is provided in the QEMU command. This is also =
validated via KVM Unit Tests involving SMP which are failing due to the =
same commit.

So basically what we know is:
 - Issue seems to show on ppc64.
 - tree with df8df3cb6b at tip does not show issue.
 - tree with next commit 98884e0cc1 at tip shows the issue.
 - kvm_reset_vmfd() introduced by 98884e0cc1 is not called.=20

You think any one these commits are the cause of the issue (which I =
personally cannot agree with):

98884e0cc1 accel/kvm: add changes required to support KVM VM file =
descriptor change
df8df3cb6b system/physmem: add helper to reattach existing memory after =
KVM VM fd change
4003e5e65f hw/accel: add a per-accelerator callback to change VM =
accelerator handle
2391125f13 accel/kvm: add confidential class member to indicate guest =
rebuild capability
b3f0a55576 i386/kvm: avoid installing duplicate msr entries in =
msr_handlers

None of the above commits does anything SMP related.

>=20
> Test Results:
> Without SMP (boots successfully):
> /usr/bin/qemu-system-ppc64 -name avocado-vt-vm1 -machine =
pseries,accel=3Dkvm \
>  -enable-kvm -m 32768 -nographic -device virtio-balloon \
>  -device virtio-scsi-pci,id=3Dscsi0 \
>  -drive =
file=3D/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel-ppc64le-hpb.q=
cow2,if=3Dnone,id=3Ddrive-scsi0-0-0,format=3Dqcow2 \
>  -device scsi-hd,bus=3Dscsi0.0,drive=3Ddrive-scsi0-0-0 \
>  -netdev bridge,id=3Dnet0,br=3Dvirbr0 -device =
virtio-net-pci,netdev=3Dnet0
>=20
> SLOF =
**********************************************************************
> QEMU Starting
> Build Date =3D Oct 26 2025 18:45:22
> FW Version =3D release 20251026
> Press "s" to enter Open Firmware.
>=20
> Populating /vdevice methods
> Populating /vdevice/vty@71000000
> Populating /vdevice/nvram@71000001
> Populating /pci@800000020000000
> ...
> ...
> Result: Guest boots successfully
>=20
> With SMP (hangs indefinitely):
> /usr/bin/qemu-system-ppc64 -name avocado-vt-vm1 -machine =
pseries,accel=3Dkvm \
>  -enable-kvm -m 32768 -smp 32,sockets=3D1,cores=3D32,threads=3D1 =
-nographic \
>  -device virtio-balloon -device virtio-scsi-pci,id=3Dscsi0 \
>  -drive =
file=3D/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel-ppc64le-hpb.q=
cow2,if=3Dnone,id=3Ddrive-scsi0-0-0,format=3Dqcow2 \
>  -device scsi-hd,bus=3Dscsi0.0,drive=3Ddrive-scsi0-0-0 \
>  -netdev bridge,id=3Dnet0,br=3Dvirbr0 -device =
virtio-net-pci,netdev=3Dnet0
> ...
> ...
> Result: Hangs indefinitely at bql_lock() in qemu_default_main()
>=20
> KVM Unit Tests:
> Running kvm-unit-tests confirms the SMP dependency. Note that tests =
explicitly involving SMP (smp, smp-smt, atomics) all fail with SIGKILL, =
while single-threaded tests pass.
>=20
> # ./run_tests.sh
> FAIL selftest-setup (terminated on SIGKILL)
> PASS selftest-migration (2 tests)
> PASS selftest-migration-skip (1 tests)
> PASS migration-memory (1 tests)
> PASS spapr_hcall (9 tests, 1 skipped)
> PASS spapr_vpa (13 tests)
> PASS rtas-get-time-of-day (10 tests)
> PASS rtas-get-time-of-day-base (10 tests)
> PASS rtas-set-time-of-day (5 tests)
> PASS emulator (4 tests)
> PASS interrupts (13 tests)
> FAIL mmu (terminated on SIGKILL)
> FAIL smp (terminated on SIGKILL)
> FAIL smp-smt (terminated on SIGKILL)
> SKIP smp-thread-single (qemu-system-ppc64: -accel tcg,thread=3Dsingle: =
invalid accelerator tcg)
> FAIL atomics (terminated on SIGKILL)
> PASS atomics-migration (1 tests)
> PASS timebase (12 tests, 1 known failures, 1 skipped)
> SKIP timebase-icount (qemu-system-ppc64: -icount shift=3D5: cannot =
configure icount, TCG support not available)
> FAIL h_cede_tm
> PASS sprs (14 tests)
> FAIL sprs-migration (14 tests, 1 unexpected failures)
> PASS sieve
>=20
> Thanks,
> Misbah Anjum N <misanjum@linux.ibm.com>
>=20
>=20
> On 2026-03-10 15:42, Ani Sinha wrote:
>>>> This theory is not substantiated by code or evidence.
>>>> 98884e0cc10997a17ce9abfd6ff10be19224ca6a introduces =
kvm_reset_vmfd()
>>>> which is called by this block of code with the tip at
>>>> 98884e0cc10997a17ce9abfd6ff10be19224ca6a :
>>>>  if (!cpus_are_resettable() &&
>>>>       (reason =3D=3D SHUTDOWN_CAUSE_GUEST_RESET ||
>>>>        reason =3D=3D SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET)) {
>>>>       if (ac->rebuild_guest) {
>>>>           ret =3D ac->rebuild_guest(current_machine);
>>>>           if (ret < 0) {
>>>>               error_report("unable to rebuild guest: %s(%d)",
>>>>                            strerror(-ret), ret);
>>>>               vm_stop(RUN_STATE_INTERNAL_ERROR);
>>>>           } else {
>>>>               info_report("virtual machine state has been rebuilt =
with new "
>>>>                           "guest file handle.");
>>>>               guest_state_rebuilt =3D true;
>>>>           }
>>>>       } else if (!cpus_are_resettable())  {
>>>>           error_report("accelerator does not support reset!");
>>>>       } else {
>>>>           error_report("accelerator does not support rebuilding =
guest state,"
>>>>                        " proceeding with normal reset!");
>>>>       }
>>>>   }
>>>> If cpus are resettable, this block will not be called and nothing =
that
>>>> the patch introduces will have been executed.
>>>> So I think you guys need to explain a bit more why you so strongly
>>>> feel this patch broke it. I am confused and unable to reason this.
>>>>> Did you validate your patches on other architectures which does =
not support this feature yet?
>>>> As you have already seen, on other architectures, the entire block =
of
>>>> code is not executed at all. Only SEV-ES, SEV-SNP and TDX currently
>>>> exercises this.
>>> I understand your concern about the code path analysis. Let me =
clarify our findings with concrete evidence.
>>> Reproducibility Evidence:
>>> With commit 98884e0cc10997a17ce9abfd6ff10be19224ca6a applied, we are =
able to reproduce the hang issue 100% of the time across multiple test =
runs. When we revert to the previous commit =
df8df3cb6b743372ebb335bd8404bc3d748da350, the same KVM guest boots =
successfully 100% of the time.
>>> This consistent reproducibility strongly indicates that commit =
98884e0cc10997a17ce9abfd6ff10be19224ca6a is introducing the regression, =
even if the code path analysis suggests otherwise. This suggests the =
issue may not be in the code path, but rather in the changes introduced =
by the patch series.
>>> As the author who led the development of this patch series, we would =
appreciate your help in figuring out this issue.
>> I am really not sure what changes in that patch can cause this
>> breakage in a completely unrelated area when the changes are not even
>> executed.
>=20


