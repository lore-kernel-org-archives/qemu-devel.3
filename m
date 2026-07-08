Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08E1C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 18:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whWxk-0000Bs-Cg; Wed, 08 Jul 2026 14:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anbelski@linux.microsoft.com>)
 id 1whWxb-0000B4-NW
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 14:25:28 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anbelski@linux.microsoft.com>) id 1whWxY-0004M1-W2
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 14:25:27 -0400
Received: from frill.fritz.box (p5dd8f10f.dip0.t-ipconnect.de [93.216.241.15])
 by linux.microsoft.com (Postfix) with ESMTPSA id 37F0720B716B;
 Wed,  8 Jul 2026 11:25:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 37F0720B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1783535117;
 bh=UCSfGCrhOxL4rVve/PBCKkZjJZbtyfKEs5yidHbZuws=;
 h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References:From;
 b=lO1oHmHnFUwr3mPY/TmTg2QAZxg4fEfL6vzYEb80enkHQceNbk8ZiJm23PkyVF1c0
 E2bJRvNnosFXziO3PiHOWnLFJIr/yeG8319Co0ByT6Q//oEzRZuKHZNQwBJOZTxn8Q
 1O8r6RpxF5HDkX3UvwXp/V03dRpR3ioeYCCIIrug=
Message-ID: <068f20b5ff9e0ab58706c0f2260292c9fa63c471.camel@linux.microsoft.com>
Subject: Re: [RFC] virtio-villain: Guest fault injection for VMM robustness
From: Anatol Belski <anbelski@linux.microsoft.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Date: Wed, 08 Jul 2026 20:25:19 +0200
In-Reply-To: <ak4Fxt989xkWfgwD@redhat.com>
References: <98dd26094403c204c7c2f0270d96b9c75842c7d8.camel@linux.microsoft.com>
 <aktl-ojkXVZ4Jira@redhat.com>
 <a2a7bb2e20d954689a638b8a27b7fb95de156667.camel@linux.microsoft.com>
 <akzXblNvD5s4QGgB@redhat.com>
 <861020196095d6d91a83b878a1ed744b2824d159.camel@linux.microsoft.com>
 <ak4Fxt989xkWfgwD@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=anbelski@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-To: anbelski@linux.microsoft.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 2026-07-08 at 09:09 +0100, Daniel P. Berrang=C3=A9 wrote:


> Yes, I think it'd be interesting to try to fit them directly into a
> functional test script. I guess having the virtio-villain repo as a
> git submodule would probably be the way to go to access the
> individual
> tests to build the initramfs.

A submodule would work. The build is a plain musl-gcc static link
plus a cpio wrap, so it should integrate without pulling in extra
dependencies.

One question on the kernel side. The harness currently uses the
Cloud Hypervisor prebuilt kernel

https://github.com/cloud-hypervisor/linux/releases/tag/ch-release-v6.16.9-2=
0260508

which seems fully sufficient for the goals here. Is there a QEMU
preferred prebuilt kernel for tests/functional/ that I should use
instead?


Regards

Anatol

