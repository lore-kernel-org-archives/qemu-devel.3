Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B9DC55AB9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 12:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtPB0-0005qy-22; Fri, 20 Feb 2026 07:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vtPAv-0005py-H0
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 07:00:01 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vtPAu-0002Eu-1U
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 07:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=4BFUBwsqWNDWl2ndJ1+uZvSL2SBVqbn88ZrknH3fK7c=; b=LwVDu0d+Fw0o3OExI+XOhsao9D
 4GgBD/kuw4yM8zn3dAw6W/69vN/PgmwlKNUFD7+HGGhmVy4AS3ev05lmf5S6N2M2ct/Q9oTpZXzkX
 uGkvj0M3GrkFuqyvkSUKU3pP3k9YPD8lCL+j8MqTv+4xMgEONLekwshkfa/uTBbyYKurLZa2WpavM
 IYX56MpHAUkUpfSwnd4Hs+WQB2Znh6HzTT6cZ0ykpVlAVDPNcG7HsBXtKBLFryCAZF+i946/9D92V
 MK6AzucxEdoW/5nfp+KJXMJEmN4kW8RiZytuWBd1Sa+WPEEXIgCbNT+TLqca24Z4EXt3I0SSK574i
 BEKRVUga3b9nplZSA73w2HO4Lh7n8lF3sHzjciltMVWKfupJBQJEfyzb/Es/VNq2ZopNXPq0In09S
 eB7bhYcVbOaBB3Argyq+fqBCrsR0bB+AAb0ZB9PnC8uJm3pOBNX5PSJncdHXDyY7GDJeb6iTNx/KY
 rK50m7+hCNwyQaSfcbUimWcQ/rAL9/kOausY8q0lyq1KoweOWoAxZ81KcSDlEe+DbGmMkor9GRvjy
 zQsITgrx7Ddh4QxRvUBcb9nq0BQH6QJjUe4+AFy6HjmJ784lJ144HHX6o6l78P1EVDWT1S2cJ4IRm
 Ut4AWf5bbvwZoMnUInkSEuvFNlB6NbeXInWCsVK7c=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Oliver Chang <ochang@google.com>, Alexander Bulekov <alxndr@bu.edu>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] hw/9pfs: fix missing EOPNOTSUPP on Twstat and Trenameat
 for fs synth driver
Date: Fri, 20 Feb 2026 12:59:55 +0100
Message-ID: <12840699.O9o76ZdvQC@weasel>
In-Reply-To: <E1vrbaP-000Gqb-B3@kylie.crudebyte.com>
References: <E1vrbaP-000Gqb-B3@kylie.crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sunday, 15 February 2026 13:44:50 CET Christian Schoenebeck wrote:
> Renaming files/dirs is only supported by path-based fs drivers. EOPNOTSUPP
> should be returned on any renaming attempt for not path-based fs drivers.
> This was already the case for 9p "Trename" request type. However for 9p
> request types "Trenameat" and "Twstat" this was yet missing.
> 
> So fix this by checking in Twstat and Trenameat request handlers whether
> the fs driver in use is really path based, if not return EOPNOTSUPP and
> abort further handling of the request.
> 
> This fixes a crash with the 9p "synth" fs driver which is not path-based.
> 
> The crash happened because the synth driver stores and expects a raw
> V9fsSynthNode pointer instead of a C-string on V9fsPath.data. So the
> C-string delivered by 9p server to synth fs driver was incorrectly
> casted to a V9fsSynthNode pointer, eventually causing a segfault.
> 
> Reported-by: Oliver Chang <ochang@google.com>
> Fixes: https://issues.oss-fuzz.com/issues/477990727
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3298
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/9p.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

/Christian



