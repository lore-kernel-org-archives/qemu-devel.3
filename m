Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D409BCD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 23:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waMPD-0007jP-8S; Thu, 18 Jun 2026 19:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1waMPB-0007j2-DC
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 19:44:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1waMP9-0007rF-5M
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 19:44:16 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65ILrwLr3058826
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 23:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YeDqIoUlbhporoWWOQUv5DxsmvQCdfjwqEfV/5CxoPE=; b=FszMSuASYv3Sv6Tl
 1/+X/x1ZNx44EMi50JZ63ySDr5vrb79NCbqqqAwSzQiQDaI5ocRdPwrteXcnJtO0
 qknFHz1LEhpKa5HXTwRqi5fVTDy7rrH8TjZ7AxVEryIxKP4dqQPnPOsRGVFT1llN
 4Oj4kgQtSXPB/UTCNz11xTIJJDI1xj/hLFzKVlSbdifiEFlAT6nqplE1bEsiNGfF
 2AHNHa6lmYKitmrAZGTUORNwuWXuFntdRTLXNQpZeZvS5fI1mvXvTvwFcypVNj2I
 Vtol/F5y/sbdnjS//ZsRg17vxfXixFApgcRWVUIkTo63jgmqGcbGVO6WgEITQ3m7
 b/1KFA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evmtj9hpv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 23:44:13 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-138156c0492so5419381c88.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 16:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781826253; x=1782431053; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YeDqIoUlbhporoWWOQUv5DxsmvQCdfjwqEfV/5CxoPE=;
 b=OGm8p4zGH8h9mhTmx+HTlzomjwbdTGq7TUsYODNtfQuKGGzAsNCuVPNHimyDjxNIdL
 7P+9z3yD0XcBmeDH7f0Vw6hugvqBQUQ55qc81SVpYKTZhsaBifORTV9JChM/7wQsczr+
 yNvttgnvn+d/wNNLVJ7SKgE3gRgJbuG3Fz7+yYMmdEzMTSD/BlqlpdZ1y/GLXAmzATmh
 voYjcsM7wMN7p0fqc4flQyEa+LV6UQZfCuY3FoUlCgAdpM40zG0QEKlIka1d8OM9vr52
 X4gl1XdX16jelgVenq+6hexJrcTOQRh32K1OqKd1We4YeW9EuaSe/y2yd1OcX4jaNkmv
 3r6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781826253; x=1782431053;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YeDqIoUlbhporoWWOQUv5DxsmvQCdfjwqEfV/5CxoPE=;
 b=rHMOg/YSkrcDluycgqsE3hPJ62dvhZFPKsdEhtC9q3aFfClLqD1fl6WR5BX0gDrpEo
 LDeE2TMkAiBHhCHFAjHcurPaXRSiCKocuF3hPHehJDoq23A9x1nq7+5jzc+6FdZi+kNi
 1ILAd1rD0pU3PUWCvTo0e2H2uSGPpm/nEXWuOsaXfkbrKWN/l24odg6AcTKeWtuptMWM
 pxgUz/AQSKEL41635CzjK8wlv5h3YV9ZnVTpFFPa0NWE2DgZNAwBwGybtBe4yXCwMWu9
 zEiQis4YDkKUEbfHdpDSz9Q6Kbi8G2LDsZUCqAVIvcfI0q0jUxQZwJCDDIREU/6d18k5
 Sg6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+lV50APCMJ91l8QiGOz3RIywGFJDTw1HiOtQuJRzke/8BBC83QGU0B6G5sRa0Pk4h+YJ1aJzR158ZP@nongnu.org
X-Gm-Message-State: AOJu0YzrjwM7rxOFOI97YFPwZcOI0iSLkBzU4AgTiXEhQ4D4xXCFCIP2
 BKtmU1fBAfjIw926URFnv4TLVrnpCSNsxsof1iGUv0jktGbyjaMJqg61O7wtGXmgxjD1qjPbKkK
 pxfpWt7y5oXE2/eGfSWCSD5nMPsei1L4q+VmPf6+qnJYgx0sZUZdF/yZrbA==
X-Gm-Gg: AfdE7ckE17lyQEfaFzM0PzA8l5wloMiUoFCPoXAsLfDYjNc5ajCv+zHvU2Q7qi7XvT4
 4VcxtUz5ENJIHkV1uW6ZS50edigS8NbqAJ7geY9GEnmD0mWz9tsI13V/LkfM/fvpdvnW8b5s88Z
 PCTKvlEg9UdSof4ZzDT2m7b3UCkCv7RGoCrVXLsl4UTSLrNZ9cnubtsGMmM72C9ZSy0L+qmhYiT
 yI6Xe/sBLiC9Q2Y8X7Hq5vk7KWGRPMpGrHgPQKMckxx2lhaqMARQvs3nsMQmd0qKNbS0fxk5dNL
 r6+54rKOOH4iImeBXtypL77gkpkRM25EOvPLhjhv60gui88PiRH4aK8KyBwE35zS6UDCDDlgkVV
 59BZk2DFHF66dRLJ9nLUoauTsL3HyUdXN1ts962z6n+SyIUkj1U0En7bpLQ+aAW1xbWOFmofn5q
 KtzX4=
X-Received: by 2002:a05:7022:f68e:b0:137:fec9:8ffb with SMTP id
 a92af1059eb24-139a504e7damr97055c88.25.1781826252955; 
 Thu, 18 Jun 2026 16:44:12 -0700 (PDT)
X-Received: by 2002:a05:7022:f68e:b0:137:fec9:8ffb with SMTP id
 a92af1059eb24-139a504e7damr97036c88.25.1781826252421; 
 Thu, 18 Jun 2026 16:44:12 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139a3494c66sm499174c88.2.2026.06.18.16.44.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 16:44:11 -0700 (PDT)
Message-ID: <3cf06923-63ae-4026-9044-7ae2607144ad@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 16:44:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] contrib/plugins: add a minimal passthrough plugin
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260617130742.769234-1-functioner@sjtu.edu.cn>
 <20260617130742.769234-2-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260617130742.769234-2-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDIxNiBTYWx0ZWRfX8JGQazEdZD28
 ugc2uZ6wYq386/4xG9X+agFjBPuoH1uTOAR2j5sSv7vF/Pmn2zU5jmo2HKUxj9/ecZoG3bxYMsg
 49td+mo7wAXH4T+jcDQDCWTlndYxkXc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDIxNiBTYWx0ZWRfXypMQH4pq+CMj
 XhLMCvucT4IpV87H01xCXDzYN+TlEbiAtL+IRhRRam9N+veGdzmFiRO8umSfvCB+FbJ+AxquEsr
 YDLm3J+fXeAS5HjKl8zH4tXFJqy0fUlvZk1TEcVpIAAH1Q2iKGL7ynfXh30i/E90JBLvkYm/mBY
 td4Tdec0hIbqYCiWtD3S9DYpbU3xsgFDDFzpwO6omRJ3aGXe+2JQPo68HZNSini6Vzljr2sC4st
 1D5MJ1mQAt/ppHpzrXFIuqjElJrmOs8dQDver7OxVFgky9Hkc5MY4pVsI6yk8mrHcdyQmaiDX6F
 ugKVMeNDCI1VIDCEN+Hcd10Ef2h5SmeyNFx/6WMTJZJtN0W2Uq5yOzib0L/iuB4WjJZNFyP/Fsj
 ubqVn9kPyos24pe0dt+lab7TfVmE8I7M4iRnNWqodrdiE5P2W0hofMH9z8XRH0Au32ps7bFQ+Wo
 IxAmD7/uHm8B5rVqJDg==
X-Proofpoint-GUID: 2wvKYluK14lCFud9FYkSY_c5ZP6BxO-u
X-Proofpoint-ORIG-GUID: 2wvKYluK14lCFud9FYkSY_c5ZP6BxO-u
X-Authority-Analysis: v=2.4 cv=OM8XGyaB c=1 sm=1 tr=0 ts=6a3482ce cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=xzRSIUojZjBAsTHTd1cA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180216
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/17/2026 6:07 AM, Ziyang Zhang wrote:
> Add a minimal passthrough plugin that lets the guest invoke host
> functions through magic system calls. The plugin registers a vCPU
> syscall filter callback that intercepts a reserved syscall number and
> dispatches a set of pass-through operations: querying host attributes,
> loading and freeing shared libraries, resolving symbols, retrieving the
> last library error, and invoking a host function through a common
> interface.
> 
> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
> ---
>  contrib/plugins/meson.build   |   1 +
>  contrib/plugins/passthrough.c | 187 ++++++++++++++++++++++++++++++++++
>  2 files changed, 188 insertions(+)
>  create mode 100644 contrib/plugins/passthrough.c
> 
> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
> index 099319e7a1..5bfeb1cd60 100644
> --- a/contrib/plugins/meson.build
> +++ b/contrib/plugins/meson.build
> @@ -9,6 +9,7 @@ contrib_plugins = [
>  'howvec.c',
>  'hwprofile.c',
>  'ips.c',
> +'passthrough.c',
>  'stoptrigger.c',
>  'traps.c',
>  'uftrace.c',
> diff --git a/contrib/plugins/passthrough.c b/contrib/plugins/passthrough.c
> new file mode 100644
> index 0000000000..f2db9acdfe
> --- /dev/null
> +++ b/contrib/plugins/passthrough.c
> @@ -0,0 +1,187 @@
> +/*
> + * Copyright (C) 2026, Ziyang Zhang <functioner@sjtu.edu.cn>
> + *
> + * Passthrough Plugin: lets a guest invoke host functions via a magic
> + * system call. This grants the guest full host access (dlopen/dlsym and
> + * arbitrary function calls), so use it only with trusted guests.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <assert.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <glib.h>
> +#include <dlfcn.h>
> +
> +#include <qemu-plugin.h>
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> +
> +/* The magic system call number for pass-through. */
> +enum {
> +    SYSCALL_PASSTHROUGH_NUMBER = 4096,
> +};
> +
> +/*
> + * Pass-through calling convention.
> + *
> + * The guest issues system call SYSCALL_PASSTHROUGH_NUMBER. The first syscall
> + * argument (a1) is one of the call IDs below; the remaining arguments (a2, a3,
> + * a4, ...) are that ID's operands. All pointer operands are guest virtual
> + * addresses that the plugin dereferences as host addresses directly. This
> + * assumes guest_base is 0, so the guest and host address spaces coincide;
> + * with a non-zero guest_base every pointer operand would be off by guest_base
> + * and the dereferences would hit unrelated host memory. Results are written
> + * back through caller-provided "out" pointers rather than returned in the
> + * syscall value.
> + *
> + * The syscall return value (*sysret) only reports dispatch status: 0 on a
> + * recognised ID, -EINVAL for an unknown one. The actual success/failure of an
> + * operation (e.g. a NULL handle from dlopen) is delivered through its out
> + * pointer, exactly like the underlying libdl call.
> + *
> + * Operands per ID:
> + *
> + *   PASSTHROUGH_ID_GET_HOST_ATTRIBUTE
> + *     a2  const char *key        in:  attribute name to query
> + *     a3  const char **attr_ptr  out: matching value, or NULL if unknown
> + *
> + *   PASSTHROUGH_ID_LOAD_LIBRARY                            (wraps dlopen)
> + *     a2  const char *path       in:  library path
> + *     a3  int flags              in:  dlopen() flags (e.g. RTLD_NOW)
> + *     a4  void **handle_ptr      out: library handle, or NULL on failure
> + *
> + *   PASSTHROUGH_ID_GET_PROC_ADDRESS                        (wraps dlsym)
> + *     a2  void *handle           in:  library handle
> + *     a3  const char *name       in:  symbol name
> + *     a4  void **entry_ptr       out: symbol address, or NULL if not found
> + *
> + *   PASSTHROUGH_ID_FREE_LIBRARY                            (wraps dlclose)
> + *     a2  void *handle           in:  library handle
> + *     a3  int *ret_ptr           out: dlclose() return value (0 on success)
> + *
> + *   PASSTHROUGH_ID_GET_LIBRARY_ERROR                       (wraps dlerror)
> + *     a2  const char **error_ptr out: last libdl error string, or NULL
> + *
> + *   PASSTHROUGH_ID_INVOKE_PROC                             (calls the symbol)
> + *     a2  void *proc             in:  function pointer, signature
> + *                                     void (*)(void *arg1, void *arg2)
> + *     a3  void *arg1             in:  first argument forwarded to proc
> + *     a4  void *arg2             in:  second argument forwarded to proc
> + */
> +enum PassThroughID {
> +    PASSTHROUGH_ID_GET_HOST_ATTRIBUTE,
> +    PASSTHROUGH_ID_LOAD_LIBRARY,
> +    PASSTHROUGH_ID_GET_PROC_ADDRESS,
> +    PASSTHROUGH_ID_FREE_LIBRARY,
> +    PASSTHROUGH_ID_GET_LIBRARY_ERROR,
> +    PASSTHROUGH_ID_INVOKE_PROC,
> +};
> +
> +static inline const char *query_host_attribute(const char *key)
> +{
> +    if (strcmp(key, "emu") == 0) {
> +        return "qemu";
> +    }
> +    return NULL;
> +}
> +
> +static inline void invoke_proc(void *proc, void *arg1, void *arg2)
> +{
> +    typedef void (*Func)(void * /*arg1*/, void * /*arg2*/);
> +    Func func = (Func) proc;
> +    func(arg1, arg2);
> +}
> +
> +static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_index,
> +                                int64_t num, uint64_t a1, uint64_t a2,
> +                                uint64_t a3, uint64_t a4, uint64_t a5,
> +                                uint64_t a6, uint64_t a7, uint64_t a8,
> +                                uint64_t *sysret)
> +{
> +    if (num == SYSCALL_PASSTHROUGH_NUMBER) {
> +        switch (a1) {
> +        /* Query host attribute by a reserved key. */
> +        case PASSTHROUGH_ID_GET_HOST_ATTRIBUTE: {
> +            const char *key = (const char *) a2;
> +            const char **attr_ptr = (const char **) a3;
> +            assert(attr_ptr);
> +            *attr_ptr = query_host_attribute(key);
> +            *sysret = 0;
> +            break;
> +        }
> +
> +        /* Load a shared library. */
> +        case PASSTHROUGH_ID_LOAD_LIBRARY: {
> +            const char *path = (const char *) a2;
> +            int flags = (int) a3;
> +            void **handle_ptr = (void **) a4;
> +            assert(handle_ptr);
> +            *handle_ptr = dlopen(path, flags);
> +            *sysret = 0;
> +            break;
> +        }
> +
> +        /* Get the address of a function in a shared library. */
> +        case PASSTHROUGH_ID_GET_PROC_ADDRESS: {
> +            void *handle = (void *) a2;
> +            const char *name = (const char *) a3;
> +            void **entry_ptr = (void **) a4;
> +            assert(entry_ptr);
> +            *entry_ptr = dlsym(handle, name);
> +            *sysret = 0;
> +            break;
> +        }
> +
> +        /* Free a shared library. */
> +        case PASSTHROUGH_ID_FREE_LIBRARY: {
> +            void *handle = (void *) a2;
> +            int *ret_ptr = (int *) a3;
> +            *ret_ptr = dlclose(handle);
> +            *sysret = 0;
> +            break;
> +        }
> +
> +        /* Get the last error message for a library event. */
> +        case PASSTHROUGH_ID_GET_LIBRARY_ERROR: {
> +            const char **error_ptr = (const char **) a2;
> +            *error_ptr = dlerror();
> +            *sysret = 0;
> +            break;
> +        }
> +
> +        /* Invoke a function of a common interface. */
> +        case PASSTHROUGH_ID_INVOKE_PROC: {
> +            void *proc = (void *) a2;
> +            void *arg1 = (void *) a3;
> +            void *arg2 = (void *) a4;
> +            assert(proc);
> +            invoke_proc(proc, arg1, arg2);
> +            *sysret = 0;
> +            break;
> +        }
> +
> +        default:
> +            *sysret = -EINVAL;
> +            break;
> +        }
> +        return true;
> +    }
> +    return false;
> +}
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> +                                           const qemu_info_t *info,
> +                                           int argc, char **argv)
> +{
> +    if (info->system_emulation) {
> +        fprintf(stderr, "plugin passthrough: only useful for user emulation\n");
> +        return -1;
> +    }
> +
> +    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
> +
> +    return 0;
> +}

I don't have any specific comment on the plugin itself, it's pretty
clear and straightforward.

Maybe you might want to be able to tune syscall number with a parameter,
but it's definitely just a suggestion.

Regards,
Pierrick

