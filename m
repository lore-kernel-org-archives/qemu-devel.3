Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC0EF4BB7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 19:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuxlU-0008Oy-Gg; Tue, 24 Feb 2026 14:08:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuxlS-0008Ol-Rk
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:08:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuxlR-0004Kz-2u
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771960088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dO7zBnW+cAdEFBEwg4nbMEzPjjSirhfoIZZkP25AF4Q=;
 b=im0D3Q4x6rsqHbxQP3WQ3LBPRvxBXigXjUv93SrAvgMt0M8nJ9pZo3X3yh9SswaJyCM69J
 XWRHEhIU/7wLjJOH4dhvj/5diy1ECy86mGo7mERmsuqV+v8+gRmVAeYPv+qiMWS0pJ8Qcy
 jvt8JOJW0SCkUcJ1AM6kSPT8se/HcXQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-NyM_fKahNj2WqRjDp5D0Yw-1; Tue, 24 Feb 2026 14:08:05 -0500
X-MC-Unique: NyM_fKahNj2WqRjDp5D0Yw-1
X-Mimecast-MFC-AGG-ID: NyM_fKahNj2WqRjDp5D0Yw_1771960084
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-483a24db6ecso64343435e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 11:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771960084; x=1772564884; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dO7zBnW+cAdEFBEwg4nbMEzPjjSirhfoIZZkP25AF4Q=;
 b=YMywXeYp9D9esgBTDs+wQLrJaTFwGkJcqThkaXJd/Yyytf+pTlUHqS1K2peuwtM8ag
 72Yqfqj9HI+RRwk+Fx7N8M7CM727sBgDJtEq8bKmXykmKKi6D8VW0B/5whXmrfgXgRtb
 B+nBzXuRZs2uJJR9G32UGDVcrAPyb/MEqdbQO5ukhaAjzHnzc3GLePS8lln1yzt3NdIt
 basn9s0IzK8ckT63Npo30TO6aRyBsERE8e1LWY5GdsZrkLVPtqK+si89Kk+929+RfSEn
 /XuRpS6QxT5HZYAEWAgv6JZoSuGK3QSFc3dhyR/i4yC7+7NTWKoEGRI0xxRNOOC2PJlt
 IP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771960084; x=1772564884;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dO7zBnW+cAdEFBEwg4nbMEzPjjSirhfoIZZkP25AF4Q=;
 b=oxHV1KxTaED6fLpDrru8ENJxs52QMAQq7y+ZOOfArzN4ubuGiEt/ZwfTncaB7cVSh5
 SFlpp4cRPL7prWJyimsldM/mHShwb5lNj/20r8zDwrL7y3vjaG0mej9lBMgp9UCXVZTo
 PnUGcMPJiQZ5xWqg7i28efsOQM90FsMwGGqQ69cZesTiK5DHVPtCUaSI4HDAtTBHzyZb
 gzOIyQA82QoSQqQ4dM8/2i1G7vaAok7WRxPo9plObhHeXysZhmdKAKZfBGGXADFG9gQU
 CJHC7pUKZd/gDevSueadTONp07wVSwhnoOGvRCLFNyDnQhMnxFjKSLAR5v4qEK8kMAS1
 7haQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHFO8JB2XLaB0KVm3zGDCYEqLF+/DZrJZWzfJdkB9col1tq+rAFjY73oqTUxgqH47d4UlurjvmCPCm@nongnu.org
X-Gm-Message-State: AOJu0Yz4rm18SCdMdYqlEZyn5fwrwTlQxo1qRR23aYjX/2t3BJ+HVc+x
 nB+rwMAa9oR4P+3UGykkb94Jgwvq6hHMqYYsCinErR8617zdUd3umPnYerQxhJekdl3LSjFLydm
 0HiL2TlreTQgLc9B0AG/8JuOuQb9lyK0vn1TwfuXadDJ6yESfDLdxtETG
X-Gm-Gg: AZuq6aLW8ucoyNcULto/oEB+JMmB5SN6IVgLqFT/p9DSCzqt+cVYwuBmqnxwg/F+4gg
 v9N/Tlq9P8tIIhGXEwcJMlIyt/a6hRvmcStUXJTyALMF8iSIC+XMKnudpKTVFISv5wQa+gInTub
 ZeXwwyOhoXxNXO2GwHoMCmCl/UBYQhBeqhDczxtlmKszCJq411LQvYiE8XbsmYIDRsvFuXvzY1y
 RRgkCuKFjygfpJfC/Sp656tDA7T/QF+ULWUt56LOmNFFOkwfRn72fVYAGMx5MWGVl8UWeG2P0eA
 2ZmtiKkq0ZsHw8D9VMZh0x9mUrM0Xpx08Q4mKY47ULkjXHDK2KDaHonID3CDLA4kmK3Vya9VXoP
 9JYw3WeLQ2+/byF1K2adxiSZ2Awa9hhBe3ml85+WS+Mf+NA==
X-Received: by 2002:a05:600c:6298:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-483a95fb23amr217986655e9.10.1771960083766; 
 Tue, 24 Feb 2026 11:08:03 -0800 (PST)
X-Received: by 2002:a05:600c:6298:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-483a95fb23amr217986045e9.10.1771960083227; 
 Tue, 24 Feb 2026 11:08:03 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd70e6c9sm13261865e9.8.2026.02.24.11.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 11:08:02 -0800 (PST)
Date: Tue, 24 Feb 2026 14:07:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, stefanha@redhat.com,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH 0/3] hw/virtio/virtio-access.h: remove target specific code
Message-ID: <20260224134436-mutt-send-email-mst@kernel.org>
References: <20260212234602.338131-1-pierrick.bouvier@linaro.org>
 <967c35ff-0630-4ca7-847e-04a918c93e7d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <967c35ff-0630-4ca7-847e-04a918c93e7d@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Feb 24, 2026 at 07:33:14PM +0100, Philippe Mathieu-Daudé wrote:
> Hi Pierrick,
> 
> On 13/2/26 00:45, Pierrick Bouvier wrote:
> > This series eliminates some target specifics in hw/virtio and replace them with
> > runtime functions where needed, to be able to link virtio code in single-binary.
> > After a first try on a series [0] doing this change and making all virtio files
> > common, Richard asked to refactor this part, thus this independent series.
> 
> > Pierrick Bouvier (3):
> >    hw/virtio: add virtio_vdev_is_{modern, legacy}
> >    hw/virtio: rename virtio_is_big_endian to virtio_vdev_is_big_endian
> >    hw/virtio: remove virtio_access_is_big_endian
> 
> Patch #2 has been merged as commit 6325407f67d.
> 
> Since we don't have feedback from the maintainers Cc'ed, I took
> the liberty to rebase your series, trying to address Zoltan's
> concerns on patch #1. 


So as I said, main use-case where we would worry about perf is
virtio storage. So it's mostly for storage guys to ack.
Did not get Stefan's feedback yet on whether he is happy.

I don't understand if we always want to build a single binary though.
If not we could address all perf worries by having both  generic
and target specific implementations by using linker tricks (weak symbols or
whatnot).


-- 
MST


