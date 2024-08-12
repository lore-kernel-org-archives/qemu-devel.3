Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62897C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 22:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sddSI-0006vn-8U; Mon, 12 Aug 2024 18:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1sddSG-0006ue-E0
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 18:23:56 -0400
Received: from rn-mailsvcp-mx-lapp02.apple.com ([17.179.253.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1sddSD-0004cr-9V
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 18:23:56 -0400
Received: from rn-mailsvcp-mta-lapp02.rno.apple.com
 (rn-mailsvcp-mta-lapp02.rno.apple.com [10.225.203.150])
 by rn-mailsvcp-mx-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SI4005BKLZ8ZM10@rn-mailsvcp-mx-lapp02.rno.apple.com>
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 15:18:50 -0700 (PDT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=20180706;
 bh=qDm10JYpDRVixlrVarsyOl3IdszKxHlNALpXZwB8mOA=;
 b=rV9gHM0ePWUsMnoNhgU/Cs6n9M7kpS4rMbiTbmTrqoo5G2LBWGs0Fk0qKAJWMJ6UXGq4
 f92PqArlcKqN+mIqGmBZAAK8yeAt45M7EpMK8NW9/9EXIO1sXh0hJnK7d5uvg75Incjv
 gZ7wAjrm8SJaWaITjbi8chjZIs37v0G7BHQw6HI/ydgTo/NmTbjkNCaF5S5WwxKxi1HM
 bNR+w8OYJ/T9g9x0PChJ6biDz2YIr8ByXvtuLUavgjI1Gqu+M0IKhZHHQ6SgR017T3+i
 NuNQcVsyGV/pYnLsU0UrJOQhSJJXAJAcL84t1Uy9O+3xjbk5UGF+W/SoH+JD7a07AxDo Qw==
Received: from mr55p01nt-mmpp06.apple.com
 (mr55p01nt-mmpp06.apple.com [10.170.185.198])
 by rn-mailsvcp-mta-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SI400Q3RLZ8J320@rn-mailsvcp-mta-lapp02.rno.apple.com>; 
 Mon, 12 Aug 2024 15:18:46 -0700 (PDT)
Received: from process_milters-daemon.mr55p01nt-mmpp06.apple.com by
 mr55p01nt-mmpp06.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SI42BC00LZ1K400@mr55p01nt-mmpp06.apple.com>; Mon,
 12 Aug 2024 22:18:44 +0000 (GMT)
X-Va-A: 
X-Va-T-CD: 9be860c946f6cbc0801dd392535b1c06
X-Va-E-CD: 6e8d677d3901fd5b58b190047ca79016
X-Va-R-CD: 4206bda14c83e153d471243933acbb53
X-Va-ID: 33e5ab5e-bba7-48d4-bdea-6ef5a17d11f8
X-Va-CD: 0
X-V-A: 
X-V-T-CD: 9be860c946f6cbc0801dd392535b1c06
X-V-E-CD: 6e8d677d3901fd5b58b190047ca79016
X-V-R-CD: 4206bda14c83e153d471243933acbb53
X-V-ID: ad1bc05f-7661-4de4-82a6-2534d1add627
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
Received: from smtpclient.apple (unknown [17.243.243.246])
 by mr55p01nt-mmpp06.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPSA id <0SI42BB0OLZ0V300@mr55p01nt-mmpp06.apple.com>; Mon,
 12 Aug 2024 22:18:40 +0000 (GMT)
Content-type: text/plain; charset=utf-8
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] hvf: arm: Allow creating VMs with > 63GB of RAM on macOS
 15+
From: Danny Canter <danny_canter@apple.com>
In-reply-to: <CAFEAcA__WZ=uw0VLcP0fLbUTwmctsZ1y=FRf9bXMT9WJC2sRFA@mail.gmail.com>
Date: Mon, 12 Aug 2024 18:18:25 -0400
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, rbolshakov@ddn.com, agraf@csgraf.de
Content-transfer-encoding: quoted-printable
Message-id: <E03A8C36-4079-468F-9596-328D713C3611@apple.com>
References: <20240718230031.69641-1-danny_canter@apple.com>
 <CAFEAcA__WZ=uw0VLcP0fLbUTwmctsZ1y=FRf9bXMT9WJC2sRFA@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3776.700.51)
Received-SPF: pass client-ip=17.179.253.23;
 envelope-from=danny_canter@apple.com; helo=rn-mailsvcp-mx-lapp02.apple.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Peter, thanks for review! Will work on splitting this up a bit to =
support the plumbing you mentioned KVM does today on ARM.=20

> On Aug 12, 2024, at 10:52=E2=80=AFAM, Peter Maydell =
<peter.maydell@linaro.org> wrote:
>=20
> On Fri, 19 Jul 2024 at 00:03, Danny Canter <danny_canter@apple.com> =
wrote:
>>=20
>> This patch's main focus is to enable creating VMs with > 63GB
>> of RAM on Apple Silicon machines by using some new HVF APIs. In
>> pursuit of this a couple of things related to how we handle the
>> physical address range we expose to guests were altered:
>>=20
>> The default IPA size on all Apple Silicon machines for HVF is
>> currently 36 bits. This bars making a VM with > 63GB (as RAM
>> starts at 1GB in the memory map) of RAM. Currently, to get the
>> IPA size we were reading id_aa64mmfr0_el1's PARange field
>> from a newly made vcpu. Unfortunately HVF just returns the
>> hosts PARange directly for the initial value and not the IPA
>> size that will actually back the VM, so we believe we have much
>> more address space than we actually do today it seems.
>=20
> So just to check my understanding, this means that with current
> QEMU, on all Apple hardware, attempting to create a VM with
> more than 63 GB of RAM will always fail in the same way,
> regardless of whether that CPU's hardware has a 36 bit IPA
> or a larger IPA? That is, we don't change the default IPA for the
> VM, so it's 36 bits, and then the hvf command to map in the RAM
> to the guest address space fails with HV_BAD_ARGUMENT, per
> https://gitlab.com/qemu-project/qemu/-/issues/1816 .

Spot on, yes. We default to a lower (36 bit) IPA space always, and =
expose the knobs starting in 13 to raise this on a per-VM
basis. We aren=E2=80=99t raising it today so we=E2=80=99d always fail =
when the kernel gets a hv_vm_map with an IPA past the end of our address
space.

>=20
>> Starting in macOS 13.0 some APIs were introduced to be able to
>> query the maximum IPA size the kernel supports, and to set the IPA
>> size for a given VM. However, this still has a couple of issues
>> on < macOS 15. Up until macOS 15 (and if the hardware supported
>> it) the max IPA size was 39 bits which is not a valid PARange
>> value, so we can't clamp down what we advertise in the vcpu's
>> id_aa64mmfr0_el1 to our IPA size. Starting in macOS 15 however,
>> the maximum IPA size is 40 bits (if it's supported in the hardware
>> as well) which is also a valid PARange value, so we can set our IPA
>> size to the maximum as well as clamp down the PARange we advertise
>> to the guest. This allows VMs with 63+ GB of ram and should fix the
>> oddness of the PARange situation as well.
>=20
> So (again to clarify that I understand what's happening here)
> for macos 13-14 we'll effectively continue to use a 36-bit
> IPA range because we clamp the "39" value down to the next
> lowest actually-valid value of 36 ? And so if you want >63GB
> of memory you'll need all of:
> * a host CPU which supports at least a 40 bit IPA
>   (is there a definition somewhere of which these are?)
> * macos 15
> * a QEMU with these changes
>=20
> ?
>=20
> (That seems fine to me: I'm happy to say "get macos 15 if you
> want this" rather than trying to cope with the non-standard
> 39 bit IPA in QEMU. We should make sure the error message in
> the IPA-too-small case is comprehensible -- I think at the
> moment we somewhat unhelpfully assert()...)
>=20

Spot on again. We didn=E2=80=99t want to advertise a larger PA range to =
the guest than what is actually backing the VM, so for a =E2=80=9Ccorrect=E2=
=80=9D world
macOS 15 would be required. You=E2=80=99d get 40 bits of IPA space, and =
we finally line up with a valid ARM PARange value. As for whether
there=E2=80=99s a list of what SoC=E2=80=99s support what IPA size, I =
don=E2=80=99t believe so. All of the pro/max SoC=E2=80=99s do iirc, but =
I=E2=80=99d just direct folks to write a
program that calls `hv_vm_config_get_max_ipa_size` to confirm. There=E2=80=
=99s `sysctl -a kern.hv`, but I=E2=80=99d avoid recommending this in =
case
the hv API does some extra munging with the value this reports. That =
hv_vm_config_ API should truly be the source of truth on any given
machine.

As for the error message we report, I=E2=80=99d have to remember what =
the error message is today, but it seemed somewhat reasonable after this =
patch
if I recall. It was in a codepath that already existed (and was added =
for kvm it seemed) and was checking if any part of the memory map =
exceeded the
maximum IPA size.

>> For the implementation of this I've decided to only bump the IPA
>> size if the amount of RAM requested is encroaching on the default IPA
>> size of 36 bits, as at 40 bits of IPA space we have to have one extra
>> level of stage2 page tables.
>>=20
>> Signed-off-by: Danny Canter <danny_canter@apple.com>
>> Reviewed-by: Cameron Esfahani <dirty@apple.com>
>=20
>> @@ -929,6 +977,66 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
>> {
>> }
>>=20
>> +hv_return_t hvf_arch_vm_create(MachineState *ms)
>> +{
>> +    uint32_t default_ipa_size =3D hvf_get_default_ipa_bit_size();
>> +    uint32_t max_ipa_size =3D hvf_get_max_ipa_bit_size();
>> +    hv_return_t ret;
>> +
>> +    chosen_ipa_bit_size =3D default_ipa_size;
>> +
>> +    /*
>> +     * Set the IPA size for the VM:
>> +     *
>> +     * Starting from macOS 13 a new set of APIs were introduced that =
allow you
>> +     * to query for the maximum IPA size that is supported on your =
system. macOS
>> +     * 13 and 14's kernel both return a value less than 40 bits =
(typically 39,
>> +     * but depends on hardware), however starting in macOS 15 and up =
the IPA
>> +     * size supported (in the kernel at least) is up to 40 bits. A =
common scheme
>> +     * for attempting to get the IPA size prior to the introduction =
of these new
>> +     * APIs was to read ID_AA64MMFR0.PARange from a vcpu in the =
hopes that HVF
>> +     * was returning the maximum IPA size in that. However, this was =
not the
>> +     * case. HVF would return the host's PARange value directly =
which is
>> +     * generally larger than 40 bits.
>> +     *
>> +     * Using that value we could set up our memory map with regions =
much outside
>> +     * the actually supported IPA size, and also advertise a much =
larger
>> +     * physical address space to the guest. On the hardware+OS =
combos where
>> +     * the IPA size is less than 40 bits, but greater than 36, we =
also don't
>> +     * have a valid PARange value to round down to before 36 bits =
which is
>> +     * already the default.
>> +     *
>> +     * With that in mind, before we make the VM lets grab the =
maximum supported
>> +     * IPA size and clamp it down to the first valid PARange value =
so we can
>> +     * advertise the correct address size for the guest later on. =
Then if it's
>> +     * >=3D 40 set this as the IPA size for the VM using the new =
APIs. There's a
>> +     * small heuristic for actually altering the IPA size for the VM =
which is
>> +     * if our requested RAM is encroaching on the top of our default =
IPA size.
>> +     * This is just an optimization, as at 40 bits we need to create =
one more
>> +     * level of stage2 page tables.
>> +     */
>> +#if defined(MAC_OS_VERSION_13_0) && \
>> +    MAC_OS_X_VERSION_MIN_REQUIRED >=3D MAC_OS_VERSION_13_0
>> +    hv_vm_config_t config =3D hv_vm_config_create();
>> +
>> +    /* In our memory map RAM starts at 1GB. */
>=20
> This is not board-specific code, so you can't assume that.
> The board gets to pick the memory map and where RAM starts in it.
>=20
> You probably need to do something similar to what we do
> in hw/arm/virt.c:virt_kvm_type() where we find out what
> the best IPA the hypervisor supports is, set the board memory
> map to respect that, diagnose an error if the user asked for
> more RAM than fits into that IPA range, and then arrange for
> the actual VM/vcpu creation to be done with the required IPA.
>=20
> This is unfortunately probably going to imply a bit of extra
> plumbing to be implemented for hvf -- that MachineClass::kvm_type
> method is (as the name suggests) KVM specific. (Multi-patch
> patchset for that, where we add the plumbing in as its own
> separate patch (and/or whatever other split of functionality
> into coherent chunks makes sense), rather than one-big-patch, please.)

That=E2=80=99s perfectly fine, I=E2=80=99ll try and see how the plumbing =
was done for KVM and try and emulate where it makes sense
for HVF. Agree though, that=E2=80=99d definitely push this into =
multi-patch territory. Curious if you think what=E2=80=99s here today =
should
be multiple patches or the current work seems fine in one?

>=20
>> +    uint64_t threshold =3D (1ull << default_ipa_size) - (1 * GiB);
>> +    if (ms->ram_size >=3D threshold && max_ipa_size >=3D =
FIRST_HIGHMEM_PARANGE) {
>> +        ret =3D hv_vm_config_set_ipa_size(config, max_ipa_size);
>> +        assert_hvf_ok(ret);
>> +
>> +        chosen_ipa_bit_size =3D max_ipa_size;
>> +    }
>> +
>> +    ret =3D hv_vm_create(config);
>> +    os_release(config);
>> +#else
>> +    ret =3D hv_vm_create(NULL);
>> +#endif
>> +
>> +    return ret;
>> +}
>=20
>> +uint8_t round_down_to_parange_index(uint8_t bit_size)
>> +{
>> +    for (int i =3D ARRAY_SIZE(pamax_map) - 1; i >=3D 0; i--) {
>> +        if (pamax_map[i] <=3D bit_size) {
>> +            return i;
>> +        }
>> +    }
>> +    g_assert_not_reached();
>> +}
>> +
>> +uint8_t round_down_to_parange_bit_size(uint8_t bit_size)
>> +{
>> +    for (int i =3D ARRAY_SIZE(pamax_map) - 1; i >=3D 0; i--) {
>> +        if (pamax_map[i] <=3D bit_size) {
>> +            return pamax_map[i];
>> +        }
>> +    }
>> +    g_assert_not_reached();
>=20
> We could implement this as
>       return pamax_map[round_down_to_parange_index(bit_size)];
>=20
> and avoid having to code the loop twice, right?

Yes, my copy and paste seems dumb reading it back now :)

>=20
> thanks
> -- PMM


