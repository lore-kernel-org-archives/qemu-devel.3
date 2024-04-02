Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8963CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 06:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrXeb-0004UN-ER; Tue, 02 Apr 2024 02:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rrXeZ-0004UA-9N
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 02:29:51 -0400
Received: from jackal.cherry.relay.mailchannels.net ([23.83.223.95])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rrXeX-0000Sa-6k
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 02:29:51 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id DB8736C19B4
 for <qemu-devel@nongnu.org>; Tue,  2 Apr 2024 06:29:46 +0000 (UTC)
Received: from outbound1.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 337876C1AF0
 for <qemu-devel@nongnu.org>; Tue,  2 Apr 2024 06:29:46 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1712039386; a=rsa-sha256;
 cv=fail;
 b=Ep0GptclR1b6pwcoJLhY4uy0qJKSzw8/6zo5yQHbGyPw7n4MoEV27orADdihq45Gw4CQXN
 yGUowzwWqGoQ5qe677nmUWkNbrC+Kulof3FuChVcTwk+wsStrJrrrnE2WhxHddsp4C/Mhn
 gSV5CApcafmNXpvGS1TC98hsMWLTXOdJKlXy2hJh6hnWuxZxn7H4ZwJh3xeFYzSkXbw3Rm
 gRHB9ll0XTCl9t1MOprpFPKAZqT3/IOP5h8cWX70rK31G2YCR10AkoTtZNNwYqpgwTi4He
 LmzzSbEvB7UCwscPsOouhJCCapkv7NXlyJ5Vqal+YOD+sD4KKERG/IxPN1eaVQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1712039386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=K3ckc+8a0AIBjXop3ZrA1Ec9emZFF4t05SJ+4BPS9bE=;
 b=8tYr0jNuqzhJmwI8QSK6whlIFCWH+NvSgV8+zh7c7m1ktDQNFHmL3RRyVJND12FeWkuu33
 SH/tJJ1nYL0YeWpD4z+2RVX8UqFxBVrZLNToWAeqoslC/u/55H/y1S8f3wG9r7/nvUA5j4
 nlddFRVTJ9sS1SE0zVmfY1oQaLwPgfQ/i5zcIS8ahMldqiaYcT3CtsH62mfmlLFkv1iIPy
 NYMHFQ/fXB6AFBiEoiM5oBCI4/M/oxbp2jzbGbC2FQvqg2so0FhycOWEQNxy6iyiCMEYP+
 oQTpAh3Jtyx3xt7My8oGg8tW1LjkppDht3IwzsKa3/hmhmM134qzfB5jcPxyjQ==
ARC-Authentication-Results: i=2; rspamd-5ffc56d49c-b7rxj;
 arc=reject ("signature check failed: fail, {[1] =
 sig:outbound.mailhop.org:reject}");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Thread-Ski: 352d317f6a69c95a_1712039386709_3701642773
X-MC-Loop-Signature: 1712039386709:3420191529
X-MC-Ingress-Time: 1712039386709
Received: from outbound1.eu.mailhop.org (outbound1.eu.mailhop.org
 [52.28.251.132]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.98.182.134 (trex/6.9.2); Tue, 02 Apr 2024 06:29:46 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1712039345; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=X/WCacVN+yv/Xm0shc9ivNFGm3vjp0nBt/GklBrYmvMlKsBsMbhDFO523kErJlP6Ihva9skwXJPzg
 9iMEyyo43a/5RpCkGZKjcuZ+yIoPQRCPRzjIDAim/UmP0tHS3AjMmgwyh8vntEqwjHANl2ZN+9gRVL
 b/3TYimHwZYH17Pau7ZJ3oka3YWaJdWLciRCex7Zp6quCjaw+D1lHhytARah/4sryMSGoJRVfJVGTD
 /B1B+LO+/Ddvx+XELxUipgcgMENZakMdLLtPV3nk/hon7o152nVV0xcmXmNV91tps63i7GqW6n4UEt
 KybTwgrih5gBd+EqSqeNPuqGCpSU9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=OeS1lRUOHLDWwbdCP5hXisgriZIRr5ijYBx0E79p3SY=;
 b=QtTMvF23Ty7e8GcC6BOBFoYn+JkMWYRsiJDT3TyFaABcJIjWofQ6LtvkW9nZl8mpzFNHzyX7f7kbB
 bwcrtzqgvlzAASa8ynhYqiblm37/BOGFldfTMMP7gHQuQVJiPObuEjyU5zztdpkbkn2lDBDDsSzewh
 piMBiIFttlB9JAdwGkB8mD8LZf1b2EFpzdIwZ/hOZcPHeHD6tc1mtASVmT2RmyOO5VKR6CoskfXF3s
 apGVu9K9TDnzHsuR46T6xJgJl29EHzy9QdRmOCsO5vtFoSSFcWx3LwmciS2pnDZiN6VsjIA2TaVZPl
 dgMMLyKoRBDDkrMbYacOxIEsQa1yEzA==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=MRYfe90P; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=OeS1lRUOHLDWwbdCP5hXisgriZIRr5ijYBx0E79p3SY=;
 b=HwZQbsz3/Tdo2DxQKM791gii8LibmWQqMDwkv53Icp/3CmRh8lbQ3Sa6Hn0MduclVYzVACUNOGUv6
 ttgjmQJFvCwfi+52GWQGLh1fd2S/++O0uc7LKbapN/l540R78rNdn6iNOwqPlPgdAV2yptj3Z8cfS8
 ZBJIGRmIm3m++DDk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=OeS1lRUOHLDWwbdCP5hXisgriZIRr5ijYBx0E79p3SY=;
 b=unwGSRrjnA3wsRpwJayxJQziQeGHzC83iBRIrUMR/j/0sCrqnUzch72Ak7AyYvCC8xL1mXrSAP5Q+
 FvNN7BFSYzEt/kCZFAVsbHDU+mNkDRlfNklmHYvvEE+PJaGiwjK9u/wW2ceVRjiGvuD0rRVLxfVQ4q
 cG+Es0tsc8RV8iU+GqWaqxCK8qwWs3fM1C5dlNUKnChg6oiGfLX0H7xBimuoOLu3CgEwpibLsaxgfn
 uZdfFdsVMxdgizvVyj4ggBp2sIByZaOrVhjfBVptvng7davXPqLRb04w5dYe4+E2qqLLjDIXCU5YUT
 BJfBqYSKsZpGuRF1os4wDPvzydc1wIg==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 4b9197dc-f0ba-11ee-b34b-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 4b9197dc-f0ba-11ee-b34b-eda7e384987e;
 Tue, 02 Apr 2024 06:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OeS1lRUOHLDWwbdCP5hXisgriZIRr5ijYBx0E79p3SY=; b=MRYfe90PWO5Cuq9dB15rjc+mv7
 GPUEO26Dki3WpKtixy1bE4Qyzs97bW7TEZpVj07hSe2vo286r4LMD5oajmXrar4ZOAI/KxbLzq7Fy
 zSrJ4o9vd8Ps+ohXZ0uFk6YYKhkaqbP15NJu/jQVSS8m1ILPIm14jnp+OQiUNCilB7H7LfvnCH/KW
 /xb+nt0SwlcQT5wUZOAc5JH9DiH7sTtnpfbBcuBOCy+eLL/rklxUOgT5/27anuCYzw1OZR4aYlrhr
 IdI8vXfVmcIEKrspLniZNGQHofWM6LlfySjO8oE/THVoOZTfXJ2lcIKp6i0s8HhIjI4zVuld1Sr7R
 5eQZ4u7g==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rrXeP-007A6C-2K;
 Tue, 02 Apr 2024 08:29:41 +0200
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 2/3] target/hppa: mask offset bits in gva
In-Reply-To: <a8130b3e-c80b-481d-970c-880353d22e23@linaro.org> (Richard
 Henderson's message of "Mon, 1 Apr 2024 20:08:42 -1000")
References: <20240324080945.991100-1-svens@stackframe.org>
 <20240324080945.991100-3-svens@stackframe.org>
 <ec050630-a866-4a51-8878-d35844fb66a6@linaro.org>
 <87jzlm1334.fsf@t14.stackframe.org>
 <87sf04xpzi.fsf@t14.stackframe.org>
 <a8130b3e-c80b-481d-970c-880353d22e23@linaro.org>
Date: Tue, 02 Apr 2024 08:29:41 +0200
Message-ID: <87o7asxooa.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.223.95; envelope-from=svens@stackframe.org;
 helo=jackal.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 4/1/24 20:01, Sven Schnelle wrote:
>> Implement dr2 and the mfdiag/mtdiag instructions. dr2 contains a bit
>> which enables/disables space id hashing. Seabios would then set
>> this bit when booting. Linux would disable it again during boot (this
>> would be the same like on real hardware), while HP-UX would leave it
>> enabled.
>
> Pointer to documentation?

There's no documentation about that in the public. There's this code since the
beginning of linux on hppa in the linux kernel (arch/parisc/kernel/pacache.S):

/* Disable Space Register Hashing for PCXL */

.word         0x141c0600      /* mfdiag %dr0, %r28 */
depwi           0,28,2, %r28  /* Clear DHASH_EN & IHASH_EN */
.word         0x141c0240      /* mtdiag %r28, %dr0 */
b,n           srdis_done

srdis_pa20:

/* Disable Space Register Hashing for PCXU,PCXU+,PCXW,PCXW+,PCXW2 */

.word         0x144008bc            /* mfdiag %dr2, %r28 */
depdi         0, 54,1, %r28         /* clear DIAG_SPHASH_ENAB (bit 54) */
.word         0x145c1840            /* mtdiag %r28, %dr2 */

So PCXL (32 bit) uses dr0, while 64 bit uses dr2. This still is the same
on my C8000 - i see firmware still contains code reading dr2 to figure
out whether space id hashing is enabled. The mfdiag/mtdiag instructions
are described in the PCXL/PCXL2 ERS.

https://parisc.wiki.kernel.org/index.php/File:PCXL_ers.pdf
https://parisc.wiki.kernel.org/index.php/File:Pcxl2_ers.pdf

There was a discussion mentioning disabling Space ID hashing in Linux:

https://yhbt.net/lore/linux-parisc/199912161642.IAA11478@lucy.cup.hp.com/


