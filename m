Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25F6C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzFpd-0004RE-0b; Wed, 26 Aug 2026 11:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wzFpa-0004Od-TD; Wed, 26 Aug 2026 11:46:26 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wzFpX-00021q-JF; Wed, 26 Aug 2026 11:46:26 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 01DA1C08CA;
 Wed, 26 Aug 2026 18:46:18 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:86::1:4] (unknown [2a02:6bf:8080:86::1:4])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with
 ESMTPSA id HkfBEL3ZZ4Y0-f0wG0dV1; Wed, 26 Aug 2026 18:46:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787759177;
 bh=fftVGtGGhJbaYVa3rckoktxemBvQSDjLhkEpchoVGv8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=oquqDZbrxjkJvz117akCLiD5EDgeAy30jyEVWzChMADnUNyXjBH9+J1HhVnTufL9p
 +cSH++ksJp51s/IR1AZBsdfoNMnAmrCHyv5ncZ7j0SJujCc0oKjfRKtR5r+QMuwFXy
 QFIDFBSDL/wNMH/DEch4vrvTs1oWGZ3FJUZgQ+ws=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ee6e69df-673b-4859-8c77-e1f5b5552f68@yandex-team.ru>
Date: Wed, 26 Aug 2026 18:46:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] qcow2: add functionality to repair bitmaps
To: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>
References: <20260826101005.2345883-1-jean-louis@dupond.be>
 <20260826101005.2345883-2-jean-louis@dupond.be>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260826101005.2345883-2-jean-louis@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 26.08.26 13:10, Jean-Louis Dupond wrote:
> In some cases, it might happen that bitmaps become corrupt.
> For example when adding/removing bitmaps on a live image.
> 
> Of course this should not happen, but in case this happens, the image is
> corrupt and even cannot be opened anymore. You'll get something like the
> following:
> qemu-img: Could not open 'disk.qcow2': Bitmap '' doesn't satisfy the constraints
> 
> So the image becomes useless, and cannot be repaired. This while in fact
> only (one) bitmap entry is corrupt, and the rest of the data is just
> intact.
> 
> This commit adds a way to fix this corruption, by just replacing the
> bitmap list in the qcow2 image with the valid bitmaps, and dropping the
> bitmaps that are corrupt.
> 
> $ qemu-img check disk.qcow2
> qemu-img: Check failed: Invalid argument
> qemu-img: Lost persistent bitmaps during inactivation of node '#block147': Bitmap '' doesn't satisfy the constraints
> 
> $ qemu-img check -r all disk.qcow2
> qcow2_free_clusters failed: Invalid argument
> Leaked cluster 3 refcount=1 reference=0
> Leaked cluster 26 refcount=1 reference=0
> ERROR cluster 983214 refcount=0 reference=1
> Rebuilding refcount structure
> Repairing cluster 1 refcount=1 reference=0
> Repairing cluster 2 refcount=1 reference=0
> Repairing cluster 32768 refcount=1 reference=0
> ....
> Repairing cluster 983214 refcount=1 reference=0
> The following inconsistencies were found and repaired:
> 
>      2 leaked clusters
>      3 corruptions
> 
> Double checking the fixed image now...
> No errors were found on the image.
> 983056/1048576 = 93.75% allocated, 0.05% fragmented, 0.00% compressed clusters
> Image end offset: 64437878784
> 
> And the image is valid again!
> Worst case you lose all bitmaps, but at least the image and the data
> itself is useable again.
> 
> Signed-off-by: Jean-Louis Dupond<jean-louis@dupond.be>

With accidental (I assume)  scripts/meson-buildoptions.sh.tmp file removed:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir

