Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55469E74AC3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 18:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIY2Y-0004BU-09; Tue, 03 Dec 2024 13:54:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIY2I-00049D-Pn
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:54:16 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIY2F-00014S-UJ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=cEB1PDmY5RYSSsabqHrHtSNULaAQVd4CqyH2gctk1Hk=; b=pBtcYSj8oyZoc6f
 gziW0Mq1fzJ32Vh/eH/RYW6bUJ+m+TpQjw7lzlJ4VCgcx9l9R6sXwyngdFUocWWPoNSIEFIyLCefk
 Om94uEbKQPr6r0wPcrbn6kI4EYJLCw/pWuUTJhgGUO6onqeWu+8TrthrnXpup3v4a87oK+ffYWoFU
 SI=;
Date: Tue, 3 Dec 2024 19:57:10 +0100
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, alex.bennee@linaro.org
Subject: Re: [RFC PATCH v1 37/43] target/hexagon: Make HVX vector args.
 restrict *
Message-ID: <baawemaxxlh7kjecgw6zi6b6lk4i6m3ckq62teao6bctcoblzx@ncy5pot3loed>
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-38-anjo@rev.ng>
 <30a70eef-01ac-46a2-8e34-458c579dcf27@linaro.org>
 <689a4c48-af1f-44b1-9575-56c75ec0b830@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <689a4c48-af1f-44b1-9575-56c75ec0b830@redhat.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 25/11/24, Paolo Bonzini wrote:
> On 11/25/24 12:36, Philippe Mathieu-Daudé wrote:
> > > +#define QeV      (*(MMQReg * restrict)(QeV_void))
> > > +#define QdV      (*(MMQReg * restrict)(QdV_void))
> > > +#define QsV      (*(MMQReg * restrict)(QsV_void))
> > > +#define QtV      (*(MMQReg * restrict)(QtV_void))
> > > +#define QuV      (*(MMQReg * restrict)(QuV_void))
> > > +#define QvV      (*(MMQReg * restrict)(QvV_void))
> > > +#define QxV      (*(MMQReg * restrict)(QxV_void))
> > >   #endif
> > 
> > Maybe we need to fix scripts/checkpatch.pl along?
> > 
> > ERROR: "foo * bar" should be "foo *bar"
> > #31: FILE: target/hexagon/mmvec/macros.h:26:
> > +#define VdV      (*(MMVector * restrict)(VdV_void))
> > 
> > ERROR: "foo * bar" should be "foo *bar"
> > #32: FILE: target/hexagon/mmvec/macros.h:27:
> > +#define VsV      (*(MMVector * restrict)(VsV_void))
> > 
> > ERROR: "foo * bar" should be "foo *bar"
> > #33: FILE: target/hexagon/mmvec/macros.h:28:
> > +#define VuV      (*(MMVector * restrict)(VuV_void))
> 
> I think checkpatch.pl has a point here. :)

I'll switch to `*restrict`!:)

//Anton

