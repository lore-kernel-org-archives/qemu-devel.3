Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4C4D1CDC1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 09:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Aqo-0003pK-O4; Tue, 22 Oct 2024 05:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@caoua.org>) id 1t3Aql-0003op-Ri
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 05:06:47 -0400
Received: from vm1.arverb.com ([185.82.219.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <alex@caoua.org>) id 1t3Aqi-00052U-TA
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 05:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=ijz/L6h5PCh7
 pte8z94C2cDIwgyY/1/aI5IRIex7RA4=;
 h=in-reply-to:references:subject:cc:
 to:from:date; d=caoua.org; b=Ig0i1xQYoIkccAJ5sdjHrxInKEvTOCswFFAlkx4w7
 88d6fP4NCMMsAU8IEE0Y5+k0QNu0hUj58EFULU5cqcjD6GCXB9OvFMK1tZDdmzd37R41E0
 nj0FZxSwg/IWLoqr+CT7vb8HDPhvH5fC1ikzp2c98HbSkgVP+AymF5x3Yer0=
Received: from localhost (vm1.arverb.com [local])
 by vm1.arverb.com (OpenSMTPD) with ESMTPA id 8d5b7c2a;
 Tue, 22 Oct 2024 11:06:39 +0200 (CEST)
Date: Tue, 22 Oct 2024 11:06:39 +0200
From: Alexandre Ratchov <alex@caoua.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Bandan Das <bsd@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Akihiko Odaki <akihiko.odaki@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>,
 Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: Re: [PULL 20/24] audio: Add sndio backend
Message-ID: <ZxdrH5Prk2bC2fw5@vm1.arverb.com>
References: <20220927081912.180983-1-kraxel@redhat.com>
 <20220927081912.180983-21-kraxel@redhat.com>
 <fc493743-5ab0-49eb-98ed-dd260f0f60d6@linaro.org>
 <ZuBXqSoohgbS-rF6@redhat.com> <ZuBeYjju389c8MoI@vm1.arverb.com>
 <87frq42d4i.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87frq42d4i.fsf@pond.sub.org>
Received-SPF: pass client-ip=185.82.219.62; envelope-from=alex@caoua.org;
 helo=vm1.arverb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 13, 2024 at 10:04:29AM +0200, Markus Armbruster wrote:
> Alexandre Ratchov <alex@caoua.org> writes:
> 
> > On Tue, Sep 10, 2024 at 03:28:57PM +0100, Daniel P. Berrangé wrote:
> >> > 
> >> > This is the single use of the ISC license in the more than 10k
> >> > files in the repository. Just checking IIUC this document:
> >> > https://www.gnu.org/licenses/quick-guide-gplv3.en.html
> >> > 
> >> > ISC -> LGPLv2.1 -> GPLv2 -> GPLv3
> >> > 
> >> > So ISC is compatible with GPLv2-or-later. Is that correct?
> >> 
> >> ISC is a permissive license that's semantically pretty much equivalent
> >> to either MIT or BSD 2 clause licenses and thus is broadly compatible
> >> with most other licenses, including the various GPL variants/versions.
> >> 
> >> None the less, since sndioaudio.c was a new file, it should have been
> >> submitted using the GPLv2+, unless there was a reason it needed to
> >> diverge and use ISC.
> >> 
> >> An example justification for divering is if the new code is derived
> >> from some non-QEMU source that was already ISC.
> >> 
> >
> > The ISC license is more permissive than GPLv2+ and compatible with it.
> > The file uses this license for history reasons: initial versions of it
> > used to be part of the OpenBSD ports repository, which uses ISC.
> >
> > If ISC is not appropriate for qemu, I agree to use GPLv2+ instead (I'm
> > the author this file).
> 
> Let's adjust the license then.  Alexandre, care to post the patch?
> 

Almost all audio backends (in the audio/ directory) have the same
header with a copy of the MIT license. So here's a patch to make
audiosndio.c also use this header. The "QEMU <insert_api_here> audio
driver" comment was also missing, so I've added it as well.

OK? better suggestions?

diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
index 8eb35e1e53..3922b73045 100644
--- a/audio/sndioaudio.c
+++ b/audio/sndioaudio.c
@@ -1,7 +1,25 @@
 /*
- * SPDX-License-Identifier: ISC
+ * QEMU sndio audio driver
  *
  * Copyright (c) 2019 Alexandre Ratchov <alex@caoua.org>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
  */
 
 /*

