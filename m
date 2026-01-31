Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30547E6BF3C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 01:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlzvY-0008Kn-4a; Fri, 30 Jan 2026 20:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1vlzvS-0008Io-3C; Fri, 30 Jan 2026 20:37:27 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1vlzvQ-00040C-BE; Fri, 30 Jan 2026 20:37:25 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5FD2D444CC;
 Sat, 31 Jan 2026 01:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A537AC116C6;
 Sat, 31 Jan 2026 01:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769823434;
 bh=77T/rAl/wGg+8sXS8H6I24fjyvvoz2/jHrze4SaVL2g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MW/42cY17MLvRaOIMYVtIRfgeViblt2f6vOxsHfcJF5bm/a/deBMKgpoJ1KKXHSIf
 6PWEu+nS2r5epBdixRWGIJ4lcxZF+9gWxyYg0CZ9lJOvSM6ZaipEI+INLv9mY1jbWA
 vHVu0mTC5N9O85QelpHo3sEQanfw6e+PQ5Bukv5KkpsmiiqmDEyz+SSGHijIG5gfvC
 VNe25+NFCUWupo65OrMyfRFhtwKJoK+83yvdnKhL4cz1pefw5dW0gXhZ7x3OVvhpfo
 QhZ6ukL5TiUZWR/MS9fhg8Qo70eoG7ONwn/0SZV9LDRDEGINnUDq5P3aR0Tr4vMEFa
 AOto+/lnv4+eA==
Date: Fri, 30 Jan 2026 18:37:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: Re: [PATCH 5/5] hw/nvme: Fix bootindex suffix use-after-free
Message-ID: <aX1cx3mR-s4pKdDP@kbusch-mbp>
References: <20260125-nvme-v1-0-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
 <20260125-nvme-v1-5-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
 <d74ef37a-b423-457a-b2c1-31989243b1a8@linaro.org>
 <aXpUD4s7LrC9-AMa@AALNPWKJENSEN.aal.scsc.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXpUD4s7LrC9-AMa@AALNPWKJENSEN.aal.scsc.local>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=kbusch@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Jan 28, 2026 at 10:23:11AM -0800, Klaus Jensen wrote:
> On Jan 25 17:56, Philippe Mathieu-Daudé wrote:
> > On 25/1/26 07:42, Akihiko Odaki wrote:
> > > The bootindex suffix can be used as long as the property is alive.
> > 
> > True, so:
> > 
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > 
> > But maybe it shouldn't (we should g_strdup it like other QOM fields).
> > 
> 
> Do you mean that device_add_bootindex_property() should g_strdup the
> suffix? And then free it in property_release_bootindex()? That would
> make sense to me.

Doesn't it already do that? 

  device_add_bootindex_property
    object_property_add
      object_property_try_add
        g_strdup

?

