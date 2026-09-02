Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C187C61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 07:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1fkz-00060j-6k; Wed, 02 Sep 2026 03:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stanleyjhu@google.com>)
 id 1x1fkx-00060Z-Gn
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 03:51:39 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stanleyjhu@google.com>)
 id 1x1fkv-0007B0-Vr
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 03:51:39 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-51c01c79467so247211cf.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 00:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788335497; cv=none;
 d=google.com; s=arc-20260327;
 b=f23F/tUgkyZYrSvTNUybD/W2VAYFeR4BJte9qgtfzwY/5tkRsjb671TWPgA/+rqBzF
 QEVinV5jvBoOW2ceWPGkwPGODUoitQwQ5UbC4mI41V5DFkULzaKMcssXJXe0JokIACKS
 xRwE17IrKKePfNXbWiL7Jc5gTjwSxU9Nv5eclFcAFyF3ClS0EVj7tWb5vSQ9tmRfSTpc
 pE/QiznQLD50+UMTJj3nLVzuvKedKfB9CzGRQa5rwDgAwMLCJ6ThWNC9d2vI9bBH4GAs
 pYeVFmsizXIwA3BS6d5mGnR4is+151FoS6o/+2I11jtzE/cfsV+8iGjq1OETfVZbxK1t
 qbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FXOrAnYsoSceuH7On5xeujI0dOTWc9pbO0kuX46UqgI=;
 fh=rzjnk08up/1SurQqSf/G3LUMKeQU6lzjqNqdLu6Hy3I=;
 b=fF/prlokryWXbNn3+RRlQNV6h1u0piGy1jvFFWcjLyarqg8Lflft0WYKCEvza33Acd
 4zi7dunzKwSkH5iRJtDYlU/EFj+WobPLS9aHdoQ/Ir6xuG1C5Ml4avwu/3XvseAzSiWB
 p7dG5EVXCw57WcrUezsKIV8qzXwDohj37muwsoGrt4BVXQNVF7Kuw+dsjvoKaxFff+H0
 23NyliOO0h1KskOJgan2FP4bSJ8LZytrSQgZpzXDmNqY3oeGhObKv2s4B/I0Zy++Dc6l
 8TK9Pzr6qJ3ch8UG8yVvw3HgdMtnTCIvBt1FqaJZ4fUR99Nr28GjrpPY3c1zPtHOV20i
 BqVw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788335497; x=1788940297; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FXOrAnYsoSceuH7On5xeujI0dOTWc9pbO0kuX46UqgI=;
 b=eVYlJItbsOUac7f8eRTMkPXpoYqy4oKGGVL1hYOQ1q2DFYrdcWz8b4GkVcd/JLtyoD
 ot1vV1r4e8BGpUI7k+HgxZbvSpJvta3u6aLuSTY7xx5zR7hbk0IZZe8LOyO5p/vEFSSn
 95kaY2g/OEhCS2h3UCsrjWLt+S+cEJU0lsLHbxQfEEGto2SWOL/qh7LbgtmhqupsUIa3
 x73LIgICdWIvZNdTPq2G6DwBnnZy39mvxOhox+6FDWDYwVu2+zku/xV5yw7YXoNgzv1g
 +NTNUBr77G1aarEqr2EVVhaaeFqEosLE88Wc90dU4h1x6fGFvkz/AsLnE/HoqUXzFtT7
 55kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788335497; x=1788940297;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FXOrAnYsoSceuH7On5xeujI0dOTWc9pbO0kuX46UqgI=;
 b=gBLsC+K8ZpLq+MDh3Ud/lfcLMqAVmGQ26S6yAqtOrbLh5iTZy1DmnE/UwjyUXZCYyj
 GOM3DFCcjBA0/0sPNQqzChsgkTT0HxoSF/N2rFptrza6sGnyXulw5SmTwU8b2mdZXLLD
 jiMXk2/1jryhLxnwD/LSZe15y6uxs+wfqosnMezInDrB3bMLuiccgHotLhPvYyEdqhTC
 bbG9NDrc7VhwSV57yqtqEw4gGIHU0pte6mev0qfkFEBX7PEdVTPs9iJ6VcoTWrXce98x
 Xr38+IcrbHrQbC4rw1Ub9MdQ7LldFHTj9tdjsyJd9M0ti8SNfWG2yDe3o0HMozLxolRX
 G6GQ==
X-Gm-Message-State: AFuF++kLEIpBNSGprgF4O3dJryMIVKEHDA1qZ42Ht57DEWDo2w4D6xWh
 fPdjEkeaq7Hpc/v1tiIptMR13ronBakdflKVNVRAiuH84x0tvCcAOtWRd3cEyCklAq85vGuFSoI
 u2G1rldmTh8bDf9CnYFbpAQaA2GbS975zqmQWCELd
X-Gm-Gg: AR+sD11J/Kk/sPjePFgctMaPnnYYBDpWwhX9qH2wYPpo2WgL8dVGaoZfNef7vJT3vnj
 1RF8lgA+t14tKSFqQNo2y4568YLTj7NEvxyg7gfjCsj8C9tHmrX5Nr15s+3dtmO89dTPxiiMuJ9
 aDthlpmBI4pHripVH/dWLd6zcIt7+FQ+qf0Me1iNcEIjBP2YyTFFFTxM/Zp4utEEu+1xfMyxW2N
 gEtd/C4HUHvvpU+bcwOacTr39I1UuGTQ0yE3FYfbHG6xT9Dphu0FPARSstDeGI9YM/ToLU/9+iv
 NRS85hn0PafUTAMMReDqghbgXx244dC4m68zXZo7t8s=
X-Received: by 2002:a05:622a:144e:b0:52e:8422:a329 with SMTP id
 d75a77b69052e-53033af327emr12263981cf.6.1788335496130; Wed, 02 Sep 2026
 00:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAE14pdd_8whV+A_2qpujNTS+zeCes8M0e53LfN_zLY+v7iKPcw@mail.gmail.com>
 <456f7344-0d8c-49ab-8d3c-5652e4ba7d48@gmail.com>
In-Reply-To: <456f7344-0d8c-49ab-8d3c-5652e4ba7d48@gmail.com>
From: Stanley Jhu <stanleyjhu@google.com>
Date: Wed, 2 Sep 2026 15:50:59 +0800
X-Gm-Features: AcwNN1XfkxRK4jA26DsfZTeERCkpMiHNoMoWFS8NqSzKD0mGfiLYP6_0Ezi1fPs
Message-ID: <CAE14pdc5LO5Lj1+qdu3TvNTuLYOE8hJKv9u9+nJLc4+AvKZ-jQ@mail.gmail.com>
Subject: Re: [PATCH] hw/ufs: Reset controller and MCQ state on HCE transition
 to 0
To: Jeuk Kim <jeuk20.kim@gmail.com>, Stanley Jhu <stanleyjhu@google.com>, 
 Jeuk Kim <jeuk20.kim@samsung.com>
Cc: qemu-devel@nongnu.org, Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=stanleyjhu@google.com; helo=mail-qt1-x836.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Wed, Sep 2, 2026 at 3:51 PM Jeuk Kim <jeuk20.kim@gmail.com> wrote:
> > +    /* 1. Purge outstanding SCSI requests for all logical units */
> > +    for (i = 0; i < UFS_MAX_LUS; i++) {
> > +        if (u->lus[i] && u->lus[i]->scsi_dev) {
> > +            scsi_device_purge_requests(u->lus[i]->scsi_dev, SENSE_CODE(RESET));
>
> The UFS SCSI bus has no .cancel callback. The reference returned by
> scsi_req_new() is released only from ufs_scsi_command_complete(), so
> a cancelled request would leak that reference.

Good catch. I added ufs_scsi_command_cancelled() and registered .cancel
in ufs_scsi_info (in hw/ufs/lu.c). It sets scsi_req->hba_private = NULL
and drops the reference via scsi_req_unref(scsi_req), ensuring cancelled
requests do not leak.

> > +    /* 2. Cancel active Bottom Halves */
> scsi_device_purge_requests() calls blk_drain(), which may run pending
> BHs. Please stop the request-producing BHs before
> the purge and make sure they cannot be scheduled again while the reset
> is in progress. Note that an MCQ CQ BH may reschedule an SQ BH.

Agreed. I introduced a `u->resetting` flag and reordered the sequence:
1. All active BHs (doorbell_bh, complete_bh, and all MCQ sq[i]->bh and
   cq[i]->bh) are canceled BEFORE scsi_device_purge_requests().
2. In ufs_mcq_process_cq(), rescheduling sq->bh is explicitly guarded by
   `!u->resetting`.
3. Request processing in ufs_mcq_process_sq() and ufs_process_req()
early-returns
   if `u->resetting` is set.
This ensures blk_drain() cannot run or reschedule any request-producing BHs
during the purge.

> > +    u->reg.utrldbr = 0;
> > +    u->reg.utmrldbr = 0;
> > +    u->reg.is = 0;
>
> Please clear UTRLCNR and UTRLRSR as well.

Done. Added:
    u->reg.utrlcnr = 0;
    u->reg.utrlrsr = 0;

> There seem to be two possible approaches here:
>
> 1. Add the missing SCSI cancellation handling and stop the
> request-producing BHs before purging the requests.
> 2. Stop accepting new requests and defer the HCE reset until the
> in-flight requests complete normally.
>
> The second approach looks simpler for now. HCE can remain set while the
> disable is pending and be cleared from
> a BH once no request remains in flight.

I chose Approach 1 for two main reasons:
1. JEDEC UFSHCI Section 5.2.1 ("Host Controller Enable") explicitly specifies
   that when HCE transitions to 0, the controller "shall abort all active
   transfers". Deferring the reset to allow in-flight requests to complete
   normally risks writing completion UPIUs/CQEs back to guest memory after
   the guest OS has already aborted them or while the guest is actively
   re-initializing the controller.
2. Synchronous purge via scsi_device_purge_requests() guarantees that once
   the MMIO write to HCE=0 returns, the controller is immediately in a clean,
   idle state without lingering asynchronous completion windows.

With .cancel implemented and BHs guarded, Approach 1 is clean and compact.
I verified this end-to-end under ARM64 QEMU with UFS 4.0 MCQ fault injection
(dropping CQE to force guest timeout and mock abort failure): full host
reset completed cleanly, and subsequent 4KB direct I/O passed 100% binary
comparison with zero warnings or leaks.

I will send v2 shortly.

Thanks,
Stanley Jhu

