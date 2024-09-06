Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9520DCE7AFD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 09:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smViq-0000oL-M5; Fri, 06 Sep 2024 05:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1smVip-0000np-Hd
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 05:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1smVio-0008NZ-6V
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 05:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725616660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eTqqVe7zIbnGoQTlV5mLCL+KZjIwAcPxV+dUBkbDwO8=;
 b=ES5bVSvbLFNhi+/Fad84coB5WPruVidT08EMSgHyrocudWaQWsRD4x3OloJ9vro58pXabI
 Kfv0tOjylVSim+T1paue2Vndgqf7TxwvCSwRy6YreacOHaMVGKKDBYzsgd5JFcJN4166ZX
 pAqMQ7wP3q7B9DoN6uh47x0YsTngAYg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-0FJB8NhFOoKVu_2yq92ymA-1; Fri, 06 Sep 2024 05:57:38 -0400
X-MC-Unique: 0FJB8NhFOoKVu_2yq92ymA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42c80412dc1so14670445e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 02:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725616657; x=1726221457;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eTqqVe7zIbnGoQTlV5mLCL+KZjIwAcPxV+dUBkbDwO8=;
 b=VzyAYwnwFyhVFlnYhlOqQ76pH04duRbIfTTiGG8CYOXdb9c/yRj35DP4KJtrFG9/5F
 /1A2qMS+vAot+Y0TKu8LVyjlo2L3AXCzAn6/01bfy9NAnY2LA5pdZHYiiMuwFnWbSNsz
 z8OPVTvqbCoHiXfRB1FwoDJ3sZipUjKCHmLxurg8pHE7Ke0B6NfnHQ83M0NDdyt0smlT
 6fzJ0RmJTWWeTHGv/Z6reFrj8GGNLZ/CewQPfaWWQkD2zU/wauJlUz2AfAWYq8MYsJgT
 SqdqPejkkTSFMimuQvZ/eVDxLb5Ksn/rDTPCyPHITmV/z3RQ0apP0ncLiI0YaLNs0EeA
 PmUA==
X-Gm-Message-State: AOJu0YztPrLxsbOd+Be46wt823lpABuIzLUKGGQ9lIEas9t0xHr9OqMb
 S/8w0D5X+PkVgvl0uKcRW0jakS60rvazDrV0p/kCxCz9xHxI2d/0B0St/vKNSbNkYLnInc49NDR
 2RQVLPPmcGmJiTezftR3+ZnIO+ebi4Fo+HmBR+8aBYecX06EPv3YjR/pXONW/s2c=
X-Received: by 2002:a05:600c:4f82:b0:426:5b3a:96c with SMTP id
 5b1f17b1804b1-42c9f9d66famr13839775e9.28.1725616657295; 
 Fri, 06 Sep 2024 02:57:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoaS4bNmOCN92Os95z0wuzD7qfiP9VNnx+svGprP+CRLZcJe3c97BsKVzde4sygK9EW6Yj3A==
X-Received: by 2002:a05:600c:4f82:b0:426:5b3a:96c with SMTP id
 5b1f17b1804b1-42c9f9d66famr13839555e9.28.1725616656685; 
 Fri, 06 Sep 2024 02:57:36 -0700 (PDT)
Received: from redhat.com ([155.133.17.165]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42c9a5e82dasm49145045e9.0.2024.09.06.02.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 02:57:36 -0700 (PDT)
Date: Fri, 6 Sep 2024 05:57:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>
Subject: Re: [PATCH v2 0/7] Report fatal errors from failure with pre-opened
 eBPF RSS FDs
Message-ID: <20240906055711-mutt-send-email-mst@kernel.org>
References: <20240905181330.3657590-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240905181330.3657590-1-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Sep 05, 2024 at 07:13:23PM +0100, Daniel P. Berrangé wrote:
> The virtio-net code for eBPF RSS is still ignoring errors when
> failing to load the eBPF RSS program passed in by the mgmt app
> via pre-opened FDs.
> 
> This series re-factors the eBPF common code so that it actually
> reports using "Error" objects. Then it makes virtio-net treat
> a failure to load pre-opened FDs as a fatal problem. When doing
> speculative opening of eBPF FDs, QEMU merely prints a warning,
> and allows the software fallback to continue.
> 
> Trace event coverage is significantly expanded to make this all
> much more debuggable too.


looks good
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Jason's tree.

> Changed in v2:
> 
>  - Split 'ebpf_error' probe into multiple probes
> 
> Daniel P. Berrangé (7):
>   hw/net: fix typo s/epbf/ebpf/ in virtio-net
>   ebpf: drop redundant parameter checks in static methods
>   ebpf: improve error trace events
>   ebpf: add formal error reporting to all APIs
>   hw/net: report errors from failing to use eBPF RSS FDs
>   ebpf: improve trace event coverage to all key operations
>   hw/net: improve tracing of eBPF RSS setup
> 
>  ebpf/ebpf_rss.c     | 118 ++++++++++++++++++++++++++++----------------
>  ebpf/ebpf_rss.h     |  10 ++--
>  ebpf/trace-events   |   8 ++-
>  hw/net/trace-events |   8 +--
>  hw/net/virtio-net.c |  63 +++++++++++++++--------
>  5 files changed, 137 insertions(+), 70 deletions(-)
> 
> -- 
> 2.45.2


