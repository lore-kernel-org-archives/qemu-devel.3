Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D2FC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 14:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts0RZ-0008CN-P8; Tue, 11 Mar 2025 10:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1ts0RY-0008C2-Br
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 10:18:52 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1ts0RW-0008Eo-EY
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 10:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Cc:
 Content-ID:Content-Description;
 bh=CxCJJgOfxri66j4X5Q2SjIIOJ5ILXyIW0cQVvLReOM0=; b=bcoBwpGBDqZNLi+Gjv6qtFPfb5
 QuJPDs/CgWYJzCeFP8Rgypk11d1BFORoQDNS9RE/rC6P2f3M5mgi0vRJ/RV+Q4GA+0xw7R4OzZQCU
 Yrem3axmGYaqhMpFIK+226fD5W0nrtAs1ZCbwdUEaUtpFsj4R2HI00OMKbxW+CQsEZZ01f61HH7B/
 q6ljgsPfOzMC4WAsmq1fNqZzb7eLMsjLJf8rqG9opC7hQ2oWyeJy6q+HzbL0sGoclF17DWDstI+xh
 abBRqu/PauTv7b7GP/ay8VcPdP9orajtplGjKPiir1L6Scci2YWVBty22Wxkq54O2dnyUMKad6Pme
 8wB1pZkkUEc81tuIYiVYEUtnYE5YHV0/mTV+NjeMlTPy3dthZ7uq3dSalsEUEWJ7C9iFmSVrPteJu
 Ow6+DIE9k2n5lIxj85qPEYIAIfviPo0uDChWm25VjzxJVX3dudC2EEZr6gvWlImv87EKphxzOcMf3
 mLiFA0h3n12C6BUWR2wqg6AWOUQUOkkaSgigTlOOK+k4/5/VWHGYR89z/x4y66vi5Phnm9tGDJlQr
 Q0toUiNgL9nMF8jkdrE7gcCcEvhaA8gDT7wPUwdZR5nDuX6KtfVu3taNrAEmhH9qwHoHtq0UzJ+PI
 1GFd9MHdXzaBO2iwoORNWKU4JS5tOc2ygS0qfevFA=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 2/4] 9pfs: Don't use file descriptors in core code
Date: Tue, 11 Mar 2025 15:18:45 +0100
Message-ID: <3577848.jiUZ1Cz8uQ@silver>
In-Reply-To: <20250311150313.5e3a7e52@bahia>
References: <20250310171101.138380-1-groug@kaod.org>
 <5513162.Wvc2JcUQ7O@silver> <20250311150313.5e3a7e52@bahia>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=0.413, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tuesday, March 11, 2025 3:03:13 PM CET Greg Kurz wrote:
> On Tue, 11 Mar 2025 12:13:06 +0100
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> 
> > On Monday, March 10, 2025 6:10:59 PM CET Greg Kurz wrote:
[...]
> > Follow-up on previous patch, this could be reduced to:
> > 
> > static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
> > {
> >     if (fid_type == P9_FID_DIR && fs->dir.stream != NULL) {
> >         return dirfd(fs->dir.stream);
> >     } else if (fid_type == P9_FID_FILE) {
> >         return fs->fd;
> >     }
> >     return -1; /* POSIX invalid file handle */
> > }
> > 
> > or even:
> > 
> > static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
> > {
> >     return (fid_type == P9_FID_DIR && fs->dir.stream != NULL) ?
> >                dirfd(fs->dir.stream) :
> >                    (fid_type == P9_FID_FILE) ? fs->fd :
> >                        -1; /* POSIX invalid file handle */
> > }
> > 
> 
> Yuck, I'll stick to the `if` version ;-)
> 
> No sure to understand the meaning of `/* POSIX invalid file handle */` though...

"invalid file descriptor" rather than "invalid file handle". What I mean is
that outside of the Unix world -1 is not necessarily the predefined and
reserved value for "invalid file descriptor".

But no big deal.

/Christian



