Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89CAC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 04:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu2YI-0007q4-1t; Mon, 17 Mar 2025 00:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tu2YC-0007ph-Hc
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 00:58:09 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tu2Y7-0004qT-MM
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 00:58:08 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-225df540edcso42804815ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Mar 2025 21:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742187471; x=1742792271; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RSSgzp31OncDNetHQhTx58zuRO5iZqorPzdIFZUKZwc=;
 b=WxcHAUS8h0GgINCRpdiu8t2vjzISa8MXw68zcunHTyNLnje4m1wbfO3ErzYtSTcfxE
 jOhhmiPPWmO7sXIrRQ6t7JyBggp/oSTNCqPyglz4bUrkrRvrP8M/BIM1rQgSaqmRqC8/
 EVG+5XuXwyQnsb8q6hu8zOaObe2eGpn0K/hZ+RU5v/Lk706aRG47aBRjLmesAVSOnbg+
 rRqpfHgc65Ebm/n4HYgo/1b6/lAXHGeJcrj8tPfV0sWV9I4+AZavq7PV5TbZSG7B6D5d
 f3MkgUKYYZPzvk4co7dvqclXtvHrfF+Ph69d5v2B3GLnUL8R7IcHyuIGIuaMQE9vzolO
 m40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742187471; x=1742792271;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RSSgzp31OncDNetHQhTx58zuRO5iZqorPzdIFZUKZwc=;
 b=pyBkszPVlu/0v8pNuIv5wwGjmszTFvQywUXr9ZeMgcc4OxKovBAoeAGgSBvwczOHJA
 AILGujEqy7NiixYR1CFBhSbV8erCG2hHmHxoC7BSiFP7uaB+pfiClKwnikEM2jo5fNpC
 uE/hhwSx6ytYHPSM7LGLROZ3+RQ5w9PQeWMAwYkPzdGfsPfgfBO7yJHfho4HDeTSYhnm
 vaNWZRvZ6D1iCkBBbiPvd6KOxL+ExzcK7pLYvDkXPIZL/Z4x0IqUni0FmAl1tHwZ16cc
 16cUmpzMzIAYBUlDwEP7lpmfCcju0ZcwjHHG8eTyd6DAwIAIQNq9NEnDv618zr4qJyGM
 Ul3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJcxnbs8Qx2Vm5pO5ipwcVCx2l7xRG4Ozx9WM4z8em8LvueD9huBecVZs1erfqoS53m+FgdK5LoU49@nongnu.org
X-Gm-Message-State: AOJu0YxJ9MNX+4O5uOPhDiZdH19JHI4Rvc/SQPCwOPv+fUy4XI38SgaK
 hwDe4/k3s8h3TDIPvl6MCK4uwA0sZuqLwD0wmFbTxM/zZ0mXExHX
X-Gm-Gg: ASbGncv5HTo0BmdhMo948UDoM6ESK6sp4gSEqbfUTbstq/tX3bWoD7XH1+AZdaVWP9i
 5QAO8E12M63r3f9wGMeQNJs6cqBAexyDItBQpaTkKy3/J3u99xIWAufEwt54uLrYtCUgTvIAbjw
 UrFJzgr6S/jmEyrsiC6N+XHAUwkW3/ZAr/VF8X7keQHpSyaOCZkW0mydS0zhTGtF6w1rormuNUd
 PmiyrWXPSsbBCZtpSHec1eh5HGjtjGeyG0tTxOqHzmioG/pJOdt5kVNUFP4/ufWwu42YVuMdS1T
 Ad3BtXIo/2RcIElYq6ZObF0vxnmLhnqvmbWDe+dVPpi4mgocwg==
X-Google-Smtp-Source: AGHT+IGghGve2nimx30hIetCzPnuUj3WdPjA8qtX1+c+1fbNFpCbGXGyoKtjrbqtzppgN6ku/6hB4g==
X-Received: by 2002:a05:6a00:8c5:b0:736:5969:2b6f with SMTP id
 d2e1a72fcca58-73722d653fdmr12653682b3a.6.1742187470641; 
 Sun, 16 Mar 2025 21:57:50 -0700 (PDT)
Received: from localhost ([118.208.135.36]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-737116b3de4sm6818746b3a.179.2025.03.16.21.57.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Mar 2025 21:57:50 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Mar 2025 14:57:45 +1000
Message-Id: <D8I9WWLAWDSI.3I9IU38CIU567@gmail.com>
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Peter Xu" <peterx@redhat.com>, "David
 Hildenbrand" <david@redhat.com>
Subject: Re: [PATCH 1/2] gdbstub: Add phys_memory_rw_debug for physical
 memory access
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250314074107.992163-1-npiggin@gmail.com>
 <20250314074107.992163-2-npiggin@gmail.com>
 <dfb1025c-830b-4c7e-8d77-b1948fa2c4a3@linaro.org>
In-Reply-To: <dfb1025c-830b-4c7e-8d77-b1948fa2c4a3@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

On Sat Mar 15, 2025 at 7:19 AM AEST, Richard Henderson wrote:
> On 3/14/25 00:41, Nicholas Piggin wrote:
>> Add an accessor for gdb physical memory access mode which sets the
>> the .debug attribute for the MemTxAttribute, and also returns success
>> to the caller.
>>=20
>> GDB with PhyMemMode will now report failure from memory accesses outside
>> valid system memory addresses, and it is also able to write to ROMs as
>> GDB virtual memory access can.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   docs/devel/loads-stores.rst | 11 +++++++++++
>>   include/exec/cpu-common.h   |  3 +++
>>   gdbstub/system.c            |  7 +------
>>   system/physmem.c            | 16 ++++++++++++++++
>>   4 files changed, 31 insertions(+), 6 deletions(-)
>>=20
>
> I think you might as well put this function in gdbstub/system.c
> and not export (or document) it.

A possible advantage this way is gdbstub not knowing precise
details of the memory transaction (i.e., .debug =3D 1), but I
can do that. Will submit a v2.

Thanks,
Nick

