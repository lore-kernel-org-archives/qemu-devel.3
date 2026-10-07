Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F03CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xET0Q-0005pi-7e; Wed, 07 Oct 2026 10:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xESyu-0005Z3-Dz; Wed, 07 Oct 2026 10:50:57 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xESyq-0003gJ-27; Wed, 07 Oct 2026 10:50:55 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 697EoaXm033806
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 7 Oct 2026 23:50:36 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=0rv2d1ShfldswQy88JMJhMmrwVYH23VrgE2T0FaOMrc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1791384637; v=1;
 b=u2JWOOcC79pteEXPBERrl2x32ljlmoOQlV3brPv6iZ5YXTiBbv+Eup6lTSRhS+if
 STksK4OUfgHXNlcr2lXsDSOakZoFvUkNuP8uBAbVK0U0dSh3GeTAGF0dY2mFzcYj
 PqHMvYvxGsf36Hp4RTk3no+BoneZMHWisVBWsWDFqlU8S/gucIw4M9eag857XbfO
 3gKsdo6hvQD5ft4PTRrB7p+p348EJbxKXIfa4rtKdBQ1d2sQKJaEcwcQgjmNeksP
 pccc8Pn86n2PUYRLKn7qUS5+Y9xJYECJ17rKUtg+vi93Nro3vup+egI04UxK2smc
 tIdEaLNMheTLEBw51yzajQ==
Message-ID: <f0c07762-c115-41a0-b713-a47bdaa1f218@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 7 Oct 2026 23:50:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm/hvf: Retry RAM write faults only for dirty
 logging
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 "Scott J . Goldman" <scottjgo@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>, qemu-stable@nongnu.org
References: <20261007093001.74476-1-philmd@oss.qualcomm.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261007093001.74476-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/10/07 18:30, Philippe Mathieu-Daudé wrote:
> From: Mark Burton <mburton@qti.qualcomm.com>
> 
> Dirty-page logging handles a RAM write fault by marking the page dirty,
> restoring write permission, and retrying the guest instruction.
> 
> The handler also retried when the resolved RAM region had no dirty-log
> client.  This path neither restores permission nor advances the PC, so
> the instruction can repeatedly exit to QEMU.
> 
> Retry only after marking the page dirty and restoring write permission.
> Otherwise, use the existing emulation path to complete the access and
> advance the guest PC.

I can identify three cases of RAM write faults. The existing code
handles all three, but this patch breaks the third:

1. The RAM is read-only. assert(!mr->readonly) trips in this case.

2. Dirty logging is enabled. The vCPU marks the page dirty, restores
    write permission, and retries the write.

3. Dirty logging is enabled when the fault occurs, but another thread
    disables it before the vCPU acquires the BQL. The vCPU then observes
    a zero dirty-log mask. The write still needs to be retried because
    write permission has already been restored. The existing code does
    this correctly, but this patch falls through to emulation instead.

This patch is useful only if there is another case that the existing
code does not handle correctly. Please describe that case and preserve
the retry behavior in case 3.

Regards,
Akihiko Odaki

