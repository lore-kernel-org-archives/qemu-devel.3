Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0F5E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 14:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNYnv-0002Kp-SL; Tue, 17 Dec 2024 09:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNYnr-0002KM-Ov
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:44:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNYnZ-0006yB-4Y
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734446621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n/AKrXHd+b6mRjdl5u4Bw1015eGC/aoj5jqCJDpR2PQ=;
 b=U5p5TV2VCOY/c3XrWg2OvX935uRO+WcjbqNp08FIdPEzZnSJNY2Yz0ayiqHjEZSgNm2eX6
 b/rc4XZt2Cl2+DhVtSbmoFgUjY/VMoQcx+og9303Vbxo94dALHBc3eSRlfBpsC9EB9YJS3
 SvLL/dLe9Bq7S8E+G96EIl5YvEwBmQ4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-q5mJt-RoNNy2CY2LcJzJEg-1; Tue, 17 Dec 2024 09:43:40 -0500
X-MC-Unique: q5mJt-RoNNy2CY2LcJzJEg-1
X-Mimecast-MFC-AGG-ID: q5mJt-RoNNy2CY2LcJzJEg
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d87ee5fb22so85697226d6.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 06:43:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734446613; x=1735051413;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n/AKrXHd+b6mRjdl5u4Bw1015eGC/aoj5jqCJDpR2PQ=;
 b=NUqi7mKHYPqlzH34xh9+hut3zN4zma3gTvI25hCvr4khVD7M5IEy96c0NKj/8CCVmv
 qJmZTAwqzerqgEH4Tjb1wMF5skefbTAb1304GBZlWDpS2usg1mpm9Ql38em8EWdXmh+H
 yJ+okeY+L1+4iCuUlusOwAP+mfB0AtBKG5pLWwv0lhx0gDvgpB3V+DYQyhLS/7hJpAOj
 lW6ueDuhUqG7K2/5VSfUftuoaUraE4Sv72S/kurlWHgu0SmlGD98QrAYwMncza/Byhz5
 R3FHKg4ClIkRPo+X0PWkTte2RFlWLWyCQ2pVhSVno7w4wcT0UinT+JrV6tsT/5S20+qm
 ti5Q==
X-Gm-Message-State: AOJu0YzVrum4In7EELTwhxhuz46A9tuNF+vxqk21fBfmpDsTvzPDuNKS
 GRZlsToDGxAJsIHI11Yi1EWvlVslxfm0jKYIddax/TjCWExKjHN0L16fD8W+aqtw5UR8Xw2s5kF
 1B0M0D6Y6vyYDXe5GwN/CxeT3TALLOmjmd1xDIfnU4zW5SumiK2OX
X-Gm-Gg: ASbGncvQ2bcOJRinVabgIpY1mFnhXKHXJS3hbNHLr83pGtex2ukUmQ3rYTZIMIzCeoY
 /W+576T8XT+3EHBd6Ag1RK7GMGTSnQaX98K/OcJAjInCI3oMprA5oSp1XEgGd1u2197vPRTlTmf
 BjoaAfabHAbRtsK69khURYooB2IGlMquCIsTC+AmPdNVtCiSO1euSyneGGmsiF0HPzKOgmmmx2Q
 0APKQkq8ycOeNzUZcLI267sOHKP6xpFGWK9RZ2DvJEFTNtoiZxd2mohjq3wxFNHvj6Iahifq9lO
 BDTmEpI3A8OiBwEhZQ==
X-Received: by 2002:ad4:5de6:0:b0:6d8:b3a7:75ab with SMTP id
 6a1803df08f44-6dc9684a93emr292068876d6.44.1734446613739; 
 Tue, 17 Dec 2024 06:43:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHszwCwL+kTZUIQq1loM8fvAtv55bzke7Ln5yqcer24F0+5+PFwKf4l2avRDYTF4uW6mBAsNA==
X-Received: by 2002:ad4:5de6:0:b0:6d8:b3a7:75ab with SMTP id
 6a1803df08f44-6dc9684a93emr292068686d6.44.1734446613441; 
 Tue, 17 Dec 2024 06:43:33 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd26c8cbsm39014416d6.54.2024.12.17.06.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 06:43:32 -0800 (PST)
Date: Tue, 17 Dec 2024 09:43:30 -0500
From: Peter Xu <peterx@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, linuxarm@huawei.com,
 zhangfei.gao@linaro.org
Subject: Re: [PATCH] tests/qtest/migration: Fix compile errors when
 CONFIG_UADK is set
Message-ID: <Z2GOEoiVGoegx2z4@x1n>
References: <20241217131046.83844-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241217131046.83844-1-shameerali.kolothum.thodi@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Dec 17, 2024 at 01:10:46PM +0000, Shameer Kolothum wrote:
> Removes accidental inclusion of unrelated functions within CONFIG_UADK
> as this causes compile errors like:
> 
> error: redefinition of ‘migrate_hook_start_xbzrle’
> 
> Fixes: 932f74f3fe6e ("tests/qtest/migration: Split compression tests from migration-test.c")
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


