Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1939FCCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 16:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8hWJ-0006y7-Up; Tue, 14 Oct 2025 12:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1v8hWH-0006xO-VF
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:05:02 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1v8hWE-0004jF-68
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:05:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1760457885; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PsezeQPpHkrJEoIftEjDyHpIvqyCcogc4W2oT48brkfUu7U2F3pPPdNWhnt9mCRuPJ5O9w4BSrVVupd9CxDv+xkMEAcDddtZkUmY83jQU76iqhAOE0Qswz93SxNdGMiWmmVwHL4n6zS6fiCTMBbz1efPdyvtdxEFWHI409hmNcU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1760457885;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=xQLomgCMn/wxJQ256pDUjPavFVzjhAJvszM1OScp0W0=; 
 b=edTY4oCTbOpzymglyWLFaj1zKGnVlgIHAD9E49lOLlthx+w0UfB9sttiIdwN3Ff5M5ayBI0BYd+NGdq09LSZ4U7nwMOafU01DltZJz7M+08KDXHfHr3ZMgyAqWaCHF0puzjninIC6S84mpSNhCRdmCEn14IR1V6rrkT8nkvxUac=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760457885; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=xQLomgCMn/wxJQ256pDUjPavFVzjhAJvszM1OScp0W0=;
 b=K9iHudF5qxEJhaIzlTNhoUW2+XpljAvhgZD/f1aEWNMVLYH2iv1DCvUu3mATtg1o
 OEFx/4Sjov1edF7g+D32qp19Ak4R4ZLADZC42Bn9GMc7AdCVIenA2yGzuG1gLIBPHoF
 VYgk58PeZUBNCBltVjT7xHWvHZagsch0oT3WiXgA=
Received: by mx.zohomail.com with SMTPS id 1760457882861455.30815142082804;
 Tue, 14 Oct 2025 09:04:42 -0700 (PDT)
Message-ID: <ca3d0a47-8ea6-48e1-8063-76fdc362a427@collabora.com>
Date: Tue, 14 Oct 2025 19:04:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v7 0/2] Honor guest PAT on x86, absent Bochs display
To: ~myrslint <myrskylintu@proton.me>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <176045275486.7119.13003157223292391926-0@git.sr.ht>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <176045275486.7119.13003157223292391926-0@git.sr.ht>
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

On 10/14/25 17:39, ~myrslint wrote:
> This is a minor revision of of the proposed patch to disable KVM ignore
> guest PAT quirk, on x86_64 target, when KVM is available and Bochs DRM
> display driver is not used.
> 
> This revision hopefully addresses the points raised by Dmitry Osipenko
> <dmitry.osipenko@collabora.com> regarding the v6 one.
> 
> As with the v6 of the patch it is intended to address the following
> issue:
> https://gitlab.com/qemu-project/qemu/-/issues/2943
> 
> myrslint (2):
>   Honor guest PAT on x86, absent Bochs display
>   Honor guest PAT on x86, absent Bochs display
> 

Something went wrong, you posted two patches here - old and new versions
with incorrect commit titles.


-- 
Best regards,
Dmitry

