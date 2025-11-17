Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E3CCEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 21:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL6xK-0003xh-SE; Mon, 17 Nov 2025 16:40:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL6x4-0003tJ-Gn
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 16:40:02 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL6x0-0001mn-VQ
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 16:39:56 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so19447305e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 13:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763415593; x=1764020393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5CEXDXcd3L9UlPGWQ/YhOKUiusvEqYf0lUso7AKuK/E=;
 b=MaX9hIpuHkNyRXbPbGoTI40Zg+W66fvtXBfa1X5Y7UE232Gm0qpER8HBgt0zop3hCE
 vwE0R07Q/YYJTX6mHx4NauHFoiv13Q1HeBC/vBXTIf9Be2HQRR09rCXQZx3O8lZJqOrH
 O1uZ9Hz0V3+FzQOsjh8GSF6oQcczLY3aQPXjRG4EQHUHJHmfb9b+vP90aD96ukO/Ag7L
 l7L2KBqVtfhzo9WjRVhMDDr8IvEQCFGiWuzG/lzIMQiSIQIRL2K8OH8PMG7wBZiD3v7L
 iJB60GkDK54vejb2kyE0PR/e5VwqYO8oJI+x99gKdqkvGn3JWDxLtdbGuFALeX9xfJoy
 MbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763415593; x=1764020393;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5CEXDXcd3L9UlPGWQ/YhOKUiusvEqYf0lUso7AKuK/E=;
 b=UZYD8n/YAm3eGb9vL41/4u3lSn+Bi7OMaPTiPU5sPT3qE2r/Am6+abjk/KgUSp5DkG
 S9zvINN7vn5ZtUNHwef7Az3/ZBYIood4n1ZVaYgfNtLXtoxjNme37//Lw452pNkJrJYj
 S6ZH+1I7odowjIVi9lyE++Bqrod4zpiyUMx6lQG2gzr218s6Vjo6D9lpSh8O7M8mMjkg
 Gpq3kML7h3dWqL+AxMTX0vF8H9ue6uLCS+wbABmBFdPyYImNk4S/5273YdoJvvEAV+VE
 mSRQiB66YE7KBr49btmmW6NqntZJGc/UJmUC/JWDNgVz1fY5JEubOEXGRr2yvpczHuQF
 xhkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjjYs0vWgCi/hiLy+TWo54bUO9pQu0azDy5Jk3rYaD8Aa3q4eWZyMx5L4mmcRko3+j9GvHTfr128u1@nongnu.org
X-Gm-Message-State: AOJu0Yz5tD1O1qbytJo5taanQ/Yq8x4jn7TM9TWjnL9Bw2znPJgLZBWB
 KSW8PC223cn9HEEbnH/LaYbxW2mgtoI2czIedi3cmuvcug7fud7n47CyqhWPbPf2RWM=
X-Gm-Gg: ASbGnctFCUqLN4VsBqoGerZ7phkVNO9G58DHeSkQQT3IAmqHK1e2FgPPCh9DraJ9TJi
 0Gf+L3px2YhZS12ooGodgfrDlaYXiGJXPVy4QU7K6+ACjYzy0mNv+f5u8lNN8UQbQZniyk9vn1y
 /0COhylLrUxLVQ55jhhGRbZEodT+nBtqGNcZdPV9qkYlPkQ6IYIxq0AnCh6sPDIBiJh2be26epK
 QiLcBznq9TYzvl3G7C24ZrP6i590aXt+h1Vtoyg85enXyYvOdBMnN8rQYuh9F9zePl71zeRVks5
 M/ZRkwixc7DhUk61mwLavvzkFvZW9ST15Ponnddh5iXGIe7BHEDTNbf+noiUYD36r9vHc4gH5L4
 r6V+t5RaMxFi05viipUNf6c5pKzdcRffQFKTvWTAFhWC/XHPVWZV6MMtpdgwHWI3aBusbcAV5Ed
 d7
X-Google-Smtp-Source: AGHT+IEa0t8s/lbFZnAUeGtqqRVJeNVqOOfD9k8HtdSs+9RrjO9NA4gD4M79igPqpxoQt3FY/7g9LQ==
X-Received: by 2002:a5d:64e3:0:b0:429:f0a4:22e with SMTP id
 ffacd0b85a97d-42b5939e084mr14779609f8f.54.1763415593081; 
 Mon, 17 Nov 2025 13:39:53 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42c9628ebacsm15081358f8f.30.2025.11.17.13.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 13:39:52 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 69B9F5F76E;
 Mon, 17 Nov 2025 21:39:51 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Laurent Vivier
 <lvivier@redhat.com>,  Eric Auger <eric.auger@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,  "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
Subject: Re: [RFC v3 1/3] hw/misc: introduce iommu-testdev for bare-metal
 IOMMU testing
In-Reply-To: <7f38ee63-eb24-460c-b8b3-51f3402c4d69@phytium.com.cn> (Tao Tang's
 message of "Mon, 17 Nov 2025 21:56:28 +0800")
References: <20251112162152.447327-1-tangtao1634@phytium.com.cn>
 <20251112162152.447327-2-tangtao1634@phytium.com.cn>
 <b087405f179f2d2b8c4224c87c2c562455b9ab6d.camel@eviden.com>
 <7f38ee63-eb24-460c-b8b3-51f3402c4d69@phytium.com.cn>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Mon, 17 Nov 2025 21:39:51 +0000
Message-ID: <875xb8l4ns.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Tao Tang <tangtao1634@phytium.com.cn> writes:

> Hi=C2=A0Clement,
>
> On 2025/11/13 15:02, CLEMENT MATHIEU--DRIF wrote:
>> Hi Tao,
>>
>> On Thu, 2025-11-13 at 00:21 +0800, Tao Tang wrote:
>>> Add a minimal PCI test device designed to exercise IOMMU translation
>>> (such as ARM SMMUv3) without requiring guest firmware or OS. The device
>>> provides MMIO registers to configure and trigger DMA operations with
>>> controllable attributes (security state, address space), enabling
>>> deterministic IOMMU testing.
>>>
>>> Key features:
>>> - Bare-metal IOMMU testing via simple MMIO interface
>>> - Configurable DMA attributes for security states and address spaces
>>> - Write-then-read verification pattern with automatic result checking
>>>
>>> The device performs a deterministic DMA test pattern: write a known
>>> value(0x88888888) to a configured IOVA, read it back, and verify data
>>> integrity. Results are reported through a dedicated result register,
>>> eliminating the need for complex interrupt handling or driver
>>> infrastructure in tests.
>>>
>>> This is purely a test device and not intended for production use or
>>> machine realism. It complements existing test infrastructure like
>>> pci-testdev but focuses specifically on IOMMU translation path
>>> validation.
>>>
>>> Signed-off-by: Tao Tang <[tangtao1634@phytium.com.cn](mailto:tangtao163=
4@phytium.com.cn)>
>>> ---
>>>  =C2=A0docs/specs/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>>  =C2=A0docs/specs/iommu-testdev.rst=C2=A0=C2=A0=C2=A0 |=C2=A0 96 ++++++=
+++++
>>>  =C2=A0hw/misc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +
>>>  =C2=A0hw/misc/iommu-testdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 292 ++++++++++++++++++++++++++++++++
>>>  =C2=A0hw/misc/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>>  =C2=A0hw/misc/trace-events=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 ++
>>>  =C2=A0include/hw/misc/iommu-testdev.h |=C2=A0 78 +++++++++
>>>  =C2=A07 files changed, 483 insertions(+)
>>>  =C2=A0create mode 100644 docs/specs/iommu-testdev.rst
>>>  =C2=A0create mode 100644 hw/misc/iommu-testdev.c
>>>  =C2=A0create mode 100644 include/hw/misc/iommu-testdev.h
>>>
>>> ------------------------------<snip>------------------------------
>>>
>>>
>>>
>>> ------------------------------<snip>------------------------------
>>> +
>>> +static void iommu_testdev_maybe_run_dma(IOMMUTestDevState *s)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 int i, j, remaining_bytes;
>> I think i and j could be declared in their respective loop
>
>
> Thanks a lot for taking the time to review the patch. All your
> suggestions are excellent and make a lot of sense.
>
>
> Move the i and j loop variable declarations into their respective for
> loops sounds a good idea. But I wasn't entirely sure if QEMU had a
> strict code style requirement for this, such as mandating all
> variables be defined at the start of the function before any
> executable code (C89 style), so I appreciate the clarification.
>
<snip>

We have a special exemption, from style.rst:

  Mixed declarations (interleaving statements and declarations within
  blocks) are generally not allowed; declarations should be at the beginning
  of blocks. To avoid accidental re-use it is permissible to declare
  loop variables inside for loops:

  .. code-block:: c

      for (int i =3D 0; i < ARRAY_SIZE(thing); i++) {
          /* do something loopy */
      }

  Every now and then, an exception is made for declarations inside a
  #ifdef or #ifndef block: if the code looks nicer, such declarations can
  be placed at the top of the block even if there are statements above.
  On the other hand, however, it's often best to move that #ifdef/#ifndef
  block to a separate function altogether.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

