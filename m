Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68482D3943A
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 15:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8K35-0003la-Dh; Thu, 02 Apr 2026 11:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w8K2z-0003kp-RQ; Thu, 02 Apr 2026 11:33:30 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w8K2y-0008TP-8F; Thu, 02 Apr 2026 11:33:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1775143968; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iUlCJwvz4jfTAnK089W05ufBh+ng18Fjba14SFCXmGpr1P3shcg4mP7hssTeZXDZaf7RP0ExmTXaLbz+s/wuTS165kgLLaOpKbblJnlgQQvWGCAWBklFAmzAfqzO+NUInmzcCi+evUIy65yaDUP3wsOm/QJfrkQwzqLgo9EJQiE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775143968;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=XSTNriXCZzrVpa/vUtkXKE3tPoQ9sm52NLHe7sIBtTs=; 
 b=XphmfPnuAZEVNApCM6iUN9vF2/euNuTPBuI2kE1GVj4nixR5loaPom+JPWBvE4I1mx85T+TNHc7x0f/jgrVRCzAMFsYMf8rZIX6z4XxYDHKW0turEX38o16MP8ROnBrSNmgsYhbhRt4bH6iGfzQmIHnp+cWKLgym5ylxV4XumWI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775143968; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=XSTNriXCZzrVpa/vUtkXKE3tPoQ9sm52NLHe7sIBtTs=;
 b=Nbqgelo1k7UjBKH6rd7XfCs6N/0bhABi6eTkR/cqhdMdtRlAhYj+O9V7YTkVBD6z
 ZhDPWtZHBuMJVT8l/7ClcqKdfCt96wL/eHlfOiTnHxNCQ/ej2BAuAx6E8BSIonop/3i
 sjbAcYBKoB+5w0rqqeb8IDPU0aqITFY6Jc82yQ3Q=
Received: by mx.zohomail.com with SMTPS id 1775143964040451.5148707301264;
 Thu, 2 Apr 2026 08:32:44 -0700 (PDT)
Date: Thu, 2 Apr 2026 15:32:37 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-devel@nongnu.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?=22Daniel_P=2E_Berrang=E9=22?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: Re: [PATCH v2 06/14] accel/mshv: add arch-specific accelerator init
 hook
Message-ID: <20260402-wealthy-limpet-of-vitality-ffb7d8@anirudhrb>
References: <20260402-mshv_accel_arm64_supp-v2-0-754895c15e9e@linux.microsoft.com>
 <20260402-mshv_accel_arm64_supp-v2-6-754895c15e9e@linux.microsoft.com>
 <BA3D9272-4972-4922-B6C2-26306FE19139@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BA3D9272-4972-4922-B6C2-26306FE19139@unpredictable.fr>
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.54;
 envelope-from=anirudh@anirudhrb.com; helo=sender4-of-o54.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 02, 2026 at 04:26:08PM +0200, Mohamed Mediouni wrote:
> 
> 
> > +/*
> > + * Default Microsoft Hypervisor behavior for unimplemented MSR is to send a
> > + * fault to the guest if it tries to access it. It is possible to override
> > + * this behavior with a more suitable option i.e., ignore writes from the guest
> > + * and return zero in attempt to read unimplemented.
> > + */
> 
> Hi,
> 
> Is that desirable behaviour on arm64? I think it’s better to _not_
> do this there.

This is not for arm64. This is *existing* x86 code being moved to an
arch-specific directory.

Thanks,
Anirudh.


