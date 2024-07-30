Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE930C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 21:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYurr-0008Q8-6C; Tue, 30 Jul 2024 17:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1sYuro-0008PZ-1a
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 17:58:48 -0400
Received: from ma-mailsvcp-mx-lapp02.apple.com ([17.32.222.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1sYurm-0003BM-HJ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 17:58:47 -0400
Received: from rn-mailsvcp-mta-lapp04.rno.apple.com
 (rn-mailsvcp-mta-lapp04.rno.apple.com [10.225.203.152])
 by ma-mailsvcp-mx-lapp02.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SHG00MPTI5J0F10@ma-mailsvcp-mx-lapp02.apple.com> for
 qemu-devel@nongnu.org; Tue, 30 Jul 2024 14:53:43 -0700 (PDT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_17,2024-07-30_01,2024-05-17_01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=20180706;
 bh=H6K//kzbaNjOf4Z6dSWHpNChGyR9ein+SUNiFDEvSgY=;
 b=lelmlupUc3lwAgqqcs45zoekS+E9l4XGy/CsPbHtu5GuUFlwDF5mcqIbV6fZypHwF8Qk
 z4TSbb9Kfm5nvwtRAEFJPP5aLRFdpxH6ZD0s2/KkAJqD8lBitf1MFFx8V7U8lcVwr5Xz
 eSfljAqkdVtub20pzM6fZX/8sNMMxYhrgZBmmJL891bDkdP3AkveHgZlFYf5JkKQocCz
 Le6hiw7Fl4bFPQBx1Qb+WGm6gsmLmibFDC2H8jE/bbZNkt+KCoqVhZ0tg42I5Ec6x/Rv
 DAOkEXCFSQ/sebIeEjX8TG7kDPE0Na0bNgDimo720dIyGrLNKDuPltZ9IXJ+7YKLD3qj iw==
Received: from rn-mailsvcp-mmp-lapp04.rno.apple.com
 (rn-mailsvcp-mmp-lapp04.rno.apple.com [17.179.253.17])
 by rn-mailsvcp-mta-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SHG00YKDI5IMIN0@rn-mailsvcp-mta-lapp04.rno.apple.com>; 
 Tue, 30 Jul 2024 14:53:42 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp04.rno.apple.com by
 rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SHG00X00HXR8500@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Tue,
 30 Jul 2024 14:53:42 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: 9be860c946f6cbc0801dd392535b1c06
X-Va-E-CD: 6e8d677d3901fd5b58b190047ca79016
X-Va-R-CD: 4206bda14c83e153d471243933acbb53
X-Va-ID: 4bc6cea4-1786-4bfe-8938-41b0639e5136
X-Va-CD: 0
X-V-A: 
X-V-T-CD: 9be860c946f6cbc0801dd392535b1c06
X-V-E-CD: 6e8d677d3901fd5b58b190047ca79016
X-V-R-CD: 4206bda14c83e153d471243933acbb53
X-V-ID: 5bb79c9b-c26d-4e54-ac1a-a746214c5fb6
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_17,2024-07-30_01,2024-05-17_01
Received: from smtpclient.apple (unknown [17.243.209.248])
 by rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023))
 with ESMTPSA id <0SHG00ILTI5IDP00@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Tue,
 30 Jul 2024 14:53:42 -0700 (PDT)
Content-type: text/plain; charset=utf-8
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] hvf: arm: Allow creating VMs with > 63GB of RAM on macOS
 15+
From: Danny Canter <danny_canter@apple.com>
In-reply-to: <CAFEAcA9Y3yNoOQp+Ei3M4mtOyeMKAh9fD9_WBimrSYETxFkUhA@mail.gmail.com>
Date: Tue, 30 Jul 2024 14:53:31 -0700
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, rbolshakov@ddn.com, agraf@csgraf.de
Content-transfer-encoding: quoted-printable
Message-id: <8CEBAF31-2582-45B5-B391-DE4F392EB932@apple.com>
References: <20240718230031.69641-1-danny_canter@apple.com>
 <CAFEAcA9Y3yNoOQp+Ei3M4mtOyeMKAh9fD9_WBimrSYETxFkUhA@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
Received-SPF: pass client-ip=17.32.222.23; envelope-from=danny_canter@apple.com;
 helo=ma-mailsvcp-mx-lapp02.apple.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Thanks Peter!=20

For the macOS 13 comment just so I=E2=80=99m clear, you=E2=80=99re =
saying the minimum we support is
13 now so the conditional compilation for those isn=E2=80=99t required =
anymore as well? I suppose
that tracks given the wording that we support the last two macOS =
releases at any given
time, that kind of slipped my mind when thinking about what actually =
needs to be ifdef=E2=80=99d
here. That certainly cleans things up a bit for some of the functions in =
this patch.

=E2=80=94 Danny=20

> On Jul 29, 2024, at 9:27=E2=80=AFAM, Peter Maydell =
<peter.maydell@linaro.org> wrote:
>=20
> On Fri, 19 Jul 2024 at 00:03, Danny Canter <danny_canter@apple.com> =
wrote:
>>=20
>> This patch's main focus is to enable creating VMs with > 63GB
>> of RAM on Apple Silicon machines by using some new HVF APIs. In
>> pursuit of this a couple of things related to how we handle the
>> physical address range we expose to guests were altered:
>=20
> Hi -- this is just a note to say that this patch is on my
> todo list to review, I just haven't got to it yet. (Unfortunately
> it's just missed the cutoff for the upcoming 9.1 release, and
> I've been prioritising the for-9.1 stuff.)
>=20
> I did see one thing from an initial quick eyeball, but
> don't bother respinning the patchset just to change that:
> I'll do an actual review hopefully in the next week or so.
>=20
>> +static uint32_t hvf_get_default_ipa_bit_size(void)
>> +{
>> +    uint32_t default_ipa_size =3D 36;
>> +#if defined(MAC_OS_VERSION_13_0) && \
>> +    MAC_OS_X_VERSION_MIN_REQUIRED >=3D MAC_OS_VERSION_13_0
>> +    hv_return_t ret =3D =
hv_vm_config_get_default_ipa_size(&default_ipa_size);
>> +    assert_hvf_ok(ret);
>> +#endif
>=20
> You can assume we have at least macos 13 or better -- our
> minimum supported build platform is at least that new,
> and we already dropped some 10.12-and-earlier compat
> ifdefs (see commit 2d27c91e2b72ac7).
>=20
>> +    return default_ipa_size;
>> +}
>=20
> thanks
> -- PMM


