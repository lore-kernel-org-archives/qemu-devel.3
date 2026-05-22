Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F82ACD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 08:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQLDd-0000gU-CB; Fri, 22 May 2026 04:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wQLDX-0000fm-JB; Fri, 22 May 2026 04:26:52 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wQLDR-00041z-IH; Fri, 22 May 2026 04:26:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C478F8075F;
 Fri, 22 May 2026 11:26:39 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:55c::1:1d] (unknown
 [2a02:6bf:8080:55c::1:1d])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id cQPsSL0hvmI0-tJMYakjI; Fri, 22 May 2026 11:26:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779438399;
 bh=8AHwySzfzV0CKc6dfC8cu/r50/MDMgK3dcHCc4lE4eU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=THDurn7Qf9hfco5+TH+kwbDaswSm9ntoU1KF974gvQsQgB1n75ow8Gkcf2Df29hjU
 sNqGaxA+zBJY+JbDmAMjRp9M9IJv88cMdARoOBvGWQgd+nBGBKX2EXKarRZiHUxsF3
 k/Tw8sxz47DseXIRndVl6h+CA99CTPucnJaWQ058=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2cf89d5e-6839-467c-a392-f9702f75c8dd@yandex-team.ru>
Date: Fri, 22 May 2026 11:26:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] qcow2: move qcow2_check_bitmaps_refcounts func
To: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20260521091918.2366140-1-jean-louis@dupond.be>
 <20260521091918.2366140-2-jean-louis@dupond.be>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260521091918.2366140-2-jean-louis@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 21.05.26 12:19, Jean-Louis Dupond wrote:
> Move the qcow2_check_bitmaps_refcounts function in order to be able to
> call update_ext_header_and_dir from this function in the following patch.
> 
> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>

IMO, for such cases it's better just create a forward declaration for
needed function (update_ext_header_and_dir) at top of the file.

Such movements makes extra complexes (conflicts) for any kind of future
patch rebasing (porting patches to/from downstream, conflicting series, ..)

(And one another small negative thing is that to honestly review such patch,
I had to apply it locally, to check, is it a clear copy with no changes or not)


-- 
Best regards,
Vladimir

