Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A300E10A88E0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5mor-0004bV-8u; Thu, 26 Mar 2026 11:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5moh-0004at-3U
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:40:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5mod-0004mF-PY
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 11:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774539608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=taBV0PF/PGvMQ1u9PCbckPeeplRnaNc22NV687WtKQ0=;
 b=eH3ix6GXp4K0FVUjIITbkRmDKVEQoxZGLuEVyjvLZquGS9FkB/wT4QWh6TNVIpAJzICaZP
 pjLpi6vFRSbPjjSD001XSfyHjTK545QLsr56y7Yaxg3UHcJEPNklWSG5OMMCBMV8WGW3ni
 IrzehD4qds9J7r2i4SeQX77/s0sYZpg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-qU9oPYNHP1-wLLOt9Q_h5g-1; Thu, 26 Mar 2026 11:40:07 -0400
X-MC-Unique: qU9oPYNHP1-wLLOt9Q_h5g-1
X-Mimecast-MFC-AGG-ID: qU9oPYNHP1-wLLOt9Q_h5g_1774539607
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5090e08dcfcso28715801cf.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 08:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774539607; x=1775144407; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=taBV0PF/PGvMQ1u9PCbckPeeplRnaNc22NV687WtKQ0=;
 b=dVDYZcmNF6jv65crcRlZIGHcKaOBupYPK5Q99HNrZNrPXfTUOUWiLMkB/K58QFHmju
 DTXf0yoUUr772aKJHM0s5CB5f0s+uuhXQpT0AYtDFRtvrVBQYb8nRcQe5JLqu80wfcxM
 PcV1fxNDxpSzST2pmQyIiClAbnFAIn93ghxADS+lEfHI5AWM8NPeoq+WHCUEpuDd4fiM
 z9lkOS6STOGlDFg48bQ7yBsmDvLR9HE2zVs+YbfgeTdDH8TgXkupqyO+93nuAX8cc3Mt
 OaD8jUiWqTC+Vbh+M5DlBfylKIrq6Yz2C3CEq2rUIJkmpD91r7/o1/yPWItX9cc4/G4o
 ZGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774539607; x=1775144407;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=taBV0PF/PGvMQ1u9PCbckPeeplRnaNc22NV687WtKQ0=;
 b=Zcwe/7Lp3iTqvx7r33cgS8j4+zZXK52fTTq/dF+PfEhnCh/wbX3klbGdlR8Rv2HHgY
 HQS/9WhbJAY0AMTkGnbMJOXDuJWMsJC1MaEzTdalWK1w56ki7Py5k9xtlnm4pRKJppfb
 DknPQNL2hAvdWs66x3rZkvyJEjgNqOv9+zAyPAW7eaw3PFayKckkzY3j1McbGt6fUU5d
 YzJS/ziGJ0/rj48Q7SmrgEReQtpMh3ibcEOq/MjYNUz2VU7Iequ3VdUh0mIhsngbyUMV
 y4gJza3hLxTVerYsRA/bSvcLe+zakBo38IBtvEW3lZRpO+NYDSuIjb2z12FgUAzmMy1l
 9yvw==
X-Gm-Message-State: AOJu0Yy+3jeWsG0Z4XXRx8omCOBIJP1yjh8uw0nk+vjXy8qFg3vtf44L
 vindVKjBd8e3AmU/n6WndfIzUuT3JAiRWAlk2dr87wyyY5NHnyHhj8i9CS4V0UQykEEK7l6FtRH
 K5yna3LIq2BbSNainmsy7w/iRq47ZTsfy/JxM1CN1cIW44FMhKZhfX0zr
X-Gm-Gg: ATEYQzwWirvdgHe2xMlcsrf6Pxivyl5zpLG7xCuUvbvHRpOQ7gLrHzVYMH4pStWEqWt
 l+v8sWp3E0VZB2o5pvGJ/4nEQjw92oq6D6MEF0zVUz+AGw35XzIfGq+KFy2DRZufnVGon0MMHxx
 uykk80oLWeKRYa68OM7araHWkwGlnI70yNOl7C0UW2IrMUqwysZkCh+cF/LnhkpORe+3T3H8AOR
 oiyDJLldxeF8yu6ZM2hfkidSkbyVfqGCbWFnRAFwA6bo1mfanyHZlkrxkWky1Qqzg5nNfYs0wAF
 1fhDkh5bVcRMyarSs92zRjuRmqJzSmjKiFwLFo+Mnd4IIfRGo5lB615rKir3/pBL7TbpPMGzJ5v
 LSt6wCqG1tLxCkg==
X-Received: by 2002:a05:622a:1e99:b0:50b:29a6:8696 with SMTP id
 d75a77b69052e-50b80cced67mr105370821cf.7.1774539606563; 
 Thu, 26 Mar 2026 08:40:06 -0700 (PDT)
X-Received: by 2002:a05:622a:1e99:b0:50b:29a6:8696 with SMTP id
 d75a77b69052e-50b80cced67mr105370221cf.7.1774539605953; 
 Thu, 26 Mar 2026 08:40:05 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b9217ca02sm27692721cf.13.2026.03.26.08.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 08:40:05 -0700 (PDT)
Date: Thu, 26 Mar 2026 11:40:03 -0400
From: Peter Xu <peterx@redhat.com>
To: hongmainquan <hongmianquan@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com
Subject: Re: [RFC V2 0/2] migration: optimize cpr fd lookup using GHashTable
Message-ID: <acVTU42xvTqzx2wA@x1.local>
References: <20260319113830.53867-1-hongmianquan@bytedance.com>
 <abv_bPLyZtfDjpPs@x1.local>
 <6df681fb-0db1-48a1-bac0-a05229fb2c7d@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6df681fb-0db1-48a1-bac0-a05229fb2c7d@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi, hongmainquan,

On Thu, Mar 19, 2026 at 11:03:48PM +0800, hongmainquan wrote:
> Thanks for the reminder. I apologize if I missed any specific points 
> from your v1 review. Could you please point out which specific comments 
> I left unanswered? I will address them immediately.
> Regarding your main questions in v1 (performance data and why migrate 
> hash), I have updated them in the cover letter of the v2 series, but 
> I'll summarize the answers here directly for your convenience:

Thanks, please still always reply directly so we can discuss before you
send new versions, and sorry for the late reply.

> 
> 1. Why the lookup is slow, and the performance improvement data: 
> Currently, `find_fd` uses a linear search (O(N)) on a QLIST.
> The latency increases with a rising number of fds, and the supporting 
> test data is provided in the cover letter.

Yes, the number is persuasive.

> 
> 2. Why migrate a hash instead of migrating a list and reconstructing it:
> My primary goal was to accelerate all `find_fd` lookups. To achieve 
> this, the underlying data source needs to be replaced with a hash table. 
> My initial thought was to simply change the fds structure entirely to a 
> GHashTable and migrate it directly. This approach seemed much more 
> straightforward to implement than maintaining a conversion between QLIST 
> and hash, though, as you rightly pointed out, it does inevitably involve 
> changing the CPR ABI.
> Secondly, I was concerned about the timing of converting a QLIST to a 
> GHashTable. The conversion must happen when the fds list is in its final 
> state with no further modifications. However, during normal VM 
> operation, there are ongoing operations that save or modify fds. If the 
> GHashTable were merely an auxiliary structure, we need to keep the QLIST 
> and the GHashTable synchronized.
> That said, your suggestion makes a lot of sense. If we treat the 
> GHashTable as the primary structure and only convert it to a QLIST in 
> the pre_save hook right before migration—then reconstruct the hash table 
> from the QLIST on the destination, it would completely work. This 
> preserves the original QLIST-based migration ABI.
> In short, I believe both approaches are technically feasible, but I 
> agree that my current implementation has the downside of breaking the 
> CPR ABI. I look forward to discussing this further with you.

Yes exactly, you can stick with the hash for most of the lifespan of QEMU.

It makes sense to be able to migrate a ghash, but cpr may not be the best
first user due to ABI break.  You can also wait to see if the Reviewers
have anything to say.

If you want to be on the safe side, you can still evaluate the pre_save /
post_load approach dynamically constructing the qlist, then dynamically
rebuild the qdict, to measure the perf.  I'd expect it'll be similarly
good without ABI break.

Thanks,

> 
> Thanks.
> 
> 在 2026/3/19 21:51, Peter Xu 写道:
> > On Thu, Mar 19, 2026 at 07:38:28PM +0800, hongmianquan wrote:
> >> Currently, the CPR subsystem in QEMU uses a QLIST to store fds.
> >> In scenarios where a large number of
> >> fds are involved (such as a VM with many vfio-pci devices), looking up an fd
> >> via `cpr_find_fd` becomes a performance bottleneck due to the O(N) linear search.
> >> This patch series optimizes the cpr fd storage by replacing the QLIST
> >> with a GHashTable. The time complexity for `cpr_find_fd` is reduced
> >> from O(N) to O(1).
> > 
> > Some unanswered comments here for v1:
> > 
> > https://lore.kernel.org/all/aacuTpoMucQ1wrUN@x1.local/#t
> >
> 

-- 
Peter Xu


