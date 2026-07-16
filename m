Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A55C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkSzy-0001oi-AE; Thu, 16 Jul 2026 16:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wkSzw-0001oL-FO
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 16:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wkSzu-00086H-5K
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 16:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784234875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SLscvMbultGeCFBMoqoVyL5g6Spu1s3eX/09KNeOWGQ=;
 b=YAk4yvu+5KXJbGZU1ivUHxfoTq+aEJdbSl4Urxd+gsn5xWjp9VPRd0/Hl5BwC2ISoke7qH
 FbplTnsqVmj5ywxK2Hklp82unaehLU+PyfTXmWCIkU2kJa6kq6YxyTgQ7LZ6L7OhurtMvS
 kJFN8f78fqkncp8TPEi4m53oT7opnWM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-uOJMrgAtOEGYtvMrPGC42g-1; Thu, 16 Jul 2026 16:47:54 -0400
X-MC-Unique: uOJMrgAtOEGYtvMrPGC42g-1
X-Mimecast-MFC-AGG-ID: uOJMrgAtOEGYtvMrPGC42g_1784234873
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49544a639e9so4573285e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 13:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784234873; x=1784839673; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SLscvMbultGeCFBMoqoVyL5g6Spu1s3eX/09KNeOWGQ=;
 b=ULnk3zcc9W+upwruj71grwLPzfUs7YeLGGyXhoT7AU2Y1uW1Lb4IkKcO6AAEAYUca6
 V21aZsWYb/ZKVlw+VW+FZxcHNNxEm9LKFWUrdIblvtxjMZ3Ag35lb5+Scf0ZDjoiI6Jl
 fu4LJmHVed+nbReiIyUiQKUR9lNznE2oes+y7Cyx9ZitjKG7HoJktp8sBE/fiGYHIJwo
 Mt7HkRxSfUacQInkUdv2a6sxo/ak0JPfmIdgKau+fA2p3LZs3NlyCnqIyXCJYb7dsoiF
 ORsUIwSIAS/C//V7K6dy9ds9MSHHga8ftE+oj2ecLkLvmnqetOqnxToe8pUDU7qZTZvH
 G+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784234873; x=1784839673;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SLscvMbultGeCFBMoqoVyL5g6Spu1s3eX/09KNeOWGQ=;
 b=HdDz4aqFWX01heCktyuE/W3JKSP/09sr6r+0h5STvcVxpSnDaMxgc31IDrUmUjWhdY
 qJEiEimH0B2Egp5mPHswRStu+lhzA6xRrigggaNiyp7v8jQcyUnPGoPeNtvzcIIETTy9
 SHv/6X0n98OPRFkW3QLql1VdT1NCq9gu+Bhdh5N+WOiwE4/tHL//daHFBjPcsswV8p/A
 4RihCbPc+4ZKxzxGFOn6VQuhYaA0xUb9dIs4fyvazX4jUuHYd4ZsIOnoXG68Hr/VjFhW
 RSfEZcpERTljNN/kjg27bSMgYj9AjH/qTihBpo15zCxrnodoATNsQ8DT4i5o69i97Dn6
 uTGQ==
X-Gm-Message-State: AOJu0Yw0moH1nWbrWDtisD2MftOIWUVQJm369KVxLfTURx5hRJ7AnoMs
 HPvpTRORZmXM604eXcW27lv/nXP/UAlV4uQXzXvqoEBf9f78Yu36Y2NatU9qHatldL92RwoukJT
 owVUM8twpFg/MR3ziVxmfPTMyM8ZhmQuCGDpuqO2ZotsTX0ZpZI8Vgqcf
X-Gm-Gg: AfdE7cmOHaD0g0ewes2tbAkQ7JNHdM0VIpfXzKIYy0RY90UmZH+1F0iFYdL9ZRD2V4y
 5UxfRMkXHk8A50D70CHyF289GV6q0TJGWngV+Up4lugG4ZPqm6LLPBe2oCCXiq9d4di7n5z6FGA
 DGzsfvsjG4buyT/oP8Oa/blz3uwFi8Rq27ryFyXoqsTw3DxAJ3d+GsGmeNPS9QCmq4wiv7ftAsO
 dI7DmiCJ4Pc7OalY0FhXDIWRA1ECNYq7SqxCCTRriOOz34XgRJ6SxglSTgVAbHigZcRMNB0uG35
 tFqterAFBN58hJpMBLoapWzsSfeMnanGKxcp1yEmst+wLPvVLKwfwuMps0Yyo03HSn+wqp4g0gt
 TK/TI/++SD4CYJJv+e9v8QFQO
X-Received: by 2002:a05:600c:1f94:b0:493:e52f:6ee1 with SMTP id
 5b1f17b1804b1-4953bfffbc8mr99282955e9.0.1784234872850; 
 Thu, 16 Jul 2026 13:47:52 -0700 (PDT)
X-Received: by 2002:a05:600c:1f94:b0:493:e52f:6ee1 with SMTP id
 5b1f17b1804b1-4953bfffbc8mr99282825e9.0.1784234872366; 
 Thu, 16 Jul 2026 13:47:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635ac2esm26656602f8f.13.2026.07.16.13.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 13:47:51 -0700 (PDT)
Date: Thu, 16 Jul 2026 16:47:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] docs: outline some guidelines for security classification
Message-ID: <20260716164043-mutt-send-email-mst@kernel.org>
References: <20260707105927.2776822-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707105927.2776822-1-berrange@redhat.com>
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jul 07, 2026 at 11:59:27AM +0100, Daniel P. Berrangé wrote:
> +* **memory allocation bounds**. There are many ways in which a QEMU
> +  process can legitimately consume an amount of memory that is
> +  significantly larger than the assigned guest RAM. QEMU's worst
> +  case memory usage should be considered effectively unbounded.

This really is a bug we need to fix at some point.

> As
> +  such the QEMU deployment on the host should account for the
> +  possibility of large memory peaks and apply countermeasures to
> +  provide continuity of host operations.


Well it does not look like existing management stacks do much of this,
perhaps because when we say qemu memory is unbounded
the result is you can't limit memory using cgroups without risk of
qemu dying on oom.


> It is typical for the Linux
> +  OOM killer to reap the process triggering host memory overcommit
> +  in the case of exccessive usage, offering a degree of protection.

Yes but what degree?
At least on my box, it seems to kill firefox at about 50% of time (

> +  As such, bugs which can lead to excessive/unbounded memory allocations
> +  will usually not be classified as security flaws, but should be
> +  fixed as hardening bugs.
>

should we classify guest driven memory leaks and guest driven
memory spikes differently?


> +* **degraded guest behaviour**. There are a set of bugs which can
> +  lead guest hardware devices to misbehave. For example, a flawed
> +  virtual IOMMU operation may not offer the guest device isolation
> +  that would otherwise be expected. If a guest triggered exploit
> +  requires kernel privileges (or root account access), and leads
> +  to sub-optimal behaviour of the virtual device this is considered
> +  a self inflicted service degradation. These will **not** be
> +  treated as security flaws, at most hardening bugs. If triggernig
> +  the code path can be done by an unprivileged guest OS account,
> +  this may justify handling as a security bug.
> +
> +* **nested virtualization**. The scope for nested virtualization
> +  is to prevent a level 2 guest from breaking out into a level
> +  1 guest. As noted above, a number of scenarios exclude security
> +  handling for flaws only exploitable by the guest kernel / root
> +  account with affect the guest's own service/availability. In the
> +  context of nested virtualization with PCI device assignment, it
> +  may may be possible for a level 2 guest kernel to trigger flaws
> +  that affect the level 0 QEMU process. While these bugs should be
> +  fixed, they will not be triaged as security flaws at this time.
> +
> +* **low severity impact**. As a catch all rule, issues which
> +  are judged to have a "low" severity impact on the system will
> +  usually not justify handling as security bugs, nor assignment
> +  of CVEs. They will be fixed as routine bugs when time allows.
> +
>  Architecture
>  ------------
>  
> -- 
> 2.55.0


