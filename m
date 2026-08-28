Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FB9C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzptn-0000sJ-3d; Fri, 28 Aug 2026 02:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wzpti-0000pm-AR; Fri, 28 Aug 2026 02:17:06 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wzptf-0002Ih-R4; Fri, 28 Aug 2026 02:17:05 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6C35D41A39;
 Fri, 28 Aug 2026 06:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0F71F000E9;
 Fri, 28 Aug 2026 06:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787897822;
 bh=jaUE9eDL/oONPyV3JhSxB2e8p73DUwsJpa0QyHqI3tQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=S8W+TsRE4MnR8r9SL75r9pHCtxULw4O58uR0YgQtIBgpo50l6++ZmVzMQ/d8sPxzM
 2h2yllvR1ePpz5goa3m8qdz4nQq4g8tYOAVIW9K+TmZc1Y8EHKyzBQEvlt9WqYc0RK
 9puNno6XEaNw1q15S3JPu31qlX31EixmQSzYo7u/CpeMbFtsHTV2BtSuyiicmrwMv5
 epdO6nNcMUNzKhgJ4RmGQRNJ/1tHC29c1IrEKoTaqhUklRJRIH298UEJ1jXQmFziTr
 l/HtjB3rsHeXaLrLgn9xJdham32tehqzNCIYHxUJey7pf99cRLnVnCWSvmRH5CryhZ
 9hJxH2Lad2TiQ==
Message-ID: <fcd667ca-4c1e-4a20-a700-5aa070315119@kernel.org>
Date: Fri, 28 Aug 2026 15:17:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] file-posix: base the zone append limit on the
 transfer limit
To: Niklas Cassel <cassel@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20260825205748.679968-1-cassel@kernel.org>
 <20260825205748.679968-10-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260825205748.679968-10-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=dlemoal@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/26/26 05:57, Niklas Cassel wrote:
> The zone_append_max_bytes queue attribute is the largest
> REQ_OP_ZONE_APPEND that the device accepts, and Linux has no interface
> for issuing one from userspace: include/uapi has no such operation, and
> every submitter of REQ_OP_ZONE_APPEND is in the kernel. Userspace writes
> to a sequential zone with an ordinary write at the write pointer.
> 
> That is what this driver does. raw_co_zone_append() substitutes the write
> pointer of the zone for the offset and hands the request to raw_co_prw(),
> which reaches handle_aiocb_rw_vector() and issues a plain pwritev(). The
> kernel never sees a zone append, so the attribute describes a limit on an
> operation that is never issued.
> 
> Nor is it a limit that this driver runs into. The kernel splits a write
> that exceeds the transfer limit rather than refusing it, so a larger
> append succeeds: on a null_blk device whose zone_append_max_bytes is
> 130560, a 16 MiB append completes and advances the write pointer by
> 16 MiB. Reporting the attribute only understates what the driver can do,
> because Linux derives it as a minimum that already includes max_sectors
> and chunk_sectors.
> 
> Report max_hw_transfer instead, the limit that governs the write the
> driver actually issues. There is no use in telling a guest that it may
> append more than the device carries in one command, and a frontend then
> does not have to reason about how this driver implements an append in
> order to bound the value it advertises.
> 
> On a null_blk device with max_hw_sectors_kb of 127 and
> zone_append_max_bytes of 130560, virtio-blk reports 255 sectors before
> and after.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

