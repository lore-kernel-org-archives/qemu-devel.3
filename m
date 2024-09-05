Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D78CD98FE
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 18:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smHYx-0001Tt-4g; Thu, 05 Sep 2024 14:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1smHYp-0001T8-Mo
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 14:50:29 -0400
Received: from ma-mailsvcp-mx-lapp01.apple.com ([17.32.222.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1smHYn-0005m7-T7
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 14:50:27 -0400
Received: from rn-mailsvcp-mta-lapp01.rno.apple.com
 (rn-mailsvcp-mta-lapp01.rno.apple.com [10.225.203.149])
 by ma-mailsvcp-mx-lapp01.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SJC00E9OS3JAB10@ma-mailsvcp-mx-lapp01.apple.com> for
 qemu-devel@nongnu.org; Thu, 05 Sep 2024 11:45:19 -0700 (PDT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_13,2024-09-05_01,2024-09-02_01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=cc :
 content-type : date : from : in-reply-to : message-id : mime-version :
 references : subject : to; s=20180706;
 bh=+0blcSRINR1pnTYnuB5827l0WZi6OXvie7l6yLXwfgY=;
 b=l1kqgZrV7Hl9oX6+g3EbexZq0VbXHoBmfmaimK1ljmaiX9MbBIqfI63GubHUATP5a1dZ
 yG4cSPa0a6GWaHj/FuZNKoDeejVzqURejkXXGjSIukn6aDxMDwiTUbBhfFqZV0wdabaW
 vLLg63hM6QPPWYX3qIrBvz0pKJtx5T6at+qk2w+/1zyzgkZLKH1unbEjjpNMeGNvPcBa
 fOpFAH3iBlhWmptpVk3IsrfSosn7uP5jNsEsg5YobsipZ+elRCIUR1lG0UBt5dV637EH
 8NniXzAiy/WGChJwxvIbTXBb0zvJcp+QKo5eqcCVmM9MzouFlbYPoAbip0KEeQbFr1ua Ew==
Received: from mr55p01nt-mmpp05.apple.com
 (mr55p01nt-mmpp05.apple.com [10.170.185.201])
 by rn-mailsvcp-mta-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SJC0018ES3INTM0@rn-mailsvcp-mta-lapp01.rno.apple.com>; 
 Thu, 05 Sep 2024 11:45:19 -0700 (PDT)
Received: from process_milters-daemon.mr55p01nt-mmpp05.apple.com by
 mr55p01nt-mmpp05.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SJC2FV00RK0GJ00@mr55p01nt-mmpp05.apple.com>; Thu,
 05 Sep 2024 18:45:18 +0000 (GMT)
X-Va-A: 
X-Va-T-CD: 9be860c946f6cbc0801dd392535b1c06
X-Va-E-CD: 6e8d677d3901fd5b58b190047ca79016
X-Va-R-CD: 4206bda14c83e153d471243933acbb53
X-Va-ID: 6287912f-55b9-4e8d-82b7-b6141a875afa
X-Va-CD: 0
X-V-A: 
X-V-T-CD: 9be860c946f6cbc0801dd392535b1c06
X-V-E-CD: 6e8d677d3901fd5b58b190047ca79016
X-V-R-CD: 4206bda14c83e153d471243933acbb53
X-V-ID: 53283d84-6094-45c1-9937-dfa5ce4905f4
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_13,2024-09-05_01,2024-09-02_01
Received: from smtpclient.apple (unknown [17.243.242.205])
 by mr55p01nt-mmpp05.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPSA id <0SJC2G0AAS3GC300@mr55p01nt-mmpp05.apple.com>; Thu,
 05 Sep 2024 18:45:18 +0000 (GMT)
From: Danny Canter <danny_canter@apple.com>
Message-id: <65DA78B3-BA47-4C4E-80DE-F4B8B60A14B7@apple.com>
Content-type: multipart/alternative;
 boundary="Apple-Mail=_C71342DE-4ECD-4706-890E-E43BFA71A686"
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] hvf: arm: Allow creating VMs with > 63GB of RAM on macOS
 15+
Date: Thu, 05 Sep 2024 11:45:06 -0700
In-reply-to: <CAFEAcA9XXhsUeHNjsVkjhjO2_Njkk=L00BG+24xtXWWKgJayRw@mail.gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, rbolshakov@ddn.com, agraf@csgraf.de
To: Peter Maydell <peter.maydell@linaro.org>
References: <20240718230031.69641-1-danny_canter@apple.com>
 <CAFEAcA__WZ=uw0VLcP0fLbUTwmctsZ1y=FRf9bXMT9WJC2sRFA@mail.gmail.com>
 <E03A8C36-4079-468F-9596-328D713C3611@apple.com>
 <CAFEAcA9XXhsUeHNjsVkjhjO2_Njkk=L00BG+24xtXWWKgJayRw@mail.gmail.com>
X-Mailer: Apple Mail (2.3776.700.51)
Received-SPF: pass client-ip=17.32.222.22; envelope-from=danny_canter@apple.com;
 helo=ma-mailsvcp-mx-lapp01.apple.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


--Apple-Mail=_C71342DE-4ECD-4706-890E-E43BFA71A686
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Forgot to leave a trail here :). V2 is posted =
https://lists.gnu.org/archive/html/qemu-devel/2024-08/msg04016.html

Thanks again for review Peter!

> On Aug 13, 2024, at 2:31=E2=80=AFAM, Peter Maydell =
<peter.maydell@linaro.org> wrote:
>=20
> On Mon, 12 Aug 2024 at 23:18, Danny Canter <danny_canter@apple.com> =
wrote:
>> On Aug 12, 2024, at 10:52=E2=80=AFAM, Peter Maydell =
<peter.maydell@linaro.org> wrote:
>>> This is unfortunately probably going to imply a bit of extra
>>> plumbing to be implemented for hvf -- that MachineClass::kvm_type
>>> method is (as the name suggests) KVM specific. (Multi-patch
>>> patchset for that, where we add the plumbing in as its own
>>> separate patch (and/or whatever other split of functionality
>>> into coherent chunks makes sense), rather than one-big-patch, =
please.)
>>=20
>> That=E2=80=99s perfectly fine, I=E2=80=99ll try and see how the =
plumbing was done
>> for KVM and try and emulate where it makes sense
>> for HVF. Agree though, that=E2=80=99d definitely push this into =
multi-patch
>> territory. Curious if you think what=E2=80=99s here today should
>> be multiple patches or the current work seems fine in one?
>=20
> I think it was fine as one patch. My personal preference
> when I write code tends to go for more-smaller-patches
> over fewer-larger-patches, so I might have for example
> split out "Add hvf_arch_vm_create()" into its own
> patch, but that's very borderline, and I wouldn't ask for
> that change at code review time unless the patch as a whole
> was too big and unwieldy and I was looking for places to
> suggest a split into multiple patches.
>=20
> -- PMM


--Apple-Mail=_C71342DE-4ECD-4706-890E-E43BFA71A686
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;">Forgot to =
leave a trail here :). V2 is posted&nbsp;<a =
href=3D"https://lists.gnu.org/archive/html/qemu-devel/2024-08/msg04016.htm=
l">https://lists.gnu.org/archive/html/qemu-devel/2024-08/msg04016.html</a>=
<div><br></div><div>Thanks again for review Peter!<br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On Aug 13, 2024, at 2:31=E2=80=AFAM, Peter Maydell =
&lt;peter.maydell@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>On Mon, 12 Aug 2024 at =
23:18, Danny Canter &lt;danny_canter@apple.com&gt; wrote:<br><blockquote =
type=3D"cite">On Aug 12, 2024, at 10:52=E2=80=AFAM, Peter Maydell =
&lt;peter.maydell@linaro.org&gt; wrote:<br><blockquote type=3D"cite">This =
is unfortunately probably going to imply a bit of extra<br>plumbing to =
be implemented for hvf -- that MachineClass::kvm_type<br>method is (as =
the name suggests) KVM specific. (Multi-patch<br>patchset for that, =
where we add the plumbing in as its own<br>separate patch (and/or =
whatever other split of functionality<br>into coherent chunks makes =
sense), rather than one-big-patch, please.)<br></blockquote><br>That=E2=80=
=99s perfectly fine, I=E2=80=99ll try and see how the plumbing was =
done<br>for KVM and try and emulate where it makes sense<br>for HVF. =
Agree though, that=E2=80=99d definitely push this into =
multi-patch<br>territory. Curious if you think what=E2=80=99s here today =
should<br>be multiple patches or the current work seems fine in =
one?<br></blockquote><br>I think it was fine as one patch. My personal =
preference<br>when I write code tends to go for =
more-smaller-patches<br>over fewer-larger-patches, so I might have for =
example<br>split out "Add hvf_arch_vm_create()" into its own<br>patch, =
but that's very borderline, and I wouldn't ask for<br>that change at =
code review time unless the patch as a whole<br>was too big and unwieldy =
and I was looking for places to<br>suggest a split into multiple =
patches.<br><br>-- =
PMM<br></div></div></blockquote></div><br></div></body></html>=

--Apple-Mail=_C71342DE-4ECD-4706-890E-E43BFA71A686--

