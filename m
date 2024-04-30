Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B8CC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 21:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1vFN-00081i-Um; Tue, 30 Apr 2024 17:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1s1vFL-00081O-Lp
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 17:42:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1s1vFI-0001p6-VQ
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 17:42:43 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43ULcbH9020107; Tue, 30 Apr 2024 21:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZWO69h3VUntzSl7aG7BagrCNAg45iGlHQSMeAD8T/Gg=;
 b=L2farsm9v1GWzpW/hmj71eTDJNksXd8QP4T8HL0c2vVJtqmcpZblyGw694AXf/QzJWCY
 b78nZZFsDaVXiAuHKk1kLjuf75qy/wQ0u1uepiIUx0kr5mLd6C7mseJi2GMDyHdhKru/
 5YWsGPKsudwtD5Yg4SA8ml2yIr8PUl+U/I/eUC68Im4SuEJnwdY5KHMxEyBqYl6jUWDU
 pCK8JH7tBUs5YUOjFF71ZjXTKZr9l/rAiFiR1O1D3mBICD6kU3JBPZ3gB9OLgc3qlFpz
 M1hsINyTHxlGrvfT1/DYCZ0n9Tul9GoNwuZ1Yp0HWyTLQQac/JoSjCCuhPiYKO+TEDAh Ow== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xu8qw805r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Apr 2024 21:42:31 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43UJ0sUj001433; Tue, 30 Apr 2024 21:42:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xsbptyk8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Apr 2024 21:42:30 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43ULgRYF34669090
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Apr 2024 21:42:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21B1C2004D;
 Tue, 30 Apr 2024 21:42:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C41A020040;
 Tue, 30 Apr 2024 21:42:26 +0000 (GMT)
Received: from heavy (unknown [9.171.51.254])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 30 Apr 2024 21:42:26 +0000 (GMT)
Date: Tue, 30 Apr 2024 23:42:25 +0200
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 00/13] exec: Rework around CPUState user fields (part 2)
Message-ID: <uuuk6a2vo24yrrqrchjxaeko3utqshrdu6txcnqziokpg7dkom@4l4kd3dqh6jc>
References: <20240430122808.72025-1-philmd@linaro.org>
 <363wwielvdpy37h7cqo7jo5luyys2aqmfgeb4t3wypsb3myqxg@kvasyjy4e767>
 <2a5e3a10-cc9a-44ff-8241-484d17b1f9cb@linaro.org>
 <90e4b6c6-2bc4-4f4a-ac65-8141c2eb4cb5@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <90e4b6c6-2bc4-4f4a-ac65-8141c2eb4cb5@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UI_5BLe2kwoLJipD4tOvKBydsNqblkD8
X-Proofpoint-ORIG-GUID: UI_5BLe2kwoLJipD4tOvKBydsNqblkD8
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_13,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404300155
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 30, 2024 at 09:00:17PM +0200, Philippe Mathieu-Daudé wrote:
> On 30/4/24 20:45, Philippe Mathieu-Daudé wrote:
> > Hi Ilya,
> > 
> > On 30/4/24 19:55, Ilya Leoshkevich wrote:
> > > On Tue, Apr 30, 2024 at 02:27:54PM +0200, Philippe Mathieu-Daudé wrote:
> > > > Missing WASM testing by Ilya (branch available at
> > > > https://gitlab.com/philmd/qemu/-/commits/tcg_flush_jmp_cache)
> > > 
> > > Hmm, it dies very early now:
> > > 
> > >    # gdb --args ./qemu-s390x -L /usr/s390x-linux-gnu /build/wasmtime/target/s390x-unknown-linux-gnu/debug/deps/component_fuzz_util-d10a3a6b4ad8af47
> > > 
> > >    Thread 1 "qemu-s390x" received signal SIGSEGV, Segmentation fault.
> > >    0x000055555559b718 in cpu_common_realizefn (dev=0x5555557c28c0,
> > > errp=<optimized out>) at
> > > ../home/iii/myrepos/qemu/hw/core/cpu-common.c:217
> > >    217             cpu->accel->plugin_state =
> > > qemu_plugin_create_vcpu_state();
> > > 
> > >    (gdb) bt
> > >    #0  0x000055555559b718 in cpu_common_realizefn
> > > (dev=0x5555557c28c0, errp=<optimized out>) at
> > > ../home/iii/myrepos/qemu/hw/core/cpu-common.c:217
> > >    #1  0x000055555559f59a in s390_cpu_realizefn (dev=0x5555557c28c0,
> > > errp=0x7fffffffe1a0) at
> > > ../home/iii/myrepos/qemu/target/s390x/cpu.c:284
> > >    #2  0x000055555563f76b in device_set_realized (obj=<optimized
> > > out>, value=<optimized out>, errp=0x7fffffffe2e0) at
> > > ../home/iii/myrepos/qemu/hw/core/qdev.c:510
> > >    #3  0x000055555564363d in property_set_bool (obj=0x5555557c28c0,
> > > v=<optimized out>, name=<optimized out>, opaque=0x5555557a9140,
> > > errp=0x7fffffffe2e0) at ../home/iii/myrepos/qemu/qom/object.c:2362
> > >    #4  0x0000555555646b9b in object_property_set
> > > (obj=obj@entry=0x5555557c28c0, name=name@entry=0x5555556e8ae2
> > > "realized", v=v@entry=0x5555557c6650,
> > > errp=errp@entry=0x7fffffffe2e0)
> > >        at ../home/iii/myrepos/qemu/qom/object.c:1471
> > >    #5  0x000055555564a43f in object_property_set_qobject
> > > (obj=obj@entry=0x5555557c28c0, name=name@entry=0x5555556e8ae2
> > > "realized", value=value@entry=0x5555557a7a90,
> > > errp=errp@entry=0x7fffffffe2e0)
> > >        at ../home/iii/myrepos/qemu/qom/qom-qobject.c:28
> > >    #6  0x0000555555647204 in object_property_set_bool
> > > (obj=0x5555557c28c0, name=name@entry=0x5555556e8ae2 "realized",
> > > value=value@entry=true, errp=errp@entry=0x7fffffffe2e0)
> > >        at ../home/iii/myrepos/qemu/qom/object.c:1541
> > >    #7  0x000055555564025c in qdev_realize (dev=<optimized out>,
> > > bus=bus@entry=0x0, errp=errp@entry=0x7fffffffe2e0) at
> > > ../home/iii/myrepos/qemu/hw/core/qdev.c:291
> > >    #8  0x000055555559bbb4 in cpu_create (typename=<optimized out>)
> > > at ../home/iii/myrepos/qemu/hw/core/cpu-common.c:61
> > >    #9  0x000055555559a467 in main (argc=4, argv=0x7fffffffeaa8,
> > > envp=<optimized out>) at
> > > ../home/iii/myrepos/qemu/linux-user/main.c:811
> > > 
> > >    (gdb) p cpu
> > >    $1 = (CPUState *) 0x5555557c28c0
> > >    (gdb) p cpu->accel
> > >    $2 = (AccelCPUState *) 0x0
> > > 
> > > Configured with: '/home/iii/myrepos/qemu/configure'
> > > '--target-list=s390x-linux-user' '--disable-tools' '--disable-slirp'
> > > '--disable-fdt' '--disable-capstone' '--disable-docs'
> > > 
> > > If you don't see what can be wrong here right away, I can debug this.
> 
> I added this commit in the same branch:
> 
> -- >8 --
> Author: Philippe Mathieu-Daudé <philmd@linaro.org>
> Date:   Tue Apr 30 20:57:15 2024 +0200
> 
>     accel/tcg: Initialize TCG plugins in cpu-target.c
> 
>     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> diff --git a/cpu-target.c b/cpu-target.c
> index 5af120e8aa..585533cfa3 100644
> --- a/cpu-target.c
> +++ b/cpu-target.c
> @@ -46,6 +46,10 @@
>  #include "hw/core/accel-cpu.h"
>  #include "trace/trace-root.h"
>  #include "qemu/accel.h"
> +#ifdef CONFIG_PLUGIN
> +#include "accel/tcg/vcpu-state.h"
> +#include "qemu/plugin.h"
> +#endif
> 
>  #ifndef CONFIG_USER_ONLY
>  static int cpu_common_post_load(void *opaque, int version_id)
> @@ -131,6 +135,13 @@ const VMStateDescription vmstate_cpu_common = {
>  };
>  #endif
> 
> +#ifdef CONFIG_PLUGIN
> +static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data
> unused)
> +{
> +    qemu_plugin_vcpu_init_hook(cpu);
> +}
> +#endif
> +
>  bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
>  {
>      /* cache the cpu class for the hotpath */
> @@ -143,6 +154,15 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
>      /* Wait until cpu initialization complete before exposing cpu. */
>      cpu_list_add(cpu);
> 
> +#ifdef CONFIG_PLUGIN
> +    assert(cpu->accel);
> +    /* Plugin initialization must wait until the cpu start executing code
> */
> +    if (tcg_enabled()) {
> +        cpu->accel->plugin_state = qemu_plugin_create_vcpu_state();
> +        async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async,
> RUN_ON_CPU_NULL);
> +    }
> +#endif
> +
>  #ifdef CONFIG_USER_ONLY
>      assert(qdev_get_vmsd(DEVICE(cpu)) == NULL ||
>             qdev_get_vmsd(DEVICE(cpu))->unmigratable);
> @@ -171,6 +191,13 @@ void cpu_exec_unrealizefn(CPUState *cpu)
>      }
>  #endif
> 
> +#ifdef CONFIG_PLUGIN
> +    /* Call the plugin hook before clearing the cpu is fully unrealized */
> +    if (tcg_enabled()) {
> +        qemu_plugin_vcpu_exit_hook(cpu);
> +    }
> +#endif
> +
>      cpu_list_remove(cpu);
>      /*
>       * Now that the vCPU has been removed from the RCU list, we can call
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index e03d31876f..cd8bd99131 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -30,10 +30,6 @@
>  #include "hw/boards.h"
>  #include "hw/qdev-properties.h"
>  #include "trace.h"
> -#ifdef CONFIG_PLUGIN
> -#include "accel/tcg/vcpu-state.h"
> -#include "qemu/plugin.h"
> -#endif
> 
>  CPUState *cpu_by_arch_id(int64_t id)
>  {
> @@ -181,13 +177,6 @@ static void cpu_common_parse_features(const char
> *typename, char *features,
>      }
>  }
> 
> -#ifdef CONFIG_PLUGIN
> -static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data
> unused)
> -{
> -    qemu_plugin_vcpu_init_hook(cpu);
> -}
> -#endif
> -
>  static void cpu_common_realizefn(DeviceState *dev, Error **errp)
>  {
>      CPUState *cpu = CPU(dev);
> @@ -211,14 +200,6 @@ static void cpu_common_realizefn(DeviceState *dev,
> Error **errp)
>          cpu_resume(cpu);
>      }
> 
> -    /* Plugin initialization must wait until the cpu start executing code
> */
> -#ifdef CONFIG_PLUGIN
> -    if (tcg_enabled()) {
> -        cpu->accel->plugin_state = qemu_plugin_create_vcpu_state();
> -        async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async,
> RUN_ON_CPU_NULL);
> -    }
> -#endif
> -
>      /* NOTE: latest generic point where the cpu is fully realized */
>  }
> 
> @@ -226,13 +207,6 @@ static void cpu_common_unrealizefn(DeviceState *dev)
>  {
>      CPUState *cpu = CPU(dev);
> 
> -    /* Call the plugin hook before clearing the cpu is fully unrealized */
> -#ifdef CONFIG_PLUGIN
> -    if (tcg_enabled()) {
> -        qemu_plugin_vcpu_exit_hook(cpu);
> -    }
> -#endif
> -
>      /* NOTE: latest generic point before the cpu is fully unrealized */
>      cpu_exec_unrealizefn(cpu);
>  }
> ---
> 
> Totally untested here because it is late (only built...).

Now I get:

  Thread 1 "qemu-s390x" received signal SIGABRT, Aborted.
  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at ./nptl/pthread_kill.c:44
  44      ./nptl/pthread_kill.c: No such file or directory.
  (gdb) bt
  #0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at ./nptl/pthread_kill.c:44
  #1  0x00007ffff7c41e8f in __pthread_kill_internal (signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:78
  #2  0x00007ffff7bf2fb2 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
  #3  0x00007ffff7bdd472 in __GI_abort () at ./stdlib/abort.c:79
  #4  0x00007ffff7bdd395 in __assert_fail_base (fmt=0x7ffff7d51a90 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=assertion@entry=0x5555556d71b8 "cpu->accel", 
      file=file@entry=0x5555556d70e0 "../home/iii/myrepos/qemu/cpu-target.c", line=line@entry=158, function=function@entry=0x5555556d7260 <__PRETTY_FUNCTION__.3> "cpu_exec_realizefn") at ./assert/assert.c:92
  #5  0x00007ffff7bebeb2 in __GI___assert_fail (assertion=assertion@entry=0x5555556d71b8 "cpu->accel", file=file@entry=0x5555556d70e0 "../home/iii/myrepos/qemu/cpu-target.c", line=line@entry=158, 
      function=function@entry=0x5555556d7260 <__PRETTY_FUNCTION__.3> "cpu_exec_realizefn") at ./assert/assert.c:101
  #6  0x00005555555d44ca in cpu_exec_realizefn (cpu=cpu@entry=0x5555557c28c0, errp=errp@entry=0x7fffffffe140) at ../home/iii/myrepos/qemu/cpu-target.c:158
  #7  0x000055555559f50b in s390_cpu_realizefn (dev=0x5555557c28c0, errp=0x7fffffffe1a0) at ../home/iii/myrepos/qemu/target/s390x/cpu.c:261
  #8  0x000055555563f78b in device_set_realized (obj=<optimized out>, value=<optimized out>, errp=0x7fffffffe2e0) at ../home/iii/myrepos/qemu/hw/core/qdev.c:510
  #9  0x000055555564365d in property_set_bool (obj=0x5555557c28c0, v=<optimized out>, name=<optimized out>, opaque=0x5555557a9140, errp=0x7fffffffe2e0) at ../home/iii/myrepos/qemu/qom/object.c:2362
  #10 0x0000555555646bbb in object_property_set (obj=obj@entry=0x5555557c28c0, name=name@entry=0x5555556e8ae2 "realized", v=v@entry=0x5555557c6650, errp=errp@entry=0x7fffffffe2e0)
      at ../home/iii/myrepos/qemu/qom/object.c:1471
  #11 0x000055555564a45f in object_property_set_qobject (obj=obj@entry=0x5555557c28c0, name=name@entry=0x5555556e8ae2 "realized", value=value@entry=0x5555557a7a90, errp=errp@entry=0x7fffffffe2e0)
      at ../home/iii/myrepos/qemu/qom/qom-qobject.c:28
  #12 0x0000555555647224 in object_property_set_bool (obj=0x5555557c28c0, name=name@entry=0x5555556e8ae2 "realized", value=value@entry=true, errp=errp@entry=0x7fffffffe2e0)
      at ../home/iii/myrepos/qemu/qom/object.c:1541
  #13 0x000055555564027c in qdev_realize (dev=<optimized out>, bus=bus@entry=0x0, errp=errp@entry=0x7fffffffe2e0) at ../home/iii/myrepos/qemu/hw/core/qdev.c:291
  #14 0x000055555559bb54 in cpu_create (typename=<optimized out>) at ../home/iii/myrepos/qemu/hw/core/cpu-common.c:57
  #15 0x000055555559a467 in main (argc=4, argv=0x7fffffffeaa8, envp=<optimized out>) at ../home/iii/myrepos/qemu/linux-user/main.c:811

Here is the executable file: http://0x0.st/XXHp.gz
sha256sum: 58eb8d2a90c08f772ae94e20a7a8c7567bd886fe022a6b9e117912cc13acbd82

Best regards,
Ilya

