Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CB4C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 10:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thnOl-00031C-LW; Tue, 11 Feb 2025 05:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1thnOk-00030q-5X
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 05:21:46 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1thnOh-0007Tf-TT
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 05:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=XSAZ/Z6r4BBrKnTjy7/Jl9xE8QN53SZku9kGRs4ilD4=; b=RmOum6PFzWO+N8PdvwoOcXTss3
 krzt0lb532OlufjrAoAEBOrpw8er9Z6N9JRixC241HVczt1j8/A/0OYoRzlAJ/lds+s9wfsjuFXdz
 q68NiHvIOeio8vzNx/+EoOsi/mkpQ+p8QZofo9hB/+KVpUle660uUyz4PEyUrcDuR/csxKsd+tfOH
 vHGL/0CvWxRemQWQI4B4Vf+/HId6Rn8qQ2Fpxeh0QFRP7VtvmugbB25MWxS6qgY89JHfHqzHZY/z/
 rmKEOW+6tvmSb4gKuutIvS/299E6uh0SNuWY7CA7eHMG6+CLF3ve5ka8oqd3dIBEvHdV3hs/KZFvn
 UK10qY1OpPjqPUB4DLlEWaFzCUCj+I9ceNeyaRtDyZmrZXziDVklVBb6kSqyGZJBisyPUf53HY33O
 iuGZJ1vthka64KevNR/Ev0OlsbY7n3SSX1pTJXl7kFjSVf1diLD+1nbtYnimFXYH/hocqe0Oe+F0O
 m2YTsFyWrNoZicGngLI7V8ANu6gAoWfl+xDM3OaUH6Wli783T8hbSEEdV+Ul6u68Gy/KbGDs3rv7H
 Gpb0qfOFlP3SA6mf0exZktLYFJVOEPSpwJYaL2ces4N4J2rvtkafe0RL/2VdQZbrGl/Io2kn9UcDM
 2B3EDcY2jiNS5Ykl6DJKNLvhWWJO6EP+82nzSqje8=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH] 9pfs: fix dead code in qemu_open_flags_tostr()
Date: Tue, 11 Feb 2025 11:21:34 +0100
Message-ID: <18703295.KUYhaFHJxC@silver>
In-Reply-To: <2cfca5f9-4c2f-4777-bfb9-4700005780ec@linaro.org>
References: <E1thUwq-0020ux-5f@kylie.crudebyte.com>
 <2cfca5f9-4c2f-4777-bfb9-4700005780ec@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
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

On Monday, February 10, 2025 4:32:08 PM CET Philippe Mathieu-Daud=E9 wrote:
> On 10/2/25 15:33, Christian Schoenebeck wrote:
> > Coverity scan complained about expression "|LARGEFILE" to be non reacha=
ble
> > and the detailed Coverity report claims O_LARGEFILE was zero. I can't
> > reproduce this here, but I assume that means there are at least some
> > system(s) which define O_LARGEFILE as zero.
>=20
> Is O_LARGEFILE a Linux-ism?

Ah right, O_LARGEFILE is indeed Linux-specific, not POSIX.

> Commit 67b915a5dd5 ("win32 port (initial patch by kazu)") started to
> define it to 0 on 32-bit Windows. It isn't defined on my 64-bit Darwin,
> and apparently nor on other BSDs.

Yeah, that explains why O_LARGEFILE was defined as zero. I'll adjust the=20
commit log message at least on my end. The code change itself is appropriat=
e.

Thanks!

/Christian

> > This is not really an issue, but to silence this Coverity warning, add a
> > preprocessor wrapper that checks for O_LARGEFILE being non-zero for this
> > overall expression. The 'defined(O_LARGEFILE)' check is not necessary,
> > but it makes it more clear that we really want to check for the value of
> > O_LARGEFILE, not just whether the macro was defined.
> >=20
> > Fixes: 9a0dd4b3
> > Resolves: Coverity CID 1591178
> > Reported-by: Coverity Scan
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> >   hw/9pfs/9p-util-generic.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >=20
> > diff --git a/hw/9pfs/9p-util-generic.c b/hw/9pfs/9p-util-generic.c
> > index 4c1e9c887d..02e359f17b 100644
> > --- a/hw/9pfs/9p-util-generic.c
> > +++ b/hw/9pfs/9p-util-generic.c
> > @@ -19,7 +19,9 @@ char *qemu_open_flags_tostr(int flags)
> >           #ifdef O_DIRECT
> >           (flags & O_DIRECT) ? "|DIRECT" : "",
> >           #endif
> > +        #if defined(O_LARGEFILE) && O_LARGEFILE !=3D 0
> >           (flags & O_LARGEFILE) ? "|LARGEFILE" : "",
> > +        #endif
> >           (flags & O_DIRECTORY) ? "|DIRECTORY" : "",
> >           (flags & O_NOFOLLOW) ? "|NOFOLLOW" : "",
> >           #ifdef O_NOATIME
>=20
>=20
>=20



