Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDE0C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 22:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkW7d-0005Iw-Ct; Tue, 18 Feb 2025 17:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tkW7Z-0005Ig-I3
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 17:31:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tkW7X-0002nP-Ql
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 17:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739917873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ReuhTalE1kWgzBc4wxzrNTInH7tLQy39UokfOV7tNTg=;
 b=DKwdsRxRxcLpHg3D6dT1KMxYw93wmF40e1HR9+UzvWdCRMfBCa7WJbiExbEQTgjXfjvWlp
 cyuBnfKY2BSbjWnu0IV8Jxj92p4eyqV3zQnxe6GSpXhwR4e+7T8hPxG3iDGvhdKrNyG45W
 /iKiEV7dA+0z72bxmFaAJ1bY13wmFYU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-ybz8n1-9NBCy4Zb1KZD78A-1; Tue, 18 Feb 2025 17:31:10 -0500
X-MC-Unique: ybz8n1-9NBCy4Zb1KZD78A-1
X-Mimecast-MFC-AGG-ID: ybz8n1-9NBCy4Zb1KZD78A_1739917870
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-47206aad81bso13226981cf.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 14:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739917870; x=1740522670;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ReuhTalE1kWgzBc4wxzrNTInH7tLQy39UokfOV7tNTg=;
 b=DPq18fLx79b9K0U3NBnUa31Fa49D5glfLiC8oH+ihzFE8aUqzefRBpnSYrRLT7iFs5
 8kF64WuYIQSc18PiO8+7+AmPwoV6HU9vyzgqLM/X93Wq2eOy/V2FVoOJT/4ICybCfTN4
 hyVniIo8EyjONf+gxI+Y3FWoxSsJAwsD9T4ABXRpNv6enRw5Gg5hfYZBx7AtO4HqvMxV
 KY6TNEpjzONT7vYNnDumQpzbwySRFCzgV7XrLFo7WG4RtGfgTBG6lveBI5NT4urIN9NO
 IvB0B5MATCq/W4DqCppr//ce7G7zO8/eu5byq8NKILKQOspyd90FUZbWLaDdMP3hN71H
 bI+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVlN5MAvDgBQy/igK4u59VMRVjKXm1KO3Z3YCZSjptfVzPeHPnIzX6Wq90DqZGngtyS7y2wMHM80DG@nongnu.org
X-Gm-Message-State: AOJu0YxSYu+7MWw4VyixC58NdiyQRVIwMPukhX6UFN9dsAiWSFaxA1kG
 U1+onhGasUnUAs2n13/J+u4NIMVeo1KrniosqxOcH3U1iB1LPR12xKnBe8P0+7yqpQm1YO2AMzF
 0CvdDSZmin3j4ZT2aR5W7Zz1K/vioKRIRpwlcHVyrcPQcoBGhrYLK
X-Gm-Gg: ASbGncu16iC8M2b5WVAwQc6UyjdpS34p1HZFffmDa+/AV+y5/BXE52hFLT4YYTgJM0+
 iNJlY2lgoPfazA7KeVauZj+6b6olTeUSMHIbsvx7VkiheslZBkf8PluA4hjgUpVNe3VGc6jGP+2
 Ml6Srlw9CGEVM9PeDmjSGPdUpW8pznOWvJdMjEZzB+35gq3UAJ5Qs9DDlLA//AjCljYHAWHjDNr
 5QUTsb3ug3CmiB/pxY9/KbCAAhM2RJonnYwClQWfbE+Su8JcNnPEnRR4Rw=
X-Received: by 2002:ac8:5e0b:0:b0:471:89f6:838d with SMTP id
 d75a77b69052e-471dbcc0ea4mr249063241cf.2.1739917870225; 
 Tue, 18 Feb 2025 14:31:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERayIta+pjM26JHg5KM4EygLRLgNeffmUstLl7z0yuabvHxGORBQ6TlzA7nbm+5FwcGjg1hg==
X-Received: by 2002:ac8:5e0b:0:b0:471:89f6:838d with SMTP id
 d75a77b69052e-471dbcc0ea4mr249062781cf.2.1739917869934; 
 Tue, 18 Feb 2025 14:31:09 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47202b63216sm10877761cf.24.2025.02.18.14.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 14:31:08 -0800 (PST)
Date: Tue, 18 Feb 2025 17:31:05 -0500
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com,
 imammedo@redhat.com, alex.williamson@redhat.com, clg@redhat.com,
 philmd@linaro.org, zhenzhong.duan@intel.com, ddutile@redhat.com
Subject: Re: [PATCH v3 0/5] Fix vIOMMU reset order
Message-ID: <Z7UKKQ1objwqqguG@x1.local>
References: <20250218182737.76722-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218182737.76722-1-eric.auger@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 18, 2025 at 07:25:30PM +0100, Eric Auger wrote:
> With current reset scheme, DMA capable devices are reset after
> the vIOMMU which translate them. This holds for the different
> IOMMUs and various DMA capable devices such as virtio devices
> and VFIO ones. With virtio devices, spurious traces can be
> observed at qemu level such as "virtio: zero sized buffers are
> not allowed" while for VFIO devices, translation faults can be
> observed at host level.
> 
> Virtio devices use 3 phase reset and virtio-pci devices are reset
> in the 'hold' phase. VFIO device reset are registered using
> qemu_register_reset() and as a consequence they are also reset
> on 'hold' phase.
> 
> Note that the tree of QOM devices resets depth-first but it does
> so while enforcing the 3 phases. First the tree is traversed doing
> the 'enter' phase, then the 'hold' phase and eventually the 'exit'
> phase.
> 
> However the QOM hierarchy is not built so that vIOMMUs get reset
> after the DMA capable devices (IOMMUs are using either legacy reset
> scheme or hold phase). Changing the QOM hierarchy does not sound
> trivial while forcing the vIOMMUs to be reset on 'exit' phase
> sounds reasonable and much simpler. Obviously this relies on the
> assumption that all DMA capable devices quiesce their DMA before
> (ie. during 'enter' or hold' phase).
> 
> This was tested with qmp system_reset and virsh reset.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


