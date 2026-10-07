Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED5FCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 19:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEXU2-0005rr-3C; Wed, 07 Oct 2026 15:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEXU0-0005r4-8s
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 15:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEXTy-0007Sv-D1
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 15:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791401956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VdQQ6F/Y7NRlXUXigBrE8bUV3yitf1QvJEYqoCWQuqU=;
 b=Qm0rJs2Z1IjR/cbIUlTPzhsfpYt40SiNElBkYYmxXBusFgppBydWBMNKOOWgQHlhpkvO/5
 HCVBP9eLApMCscpcXuDL2Vtdj/IL3S/GMIJ3DBClinYWMUzxUIgz6UBTutOMbLbiD5++ar
 CIZKOAPbxENGDBfTkWrzstatPi5pV3Q=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-MdspYPBKMASx7qPBFnxSqg-1; Wed, 07 Oct 2026 15:39:15 -0400
X-MC-Unique: MdspYPBKMASx7qPBFnxSqg-1
X-Mimecast-MFC-AGG-ID: MdspYPBKMASx7qPBFnxSqg_1791401955
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-919879b09b7so44416956d6.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 12:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791401955; x=1792006755; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VdQQ6F/Y7NRlXUXigBrE8bUV3yitf1QvJEYqoCWQuqU=;
 b=Kgznbldp0DtsrJAYaz8EgJUL5QvLgtsDTzihjN3mjoXFtAvB0dXg3kBZXU/RocGO8e
 xPrX6NLe1z+adDoMMzQyH+Ae5GaZFQX1fjK2+crL0a9tgh2qR3sdyj1BXVMSSdZ8bHjC
 zscAf0mtGg9GG7ESG1n6HYJ+0VuYemUEhrHFPGp6RWAKy8C7j3xkAYs/Kd7Vw1exJbyt
 QKP30dDOYDI6pRZp/4FGHhc1GWKQ9mn14iwvCcviPLO09m4GboFJKba8VaBa3gMvY32h
 ZG0I1F7UG2N0xR5bgxXTiOd9ehujS4gDMBJFdLKjQvEofyvmlDTRNSfu3Y83lScYmN3n
 uiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791401955; x=1792006755;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VdQQ6F/Y7NRlXUXigBrE8bUV3yitf1QvJEYqoCWQuqU=;
 b=CSVRjuuYwwOU9FeGggtebtSZ1/eOaHDnbJLpL0cpehAyz0Aj/NYDprnPm/s1Fs1go9
 chNX/6b+TO8BNXXlIlBTQ9K7S1TkThtLcwu9s3KpHjsoTaSWznw0cxluAuv/7azgOKel
 LLSrz1eCWi4sRfqDwQ3yEoKdNRscTYceGSIfe//O8ywKQ+AsY/BhLjms3kjla/8CyI3F
 Ox32V6E2DgDLNtqBORy7veJMIqEAlEh28vHv/QCtk2XwI+LmnBZWRHgavVPBEmgqUzCP
 V+ux6+o/2CWCTbqZgZWjL8c6UgZx7MLLunsYDvXh9XQFaqkF+eqrumm5CZBTv7dEnaFE
 V8AQ==
X-Gm-Message-State: AFuF++nfErjEYmYEaa92oNfUIShfg5c6Q9mLXyrhe+czhp0/rG+43bSK
 4+hsudoWtPuTP8VvQazdTilRfZfPy2PPiI7LeDik8EUyYXWIVYtZKwxkD5upt8U9D1t7UoK1ttO
 6Rmf++h/zycA9aUXVH/gwNPsrgopMBZkfv8ZrAEjoYhgsREO+FfP6mWj2
X-Gm-Gg: AYBFou20KY2jTQU8cqVvnCS97hJQkGHc6LWUH33e14wdg4hTOCCPPehkdByChXrY4Sa
 eUNnnWJMEjAFq8uSJMJpmQBx/xJnnJdwyuOtmUL/lrhYJExY9A+szUa36dvHd4rQbao7pCbskKW
 bZtNUFfvRa4hyUagftUc276G1X+7L/3QvOPVyq6UFnCXo82jI6OmKI5MdsoHXcnMfCglhwkEzgm
 99r20aYIcr+oRxpYLQLkh+WFALXv3louIRzaHjLHm6ZBRRaUVDFBeBsfB5Cmncz3MmPRnSkKAvF
 kfoFziJJ5wm9xnvj2SSO14+p7vzsVpGzSYFjCe9KjMWsHDyB8a32foiNsvkOHI4XJLFIT+0=
X-Received: by 2002:a05:6214:2f90:b0:917:8a83:a15c with SMTP id
 6a1803df08f44-91997821199mr61604506d6.34.1791401954562; 
 Wed, 07 Oct 2026 12:39:14 -0700 (PDT)
X-Received: by 2002:a05:6214:2f90:b0:917:8a83:a15c with SMTP id
 6a1803df08f44-91997821199mr61603876d6.34.1791401953907; 
 Wed, 07 Oct 2026 12:39:13 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-919973a87c3sm26668236d6.42.2026.10.07.12.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 12:39:12 -0700 (PDT)
Date: Wed, 7 Oct 2026 15:39:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 3/7] migration: Fix socket listen backlog
Message-ID: <asaf3zJnivu9VC6U@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261006182046.3767283-1-peterx@redhat.com>
 <20261006182046.3767283-4-peterx@redhat.com>
 <asVgieiXH1aieDak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asVgieiXH1aieDak@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 06, 2026 at 09:56:41PM +0100, Daniel P. Berrangé wrote:
> On Tue, Oct 06, 2026 at 02:20:42PM -0400, Peter Xu wrote:
> > QEMU incoming side may have set a wrong listen() backlog.  After the
> > support of multifd + postcopy now we have four possibilities on setting the
> > backlog, some of them are wrong:
> > 
> >   Vanilla:            1 (correct)
> >   Multifd:            N (wrong, should be N+1)
> >   Preempt:            2 (correct)
> >   Multifd+Preempt:    N (wrong, should be N+2)
> > 
> > No real report for this, found by code observation only.  Logically the
> > backlog (pending accept requests on destination on the listening sockets)
> > needs to be the maximum of possible channels.  Otherwise if the accept
> > queue full on destination, source QEMU may hit connection errors.
> 
> From a robustness POV, we might also consider retrying connections
> if we see a transient failure. Though I'm not sure offhand what
> errrno would result on the client when the accept() queue  is full,
> hopefully there's something distinct.

I tried to find but didn't see an explicit errno for it..  The hope is even
if hit it will fail migration with some errno, then a retry would work.
It'll be similar to when there's other random network issues when starting
migration.

> 
> This would mitigate a risk of DoS from an unauthorized client
> making its own incoming connections concurrently. Such a client
> is not necessarily malicious, as there are monitoring tools or
> port scanners that randomly open connections to TCP listener
> sockets.

I expect ports can be scanned, but I didn't expect adhoc connections then
drop quickly..

If that exists, it should be able to break incoming side of qemu with
current code indeed.  AFAIU what we do is we deliver the channel to
migration process and then we'll see qemufile IO error..  not too bad since
it will very occasionally fail migration, but source unaffected.

But I agree, I think we should be more error prone.  Looks like TLS is not
affected due to the fact that TLS handshake process guaranteed anything
forwarded to migration core will be verified and solid.

And I believe the migration handshake feature will fix this as a side
effect: when we will attach a header to all channels during handshake, then
at least randomly connected sockets will fail the check and then we can
drop the channel silently until it passes our header check.  I'll keep that
in mind when working on the feature, which is in near future plan now.

> 
> > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > Fixes: 0705e56496 ("multifd: Use number of channels as listen backlog")
> > Fixes: e274188612 ("migration: enable multifd and postcopy together")
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/socket.c | 25 ++++++++++++++++++-------
> >  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Thanks,

-- 
Peter Xu


