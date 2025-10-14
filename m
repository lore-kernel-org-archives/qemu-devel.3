Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF40CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 16:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8hXv-0007n8-CY; Tue, 14 Oct 2025 12:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1v8hXs-0007n0-Ju
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:06:40 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1v8hXm-00053e-Ju
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:06:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1760457976; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ymo2hFvWU3e/56Ngl+Vr7E/8lNcAom9no7j9X3qLlqD6XAiyobX1VYb6fX2M9/kz1LSSlYWDsbT08VXj/g3hXxMMvsp9JlW63Yk69G8mjG8Qj/thiLsbdCYB9jSQAcMAY8GIcgecOW1rCYf/MsDvSvrV2fOafdW49oz5nrc69hQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1760457976;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=uYi5Zb7WLMdCiwfuX70YEjbA6L2QsDhKXD2ApHT61GU=; 
 b=MilP/oHW57sumx9xa2FNXERdCl+6J/VXguT5NLcz1wwfPhc51/rRGwLrz3TPwS2DenCFC+pMVv6J4/zaWOB+ZOIwVsvxLpHO/UF9dHMBOl91Ea96v8gZtJ3/QW+WNsufUJiEkhTfZSCHgjuP8Gv3fcUWQltv3+VSZn4Zh/gshg4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760457976; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=uYi5Zb7WLMdCiwfuX70YEjbA6L2QsDhKXD2ApHT61GU=;
 b=S0oCVHCGdqeYUQ6VZ4hFVuHAFUeRR6g15SyKIpWPOrCypcWDpfuKaEgGGvF86wT2
 vcB98D89MPmE6AvLH92Wt7MOsCcLMlLbT+JR8pP8vdsKhQCbHseWJzWrlXhfybzmpVy
 9/CYVgrDdnrpXlvV/rbEnRKF+lrc6iEblCI/LN6E=
Received: by mx.zohomail.com with SMTPS id 1760457974325973.0234470442019;
 Tue, 14 Oct 2025 09:06:14 -0700 (PDT)
Message-ID: <4dc0f1da-1509-40fa-b1c0-e31ed8061210@collabora.com>
Date: Tue, 14 Oct 2025 19:06:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v7 2/2] Honor guest PAT on x86, absent Bochs display
To: ~myrslint <myrskylintu@proton.me>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <176045275486.7119.13003157223292391926-2@git.sr.ht>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <176045275486.7119.13003157223292391926-2@git.sr.ht>
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

On 10/10/25 05:43, ~myrslint wrote:
> +
> +    /*
> +    * On x86_64, where most CPUs support self-snoop, it is preferrable to
> +    * always honor guest PAT. Not doing so is a quirk. There is a default
> +    * enabled KVM quirk flag which enforces not doing so due to a former bug
> +    * in Bochs display driver.
> +    *
> +    * The bug has been fixed but not enough has yet passed since so we only
> +    * disable said quirk flag if a Bochs display is not configured for the
> +    * virtual machine.
> +    *
> +    * The following flag tells KVM initialization code not to disable that
> +    * quirk flag.
> +    */
> +    kvm_bochs_drm_quirk = true;
>  }

Please correct the formatting of the comment:

WARNING: Block comments should align the * on each line
#70: FILE: hw/display/bochs-display.c:316:
+    /*
+    * On x86_64, where most CPUs support self-snoop, it is preferrable to

total: 0 errors, 1 warnings, 135 lines checked

0001-Honor-guest-PAT-on-x86-absent-Bochs-display.patch has style
problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

-- 
Best regards,
Dmitry

