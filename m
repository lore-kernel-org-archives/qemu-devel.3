Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0D7FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 10:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJqZZ-0003mT-9e; Mon, 04 May 2026 06:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wJqZP-0003fy-9A; Mon, 04 May 2026 06:30:36 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wJqZN-0003KH-S1; Mon, 04 May 2026 06:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=HQebBFKlRIt6H24FFyVk4lj1sLJYqM+5Ex49yANC/HY=; b=MJVGVZE+WgxsADMBct7I3bSJpp
 8wNRhB4jBa1xQXFDmwwRg6LQnjxy/zNkOOGvKHuPuEY7EAuZXxvjVZYBF47vbc9Rx4m1HxH8aFCrb
 g5Rnl2PVycoy9V/Atsb6YWI6WNUgy5YBHo6lIJ7+NjsoU7FLh7Seu96k4FEjVV8spRjuo/Me6VEa/
 lEZ9F+m3XtUnDdi8aRQPtmQcA4GTcEcuLTBTjiPp5l50+g1ORDblpVhsAObWdzb2aaMkVjhNxWbA9
 pT+625BAMFOKJIuQX18P/cpAsB1jLZNN7I1G2JqlKuEbxnRb/cxiCpf1dGnd3Mz6MPg7g1h+IIUYD
 zsZT5fzQMCH9rk1zknBIL6Xu5FyRE4crSiSmFiyMGCO8Dae9alY0qdP0FogpBMeh3CyJjaisKnkqq
 vCFZuk5e6UlmR/XSFA/WvKefdcfyl9yoSVm08p/3RYC/4M+woIKvleShZO+Y4xrthcKcZdUxc/xo+
 +pLD6cq9TBBwLw1ZI+1CHrUdvpr9Ex8j9wnMWIsmcHul/wENdJVpeBAm8Kscj/3dKut8cZHaK8IkZ
 wrFKzxVrLyWEeTdQDJX+LJDG0QmzVkT/78OEPzyCoKIAdJXp9NF7Xv2TNKDcnk7NdOgzBxHRjheKw
 Ja7TlJSPvsAREg/POvQ8n9pXbSndCDuejId6sBZ+U=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-stable@nongnu.org, 
 Jia Jia <physicalmtea@gmail.com>
Subject: Re: [PATCH] 9pfs: fix deep path truncation in V9fsPath
Date: Mon, 04 May 2026 12:30:28 +0200
Message-ID: <3415602.44csPzL39Z@weasel>
In-Reply-To: <20260430125241.3212990-1-physicalmtea@gmail.com>
References: <20260428074614.3169999-1-physicalmtea@gmail.com>
 <1954333.tdWV9SEqCh@weasel>
 <20260430125241.3212990-1-physicalmtea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Thursday, 30 April 2026 14:52:41 CEST Jia Jia wrote:
[...]
> If I understood your suggestion correctly, the short-term mitigation would
> be roughly:
> 
>   - make v9fs_path_sprintf() fail on both g_vasprintf() failure and overlong
> results;
>   - propagate that error through callers such as local_name_to_path();
>   - make v9fs_fix_path() return an error as well;
>   - and if a live fid path cannot be rebuilt during rename/fixup, clunk or
>     otherwise invalidate that fid immediately instead of leaving it
> reachable with invalid path state.

Yes, that's roughly what I had in mind as short-term mitigation. Additionally 
I would suggest calling error_report_once() somewhere, as it would be an 
unusual incident that should be logged.

> So this is not just a local check in v9fs_path_sprintf(), but also error
> propagation plus fid invalidation on fixup failure.

Right, unfortunately I don't see an easier way to address this. E.g. one might 
think to just add a max. path length check when creating a new file/dir, which 
would fix the reported vector, but then it could still be triggered by moving 
a dir into a subdir, and the moved dir could have a deep directory structure, 
so one simple path length check would not be sufficient.

/Christian



