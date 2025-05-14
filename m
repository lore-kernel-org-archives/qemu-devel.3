Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38EFC3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 10:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF9JD-0000mK-1P; Wed, 14 May 2025 06:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uF9JA-0000c9-8J
 for qemu-devel@nongnu.org; Wed, 14 May 2025 06:25:52 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uF9J6-0003l2-Oe
 for qemu-devel@nongnu.org; Wed, 14 May 2025 06:25:51 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so38154695e9.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 03:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747218346; x=1747823146; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZuoMPmbqUzMywie/+K7D5uuGq+/efsiNtYTiGqWYllo=;
 b=PJFSG+e9A1fdZKwJi1m1/pppsF5FoD0TGhvCtdBNP/4KkbHYzL8fYKdwh3RO00aK90
 HzNbGlMLEqZbnno28x6CVJd87mHWUfSGf66xY6axwzUCmrL8SY8vzpvceuyHc9tm3VWB
 SqsJ/mXCldoPARypn1q5ZVDq9bFhoIUfZQ4nRMZYP+ZKtvW9aeudrEOUS5FFixwtJnAd
 QO8oRrYdy21ma1cesXJ2dLUgfJOOKexS5AnC1WNIf4rluqyuf/BfzABHt12MqQCIP4OH
 PV1RcB/o0Nm3y+aAWo3t5FKbAi/te/8BNFgqrTs+W5QybU0koFKXF5oY4UEA2ydr5Dqm
 iUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747218346; x=1747823146;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZuoMPmbqUzMywie/+K7D5uuGq+/efsiNtYTiGqWYllo=;
 b=qZz6UdNTJ7twhrZ7ImrtuuiHJ/4KBMqFLnWVAlIdmUV6LyKdfpNmfu2F9lZct2seEE
 p5ABYLllBxdPiu0Dx3YXcrXsLEFEKoQ6Y0vPoZ+Nyy2bwo9HNKBnEndQlmlxzmx1ngz4
 D8jFbhC5ILTuO+vnr6VMSLh8luHX+D4kTQqx+un+ac0yB/YW8gIbErVkVMmtyoWw/1bF
 9QvIZ+XRpPf6e1SitRrOJEb+oETL6TJ7lQFCVQRWzfdkflKsW6fnTjPq6hHdmWW5Itbl
 JRJF6U8vi2IELNDukMmhexyTTSFs5WBSHWKV00Lyj2Ug6oeqJ2VEMWQh1MAQOlslLMk3
 W/Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIgUkJKGdkMAsFwtdPcQr1p+py3sLEQY5+mObxBqxKPG7eiAQ/+xJ6vS4V85vgl5nnBpbqjqG26Pvl@nongnu.org
X-Gm-Message-State: AOJu0YyoUinBvzmMlVz9RD3jzyM4lC3FdOBCIpYEoGG8al66oyPAwpJf
 8M7TFBEaPD8M4YA3IJ3krPzWQvJZeGXEGscWq/r+fExOz+ZWg7gO4qFtWRqA1WU=
X-Gm-Gg: ASbGncuRA2uoEJBttFkmYSMhr9eNCZfRibjpQdh/bAuIjbkZ3aEvoqkXMOSh12KkjEq
 w65Epg90USi+eymER4vydAedH0nMAJwHtKdoaPhhUzy7CFRAX0yy/QGvAiaoXRePoNSeb4gOgCY
 ISe1573mraW8XrELlWLPIguII+8ES+y1VNhdrN+7aN381rp1BSdJQGbvkZoYffKi1wv0dL3xd00
 DB9cbz5rR0csobIOxmYsTw2U3w2deFZpZAYtSfkEa1XixMuw5/OgfumnyeSE1xmhojQd2efid4z
 R6zmnvy5fYcFC3i1cyzRNVcFfAP4SlrZksjbtSQB2xxJ2mxVDAq8K/2VWcqCFd/ce9sUrJxsOIM
 GqPjtVTC9rwN9
X-Google-Smtp-Source: AGHT+IHfYzmEt7b9TqKHE5rlqOm3zR9BK5FX9BG7NpPuEj1/4sb96WzzvysadnkuBY9somgCjU8E6A==
X-Received: by 2002:a05:600c:358b:b0:43d:42b:e186 with SMTP id
 5b1f17b1804b1-442f20e8141mr23879695e9.8.1747218345897; 
 Wed, 14 May 2025 03:25:45 -0700 (PDT)
Received: from [10.61.1.248] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f6f9b309sm4075985e9.30.2025.05.14.03.25.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 03:25:45 -0700 (PDT)
Message-ID: <1cf86288-8dc0-45b0-a3b8-ba3fce1db8bf@linaro.org>
Date: Wed, 14 May 2025 11:25:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] x86-disas: add x86-mini disassembler implementation
To: Michael Clark <michael@anarch128.org>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20250514073927.2735727-1-michael@anarch128.org>
 <20250514073927.2735727-5-michael@anarch128.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250514073927.2735727-5-michael@anarch128.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Michael,

Minor comments inline.

On 14/5/25 09:39, Michael Clark wrote:
> the x86-mini library is a lightweight x86 encoder, decoder, and
> disassembler that uses extensions to the Intel instruction set
> metadata to encode modern VEX/EVEX instructions and legacy
> instructions with a parameterized LEX (legacy extension) format.
> 
> this patch adds the x86-tablegen.py script, the disassembler,
> a print_insn_x86 implementation plus host and target cpu stubs.
> 
> Signed-off-by: Michael Clark <michael@anarch128.org>
> ---
>   disas/disas-host.c      |    5 +
>   disas/meson.build       |   97 ++
>   disas/x86-core.c        | 2716 +++++++++++++++++++++++++++++++++++++++
>   disas/x86-disas.c       |   96 ++
>   disas/x86.h             | 1860 +++++++++++++++++++++++++++
>   include/disas/dis-asm.h |    1 +
>   target/i386/cpu.c       |    7 +
>   7 files changed, 4782 insertions(+)
>   create mode 100644 disas/x86-core.c
>   create mode 100644 disas/x86-disas.c
>   create mode 100644 disas/x86.h


> diff --git a/disas/x86-core.c b/disas/x86-core.c
> new file mode 100644
> index 000000000000..c4f7034e3420
> --- /dev/null
> +++ b/disas/x86-core.c
> @@ -0,0 +1,2716 @@
> +/*
> + * Copyright (c) 2024-2025 Michael Clark
> + *
> + * SPDX-License-Identifier: MIT
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included
> + * in all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
> + * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdarg.h>
> +#include <string.h>
> +#include <limits.h>

No need for these 5 includes ...
> +
> +#include "qemu/osdep.h"

... as they are provided by "qemu/osdep.h".

> +#include "qemu/host-utils.h"
> +
> +#include "disas/x86.h"
> +#include "disas/x86-tables.inc"


> +x86_opr_formatter x86_format_intel_hex;
> +x86_opr_formatter x86_format_intel_dec;
> +x86_opr_formats x86_opr_formats_intel_hex;
> +x86_opr_formats x86_opr_formats_intel_dec;
> +
> +static uint debug;
> +
> +void x86_set_debug(uint d) { debug = d; }
> +

const

> +x86_map_str x86_mode_names[] =
> +{
> +    { x86_modes_64,             "64"               },
> +    { x86_modes_32,             "32"               },
> +    { x86_modes_16,             "16"               },
> +};
> +

const

> +x86_map_str x86_map_names[] =
> +{
> +    { x86_map_map6,            "map6"              },
> +    { x86_map_map5,            "map5"              },
> +    { x86_map_map4,            "map4"              },
> +    { x86_map_0f3a,            "0f3a"              },
> +    { x86_map_0f38,            "0f38"              },
> +    { x86_map_0f,              "0f"                },
> +};
> +

const

> +x86_map_str x86_ord_names[] =
> +{
> +    { x86_ord_rflags,           "rflags"           },
> +    { x86_ord_mxcsr,            "mxcsr"            },
> +    { x86_ord_xmm0_7,           "xmm0_7"           },
> +    { x86_ord_xmm0,             "xmm0"             },
> +    { x86_ord_seg,              "seg"              },
> +    { x86_ord_stx,              "stx"              },
> +    { x86_ord_st0,              "st0"              },
> +    { x86_ord_rdi,              "rdi"              },
> +    { x86_ord_rsi,              "rsi"              },
> +    { x86_ord_rbp,              "rbp"              },
> +    { x86_ord_rsp,              "rsp"              },
> +    { x86_ord_rbx,              "rbx"              },
> +    { x86_ord_rdx,              "rdx"              },
> +    { x86_ord_rcx,              "rcx"              },
> +    { x86_ord_rax,              "rax"              },
> +    { x86_ord_one,              "one"              },
> +    { x86_ord_ime,              "ime"              },
> +    { x86_ord_is4,              "is4"              },
> +    { x86_ord_sib,              "sib"              },
> +    { x86_ord_vec,              "vec"              },
> +    { x86_ord_opr,              "opr"              },
> +    { x86_ord_mrm,              "mrm"              },
> +    { x86_ord_reg,              "reg"              },
> +    { x86_ord_imm,              "imm"              },
> +    { x86_ord_rwi,              "rwi"              },
> +    { x86_ord_wi,               "wi"               },
> +    { x86_ord_ri,               "ri"               },
> +    { x86_ord_rw,               "rw"               },
> +    { x86_ord_i,                "i"                },
> +    { x86_ord_r,                "r"                },
> +    { x86_ord_w,                "w"                },
> +    { 0,                        NULL               },
> +};
> +

const

> +x86_map_str x86_opr_names[] =
> +{
> +    { x86_opr_bnd_mem,          "bnd/mem"          },
> +    { x86_opr_k_m64,            "k/m64"            },
> +    { x86_opr_k_m32,            "k/m32"            },
> +    { x86_opr_k_m16,            "k/m16"            },
> +    { x86_opr_k_m8,             "k/m8"             },
> +    { x86_opr_vm64z,            "vm64z"            },
> +    { x86_opr_vm64y,            "vm64y"            },
> +    { x86_opr_vm64x,            "vm64x"            },
> +    { x86_opr_vm32z,            "vm32z"            },
> +    { x86_opr_vm32y,            "vm32y"            },
> +    { x86_opr_vm32x,            "vm32x"            },
> +    { x86_opr_rw_mw,            "rw/mw"            },
> +    { x86_opr_r64_m64,          "r64/m64"          },
> +    { x86_opr_r64_m32,          "r64/m32"          },
> +    { x86_opr_r64_m16,          "r64/m16"          },
> +    { x86_opr_r64_m8,           "r64/m8"           },
> +    { x86_opr_r32_m32,          "r32/m32"          },
> +    { x86_opr_r32_m16,          "r32/m16"          },
> +    { x86_opr_r32_m8,           "r32/m8"           },
> +    { x86_opr_r16_m16,          "r16/m16"          },
> +    { x86_opr_r16_m8,           "r16/m8"           },
> +    { x86_opr_r8_m8,            "r8/m8"            },
> +    { x86_opr_zmm_m512_m64bcst, "zmm/m512/m64bcst" },
> +    { x86_opr_zmm_m512_m32bcst, "zmm/m512/m32bcst" },
> +    { x86_opr_zmm_m512_m16bcst, "zmm/m512/m16bcst" },
> +    { x86_opr_ymm_m256_m64bcst, "ymm/m256/m64bcst" },
> +    { x86_opr_ymm_m256_m32bcst, "ymm/m256/m32bcst" },
> +    { x86_opr_ymm_m256_m16bcst, "ymm/m256/m16bcst" },
> +    { x86_opr_xmm_m128_m64bcst, "xmm/m128/m64bcst" },
> +    { x86_opr_xmm_m128_m32bcst, "xmm/m128/m32bcst" },
> +    { x86_opr_xmm_m128_m16bcst, "xmm/m128/m16bcst" },
> +    { x86_opr_xmm_m64_m32bcst,  "xmm/m64/m32bcst"  },
> +    { x86_opr_xmm_m64_m16bcst,  "xmm/m64/m16bcst"  },
> +    { x86_opr_xmm_m32_m16bcst,  "xmm/m32/m16bcst"  },
> +    { x86_opr_zmm_m512,         "zmm/m512"         },
> +    { x86_opr_ymm_m256,         "ymm/m256"         },
> +    { x86_opr_xmm_m128,         "xmm/m128"         },
> +    { x86_opr_xmm_m64,          "xmm/m64"          },
> +    { x86_opr_xmm_m32,          "xmm/m32"          },
> +    { x86_opr_xmm_m16,          "xmm/m16"          },
> +    { x86_opr_xmm_m8,           "xmm/m8"           },
> +    { x86_opr_mm_m64,           "mm/m64"           },
> +    { x86_opr_mm_m32,           "mm/m32"           },
> +    { x86_opr_mp,               "mp"               },
> +    { x86_opr_mw,               "mw"               },
> +    { x86_opr_vm64,             "vm64"             },
> +    { x86_opr_vm32,             "vm32"             },
> +    { x86_opr_r_m64,            "r/m64"            },
> +    { x86_opr_r_m32,            "r/m32"            },
> +    { x86_opr_r_m16,            "r/m16"            },
> +    { x86_opr_r_m8,             "r/m8"             },
> +    { x86_opr_m64bcst,          "m64bcst"          },
> +    { x86_opr_m32bcst,          "m32bcst"          },
> +    { x86_opr_m16bcst,          "m16bcst"          },
> +    { x86_opr_mib,              "mib"              },
> +    { x86_opr_m384,             "m384"             },
> +    { x86_opr_m80,              "m80"              },
> +    { x86_opr_m512,             "m512"             },
> +    { x86_opr_m256,             "m256"             },
> +    { x86_opr_m128,             "m128"             },
> +    { x86_opr_m64,              "m64"              },
> +    { x86_opr_m32,              "m32"              },
> +    { x86_opr_m16,              "m16"              },
> +    { x86_opr_m8,               "m8"               },
> +    { x86_opr_seg_gs,           "gs"               },
> +    { x86_opr_seg_fs,           "fs"               },
> +    { x86_opr_seg_ds,           "ds"               },
> +    { x86_opr_seg_ss,           "ss"               },
> +    { x86_opr_seg_cs,           "cs"               },
> +    { x86_opr_seg_es,           "es"               },
> +    { x86_opr_reg_xmm0_7,       "xmm0_7"           },
> +    { x86_opr_reg_xmm0,         "xmm0"             },
> +    { x86_opr_reg_pdi,          "pdi"              },
> +    { x86_opr_reg_psi,          "psi"              },
> +    { x86_opr_reg_pb,           "pb"               },
> +    { x86_opr_reg_pd,           "pd"               },
> +    { x86_opr_reg_pc,           "pc"               },
> +    { x86_opr_reg_pa,           "pa"               },
> +    { x86_opr_reg_bw,           "bw"               },
> +    { x86_opr_reg_dw,           "dw"               },
> +    { x86_opr_reg_cw,           "cw"               },
> +    { x86_opr_reg_aw,           "aw"               },
> +    { x86_opr_reg_rbx,          "rbx"              },
> +    { x86_opr_reg_rdx,          "rdx"              },
> +    { x86_opr_reg_rcx,          "rcx"              },
> +    { x86_opr_reg_rax,          "rax"              },
> +    { x86_opr_reg_ebx,          "ebx"              },
> +    { x86_opr_reg_edx,          "edx"              },
> +    { x86_opr_reg_ecx,          "ecx"              },
> +    { x86_opr_reg_eax,          "eax"              },
> +    { x86_opr_reg_bx,           "bx"               },
> +    { x86_opr_reg_dx,           "dx"               },
> +    { x86_opr_reg_cx,           "cx"               },
> +    { x86_opr_reg_ax,           "ax"               },
> +    { x86_opr_reg_cl,           "cl"               },
> +    { x86_opr_reg_al,           "al"               },
> +    { x86_opr_reg_st0,          "st0"              },
> +    { x86_opr_reg_v0,           "v0"               },
> +    { x86_opr_reg_ah,           "ah"               },
> +    { x86_opr_reg_di,           "di"               },
> +    { x86_opr_reg_si,           "si"               },
> +    { x86_opr_reg_d,            "d"                },
> +    { x86_opr_reg_c,            "c"                },
> +    { x86_opr_reg_a,            "a"                },
> +    { x86_opr_memfar16_64,      "memfar16:64"      },
> +    { x86_opr_memfar16_32,      "memfar16:32"      },
> +    { x86_opr_memfar16_16,      "memfar16:16"      },
> +    { x86_opr_far16_32,         "far16:32"         },
> +    { x86_opr_far16_16,         "far16:16"         },
> +    { x86_opr_relw,             "relw"             },
> +    { x86_opr_rel8,             "rel8"             },
> +    { x86_opr_moffs,            "moffs"            },
> +    { x86_opr_1,                "1"                },
> +    { x86_opr_zmm,              "zmm"              },
> +    { x86_opr_ymm,              "ymm"              },
> +    { x86_opr_xmm,              "xmm"              },
> +    { x86_opr_mm,               "mm"               },
> +    { x86_opr_ra,               "ra"               },
> +    { x86_opr_rw,               "rw"               },
> +    { x86_opr_r64,              "r64"              },
> +    { x86_opr_r32,              "r32"              },
> +    { x86_opr_r16,              "r16"              },
> +    { x86_opr_r8,               "r8"               },
> +    { x86_opr_iw,               "iw"               },
> +    { x86_opr_iwd,              "iwd"              },
> +    { x86_opr_i64,              "i64"              },
> +    { x86_opr_i32,              "i32"              },
> +    { x86_opr_i16,              "i16"              },
> +    { x86_opr_ib,               "ib"               },
> +    { x86_opr_bnd,              "bnd"              },
> +    { x86_opr_dreg,             "dreg"             },
> +    { x86_opr_creg,             "creg"             },
> +    { x86_opr_seg,              "seg"              },
> +    { x86_opr_k,                "k"                },
> +    { x86_opr_st,               "st"               },
> +    { x86_opr_mmx,              "mmx"              },
> +    { x86_opr_vec,              "vec"              },
> +    { x86_opr_reg,              "reg"              },
> +    { x86_opr_imm,              "imm"              },
> +    { x86_opr_bcst,             "bcst"             },
> +    { x86_opr_mem,              "mem"              },
> +    { x86_opr_flag_er,          "{er}"             },
> +    { x86_opr_flag_k,           "{k}"              },
> +    { x86_opr_flag_sae,         "{sae}"            },
> +    { x86_opr_flag_z,           "{z}"              },
> +    { x86_opr_flag_rs2,         "{rs2}"            },
> +    { x86_opr_flag_rs4,         "{rs4}"            },
> +    { x86_opr_f64x8,            "/f64x8"           },
> +    { x86_opr_f64x4,            "/f64x4"           },
> +    { x86_opr_f64x2,            "/f64x2"           },
> +    { x86_opr_f64x1,            "/f64x1"           },
> +    { x86_opr_f32x16,           "/f32x16"          },
> +    { x86_opr_f32x8,            "/f32x8"           },
> +    { x86_opr_f32x4,            "/f32x4"           },
> +    { x86_opr_f32x2,            "/f32x2"           },
> +    { x86_opr_f32x1,            "/f32x1"           },
> +    { x86_opr_f16x32,           "/f16x32"          },
> +    { x86_opr_f16x16,           "/f16x16"          },
> +    { x86_opr_f16x8,            "/f16x8"           },
> +    { x86_opr_f16x4,            "/f16x4"           },
> +    { x86_opr_f16x2,            "/f16x2"           },
> +    { x86_opr_f16x1,            "/f16x1"           },
> +    { x86_opr_f8x64,            "/f8x64"           },
> +    { x86_opr_f8x32,            "/f8x32"           },
> +    { x86_opr_f8x16,            "/f8x16"           },
> +    { x86_opr_f8x8,             "/f8x8"            },
> +    { x86_opr_f8x4,             "/f8x4"            },
> +    { x86_opr_f8x2,             "/f8x2"            },
> +    { x86_opr_f8x1,             "/f8x1"            },
> +    { x86_opr_i512x1,           "/i512x1"          },
> +    { x86_opr_i256x2,           "/i256x2"          },
> +    { x86_opr_i256x1,           "/i256x1"          },
> +    { x86_opr_i128x4,           "/i128x4"          },
> +    { x86_opr_i128x2,           "/i128x2"          },
> +    { x86_opr_i128x1,           "/i128x1"          },
> +    { x86_opr_i64x8,            "/i64x8"           },
> +    { x86_opr_i64x4,            "/i64x4"           },
> +    { x86_opr_i64x2,            "/i64x2"           },
> +    { x86_opr_i64x1,            "/i64x1"           },
> +    { x86_opr_i32x16,           "/i32x16"          },
> +    { x86_opr_i32x8,            "/i32x8"           },
> +    { x86_opr_i32x4,            "/i32x4"           },
> +    { x86_opr_i32x2,            "/i32x2"           },
> +    { x86_opr_i32x1,            "/i32x1"           },
> +    { x86_opr_i16x32,           "/i16x32"          },
> +    { x86_opr_i16x16,           "/i16x16"          },
> +    { x86_opr_i16x8,            "/i16x8"           },
> +    { x86_opr_i16x4,            "/i16x4"           },
> +    { x86_opr_i16x2,            "/i16x2"           },
> +    { x86_opr_i16x1,            "/i16x1"           },
> +    { x86_opr_i8x64,            "/i8x64"           },
> +    { x86_opr_i8x32,            "/i8x32"           },
> +    { x86_opr_i8x16,            "/i8x16"           },
> +    { x86_opr_i8x8,             "/i8x8"            },
> +    { x86_opr_i8x4,             "/i8x4"            },
> +    { x86_opr_i8x2,             "/i8x2"            },
> +    { x86_opr_i8x1,             "/i8x1"            },
> +    { 0,                        NULL               },
> +};
> +

const

> +x86_map_str x86_enc_names[] =
> +{
> +    { x86_enc_r_norexb,         " .norexb"         },
> +    { x86_enc_r_lock,           " .lock"           },
> +    { x86_enc_r_rep,            " .rep"            },
> +    { x86_enc_s_a64,            " .a64"            },
> +    { x86_enc_s_a32,            " .a32"            },
> +    { x86_enc_s_a16,            " .a16"            },
> +    { x86_enc_s_o64,            " .o64"            },
> +    { x86_enc_s_o32,            " .o32"            },
> +    { x86_enc_s_o16,            " .o16"            },
> +    { x86_enc_j_i16,            " i16"             },
> +    { x86_enc_j_ib,             " ib"              },
> +    { x86_enc_i_i64,            " i64"             },
> +    { x86_enc_i_i32,            " i32"             },
> +    { x86_enc_i_i16,            " i16"             },
> +    { x86_enc_i_iwd,            " iwd"             },
> +    { x86_enc_i_iw,             " iw"              },
> +    { x86_enc_i_ib,             " ib"              },
> +    { x86_enc_f_opcode_r,       ""                 },
> +    { x86_enc_f_opcode,         ""                 },
> +    { x86_enc_f_modrm_n,        ""                 },
> +    { x86_enc_f_modrm_r,        ""                 },
> +    { x86_enc_o_opcode_r,       ""                 },
> +    { x86_enc_t_evex,           ".evex"            },
> +    { x86_enc_t_vex,            ".vex"             },
> +    { x86_enc_t_lex,            ".lex"             },
> +    { x86_enc_l_lig,            ".lig"             },
> +    { x86_enc_l_512,            ".512"             },
> +    { x86_enc_l_256,            ".256"             },
> +    { x86_enc_l_128,            ".128"             },
> +    { x86_enc_l_l1,             ".l1"              },
> +    { x86_enc_l_l0,             ".l0"              },
> +    { x86_enc_l_lz,             ".lz"              },
> +    { x86_enc_p_rexw,           ".w"               },
> +    { x86_enc_p_9b,             ".9b"              },
> +    { x86_enc_p_f2,             ".f2"              },
> +    { x86_enc_p_f3,             ".f3"              },
> +    { x86_enc_p_66,             ".66"              },
> +    { x86_enc_m_map6,           ".map6"            },
> +    { x86_enc_m_map5,           ".map5"            },
> +    { x86_enc_m_map4,           ".map4"            },
> +    { x86_enc_m_0f3a,           ".0f3a"            },
> +    { x86_enc_m_0f38,           ".0f38"            },
> +    { x86_enc_m_0f,             ".0f"              },
> +    { x86_enc_w_wig,            ".wig"             },
> +    { x86_enc_w_ww,             ".ww"              },
> +    { x86_enc_w_wx,             ".wx"              },
> +    { x86_enc_w_wn,             ".wn"              },
> +    { x86_enc_w_wb,             ".wb"              },
> +    { x86_enc_w_w1,             ".w1"              },
> +    { x86_enc_w_w0,             ".w0"              },
> +    { 0,                        NULL               },
> +};

> +
> +static void x86_print_row(size_t count, x86_table_col *cols)
> +{
> +    printf("|");
> +    for (size_t i = 0; i < count; i++) {
> +        printf(" %-*s |", cols[i].width, cols[i].data);
> +        g_free(cols[i].data);
> +    }
> +    printf("\n");

Shouldn't we use info->fprintf_func() in disas/ ?

> +}

const

> +x86_opr_formats x86_opr_formats_intel_hex =
> +{
> +    .ptr_rip            = "%s[rip]",
> +    .ptr_rip_disp       = "%s[rip %s 0x%x]",
> +    .ptr_reg            = "%s[%s]",
> +    .ptr_reg_disp       = "%s[%s %s 0x%x]",
> +    .ptr_reg_sreg       = "%s[%s + %d*%s]",
> +    .ptr_reg_sreg_disp  = "%s[%s + %d*%s %s 0x%x]",
> +    .ptr_reg_reg        = "%s[%s + %s]",
> +    .ptr_reg_reg_disp   = "%s[%s + %s %s 0x%x]",
> +    .ptr_sreg           = "%s[%d*%s]",
> +    .ptr_disp           = "%s[%s0x%x]",
> +    .ptr_imm64          = "%s[%s0x%llx]",
> +    .ptr_imm32          = "%s[%s0x%x]",
> +    .imm64              = "%s0x%llx",
> +    .imm32              = "%s0x%x",
> +    .reg                = "%s",
> +};
> +

const

> +x86_opr_formats x86_opr_formats_intel_dec =
> +{
> +    .ptr_rip            = "%s[rip]",
> +    .ptr_rip_disp       = "%s[rip %s %u]",
> +    .ptr_reg            = "%s[%s]",
> +    .ptr_reg_disp       = "%s[%s %s %u]",
> +    .ptr_reg_sreg       = "%s[%s + %d*%s]",
> +    .ptr_reg_sreg_disp  = "%s[%s + %d*%s %s %u]",
> +    .ptr_reg_reg        = "%s[%s + %s]",
> +    .ptr_reg_reg_disp   = "%s[%s + %s %s %u]",
> +    .ptr_sreg           = "%s[%d*%s]",
> +    .ptr_disp           = "%s[%s%u]",
> +    .ptr_imm64          = "%s[%s%llu]",
> +    .ptr_imm32          = "%s[%s%u]",
> +    .imm64              = "%s%llu",
> +    .imm32              = "%s%u",
> +    .reg                = "%s",
> +};
> +

const

> +x86_opr_formatter x86_format_intel_hex =
> +{
> +    .fmt_const = &x86_opr_intel_const_str,
> +    .fmt_imm = &x86_opr_intel_imm_hex_str,
> +    .fmt_reg = &x86_opr_intel_reg_str,
> +    .fmt_mrm = &x86_opr_intel_mrm_hex_str,
> +    .fmt_vec = &x86_opr_intel_vec_str,
> +    .fmt_opb = &x86_opr_intel_opb_str,
> +    .fmt_is4 = &x86_opr_intel_is4_str,
> +    .fmt_ime = &x86_opr_intel_ime_hex_str,
> +    .fmt_rel = &x86_opr_intel_rel_hex_str
> +};
> +

const

> +x86_opr_formatter x86_format_intel_dec =
> +{
> +    .fmt_const = &x86_opr_intel_const_str,
> +    .fmt_imm = &x86_opr_intel_imm_dec_str,
> +    .fmt_reg = &x86_opr_intel_reg_str,
> +    .fmt_mrm = &x86_opr_intel_mrm_dec_str,
> +    .fmt_vec = &x86_opr_intel_vec_str,
> +    .fmt_opb = &x86_opr_intel_opb_str,
> +    .fmt_is4 = &x86_opr_intel_is4_str,
> +    .fmt_ime = &x86_opr_intel_ime_dec_str,
> +    .fmt_rel = &x86_opr_intel_rel_dec_str
> +};


