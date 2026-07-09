Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE609C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whlaI-000430-Cs; Thu, 09 Jul 2026 06:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anbelski@linux.microsoft.com>)
 id 1whlaG-00042l-U7
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:02:20 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anbelski@linux.microsoft.com>) id 1whlaF-00034c-CA
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:02:20 -0400
Received: from frill.fritz.box (p5dd8e4e5.dip0.t-ipconnect.de [93.216.228.229])
 by linux.microsoft.com (Postfix) with ESMTPSA id EEF4920B716D;
 Thu,  9 Jul 2026 03:02:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EEF4920B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1783591331;
 bh=N9oWwuk8ZXgLaddocJEigd8gsHmp9vg31x8Q1mcH5x4=;
 h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References:From;
 b=eZL3KCTgvT3Rv/d11lp6wOWo7J91E6PdSNzqeRP8zx/DRuDapQKRzMip1rQcK0WeG
 WG59NBzsFMkYWWqWjcb+bn0+i2dc7u/9dWLLdb2QaVEUAo84FhbUwQeLLzjfqyydJO
 MTAoHsXuAtJveSqsONhlJ6w7/q490O5xfkmX/6aM=
Message-ID: <17b658d35228733829d128c09de142b5c195ffc3.camel@linux.microsoft.com>
Subject: Re: [RFC] virtio-villain: Guest fault injection for VMM robustness
From: Anatol Belski <anbelski@linux.microsoft.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Date: Thu, 09 Jul 2026 12:02:13 +0200
In-Reply-To: <ak9LAQDQMIZjWor5@redhat.com>
References: <98dd26094403c204c7c2f0270d96b9c75842c7d8.camel@linux.microsoft.com>
 <aktl-ojkXVZ4Jira@redhat.com>
 <a2a7bb2e20d954689a638b8a27b7fb95de156667.camel@linux.microsoft.com>
 <akzXblNvD5s4QGgB@redhat.com>
 <861020196095d6d91a83b878a1ed744b2824d159.camel@linux.microsoft.com>
 <ak4Fxt989xkWfgwD@redhat.com>
 <068f20b5ff9e0ab58706c0f2260292c9fa63c471.camel@linux.microsoft.com>
 <ak9LAQDQMIZjWor5@redhat.com>
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

On Thu, 2026-07-09 at 08:17 +0100, Daniel P. Berrang=C3=A9 wrote:


> We don't have any stock kernel. Tests refer to any kenrel/initrd
> image that they require and download it via the "Asset" class
> functions which have caching built-in.

Thanks. With this I have all the info to try, I think. The CH kernel
will do fine then, I will just point the asset reference at that
release.

Meanwhile, I have filed the first finding on the tracker
https://gitlab.com/qemu-project/qemu/-/work_items/3968

Will follow up with the rest on a slower pace, as discussed.

Regards

Anatol

