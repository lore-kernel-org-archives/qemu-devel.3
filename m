Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C579CD6E4C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 05:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTvCR-0002rg-EJ; Mon, 01 Jun 2026 01:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wTvCO-0002rB-EC; Mon, 01 Jun 2026 01:28:28 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wTvCM-0005NQ-UP; Mon, 01 Jun 2026 01:28:28 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EA5EC60018;
 Mon,  1 Jun 2026 05:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555DC1F00893;
 Mon,  1 Jun 2026 05:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780291697;
 bh=lW1lbXFBl5z7UWbTx1L9N0qC8bNKattadDXAk4Op6IE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=oY/CxgBcGYSh1N+2tnyL7A/ptTxxmxNgOlOP/Ys908F6dSjmhmATh8AMkWk1sIKrh
 /cHXqlyUMyVbbDBKlD/jJNu71cZ2O6AEy8Hv9FbV+69NoOTFzTPTi60gherRU/t0Ut
 h0nh5Us8ivm4vvp3snUPwOAux7AjLz137dROqr2TiQc0i6ImCENxBnIN9md68gFoSb
 0TCj5HIy5an0wKDCw5mBlRWSuhxlpSqLxFGAh0fZPA/iGTL5e+3L/oiFtnbdFrFFx1
 nOXxUneNyzSTaCQPG6SkfU0M1NMu/4M+k+wa9kENSFCRCozez4oA4hyl1xEx+5cLbk
 NohtglaWM/v/w==
Message-ID: <4a80956e-64dc-4c83-bc2b-f997ba2f41dc@kernel.org>
Date: Mon, 1 Jun 2026 07:28:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dma-helpers: chunk dma_blk_cb at IOV_MAX
To: Keith Busch <kbusch@kernel.org>, Daniel Gomez <da.gomez@kernel.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>,
 Klaus Jensen <k.jensen@samsung.com>
References: <20260529-align-nvme-mdts-with-linux-v1-0-221d4d21ab43@samsung.com>
 <20260529-align-nvme-mdts-with-linux-v1-1-221d4d21ab43@samsung.com>
 <ahmlzjtnRoCtBP8a@kbusch-mbp>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
In-Reply-To: <ahmlzjtnRoCtBP8a@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=da.gomez@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 29/05/2026 16.42, Keith Busch wrote:
> On Fri, May 29, 2026 at 02:36:13PM +0200, Daniel Gomez wrote:
>> From: Daniel Gomez <da.gomez@samsung.com>
>>
>> dma_blk_cb() submits dbs->iov to io_func() in one shot, so callers
>> must keep dbs->iov.niov below IOV_MAX or the host preadv()/pwritev()
>> rejects the call.
>>
>> Break the accumulation loop when niov reaches IOV_MAX. The existing
>> re-entry path resumes mapping and submits a follow-up chunk under
>> the same AIOCB, so callers no longer carry that constraint.
> 
> Thanks, I like the idea. One question below.
> 
>> -        if (!mem)
>> +        if (!mem || dbs->iov.niov >= IOV_MAX) {
>>              break;
>> +        }
> 
> Won't this leak "mem" if it is not NULL, but we've hit the iov.niov
> condition? If so, I think you can move this new check to after the
> qemu_iovec_add call.

Good catch, thanks. For v2, I'll move the new break condition after
qemu_iovec_add and sg length accounting:

@@ -156,15 +156,17 @@ static void dma_blk_cb(void *opaque, int ret)
                 }
             }
         }
-        if (!mem || dbs->iov.niov >= IOV_MAX) {
+        if (!mem)
             break;
-        }
         qemu_iovec_add(&dbs->iov, mem, cur_len);
         dbs->sg_cur_byte += cur_len;
         if (dbs->sg_cur_byte == dbs->sg->sg[dbs->sg_cur_index].len) {
             dbs->sg_cur_byte = 0;
             ++dbs->sg_cur_index;
         }
+        if (dbs->iov.niov >= IOV_MAX) {
+            break;
+        }
     }

     if (dbs->iov.size == 0) {

