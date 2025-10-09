Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46893CCA471
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 06:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6k3x-0000m1-6n; Thu, 09 Oct 2025 02:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6k3u-0000ld-Gu
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 02:23:38 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6k3p-0002Hl-EM
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 02:23:37 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3ee12332f3dso592205f8f.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 23:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759991007; x=1760595807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cqWS9D7teLJXX6CCWO4SRnLrSEU5CiQnuy+/+vCuU6U=;
 b=AK+jLNK38R/8nEs0668Bzej7P4fBngxS4yKo+CCQ4aubfWfxpsV3/DQmUCJyJ3iOH1
 s2skeRTc4hWBMCCNflguZzRYPm9VjYcuC/hfCZ+yDwSMhd6oEi0UAPNJJfpR0OMtioM1
 S7+nGtspRx/87ZUE+D8AKUpjIwSPVWBDPceYB/2y4jMfYG8ddUbYJughkGep7dbAeckf
 4Wzy/c+ZI7SMkzsf5t6KHld5lpRCr2Gl5/CTEIqSvFk+AE/WBQGvcdeV3xdhirhAd/Nc
 zShZwLNKLB5TT+KGQwXPy5xPysKvY2utNlVJmkoFAt8R91wPZXge47/dtVw2YrhL5qDh
 qZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759991007; x=1760595807;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cqWS9D7teLJXX6CCWO4SRnLrSEU5CiQnuy+/+vCuU6U=;
 b=UeeTXQgwl+kRKWMJyYbjPmAebCUF0OJO8s0BHnCOFWeGIMFoGR/geGCCMrFMjwzumX
 o24ylXMwAukQk+VuWvOs8QoShQPLYrPPAk3j1V166upOnBmlj3xHuvYFFRNUbBD6ae/6
 UE/t6qVZsUaFWLkgWbKsA0sqkSx0mj1ALHsgqD7r+ovtwC2phtp7CAQlCOurFpbDzkY1
 SirQLOZkGZ/ValeijKWsB+8IQx+UwU8AlMdUYNw0mDbbIIGWwFbQ3WbZ5lbcdYumAbwz
 ysJ3i4rg54YB3IkMNkaFPORCQ2ftn4frWeXjLToUaLECIpHBb7j9K7rVc7J3Tc0B7VHF
 8LGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX95iWT79ehF8CI9uD+SfhnLq8prUxTD6pGHtGlb5ZNpBn+wE29GH2DbslqaUbH9zUzY6fwnPPjivbt@nongnu.org
X-Gm-Message-State: AOJu0YxgARKgKVvNJ/3MAkMBM9F+AWiS0mhqli8/NotuXI36bwNSjiMy
 Pz4MCPGtmZneLMHa58s0pH33EVPcq+ROhOByAR++niKbX5bsgwJjXcc80C0j/d99vc8=
X-Gm-Gg: ASbGncvIg4WLtgttid7yR791dgP55EnNRN6QHVfaheo1GjUzHuWP/SaemuZdf6+wQEy
 pUjpxxuo1gxW08BublNUMS7wOh0PkeF4YBAYOtz2fBH+NASh7nnrOFXWTLw0FbTdhvWHKwUhONp
 i1Ga7CFs382K5p20kV5Xf4XBkWHh6T3pUFe+ZoN3kNTqKTLLgbesB88EhU8OrS9rMQ3kTnxhREE
 c/5XAFzBQbHEweg+bg91WyWf78wa16DSHinBRa8BT/u5PUAKhIbET3GauivbGvynvDCDg9da3Gv
 HLRsZO6R6RplpjkioPPL+RPnmIfqjfv9fBg0YKrKIz80nc+lBFp98BTisDEQOc3IioVZZoOyyRU
 5x4PMhKt4IK5mcUQp62ixKDVXB4CwvPsRw9K8oHyd7B9iT3LEd5PkeqqJ7TJd/ZVEJPoPYEkl6k
 vmaTGbwtH8C6EDazTESA==
X-Google-Smtp-Source: AGHT+IGYgrLcMRqKk/wclHVPu/sV82RngoHwLgMw8ll+o3OLBokuCiIZft544r0FDKW/usNIff/WKw==
X-Received: by 2002:a05:6000:1861:b0:3fa:944b:9bc3 with SMTP id
 ffacd0b85a97d-4267b3396f9mr3729752f8f.62.1759991007561; 
 Wed, 08 Oct 2025 23:23:27 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e97f0sm32753631f8f.27.2025.10.08.23.23.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 23:23:26 -0700 (PDT)
Message-ID: <64f40ff8-3694-4c9a-80b6-0f58f01d7995@linaro.org>
Date: Thu, 9 Oct 2025 08:23:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Register API leaks fixes
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>
References: <20251002073418.109375-1-luc.michel@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251002073418.109375-1-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Luc,

On 2/10/25 09:34, Luc Michel wrote:

> This series addresses the memory leaks caused by the register API. The
> first patches fix the API itself while the last ones take care of the
> CANFD model.


> Luc Michel (7):
>    hw/core/register: remove the REGISTER device type
>    hw/core/register: add the REGISTER_ARRAY type
>    hw/core/register: remove the calls to `register_finalize_block'
>    hw/core/register: remove the `register_finalize_block' function
>    hw/net/can/xlnx-versal-canfd: remove unused include directives
>    hw/net/can/xlnx-versal-canfd: refactor the banked registers logic
>    hw/net/can/xlnx-versal-canfd: remove register API usage for banked
>      regs

I had few issues with your series:

../../hw/net/can/xlnx-versal-canfd.c:1917:30: error: unused variable 
'canfd_regs_ops' [-Werror,-Wunused-const-variable]
  1917 | static const MemoryRegionOps canfd_regs_ops = {
       |                              ^~~~~~~~~~~~~~

../../hw/net/can/xlnx-versal-canfd.c:1871:42: error: use of undeclared 
identifier 'TYPE_REGISTER'
  1871 |         object_initialize(r, sizeof(*r), TYPE_REGISTER);
       |                                          ^

../../hw/net/can/xlnx-versal-canfd.c:1700:48: error: incompatible 
pointer types passing 'hwaddr *' (aka 'unsigned long long *') to 
parameter of type 'size_t *' (aka 'unsigned long *') 
[-Werror,-Wincompatible-pointer-types]
  1700 |     if (!canfd_decode_addr(s, addr, &bank_idx, &reg_offset)) {
       |                                                ^~~~~~~~~~~
../../hw/net/can/xlnx-versal-canfd.c:1651:52: note: passing argument to 
parameter 'offset' here
  1651 |                               size_t *idx, size_t *offset)
       |                                                    ^
../../hw/net/can/xlnx-versal-canfd.c:1722:48: error: incompatible 
pointer types passing 'hwaddr *' (aka 'unsigned long long *') to 
parameter of type 'size_t *' (aka 'unsigned long *') 
[-Werror,-Wincompatible-pointer-types]
  1722 |     if (!canfd_decode_addr(s, addr, &bank_idx, &reg_offset)) {
       |                                                ^~~~~~~~~~~
../../hw/net/can/xlnx-versal-canfd.c:1651:52: note: passing argument to 
parameter 'offset' here
  1651 |                               size_t *idx, size_t *offset)
       |                                                    ^

I fixed them by re-ordering the xlnx-versal-canfd patches first,
having canfd_decode_FOO() taking a 'hwaddr *offset' and using a
temporary __attribute__ ((unused)) for canfd_regs_ops[].

I'm queuing this series as fixed, except if you disagree.

Regards,

Phil.

