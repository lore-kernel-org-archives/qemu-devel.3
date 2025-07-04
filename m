Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1576EC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 12:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXfC5-00073S-Ol; Fri, 04 Jul 2025 08:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uXfC2-00071z-9t
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:07:02 -0400
Received: from p-east3-cluster1-host4-snip4-10.eps.apple.com ([57.103.87.43]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uXfBz-0006BA-2a
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=ABXss1yk4Otbr4a1J29CZmIZb6m6sxx+cAVHmTUup8Y=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=AcaKGYn4MEpK3S2v1/QuwObM6rcsjprm876hznScwg4EiBJ4CeMUnF/gEx1uL2iZl
 ePDwsE7Hx4KUi3uBKE0lqW+jOMj7/0QuLXKHli6O7A3YJmvH7/yFQVV9RJEUTKAzMU
 NDffQMeB3zFNGVP1sLDJ31Sq006+Wk2unqALokqSEYjxSmH8/sZ3wghQ6KbFJvLRK6
 rijJw7zMIiQgvyQv3F2j2eKdaZxHy7+xgktjS4qHpSkIwpCBjj/veSfkJbqZsLWual
 mQw1Jp6eVoNj9EbAkQ4CHTxMUd/l+AqCeB3+Q/JHf9aMREFZCyk2MUmqFN0N42nYhr
 bKDH6EVa7E7cg==
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by outbound.qs.icloud.com (Postfix) with ESMTPS id 6E3A01800D04;
 Fri,  4 Jul 2025 12:06:51 +0000 (UTC)
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by outbound.qs.icloud.com (Postfix) with ESMTPSA id 8A609180025D;
 Fri,  4 Jul 2025 12:06:01 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v4 27/65] accel/hvf: Implement get_vcpu_stats()
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250702185332.43650-28-philmd@linaro.org>
Date: Fri, 4 Jul 2025 14:05:50 +0200
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AAAC3128-4BA8-4085-920A-9512786CA343@ynddal.dk>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-28-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Proofpoint-GUID: JJs5KPXV5DnKbWZS6g9rLCjIM9OPNCHq
X-Proofpoint-ORIG-GUID: JJs5KPXV5DnKbWZS6g9rLCjIM9OPNCHq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDA5MSBTYWx0ZWRfX1khnz0mrRzvc
 3Msr0mo3VWHQCABmGuGGqRFrM6H9mxyhXsRlSIt6J6+WMS4/dNXWx8J6dvz+s9jG1a6LbiOKavr
 RLjRonlkcrwa+6fLp3geFinWngrQdpoyG/SU/DETVr3uAqiMV7lTPswUe32nR2HP2TL7rijEXSk
 xFOyNOSx2yibd/0JCvS7Re9bRAUk4nxw2bpGKuq5KjDNrLgR4GyLLtVPD0YdwODIhsB12u7KT3Z
 epswYIDWMNc6WU9uualLUevrHMje9OKQm99U3cPSl1BS9z8g4gdeidlnQsKjBAfboNG9P29NY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_04,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0 clxscore=1030
 phishscore=0 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507040091
Received-SPF: pass client-ip=57.103.87.43; envelope-from=mads@ynddal.dk;
 helo=outbound.qs.icloud.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


> On 2 Jul 2025, at 20.52, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> accel/hvf/hvf-accel-ops.c | 19 +++++++++++++++++++
> 1 file changed, 19 insertions(+)
>=20
> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> index e7f40888c26..c07ebf8a652 100644
> --- a/accel/hvf/hvf-accel-ops.c
> +++ b/accel/hvf/hvf-accel-ops.c
> @@ -358,6 +358,12 @@ static inline int =
hvf_gdbstub_sstep_flags(AccelState *as)
>     return SSTEP_ENABLE | SSTEP_NOIRQ;
> }
>=20
> +static void do_hvf_get_vcpu_exec_time(CPUState *cpu, run_on_cpu_data =
arg)
> +{
> +    int r =3D hv_vcpu_get_exec_time(cpu->accel->fd, arg.host_ptr);
> +    assert_hvf_ok(r);
> +}
> +
> static void hvf_accel_class_init(ObjectClass *oc, const void *data)
> {
>     AccelClass *ac =3D ACCEL_CLASS(oc);
> @@ -583,6 +589,16 @@ static void hvf_remove_all_breakpoints(CPUState =
*cpu)
>     }
> }
>=20
> +static void hvf_get_vcpu_stats(CPUState *cpu, GString *buf)
> +{
> +    uint64_t time_us; /* units of mach_absolute_time() */
> +
> +    run_on_cpu(cpu, do_hvf_get_vcpu_exec_time, =
RUN_ON_CPU_HOST_PTR(&time_us));
> +
> +    g_string_append_printf(buf, "HVF cumulative execution time: =
%llu.%.3llus\n",
> +                                time_us / 1000000, (time_us % =
1000000) / 1000);
> +}
> +
> static void hvf_accel_ops_class_init(ObjectClass *oc, const void =
*data)
> {
>     AccelOpsClass *ops =3D ACCEL_OPS_CLASS(oc);
> @@ -601,7 +617,10 @@ static void hvf_accel_ops_class_init(ObjectClass =
*oc, const void *data)
>     ops->remove_breakpoint =3D hvf_remove_breakpoint;
>     ops->remove_all_breakpoints =3D hvf_remove_all_breakpoints;
>     ops->update_guest_debug =3D hvf_update_guest_debug;
> +
> +    ops->get_vcpu_stats =3D hvf_get_vcpu_stats;
> };
> +
> static const TypeInfo hvf_accel_ops_type =3D {
>     .name =3D ACCEL_OPS_NAME("hvf"),
>=20
> --=20
> 2.49.0
>=20

This doesn't return the right time for me (M3 Pro). If you tested on =
Intel, it might have a different time scale for mach units?

This is what I needed to change to make it work. Tested with 'yes > =
/dev/null' in the guest and 'info accel' in monitor.


diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index cf623a1ea4..5b3bcd553d 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -59,6 +59,7 @@
 #include "system/hvf.h"
 #include "system/hvf_int.h"
 #include "hw/core/cpu.h"
+#include <mach/mach_time.h>

 HVFState *hvf_state;

@@ -340,12 +341,16 @@ static void hvf_remove_all_breakpoints(CPUState =
*cpu)

 static void hvf_get_vcpu_stats(CPUState *cpu, GString *buf)
 {
-    uint64_t time_us; /* units of mach_absolute_time() */
+    uint64_t time_mach; /* units of mach_absolute_time() */

-    run_on_cpu(cpu, do_hvf_get_vcpu_exec_time, =
RUN_ON_CPU_HOST_PTR(&time_us));
+    run_on_cpu(cpu, do_hvf_get_vcpu_exec_time, =
RUN_ON_CPU_HOST_PTR(&time_mach));
+
+    mach_timebase_info_data_t timebase;
+    mach_timebase_info(&timebase);
+    uint64_t time_ns =3D time_mach * timebase.numer / timebase.denom;

     g_string_append_printf(buf, "HVF cumulative execution time: =
%llu.%.3llus\n",
-                                time_us / 1000000, (time_us % 1000000) =
/ 1000);
+                                time_ns / 1000000000, (time_ns % =
1000000000) / 1000000);
 }

 static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)



