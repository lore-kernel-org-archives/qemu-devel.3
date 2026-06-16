Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1470ACD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 05:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZMTZ-00024I-C1; Tue, 16 Jun 2026 01:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZMTX-00023W-Ek
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 01:36:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZMTQ-0005Ey-Gi
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 01:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781588182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M+PPFOMcVJhB8m9SShQxlFnwUOxbziE7tiZuxihlIFY=;
 b=QNu04gvtpvblcbIRBnBZrBAeNvMwqPuowvQ4ARzerBpWLd1hUWH1GTdZWjx6otKaNa6pDs
 pHOrMQJ+gYZUmY3qF9YVEufOXWVALEiBiBmSCAgEAm20dcfDj5Ti+WWqwX3cZU02jp3ZHi
 3TuIbp+up8k7aSch2EwScQ9irmA6k20=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-v5uUi70xNgmvrs1bkklB_w-1; Tue, 16 Jun 2026 01:36:20 -0400
X-MC-Unique: v5uUi70xNgmvrs1bkklB_w-1
X-Mimecast-MFC-AGG-ID: v5uUi70xNgmvrs1bkklB_w_1781588179
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490abeb7298so46153075e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 22:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781588179; x=1782192979; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M+PPFOMcVJhB8m9SShQxlFnwUOxbziE7tiZuxihlIFY=;
 b=etnvSmzZ2K3FDzMyxYn2gOLl5+Vj2VW37d+r5Es7bPT8mm4nqPG4gE4mMxJyP3XbER
 NEhWXzN5h67JfP6TlkFxnQOp/frxJgGfnbB9IEl7XF12Dtf3m1YBO5/EgzfPF9Pb7sPp
 5KWhPXOcg0JfdVRReGQTh5O/2GeRnj/w4qdzwINxt4ExKfN/s+zaWrdaYe/Q+noTaQZk
 ywCPVhqo6ojM1FPhuWC21wRrr4LNIdXW27eoezcSL4j0hrGLbJ7MoHllMPddQIQ8V3cs
 qrjD9QXWSMSY8o8q/ONDBpJOmeTvYLtauCktMGV0EE77+pyfl4+covj7hNprG40F0ZWO
 knBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781588179; x=1782192979;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M+PPFOMcVJhB8m9SShQxlFnwUOxbziE7tiZuxihlIFY=;
 b=PKFJyouGZ2qFdt4NAXuhZOdkMnS8zLC7ITeQVvV+NbEMOYGMfsdPPPNxjNHE3mp09w
 ylQS5F0/IpDqcSW12cXG0lVeTYFYhVTVXoOtfYdM8Yn2xBU0cunlJHiV5GpSgnvAaLFn
 hKT19DJH/ekYhz01O2k5/xUCWU+x0XIZFQOx4VfcRHEMfVFdBToBKExto5a/nWkuv8dd
 4rVSGJbGA0Wf+SII9s911hKnC05Bz9MXKKrR7tLF0qN6cmUiHg1nnJJKZHr14nP4iPil
 IfIKTo4QcFou2TXU6r1C8TWPi6UCRwjaxry7sYtVovp30vPLEicWmVfgMBvj5ugR5Q9Q
 +mJg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+fCuJZr+nTJ2ML255Qvz5zATYEkLq14mG5UomcBBOAHJq2akcaEnQWZ/f4LJtSDmFw4yb+o1CAtKld@nongnu.org
X-Gm-Message-State: AOJu0YwqZDmLDAXXGybwNfL3QfOhJoHAYwjXxgBE2v5LuCpQX46jCo/n
 w9ln7tdC4SG2QQ1xGw+NPX9QO2n3FKnHHWM5iQsG+Zcd5IdDRyzEQ3uU8AFd5OAEshvVkgiuZnY
 eyM4gKtyQsZbX162nMckh40XgYW8EuvpiA4TDg/S7bM9KSi0cBb6u3D8b
X-Gm-Gg: Acq92OGIoQtZ2yqBd8HM1tc+bdRuCU3nbwDoJA13grqjqzrgsUyiuu5g3onARbI9KWt
 P6tFGlSn1HD8OPRGtCPcR1UIahc7iBCj/E0sFbjGlwqoeUaC7C8gP6tNk91IFcRsiLqDZHqa/NJ
 R893zdrShiBLUHr8+RzFvrcEnP2ReZTqD5MDOPSjWGMa8Ex4jM0ARBWjMmD8mqspQjTl4mF22hn
 TwSrlNA5zCMdYb13vvlQsWvzt7n3ldjVIRjzvJ7x6Nsq212OrbaE755B161VrtDBprSrUNT8Hao
 LpOjioCDeU00KurEcb2bfPhstPZs4MI60Ey8x1nnfIf9fzThaVEVcwtM85e6PeAkdHxXr5HjR3A
 ukXDyAGoquV2Dqms5incYJ4piuC/ILSTXeMyxENK0Gwk=
X-Received: by 2002:a05:600c:4e48:b0:490:e60b:6860 with SMTP id
 5b1f17b1804b1-4922005e235mr166699905e9.7.1781588179413; 
 Mon, 15 Jun 2026 22:36:19 -0700 (PDT)
X-Received: by 2002:a05:600c:4e48:b0:490:e60b:6860 with SMTP id
 5b1f17b1804b1-4922005e235mr166699515e9.7.1781588179027; 
 Mon, 15 Jun 2026 22:36:19 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa47da9sm59813525e9.5.2026.06.15.22.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 22:36:18 -0700 (PDT)
Date: Tue, 16 Jun 2026 01:36:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 alex@shazbot.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org, berrange@redhat.com,
 philmd@oss.qualcomm.com, philmd@mailo.com, david@kernel.org,
 clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn,
 dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: Re: [PATCH v3 0/2] system/memory: Make ram device region directly
 accessible
Message-ID: <20260616013359-mutt-send-email-mst@kernel.org>
References: <20260616052552.389021-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616052552.389021-1-gshan@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jun 16, 2026 at 03:25:50PM +1000, Gavin Shan wrote:
> All ram device regions was turned to be indirectly accessible by commit
> 4a2e242bbb ("memory: Don't use memcpy for ram_device regions").


What is missing here is the list of issues around
direct ram access and how we are solving them.

Thanks,
-- 
MST


