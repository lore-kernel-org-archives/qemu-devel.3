Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E638606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 07:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=bKX4z6NI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR2N2-0004qv-KM; Wed, 11 Nov 2026 02:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xR2N0-0004qd-F6; Wed, 11 Nov 2026 02:03:46 -0500
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xR2Mx-00012B-Of; Wed, 11 Nov 2026 02:03:45 -0500
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jPZHW27mWz8Xrrd;
 Wed, 11 Nov 2026 15:03:35 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
 s=z202610; t=1794380615;
 bh=+gjMBpjVYJRz6J/iApfLesXB39oaznA0tpvtcjEWn3o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bKX4z6NIMagufPz4pJXVObWStrDBAyu05Dt5roclOBUQIgJzgyjYyesvfPyIDZK9a
 TzEIsjAdFIwa7vN7mV4eQ17nQU7VIJR3LJOb/BRf9kgeTuTBhj0I5MA140NYEpvmHY
 WEipvo1SM8mtwENRW4XummG8EJZd8RQmqFNOkotVxAB5eIL8s/bVlDZE2hdEm/fXp0
 quG/s6kLaEY6y/z5To4eUG92RcSR7WdZDWJArem3diYFXq765KBbxJRFG6RbBLmLiB
 eL2LcLdgjQQHeeXcCgtXkrXZEII0nfGKdMTwiFqRTGp9xF+cX34K7kFfFdVIkSj9oP
 yEwQoGTq/bABQ==
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
 by mse-fl1.zte.com.cn with SMTP id 6AB73S4O011772;
 Wed, 11 Nov 2026 15:03:28 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
 by smtp (Zmail) with SMTP; Wed, 11 Nov 2026 15:03:30 +0800
X-Zmail-TransId: 3e816af4134102c-2fc8c
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: alistair.francis@wdc.com
Cc: daniel.barboza@oss.qualcomm.com, chao.liu@processmission.com,
 liu.xuemei1@zte.com.cn, liwei1518@gmail.com, palmer@dabbelt.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 wang.yechao255@zte.com.cn, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH v4 4/4] target/riscv: Only save vmstate_debug when TCG is
 enabled
Date: Wed, 11 Nov 2026 15:00:26 +0800
Message-ID: <20261111070029.3825753-1-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <0c6acaea-4990-4723-9e25-0ea0d11e0530@oss.qualcomm.com>
References: <0c6acaea-4990-4723-9e25-0ea0d11e0530@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl1.zte.com.cn 6AB73S4O011772
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 11 Nov 2026 15:03:35 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF41347.000/4jPZHW27mWz8Xrrd
Received-SPF: pass client-ip=160.30.148.35;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alistair,

I'm fine with it being queued separately. Would you like me to resend it as a
standalone patch, or will you pick it directly from this thread?

Thanks,
Yechao
 
> 
> >   target/riscv/machine.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> > index 0de06e9588..c5f0261ba7 100644
> > --- a/target/riscv/machine.c
> > +++ b/target/riscv/machine.c
> > @@ -324,7 +324,7 @@ static bool debug_needed(void *opaque)
> >   {
> >       RISCVCPU *cpu = opaque;
> >   
> > -    return cpu->cfg.debug || cpu->cfg.ext_sdtrig;
> > +    return tcg_enabled() && (cpu->cfg.debug || cpu->cfg.ext_sdtrig);
> >   }
> >   
> >   static bool sdext_needed(void *opaque)

