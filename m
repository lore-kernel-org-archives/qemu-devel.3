Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E9DCD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 20:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNGO6-0000U2-Qi; Wed, 13 May 2026 16:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNGO2-0000OE-Pq
 for qemu-devel@nongnu.org; Wed, 13 May 2026 16:40:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNGNx-0002oR-4f
 for qemu-devel@nongnu.org; Wed, 13 May 2026 16:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778704851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iiTS+ZmPBnpBmmYyMtsa6NsNs0W2J15DEieIOaw/7NE=;
 b=HQ77p1R22o5ZfLoZAqDcmV1mSs25yOLljfWJVrwumUrQeinaOaKURh3ua2w9Yek0MsrsWN
 lAPIcQbrfMBUPKI0Yzcf8JVEfSWlMfTlf2PZScwrh3HJxOhFrU3jN0sw7ey9AdYm5z4mLS
 /A3T4jzcMUZs3aFK7dBVX5rhgDglfOM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-TW5rWlwjPz-aEFja-sJk8A-1; Wed, 13 May 2026 16:40:50 -0400
X-MC-Unique: TW5rWlwjPz-aEFja-sJk8A-1
X-Mimecast-MFC-AGG-ID: TW5rWlwjPz-aEFja-sJk8A_1778704849
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50fbc49bef6so109441181cf.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 13:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778704849; x=1779309649; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iiTS+ZmPBnpBmmYyMtsa6NsNs0W2J15DEieIOaw/7NE=;
 b=G3CoicLQHRco5+M9nGMH/JDJSdq6kbTX2yBpYUKmuj2n8r/J31w+zP4kn0WLBDsegq
 AIYIAnrk7c7WuVlGP9hVzJYS13NtLOhB5Dlr/zRGTnGVMO+/YWqi7U3V0HjRFpuIWW5I
 /FGzSJyefLydSJt3jDhtm/98i0lOFubX6og3LcQNoO3WJxU7oFTDIvvfB5wf1nkE9uza
 jlyl2g0mrQ8iPgAINsOwouxZfqe7l2LoWv28jagrqK7ieVR2ce4e/e5W2D31QJqRlI5v
 ZmYL1bmgEpKOStVZePdIXLAYshlMwJ+7QXfWgZp/KT6bUJx+2CEvqwnt+g9tBOXWGO/B
 YnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778704849; x=1779309649;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iiTS+ZmPBnpBmmYyMtsa6NsNs0W2J15DEieIOaw/7NE=;
 b=pdu+Dhf5m63yB+/UkfB1ZPgRrFHT5wdR+peEfTA4hqrzQoTYPbPpqQKYYIEq0ObWXY
 +gGxWxa1RWrvShJGafEXxSdLCvMF2qVVAUX3p8a+PBugCT3UB/X9SqMRzlXL3hpZjzwe
 zOZtXWaV8dtzq+L/ZEYVuxGvReXNvKx2QI+ditrg8/IwqrDUw/5xk3dhfwha5CWIL28D
 W8TFRz8oZ/LqkBROpGpY/JSHTKrkhinkfGC1LaCjkCHJe4MU764qqI6gvXRClxvF8Bvr
 Y7unbHO/Suu9YP7oMhmO8uTQLeZKfl/tmFrnUYhV5vl0XCpnjAD9DaeLpU/ZeuD30MI2
 8sTg==
X-Gm-Message-State: AOJu0Yx3i89dPXdb51IJTXTcDiHdQ0pcBYyHZ0A2ebznopiiEiTy61zO
 zOil7SBRLhDu4pf2xX+CfdMUoC9SPUcvx3j2SmcAXY420UdHaNrbkMs+rDgl5XR3lZTYi+Ob8vu
 YXLpq1wJVKM9Il7go1SZm9CgDidU/7aMrVetYK4asPdnH8Viuy6WVs0iGs23VynUN
X-Gm-Gg: Acq92OHzlNvdklFl0vlrW2rw0bY6VB2vOA7unbk/glLg5etoA/eLu9RYw+74Xp/5hdo
 OQZD1r3k6Et4tdWG4c0ovEPbxFMqJ3V08PUowygLgH1CvUDNEQ3mHmWQtaq97l4pbEYB6kXtqd/
 xPmRtzXdcQlJTsILm6SrFzTKRYz0Jxdude5R2EQ/FTDXvSY2exlFZOLvR87YKPUz+i4X+WH2QJo
 6MNX3WdhkkR6DJg0KfYcUK9Id43CatmcBh7F7ojvlr2siV3z+F6S5b9ftryquGUwOKV/LmngJyo
 FCB+dKPhNqtqHe8VxgDaQXRubDtD2aBT81YIfcs2tauUT0z6UZdjbBtqX7XeFY6YE/hTN+AP4uB
 sUELla0WhVxnHb8cKq0JkQfnG+Hw/PJayvazOjHZmEfF2DrA=
X-Received: by 2002:ac8:5795:0:b0:50b:404a:746e with SMTP id
 d75a77b69052e-5162ff611dcmr68481161cf.47.1778704849328; 
 Wed, 13 May 2026 13:40:49 -0700 (PDT)
X-Received: by 2002:ac8:5795:0:b0:50b:404a:746e with SMTP id
 d75a77b69052e-5162ff611dcmr68480811cf.47.1778704848881; 
 Wed, 13 May 2026 13:40:48 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5148e83aa2bsm155463361cf.28.2026.05.13.13.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 13:40:48 -0700 (PDT)
Date: Wed, 13 May 2026 16:40:47 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 06/13] system/ram-discard-manager: drop replay from
 source interface
Message-ID: <agThzwUWXscICglY@x1.local>
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
 <20260504-rdm5-v4-6-bdf61e57c1e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260504-rdm5-v4-6-bdf61e57c1e1@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 04, 2026 at 04:30:12PM +0400, Marc-André Lureau wrote:
> Remove replay_populated and replay_discarded from RamDiscardSourceClass
> now that the RamDiscardManager handles replay iteration internally via
> is_populated.
> 
> Remove the now-dead replay methods, helpers, and
> for_each_populated/discarded_section() from ram-block-attributes, which
> was the last source still carrying this code.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


