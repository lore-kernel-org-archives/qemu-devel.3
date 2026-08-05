Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524DCC55ABF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 12:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraSx-000183-9U; Wed, 05 Aug 2026 08:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong_li@linux.alibaba.com>)
 id 1wraSb-00015l-O4
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 08:11:04 -0400
Received: from [115.124.30.119] (helo=out30-119.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong_li@linux.alibaba.com>)
 id 1wraST-0001O5-UR
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 08:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785931828; h=From:Subject:Date:Message-ID:To:Content-Type:MIME-Version;
 bh=ChHqhSHqnqKZJ7yNw9TMjFbFQnzt2BqwQzvw5MRyxC0=;
 b=Eg69NK528byU8B47xXc6je6hnI9A+lwbj1nptYLbBIiagOd69Wy+gGy4Meki5z18chuEcs5i8e6LIu00Rg4ozMjH4NebQDAyXlhUV6fexqHiqmtDg1XRcaekjyJce6Ofzp+NGQw+kW0OaWPBtuOvN6oJT31do0eWk+RptA4EyKw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R801e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=zhengrong_li@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0X8R8LnD_1785931821; 
Received: from U-92DF4J33-2338.local(mailfrom:zhengrong_li@linux.alibaba.com
 fp:SMTPD_---0X8R8LnD_1785931821 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 05 Aug 2026 20:10:27 +0800
From: Zhengrong Li <zhengrong_li@linux.alibaba.com>
Subject: Re: [PATCH v2 1/3] runstate: set crash_occurred on guest crashloaded
Date: Wed, 05 Aug 2026 20:10:10 +0800
Message-ID: <178593181019.90910.8754057031123805737@linux.alibaba.com>
In-Reply-To: <f76c7662-09d5-4f70-a72f-90dcbe9cfef9@oss.qualcomm.com>
References: <f76c7662-09d5-4f70-a72f-90dcbe9cfef9@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, pbonzini@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.119 (deferred)
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=zhengrong_li@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

Hi Philippe,

Thanks for the review.

I followed the existing pattern in qemu_system_guest_panicked(),
which already sets crash_occurred on current_cpu when a guest
panic is reported. The intent was to keep the panicked and
crash-loaded paths consistent.

Putting it in the generic function also means any future crash
notification mechanism (beyond pvpanic) would automatically
benefit from identifying the faulting CPU in guest dumps.

I agree the original commit bac05aa9a77 ("cpu: Add crash_occurred
flag into CPUState") doesn't explain the design choice well.

If you prefer moving it to handle_event() in the caller, I'm
happy to adjust. What do you think?

Regards,
Zhengrong Li

