Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67879C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 11:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGd2X-0000n3-82; Mon, 10 Jun 2024 07:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sGd2V-0000mq-7w
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 07:18:15 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sGd2T-00088J-7t
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 07:18:14 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-579fa270e53so6282123a12.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 04:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718018291; x=1718623091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kfhyUCsbv5gCUeKYEKrdh6XzXJ4Bij4rf5wd3TQycs0=;
 b=Z9MGNSYJgIQK86jUV8uH1ZEVlN6hJy9wt0rc/TLwKgPOy0kW8gYbYxIXyDRR52AH6d
 DUFIc2mkoFGCNVYWKTO5DjAmAyqZt4YviXCzzlR6HOZGdJzZ1i+jAGTJnHloWGD5ddoc
 X+Of4ET/BP/LB2cNy0JLcndpjDUAbszpt9xjZCgAQ1nBB7FtT1tHe3esWSVDNG/doxU1
 zaQZchQpWeHrpEbkRCMq+gFsM383EkxFgwebYMG22z1e3ygIncp5/xsCqcoYB7oJJWNm
 AWdFVOk52jh8mYLIf2JgG7ZfcFt1CT11PKlWV0jll4UXGXUvcos1G73t+91BySDaEMDA
 EsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718018291; x=1718623091;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kfhyUCsbv5gCUeKYEKrdh6XzXJ4Bij4rf5wd3TQycs0=;
 b=iiTiOZvMVeB6sgBsalcZphv0tMw5lbMuzgMwkBrOp99GQ8d+aH+VTH9Mx/PF8LCi/M
 MwPMUj6quChJSzdL+cpD2evT7g/ufpf+xUUA5uAIZdHjgRHGd1Wld9rj/H8yxkhbkkM3
 LWTNL83zVlhORp0fMWX6bmBYBDzg9z/t+8TQNjNwwa2k+/HoSfY42RcEn+CTq+VUev3M
 GYAu7Dy1PgmXIU/pL+2rrYZndwLvRrj0/KBdquNIaEGSAB2+5HZH2+3m45EPUkDhd5eV
 bclTyEZcvMLYvd1dCpxbrqVnmxyQNtMmvwbbJhGJgGbYdd9I6UH3XIXQP+IDvj76/x5U
 BEjw==
X-Gm-Message-State: AOJu0YytVcdl7NUZsEXzHedb/2Opt1k5DC7rH83T4u/W4WkiFJoFybqp
 JsGXcXdXX/nK0zdhxL/CTNOYD4wZcZv+LJ58tdxOU4VKIt8m5HkNRSHTK6RIkQQ=
X-Google-Smtp-Source: AGHT+IFtoumLzIoNtbV8qkcqcXS99+JBWPYFH3vlOQq6a5sOQW0IoJhC5B6Fj1KaM/BFqFm0NzgJ/Q==
X-Received: by 2002:a17:906:184d:b0:a6e:b5ef:4145 with SMTP id
 a640c23a62f3a-a6eb5ef418fmr638320666b.16.1718018291063; 
 Mon, 10 Jun 2024 04:18:11 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6ed33b2435sm431482166b.64.2024.06.10.04.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 04:18:10 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E67115F860;
 Mon, 10 Jun 2024 12:18:09 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Andreas Faerber <afaerber@suse.de>, Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson
 <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>, bbauman@redhat.com,
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 cw@f00f.org,
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Elena Ufimtseva <elena.ufimtseva@oracle.com>, Auger
 Eric <eric.auger@redhat.com>, felipe@nutanix.com, iggy@theiggy.com, Warner
 Losh <imp@bsdimp.com>, Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe
 <jgg@nvidia.com>, jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>,
 jjherne@linux.vnet.ibm.com, Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel
 <luc@lmichel.fr>, max.chou@sifive.com, Mark Burton
 <mburton@qti.qualcomm.com>, mdean@redhat.com, mimu@linux.vnet.ibm.com,
 Paul Walmsley <paul.walmsley@sifive.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Phil
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Bernhard
 Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Wei
 Wang <wei.w.wang@intel.com>, z.huo@139.com, LIU Zhiwei
 <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Hanna Reitz <hreitz@redhat.com>, Kevin
 Wolf <kwolf@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Eugenio
 =?utf-8?Q?P=C3=A9rez?=
 <eperezma@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: QEMU Community Call Agenda Items (June 11th, 2024)
Date: Mon, 10 Jun 2024 12:18:09 +0100
Message-ID: <871q5511xq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


Hi,

The KVM/QEMU community call is at:

  https://meet.jit.si/kvmcallmeeting
  @
  11/6/2024 14:00 UTC

Are there any agenda items for the sync-up?

One that has been suggested is looking at the current Rust proposals:

  https://wiki.qemu.org/RustInQemu

And discussing what we want to see for something to be upstreamble.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

Alex maintains the invite on our Linaro project calendar here:

https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DMWd2dW=
I5NDM1bzdocnJlbTBhMHJhbG5sNWlfMjAyNDAyMjBUMTQwMDAwWiBjX2s1cDJscGd2YnB0ZGlya=
3U1c2kwMWJsbW5rQGc&tmsrc=3Dc_k5p2lpgvbptdirku5si01blmnk%40group.calendar.go=
ogle.com&scp=3DALL

