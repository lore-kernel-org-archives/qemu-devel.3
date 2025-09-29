Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0EACAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 14:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3F62-0004mw-CQ; Mon, 29 Sep 2025 10:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linux_oss@crudebyte.com>)
 id 1v3DbR-0004KH-5p
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 09:07:41 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linux_oss@crudebyte.com>)
 id 1v3DbI-0002ME-5z
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 09:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=U6p5OzRV8NVMjy5kzKrrKHfil5LPBKG7T0tsPVsqnzI=; b=UVEYZsJ0K538ZWZ1EieZNxfF9H
 p+8GxHeSHMULkws3bfrOst6rZyz24n7Bsvxd1g0QjwcQK4d9pHRxi/DcwrPmmIuMfD2Zi0mDoerQl
 zH3AcfJbwSwiC1lTYEo5vwaPMduW1hwwPpeuzOlPxCdwYbtkUzOvlak6prs/hWO/UsBSToUyVX3hx
 qFLivs3RCU77K/x3J7wqJYAqAAJQmN9zuSVm7RvEdlbGF9ie3EF3S8/fKGUXJ3cVuXNM2OxuMMBX9
 bzLjSfeUKIhlGubBYvtJRf0x7t/k0IeQPJGWBtvrbb20jHJCLv9qaLVMNuT5gD/WFQbPeGGMvbYGL
 dz2q7R7oo2aDRtjWaG2NBpJMw6EwGlyLPcf9tcH25wRdmSgUkEZ8oGLko38a+cnP7QtaG9g2sbduA
 Wl/dMvFvfkmKk9lcMJrDdT7ZuTZTEt0z6g08CuAeO2iOXw2SKDhLNSImw/d2PmyXhULgmvn82BAF1
 OnqtL0B8MJ0JEorALvE3QasTNEdA+ScfVGEGt2xw4GuSN7UNUN70guHROG/dMfXbhGZ7I+SCSr9ai
 812H/aXsDoOQhXpOLVVKpKhqSs1IxYwXJwps85bQFCJ9AlUiGmUU2owkl8P2iB3zBfu8Om4bKmNt8
 ZoLVN8UxciL1w24c6DNUhQw20CnUvQg3toB4BlYB0=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
 Dominique Martinet <asmadeus@codewreck.org>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
 =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
 linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
 Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to
 qid)
Date: Mon, 29 Sep 2025 15:06:59 +0200
Message-ID: <3061192.c3ltI2prpg@silver>
In-Reply-To: <f1228978-dac0-4d1a-a820-5ac9562675d0@maowtm.org>
References: <aMih5XYYrpP559de@codewreck.org>
 <20250917.Eip1ahj6neij@digikod.net>
 <f1228978-dac0-4d1a-a820-5ac9562675d0@maowtm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=linux_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 29 Sep 2025 10:43:14 -0400
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

On Sunday, September 21, 2025 6:24:49 PM CEST Tingmao Wang wrote:
> On 9/17/25 16:00, Micka=EBl Sala=FCn wrote:
[...]

Hi Greg,

I'd appreciate comments from your side as well, as you are much on longer on
the QEMU 9p front than me.

I know you won't have the time to read up on the entire thread so I try to
summarize: basically this is yet another user-after-unlink issue, this time=
 on
directories instead of files.

> So I did some quick debugging and realized that I had a wrong
> understanding of how fids relates to opened files on the host, under QEMU.
> It turns out that in QEMU's 9p server implementation, a fid does not
> actually correspond to any opened file descriptors - it merely represents
> a (string-based) path that QEMU stores internally.  It only opens the
> actual file if the client actually does an T(l)open, which is in fact
> separate from acquiring the fid with T(l)walk.  The reason why renaming
> file/dirs from the client doesn't break those fids is because QEMU will
> actually fix those paths when a rename request is processed - c.f.
> v9fs_fix_fid_paths [1].

Correct, that's based on what the 9p protocols define: a FID does not exact=
ly
translate to what a file handle is on a local system. Even after acquiring a
new FID by sending a Twalk request, subsequently client would still need to
send a Topen for server to actually open that file/directory.

And yes, QEMU's 9p server "fixes" the path string of a FID if it was moved
upon client request. If the move happened on host side, outside of server's
knowledge, then this won't happen ATM and hence it would break your use
case.

> It turns out that even if a guest process opens the file with O_PATH, that
> file descriptor does not cause an actual Topen, and therefore QEMU does
> not open the file on the host, and later on reopening that fd with another
> mode (via e.g. open("/proc/self/fd/...", O_RDONLY)) will fail if the file
> has moved on the host without QEMU's knowledge.  Also, openat will fail if
> provided with a dir fd that "points" to a moved directory, regardless of
> whether the fd is opened with O_PATH or not, since path walk in QEMU is
> completely string-based and does not actually issue openat on the host fs
> [2].

I don't think the problem here is the string based walk per se, but rather
that the string based walk always starts from the export root:

https://github.com/qemu/qemu/blob/4975b64efb5aa4248cbc3760312bbe08d6e71638/=
hw/9pfs/9p-local.c#L64

I guess that's something that could be changed in QEMU such that the walk
starts from FID's fs point, as the code already uses openat() to walk relat=
ive
to a file descriptor (for security reasons actually), Greg?

That alone would still not fix your use case though: things being moved on
host side. For this to work, it would require to already have a fd open on
host for the FID. This could be done by server for each FID as you suggeste=
d,
or it could be done by client by opening the FID.

Also keep in mind: once the open file descriptor limit on host is exhausted,
QEMU is forced to close older open file desciptors to keep the QEMU process
alive. So this might still break what you are trying to achieve there.

Having said that, I wonder whether it'd be simpler for server to track for
file tree changes (inotify API) and fix the pathes accordingly for host
side changes as well?

/Christian



