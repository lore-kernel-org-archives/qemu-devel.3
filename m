Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB45CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGaOk-0006Z1-Nq; Tue, 13 Oct 2026 07:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1xGaOf-0006Xl-29; Tue, 13 Oct 2026 07:10:17 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1xGaOb-0001Vp-Mk; Tue, 13 Oct 2026 07:10:15 -0400
Received: from [IPV6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2] (unknown
 [IPv6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2])
 by apollo.dupie.be (Postfix) with ESMTPSA id ABEA01520ECD;
 Tue, 13 Oct 2026 13:10:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1791889808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKYw4Rr8QsjLcklrHL8eOYlee663WpuzMlHrZru3zgg=;
 b=kKMM3GVaALmd1aJz6m9Vg0s3UA41NXfbH5o2+35OvPjTZ+oRKdGse0NWP/lIPQTzLLsWV2
 5tIPuENyRV2R4nNngUAvfsYYd6gcLy7P1Ay3vYLVCx4HUrOWNSI3IiV4Pywl8+pWANHPVf
 GmA3WxsWWY/Z0QcVCv7nn6e0T49O8CaFxmP/vd4Z13Ehr72ij097Dgd4WllG0ZJbwMG3MG
 ZBHhMD4OFU7Fk8IuFvUDhGpXXSEyhOjZzn304T8X2+2NkDtL3k9G9Ex91MCtXFVryGMolv
 vf32qZwhz56UelArmXnRai/0sEXYAXUo5oxPygcGV5Jdrf/2kewaazgGdKZtMg==
Message-ID: <2def14a2-9590-4c66-a0d8-edef97b8e966@dupond.be>
Date: Tue, 13 Oct 2026 13:10:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] block: measure for commit
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 qemu-block@nongnu.org
References: <20260915140444.1223798-1-jean-louis@dupond.be>
Content-Language: en-US, en-GB, nl-BE
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <20260915140444.1223798-1-jean-louis@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:bc8:3f2a:101::1;
 envelope-from=jean-louis@dupond.be; helo=apollo.dupie.be
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

Ping :)

On 15/09/2026 16:04, Jean-Louis Dupond wrote:
> In some cases we want to calculate the size an image will be after we commit A into B.
> This for example on block storage, where you need to resize the target storage before you start the merge.
>
> These commits adds the functionality to do this.
> First of all a commit that adds bdrv_open_backing_chain_until. So we can open an image up to base image B.
>
> And then a modified qcow2_measure that calculates the size of B after A has been merged into it.
> This with taking into account the discard-no-unref setting of the base.
>
> Jean-Louis Dupond (3):
>    block: add bdrv_open_backing_chain_until
>    block: support measure for commit
>    iotests/290: add test case for qemu-img measure
>
>   block.c                            | 77 +++++++++++++++++++++++-----
>   block/crypto.c                     |  1 +
>   block/mirror.c                     |  2 +-
>   block/qcow2.c                      | 82 ++++++++++++++++++++++++++----
>   block/raw-format.c                 |  2 +-
>   docs/tools/qemu-img.rst            |  9 +++-
>   include/block/block-global-state.h |  7 ++-
>   include/block/block-io.h           |  3 +-
>   include/block/block_int-common.h   |  2 +-
>   qemu-img-cmds.hx                   |  4 +-
>   qemu-img.c                         | 45 +++++++++++++---
>   tests/qemu-iotests/178.out.qcow2   |  6 +--
>   tests/qemu-iotests/178.out.raw     |  6 +--
>   tests/qemu-iotests/290             | 45 ++++++++++++++++
>   tests/qemu-iotests/290.out         | 61 ++++++++++++++++++++++
>   15 files changed, 310 insertions(+), 42 deletions(-)
>

