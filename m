Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6273C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 15:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl8QX-0006Ub-Li; Thu, 20 Feb 2025 10:25:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tl8QV-0006UP-HR
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:25:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tl8QT-0008Jz-FE
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740065120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qic92RfmdWKf+R733+heCNoRi6cL06RDv4EjChWDSHQ=;
 b=Lua7GxVAnRJCE5Cviyz0GcrJhrp8rpm1QTJ5wFqR33c7xfBp4h20GisI0lxRMipza9hqJS
 um4/UKUUM3A53pTwyv0+IytEU4P3kG3y3rgvydev5ybwtdW7Mly284r7Dih/0GKmiV/wgk
 yZaKMIvMnfBsB3y8UOuv5KvlCjYyjjM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-sk8vztEVPSSFA3sX-0WLqA-1; Thu, 20 Feb 2025 10:25:18 -0500
X-MC-Unique: sk8vztEVPSSFA3sX-0WLqA-1
X-Mimecast-MFC-AGG-ID: sk8vztEVPSSFA3sX-0WLqA_1740065117
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-abbae81829fso145595766b.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 07:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740065117; x=1740669917;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qic92RfmdWKf+R733+heCNoRi6cL06RDv4EjChWDSHQ=;
 b=jt6F/YzTcjR2jfRZyJ1eeB7QenUSzemumuUB/qbKVdZgnSxMvtgUOU1esxfx11thIR
 P2OFTMvCudXzHeKYWK+MOkdSbauVUMtxe9iHlBBUycAD+xlaS6Gct8nuz1pnB8MClUbY
 Fi3URaTdiaunJYmfB3aonZlquZEYQDZkSO1iZ5q598biXrR2qI0k+aKp769988v4xHdx
 Jg/JHRrQMmJ8gZjHCXimnoe+uofKrPlppJUPLrgDFzvzqmqZCNmNacOsLz2EB31tSE6u
 4Iqty5r2SLKsWd2y+m3cnMvJTjOCHbzLvMD24FZqUAO1TQuj87JuejmamEe/j/gNcCZe
 AsNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWmVNwchG7jUu5fpOT4DNpuJni8o97AQIRWaAVFSdNGN00HiMU8GdO/H0foDMiADlV/MYkiQ02MhgZ@nongnu.org
X-Gm-Message-State: AOJu0Yyac4HgdS3wCxEOJ6XsyGtkLVeHqZ3Uc0qWF0z537Yu+bsTZrn1
 u5TupyHTQqjaCyK4EwLfZyMcI8jNCSCPT587kqi6hTQBzqrJ8V4xjmNi9rXXIMmRQyxznnE9KZc
 Cc9YDl6Vcx6WclV8pq9iqYXLljExasHZq7UbCRE0nTbngK0NRWA2M
X-Gm-Gg: ASbGncucIkB0P+gjvcxyLhyznEWXX6ZMNmL7u7G7bD744o3T+RJSS8wCzx7YVWc3gZj
 lTLPiG4lsQ0r0s5fP6j1RgVs3PiVdPMpH079/z5Ad4mal9WKk0Es4Yvs34DHho3IFovo4lQOE6I
 eSolhA6vtM7uizuPwqK/1cXufs7RjqbmGr7YtyK9jZL8IUaKrF5Mg3c5TY59RfO8dvq15ngLwVt
 dC29cE1QghClmpnXtz+cfV+IYOMvMNx0pTSxvP1fCipQa2Zj9+7CDO3DSVBBLsQBp6q8Q==
X-Received: by 2002:a17:907:7f27:b0:aa6:9198:75a2 with SMTP id
 a640c23a62f3a-abb7115bcb8mr2195509566b.44.1740065117296; 
 Thu, 20 Feb 2025 07:25:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZC+h9fHvNq85OzD7U097/YXK6BLMYdhts2zqfDZHlEsTIxqaxzRbU1lFUx2AG3QElm28JCg==
X-Received: by 2002:a17:907:7f27:b0:aa6:9198:75a2 with SMTP id
 a640c23a62f3a-abb7115bcb8mr2195507166b.44.1740065116970; 
 Thu, 20 Feb 2025 07:25:16 -0800 (PST)
Received: from redhat.com ([2.55.163.174]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abbad297430sm638634366b.5.2025.02.20.07.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 07:25:16 -0800 (PST)
Date: Thu, 20 Feb 2025 10:25:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Jason Wang <jasowang@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Message-ID: <20250220102429-mutt-send-email-mst@kernel.org>
References: <20250120173339.865681-1-eric.auger@redhat.com>
 <CACGkMEu4oMa8Sf9QXtszeoSMj_67Csr0s7kHdYfbNnJWibu2dA@mail.gmail.com>
 <5a55011a-af8f-483a-99fa-5cb2cdf3841f@redhat.com>
 <CACGkMEv6ec3JLZg6ZedSHdNS5_McX7_xoV4d2MG05x_Y5t=uEA@mail.gmail.com>
 <678babb6-f64a-4db5-ad60-494214a4e673@redhat.com>
 <CACGkMEvyYT7-PTOwO-Jg9a8AHA0AJHoV2BY2RBrJTGKEFYL6QA@mail.gmail.com>
 <25b5bb73-abd8-4008-905d-6c2e9e1330e2@redhat.com>
 <SJ0PR11MB6744EBC0BB7C8CD5F33D0A4E92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <1c073acc-095e-45f0-977c-e22557f180f2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c073acc-095e-45f0-977c-e22557f180f2@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Jan 31, 2025 at 10:55:26AM +0100, Eric Auger wrote:
> 
> I tested [PATCH] virtio: Remove virtio devices on device_shutdown()
> https://lore.kernel.org/all/20240808075141.3433253-1-kirill.shutemov@linux.intel.com/
> 
> and it fixes my issue
> 
> Eric


To make sure, we are dropping this in favor of the guest fix (which
I intent to merge shortly), correct?


