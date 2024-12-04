Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C160BE77160
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 00:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIdOn-0001CI-EG; Tue, 03 Dec 2024 19:37:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tIdOj-0001C1-7s
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:37:45 -0500
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tIdOh-0000Iw-JK
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:37:44 -0500
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-841a565f871so241177939f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 16:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733272661; x=1733877461; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=wKaJY2UJNpa7445+ZQtGYwS3k7khBs3zn88GCrdeyYY=;
 b=njCLrs4ST0L2AaA/G1Qkvlg+NctyxXfm+Y/MBjRktFFcxeIgq9Om4l54si4dd6heJW
 9YtWzhUvsApOPqunndiYpXwIs3PMICB7qHP2cwoLnb2wSQ+4S4UIIfnQ3NgQzr7/JLir
 Dk7pCQvCi8dSn/iaXHAxsoUmU54aeYo6N/DFXUWudnPOWXbFPUGa2B7q8pILC63Zc8is
 tcvJFs2jS18OZC/ENtTxFsW3U+DFATOGM7nMjmNDotXKrErKAAe+TKkhCbNlIoR9H1oc
 681jXy3qvA5rWvNIi22i5Va+XhZuJsfhINqW7MkhGrLgLUyjGvfPmBx+wMHEeNRf/NyM
 LsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733272661; x=1733877461;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wKaJY2UJNpa7445+ZQtGYwS3k7khBs3zn88GCrdeyYY=;
 b=sysqjbdfIyv/xXd2leb1/HQOOu+UbKtvngAuGx6w2jgOIBqLt1GGQ/JDvhWow2nZ33
 nBql8XHBW/v/Hmp6ZZ1Kbe8JnSnnfi66Nhd1HETZ4zzMSBQWqaUBIX1n8EuTr8nWuxS7
 GSHbq/ChlpXWVKuuRfWdddVWOywq1ymswpyNe2ga+jtix2GHy0aDOefDKR0CJG8XomdE
 SsRO3H4dm8gtIstU+U7njA/KMHJeeDLZqw0XyxfDNCo6lMKEg5AvIXD4cT7t3OpPQrfN
 VKPgOmO01A72v2TiQfi7123tKUXTzGOSgv3g/JCaiGGdhzEbi4XOOcfnjUMr/J9IHE/p
 VwTQ==
X-Gm-Message-State: AOJu0YxN3U5y9sfLHh3J1DCs8q7tltH3je1aCpCZdQHv2PmtKH9hHPRC
 aQbKUinI6g83ust87abad3+f6kcf4qczKzVqPy3P9x8oBeU/3jCP
X-Gm-Gg: ASbGncvyN8DwV+e0eAsKlD0gTKzOfYo7N7NdfEXnfTTSrlvphE855t7rUv6J41oF0a+
 MhZoIiXMNu5u1YLFJTuZO63/2mBYi92aQmAIX6j56ZHhH+lqD72ShbklpvOrwEKMDKsBbftGHj5
 ZN2Y0EjF1d/+D33r4T9iFY/+w3azrOd1ouKqxVMKW7Dy1Pmhxruys8KDYvXK+jKH7cl/uIlkhoA
 EthYNlbTMpxHbQmgeps4us1GSRL/JoKB6JlwQZj3PC94cnpWiVSHgOTcQgr7eaNO3A=
X-Google-Smtp-Source: AGHT+IFnZaZlx1J/iPzDg+brt6jzNgLDMNWuGuE6qxUzInhCxoFKRe8mQ5hcOtm0O8OJqOzJm+DKiA==
X-Received: by 2002:a05:6602:6b19:b0:83b:a47c:dbfd with SMTP id
 ca18e2360f4ac-8445b558760mr600359539f.6.1733272661454; 
 Tue, 03 Dec 2024 16:37:41 -0800 (PST)
Received: from DESKTOPUU50BPD ([2601:281:800:5d0:e463:ff0e:115e:ebbd])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405eea345sm278550339f.21.2024.12.03.16.37.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Dec 2024 16:37:39 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
 "'Anton Johansson'" <anjo@rev.ng>,
 "'Richard Henderson'" <richard.henderson@linaro.org>
Cc: <qemu-devel@nongnu.org>, <ale@rev.ng>, <bcain@quicinc.com>,
 <philmd@linaro.org>, <alex.bennee@linaro.org>
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-37-anjo@rev.ng>
 <eaf906e2-3973-466b-8a2e-f7749e844968@linaro.org>
 <gcp5xcypulziy2ixslvsiekwidedztxydvypyc6faz2ssbzx2i@ibcmjqjzgxwp>
 <2ee450df-b06c-420a-9e52-44b781423c6f@oss.qualcomm.com>
In-Reply-To: <2ee450df-b06c-420a-9e52-44b781423c6f@oss.qualcomm.com>
Subject: RE: [RFC PATCH v1 36/43] target/hexagon: Add temporary vector storage
Date: Tue, 3 Dec 2024 17:37:37 -0700
Message-ID: <077901db45e4$b9187750$2b4965f0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQIEexPeVLm6zD1FRBDT2o/6+kAhcQKn5JJxAVJOMAIB8qO9YgFFbC9yskk+OHA=
X-Antivirus: Norton (VPS 241203-6, 12/3/2024), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Tuesday, December 3, 2024 1:28 PM
> To: Anton Johansson <anjo@rev.ng>; Richard Henderson
> <richard.henderson@linaro.org>
> Cc: qemu-devel@nongnu.org; ale@rev.ng; ltaylorsimpson@gmail.com;
> bcain@quicinc.com; philmd@linaro.org; alex.bennee@linaro.org
> Subject: Re: [RFC PATCH v1 36/43] target/hexagon: Add temporary vector
> storage
>=20
>=20
> On 12/3/2024 12:56 PM, Anton Johansson via wrote:
> > On 22/11/24, Richard Henderson wrote:
> >> On 11/20/24 19:49, Anton Johansson wrote:
> >>> Temporary vectors in helper-to-tcg generated code are allocated =
from
> >>> an array of bytes in CPUArchState, specified with =
--temp-vector-block.
> >>>
> >>> This commits adds such a block of memory to CPUArchState, if
> >>> CONFIG_HELPER_TO_TCG is set.
> >>>
> >>> Signed-off-by: Anton Johansson <anjo@rev.ng>
> >>> ---
> >>>    target/hexagon/cpu.h | 4 ++++
> >>>    1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h index
> >>> 7be4b5769e..fa6ac83e01 100644
> >>> --- a/target/hexagon/cpu.h
> >>> +++ b/target/hexagon/cpu.h
> >>> @@ -97,6 +97,10 @@ typedef struct CPUArchState {
> >>>        MMVector future_VRegs[VECTOR_TEMPS_MAX]
> QEMU_ALIGNED(16);
> >>>        MMVector tmp_VRegs[VECTOR_TEMPS_MAX] QEMU_ALIGNED(16);
> >>> +#ifdef CONFIG_HELPER_TO_TCG
> >>> +    uint8_t tmp_vmem[4096] QEMU_ALIGNED(16); #endif
> >>> +
> >>>        MMQReg QRegs[NUM_QREGS] QEMU_ALIGNED(16);
> >>>        MMQReg future_QRegs[NUM_QREGS] QEMU_ALIGNED(16);
> >> Wow.  Do you really require 4k in temp storage?
> > No, 4k is overkill used during testing.  But consider that Hexagon
> > uses
> > 128- and 256-byte vectors in some cases so if the emitted code uses
> > say
> > 5 temporaries in its computation we end up at 1280 bytes as an upper
> > bound.
>=20
> Per-packet there should be a maximum of one temporary.  But per-TB =
it's
> unbound.  Could we/should we have some guidance to put the brakes on
> translation early if we encounter ~N temp references?
>=20
> But maybe that's not needed since the temp space can be reused within =
a TB
> among packets.

You should only need enough temporaries for one instruction.  There are =
already temporaries (future_VRegs, tmp_VRegs, future_QRegs) in =
CPUHexagonState to handle the needs within a packet.  There shouldn't be =
any temps needed between the packets in a TB.

The number of temps needed for a given instruction is determined by the =
compiler - version, level of optimization.  So, you can determine this =
by compiling all the instructions (i.e., build qemu).  I'd recommend =
having a few extra to future proof against changes to LLVM.

Taylor



