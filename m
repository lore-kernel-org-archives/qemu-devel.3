Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996D0C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 05:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUJh2-00055h-MC; Thu, 18 Jul 2024 01:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1sUJh1-00054T-0q; Thu, 18 Jul 2024 01:28:39 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1sUJgy-0004kr-8u; Thu, 18 Jul 2024 01:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721280516; x=1752816516;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=/n30pXRSaPg6/RNVS5KqTJU65apInj9L15dc5ZlOJWI=;
 b=VycG8yNGVGSDzAPDmTF6MsK5Zqec6pIqe6m8mVgC6qum6ja6iRy2dTaz
 c+tJlV6MaWRkcsdn2TwEwkxWp2ukp4fAa5ss0XPz1D+9lEM5tJtfzHSrp
 kAguwTbwfK+CplkxCAih6q4FYajCvsXCURNpMVfWEWQO+CN9YRDY8v+1I
 oZWBBje6DsoRwOPEKgKsmPfdvkV/CciAIW60MGApz05QrH/8x+HHOO191
 IHQusCp4GZSplH0nZesIJybcQOLRT5lwK9iXk5yRF71v8De3uWkWz/iLM
 8rUTLMyKUB30f+oDGQKAoegNae8Iy0gEEgl6WtIjsdA0TLZ6z5Ouq5gZu g==;
X-CSE-ConnectionGUID: rrdU6jkwRd6Pm6v7oNFdag==
X-CSE-MsgGUID: llQ+u3j7T16/EGBDXqTOWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="18671314"
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; d="scan'208";a="18671314"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2024 22:28:33 -0700
X-CSE-ConnectionGUID: 1d43GwztQwePSZ+OmH1dMg==
X-CSE-MsgGUID: 3F6yikizQVyqX8j1PyIE4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; d="scan'208";a="55777879"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.225.1])
 ([10.124.225.1])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2024 22:28:29 -0700
Message-ID: <f18ab76c-abbe-4599-9631-603853bcfa0b@linux.intel.com>
Date: Thu, 18 Jul 2024 13:28:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/5] i386/kvm: Support event with select&umask format in KVM
 PMU filter
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti
 <mtosatti@redhat.com>, Shaoqin Huang <shahuang@redhat.com>,
 Eric Auger <eauger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Yuan Yao <yuan.yao@intel.com>, Xiong Zhang <xiong.y.zhang@intel.com>,
 Mingwei Zhang <mizhang@google.com>, Jim Mattson <jmattson@google.com>
References: <20240710045117.3164577-1-zhao1.liu@intel.com>
 <20240710045117.3164577-4-zhao1.liu@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20240710045117.3164577-4-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=198.175.65.19;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 7/10/2024 12:51 PM, Zhao Liu wrote:
> The select&umask is the common way for x86 to identify the PMU event,
> so support this way as the "x86-default" format in kvm-pmu-filter
> object.
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  accel/kvm/kvm-pmu.c      | 62 ++++++++++++++++++++++++++++++++++++++++
>  include/sysemu/kvm-pmu.h | 13 +++++++++
>  qapi/kvm.json            | 46 +++++++++++++++++++++++++++--
>  target/i386/kvm/kvm.c    |  5 ++++
>  4 files changed, 123 insertions(+), 3 deletions(-)
>
> diff --git a/accel/kvm/kvm-pmu.c b/accel/kvm/kvm-pmu.c
> index 483d1bdf4807..51d3fba5a72a 100644
> --- a/accel/kvm/kvm-pmu.c
> +++ b/accel/kvm/kvm-pmu.c
> @@ -17,6 +17,8 @@
>  #include "qom/object_interfaces.h"
>  #include "sysemu/kvm-pmu.h"
>  
> +#define UINT12_MAX (4095)
> +
>  static void kvm_pmu_filter_get_event(Object *obj, Visitor *v, const char *name,
>                                       void *opaque, Error **errp)
>  {
> @@ -38,6 +40,12 @@ static void kvm_pmu_filter_get_event(Object *obj, Visitor *v, const char *name,
>              str_event->u.raw.code = g_strdup_printf("0x%lx",
>                                                      event->u.raw.code);
>              break;
> +        case KVM_PMU_EVENT_FMT_X86_DEFAULT:
> +            str_event->u.x86_default.select =
> +                g_strdup_printf("0x%x", event->u.x86_default.select);
> +            str_event->u.x86_default.umask =
> +                g_strdup_printf("0x%x", event->u.x86_default.umask);
> +            break;
>          default:
>              g_assert_not_reached();
>          }
> @@ -83,6 +91,60 @@ static void kvm_pmu_filter_set_event(Object *obj, Visitor *v, const char *name,
>                  goto fail;
>              }
>              break;
> +        case KVM_PMU_EVENT_FMT_X86_DEFAULT: {
> +            uint64_t select, umask;
> +
> +            ret = qemu_strtou64(str_event->u.x86_default.select, NULL,
> +                                0, &select);
> +            if (ret < 0) {
> +                error_setg(errp,
> +                           "Invalid %s PMU event (select: %s): %s. "
> +                           "The select must be a "
> +                           "12-bit unsigned number string.",
> +                           KVMPMUEventEncodeFmt_str(str_event->format),
> +                           str_event->u.x86_default.select,
> +                           strerror(-ret));
> +                g_free(event);
> +                goto fail;
> +            }
> +            if (select > UINT12_MAX) {
> +                error_setg(errp,
> +                           "Invalid %s PMU event (select: %s): "
> +                           "Numerical result out of range. "
> +                           "The select must be a "
> +                           "12-bit unsigned number string.",
> +                           KVMPMUEventEncodeFmt_str(str_event->format),
> +                           str_event->u.x86_default.select);
> +                g_free(event);
> +                goto fail;
> +            }
> +            event->u.x86_default.select = select;
> +
> +            ret = qemu_strtou64(str_event->u.x86_default.umask, NULL,
> +                                0, &umask);
> +            if (ret < 0) {
> +                error_setg(errp,
> +                           "Invalid %s PMU event (umask: %s): %s. "
> +                           "The umask must be a uint8 string.",
> +                           KVMPMUEventEncodeFmt_str(str_event->format),
> +                           str_event->u.x86_default.umask,
> +                           strerror(-ret));
> +                g_free(event);
> +                goto fail;
> +            }
> +            if (umask > UINT8_MAX) {

umask is extended to 16 bits from Perfmon v6+. Please notice we need to
upgrade this to 16 bits in the future. More details can be found here.
[PATCH V3 00/13] Support Lunar Lake and Arrow Lake core PMU - kan.liang
(kernel.org)
<https://lore.kernel.org/all/20240626143545.480761-1-kan.liang@linux.intel.com/>


> +                error_setg(errp,
> +                           "Invalid %s PMU event (umask: %s): "
> +                           "Numerical result out of range. "
> +                           "The umask must be a uint8 string.",
> +                           KVMPMUEventEncodeFmt_str(str_event->format),
> +                           str_event->u.x86_default.umask);
> +                g_free(event);
> +                goto fail;
> +            }
> +            event->u.x86_default.umask = umask;
> +            break;
> +        }
>          default:
>              g_assert_not_reached();
>          }
> diff --git a/include/sysemu/kvm-pmu.h b/include/sysemu/kvm-pmu.h
> index 4707759761f1..707f33d604fd 100644
> --- a/include/sysemu/kvm-pmu.h
> +++ b/include/sysemu/kvm-pmu.h
> @@ -26,4 +26,17 @@ struct KVMPMUFilter {
>      KVMPMUFilterEventList *events;
>  };
>  
> +/*
> + * Stolen from Linux kernel (RAW_EVENT at tools/testing/selftests/kvm/include/
> + * x86_64/pmu.h).
> + *
> + * Encode an eventsel+umask pair into event-select MSR format.  Note, this is
> + * technically AMD's format, as Intel's format only supports 8 bits for the
> + * event selector, i.e. doesn't use bits 24:16 for the selector.  But, OR-ing
> + * in '0' is a nop and won't clobber the CMASK.
> + */
> +#define X86_PMU_RAW_EVENT(eventsel, umask) (((eventsel & 0xf00UL) << 24) | \
> +                                            ((eventsel) & 0xff) | \
> +                                            ((umask) & 0xff) << 8)
> +
>  #endif /* KVM_PMU_H */
> diff --git a/qapi/kvm.json b/qapi/kvm.json
> index 0619da83c123..0d759884c229 100644
> --- a/qapi/kvm.json
> +++ b/qapi/kvm.json
> @@ -27,11 +27,13 @@
>  #
>  # @raw: the encoded event code that KVM can directly consume.
>  #
> +# @x86-default: standard x86 encoding format with select and umask.
> +#
>  # Since 9.1
>  ##
>  { 'enum': 'KVMPMUEventEncodeFmt',
>    'prefix': 'KVM_PMU_EVENT_FMT',
> -  'data': ['raw'] }
> +  'data': ['raw', 'x86-default'] }
>  
>  ##
>  # @KVMPMURawEvent:
> @@ -46,6 +48,25 @@
>  { 'struct': 'KVMPMURawEvent',
>    'data': { 'code': 'uint64' } }
>  
> +##
> +# @KVMPMUX86DefalutEvent:
> +#
> +# x86 PMU event encoding with select and umask.
> +# raw_event = ((select & 0xf00UL) << 24) | \
> +#              (select) & 0xff) | \
> +#              ((umask) & 0xff) << 8)
> +#
> +# @select: x86 PMU event select field, which is a 12-bit unsigned
> +#     number.
> +#
> +# @umask: x86 PMU event umask field.
> +#
> +# Since 9.1
> +##
> +{ 'struct': 'KVMPMUX86DefalutEvent',
> +  'data': { 'select': 'uint16',
> +            'umask': 'uint8' } }
> +
>  ##
>  # @KVMPMUFilterEvent:
>  #
> @@ -61,7 +82,8 @@
>    'base': { 'action': 'KVMPMUFilterAction',
>              'format': 'KVMPMUEventEncodeFmt' },
>    'discriminator': 'format',
> -  'data': { 'raw': 'KVMPMURawEvent' } }
> +  'data': { 'raw': 'KVMPMURawEvent',
> +            'x86-default': 'KVMPMUX86DefalutEvent' } }
>  
>  ##
>  # @KVMPMUFilterProperty:
> @@ -89,6 +111,23 @@
>  { 'struct': 'KVMPMURawEventVariant',
>    'data': { 'code': 'str' } }
>  
> +##
> +# @KVMPMUX86DefalutEventVariant:
> +#
> +# The variant of KVMPMUX86DefalutEvent with the string, rather than
> +# the numeric value.
> +#
> +# @select: x86 PMU event select field.  This field is a 12-bit
> +#     unsigned number string.
> +#
> +# @umask: x86 PMU event umask field. This field is a uint8 string.
> +#
> +# Since 9.1
> +##
> +{ 'struct': 'KVMPMUX86DefalutEventVariant',
> +  'data': { 'select': 'str',
> +            'umask': 'str' } }
> +
>  ##
>  # @KVMPMUFilterEventVariant:
>  #
> @@ -104,7 +143,8 @@
>    'base': { 'action': 'KVMPMUFilterAction',
>              'format': 'KVMPMUEventEncodeFmt' },
>    'discriminator': 'format',
> -  'data': { 'raw': 'KVMPMURawEventVariant' } }
> +  'data': { 'raw': 'KVMPMURawEventVariant',
> +            'x86-default': 'KVMPMUX86DefalutEventVariant' } }
>  
>  ##
>  # @KVMPMUFilterPropertyVariant:
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index e9bf79782316..391531c036a6 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -5393,6 +5393,10 @@ kvm_config_pmu_event(KVMPMUFilter *filter,
>          case KVM_PMU_EVENT_FMT_RAW:
>              code = event->u.raw.code;
>              break;
> +        case KVM_PMU_EVENT_FMT_X86_DEFAULT:
> +            code = X86_PMU_RAW_EVENT(event->u.x86_default.select,
> +                                     event->u.x86_default.umask);
> +            break;
>          default:
>              g_assert_not_reached();
>          }
> @@ -6073,6 +6077,7 @@ static void kvm_arch_check_pmu_filter(const Object *obj, const char *name,
>  
>          switch (event->format) {
>          case KVM_PMU_EVENT_FMT_RAW:
> +        case KVM_PMU_EVENT_FMT_X86_DEFAULT:
>              break;
>          default:
>              error_setg(errp,

