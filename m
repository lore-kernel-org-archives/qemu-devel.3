Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DE2CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lDK-0000Pg-Ma; Tue, 14 Oct 2025 16:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1v8lDI-0000P8-S9
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:01:40 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1v8lDA-0004lK-ME
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:01:39 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1760472078; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EiaUwkDJbXl/J5w7XeIx+tBpmj/jh4X6H0ZFbKmMCA/lEWttBDvgT/KNo3Ju28xAgJwbcP05/A5WW9WTr44fPLRPnXP+CzKHoL8JjIc8K2qtPXYU6OOU7fE9MHlvuclV7g3qV/styHVSXDaOm6QnswOkMKneCroY2UHYpsR7pIE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1760472078;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=LYDiELtKOKYtsSCcA8IbIJdDEoZdsdg0cwRccKLMyf8=; 
 b=Y9dpVPN5h5udY1XgyV9vixj03myl1DOnvx1gSkHwWdfDICgt06/8qUwg0Sx8ShuvJxpqGhR9MvC3BtYvgJKtXNF0N+TQZWdqIk2Y70Mrq0MZYP25dCUnP37hos5I8UYmgsO/ZkxFylZoKR6G+iG6dip7UGIWxHC/Il0zSrECOdo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760472078; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=LYDiELtKOKYtsSCcA8IbIJdDEoZdsdg0cwRccKLMyf8=;
 b=LqafrVEps6bJRox2DHb0hviJBqid3KAuQ8PO70CXsovEPR/nkxv0oEWd7h2RU9rT
 /a4rNEsz/UsiPAd67HhhCmTyZuzMr3iqLXfiN+rZcPj/aMBkp0zbv+3ZXL1WbqXdHAk
 TnQwxrXigHFf34NJJzJPhoy19MX3cdB3TiwPvKvk=
Received: by mx.zohomail.com with SMTPS id 176047207692795.19604092799977;
 Tue, 14 Oct 2025 13:01:16 -0700 (PDT)
Message-ID: <2f9abed7-2cb8-4c96-b9cd-5e8d2084b1e7@collabora.com>
Date: Tue, 14 Oct 2025 23:01:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v8 1/1] Honor guest PAT on x86, absent Bochs display
To: ~myrslint <myrskylintu@proton.me>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <176045956423.5579.13349691093596703310-1@git.sr.ht>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <176045956423.5579.13349691093596703310-1@git.sr.ht>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/14/25 19:23, ~myrslint wrote:
> From: myrslint <qemu.haziness801@passinbox.com>
> 
> On x86_64, where most CPUs support self-snoop, it is preferrable to
> always honor guest PAT. Not doing so is a quirk. There is a default
> enabled KVM quirk flag which enforces not doing so due to a former bug
> in Bochs display driver.
> 
> The bug has been fixed but not enough has yet passed since so we only
> disable said quirk flag if a Bochs display is not configured for the
> virtual machine.
> 
> This commit also moves around a bit of code that would be called when
> the initialization of a VM is done.
> 
> Signed-off-by: myrslint <qemu.haziness801@passinbox.com>
> ---
>  accel/kvm/kvm-all.c        |  1 +
>  accel/stubs/kvm-stub.c     |  1 +
>  hw/display/bochs-display.c | 17 +++++++++++++++
>  include/system/kvm.h       |  9 ++++++++
>  target/i386/kvm/kvm.c      | 42 +++++++++++++++++++++++++++++++-------
>  5 files changed, 63 insertions(+), 7 deletions(-)

Looks perfect. Now up to Paolo to review further and apply the patch.

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

