Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83DCC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfdbW-0007Xe-QB; Fri, 03 Jul 2026 09:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1wfdbP-0007XJ-C5; Fri, 03 Jul 2026 09:06:43 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1wfdbN-0000Tg-6C; Fri, 03 Jul 2026 09:06:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=PepPxaW
 14fxg0o7IrpNHBlYdCh1KeHAXKb73RWqf2iYzFPaPyMXNDi4h8DSf12fTlWajw8+tT6P7S
 PtWAVZQX8R4/5rE4aEEvINilDlFxI51NyX7UDdP5t2/Ck2xKbLV0FTdD6Dvv5fI5CxB8iU
 7PrJa5av46Qt9pQXyv7suHe7Ed/DWGrvX7RqmhlJWM4qEaVQyhbnNsc2qJLTnMmcKKKYp6
 xrLbOvs0+8zEeNuvYoRisfiYn9/OtyeFHXWtGXem8IjO4wvVNO0nVL/uwU0sFT1A91Zb2n
 s5fVazhmxUP1wryAs2PQ/k4KKyEhLQoc38CHbTNDD1J6DCkmpLvkq0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=C
 qMc5yYWz7CDZKzBEUa5yhnEL8258a+LO8fWHAR/c54=;
 h=references:in-reply-to:
 subject:cc:to:from:date:dkim-signature:dkim-signature; d=mx.catap.net;
 b=VbHLhE2jO960G/vai3l8A21Wms9fdyDsmv9afRW7xgaJbyAaQ5b19fKey+Sb1KkTivU5
 rm6veF2PQTCa8+b3XwO8nIiqHOr4fE5o8fEl984iI2fQrhLTW+tHXxVBaDmdUd65sc1Z8d
 n4mwJOetQAAEx/PxMT+rV/OoBjE5TSwayGNykFPk+zZ42h0DeeaNe992bvxeUEzGMjqh11
 cImUzTUjDkfmo+/r6BfnfAViRKmkACrWaCP469v89f/6HqDvRqXzjhr9hJxRw1VEqP02GY
 W9iiG7HBqS4+D/opLatOVoZXFbYat6DOnHiI6hbgD2wCikgMicStOAGt+X6ahWPw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=cM8vX5JM; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=cHZJ4w2A;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=CqMc5yYW
 z7CDZKzBEUa5yhnEL8258a+LO8fWHAR/c54=; h=references:in-reply-to:
 subject:cc:to:from:date; d=korins.ky;
 b=cM8vX5JMNa8FPyAhvdvG3VeMB7kbrA
 yqcHEaD46uc0Is1Jr32BeNPkH17tnyFSRlCAyohj8nYjAwlldbWLyh41TPR+67hkczy/Cm
 VV9jwFl6Y9JrHqc3wtiMhduGQF4cHr/+qLiX/BXQ3/5/AawVQ+Zkucd0sBqfjKGUO8buTv
 0iRuWCfclRVFGdLGj1OIYVIzh2LQBUm5Xb2BUntL406fSSu2X8E7jnJXRYXkTRqpVCKQHL
 ItzwcMwEJumXBRMij1axURPz4pvU0d92+Wx/tdDtfJVs8bVUTpyyY0CM+mn0rRP00V4L5C
 F12dUDhiE2SoOzecfkyyrbjSAksDJZ6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=CqMc5yYWz7CDZKzBEUa5yhnEL8258a+LO8fWHAR/c54=; h=references:
 in-reply-to:subject:cc:to:from:date; d=korins.ky; b=cHZJ4w2Avbj9mQw+w5
 9cGGuyk++qlbeqdtEkMMhtU0ijuAiGi56O0SEVhr8kQd5xVHYw7XupN6gsATh/5j7vAA==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id 3661512c
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Fri, 3 Jul 2026 15:06:34 +0200 (CEST)
Received: by matebook.home.arpa (OpenSMTPD) with ESMTP id 1505a724;
 Fri, 3 Jul 2026 15:06:32 +0200 (CEST)
Date: Fri, 03 Jul 2026 15:06:32 +0200
Message-ID: <871pdkmdd3.wl-kirill@korins.ky>
From: Kirill A. Korinsky <kirill@korins.ky>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Brad Smith <brad@comstyle.com>
Subject: Re: [PATCH v3] powernv: boot OpenBSD on POWER9
In-Reply-To: <a52771d5-0179-48de-a0e3-eac95192b789@linux.ibm.com>
References: <20260702130152.89334-2-kirill@korins.ky>
 <a52771d5-0179-48de-a0e3-eac95192b789@linux.ibm.com>
User-Agent: Wanderlust
Mail-Followup-To: adityag@linux.ibm.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, milesg@linux.ibm.com,
 rathc@linux.ibm.com, brad@comstyle.com,
 Kirill A. Korinsky <kirill@korins.ky>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 03 Jul 2026 14:49:23 +0200,
Aditya Gupta <adityag@linux.ibm.com> wrote:
> 
> On 02/07/26 18:31, Kirill A. Korinsky wrote:
> 
> > <...snip...>
> > 
> > +
> > +bool ppc64_v3_get_pate(PowerPCCPU *cpu, target_ulong lpid, ppc_v3_pate_t *entry)
> > +{
> > +    uint64_t pats = cpu->env.spr[SPR_PTCR] & PTCR_PATS;
> > +
> > +    /*
> > +     * Keep the existing ISA v3.0 PATS interpretation first.  OpenBSD/powernv
> > +     * computes the value written to PTCR as ffs(PATMEMSZ) - 12, which writes 5
> > +     * for its 64KiB LPID 0 partition table. If the existing interpretation
> > +     * fails, accept that form only for the bare metal LPID 0 table.
> > +     */
> > +    if (ppc64_v3_get_pate_from_size(cpu, lpid, entry, 1ull << (pats + 12))) {
> > +        return true;
> > +    }
> Thanks for the patch, though I still have a doubt here about PATS.
> PowerISA says Partition Table Size=2^(12+PATS). But seems OpenBSD on PowerNV
> populates PATS in such way that Partition Table Size=2^11 + PATS. Why does
> OpenBSD populate PATS this way, or am I missing some document where
> Partition
> Table Size was 2^(11+PATS) ?
> 

I have no idea why OpenBSD does it but I see in powerpc64's pmap.c:

#define PATMEMSZ	(64 * 1024)
#define PATSIZE		(ffs(PATMEMSZ) - 12)

which was introduced by this commit:
https://github.com/openbsd/src/commit/dfe2a24332fd6769a7f9bb5806753189dae4d9c9

-- 
wbr, Kirill

