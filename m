Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB7BCCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 04:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6hsu-0006nO-Uq; Thu, 09 Oct 2025 00:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1v6hss-0006bV-5p
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 00:04:06 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1v6hsi-0002fL-6X
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 00:04:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1759982622; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QIa+YJiK5jgh1rCbe0RTvHLtUieZ8x3uijCxuxktAVjgyINx+LxrrLJf+cfRyYivGlV6MioI4bVRKYC09g2bZi3CWWYSz/llRCmpYdTsyISjDuHBbxzkVx+YgYmASVzHTZcLvxyk4vLgnrsHWELUwLynmBhgjTa/vZRdaabeiRE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1759982622;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=U9N5rlqsqVEHX3Y84j2Q5VI3LGKDhpLZF7hzux6rKlg=; 
 b=iMCfu9OyL0ipjeZGunyFAx6KwFXsWI38M6oRN/Nwi3ImrPL3UovAJ9FWST48HTt1eKi5tqUUrZhdml326mInaSF/WSMRLzN1v9kuOyTZwlKbJoXSkiEYBrNmdMO5qdAMNDDgsLxIAo49BndrLipTlawqJEyX6nsYkIQCFXQaZoU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759982622; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=U9N5rlqsqVEHX3Y84j2Q5VI3LGKDhpLZF7hzux6rKlg=;
 b=I6cFtytVRo2/+ntm7IGb2CxTLKFRkfynGjG/QeCb++VJwmtSEhuSN5xVuPdOU2hu
 nytjNC696XGEfnWqyXQoaoe/1MlTzBW7Pvb11O8cIc4jXhd0xQtDVCUEx7fSjSJeF1q
 NOtkVwvqJckV43gz4427Hypf1I9iZ0jm7vJlOEiI=
Received: by mx.zohomail.com with SMTPS id 1759982620135279.8958862748982;
 Wed, 8 Oct 2025 21:03:40 -0700 (PDT)
Message-ID: <cf5f668c-7aff-4ec8-85cf-a5e53b02c953@collabora.com>
Date: Thu, 9 Oct 2025 07:03:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v5 1/1] Honor guest PAT on x86, absent Bochs display
To: ~myrslint <myrskylintu@proton.me>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <175541013614.15277.14412479690071783636-1@git.sr.ht>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <175541013614.15277.14412479690071783636-1@git.sr.ht>
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

Hi,

On 8/17/25 08:37, ~myrslint wrote:
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
> ---
>  hw/display/bochs-display.c |  4 +++
>  include/system/kvm.h       |  1 +
>  target/i386/kvm/kvm.c      | 52 ++++++++++++++++++++++++++++++++------
>  3 files changed, 49 insertions(+), 8 deletions(-)
...

> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index 3c7d314736..c6ba3905dc 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -208,6 +208,7 @@ void kvm_close(void);
>   */
>  bool kvm_arm_supports_user_irq(void);
>  
> +void kvm_hack_do_not_enable_guest_pat(void);

This will fail to compile if KVM is disabled or if target != i386.
AFAICT, you'll need to check whether KVM is available at build time and
move common code to kvm-all.c.

#if defined(CONFIG_KVM_IS_POSSIBLE)
void kvm_hack_do_not_enable_guest_pat(void);
#else
static inline void kvm_hack_do_not_enable_guest_pat(void)
{
}
#endif

-- 
Best regards,
Dmitry

