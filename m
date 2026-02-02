Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C53E7DEFE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 16:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmweG-0000WV-5p; Mon, 02 Feb 2026 11:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vmweD-0000Vo-Hx
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 11:19:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vmweC-0004Zy-4M
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 11:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770049170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Otgzz3JTanC4ARlk05P0NYg+t/glceE1AGvOnbtY3QQ=;
 b=Ke9UVKqCE65jsrW7lxXnlxLrfPe+u1LVpxiGIxX7W/spgkmUMWgZPFoU0VrfTK+TmrYxDR
 bv7lyddqAenjnyPpbuYvWOAufiJESASOG+6t+Zq7ELhIo9mPAwy3uNzuwSVyajHluIXWCq
 14tWTGFN+rrsRNTE/Hw1urUsRysOS70=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-J6_6WFqTPUCOaqr-P4cuKw-1; Mon, 02 Feb 2026 11:19:25 -0500
X-MC-Unique: J6_6WFqTPUCOaqr-P4cuKw-1
X-Mimecast-MFC-AGG-ID: J6_6WFqTPUCOaqr-P4cuKw_1770049165
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8c52f89b415so1305266085a.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 08:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770049165; x=1770653965; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Otgzz3JTanC4ARlk05P0NYg+t/glceE1AGvOnbtY3QQ=;
 b=f2/UQ5efop8muLt+fTVa6gobkw47k4M4yFQ2mjv49pRCQie1o1LNzt4G/m4mPS3T/W
 /RRmrdKOYHNHmywt98SC4qne/R2dbgoViO+z1/vfW1NMphbM9EHkoULwQwaG/N4j/fE+
 5JidLp9IvU7bhrqLpqtqik9hC0m0Lrvx1IE5UR2yNYzrL5+XezwJheEFPo12qhwwhV8Y
 vmZ9iRtMVbZD/i9ZiKQUrW6U+sAjWe81v+AgBOlVb1iQmlbomqTrH9JMizn1TfOiQ0AJ
 qDfVkl05icScmfc/UEXsVbJMb1yg1A0UPt9vURYM4ffXktXfiEpSRnUBhs9hVFB5gS+e
 x2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770049165; x=1770653965;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Otgzz3JTanC4ARlk05P0NYg+t/glceE1AGvOnbtY3QQ=;
 b=N2kCIl+IxsXSqI5Ab10Ly4l3Sh8Wll3tP+h4FqHCi/6HoVF/0x4/j1dFOyllWKqKly
 yGbXlnsatV6HWrvBCOsEkoJ8WJ6C8JfIOk3tL5XrUN+CnNk4F23gjZZV4pR06gz89gpR
 sSRdRP82VBqnhj4+2Fj2E5m4j5yiLLMyED+s4YLeG3gpQfsoG4jw6BPEyRN7hIFb0pQP
 x/2SB1hp5BrNCI/Ee72/Fdt4ugZvq+pMo2/ay7TSMK7BpmGZXJwdRbai7qIG7IfWgFBm
 iXEo2BWSRb4rFrSA8zCMF7XoKKNemCD5HvDRWdXy4FQK2YjHPxxdREpsUeDiKxBzNB/u
 L/ew==
X-Gm-Message-State: AOJu0YyAMHGIovlUspSGpd8qWZFL2d9LcPhGxlx7v0FFFH4uX14MdyJ7
 /zDpuEwTSqng5Cmmd9n37d+7DdMRcSZzp8wxopB7hc3u32VanFVBn/kYehV+JkZpu6Gr5oiNOCr
 /OuFLpstBFBAmspPrSUaowN+Y78hWZXUDrbQ056Q7sDcbo79ksW4WAKiN
X-Gm-Gg: AZuq6aIyIHvSi8k2AO7/Pm3hYWGSHqkV8JEB77GvdkQRBc/rW/i0tLllvl8fnoF9wuT
 ntOv0DGGS2vEde43blCTdFaeoB9xK0bQQ1m4R6EAEDEfQA3jt4U4Chdfld1N5wBoIh/gkEps1An
 H5UwZKWm7maO5Ax6QK3plmfj3ytrfBNB5HdvBWalxBG30hUs794gU5WQ8HF1mdtYU+T1m/eWkN/
 AuEnXXCmb/dGfy3dyb54ft2+LbvupxSBnzowpHULvNUUwSWZuyAGmZOxgWla2I1wH8aa7xJNFp5
 Ornb1rR3iPZtlH2ydNzoOJtNtsnN9ZDE3iXUpkmtIg7Dq65E3g3d5BFbBknpptdtSXM1i+AibMz
 hvJg=
X-Received: by 2002:a05:620a:400e:b0:8be:88f2:5b15 with SMTP id
 af79cd13be357-8c9eb279f82mr1592612285a.38.1770049165236; 
 Mon, 02 Feb 2026 08:19:25 -0800 (PST)
X-Received: by 2002:a05:620a:400e:b0:8be:88f2:5b15 with SMTP id
 af79cd13be357-8c9eb279f82mr1592608985a.38.1770049164798; 
 Mon, 02 Feb 2026 08:19:24 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c711b7ba53sm1281178185a.1.2026.02.02.08.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 08:19:24 -0800 (PST)
Date: Mon, 2 Feb 2026 11:19:23 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: Update comments mentioning qmp_migrate_finish
Message-ID: <aYDOizMPtP4uHa1K@x1.local>
References: <20260202124112.30684-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260202124112.30684-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Feb 02, 2026 at 09:41:12AM -0300, Fabiano Rosas wrote:
> The qmp_migrate_finish function was recently removed in commit
> 2379a04e60 ("migration: Remove qmp_migrate_finish"), update comments
> that mention it.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


