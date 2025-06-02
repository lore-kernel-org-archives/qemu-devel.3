Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385B9C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 08:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM0Fn-0008UH-Hd; Mon, 02 Jun 2025 04:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uM0Fm-0008Ty-6y
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:10:42 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uM0Fk-0008VM-4I
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:10:41 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-450ce671a08so25208725e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 01:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748851838; x=1749456638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y4/eaGDe+11IzLfHcZsnz+XBC189nhHHrAgY5I/uXo8=;
 b=O9LcK6fKadpRXAAx5qZndpdJL+5H7AF1QUJo1ZTBD/We1WZXVYQQOSyPcdSLUYIqFs
 zZJnhKusnh4uP5ChYEqPECBwhp5uJSOIjIqFNrNih4lFXYM4lHGTgqi/4vq/jU29sLtr
 DO6olAw84C3CLgCpQAJhrkoiCMjSB2FaAns2L6oqdct5a8PhlQfzXcItWXE59eG0qqVk
 V46g5FCpFQvTtKYOJpW6yv+LhvViD/OL9e2rbeJZ9BQkwnCYS14I6cn6aSS+8RLsQvCS
 R2X0F0mcZfuHPCSXSjrNq9Lko0OF74EuiqFE/PLX0dNPGdQsPkoTDe49vNo1LAxzD48K
 DhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748851838; x=1749456638;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y4/eaGDe+11IzLfHcZsnz+XBC189nhHHrAgY5I/uXo8=;
 b=FkE6/AC54u4rsrnT/mDlcJgCNQglyulrHMd5S7YbiaHSKKYi/u4PhGNnTDqFssOoOr
 yFZLMczOyTVtH9xGL8yYQi/CqUfZ7oyyXf+/lK+ozlPLNTyE6o+6+nekrU7CVoFOSlw7
 PtbQ7oWeirMKSR/7QpdmwC7C2fax8ggBhOZLsnwvNtLRtUXZFjgHo4fKYmL8yhnT63n/
 tM/EYqnAi/L/mt+ln2XJCY3Fjlvg8DDZ2q7vlu/1HzBzq+L1DejoFrUZ5YswrQ70tdTj
 /9hzfYFw/2JaBuDOTYcVLDxqfoO08G1An0s8ivyfqI7OsTb5gf8gLMefbs1JCBH9UXpf
 hnUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrfYeTOeqzdLi8ABdlMl/zoYggm2dNZWw36TZ054QTTSNlLby8a58EPpJi+JAad5RXyHqe2KD0JtVG@nongnu.org
X-Gm-Message-State: AOJu0YyN86MtBeEaSrxdSbksgsGaurlVoPSwweSzS8UzTtzbSRuyu60c
 2L83/QD9dd7OgxF28BazyGpmEnD3LOw9MCpKSESxavSf/m08KUattZx9GTLy8gpA8uIUfWKh9lF
 zbLEn9MA=
X-Gm-Gg: ASbGncsjaRUxk/LWbDBJKw0uPLmy9gEkOhAOnZViKSwMU8LpfwQtZTMdHHwUkGqxDG7
 +3vhaEEp6e2wNwV3OiyH943RGCv3cXH14vBY/sZqvI2xFPivO+OmCPPXgkNq4dRBr42+TC2HffV
 ekZRfygEyvsVDEm0LPG3Dyd32xBVX/2tPWY7XORT30YOoEm9yUpTS4pdFI1Ij1mbNlORyXqj2Uc
 uyO0t+c+NN8ybNzLgUYBltPS0XAUaU6lkdPMJNOZ+TAKgwrkyA6Mo4U97xCir1PjLUoVxKdhXX3
 9WhuIwRlqRYDeVUypZMOBbhLMLD9/+ylizIdCYgSBIVf7f31XAXyvlrAcVRlZ35klFTEEidQy4U
 8/fvkivlSmrfMjt3LK5k=
X-Google-Smtp-Source: AGHT+IH7/PJNQx7xiCiYtKTfQa/neQfBrUwZvIUUiNrwNogHS/1dnQoI+3YjLS1rjcD37fU+UHGB6g==
X-Received: by 2002:a5d:5c84:0:b0:3a3:7ba5:960e with SMTP id
 ffacd0b85a97d-3a4fe3a8214mr5515346f8f.59.1748851838030; 
 Mon, 02 Jun 2025 01:10:38 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fc28f3sm112875365e9.39.2025.06.02.01.10.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 01:10:37 -0700 (PDT)
Message-ID: <4d8013d1-3787-4d8a-8b8d-3eee7d389d6e@linaro.org>
Date: Mon, 2 Jun 2025 10:10:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rocker: do not pollute the namespace
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250530070743.2050531-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250530070743.2050531-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 30/5/25 09:07, Paolo Bonzini wrote:
> Do not leave the __le* macros defined, in fact do not use them at all.  Fixes a
> build failure on Alpine with the TDX patches:
> 
> In file included from ../hw/net/rocker/rocker_of_dpa.c:25:
> ../hw/net/rocker/rocker_hw.h:14:16: error: conflicting types for 'uint64_t'; have '__u64' {aka 'long long unsigned int'}
>     14 | #define __le64 uint64_t
>        |                ^~~~~~~~
> In file included from /usr/include/stdint.h:20,
>                   from ../include/qemu/osdep.h:111,
>                   from ../hw/net/rocker/rocker_of_dpa.c:17:
> /usr/include/bits/alltypes.h:136:25: note: previous declaration of 'uint64_t' with type 'uint64_t' {aka 'long unsigned int'}
>    136 | typedef unsigned _Int64 uint64_t;
>        |                         ^~~~~~~~
> 
> because the Linux headers include a typedef of __leNN.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/net/rocker/rocker.h        | 14 +++---------
>   hw/net/rocker/rocker_hw.h     | 20 +++++++-----------
>   hw/net/rocker/rocker_of_dpa.c | 40 +++++++++++++++++------------------
>   3 files changed, 31 insertions(+), 43 deletions(-)


> diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
> index 3378f63110b..4aed1787566 100644
> --- a/hw/net/rocker/rocker_of_dpa.c
> +++ b/hw/net/rocker/rocker_of_dpa.c
> @@ -52,10 +52,10 @@ typedef struct of_dpa_flow_key {
>       uint32_t tunnel_id;              /* overlay tunnel id */
>       uint32_t tbl_id;                 /* table id */
>       struct {
> -        __be16 vlan_id;              /* 0 if no VLAN */
> +        uint16_t vlan_id;              /* 0 if no VLAN */
>           MACAddr src;                 /* ethernet source address */
>           MACAddr dst;                 /* ethernet destination address */
> -        __be16 type;                 /* ethernet frame type */
> +        uint16_t type;                 /* ethernet frame type */

Some comments are now mis-aligned, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       } eth;
>       struct {
>           uint8_t proto;               /* IP protocol or ARP opcode */
> @@ -66,14 +66,14 @@ typedef struct of_dpa_flow_key {
>       union {
>           struct {
>               struct {
> -                __be32 src;          /* IP source address */
> -                __be32 dst;          /* IP destination address */
> +                uint32_t src;          /* IP source address */
> +                uint32_t dst;          /* IP destination address */
>               } addr;
>               union {
>                   struct {
> -                    __be16 src;      /* TCP/UDP/SCTP source port */
> -                    __be16 dst;      /* TCP/UDP/SCTP destination port */
> -                    __be16 flags;    /* TCP flags */
> +                    uint16_t src;      /* TCP/UDP/SCTP source port */
> +                    uint16_t dst;      /* TCP/UDP/SCTP destination port */
> +                    uint16_t flags;    /* TCP flags */
>                   } tp;
>                   struct {
>                       MACAddr sha;     /* ARP source hardware address */
> @@ -86,11 +86,11 @@ typedef struct of_dpa_flow_key {
>                   Ipv6Addr src;       /* IPv6 source address */
>                   Ipv6Addr dst;       /* IPv6 destination address */
>               } addr;
> -            __be32 label;            /* IPv6 flow label */
> +            uint32_t label;            /* IPv6 flow label */
>               struct {
> -                __be16 src;          /* TCP/UDP/SCTP source port */
> -                __be16 dst;          /* TCP/UDP/SCTP destination port */
> -                __be16 flags;        /* TCP flags */
> +                uint16_t src;          /* TCP/UDP/SCTP source port */
> +                uint16_t dst;          /* TCP/UDP/SCTP destination port */
> +                uint16_t flags;        /* TCP flags */
>               } tp;
>               struct {
>                   Ipv6Addr target;    /* ND target address */

