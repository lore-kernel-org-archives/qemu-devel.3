Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D04C3DA4A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 00:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf7WQ-0006Og-Ju; Fri, 16 Aug 2024 20:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1sf7WO-0006OA-Py
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 20:42:20 -0400
Received: from ma-mailsvcp-mx-lapp02.apple.com ([17.32.222.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1sf7WM-0007X0-BY
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 20:42:20 -0400
Received: from rn-mailsvcp-mta-lapp04.rno.apple.com
 (rn-mailsvcp-mta-lapp04.rno.apple.com [10.225.203.152])
 by ma-mailsvcp-mx-lapp02.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SIC000MG722PA10@ma-mailsvcp-mx-lapp02.apple.com> for
 qemu-devel@nongnu.org; Fri, 16 Aug 2024 17:37:15 -0700 (PDT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_17,2024-08-16_01,2024-05-17_01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=cc :
 content-type : date : from : in-reply-to : message-id : mime-version :
 references : subject : to; s=20180706;
 bh=Z1KtMJ9inNrCSBgeoGYAd5GLzpy22ae6mW9LL6GR8OY=;
 b=igpAYPMSBEiDRqWVK6CQ/1rainOGPYdJ6FnPzSHAP5oJhxArV3RbI01dU/wDGeXvJJli
 2SefRr/AKTOrj8+7YbyQDb9tKEIsqExjahH2J2koMmoKTCv84HBHg5mHS+qg2oQG+O8w
 tVEfuZC5hStXe7G6vhV0x0cIwRJp7SoNFdSc2rIEmphqv1ayUPM8/uAbpPPrmtMiycUh
 /Vo4DBaF6IV/4gRHRvHMBx5n55/HYaZBB76N1aVe6yzyh2ybXfxPOHvk6sObqtF2UVku
 FECKjYkY8WG8mtmmD79low5MwQVOEC+5MhmmQCHr1jjk+o63AA/WpWfhMKL5EKbyPSM0 UA==
Received: from mr55p01nt-mmpp04.apple.com
 (mr55p01nt-mmpp04.apple.com [10.170.185.204])
 by rn-mailsvcp-mta-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SIC00YKH721J590@rn-mailsvcp-mta-lapp04.rno.apple.com>; 
 Fri, 16 Aug 2024 17:37:13 -0700 (PDT)
Received: from process_milters-daemon.mr55p01nt-mmpp04.apple.com by
 mr55p01nt-mmpp04.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SIC08X006TJVD00@mr55p01nt-mmpp04.apple.com>; Sat,
 17 Aug 2024 00:37:13 +0000 (GMT)
X-Va-A: 
X-Va-T-CD: 9be860c946f6cbc0801dd392535b1c06
X-Va-E-CD: 6e8d677d3901fd5b58b190047ca79016
X-Va-R-CD: 4206bda14c83e153d471243933acbb53
X-Va-ID: df1ee542-a3ac-4040-bb1c-4785413cf21f
X-Va-CD: 0
X-V-A: 
X-V-T-CD: 9be860c946f6cbc0801dd392535b1c06
X-V-E-CD: 6e8d677d3901fd5b58b190047ca79016
X-V-R-CD: 4206bda14c83e153d471243933acbb53
X-V-ID: 7c7b94ba-3674-487b-b424-138886f76123
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_17,2024-08-16_01,2024-05-17_01
Received: from smtpclient.apple (unknown [17.11.165.88])
 by mr55p01nt-mmpp04.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPSA id <0SIC08DD271OBV00@mr55p01nt-mmpp04.apple.com>; Sat,
 17 Aug 2024 00:37:12 +0000 (GMT)
From: Danny Canter <danny_canter@apple.com>
Message-id: <CA7E2403-A9F6-4B29-B640-13E41D530744@apple.com>
Content-type: multipart/alternative;
 boundary="Apple-Mail=_182B2C20-4477-4C15-BACF-6201DBE72E07"
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3815.100.3\))
Subject: Re: [PATCH] hvf: arm: Allow creating VMs with > 63GB of RAM on macOS
 15+
Date: Fri, 16 Aug 2024 17:36:42 -0700
In-reply-to: <CAFEAcA9XXhsUeHNjsVkjhjO2_Njkk=L00BG+24xtXWWKgJayRw@mail.gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, rbolshakov@ddn.com, agraf@csgraf.de
To: Peter Maydell <peter.maydell@linaro.org>
References: <20240718230031.69641-1-danny_canter@apple.com>
 <CAFEAcA__WZ=uw0VLcP0fLbUTwmctsZ1y=FRf9bXMT9WJC2sRFA@mail.gmail.com>
 <E03A8C36-4079-468F-9596-328D713C3611@apple.com>
 <CAFEAcA9XXhsUeHNjsVkjhjO2_Njkk=L00BG+24xtXWWKgJayRw@mail.gmail.com>
X-Mailer: Apple Mail (2.3815.100.3)
Received-SPF: pass client-ip=17.32.222.23; envelope-from=danny_canter@apple.com;
 helo=ma-mailsvcp-mx-lapp02.apple.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
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


--Apple-Mail=_182B2C20-4477-4C15-BACF-6201DBE72E07
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Peter, thought I=E2=80=99d send this little snippet before getting the =
rest of V2 done in case anyone hates this :). I tried to take a similar =
approach to kvm_type,
but I=E2=80=99m not sure if this will be looked upon favorably so want =
an early opinion. The nice thing about kvm_type is at least it has =
differing meaning per
platform so all the impls can do whatever they need, with the below =
it=E2=80=99s really only needed on ARM (and obviously macOS specific) so =
it's a bit odd,
but couldn=E2=80=99t think of how else to be able to be able to get what =
we need out of the memmap during vm creation.=20

How this would be used is almost exactly like how ARMs kvm_type is used. =
We set up hvf_get_physical_address_range to freeze the memory
map and compute the highest gpa, then check if that exceeds our =
platforms largest IPA size and if so return a sane error message. If =
everything
checks out we=E2=80=99d just set the IPA size on the VM config object =
and then create the VM. The current patch should mostly stay the same =
after that bit
of plumbing I think besides removing the macOS 13 ifdef=E2=80=99s (and =
simplifying the copy and pasted loop you pointed out). x86=E2=80=99s
hvf_get_physical_address_range can be NULL.

--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -215,6 +215,10 @@ typedef struct {
  *    Return the type of KVM corresponding to the kvm-type string =
option or
  *    computed based on other criteria such as the host kernel =
capabilities.
  *    kvm-type may be NULL if it is not needed.
+ * @hvf_get_physical_address_range:
+ *    Returns the physical address range in bits to use for the HVF =
virtual
+ *    machine based on the current boards memory map. This may be NULL =
if it
+ *    is not needed.
  * @numa_mem_supported:
  *    true if '--numa node.mem' option is supported and false otherwise
  * @hotplug_allowed:
@@ -253,6 +257,7 @@ struct MachineClass {
     void (*reset)(MachineState *state, ShutdownCause reason);
     void (*wakeup)(MachineState *state);
     int (*kvm_type)(MachineState *machine, const char *arg);
+    unsigned int (*hvf_get_physical_address_range)(MachineState =
*machine);

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


--Apple-Mail=_182B2C20-4477-4C15-BACF-6201DBE72E07
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;">Peter, thought =
I=E2=80=99d send this little snippet before getting the rest of V2 done =
in case anyone hates this :). I tried to take a similar approach to =
kvm_type,<div>but I=E2=80=99m not sure if this will be looked upon =
favorably so want an early opinion. The nice thing about kvm_type is at =
least it has differing meaning per</div><div>platform so all the impls =
can do whatever they need, with the below it=E2=80=99s really only =
needed on ARM (and obviously macOS specific) so it's a bit =
odd,</div><div>but couldn=E2=80=99t think of how else to be able to be =
able to get what we need out of the memmap during vm =
creation.&nbsp;<div><div><br></div><div>How this would be used is almost =
exactly like how ARMs kvm_type is used. We set up&nbsp;<span =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, =
0);">hvf_get_physical_address_range to freeze the =
memory</span></div><div>map and compute the highest gpa, then&nbsp;<span =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">check if that =
exceeds our platforms largest IPA size and if so return a sane error =
message. If&nbsp;</span><span style=3D"caret-color: rgb(0, 0, 0); color: =
rgb(0, 0, 0);">everything</span></div><div><span style=3D"caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0);">checks out we=E2=80=99d just set the =
IPA size on the VM config object and then create the VM. The current =
patch should mostly stay the&nbsp;</span><span style=3D"color: rgb(0, 0, =
0);">same after that bit</span></div><div><span style=3D"color: rgb(0, =
0, 0);">of plumbing I think besides removing the macOS 13 ifdef=E2=80=99s =
(and simplifying the copy and pasted loop you pointed =
out).&nbsp;</span><font color=3D"#000000">x86=E2=80=99s</font></div><div><=
span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, =
0);">hvf_get_physical_address_range can be =
NULL.</span></div><div><br></div><div><div>--- =
a/include/hw/boards.h</div><div>+++ b/include/hw/boards.h</div><div>@@ =
-215,6 +215,10 @@ typedef struct {</div><div>&nbsp; * &nbsp; =
&nbsp;Return the type of KVM corresponding to the kvm-type string option =
or</div><div>&nbsp; * &nbsp; &nbsp;computed based on other criteria such =
as the host kernel capabilities.</div><div>&nbsp; * &nbsp; =
&nbsp;kvm-type may be NULL if it is not needed.</div><div>+ * =
@hvf_get_physical_address_range:</div><div>+ * &nbsp; &nbsp;Returns the =
physical address range in bits to use for the HVF virtual</div><div>+ * =
&nbsp; &nbsp;machine based on the current boards memory map. This may be =
NULL if it</div><div>+ * &nbsp; &nbsp;is not needed.</div><div>&nbsp; * =
@numa_mem_supported:</div><div>&nbsp; * &nbsp; &nbsp;true if '--numa =
node.mem' option is supported and false otherwise</div><div>&nbsp; * =
@hotplug_allowed:</div><div>@@ -253,6 +257,7 @@ struct MachineClass =
{</div><div>&nbsp; &nbsp; &nbsp;void (*reset)(MachineState *state, =
ShutdownCause reason);</div><div>&nbsp; &nbsp; &nbsp;void =
(*wakeup)(MachineState *state);</div><div>&nbsp; &nbsp; &nbsp;int =
(*kvm_type)(MachineState *machine, const char *arg);</div><div>+ &nbsp; =
&nbsp;unsigned int (*hvf_get_physical_address_range)(MachineState =
*machine);</div></div><div><div><br><blockquote type=3D"cite"><div>On =
Aug 13, 2024, at 2:31=E2=80=AFAM, Peter Maydell =
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
PMM<br></div></div></blockquote></div><br></div></div></div></body></html>=

--Apple-Mail=_182B2C20-4477-4C15-BACF-6201DBE72E07--

