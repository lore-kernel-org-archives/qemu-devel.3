Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA005CFB44A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 16:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxqbQ-0005db-9D; Mon, 07 Oct 2024 12:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richardcochran@gmail.com>)
 id 1sxqIk-0000iA-0t
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:09:38 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richardcochran@gmail.com>)
 id 1sxqIi-0005HT-Fd
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:09:37 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20b0b2528d8so52503925ad.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 09:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728317374; x=1728922174; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jbnVqVnf/+P0rl51L6+didESx8C92ZvLSqC1mWtGnLk=;
 b=IYJ2LRkEEdsjRhTXtM7eWv46Qc++zT561Cxf34fAV00MHtvFw7D3mpmMbEkF1ndq40
 U/jflQwS+Sog6bRIGHmskuJOYd8jScfrFkJkML3tEm3yDWPsymQUVJ7BrW0XnmWT6CN9
 +Z+QuItKhpW78ECPhzvOTj/1mCdXCyaHQZCjXLWDE4gkc48VjW4LMvBvtUqL5viVl2t0
 GiCoeG+CX/iHsp4saD2uRcI3MAJ8vNzh9fB7abavMeshEZ98sRMiig36QLgqbcL0DcVh
 Vs+jV6oPmDbpbWrGJ/ucXfMhT8V/EGoUFFh9KOO+pVOpbgjxRT4sDyTvPPThKZRYAhPV
 bXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728317374; x=1728922174;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jbnVqVnf/+P0rl51L6+didESx8C92ZvLSqC1mWtGnLk=;
 b=BBSLhPG1vLM45MTsGqcLvDLTD1ycwiPO5ATc23woWiitjR3CDWDmCTH8x0tFwrFVJx
 eopIgZxFwkUnMoRRuLdrKr/YAF1Q61/vk3BJFDlo+K4o5TtZhTD2xMlYsTATY2BZD7oS
 KvbajpMLNHibLiHazuydYMr/SFRbX8NB4PdEjfIITqs+2J3YOk4JQ26jQ85foJohHgC0
 Rae5VO3EFUvz56k/74eNaJSwNtJVRFad7y2lq/cnD+67kk/6KZf+eh/usg3wtJs+Pjez
 tUogcfdkJeymDifBuuGFifONxfwIeLzuEM4QKDooFHFkje1kiBSW9lgLdYL0s0C1bntd
 YsEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5qBn7nypOb0ur8MsQbcNPZ/kTVEyrpi4Xl8THfsL3adZ3cJz1T3LnpP10Fe2By5kc5kw3NcG9P0KR@nongnu.org
X-Gm-Message-State: AOJu0Ywnw6qwq4NF0j6Ho4BcoBCtJTF1o8E6sxzvQLVvzDmIpEegGF6d
 rI06GAC9TAa+W8mp5neirsy/XD6r+rVwyns02xRApqYGgkWiT5Cz
X-Google-Smtp-Source: AGHT+IGRJ8PDY2uvOdrScF+lvW+ErLKYmvUUU9Ley7KXKt2lpYDNWDc7FzwaUgY9vidSx6egFuHhvA==
X-Received: by 2002:a17:903:2445:b0:20b:ab4b:544a with SMTP id
 d9443c01a7336-20bfe49471amr194072435ad.43.1728317373996; 
 Mon, 07 Oct 2024 09:09:33 -0700 (PDT)
Received: from hoboy.vegasvil.org ([198.59.164.146])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13988d0bsm41141785ad.262.2024.10.07.09.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 09:09:33 -0700 (PDT)
Date: Mon, 7 Oct 2024 09:09:24 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
 "Ridoux, Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev,
 "Luu, Ryan" <rluu@amazon.com>, "Chashper, David" <chashper@amazon.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
 Paolo Abeni <pabeni@redhat.com>,
 "Christopher S . Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 qemu-devel <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v7] ptp: Add support for the AMZNC10C 'vmclock'
 device
Message-ID: <ZwQHtD5lVNuc4aAf@hoboy.vegasvil.org>
References: <78969a39b51ec00e85551b752767be65f6794b46.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78969a39b51ec00e85551b752767be65f6794b46.camel@infradead.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richardcochran@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 07 Oct 2024 12:28:53 -0400
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

On Sun, Oct 06, 2024 at 08:17:58AM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The vmclock device addresses the problem of live migration with
> precision clocks. The tolerances of a hardware counter (e.g. TSC) are
> typically around ±50PPM. A guest will use NTP/PTP/PPS to discipline that
> counter against an external source of 'real' time, and track the precise
> frequency of the counter as it changes with environmental conditions.
> 
> When a guest is live migrated, anything it knows about the frequency of
> the underlying counter becomes invalid. It may move from a host where
> the counter running at -50PPM of its nominal frequency, to a host where
> it runs at +50PPM. There will also be a step change in the value of the
> counter, as the correctness of its absolute value at migration is
> limited by the accuracy of the source and destination host's time
> synchronization.
> 
> In its simplest form, the device merely advertises a 'disruption_marker'
> which indicates that the guest should throw away any NTP synchronization
> it thinks it has, and start again.
> 
> Because the shared memory region can be exposed all the way to userspace
> through the /dev/vmclock0 node, applications can still use time from a
> fast vDSO 'system call', and check the disruption marker to be sure that
> their timestamp is indeed truthful.
> 
> The structure also allows for the precise time, as known by the host, to
> be exposed directly to guests so that they don't have to wait for NTP to
> resync from scratch. The PTP driver consumes this information if present.
> Like the KVM PTP clock, this PTP driver can convert TSC-based cross
> timestamps into KVM clock values. Unlike the KVM PTP clock, it does so
> only when such is actually helpful.
> 
> The values and fields are based on the nascent virtio-rtc specification,
> and the intent is that a version (hopefully precisely this version) of
> this structure will be included as an optional part of that spec. In the
> meantime, this driver supports the simple ACPI form of the device which
> is being shipped in certain commercial hypervisors (and submitted for
> inclusion in QEMU).
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Acked-by: Richard Cochran <richardcochran@gmail.com>

