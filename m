Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB51C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x94iW-0004zR-4h; Tue, 22 Sep 2026 13:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x94iQ-0004xt-F4
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:55:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x94iO-0000oj-Lr
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790099735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cZnRqHncLVVfl8P8B0+V36N7NmBKH5GqbT31wK4eedI=;
 b=J9MAK17hGqE4C+EEYY5CyxS9ndzcBRoTLWSz1x8SvkrWgg9EgyDRN9iyasNtMMVXw9Huso
 g8rwWlL6sKYX7RwAUfWGtb5AMAq9zGtXETisRglptLzUzv1dSoi1w/VIAdsADQ4zcfNfin
 0Rl9Kp5EW2/w4bpFpL/M4bsnpMQwGzo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-dlWCasQHPDCy3DtIJWTzPQ-1; Tue, 22 Sep 2026 13:55:34 -0400
X-MC-Unique: dlWCasQHPDCy3DtIJWTzPQ-1
X-Mimecast-MFC-AGG-ID: dlWCasQHPDCy3DtIJWTzPQ_1790099733
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93be1861d2dso35015585a.3
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 10:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790099733; x=1790704533; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cZnRqHncLVVfl8P8B0+V36N7NmBKH5GqbT31wK4eedI=;
 b=Yg4WnVsZhqojOHpF1gm/xWjSPTHnOPAmn5s3s95MwZsqNmIrMYPxqGU/tvYQtAC8Dz
 S/9UHE2jO6J60eJGxypqIc/QKP3xwGaEzUijwU/wvVylqP/cOWgif2KSBrMJ5gPSzfm4
 Ig7V4hvdk8kCFfR0a0frtm0rc3c5/wwrDXZy2Mx0Yk8EqarbriS0nM436QowrtlPS5dT
 iUqkkTLB9k7fFzK39uQN69kECgcGZsp95SPHvGq2R9FjrUSN3DnFd1tiLN9a89dTTIgF
 +XrqdJFo/Ls/akEnvKl4GlL+D3Io51c8pFRJEssm+XCiwMdhE7VKb4nqy4mIzxQipuiS
 e3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790099733; x=1790704533;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cZnRqHncLVVfl8P8B0+V36N7NmBKH5GqbT31wK4eedI=;
 b=XMrxrPHh6aqqdcjqJ3I+qdRA6F8C78IC14v2ZCXWaxtPgKB3FfGnItjg20xp49utHY
 myPdXAoQ1GqcSiuAMQkTYwA4vTXFa2c6M6D39ojvKBq5vwEGBbaofkGkjNM0xjPU9bqC
 0F203mzYc+YICJapY0khw33TECEPuEAQWPbLnmIsjg1tYq8EH1ZP5BdQ+U1TVqMCRKrH
 jULGSER7ZlglbqhAINRPoK1t18zHcEZSAdo1XiZTPKm6kEhBeKyAEawVSFMan2sx7llh
 b87yZln3KDZlNsb69YPMjkGfqDBWRYlmOBTAKDm6TeHCPVtuuM/HzUrHBQqpjmRTOQL+
 7gtA==
X-Gm-Message-State: AFuF++leC9Ya1OBhO0kikbr3d34i1EaRmxlR83E1blDvaPd2hs03DOxT
 nYEUgnTFU/cmZUexbub48J7J1dEG9/4p9LFYmII5tHBSq8ASF47sqXIMnsABo831CCLc06epFSH
 rbXBC/4DzX80NVqcOHFuiEEmE8d9hIveIXO/HB1ZGAQSAEmQ8LDRysNTBvVp2NI73cmA=
X-Gm-Gg: AYBFou0k3vC2nW3coNtctXUJvurTOpHuTtdjuft3PscgWmr9w+0HllXoyM/cXTOTif7
 dsV+cdZOy5AVenXGdKF/0zU3yvcVy1nH9jll15bDiZz/zJSx2d5tjhCx5GLss9E4UneVLzR3XR2
 5542bvHQAFWwBw6HEJNhgOlfTEH4QEQ4MbibwWEXSUKjOuKKJFEeHha89VdIkn+5jOzFf2yk0Sf
 hUZUZQT/++MXaIyRV3ClCAMARziY69gVKGdnf3MNR9HHvSgXu9nQ0ULizm5uQ7Iyu66R9wyeUh6
 DELuiC/WKFMLvsSfjsw1DEWwjksFd3W7Y861VcIjGh8F6qlURNscP4U3SyDRAZg2O2OZApM=
X-Received: by 2002:a05:620a:8089:b0:93b:b846:bfd6 with SMTP id
 af79cd13be357-93c2509718fmr26392285a.12.1790099733352; 
 Tue, 22 Sep 2026 10:55:33 -0700 (PDT)
X-Received: by 2002:a05:620a:8089:b0:93b:b846:bfd6 with SMTP id
 af79cd13be357-93c2509718fmr26389085a.12.1790099732846; 
 Tue, 22 Sep 2026 10:55:32 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c248225c8sm28783985a.9.2026.09.22.10.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 10:55:31 -0700 (PDT)
Date: Tue, 22 Sep 2026 13:55:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH 2/2] migration/postcopy: account faults taken by memory
 sharing processes
Message-ID: <arLBEswPcm-Iu826@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260915063719.89031-1-guobin@linux.alibaba.com>
 <20260915063719.89031-3-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915063719.89031-3-guobin@linux.alibaba.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 15, 2026 at 02:37:19PM +0800, Bin Guo wrote:
> Page faults taken by a process that shares guest memory with us (e.g. a
> vhost-user backend) are resolved over the migration stream just like our
> own, but they are not accounted for, so they are missing from the latency
> reports.  There is no thread id to report them with: the client's
> userfaultfd is not required to enable UFFD_FEATURE_THREAD_ID, and
> libvhost-user does not, so the ptid in the fault message stays zero.  Even
> when the feature is enabled, the reported ids belong to another process
> and can never match one of our vCPUs.  Passing zero would not work either,
> as mark_postcopy_blocktime_begin() reads it as "no thread id" and returns
> early.
> 
> Report those faults with POSTCOPY_TID_FOREIGN instead, which takes the
> same path as the faults of our own non-vCPU threads: no vCPU is involved,
> so the vCPU blocktime reports are left alone and only the latency of the
> fault is accounted.  This also resolves the "TODO: support blocktime
> tracking" left in postcopy_request_shared_page().
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>

This one looks fine in general, but I feel like POSTCOPY_TID_FOREIGN as a
new flag didn't bring us anything, since the FOREIGN is treated the same as
the main thread then.

Logically, the vhost-user process will have its TID too, so it means if the
vhost-user process open the userfaultfd with TID cap it'll work.  But I
agree with your approach here that unfortunately we didn't have control
over it, the pre-existing TID support was pretty much hard-coded to QEMU so
far only.  Maybe it's not yet as helpful to make it formal to have
vhost-user servers supporting it.

But then, I think we can simply enable tid=0 rather than introducing
POSTCOPY_TID_FOREIGN.  It means only vCPU threads are special, all the rest
accounting will fall into non-vcpu category, and with tid=0,
blocktime_get_vcpu() should already return -1, or we can move the tid=0
check from mark_postcopy_blocktime_begin() to blocktime_get_vcpu() instead:
returning -1 if tid=0, and it's safe as vcpu threads shouldn't have tid=0.

Enabling tid=0 brings one more benefit: IIUC it'll also make blocktime work
naturally on old kernels without UFFD_FEATURE_THREAD_ID defined: currently,
ufd_check_and_apply() will simply bypass that feature, then tid will be
reported as 0 on old kernels.  It means then blocktime will work on those
kernels too now, except that all faults accounted into non-vcpu category,
which makes sense, because kernel is too old to identify where it came
from.

Thanks,

-- 
Peter Xu


