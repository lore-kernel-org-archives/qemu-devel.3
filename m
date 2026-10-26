Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F8A606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=bqQNRPtD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLPj1-0000hk-MF; Mon, 26 Oct 2026 14:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <maximilian.immanuel.brandtner@protonmail.com>)
 id 1xLOzx-0006k5-Nn
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 14:00:41 -0400
Received: from mail-07.mail-europe.com ([37.187.220.204])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <maximilian.immanuel.brandtner@protonmail.com>)
 id 1xLOzw-0003ve-3R
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 14:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1793037628; x=1793296828;
 bh=+0mO2gVS7U19ZiSXju+aQrvEFEWHyTv9rSEuhavERL8=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=bqQNRPtDdd2ENWylorWby/apR8dL0zKKpwaX7Yv1Qx8fzNDopZm2e3/qv+2GVxkOY
 E4n/oz8bl2Mm5riz82pNLalwdAiqLBTsD+ukvl//eB5NfB0PYQGZOmVCYa6BdcYLH3
 D1sw9LIT91aVbPqCksvf/OLANy7MHG1SUCELa9ssQjL8G9BcfZ7at3EQ+kSNkBcfbR
 eOYVqzDvPGZ0NwC3UMLAaARkc7oWkhOLOdXCRvsOvA/emE2urNMhi8TTFPbHu+T7Cd
 EY80aVX3YtLKXdloviQ0/OEv0eGXwDpVJLXPbkyj7dosHtytlzdmQ6pzKSClVF1/Te
 EXlPlEoeyPr0A==
Date: Mon, 26 Oct 2026 18:00:22 +0000
To: farman@linux.ibm.com
From: Max Brandtner <maximilian.immanuel.brandtner@protonmail.com>
Cc: cohuck@redhat.com, jjherne@linux.ibm.com, maxbr@linux.ibm.com,
 mjrosato@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [PULL 3/6] s390x/sclpconsole: implement resizing for vt220
 consoles
Message-ID: <20261026175948.2115056-1-maximilian.immanuel.brandtner@protonmail.com>
Feedback-ID: 42508046:user:proton
X-Pm-Message-ID: 701fd4d9976502ca7a97b1afb0a3499b4a99e443
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=37.187.220.204;
 envelope-from=maximilian.immanuel.brandtner@protonmail.com;
 helo=mail-07.mail-europe.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) AC_FROM_MANY_DOTS=1.123, BAYES_00=-1.9,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 26 Oct 2026 14:46:48 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Could you add this mail to CC? Thanks.

Kind regards,
Max Brandtner


