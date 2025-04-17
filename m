Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0BFC369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 11:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5NYj-0004cG-3z; Thu, 17 Apr 2025 07:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u5NYg-0004bk-3W
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 07:37:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u5NYd-00035b-3i
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 07:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744889845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=omXWP0DV8EaQ2tVSFFZE6IzH9CWefJQxeK3N5sFdXiY=;
 b=NyZcz7SKGN8ottQtN+HBFudygm+1UegPOPEMoKyZbeSnqtqy/FAq2nIQ13HcGojujJ2ZOu
 HiDvo72SA/UIMEiFGFuawzx/8As/2LLfi+ZTb0c0pSTh+x+IkijYDe9iOprLL62l1CQgu/
 gT8TkWDoi2hdEW0SgBqSU2pUpT+9Low=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-rkXmdYoVMY-hGnulZBgpfA-1; Thu, 17 Apr 2025 07:37:23 -0400
X-MC-Unique: rkXmdYoVMY-hGnulZBgpfA-1
X-Mimecast-MFC-AGG-ID: rkXmdYoVMY-hGnulZBgpfA_1744889843
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3913b2d355fso268465f8f.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 04:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744889843; x=1745494643;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=omXWP0DV8EaQ2tVSFFZE6IzH9CWefJQxeK3N5sFdXiY=;
 b=DuXixsLR4H9qsqczSfF0qF5OD0wzvScSvjefprz/JVY3GqdZXmri0JP5PTmfueySeN
 GChs0eLUBWCeRtHCNjMxBV/UAMSaHr3UhEnAM9pmRlfaT1OTnAfINFS23jzvrjqtyXJL
 3FUUNtiZYtSEB1WxLbufYyTHFXBrhu/8t2NhKtqLOrwzrkhWtjaDQXUKsDBRqsHWbb9b
 Gi1NrInUYVCRvUqXOTmVpMBfbDvPu9qoXF8V4JNNVZTSmnjLiCihe1lUMiNTT+EOaRVQ
 UUtA68q2R3ryhWRnMmtz5rt3na68wxXYf1+V70GIFluboBfIO5I23Nrln0RMoBvGoCCL
 hgHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1ZVQ0Hl7jorvFOf49IKhm4+w4ea9SUhH12F671IS6iqhPsQmOP2S4V5OVMErAofOq+lhB1cmCx39q@nongnu.org
X-Gm-Message-State: AOJu0Yzem9yWbiQ7IPtR03jTBASyfYwSN/zUudC/CXiIaeUkM9j4oCbw
 FfscMSPr/6LMYEwYUzcrGFiDoqT+dOCz2tTLhSx/TvxoijT1SZKrNjGUMJR1AI/Iun9BwDZmgcm
 q4IwvYspv4I6N3UFT1NajQFe+4tiaV2GVh3Yaxqk8d14dgWt0UJ+0
X-Gm-Gg: ASbGncvYJl/RYWcC8Rtfj5xa47W2ucpgQZJq8D3KExqM92+VEg7sVN2iL7tVkxRhvgr
 r1A3twjqZdajJ0K9QPxo/ewp8FP/aOwIOlHLPyhI+e+F9ZwaaLDkMXOEJDXVx/YbA8vM2cvC9AT
 kfOBbL65+QmnmEKgSL0QdPhIvD9ntJq0RSczCeCaj+INeS0B8cMO/chNa71JyWDo30tqVp0BvTc
 FHaBitfHmWSMi9KKxIzyDFYuhD00EfJPWTUuXAjlmGLSeos8Yd0JeCzbiobBQOZNMbQ0tUsrV8q
 SyYnMg==
X-Received: by 2002:a05:6000:1acb:b0:391:a74:d7dc with SMTP id
 ffacd0b85a97d-39ee5bad723mr4490488f8f.50.1744889842738; 
 Thu, 17 Apr 2025 04:37:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmWt+56eTzjT0pAD+JsIgH4fY69YphLpS8MraQQKYLQrXbhpppRN6OOMqgAPXPkxEZJk5KWA==
X-Received: by 2002:a05:6000:1acb:b0:391:a74:d7dc with SMTP id
 ffacd0b85a97d-39ee5bad723mr4490469f8f.50.1744889842417; 
 Thu, 17 Apr 2025 04:37:22 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae9807b7sm19982826f8f.60.2025.04.17.04.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 04:37:21 -0700 (PDT)
Date: Thu, 17 Apr 2025 07:37:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 0/3] virtio-gpu: fix blob unmapping sequence
Message-ID: <20250417073708-mutt-send-email-mst@kernel.org>
References: <20250410122643.1747913-1-manos.pitsidianakis@linaro.org>
 <87v7r5clft.fsf@draig.linaro.org>
 <20250416145701-mutt-send-email-mst@kernel.org>
 <87jz7jcj4n.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jz7jcj4n.fsf@draig.linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Apr 17, 2025 at 09:00:40AM +0100, Alex Bennée wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Tue, Apr 15, 2025 at 07:46:14PM +0100, Alex Bennée wrote:
> >> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
> >> 
> >> > A hang was observed when running a small kernel that exercised VIRTIO 
> >> > GPU under TCG. This is an edge-case and won't happen under typical 
> >> > conditions.
> >> 
> >> Should I (or MST?) pull these into a tree for 10.0 or should they be
> >> grabbed for when the tree opens with a Cc qemu-stable?
> >
> >
> > Let's just agree who takes them, then it's up to that maintainer.
> > You wanna merge them?
> 
> I'm happy to take them, I'll cc stable when the tree opens up again.


Acked-by: Michael S. Tsirkin <mst@redhat.com>


> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro


