Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D51BD0EE14
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 19:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNylX-0004Q7-Ue; Tue, 25 Nov 2025 14:31:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vNylV-0004Lb-G8
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 14:31:53 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vNylT-0004Fy-KV
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 14:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=mw+OjuDq+JBedNWeZB9RUJCNwJyGm63p6i8VVJ5DXaY=; b=Y7G41XijingiWOyZk+hptmY5kT
 0us03kByNLYnK61hL6/vmlqaBdRUddOt8dgHS2J2/sNRFl3XqjLw3vtEWELdblhOVMOsyoDejRJOS
 +K7kOrocJs7rYhBL4kWlyuTrii35yamivWn2QqoOqUOA1O9ZFhH53dZ3731liPSLBANgAzkxbIae9
 tJn8HgdDnm5kl2BPHx0IWTqyaKrzGCeCU31TnAt3aftY3jXLW7vGAoVNHf1bZ/L3xxw5eYN+0W12D
 rvd37SrmIxz59SqI0vTJz8K3+RDR7VwByiG8sg091p89PrT8K8oMDiBKf2NwHLerimKBj12TMVUPp
 i2kmTPASaCnIZdviq2rdS3gksG+ouJTQ2krG87GQ6BXvz4zMdLb1x+XMMg8hy9ObJJgaArr5JqFle
 UxQCkF1jnUy2hP78C0R/gR/hCNYxKxltJFMDsD0c89pEMePpRT5AA9T2/3tufPwPY1pROm+SMkuib
 9/TvnfFN4SUO1Dm84HFYI8tQyAWYYOnTPJVB53OF/1q3CmfLKCQPIhWTRtLUdmcBCpaYnobD0bYSN
 /4po5JBW/TPZpOTff8Ey2vRsAy/Urgl/JlKonv7y3ka29h97s8m2WaMVX2dvImuwqRvnVqiBQH6AS
 XSLYq/OkSI2KHhxKLnVg0h3/XHxWZlWD1P3JHrNZs=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Andrey Erokhin <language.lawyer@gmail.com>, Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] 9pfs: local: read native symlinks when
 security-model=mapped
Date: Tue, 25 Nov 2025 20:31:32 +0100
Message-ID: <13893778.uLZWGnKmhe@weasel>
In-Reply-To: <20251125195819.5bf1e051@bahia>
References: <3c35955d-a57e-4203-81c5-395146e23f83@gmail.com>
 <c9461c73-fbda-4963-b96c-3fd4b2d6ce41@gmail.com>
 <20251125195819.5bf1e051@bahia>
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

On Tuesday, 25 November 2025 19:58:19 CET Greg Kurz wrote:
> On Tue, 25 Nov 2025 19:21:00 +0500
> 
> Andrey Erokhin <language.lawyer@gmail.com> wrote:
> > >> +    native_symlink:;
> > > 
> > > Still has the terminating but unneeded semicolon
> > 
> > I think I've addressed this in the v1 thread, with links to the C11 draft
> > grammar. Can repeat in plain English: a label shall be followed by a
> > statement. (No, declaration is not a statement)
> My bad, I didn't see your answer.
> 
> It is funny that I had to pass -pedantic to gcc to get a complaint (in plain
> English as well) if I drop the semicolon :
> 
> warning: a label can only be part of a statement and a declaration is not a
> statement [-Wpedantic]
> 
> Cheers,

Yes, I noticed that as well. GCC compiles fine without the semicolon, clang 
OTOH errors:

../hw/9pfs/9p-local.c:481:9: error: expected expression
        char *dirpath = g_path_get_dirname(fs_path->data);
        ^

Anyway, Andrey is right of course. The C standard defines a "labeled-
statement" as

  identifier : statement
  ...

and the subsequent line in the patch is a declaration, not a statement.

But I also understand if GCC developers relaxed this rule. Because it "feels" 
like both, a declaration and a statement. Interesting, because usually it's 
clang to be more relaxed than GCC.

/Christian



