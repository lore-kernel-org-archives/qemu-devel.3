Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AA5C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkjeT-0004Gy-Ee; Fri, 17 Jul 2026 10:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wkjeR-0004Bo-DC; Fri, 17 Jul 2026 10:34:55 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wkjeP-0000Mu-Tp; Fri, 17 Jul 2026 10:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=fCR4Ej30kZnIWYTu6hogT0vRM7wz0nUYWrnbtJpifb4=; b=pMvJn3w9YcEA453O7TZIDkHwro
 sqprX+AciKnFfdvWM5tM6mxtW374aYrWJ2mqNBLG+/S5xrf9b91ZPu231uYtspDfgx1w/odSc5+P+
 f5Go9h4w3OigclDZYuLK4Tzj7qdhfxepozy9GTDlvq6Z6Cd62VcHHrD7MeYRstSXTCF06Zg2XILMi
 XX/egA6mjmCGgt7/qiprBpnpRXzPUHjhz2vxdaSBEpawP2+pBZWbECQjhiJCuR8U4qSvaDje5SGcP
 7YB6Ye0/RDP5Lnf78S37PMVo72e7OWfd+jVWgn4RSRhcjtYLARiPkB9pMCEZI+jrGVpVP5UiP+gB9
 lPxnymwopMFL2FzGSHmacRP4fMgUdJ+VGz59sr5hPhSLv2RNOklPVY4g1sgJkl9om5Z5Dyo497QWf
 kjv4EtXHNdPm+OMbOMe8ZHPq+MSIacld8XnWoM4dnELt6Ph+glwM1ipgmjnD2a7XcWYuc4G8XQCGV
 R9EnspeEV1HiN7MRFXMh77x48bhzK+9nsx/PN3G7Iwle2/T2cu8us6/eP7tlhWAt/O4VZKVckcMxP
 MivYDzpmLI7/9YbyKOwZpTmtbVoDcgstQW1RqFRRt15zz46tt1OSiBxmNhmWWb7YqbeZbRG4avBVT
 0GDUqi90Z0Tm+uK3TXqoFyuJsznd1E8LdVd/pHYog=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Daniel =?UTF-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] hw/9pfs: fix O_TRUNC bypass on read-only export
Date: Fri, 17 Jul 2026 16:34:51 +0200
Message-ID: <2010370.taCxCBeP46@weasel>
In-Reply-To: <E1wk2Dq-0019kY-JK@kylie.crudebyte.com>
References: <E1wk2Dq-0019kY-JK@kylie.crudebyte.com>
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

On Wednesday, 15 July 2026 18:10:00 CEST Christian Schoenebeck wrote:
> Guest 9p client opening a file with O_TRUNC on a read-only 9p file
> system using 9p2000.u protocol version, allowed to bypass 9p
> server's read-only check, eventually causing file(s) being
> truncated to empty file(s) on host's read-only export.
> 
> Root cause is that 9p server's read-only check is using Linux open
> flags like O_WRONLY, O_RDWR, O_TRUNC, but checking them against
> the 9p Topen request's "mode" parameter, which has a different
> encoding (Otrunc = 0x10 vs. O_TRUNC = 0x200).
> 
> Fix this by checking against the "flags" variable instead of the
> protocol's "mode" option. Because the "flags" variable is already
> converted to Linux encoding by omode_to_uflags() for 9p2000.u and
> by get_dotl_openflags() for 9p2000.L protocol version.
> 
> Only 9p2000.u was affected by this bypass, 9p2000.L uses the Linux
> format on protocol level already.
> 
> Fixes: 2c74c2cb4b ("hw/9pfs: Read-only support for 9p export")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4000
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

/Christian



