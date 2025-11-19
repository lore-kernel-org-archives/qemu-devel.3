Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2250ECF3187
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 09:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLewb-0001mb-Af; Wed, 19 Nov 2025 04:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1vLewZ-0001mQ-M7
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 04:57:43 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1vLewW-0006C8-Or
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 04:57:42 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42b39d51dcfso3671466f8f.2
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 01:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20230601.gappssmtp.com; s=20230601; t=1763546259; x=1764151059;
 darn=nongnu.org; 
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xlIDD3P4YdHZcnyH/LavO1kT+i9fQ8ABrVKBWe/YZms=;
 b=oEpI4CBefjWWhkeYBAyQiOE6s93yPQx+F0uSXk2HsQbHBqnHLDkxe7WZ8Ii027pZYf
 qrtTx1olNoIBbWNg45sVwFEQN47Aj6wLs3t1f8Wd9HdqKDkjOx1H9cPTzIKSWWveIaN4
 EJnM0o4cpEml+qwuAJgU0alQU1Zb2wCKJ2x/oNeaOWqdZ9lqg+LpyCDnCqyRaHeJJRC1
 hHA/vZ0w7DxOoF7GugABl3+y2mmCzAazblJdEuKS1KnMS+NCTxLB4YVA/C9cIE4y95BO
 7PfiPrtjt8eT4cimv+690J4dogedkebG1T2HOJS+lWZMgn918Gwc/8tDFLV3n9/BBCwl
 t6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763546259; x=1764151059;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xlIDD3P4YdHZcnyH/LavO1kT+i9fQ8ABrVKBWe/YZms=;
 b=bK13Q6zFpRLNRVjZB9pjhA8Ws7axS6f2N5O2yumnpIYZtbz/K2Dk3pytOTA+uHH7RG
 qKDFiCKWpg9hAv93j3CMfiKHgh7wmbXcggdtW/R6UWVCDGA2nZBAlScuHBL0j+VH/MsO
 TuUvSKhO1ot6ZwgFkhLkQUyas1qOwfooaryBBl5tWzDoHOVhqdexOjjkHLVSekMKx/Hd
 AXjoyphM1CEsVHJLFxY/W9xIp6QXdr9iwrUXrv9cKlq0a/cIMAH7Go04fRsVal7pPj9m
 cNocJVF7F18e0jBS/iemIizhmYQuRhaes3SVhnnSSU9LsofALNmbVbD9TzsbEA4gNKy0
 xJMw==
X-Gm-Message-State: AOJu0YyHqGz75f7J5/b7iokMY+BFMcIIMjcs0T84jzJEWw+MZMy8h6x8
 +/s3QYevDFqXTZoIL63mWXuLfCm7WYVbqEGlv6N0NIud5lKU3/g3lL477PDn8hNDSVwaVDAQnXt
 AwPjt1iY=
X-Gm-Gg: ASbGnct74m08sC+lFBJzxx8OhWewi81vpQMiXNa4gjQVydcNnL5b/42JZK21UL6GVYD
 l/yxf8YpJ3cM1/Gmo/uOZ5V2A9DC/JC2bfgRhvsi/D6TnOz/3VAkeanNo94tYL311wS7pCLwe7f
 521XKjxygRPh26+/GjbHSSMZsPse/iOghNbV0lor9VwUalNKl22vvinKLIFzf7Il+gRD/yJEe4F
 GFqYwD32l1AKUwzo9pMi1XIW8GkcR3AH3GTId58nv86TKGsr6UwMv4eRcrdctRT+7rgiiQwJ6Nc
 upjL9GGbp9P/j9FAkr6T01/Z6zdwVBTNkXMfeAC1FQ3Jp8xSvLxW18HBcwHQXKl5ztZVEKLpvdH
 1ShMjqvM5ngUOVU5b6iPSlK/WSryk5toT5VyQXwJXd0Gyoh46YSeVB7oEScNLkoXeP45mUwiwa2
 JkaSiP8iEj5COnotY=
X-Google-Smtp-Source: AGHT+IGbWDKb6ZmpNtPqbrX2tpNiJbg0xsOHKPUQbkrldmjMgD1CRdiFd2YL5aI0lpcY+wJnuHtfjw==
X-Received: by 2002:a5d:64e3:0:b0:42b:4061:2416 with SMTP id
 ffacd0b85a97d-42b59396ee3mr19137523f8f.52.1763546258966; 
 Wed, 19 Nov 2025 01:57:38 -0800 (PST)
Received: from smtpclient.apple ([5.12.109.3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7b14bsm36670521f8f.9.2025.11.19.01.57.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Nov 2025 01:57:38 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.3\))
Subject: Re: unaligned access for cortex-a15?
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <98b9ec31-abd0-4b1a-a06e-4e041f84bebd@linaro.org>
Date: Wed, 19 Nov 2025 11:57:27 +0200
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <748D08D9-A015-496A-AAFE-7416A026F056@livius.net>
References: <77419EC3-BFC1-4F0C-9287-2E753D0C30DE@livius.net>
 <98b9ec31-abd0-4b1a-a06e-4e041f84bebd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81.1.3)
Received-SPF: none client-ip=2a00:1450:4864:20::42a;
 envelope-from=ilg@livius.net; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



> On 19 Nov 2025, at 11:51, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> You must enable the mmu for unaligned accesses for the a15 as well.

Ah, ok, that explains it.

Thank you,

Liviu


