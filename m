Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784E5EF48C4
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 03:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqjS3-0001io-0l; Thu, 12 Feb 2026 22:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1vqjS1-0001iL-6G
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:02:37 -0500
Received: from anarch128.org ([2001:4801:7825:104:be76:4eff:fe10:52ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1vqjRz-0005cW-Iy
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:02:36 -0500
Received: from [192.168.1.3] (dynamic-cpe-pool.orcon.net.nz [121.99.116.25]
 (may be forged)) (authenticated bits=0)
 by anarch128.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTPSA id
 61D32LbD3845033
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 03:02:24 GMT
Authentication-Results: anarch128.org; dmarc=fail (p=reject dis=none)
 header.from=anarch128.org
Authentication-Results: anarch128.org; arc=none
ARC-Seal: i=1; a=rsa-sha256; d=anarch128.org; s=100003; t=1770951744; cv=none;
 b=blgJ2n/ob3TLiJMgk1O/CC0LuUk4POxt3LKfRUFxi+xydslysWaKaVlg0zxDI/MqQM5TA9LLI8INiIQ/l/umeHv/C3WDsx62OLT1vI5NQH0Dopjc/BzmfZw+kUpBqyYSrEYWp/TOqWcxTvzZJ0Xr1+01wUu9q0zLthovjIi7nDldtxmJi1mqq0ybDgg6LCZsOYOM6Yi8sxtQPckYZJZo1IFV7Ll4H3/0Uj3KNnr1gccaHwfaRUjtuahyh3BGVem/l74BWQp+9CZqV7ze3OLRzOSIjEmYICbNLC85WoTjt/OIGGjxwbYd6Gsd2oOCWrG6ghtjQ94C/GOV5tSFc815NA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=anarch128.org; s=100003;
 t=1770951744; c=relaxed/simple;
 bh=MciV03L6Yz0CfEOPFo14Ia6KdNZSA5VTYXqwamHOiL8=;
 h=DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
 From:To:References:Content-Language:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 b=JsWKSwD5HrR3HxAdkjWy1FCcfuhfnlV9q8fJR90aEaoS5mLimgvQiAlkw/V/cUUNQGDsOe8pVaO1oVoz8JSc0NJ43oS0B3mvf6VtAMyZoDO0bAEuljrntZxBttGt0lC3fiEx9rqrMhOyiqzkxpprvZL9Ci+H0utSOXQl1row5iaqER8xA6wTHZKKg35ZCrU5tiCJffaEmL2BAlquzgHX7hiAGGhWLL2STzTi+YeqA33ZanfVcDpDTtRc3Zx7789XQZvfJegD8uOSRmqt+vJF3qiYNPl2rIx+MFQTHZbJ0A+XDDYWkGWzAPPQ7XiZh8k5PHzN3eqmv6Lc+5mYRZuQIg==
ARC-Authentication-Results: i=1; anarch128.org; dkim=none (no signatures found);
 (null)=pass (MX Records found: mail.anarch128.org)
 smtp.domain=anarch128.org policy.is_org=yes; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anarch128.org;
 s=100003; t=1770951744;
 bh=MciV03L6Yz0CfEOPFo14Ia6KdNZSA5VTYXqwamHOiL8=;
 h=Date:Subject:From:To:References:In-Reply-To:From;
 b=Cbquqq7yw0s3lIYVmz7fduv8JUrutAj7+WDZ5ZAd5q/91suX/5jtx0TS+NUEnU7fs
 UFC5GboVbNt8RBL5KRpNSDUYBnlm8NhFP4pYn7NmsCpoy4ruimMYLuC6rccUEz4paW
 /lhIVDqU8+xvqnfGRsdpoFKKfO+1l6Dzq8zsY7Ghtgqyw1k+isZ+ecqSOX+ldu/suo
 ZJ3Cb1frEmw0TQV4H5r9ZixuPCZkWzq2ukcy+GdfxCUgrhUG2m3IYqiie2eGVVuUIZ
 vtKa77eWB1/BJHVtoCkmjEEee5Q9M+5lDouLxaRIAkKVSrL8ae5LjQSXbX2aWuHDiX
 o+MeyqnfTToZA==
Authentication-Results: anarch128.org; auth=pass;
 dkim=none (no signatures found);
 x-return-mx=pass header.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org); 
 x-return-mx=pass smtp.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org)
Message-ID: <8872dfb8-548d-4c74-ad9f-f31da415f4a6@anarch128.org>
Date: Fri, 13 Feb 2026 16:02:15 +1300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: GLYPH Instruction Set Architecture
To: qemu-devel <qemu-devel@nongnu.org>
References: <997772af-8b58-4550-8b3b-1249d8ae0cb7@anarch128.org>
Content-Language: en-US
In-Reply-To: <997772af-8b58-4550-8b3b-1249d8ae0cb7@anarch128.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4801:7825:104:be76:4eff:fe10:52ae;
 envelope-from=michael@anarch128.org; helo=anarch128.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Michael Clark <michael@anarch128.org>
From:  Michael Clark via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Folks,

On 1/22/26 09:46, Michael Clark wrote:

[snipped]

> GLYPH has been designed from the perspective of an emulator developer.
> it has many features that make it ideal for emulation. it has twice as
> many registers as mainstream CPU architectures which means privileged
> state can be mapped to registers. it also has a software-defined MMU.

new sections on number formats, types, vectors, interrupt handling,
and a very brief and high-level description of the virtual machine:

     latest: https://metaparadigm.com/~mclark/glyph-20260213.pdf
     current: https://metaparadigm.com/~mclark/glyph.pdf
     changes: https://github.com/larkmjc/glyph/commits/trunk/

there are 42 commits since the last update. stateless trap routing for
interrupts and exceptions for the domain extension is now there.

it is not stated explicitly, but the domain extension and trap-routing
for privilege-level free contexts might be interesting. there is the
idea of identity-mapped trap routing to configure bare metal domains.
one can use it to configure something similar to user-level interrupts.

there is also a new 'dommsg' vector mapping to PCIe MSG ops i.e. MSI.

domain message routing table for globally-scoped inter-domain messages.

Michael

